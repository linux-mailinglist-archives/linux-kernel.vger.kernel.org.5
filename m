Return-Path: <linux-kernel+bounces-94025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA330873890
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AACF1F234C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967421353FD;
	Wed,  6 Mar 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXHXngj0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E9134721;
	Wed,  6 Mar 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734134; cv=none; b=W8UMjJvxZnDzzcN3CRQW27dcZku5LT1sdKseL4zsyniKJetVqrpFega6smnzKJ5X1NFVwMd/z61Qcx9VK615xiI65ms7jQtEnOqAeH9GXCd/pOuiLQy5YSq+Bb1TlW17DmWnAajri4AE3wyRYzSC4mi1jor1E4mQaJLJJzhlK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734134; c=relaxed/simple;
	bh=0zm2X/KDZl63etiI4NfF7/kknQN0paR11/NfnXifv4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6XGIiOZ/xNHG6UEEdoPowO+dkBpShYbyDWcqjhOrsS2LL3GOCVcwyYEh+G4PgPCnWDApLMhw4MpDKLqR71FCSimlfOaKRdZTQ5FTj/LqPgSDGtQ9tkAsxmaEegLBoPJQ3ilo5cIACuRHQhtmxFYQ2wyRaUIdACbj4r2NCRkgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eXHXngj0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426DXZTl020959;
	Wed, 6 Mar 2024 14:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/Pce4az328om0ozWYrHKebq5la97J2ZUIXLIxmMGpFk=;
 b=eXHXngj0FqVFeuBGEyb6Yk4OrK7PhbNiDgkm256XjSNQgzeK0+kJD6E1pvufQVe2VNeI
 QSI98MYOVdYVw8Y6gCswvJ7hVuZdUR9dXTphToWizsQGhcK9FkpjAxm1SE81Bxgjeb9v
 tOMckW2HLtEutkZXp41TmmX6FB5qGvdfiRdnEkza9GHkoBImGYysCrrnizhRE56Z7zKg
 YuhEKgX1AcuWRjMpejEvx9b0pcHSzxm48ujyAQ/+Iu6lIXDpTwsk5sU5SapyPqmhbrwd
 qsxIenS8c07jEypQexu2hdi6hLEbnPqZqVCBK/05278au8HZHAmEjb6gtgEAJhKmapd2 Vw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsfj1ewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426DHTOZ025366;
	Wed, 6 Mar 2024 14:08:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyq85a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426E8le311928132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:08:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADEC58068;
	Wed,  6 Mar 2024 14:08:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C48558056;
	Wed,  6 Mar 2024 14:08:47 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.164.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:08:47 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v2 5/5] s390: doc: Update doc
Date: Wed,  6 Mar 2024 09:08:43 -0500
Message-ID: <20240306140843.10782-6-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306140843.10782-1-jjherne@linux.ibm.com>
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aoEAmvhaWnwxiHVGGaSciocZdcgIzaCm
X-Proofpoint-GUID: aoEAmvhaWnwxiHVGGaSciocZdcgIzaCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=993
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060113

fix me

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index 929ee1c1c940..af5ef60355a2 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -380,6 +380,33 @@ matrix device.
     control_domains:
       A read-only file for displaying the control domain numbers assigned to the
       vfio_ap mediated device.
+    ap_config:
+        A read/write file that, when written to, allows the entire vfio_ap mediated
+        device's ap configuration to be replaced in one shot. Three masks are given,
+        one for adapters, one for domains, and one for control domains. If the
+        given state cannot be set, then no changes are made to the vfio-ap
+        mediated device.
+
+        The format of the data written to ap_config is as follows:
+        {amask},{dmask},{cmask}\n
+
+        \n is a newline character.
+
+        amask, dmask, and cmask are masks identifying which adapters, domains,
+        and control domains should be assigned to the mediated device.
+
+        The format of a mask is as follows:
+        0xNN..NN
+
+        Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
+        The leftmost (highest order) bit represents adapter/domain 0.
+
+        For an example set of masks that represent your mdev's current
+        configuration, simply cat ap_config.
+
+        This attribute is intended to be used by automation. End users would be
+        better served using the respective assign/unassign attributes for
+        adapters, domains, and control domains.
 
 * functions:
 
-- 
2.41.0


