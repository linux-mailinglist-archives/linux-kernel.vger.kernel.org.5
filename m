Return-Path: <linux-kernel+bounces-78832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E086197E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0AB26C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1813A261;
	Fri, 23 Feb 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USP7ET2m"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183313341F;
	Fri, 23 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709145; cv=none; b=CUkzruZG66N3eLPVfBTHQgNQCvSnqkKAC9hAYoq60Fop9sZUtM9pKsYCqhHyP1QsDCyWU0LEt6EZFoTyf3gDyvd+hYDEyz3zK+CNVTT1mkJ/8jlEHEV5XZddaSwSnyqg6Tg97SHXbHWLceY/QLmrxlsRC6uxOoJ5ziGKah5hI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709145; c=relaxed/simple;
	bh=9mXQ1BGzBOlg5izS1nn4EJTQWXx67AxBDxrlxoLTRBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJbiO8XRcHA70bb0Yw3hMt5d/YZHiBf3st76ujXCSPyAKcTHQk4nntnfzlJpT3iIR86IstmFsIaioc8bN+0cF8Pt7AmdT7EZgoM8aflwozUiIshp7nFVGUrUH9XoYDnXKFqKjnuJysohWG3uNhp0Vo5Cn+9HjAyWF+6DGKxlJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USP7ET2m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHMLjp026927;
	Fri, 23 Feb 2024 17:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X/ePSxDdWpDwK8FN8vmj7V7eFK5aLdsPNvK8v5E61Ss=;
 b=USP7ET2mXNJpj+HekwBv5k2R2oCZazlb/WFlKCATli6R5gkDOmIsNu5Y0OJgEHbDlc0Q
 SiJdBpVWwZAK1VgjSboHCBg28o2b+3brm/pN/NNQkAp2VUNeC9NdUiz5/FXs7Snb23pE
 GcXXStG52a5YKxaV8soX37PNUJlYySOgkVLu6ksu0gU1uhbh8nFRKGe9vJ4h97CinLS3
 Gl414zNknPQfEkEfwM0O/jh37eVGMKX5batskbRC+RWaFd+n2qvv+S9Ml8z4SoHB9XE7
 E2J39PDzyfWvm+id9+e8xOU6zFrEHWcvPQSpWP4RLm49eETk8v70D6SE8njdsAiNXgr3 vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:28 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHNQIX030513;
	Fri, 23 Feb 2024 17:25:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFWGxf003611;
	Fri, 23 Feb 2024 17:25:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u756c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPMY619661510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49A558043;
	Fri, 23 Feb 2024 17:25:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17A358065;
	Fri, 23 Feb 2024 17:25:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:21 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 04/10] evm: Use the metadata inode to calculate metadata hash
Date: Fri, 23 Feb 2024 12:25:07 -0500
Message-ID: <20240223172513.4049959-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223172513.4049959-1-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eVejRUY03dMWT6j6oSFXNpdfhfPBnong
X-Proofpoint-GUID: SBDFzDF_Bd6udu3A4D50GeG50jjpmPgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=970 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Changes to file attributes (mode bits, uid, gid) on the lower layer are
not taken into account when d_backing_inode() is used when a file is
accessed on the overlay layer and this file has not yet been copied up.
This is because d_backing_inode() does not return the real inode of the
lower layer but instead returns the backing inode which in this case
holds wrong file attributes. Further, when CONFIG_OVERLAY_FS_METACOPY is
enabled and a copy-up is triggered due to file metadata changes, then
the metadata are held by the backing inode while the data are still held
by the real inode. Therefore, use d_inode(d_real(dentry, D_REAL_METADATA))
to get to the file's metadata inode and use it to calculate the metadata
hash with.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 7552d49d0725..35416f55391c 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 size_t req_xattr_value_len,
 				 uint8_t type, struct evm_digest *data)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));
 	struct xattr_list *xattr;
 	struct shash_desc *desc;
 	size_t xattr_size = 0;
-- 
2.43.0


