Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4E7E482F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjKGSXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjKGSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:23:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CEB0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699381418; x=1730917418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TpLIlXS/sIMSaQ8KlynS9sTmn/BUEjG+x+2Osl6Bl+o=;
  b=I4dJPznQR68olDVPuvYYqPx+YEa8shfAz/Yd54MjxrHwZgYk3pNK7evy
   w0jbBnGjhLnHx0h0s5ZFcAlkitIrDOAiWsagW+mkXXlsCLXpGoO53THo+
   c5uBfT/Vy1Ns9M0oTRKsGQQblpOsjs2OlG0OAJeC0zNLbrGibXfM8Nbxq
   9mf9UFHv7F6poGQD3qfKUXFJCnQfnb6p1180nseCVYibyldv9W/ihw62a
   HcqVVNtlKnih8Fcy2wSmjUCfiiD6lv7jluKnWabrKSNN3T39fjEAMb5Dw
   Oo1DhD/c6Ik+12CSTzdDPujN7X2kd3CeS6L7RQkD0l7CyumyqGelwrz3D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2595626"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2595626"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="766396405"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="766396405"
Received: from pguttal-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.30.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:23:36 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, debug@rivosinc.com, rick.p.edgecombe@intel.com,
        pengfei.xu@intel.com
Subject: [PATCH] x86/shstk: Change SSP after user accesses
Date:   Tue,  7 Nov 2023 10:22:51 -0800
Message-Id: <20231107182251.91276-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a signal is being delivered, the kernel needs to make accesses to
userspace. These accesses could encounter an access error, in which case
the signal delivery itself will trigger a segfault. Usually this would
result in the kernel killing the process. But in the case of a SEGV signal
handler being configured, the failure of the first signal delivery will
result in *another* signal getting delivered. The second signal may
succeed if another thread has resolved the issue that triggered the
segfault (i.e. a well timed mprotect()/mmap()), or the second signal is
being delivered to another stack (i.e. an alt stack).

On x86, in the non-shadow stack case, all the accesses to userspace are
done before changes to the registers (in pt_regs). The operation is
aborted when an access error occurs, so although there may be writes done
for the first signal, control flow changes for the signal (regs->ip,
regs->sp, etc) are not committed until all the accesses have already
completed successfully. This means that the second signal will be
delivered as if it happened at the time of the first signal. It will
effectively replace the first aborted signal, overwriting the half-written
frame of the aborted signal. So on sigreturn from the second signal,
control flow will resume happily from the point of control flow where the
original signal was delivered.

The problem is, when shadow stack is active, the shadow stack SSP
register/MSR is updated *before* some of the userspace accesses. This
means if the earlier accesses succeed and the later ones fail, the second
signal will not be delivered at the same spot on the shadow stack as the
first one. So on sigreturn from the second signal, the SSP will be
pointing to the wrong location on the shadow stack (off by a frame).

Pengfei privately reported that while using a shadow stack enabled glibc,
the “signal06” test in the LTP test-suite hung. It turns out it is
testing the above described double signal scenario. When this test was
compiled with shadow stack, the first signal pushed a shadow stack
sigframe, then the second pushed another. When the second signal was
handled, the SSP was at the first shadow stack signal frame instead of
the original location. The test then got stuck as the #CP from the twice
incremented SSP was incorrect and generated segfaults in a loop.

Fix this by adjusting the SSP register only after any userspace accesses,
such that there can be no failures after the SSP is adjusted. Do this by
moving the shadow stack sigframe push logic to happen after all other
userspace accesses.

Note, sigreturn (as supposed to the signal delivery dealt with in this
patch) has ordering behavior that could lead to similar failures. The
ordering issues there extend beyond shadow stack to include the alt stack
restoration. Fixing that would require cross-arch changes, and the
ordering today does not cause any known test or apps breakages. So leave
it as is, for now.

Cc: stable@vger.kernel.org
Fixes: 05e36022c054 ("x86/shstk: Handle signals for shadow stack")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index cacf2ede6217..23d8aaf8d9fd 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -175,9 +175,6 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
-	if (setup_signal_shadow_stack(ksig))
-		return -EFAULT;
-
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -198,6 +195,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 			return -EFAULT;
 	}
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	/* Set up registers for signal handler */
 	regs->di = ksig->sig;
 	/* In case the signal handler was declared without prototypes */
-- 
2.34.1

