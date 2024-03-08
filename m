Return-Path: <linux-kernel+bounces-97572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B9876C06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6951E28359C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00B5E096;
	Fri,  8 Mar 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Cyqj3pH0"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEE1EF1E;
	Fri,  8 Mar 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931066; cv=none; b=aGJ7RRXzbO7qzJV0GKepJqi+3kNkfdq/DAtVuEvTBFWfr9dpPQSK2aTB8XJBZHIwUcUxksJcSsnZZ2Yh2ZB9o+Pfwef8yhFT4w2jJzawmOefjtowTz832Wfe73OiN0+tVxxJpH4dO5UfdDDROxaU0Tl4f5TW4bDUnAQDgeXGvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931066; c=relaxed/simple;
	bh=vtY+SJLzuQ886tO3RilWGHvnlozVn7rpCpvs+8G8tZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ei30OAGwEJM2hLQGv93q2gYNHe9MLBJ0HdkUdo62Z0+kOgh6eM7O4daZQrWYP0TTrvbwmwQB94/K1m/8j9ohq5Rb9EOmCUtBP0gUsyQ6Fl+pOM0NSMPtK1vP5v741hFHaX7LRzTpctv2hua6mIk3zRc/FDYxMFgVPORXdGzqOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Cyqj3pH0; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428ImR43014453;
	Fri, 8 Mar 2024 20:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=oG87MoMYaG+G4FieFFonOB5EHz7PptoAErze3BHJIwE=;
 b=Cyqj3pH0xopbdBtnBxuleSm5v1P3nMRbRxRoXCPi9w0+pwqy3OZ6n5IAa+isiwXrTKHw
 vJHnNR6l2yQ1Ve0Qoe7P8H2xJdtgpp1vgBa81e8KNIivKQWKMSVNkuoPmlpU7jM/H15Z
 T132xponLHLcW1rjRowyLL/oomAgzPuHDmMYgcVPdRJna4wy3nPJjvLETYuRhPKCXNvO
 zJ7SLVObz/KPFF5trvKWNGueXeSmp2Vl1OOzeooahYtSKppmY5jQy4ovi4fAznLACtPv
 yum6QOTnfbClFZIGGUd3AoelHWOwJnMwU21mBU/O3PEurz20px4OQQ9r87lfiJwb5gjS 4g== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wr5jktc6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 20:50:46 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 83EEC8059CB;
	Fri,  8 Mar 2024 20:50:45 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 290768014DB;
	Fri,  8 Mar 2024 20:50:45 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
	id A352330000A0D; Fri,  8 Mar 2024 14:50:44 -0600 (CST)
From: Justin Ernst <justin.ernst@hpe.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH] tools/power/turbostat: Fix uncore frequency file string
Date: Fri,  8 Mar 2024 14:49:57 -0600
Message-Id: <20240308204957.2007212-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FLfWcM5C0A-_FpItH3KrMNt39-CpGJJu
X-Proofpoint-ORIG-GUID: FLfWcM5C0A-_FpItH3KrMNt39-CpGJJu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080164

Running turbostat on a 16 socket HPE Scale-up Compute 3200 (SapphireRapids) fails with:
turbostat: /sys/devices/system/cpu/intel_uncore_frequency/package_010_die_00/current_freq_khz: open failed: No such file or directory

We observe the sysfs uncore frequency directories named:
..
package_09_die_00/
package_10_die_00/
package_11_die_00/
..
package_15_die_00/

The culprit is an incorrect sprintf format string "package_0%d_die_0%d" used
with each instance of reading uncore frequency files. uncore-frequency-common.c
creates the sysfs directory with the format "package_%02d_die_%02d". Once the
package value reaches double digits, the formats diverge.

Change each instance of "package_0%d_die_0%d" to "package_%02d_die_%02d".

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7a334377f92b..2a15a23cb726 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2599,7 +2599,7 @@ unsigned long long get_uncore_mhz(int package, int die)
 {
 	char path[128];
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/current_freq_khz", package,
+	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
 		die);
 
 	return (snapshot_sysfs_counter(path) / 1000);
@@ -4589,20 +4589,20 @@ static void probe_intel_uncore_frequency(void)
 		for (j = 0; j < topo.num_die; ++j) {
 			int k, l;
 
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/min_freq_khz",
+			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/min_freq_khz",
 				i, j);
 			k = read_sysfs_int(path);
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/max_freq_khz",
+			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/max_freq_khz",
 				i, j);
 			l = read_sysfs_int(path);
 			fprintf(outf, "Uncore Frequency pkg%d die%d: %d - %d MHz ", i, j, k / 1000, l / 1000);
 
 			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_min_freq_khz",
+				"/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/initial_min_freq_khz",
 				i, j);
 			k = read_sysfs_int(path);
 			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_max_freq_khz",
+				"/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/initial_max_freq_khz",
 				i, j);
 			l = read_sysfs_int(path);
 			fprintf(outf, "(%d - %d MHz)\n", k / 1000, l / 1000);
-- 
2.26.2


