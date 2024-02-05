Return-Path: <linux-kernel+bounces-53208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27A84A231
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64C11F2103D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C44E1C9;
	Mon,  5 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sze0O4lm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACD482EE;
	Mon,  5 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157538; cv=none; b=RfFzvdIcoLs0LxSF2KcLNO84Il8ySCnp6tH/g7YXu9epCtr4On7ZEdc5Zddk4BaiP8gJFlNH4jpg9VGixLjCKMazJQnwsEP/WrJ3/2kDrlV9JHyYOPSoaxWhKlYUjKdX+rY3biIs2UOWv/hL5A0lOfMc10NGQk4nfXjvbsYdUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157538; c=relaxed/simple;
	bh=4KP7O425uTsxVP5HI1ABFszr7vhFfT9HSRwUfG/aGjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giO0Zrzo9k5hK7tGk8duaK+Ba1g7Up3fFw/oZRuwFVc5yJgAnY0VuPHDyq36QutB2s7r0cL1XIjgahMFKvEMbvkvG4tMwCzGDX1Jl6CUr60nCm9D1obd0Pu1Wfk2TWQqyP0oGs8iqRTg3qWthzyH4WF+d7jhL9Ka30mu4BJJkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sze0O4lm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415Hh4Ec022037;
	Mon, 5 Feb 2024 18:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a3vsKHKBwl+QIw4d1CzatigIkAJ6zN9NXGjAgtIf538=;
 b=sze0O4lmNkX4TEGB3h9sF0nh5eXtW3k0wJjt537SlTw2G+6YIjF8YsI9lyllg5n3ihbO
 aMmduqXf4gPb9p1HXPeXhM5yGQfmq/FfrRSqyyOVsw4sEmVQBdU0bfb/dCWH6ohOKPkL
 w3p0BM9VF3eplzdwbgL/cjSFuGq7ZR8RTrDvasBF78VvWGo2b8Ojx+8O/QUkRyAUSxxU
 KR7q7IT5nfuXDjpRDsYOv4JoAyVkQ4j0tBUTHP8B36CqzTQtyIYHb0cNVi8/ySgdSCby
 Eainc9NbnYVOQMimZU1TVH4mkvZREkxmaCTkfGWFA266NTD8/TNOeMsPtq1sBcG78eTi ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33n628uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415I06DJ008946;
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33n628u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415HIA5G005458;
	Mon, 5 Feb 2024 18:25:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21aka1xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:15 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPEm215729214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C4E58056;
	Mon,  5 Feb 2024 18:25:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3DC15803F;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 5/9] evm: Use the inode holding the metadata to calculate metadata hash
Date: Mon,  5 Feb 2024 13:25:02 -0500
Message-ID: <20240205182506.3569743-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205182506.3569743-1-stefanb@linux.ibm.com>
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bJfUEwHt_43L-rH68Z1L0iGJZwmdea01
X-Proofpoint-ORIG-GUID: vpPGj99zgkScQZYs7pIlU9lDZC_NXRLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=935 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Changes to file attributes (mode bits, uid, gid) on the lower layer are
not taken into account when d_backing_inode() is used when a file is
accessed on the overlay layer and this file has not yet been copied up.
This is because d_backing_inode() does not return the real inode of the
lower layer but instead returns the backing inode which in this case
holds wrong file attributes. Further, when CONFIG_OVERLAY_FS_METACOPY is
enabled and a copy-up is triggered due to file metadata changes, then
the metadata are held by the backing inode while the data are still held
by the real inode. Therefore, use d_inode(d_real(dentry, D_REAL_METADATA))
to get to the inode holding the file's metadata and use it to calculate
the metadata hash with.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..51e24a75742c 100644
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


