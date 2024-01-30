Return-Path: <linux-kernel+bounces-45345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD1842ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B231F21E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABB279945;
	Tue, 30 Jan 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ecdLKN4K"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9B78B68;
	Tue, 30 Jan 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651214; cv=none; b=IZfwYGdWFXHzy2vlAKNEZmvZcUuFNwA1SEHvUIJOcf6lkAz9g/NS5AfKQvf1hZ2WRiTgllgDhRTceNIYuafNUKDwVF9gfzq/QZWNnnWCiUumJETbXuhVx08FmXzJwzGI6aYFXfrNfDD76iY1CVfUa95qbEOVOrpDgNOE4mO5d8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651214; c=relaxed/simple;
	bh=1Mf3wyu6a17R4DYnsbGVDf+ocPp2KC6e1ASfr1NJ06s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdafZrzcmc6mJp34KDVDpZHWf/hQmtG7/M5wN6cZtDE6849+HfXg04qCy0TGZ0pOyHfc4w7JgeCxzAakxYzPSr76VFGJjF2wrhyOMGKc04vSx2HpPs32JCBJacAi8T2BQ70yxAz2R5YQprYHXbNf7wQSBAjk2KqyHokwGaLFdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ecdLKN4K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULbNFx019671;
	Tue, 30 Jan 2024 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BP5fUK230w16aaAM9wCPXmpVSGviN/8Ei3dtKX9GF/U=;
 b=ecdLKN4KFm1+vzBc03WbzQOFXLe6UPt46fJ+NZ33iZLXSibNHtNSZd2/AHc+JrxlhRNk
 LBsEDt4N9omGj5LTqo8u47++2OiW55IARQnCu+3v2iBAARJ1WxcHs0EC+ptTdTLc+int
 y7swpLK/9/8oebssR3A+fe65k99S/eTa59NfkVkU1tsA097eK8YScIiW8LPbp6iMsr7a
 MkAbgDQL29+7yV/26g4z6aDyXjbAWbyohb4dsclvwPzwkhc77mTRcathqu+ivzfuVN87
 yOzaTap3D2hlzUyTlq8by8q1/BlgcsXm1v63vNQl7T+ON6NnC0ajuJ1UJxiYgKyynLXT Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy96br53d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULbUew019804;
	Tue, 30 Jan 2024 21:46:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy96br536-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UKMsFY007179;
	Tue, 30 Jan 2024 21:46:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev291rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkU3Z22610580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2549F5805D;
	Tue, 30 Jan 2024 21:46:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D8E858052;
	Tue, 30 Jan 2024 21:46:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 4/5] evm: Use the real inode's metadata to calculate metadata hash
Date: Tue, 30 Jan 2024 16:46:19 -0500
Message-ID: <20240130214620.3155380-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130214620.3155380-1-stefanb@linux.ibm.com>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7YY7tYmObqCtrkaZ9b0L-3LVS_G6t8iH
X-Proofpoint-GUID: k5R9ARI-UMjDdKRyjwX9gPNVBKEXQua2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300163

Changes to the file attribute (mode bits, uid, gid) on the lower layer
are not take into account when d_backing_inode() is used when a file is
accessed on the overlay layer and this file has not yet been copied up.
This is because d_backing_inode() does not return the real inode of the
lower layer but instead returns the backing inode which holds old file
attributes. When the old file attributes are used for calculating the
metadata hash then the expected hash is calculated and the file then
mistakenly passes signature verification. Therefore, use d_real_inode()
which returns the inode of the lower layer for as long as the file has
not been copied up and returns the upper layer's inode otherwise.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..2e48fe54e899 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 size_t req_xattr_value_len,
 				 uint8_t type, struct evm_digest *data)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_real_inode(dentry);
 	struct xattr_list *xattr;
 	struct shash_desc *desc;
 	size_t xattr_size = 0;
-- 
2.43.0


