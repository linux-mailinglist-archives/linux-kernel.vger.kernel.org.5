Return-Path: <linux-kernel+bounces-163612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA428B6DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC9028B377
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DF129E62;
	Tue, 30 Apr 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jy7WzJOZ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607BF128813
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467439; cv=none; b=TdT8qe8rCg7bEdFh/KIXSnTzbOaj0PlHxRUlUrBQ9Uz3FcAtaBbB1cm750oTq33y7NGainZNQ7tyHXs1PZrLOkM97txBhcH1Hjvn+Ld+/I+h/VYwH0+qp1tjdwPgY7ZmhUzZP77U8k3wx4iEdPfBmmPbsSCDqas4h1Juql8ANCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467439; c=relaxed/simple;
	bh=rEosPRTdG06gJvJ1UJqnR8e29NPloE5LAew93gOUQpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlwLIXNDhyUKSHD5CQrpvEUTSVKu+3ntmcO2SrW8BU8WlAbZ2xZOOkhkCxI1LIyuzy6ojGokhZSJcqU+XWdf3C02JltioQo8D6mwMx8qsNLn2gYvlbIpN1iSa+MaLD8mXjWGEcTBFJihGL//BR/NJ6l2LllyqzSdadMLc7aRatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jy7WzJOZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714467435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coNJgQXJx6rWysDXjwJJAKNcI1CfudjLlaUiK4+GVcc=;
	b=jy7WzJOZ6T5WSb8bk6k7Bh9Gj8OYkNbzSSk0MyWTg+AiBtGq7C/zT+u9tKTJSbLcN0qoMV
	8Y5IjGMoWMwyvuSCrYgMJ7EosEijGpRJjzUcH5d4AuOpjSGLYXZukj4FXN2xLzJWE6ryVo
	YDImg3xCi5CpbQSdYpsZOgotWfbP4zU=
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
Subject: [PATCH v3 1/1] arm64: simplify arch_static_branch/_jump function
Date: Tue, 30 Apr 2024 16:56:55 +0800
Message-Id: <20240430085655.2798551-2-dongtai.guo@linux.dev>
In-Reply-To: <20240430085655.2798551-1-dongtai.guo@linux.dev>
References: <ZiYs3itsmdOmuPq4@FVFF77S0Q05N>
 <20240430085655.2798551-1-dongtai.guo@linux.dev>
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
code duplication.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/arm64/include/asm/jump_label.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 6aafbb789991..d43fce47feb9 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -15,17 +15,23 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
+#define JUMP_TABLE_ENTRY(key, label)			\
+	".pushsection	__jump_table, \"aw\"\n\t"	\
+	".align		3\n\t"				\
+	".long		1b - ., %l["#label"] - .\n\t"	\
+	".quad		%c0 - .\n\t"			\
+	".popsection\n\t"				\
+	:  :  "i"(key) :  : label
+
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
+	char *k = &((char *)key)[branch];
+
 	asm goto(
 		"1:	nop					\n\t"
-		 "	.pushsection	__jump_table, \"aw\"	\n\t"
-		 "	.align		3			\n\t"
-		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
-		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		JUMP_TABLE_ENTRY(k, l_yes)
+		);
 
 	return false;
 l_yes:
@@ -35,15 +41,11 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
 static __always_inline bool arch_static_branch_jump(struct static_key * const key,
 						    const bool branch)
 {
+	char *k = &((char *)key)[branch];
 	asm goto(
 		"1:	b		%l[l_yes]		\n\t"
-		 "	.pushsection	__jump_table, \"aw\"	\n\t"
-		 "	.align		3			\n\t"
-		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
-		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
-
+		JUMP_TABLE_ENTRY(k, l_yes)
+		);
 	return false;
 l_yes:
 	return true;
-- 
2.34.1


