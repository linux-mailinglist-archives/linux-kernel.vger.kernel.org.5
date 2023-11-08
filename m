Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F77E5CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:11:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B4171B;
        Wed,  8 Nov 2023 10:11:45 -0800 (PST)
Date:   Wed, 08 Nov 2023 18:11:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699467102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qTZCwBL3ePgB/9fon2+LOAb4X4uCob5TehfJ6KGUEaw=;
        b=flO7GdrkVu7ni32ohs7YdWtZfoYXzx6BtOwtiHLxIQDgDrQKijvUg6jboC6F2zAd1Itwgl
        s5u6alisiibmdb+MHBlp5bSSYDglZnjFc+GYVFGkW+7318SdkV2X4WbTi4ttS4sLbCH772
        vUzCc08rIpsjKqkuWY7flvE7zkjUjhrQjsz4V2k5TbDm/cQzjXeLW/0By6Jru9rPed5hYu
        Cm0z1q5qJwopB2CNxIOfP7qNmbAvmp5vSMPgVMa3Op5s2TKFWkJGx5GSZAYGHrAqsbMNuo
        YLiejfPrSsOY3VtSC5RmvoaQJdKwuKFn+srcqzAuBSAhQWEkvfWWL4T/6Zgecw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699467102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qTZCwBL3ePgB/9fon2+LOAb4X4uCob5TehfJ6KGUEaw=;
        b=EnmaNQwfQKp7CIYAMpq2JPbYtsAz5r9RrQ3QnZuyKNxCD5GkDzYy402K9RwBpnR2q23Dgp
        IxSenka/aPkap2BA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/shstk: Delay signal entry SSP write until after
 user accesses
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169946710196.3135.13826556225049872785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31255e072b2e91f97645d792d25b2db744186dd1
Gitweb:        https://git.kernel.org/tip/31255e072b2e91f97645d792d25b2db7441=
86dd1
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Tue, 07 Nov 2023 10:22:51 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Nov 2023 08:55:37 -08:00

x86/shstk: Delay signal entry SSP write until after user accesses

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
the =E2=80=9Csignal06=E2=80=9D test in the LTP test-suite hung. It turns out =
it is
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

Note, sigreturn (as opposed to the signal delivery dealt with in this
patch) has ordering behavior that could lead to similar failures. The
ordering issues there extend beyond shadow stack to include the alt stack
restoration. Fixing that would require cross-arch changes, and the
ordering today does not cause any known test or apps breakages. So leave
it as is, for now.

[ dhansen: minor changelog/subject tweak ]

Fixes: 05e36022c054 ("x86/shstk: Handle signals for shadow stack")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20231107182251.91276-1-rick.p.edgecombe%40i=
ntel.com
Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/=
syscalls/signal/signal06.c
---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index cacf2ed..23d8aaf 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -175,9 +175,6 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_re=
gs *regs)
 	frame =3D get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags =3D frame_uc_flags(regs);
=20
-	if (setup_signal_shadow_stack(ksig))
-		return -EFAULT;
-
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
=20
@@ -198,6 +195,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_re=
gs *regs)
 			return -EFAULT;
 	}
=20
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	/* Set up registers for signal handler */
 	regs->di =3D ksig->sig;
 	/* In case the signal handler was declared without prototypes */
