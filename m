Return-Path: <linux-kernel+bounces-94675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C18742F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5901C2140D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F011C2A0;
	Wed,  6 Mar 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EuCUvYR8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B91B7E4;
	Wed,  6 Mar 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765292; cv=none; b=qcA/DlEb1ckWL3qPtyiOxhL5zIKxChe4B1Scv+4GaZ0Em45S/5alRi7ZLVmu55fuqQZMd64e3h26eBpLB7dbl60WkWzvYYYYqA61Dv4617wW7+t0GjPpXz9Pxxz66AgiZLSbaPSgS8ssmaOs7pKOa1qVqZZTQZnUYqB+LiE+sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765292; c=relaxed/simple;
	bh=8crutX9dpmo8bG+8UbYg4M3nXirj3AaUnPS+ao0lWvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cscDbYIQ30VaWFTsoTB1VJ4VjNFVWkkFxWosX1YIS2eHuXUbGFwLuHirWoNnmEeiWM/f++UDKWsotvLDtrn0QSVXIfBwPa97gFJ+LuuDbuJyhNlFfAdDhWbPMIxW2fjga0wE7QiO4xSJ9OBxKvaayWmRM9axAfFOMP79zvgODd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EuCUvYR8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426MS7cD014098;
	Wed, 6 Mar 2024 22:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dqz8s/tDay0NtoWCi/zHFHzJNonemDZUejLfpG+e+DU=;
 b=EuCUvYR8U9SmV6NjNVOMzqc+0PucKeEuaAeCasSeQOV6GRhrGfRHMGSFSHByNUxSb6ul
 IOA63fKqbLMuoAN/A9++nGp6kXykbstjE/duiHHL/hJaVksFX2MseU2e+JvKA6WEg0mW
 vVLfakRyNeElzRArvdxJ9MllCiwSB2fQtJNVIC00QO8mC0jsOpfrv6Fpo8Cy26FD26mN
 Y93JlysQJTZz8A01lHJOEMYktCduBwFZTp9G7z2jTZBa1pdTkkSSnqG5LUyYUFhXLqTq
 ay8GfvJPWFnnyoRVXNcH+sCC+XVDOQqU4KuLgcUo2hptghQdrPBjpsmlTLwFJ3u0JfFP eQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq1a98dkx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:48:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426KgrSh010913;
	Wed, 6 Mar 2024 22:23:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52h7xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN3FA43057604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE1B58062;
	Wed,  6 Mar 2024 22:23:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D2A58061;
	Wed,  6 Mar 2024 22:23:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 02/12] crypto: ecdsa - Adjust tests on length of key parameters
Date: Wed,  6 Mar 2024 17:22:47 -0500
Message-ID: <20240306222257.979304-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306222257.979304-1-stefanb@linux.ibm.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WxKmyU7IWKALJ9c5QIQomlhNFxziGRSv
X-Proofpoint-GUID: WxKmyU7IWKALJ9c5QIQomlhNFxziGRSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060183

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameters to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each fully require 'full' digits (= u64), unlike
NIST P192/256/384 that all require multiple 'full' digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 6653dec17327..64e1e69d53ba 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	if (ret < 0)
 		return ret;
 
-	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
+	if (keylen < 1 || ((keylen - 1) & 1) != 0)
 		return -EINVAL;
 	/* we only accept uncompressed format indicated by '4' */
 	if (d[0] != 4)
-- 
2.43.0


