Return-Path: <linux-kernel+bounces-155544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D814E8AF3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7565B1F23966
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B813CF90;
	Tue, 23 Apr 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jSVYCH9u"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA413C9DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889103; cv=none; b=N3pt7ZpLKkRAlNi8eAb5Ri3jMk0xy2Lt5tJzGshy6hITZEQIrvXyHE5HasoqT89h2/ymqErNtLvzggvd96Lh0PYXQMoYfWUYeSWLInwOBkIQXLdVtObB4Pb1l8biw/mWntlGrR1TTlTJOIijaKmltYBMBlId5HOrYTONZNW1sS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889103; c=relaxed/simple;
	bh=P84qAECVDYJQCQnPbWsQ6NIevS3wLECwkMExEJRWMbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EunmD86vDwsIeTI2vK3dRn7F78eKXkMU4ue7de5rPJZkWb5Bn/8GXZ5g4L+bcNB9e7GU/kNWtlMwe/EDOf9BowoY50qSfXE/TpnNoekF76L30seJZkSIKzvBSlFxLqzSI7ShfsL8S3pFaxoaGo8iEJ+O1m4vL9AAKYeONJOJu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jSVYCH9u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFX7PF010583;
	Tue, 23 Apr 2024 16:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KmVzK3/IOcMdYj/fR7TyBM7S7meDOpjTYxXctq9rhZQ=;
 b=jSVYCH9uYU2w+qnUeRO/tZzMmnihXAoHQUR86+pehAhk1PpT5GUdVJO5c//fjvsdgUwt
 zkDlVep4HJYYnOrx65qJeSfkMaef1p0TjK+7bOD2wb6fok2NkPXHrV0p5hNDEO3+VBlJ
 b8vLJ+VV3ewfk1QmgQoS59khuRmz6HoWbGMJTKVxS8LeurD3R33vdLtFlhO/tsZKnfW+
 +q9lA88PAYz7ekwQIR8pBBhFrP4OtVtGm9Thchz9Vg4xKTcwjsEdfZfwYfsPwJraNxgr
 NN62kFUfuY4jYzTA55dWTaq86q32KKsT3n+zEAQf9CarYW/cwtd7cSucOwUXxPYVI/zu pQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpfqrg2t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:18:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43NF5xPs015299;
	Tue, 23 Apr 2024 16:18:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshm6e3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:18:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43NGI43V22938356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:18:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E556758059;
	Tue, 23 Apr 2024 16:18:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC9E5804B;
	Tue, 23 Apr 2024 16:18:04 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.133.34])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 16:18:04 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: i2cr: Reduce status checks for read operations
Date: Tue, 23 Apr 2024 11:18:02 -0500
Message-Id: <20240423161802.134089-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2dFiZv_uPi6oSvn_gODzW6Qz2bCE3BNI
X-Proofpoint-ORIG-GUID: 2dFiZv_uPi6oSvn_gODzW6Qz2bCE3BNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_13,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=994 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230037

As an optimization, only check the status register if the eight
byte i2c read operation returns 0xffffffffffffffff. This indicates
that the I2C Responder operation failed and the status register
will provide the reason. Otherwise, the operation was successful,
so no status check is necessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-i2cr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..9bb5c008995e 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -145,9 +145,11 @@ int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, u64 *data)
 	if (ret)
 		goto unlock;
 
-	ret = i2cr_check_status(i2cr->client);
-	if (ret)
-		goto unlock;
+	if (*data == 0xffffffffffffffffull) {
+		ret = i2cr_check_status(i2cr->client);
+		if (ret)
+			goto unlock;
+	}
 
 	trace_i2cr_read(i2cr->client, command, data);
 
-- 
2.39.3


