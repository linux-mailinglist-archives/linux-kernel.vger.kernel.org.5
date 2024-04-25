Return-Path: <linux-kernel+bounces-158289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF58B1DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7001C23F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16DE1272B5;
	Thu, 25 Apr 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L/tTBCQl"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF81272AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036925; cv=none; b=jB/lEEJt8kesvCbKIJ/ZDFnHdnT+pVoV1qC3yIDnv1Nd8YW7F1Y64mlxf+jki//8KE+WwWwTcsynPlaVJBjLY8edM0TW6rVXqKwJpz+LqKiI0QulNbrO8A+lNibPFYIBBWeQQ8DSZnqahI/bp/LTNUVC3gen/VegM25ZRsZwWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036925; c=relaxed/simple;
	bh=4PuvvSrgrUY9QfAUKjuGoS3AnOhcCgoDp78Xl1PJe2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feAnfZSm92AvizzU7SLQwLICr2gv+JG6T3hrlX+1d9ocnrvf4u7OFckGILk/Af1BLuugFcoqJo3oQp3hFy0mrgIu8qFYVkSpD4W8+aTFck319gE+/AQvx6+Le2hlsFRTzOplTG4pZx19BZaw2dEePClzgBn2Rawaued857Bhoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L/tTBCQl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714036921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFTiIIshBt3nHGS/4A3nNNzLGmWXkp5ut7bbz0K7Lek=;
	b=L/tTBCQlgNyM6irTUBCMN/Y6PXJQjRQC9n0W0NtMa5LHG8Pb7sNC5gdYslPPrMV9B8hSLr
	CXs4h4OEagpy0KKe2NFnI48BIh9Q+G7CaZDjNkwO12RmU4ujfR6Ct7hiZsGa1rWSc3iLsi
	kJlISbN0kcONOTC1OgGyL3RaLBNsJFw=
From: George Guo <dongtai.guo@linux.dev>
To: mark.rutland@arm.com
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	dongtai.guo@linux.dev,
	guodongtai@kylinos.cn,
	jbaron@akamai.com,
	jpoimboe@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: [PATCH v2 1/1] arm64: simplify arch_static_branch/_jump function
Date: Thu, 25 Apr 2024 17:21:18 +0800
Message-Id: <20240425092118.2924369-2-dongtai.guo@linux.dev>
In-Reply-To: <20240425092118.2924369-1-dongtai.guo@linux.dev>
References: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
 <20240425092118.2924369-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Extracted the jump table definition code from the arch_static_branch and
arch_static_branch_jump functions into a macro JUMP_TABLE_ENTRY to reduce
code duplication and improve readability.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/arm64/include/asm/jump_label.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 6aafbb789991..69407b70821e 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -15,16 +15,19 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
+#define JUMP_TABLE_ENTRY				\
+	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
+	 ".align	3			\n\t"	\
+	 ".long		1b - ., %l[l_yes] - .	\n\t"	\
+	 ".quad		%c0 - .			\n\t"	\
+	 ".popsection				\n\t"
+
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
 	asm goto(
 		"1:	nop					\n\t"
-		 "	.pushsection	__jump_table, \"aw\"	\n\t"
-		 "	.align		3			\n\t"
-		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
-		 "	.popsection				\n\t"
+		JUMP_TABLE_ENTRY
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
@@ -37,11 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 {
 	asm goto(
 		"1:	b		%l[l_yes]		\n\t"
-		 "	.pushsection	__jump_table, \"aw\"	\n\t"
-		 "	.align		3			\n\t"
-		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
-		 "	.popsection				\n\t"
+		JUMP_TABLE_ENTRY
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
-- 
2.34.1


