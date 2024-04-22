Return-Path: <linux-kernel+bounces-152794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518D8AC44E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2149282E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839D481B7;
	Mon, 22 Apr 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xaRojVG7"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C583A1A2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767957; cv=none; b=hbiU1b4bDHCP30j7pDZcAe35u91yCKPe1MCUXtEk40M1XbIa4/idcgNEWofE1+xqE76KDQLu5E9LX82REBqLIBiryMLLlL1ZFL9dX6adHbRXRIpJ4eYBgMderhN0/zzuMYrqkh8sKWK/UoPCwf7SQAmDkSEd/BsI2drV08HnuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767957; c=relaxed/simple;
	bh=4PuvvSrgrUY9QfAUKjuGoS3AnOhcCgoDp78Xl1PJe2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mPW4ku23PTwL/S62DoDElQbamGpmMwm9sCCNFKv1VVOHZFTAaaF8/b/qIPl9BJUls27Et811Zj2r/VbF/UOq/1rKG41Yvt58HqrUs5XawsSTl5sjeTlPcjMU5vNbaMMaJNb+lim/5FrPiRZqqektHB/bxie8txzLGv1zYzn+Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xaRojVG7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713767953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFTiIIshBt3nHGS/4A3nNNzLGmWXkp5ut7bbz0K7Lek=;
	b=xaRojVG7IT4jnM4Vnz7YUbaEUPe5r+mDIGUtMHukl/XaZ4VHG4ehNm8Yg3VsimU7se0ek0
	VHPVBoNMot79mURJlOpZ3hEYGKx1UjBRwPa35FTDf5PuLeE+pEE53XHqdCDk7erVT4O+M3
	33XbPTDnLBmKHLJ83uX4t/uhK3BBbUE=
From: George Guo <dongtai.guo@linux.dev>
To: peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 1/1] arm64: optimize code duplication in arch_static_branch/_jump function
Date: Mon, 22 Apr 2024 14:38:53 +0800
Message-Id: <20240422063853.3568733-1-dongtai.guo@linux.dev>
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


