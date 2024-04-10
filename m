Return-Path: <linux-kernel+bounces-139376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9528A022C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3081C218A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD22184102;
	Wed, 10 Apr 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="jRZ5Slpp"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DE181BA1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784854; cv=none; b=ibp+S86o2dgeZ4OyJxOsbQgSa760cJy5Ze3id/iYkMBfmW/vnzcsRYPIw/yVmxGODU97VuiTilcz6skuzHG/EF5KGGgqy98TMIOcUoAdEPCeRlMxFxA4A8OpBqGE9F+hWWKWtCXYM71Wt/t19V66CXmirGnzst39srW7iNCjIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784854; c=relaxed/simple;
	bh=a0SG3VyvekQ3EUaROTNeCfLGl5QhimItEjNTpotic1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhKcjO5eT1/v/CO0jHbTeXq9EZXyqatQE+2T6yMO7IQ+jM/9gycv1A4+XX3ptYbjUYSqY8RDjTQRofnM62w/ovGvlPGJ+rX/b70E+RYb04lJFSdwoH+Fp2XioNWmDyv6fOaIVOMX5CSqgzQVu3O6wwTXMxTBz8w7jEWmsPTwyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=jRZ5Slpp; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AK6FO5028605;
	Wed, 10 Apr 2024 21:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=n8iXOtRne7tZ+9DWIHeKPTmoEpb24PMwftP+jRCqW68=;
 b=jRZ5Slppd3p7dO+qYjoNotTAJxnnjzdbIyLMpa8+KoW3Dp40NfZDAqg7k7UmPxnJ6tIw
 sPpAzYML1C8Lyo3eNebv+u2533j1/0G15FOBmfv6XU+jLzgXgHFMZBaXpzEBxKyHRhCs
 TpfbsAzH7C/s6oShxcgMmr2FxB4jBkeyAGfhGYDG+h9AOtsl2vXVQ/t6zmVgiV0UVbJn
 Xx+2pfm6wVPyGgMvqk2wk347worTH5kPp0P9Pb3AcnTf8lgqC/zp3FNMQh+qIb7qqL1d
 2vpEdp/jQBoNfvZYjHwrC32jZapX0d5JIovov7F8FEQcnT4fo7/eGvS++HdVkfZNlM7+ tw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3xdssrd4m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 21:33:43 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1AF048005D6;
	Wed, 10 Apr 2024 21:33:42 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8B482805AE8;
	Wed, 10 Apr 2024 21:33:29 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id DD16430000734; Wed, 10 Apr 2024 16:33:28 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2 1/2] cpumask: Add for_each_cpu_from()
Date: Wed, 10 Apr 2024 16:33:10 -0500
Message-Id: <20240410213311.511470-2-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410213311.511470-1-kyle.meyer@hpe.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: I3aY0pbpw_jtiLoNISHwocuO5VKiBCkV
X-Proofpoint-GUID: I3aY0pbpw_jtiLoNISHwocuO5VKiBCkV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404100158

Add for_each_cpu_from() as a generic cpumask macro.

for_each_cpu_from() is the same as for_each_cpu(), except it starts at
@cpu instead of zero.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..d75060fbd058 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -368,6 +368,16 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_or(cpu, mask1, mask2)				\
 	for_each_or_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_from - iterate over CPUs present in @mask, from @cpu to the end of @mask.
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask: the cpumask pointer
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_from(cpu, mask)				\
+	for_each_set_bit_from(cpu, cpumask_bits(mask), small_cpumask_bits)
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
-- 
2.44.0


