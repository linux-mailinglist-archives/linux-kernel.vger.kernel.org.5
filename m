Return-Path: <linux-kernel+bounces-15621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F78822EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDD1F248D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F731A282;
	Wed,  3 Jan 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJOWDdtr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C821A59C;
	Wed,  3 Jan 2024 13:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8135BC433C7;
	Wed,  3 Jan 2024 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290102;
	bh=e+vdgZdNlFkyaCqPGKRk3VegfICWH1EOn+tuydPy1NQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SJOWDdtrO8MiO2UrWdF7alkssLRSYC87HIhmoVCdQA2HC6cZ7JwY7uAK4exvO+Cvm
	 1LFu1V0F63pbEEaHi3nCfcdYLV6zBe6jIj91mabM6lzN0em9qmQN5/a0/wJHFIe6Cb
	 yQ0er1M7R/lUZN4AbdYHrSktGoQnGPqXztNwCSAr5RlYvhMf5+gG/gnXh/7LZ1H27o
	 CPyEBmU0Sajz1SBAgkE1Wbak3su8mqK8j/3BU1u4WNf/ZUstoZrEpZbSKZE6WZec8p
	 VvSwA21E8bz+lLbb95Vu3e922amoXZ9cJzDiGrACXyX7U3waRLZEcjz42N1ocn/tWF
	 0OFZSKjR6G2fw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] linux/export.h: remove unneeded .balign directive
Date: Wed,  3 Jan 2024 22:54:54 +0900
Message-Id: <20240103135454.376021-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .export_symbol section is discarded by the linker script, hence
no alignment is needed. Simplify the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/export.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 0bbd02fd351d..dff230bb5aca 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -15,13 +15,9 @@
  */
 
 #ifdef CONFIG_64BIT
-#define __EXPORT_SYMBOL_REF(sym)			\
-	.balign 8				ASM_NL	\
-	.quad sym
+#define __EXPORT_SYMBOL_PTR	.quad
 #else
-#define __EXPORT_SYMBOL_REF(sym)			\
-	.balign 4				ASM_NL	\
-	.long sym
+#define __EXPORT_SYMBOL_PTR	.long
 #endif
 
 #define ___EXPORT_SYMBOL(sym, license, ns)		\
@@ -29,7 +25,7 @@
 	__export_symbol_##sym:			ASM_NL	\
 		.asciz license			ASM_NL	\
 		.asciz ns			ASM_NL	\
-		__EXPORT_SYMBOL_REF(sym)	ASM_NL	\
+		__EXPORT_SYMBOL_PTR sym		ASM_NL	\
 	.previous
 
 #if defined(__DISABLE_EXPORTS)
-- 
2.40.1


