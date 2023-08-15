Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476E77C4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjHOAsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjHOAsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105D1715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8E364006
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C703C433C9;
        Tue, 15 Aug 2023 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060498;
        bh=pgFliqh5FCiPwev8SHNbWyt1mtItXDmKgFcmPAR7eAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArMfxvd8GgUdg9gKY7FVVUcLWCSiKmKUDUbi+UAGlo4ygnK0IxpvcOECu7gxym9b+
         6XhETF2Rtb8o+c8/Q2S8XTUUNI15wG2klfjCtsR1Mmkm1Xi+DQ2gNYcN2N/T31Xtm1
         AgsBEAX8lxJjcmzsVneffl3TGWlOQNimVicJzFsZGRBr/DF9TI8fVZiMjUGwjVwa9C
         nxeQ4P+tA0myGZBOwFI4D0Huaykq4WTzQ+sx7hA1RiUtasRRDseNyqZJsmIWvBbyc+
         LPQ0fazBO9uHvG6/n+RxG+QZwGI8wcx520FlACcltd/KNaplqsj0yMkyMCKzbKksVk
         KhCJY1XMVb6KA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 01/20] ARC: uaccess: remove arc specific out-of-line handles for -Os
Date:   Mon, 14 Aug 2023 17:47:54 -0700
Message-Id: <20230815004813.555115-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything is now out-of-line in lib/usercopy.c

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/uaccess.h | 11 ++---------
 arch/arc/mm/extable.c          | 11 -----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 99712471c96a..d2da159bb80a 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -584,7 +584,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return res;
 }
 
-static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
+static inline unsigned long __clear_user(void __user *to, unsigned long n)
 {
 	long res = n;
 	unsigned char *d_char = to;
@@ -626,17 +626,10 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
-#define __clear_user(d, n)		__arc_clear_user(d, n)
-#else
-extern unsigned long arc_clear_user_noinline(void __user *to,
-		unsigned long n);
-#define __clear_user(d, n)		arc_clear_user_noinline(d, n)
-#endif
+#define __clear_user			__clear_user
 
 #include <asm-generic/uaccess.h>
 
diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index 4e14c4244ea2..88fa3a4d4906 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -22,14 +22,3 @@ int fixup_exception(struct pt_regs *regs)
 
 	return 0;
 }
-
-#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-
-unsigned long arc_clear_user_noinline(void __user *to,
-		unsigned long n)
-{
-	return __arc_clear_user(to, n);
-}
-EXPORT_SYMBOL(arc_clear_user_noinline);
-
-#endif
-- 
2.34.1

