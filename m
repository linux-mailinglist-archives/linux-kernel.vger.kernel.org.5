Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07B805254
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442186AbjLELWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442166AbjLELVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:21:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCE129;
        Tue,  5 Dec 2023 03:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701775294; x=1733311294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNry4Fzy15Ftidcudz/wq0ei+oIMjP7Ry/4o5mJqLAU=;
  b=T/OK1cUyrWa6Hvq2uNLy0GxZgCSaHa4oOwNCFT9CdaSnQ6zoTbwFASH9
   lxELjIt/MVUOM5MhVBPx/wTlZ5re76MjF0fBCTlf7LgavKQPuUQjqaAlW
   gMlXJ0690Tl3MZeLI3ntJ3ZZZhWoaOkb6aoPmjXahC209fW+ed+M0toEk
   fFbjG2+EKQh2sFgxnNTYn/d+GmXceHH2PGPRhy8PsJKm8hPTZbcmenHVk
   v8rphlWeKsv13ih3J2eurKveE+uB4hQ0KujKdQWQt1YapmCkYQoZUQvTO
   nBxFN39cVdWh3J/cudKr2kr4lMsUUaKR6CCY6iw0YAn+DKsjI+1hZqhed
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="942645"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="942645"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018192998"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018192998"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 03:21:24 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, andrew.cooper3@citrix.com,
        jiangshanlai@gmail.com, nik.borisov@suse.com, shan.kang@intel.com
Subject: [PATCH v13 28/35] x86/fred: Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled
Date:   Tue,  5 Dec 2023 02:50:17 -0800
Message-ID: <20231205105030.8698-29-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205105030.8698-1-xin3.li@intel.com>
References: <20231205105030.8698-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled,
otherwise the existing IDT code is chosen.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/entry_64.S      | 6 ++++++
 arch/x86/entry/entry_64_fred.S | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5a1660701623..87d817296dcb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -247,7 +247,13 @@ SYM_CODE_START(ret_from_fork_asm)
 	 * and unwind should work normally.
 	 */
 	UNWIND_HINT_REGS
+
+#ifdef CONFIG_X86_FRED
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp asm_fred_exit_user", X86_FEATURE_FRED
+#else
 	jmp	swapgs_restore_regs_and_return_to_usermode
+#endif
 SYM_CODE_END(ret_from_fork_asm)
 .popsection
 
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 37a1dd5e8ace..5781c3411b44 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -32,6 +32,7 @@
 SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
 	FRED_ENTER
 	call	fred_entry_from_user
+SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
 	FRED_EXIT
 	ERETU
 SYM_CODE_END(asm_fred_entrypoint_user)
-- 
2.43.0

