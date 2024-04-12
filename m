Return-Path: <linux-kernel+bounces-142540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67C8A2CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0873D286B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8C54BEA;
	Fri, 12 Apr 2024 10:59:31 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17835548EF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919570; cv=none; b=WinS7GlpwLpJ3SCM0bS1uQX31UfKzOauFX9+yXOrPbkdpd65LQm56GBcBthDif7sja1eE2U1ncNEozmxMx8BpZYs5GxCs0aXs2ywcQayRvTP/UPKn+t05u4S3jK0/xyMgdwpDBxUaehf2aKoqfsPTolN5ejr7+pHXYgOLFuA0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919570; c=relaxed/simple;
	bh=1sBhyvz1fxNkFqL0yFOzYr/XO/zKc8UzE3DM3vAvTsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0LrPTfdJt/oqbxGt+/lXh7IXbiJML6yZTbgKmEL1X/TuovIhe1Gr5jNMyPVPNqcLNBI3BzWRdJBACJw5045u39YhzCt8P68dzNgLXNYvyJAqUnQ0XH7XKbCe9uKIbRon4YvZek0r7EZY3qSLdOieQnlEfqm4JMvun9OtlG+DG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1712919542t285z4q0
X-QQ-Originating-IP: P9W5CUCzmo74STeBAOKXjWV3lnnaXjPFC+yITRe8kF8=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:00 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: w1YG9MRGEBJKkTAyBrDV6RT3dBhtX93mXW6fSIaKArDqK5i71v7BXONlHvAty
	ahwXzLDzb0jWTi9IQTMfjoZJ8MJW2EKCnAMgLstA65WAoqS9U5i2pCOEaAArM3E+pHxuawt
	bAVfJIswMUzXEZkhbDjioNdgd8Pa1douq9gDNJjmiNRlsah0tGjUjSmCbWVZnDSqbMt2DWA
	Q1o0CfEludca8M917Fav6gdTOryyUMCmcVuprHlJ2ZqCsgsNHXIP0gPB8t3dnPvSGII57hR
	cIpNScuJshdwyMLU5Dsk7wRCWvMVeNh8VoNJUB10kl4y578ijfDDKL/8bPtxZ6mHUCoEQ21
	aq66GP/zopHDICRpL973vsg1bwlH8FsLdZYEBR/GOPvfg3UKOsHS7DnXRPUcraVSNadZJko
	+8TxBYoGcZQxdhpugT27RQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1337422365451864841
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 1/6] cpumask: introduce cpumask_first_and_and()
Date: Fri, 12 Apr 2024 18:58:34 +0800
Message-Id: <20240412105839.2896281-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240412105839.2896281-1-dawei.li@shingroup.cn>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For some cases, it's required to make intersection between 3 cpumasks
and return possible cpu bit. Current implementation for these cases are
allocating a temporary cpumask var(sometimes on stack) storing intermediate
calculation result.

Introduce cpumask_first_and_and() to get rid of this intermediate orinted
approach. Instead, cpumask_first_and_and() works in-place with all inputs
and produce desired output directly.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/cpumask.h | 17 +++++++++++++++++
 include/linux/find.h    | 29 +++++++++++++++++++++++++++++
 lib/find_bit.c          | 14 ++++++++++++++
 3 files changed, 60 insertions(+)

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
index c69598e383c1..047081c6b9f7 100644
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
 
@@ -345,6 +347,33 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_first_and_and_bit
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
+#endif
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..fdc5c4117e8b 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,20 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+#ifndef find_first_and_and_bit
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
+#endif
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
-- 
2.27.0


