Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E9803E10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjLDTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjLDTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:07:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F6D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701716839; x=1733252839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+ksUC7k7dsrCMckhfycqnTyhivxgCIkSpxqzHRlpIh0=;
  b=DtW7nCrdMTfjs4vPiL3G4Mu2cXxN38j8GFWGEe3t467BRZ5mOMtrHI3O
   T6XXkod5tiePSSsc82LD2aKJfe/kfsz7bHj62qGleg3m+9iPI4QMGwKA7
   kvxFeEIrbgWlIcN6S6bppFMgKz+X+T51SIsf0O3Fjwphr+L0bwcLhCeqQ
   URvyQRVRVRz6uOcXUZz0QN4ViKwdsa6c33Ys3CANkHoA3q8HPQL2zE+Tc
   FDWMUq8VSFpbSiAFApLb725tASaYy+JuiO0x+uLbAyx68CgIBus3T/eeA
   POZk7GEVoZ5JGR4NlS0E3lFwLKT9lAkWYeeqW9frC0mDgd85gSO1FfBUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="678865"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="678865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:07:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841164643"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="841164643"
Received: from nstrutt-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.45.160])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:07:17 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com, christina.schimpe@intel.com
Subject: [PATCH] x86: Check if shadow stack is active for ssp_get()
Date:   Mon,  4 Dec 2023 11:07:09 -0800
Message-Id: <20231204190709.3907254-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shadow stack regset ->set() handler (ssp_set()) checks the regset
->active() handler (ssp_active()) to verify that shadow stack is active.
When shadow stack is active, the XFEATURE_CET_USER xfeature will not be in
the init state because there is at least one bit set (SHSTK_EN). So
ssp_set() should be able to safely operate on the xfeature in the xsave
buffer after checking ssp_active(). If it finds it is in the init state
anyway, it warns because an unexpected situation has been encountered.

But ssp_get(), the regset_get() handler, doesn't check ssp_active(). This
was under the assumption that all the callers check the ->active()
handler. It is indeed normally the case, but Christina Schimpe reports
that and a warning like the following can be generated:

WARNING: CPU: 5 PID: 1773 at arch/x86/kernel/fpu/regset.c:198 ssp_get+0x89/0xa0
[...]
Call Trace:
<TASK>
? show_regs+0x6e/0x80
? ssp_get+0x89/0xa0
? __warn+0x91/0x150
? ssp_get+0x89/0xa0
? report_bug+0x19d/0x1b0
? handle_bug+0x46/0x80
? exc_invalid_op+0x1d/0x80
? asm_exc_invalid_op+0x1f/0x30
? __pfx_ssp_get+0x10/0x10
? ssp_get+0x89/0xa0
? ssp_get+0x52/0xa0
__regset_get+0xad/0xf0
copy_regset_to_user+0x52/0xc0
ptrace_regset+0x119/0x140
ptrace_request+0x13c/0x850
? wait_task_inactive+0x142/0x1d0
? do_syscall_64+0x6d/0x90
arch_ptrace+0x102/0x300
[...]

It turns out the PTRACE_GETREGSET path does not check ssp_active(). The
issue could be fixed by just removing the warning, but it would be nicer
to rely a check of ssp_active() which is much easier to reason about than
xsave init state logic. So add a ssp_active() check in ssp_get() like
there already is in ssp_set().

Fixes: 2fab02b25ae7 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Christina Schimpe <christina.schimpe@intel.com>
Tested-by: Christina Schimpe <christina.schimpe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/fpu/regset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2a21bd..887b0b8e21e3 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -190,7 +190,8 @@ int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	struct fpu *fpu = &target->thread.fpu;
 	struct cet_user_state *cetregs;
 
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
 		return -ENODEV;
 
 	sync_fpstate(fpu);
-- 
2.34.1

