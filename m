Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406F80F989
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377608AbjLLVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377563AbjLLVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:37:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E4AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:37:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D06C433C9;
        Tue, 12 Dec 2023 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417027;
        bh=YG9YY9iEszGGckGfEsHdcd7GRr37WZ5+YKaXd/4SyBA=;
        h=From:To:Cc:Subject:Date:From;
        b=oBWPCFgld2/BjYDNaG8jaEnt7Cx9tpnd7KcYCtbnA5rD52Cy82NwBE9XJAGFsqCM3
         U6utTvXQcKjl6EnuRdn5XM+B2DZOrua3ymFoTqGqxoCjxOrqurFzf5It6UbOfaXIUZ
         KkNa23uvx7WyLkk7RRt02tVKDrnAW7xXwbcQ48gvRps2teHFuNi8A3f9D0mjUvm6Je
         0S2d4DZjkdycE2IpzxEdbrn5vVRnZlG14rsmR30Qgp7JjcyARWj3zyuoiVvnG8FYGA
         oEs1GshsyyENWFrnzZO+IC6VpHwflKZVK9pwKzW66VYsqqrAQkujmqJA3zZ4wjts5m
         yGrB/+QUyHozQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Yuan Yao <yuan.yao@intel.com>, Kai Huang <kai.huang@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Date:   Tue, 12 Dec 2023 22:36:50 +0100
Message-Id: <20231212213701.4174806-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When TDX is enabled but MCE is not, the tdx_dump_mce_info() function
fails to link:

ld.lld: error: undefined symbol: mce_is_memory_error
ld.lld: error: undefined symbol: mce_usable_address
>>> referenced by usercopy_64.c
>>>               vmlinux.o:(tdx_dump_mce_info)

In this configuration, there is also no caller for the function, so
avoid the problem by enclosing it in an #ifdef block.

Fixes: 45f31973967d ("x86/mce: Differentiate real hardware #MCs from TDX erratum ones")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/virt/vmx/tdx/tdx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 13df68ef40b5..3af7a7e2d8d0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1245,6 +1245,7 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_GPL(tdx_enable);
 
+#ifdef CONFIG_X86_MCE
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
@@ -1344,6 +1345,7 @@ const char *tdx_dump_mce_info(struct mce *m)
 
 	return "TDX private memory error. Possible kernel bug.";
 }
+#endif
 
 static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
-- 
2.39.2

