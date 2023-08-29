Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C578C5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjH2NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjH2Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A7CCE;
        Tue, 29 Aug 2023 06:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D49B6578F;
        Tue, 29 Aug 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964B2C433C9;
        Tue, 29 Aug 2023 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315993;
        bh=MSSDfUOC3gvLXz71PuLLf4zxD/dntXDkQq++7ilshuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJkqtlBT/FyWRh2AEGLFqDIFf1wc/qJiYnBzh3XDTsLUikcsOgWmYbcuZfPW3cfTh
         PGueCxqzxXudoxyk0KjVkPACnOFLp9ERS7WAfZM3Qd9I3NEes1/3busVnZv0BxwY2I
         7Hc6m39S3lXJp0drclG5yiYAyUVdWb94KfUHo/dwt1ZVZeaaa94T9h4W9rwBskPvTm
         +jkydiRkTJnCoW2oXGNESDL7rib8sMpeyfg7Z8S9pP00LhSCQZJ0C7LBC7dLQ4qKfr
         3r0mSJFZJOsFrbFRYVj8uso9tJi9ePnPzhJOoVOczkdoC8ryLvzQnirJL9415yR5Mx
         pkcLY+4jtbbxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qi Hu <huqi@loongson.cn>, Miao HAO <haomiao19@mails.ucas.ac.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        gregkh@linuxfoundation.org, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 14/15] LoongArch: Fix the write_fcsr() macro
Date:   Tue, 29 Aug 2023 09:32:44 -0400
Message-Id: <20230829133245.520176-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133245.520176-1-sashal@kernel.org>
References: <20230829133245.520176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.49
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Hu <huqi@loongson.cn>

[ Upstream commit 346dc929623cef70ff7832a4fa0ffd1b696e312a ]

The "write_fcsr()" macro uses wrong the positions for val and dest in
asm. Fix it!

Reported-by: Miao HAO <haomiao19@mails.ucas.ac.cn>
Signed-off-by: Qi Hu <huqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 62835d84a647d..3d15fa5bef37d 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1488,7 +1488,7 @@ __BUILD_CSR_OP(tlbidx)
 #define write_fcsr(dest, val) \
 do {	\
 	__asm__ __volatile__(	\
-	"	movgr2fcsr	%0, "__stringify(dest)"	\n"	\
+	"	movgr2fcsr	"__stringify(dest)", %0	\n"	\
 	: : "r" (val));	\
 } while (0)
 
-- 
2.40.1

