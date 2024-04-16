Return-Path: <linux-kernel+bounces-146520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F278A6684
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821671C21141
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453684FBF;
	Tue, 16 Apr 2024 08:56:05 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC384A3E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257764; cv=none; b=ghB8D5qR87xsNi1pVMyuGozPNoOigoi49QOqSOw0dJZEW6SFDheuuvyybGeL5W8w+3mFcUQ36cBUGZ1a5Kmo62+y96QGjJTS0D+4SKVOu+277xyPprpOLpLEXwgK3pSh/zV78LinE5GzSxqKKfSF2qjo2YuM/fZVC4u57+FQtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257764; c=relaxed/simple;
	bh=MWsZw2xAnYzew3mAR/4hOT+/JOvbHTbm2HiiGwv43ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2KZs251NE9aMG1Cf+o3xhuSZ+5RA0WKvTCrk4NBK/3bsQf3uPvy7fpCZdN+t3t3HCW3lq/h77TJ4c3Bq2ZulQMBnoiPe+RsB32hnnx1yV781D3jjAQQzV58HTQ1TyZdlSQHVLwvQrubEe8/GMrJ19CiC7jsCQxH/zEEk0rF7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1713257723t6x31fvw
X-QQ-Originating-IP: WatDBIqlqkEbhBW9b+x8m3/vWdvHewLtHdIAOQ/7O8c=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:21 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: H21jX+7aWYbgzlTnzlsOCCpV6BUAK1vvoOUgDWvSPPEkNN8e8v5NqbHiz4AIp
	OTQGH/RpD7/ddJ5hJ8EGGPeTyF7iSrbIXZzthHIgzy7JLrWLNlyWvnTQfeeddjsBk7udAXJ
	oV4YouBL/O98r5xkt4RxhfC++Sdjf6AjyOrrR6xkAHWfmsc8UzW6yEALuJAiauTryEL9p5L
	0PHMLrtB5AMPD8z7TLiBgul0VUr1oO4VlA+2Wq8WhZ+xn7DAAonLAuWR0QV56VeMJHc6PMX
	VEvv/dFUAQxPVhengYCficlfz8shhzd+r3NDgWhXv/Q5NabaBTJqZ8hZwamG0uLbBBtE4XY
	JXdjdM35/V1RrDhY8vAQjOWCjRVSNi4qNjY3QfqOU486NAHuFyIpf6+e2KhtdBVuqQbmr91
	dBj7/8PzwoFZd0sWTTyG7KE3aWreNZbp
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5318237287310536978
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com,
	rafael@kernel.org
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 1/7] cpumask: introduce cpumask_first_and_and()
Date: Tue, 16 Apr 2024 16:54:48 +0800
Message-Id: <20240416085454.3547175-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416085454.3547175-1-dawei.li@shingroup.cn>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Introduce cpumask_first_and_and() to get intersection between 3 cpumasks,
free of any intermediate cpumask variable. Instead, cpumask_first_and_and()
works in-place with all inputs and produce desired output directly.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/cpumask.h | 17 +++++++++++++++++
 include/linux/find.h    | 27 +++++++++++++++++++++++++++
 lib/find_bit.c          | 12 ++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..c46f9e9e1d66 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
 }
 
+/**
+ * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
+ * @srcp1: the first input
+ * @srcp2: the second input
+ * @srcp3: the third input
+ *
+ * Return: >= nr_cpu_ids if no cpus set in all.
+ */
+static inline
+unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
+				   const struct cpumask *srcp2,
+				   const struct cpumask *srcp3)
+{
+	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				      cpumask_bits(srcp3), small_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
diff --git a/include/linux/find.h b/include/linux/find.h
index c69598e383c1..28ec5a03393a 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
@@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_first_and_and_bit - find the first set bit in 3 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @addr3: The third address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_and_and_bit(const unsigned long *addr1,
+				     const unsigned long *addr2,
+				     const unsigned long *addr3,
+				     unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_and_and_bit(addr1, addr2, addr3, size);
+}
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..dacadd904250 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+/*
+ * Find the first set bit in three memory regions.
+ */
+unsigned long _find_first_and_and_bit(const unsigned long *addr1,
+				      const unsigned long *addr2,
+				      const unsigned long *addr3,
+				      unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_and_and_bit);
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
-- 
2.27.0


