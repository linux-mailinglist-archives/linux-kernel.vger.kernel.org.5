Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB777FEC05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjK3Jj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjK3JjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:39:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10255D40;
        Thu, 30 Nov 2023 01:39:31 -0800 (PST)
Date:   Thu, 30 Nov 2023 09:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701337169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncQYNJ4GBwdM1wndJD2ZUZuSLFmYqkvecrHz/qccbIw=;
        b=BCaNQ5C58z8iTkTvRYakAnu/LZz0SLOCLDpBI+oKhATyGp2oWyQmRI/SI7JtNlrzmUWYkE
        Zrh8NvKRnSjYXXJKwrcqT9xPzK+HiuMHTp4KqLprZlyMzul7XWDX+m8ndudboaYHB774CP
        403Zap3yuDiHXtG0PG6ycHTlAx0tcOPXlj35kKkLhfPABQd5K3+tH/IrIH5eqtjDU6NkGf
        0Kj1Kz8JsdWfVcjs6RDcl94mpbNvT9pCRoMhpf/bJpP59CRVj1B6APjWon7W8pC1BjBIli
        4U0/l+YoK5w44E0SgRWv7t7OCQCHLDvT3qjpqrMtS0RDjIP8Pj+qovCEP2ewJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701337169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncQYNJ4GBwdM1wndJD2ZUZuSLFmYqkvecrHz/qccbIw=;
        b=lw7uxh9lW6lm5i0CJcL4tB2ETcJ6olfFsuWg+p9gyyr2wUwLk3Y9gSUfGRtHzzr40Gc7YH
        e8O1M0yenSQQ32Cw==
From:   "tip-bot2 for Ashwin Dayanand Kamat" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Fix kernel crash due to late update to
 read-only ghcb_version
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Bo Gan <bo.gan@broadcom.com>,
        Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
References: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Message-ID: <170133716855.398.4806769836355142687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     27d25348d42161837be08fc63b04a2559d2e781c
Gitweb:        https://git.kernel.org/tip/27d25348d42161837be08fc63b04a2559d2e781c
Author:        Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
AuthorDate:    Wed, 29 Nov 2023 16:10:29 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 10:23:12 +01:00

x86/sev: Fix kernel crash due to late update to read-only ghcb_version

A write-access violation page fault kernel crash was observed while running
cpuhotplug LTP testcases on SEV-ES enabled systems. The crash was
observed during hotplug, after the CPU was offlined and the process
was migrated to different CPU. setup_ghcb() is called again which
tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
is a read_only variable which is initialised during booting.

Trying to write it results in a pagefault:

  BUG: unable to handle page fault for address: ffffffffba556e70
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  [ ...]
  Call Trace:
   <TASK>
   ? __die_body.cold+0x1a/0x1f
   ? __die+0x2a/0x35
   ? page_fault_oops+0x10c/0x270
   ? setup_ghcb+0x71/0x100
   ? __x86_return_thunk+0x5/0x6
   ? search_exception_tables+0x60/0x70
   ? __x86_return_thunk+0x5/0x6
   ? fixup_exception+0x27/0x320
   ? kernelmode_fixup_or_oops+0xa2/0x120
   ? __bad_area_nosemaphore+0x16a/0x1b0
   ? kernel_exc_vmm_communication+0x60/0xb0
   ? bad_area_nosemaphore+0x16/0x20
   ? do_kern_addr_fault+0x7a/0x90
   ? exc_page_fault+0xbd/0x160
   ? asm_exc_page_fault+0x27/0x30
   ? setup_ghcb+0x71/0x100
   ? setup_ghcb+0xe/0x100
   cpu_init_exception_handling+0x1b9/0x1f0

The fix is to call sev_es_negotiate_protocol() only in the BSP boot phase,
and it only needs to be done once in any case.

[ mingo: Refined the changelog. ]

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/1701254429-18250-1-git-send-email-kashwindayan@vmware.com
---
 arch/x86/kernel/sev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70472ee..c672858 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1234,10 +1234,6 @@ void setup_ghcb(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
-	/* First make sure the hypervisor talks a supported protocol. */
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
 	/*
 	 * Check whether the runtime #VC exception handler is active. It uses
 	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
@@ -1255,6 +1251,13 @@ void setup_ghcb(void)
 	}
 
 	/*
+	 * Make sure the hypervisor talks a supported protocol.
+	 * This gets called only in the BSP boot phase.
+	 */
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
 	 */
