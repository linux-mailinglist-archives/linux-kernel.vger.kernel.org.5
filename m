Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601777C4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjHOAsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHOAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4CB1726
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3587664872
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E27CC433CC;
        Tue, 15 Aug 2023 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060499;
        bh=u1nWpIWuw7k0zAnF/NQi2BJwAjoLPN0MnaMyy2rE3OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+4vGTbgbE+G2m55otkANO02MVzGEQh6P3wkbDIeKAc61Ge4ipns3aCly/jAe4662
         /x/bB18nxReFR6fch5pOQItf2Y0nH3kizE7YbHIYeyeZj4DTTd2ShXjwa3AkqS3wGy
         2sHLa6fcriwlG6N2VFhCXyebVd+8TkYnpxkGM4l3Fjjm+jTAj1ivbji7qF6QU57Y+H
         hG0hNX6AqE5MNSqZILVB9hPj+39Q9WdBjKrIuY/mTMOWlE6XVYhZr/ZX4hEUN27wAk
         LxZJFrr86j3mZs5YqGYm1/7UrLxm7YQ0rec3LWTNNswfIYf0Yih20vPN/W3EY2wttt
         2faWVWD8mbw8A==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 03/20] ARC: uaccess: elide unaliged handling if hardware supports
Date:   Mon, 14 Aug 2023 17:47:56 -0700
Message-Id: <20230815004813.555115-4-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index d2da159bb80a..1e8809ea000a 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -146,8 +146,9 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 	if (n == 0)
 		return 0;
 
-	/* unaligned */
-	if (((unsigned long)to & 0x3) || ((unsigned long)from & 0x3)) {
+	/* fallback for unaligned access when hardware doesn't support */
+	if (!IS_ENABLED(CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS) &&
+	     (((unsigned long)to & 0x3) || ((unsigned long)from & 0x3))) {
 
 		unsigned char tmp;
 
@@ -373,8 +374,9 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	if (n == 0)
 		return 0;
 
-	/* unaligned */
-	if (((unsigned long)to & 0x3) || ((unsigned long)from & 0x3)) {
+	/* fallback for unaligned access when hardware doesn't support */
+	if (!IS_ENABLED(CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS) &&
+	     (((unsigned long)to & 0x3) || ((unsigned long)from & 0x3))) {
 
 		unsigned char tmp;
 
-- 
2.34.1

