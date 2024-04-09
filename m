Return-Path: <linux-kernel+bounces-137272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD389DFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14FC282D70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A3139D0D;
	Tue,  9 Apr 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MCiE+5M4"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995B137C21
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678095; cv=none; b=FTL3rb33cDyB0462LBAk2o65N7ZQljQ+5wf/XF7mr3T7hU7BE5uwf0Qvo/8a0KfGThURoqy+I0bOBN4Ejkv5flwifxBSA5lou72QixhsCsdNWJNipXPaprJKMH+B8CTppdoo52l3kUor4KTCrLAgiYG/IpCUJENzLErP6xvvllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678095; c=relaxed/simple;
	bh=WubcsGUotx8PYf1zvq25+VVmzP510xR5OJGgVNuPdjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WE8CFitPcrD5I9VxfXzaEUn4sVuZG2ypKf7u7LVPUxTPqLhdFgYxnFfb1h0+DKVaRjJP0dGaToEYjR8j0Dsd4Ngh8DCMMXNx1WWfsDH1svYND2/2ZzkZCv0UYf9ToJoptQUgIlDN2JS/1g8TTAh+ZaroITxdyR03Z18FupxHqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MCiE+5M4; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439EJY3p017114;
	Tue, 9 Apr 2024 15:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EQ+H/dBiEKu8IKtLySCwmwKq940Mc7GunA0XrmxuPWg=;
 b=MCiE+5M4e8k0Wk6I0ScePrlzmAVLDpWPYb2+FE8dXySULyyuXMaA/7z3fBM6fYzDGesC
 N8pWREWYa86CzdtzwjX49bD1tYzrC2HBoAgZBupn/gmSA1YXG0FDLbdi94Tp/Dgqdp2i
 EUoVnEBkroJgUEnBFOIANy94PU5/jLzNYFXu2QP7EaxAzLWThMdQsIStLZlmdmnUkPNH
 aJ/5kdvPCxauLPX0Di4AQEwqcOeQCXOIW3tRSJsvMi9377TUvO5queNWDB8O3KMCu9cK
 LAh2cSOe5/fRFEkIKWkkq7V834KD1GPB7+E9NuJghGRPHiP3d3jU+p/zQPceGXL2UZYT ZA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xd7bc0tbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:29 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C3F7E805E9B;
	Tue,  9 Apr 2024 15:54:27 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 78703809A22;
	Tue,  9 Apr 2024 15:54:26 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id F0058302F4723; Tue,  9 Apr 2024 10:54:25 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH 1/2 RESEND] cpumask: Add for_each_cpu_from()
Date: Tue,  9 Apr 2024 10:52:49 -0500
Message-Id: <20240409155250.3660517-2-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240409155250.3660517-1-kyle.meyer@hpe.com>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7_QlsFujO7Z8xsNJtySWOVqWyt6X9OR8
X-Proofpoint-ORIG-GUID: 7_QlsFujO7Z8xsNJtySWOVqWyt6X9OR8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090104

Add for_each_cpu_from() as a generic cpumask macro.

for_each_cpu_from() is the same as for_each_cpu(), except it starts at
@cpu instead of zero.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..655211db38ff 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -368,6 +368,16 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_or(cpu, mask1, mask2)				\
 	for_each_or_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_from - iterate over every cpu present in @mask, starting at @cpu
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


