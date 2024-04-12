Return-Path: <linux-kernel+bounces-142787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A48A3017
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944851F22AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA0126F32;
	Fri, 12 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cypULCuV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA686262;
	Fri, 12 Apr 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930505; cv=none; b=FiQbucr0SiYeqpIkuhKYN7aoCcrsFW80worBsLGNK5C7SVmwRtyVaiUPUOySkS0DPcCTT9T8MCmA1bnBOAi+XjJBHpTURNjtFCgpNfQsBCJCQdwGEAH++kyyP+QCpNUsT//k5ikNwH2NMxno8carvV/A0AE5VibqASluNWxZCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930505; c=relaxed/simple;
	bh=NM4hlOMQsrnFFrneWvCxMxGhgdDsxkliPcqMY7mRnFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYIVIkWzQkCoJ1lOJO4VNiAwA3KBk99fv2+qfIduH2qfO4oOTX0vT3CvBH6BjR4UcJeq+eDEu66PWVlFcTvmUc59OB12n0yAAOR86kxLzFU9vz4Fpv5qGKd4M8ZDaYFBScijwH0FIOyLurUf1Qq6jnaM339i1UDbMiveRD7/j6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cypULCuV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CE0WY0000531;
	Fri, 12 Apr 2024 14:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9pjxrVeBMOdLpWUre/WzLmPuBazQcFpTaTReG6oVzVI=;
 b=cypULCuVgdyBWUH1ew1JHYIuBj2J9basV/9u5hlfgcuXAK6hZRX+i+iL/DU0XDUhFL5l
 /C1BgcG/Cf8zQabpOU8eLWRID8Vqj8v7QO/W/Nc1aQz5u3OuP9rohqCMpAb0fZJBPy/2
 xenlwKw94WlfnYOq2zQ4+s/UgnECIGBTSr7MqNOtILPWtR71pIocBA4csT7da39btMIx
 XjVPuDOwcd9C6dnT0k3/47cAq3uniR7FKdcZ0aEPgjlJuTSRFsJDXO/3yz+pkZLZdH0C
 XhnPf0mZnWmfEotnaw/iAuDqVnZeOLqjJzqggT9CDEB9GchkPmAmbRCwjnTRAvT4TeOf xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5b4g4sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CE1Xm9001958;
	Fri, 12 Apr 2024 14:01:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5b4g4sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAnXtt019089;
	Fri, 12 Apr 2024 14:01:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh40tc8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CE1TlZ5046786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:01:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B7095805A;
	Fri, 12 Apr 2024 14:01:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFEFB58072;
	Fri, 12 Apr 2024 14:01:28 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 14:01:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC 1/2] ovl: Define D_REAL_FILEDATA for d_real to return dentry with data
Date: Fri, 12 Apr 2024 10:01:21 -0400
Message-ID: <20240412140122.2607743-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412140122.2607743-1-stefanb@linux.ibm.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eX8HXJvsg27-KL4Ie6rlc8btVmXnOHO7
X-Proofpoint-GUID: 1lyrfiG_wwnbi4lqo4kN8KpcpFZ3xEpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120101

Define D_REAL_FILEDATA which is to be used as a parameter for d_real()
to return the dentry that is holding the file data, which is either the
upper or the lower denry. The caller is expected to call d_real() again
on the returned dentry to get to lower layers of a stacked filesystem,
if available.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/overlayfs/super.c   | 6 ++++++
 include/linux/dcache.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 06a231970cb5..f466ad89b005 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -36,6 +36,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry, enum d_real_type type)
 	switch (type) {
 	case D_REAL_DATA:
 	case D_REAL_METADATA:
+	case D_REAL_FILEDATA:
 		break;
 	default:
 		goto bug;
@@ -47,6 +48,11 @@ static struct dentry *ovl_d_real(struct dentry *dentry, enum d_real_type type)
 	}
 
 	upper = ovl_dentry_upper(dentry);
+	if (type == D_REAL_FILEDATA) {
+		if (ovl_has_upperdata(d_inode(dentry)))
+			return upper;
+		return ovl_dentry_lower(dentry);
+	}
 	if (upper && (type == D_REAL_METADATA ||
 		      ovl_has_upperdata(d_inode(dentry))))
 		return upper;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..e4e54fb2cf4e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -128,6 +128,7 @@ enum dentry_d_lock_class
 enum d_real_type {
 	D_REAL_DATA,
 	D_REAL_METADATA,
+	D_REAL_FILEDATA,
 };
 
 struct dentry_operations {
-- 
2.43.0


