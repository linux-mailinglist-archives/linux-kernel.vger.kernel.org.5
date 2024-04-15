Return-Path: <linux-kernel+bounces-144429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588058A4653
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D57C1C2134A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FE4689;
	Mon, 15 Apr 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q5Yk8ckR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2656639;
	Mon, 15 Apr 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141051; cv=none; b=PnIMZXztH1VAcO135w2MSvZh0RIsKh3eawDyeBEeU9RACO0E2/yZOKmcgb7Hw53avGsfi9AofXOsOFsAom5wFrOmrV61I7J8VThlBKZU0SE5QuO5DN0LHYonfEQEebiTyB6NEYIjws7ZzeCmlNtF6GkOur7B+xMUSfxmfWqTua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141051; c=relaxed/simple;
	bh=Pgi1hwsPCRr/pQlWUI/3wnY7VDqsmkcVTLkE5C/Q39M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHJg55gobfqwOoJJo7FZQCryBCjPDwVhTElVHReJfX+HN81kdjUCZy+W8QlelxIOxLBHJ4SUS5on7el+biGXyPWmUy2NNHhrIJ1cVZTqtEoNn3NlFMfqJp0i70FCVA41zXQ/va3JYodcx5//BC4xIUfCv4K4OKnyWzJoppoECcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q5Yk8ckR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ENMhTF025010;
	Mon, 15 Apr 2024 00:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aMdpbtEpYPT6bd+qF7yWcmo2kxzAimZqE/KRKsEY2xg=;
 b=Q5Yk8ckRJgqsA23KYgD8vC8rm++LHVBlXr1yCjqnhCcbg4fhqK2qOhHuJUe1ssu4VZgy
 Ikjff0DP5nLn1csXu2cs72XplPScpYwMSNBRLPXt5+n3O61FIGvQ89D44BBxLo/Wjxbf
 2Re+aOZHthhCcp88xatYJHBSvyFk7K+EeRpl+QEmLFe1bPdjJ56DgTOkCUVVHOUTi9LQ
 jJHyrkynUhsqdKHwezXBhEjqjPwurB9zicCoJd5Vncc6oWzn6Wa5sI/AooDXFE0NMiUZ
 dCvjnswWX/bwjaslyDUVW4a63PRUwZOZuMxSkK17OpAnznQdyFxgcV48PpEdRh7BRQWZ Kw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfh2jjs1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43EMZud8015506;
	Mon, 15 Apr 2024 00:30:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vkvsyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F0Ud6J25690684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 00:30:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 323C658076;
	Mon, 15 Apr 2024 00:30:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7295958068;
	Mon, 15 Apr 2024 00:30:38 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 00:30:38 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/2] crypto: ecdh & ecc: Fix private key byte ordering issues
Date: Sun, 14 Apr 2024 20:30:24 -0400
Message-ID: <20240415003026.2661270-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vxLTvENMiQ79LmGBuq-5iGYIZ4DTVV8H
X-Proofpoint-ORIG-GUID: vxLTvENMiQ79LmGBuq-5iGYIZ4DTVV8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=882 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150001

The 1st patch fixes a byte ordering issue where ctx->private_key is
currently passed to ecc_is_key_valid but the key is in reverse byte order.
To solve this issue it introduces the variable 'priv' that is already used
throughout the ecc and ecdh code bases for a private key in proper byte
order and calls the function with 'priv'.

The 2nd patch gets rid of the 'priv' variable wherever it is used to hold
a private key (byte-swapped initialized from ctx->private_key) in proper
byte order and uses ctx->private_key directly that is now initialized in
proper byte order.

Regards,
  Stefan


Stefan Berger (2):
  crypto: ecdh - Pass private key in proper byte order to check valid
    key
  crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order

 crypto/ecc.c                  | 29 ++++++++++-------------------
 crypto/ecdh.c                 |  3 ++-
 include/crypto/internal/ecc.h |  3 ++-
 3 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.43.0


