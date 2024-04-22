Return-Path: <linux-kernel+bounces-153601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5E8AD03D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390C41C21F77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB580152524;
	Mon, 22 Apr 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iPRMRii7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934B5025E;
	Mon, 22 Apr 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798442; cv=none; b=M9j3oC2U5jZB+718TzQhzz+kjJH8E+awOimuH2fV8Z1BY4ieyq5oUjpf3j7Z4nmnkl7JRqerAVJxQuP971wRFv28pZJk48vocu655yaRYtNYyZjjw05fMs8r3lhgvKmOPaqPpO4zUX1V3OLkaOiXcDnrV3M3oTM/RGCYqdYPcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798442; c=relaxed/simple;
	bh=kuIUXr6YCXOh6IhDYo491UZyf4sjhrPMSWv5b0L5gno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOGyI1OdDpiSfsXPaR/90aOeXbiTAbAL148IjerOu562e31v4cG8KTuZY4rr9wg0fEmTH0JWtjWDYpOgsON8H3vKelsuFp7Hr2Hnz6lGVPhCjYzrVYWDkuCYM0GxzBW7Mcl2PpyCvadkq+9eX1q4h8LgxS9VFaCpT3fbaq/FGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iPRMRii7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MEmx5b029307;
	Mon, 22 Apr 2024 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4fKxuhDNVZ10Ev35pQE20tb1THhCYL/0YyVKHfB7crI=;
 b=iPRMRii7f6CLKwrZj99qE25polEJPStTONLanaCDb0bOhjelQbso9n2ZRaMscO1lQTYI
 ssTjM8V2lebS8OQZLS/xZenbb7ZC+PcRrjL0QV3f2gQT7eXSeMxrwncP+k0C3sXz8EsB
 kM4qGspQ3yaYcJlNm3HWdcCBG5t4h3FoukfHIpeBnxERr2x154VSO3QLwJ3pJZ+AKndF
 +I31NEWvE8RewDIo1+xcSndoiMpJA89DsGyPv1faSlHdF3ptNneOD2SDgVx0q33+IIc9
 qWzp7JEKDuEcuMejppfms6p5MtZlVjaVDMuI+VFEcITAYhVb+vpAycz60Su5JSvAzgbG +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnsyx81jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:04 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MF73Qi030610;
	Mon, 22 Apr 2024 15:07:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnsyx81ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43MBmHMu028328;
	Mon, 22 Apr 2024 15:07:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr27vdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43MF70IM25821940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 15:07:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FCFE58065;
	Mon, 22 Apr 2024 15:07:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FF058043;
	Mon, 22 Apr 2024 15:06:59 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2024 15:06:59 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        brauner@kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 1/2] ovl: Define D_REAL_FILEDATA for d_real to return dentry with data
Date: Mon, 22 Apr 2024 11:06:50 -0400
Message-ID: <20240422150651.2908169-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422150651.2908169-1-stefanb@linux.ibm.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BSjmWBvt92PLPKosiN5REeUDopk1TNUt
X-Proofpoint-GUID: iOmg7h_3DNPC1Pc8_8sU5S8ir8steyM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220065

Define D_REAL_FILEDATA which is to be used as a parameter for d_real()
to return the dentry that is holding the file data, which is either the
upper or the lower denry. The caller is expected to call d_real() again
on the returned dentry to get to lower layers of a stacked filesystem,
if available. This allows a caller to get all dentries involved in hold
a file's data and iterate through the layers.

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


