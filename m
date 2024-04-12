Return-Path: <linux-kernel+bounces-142786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679928A3018
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6963B235A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C22126F1B;
	Fri, 12 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pw5qvUiD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC68626E;
	Fri, 12 Apr 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930505; cv=none; b=BCPK5vNjaorWJrrqcdUeEF8DBbDsl7IZTZLykRTok/OOMCuWiZsK6HieVCS1o9P/imOioOO9kBhzakDYh92a/zMLSZg1guUfnkqptSjcPAz5xya+45zHDSp7ZlG3I3ZdgdHS4mOVX/eti+4l6X/KIVloJu1KnX/SBL8yHJpJ3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930505; c=relaxed/simple;
	bh=0ju2OjjZJc4T+HUfUywOCKasDrgbe1ae+klsXdI57bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSmBBy6WIXOk9OD95xHDoN7KYxyy+DQ5avkuCJaS/TxGtOVYoUxDCMWFXrBjBKF7fNQyLm5LD1mnZ2TcCbcxEX+5cMOAl7G8CMhqJ4rbztqclv/xko/WGJtq3GKcN2tHYG8e9gGTdlX+tmQITw46jWtYBPNBCqngPO1CSGHGAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pw5qvUiD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CE0g57000764;
	Fri, 12 Apr 2024 14:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=P9fBnmlXwY43CvP9wtUDIhcltSi6G92Izqd1cqRnAw8=;
 b=Pw5qvUiDM+LsGpOmAzKPthMIZcfi2g6qtQ6oQuav5dzh27gnGWduSQ5MQUgYJxRwMos+
 FHfaO8exMGa8WrB0TKBWk2p6Rda/gvOrLm9FuqVCcB7zOvpxVtRiTOjyA+1TiYTR8sG6
 7gGUsS69cL/HuaFJtaFeNoRXSaLVWebzc4G7RUyQa8pHjCgJkzEkw0FsrUbUYN14iXBN
 xNgoInkKfE+HUkR1NraNp0p0L934jV3kKiDKa62qqdwszNLkpZttUW47ZL1b4ggd1BLw
 glMqyOE2AB0P006n8y45h4lg01muZVlD2znJtjRZMN/XLwIpntmv5V/zgAeJGWGDNsM/ yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5b4g4ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CE1Ziv001971;
	Fri, 12 Apr 2024 14:01:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5b4g4sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAlDCP022627;
	Fri, 12 Apr 2024 14:01:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqpj768-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CE1U3B56099292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:01:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9BA35807E;
	Fri, 12 Apr 2024 14:01:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60DD558060;
	Fri, 12 Apr 2024 14:01:28 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 14:01:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC 0/2] ima: Fix detection of read/write violations on stacked filesystems
Date: Fri, 12 Apr 2024 10:01:20 -0400
Message-ID: <20240412140122.2607743-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFkyUhI_LoXXRb5Bdig_y7sHvvMi5UQ_
X-Proofpoint-GUID: wmwLbrEvujHh0AEYnsqEhFxg5brOExWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=663 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120101

This series fixes the detection of read/write violations on stacked
filesystems. To be able to access the relevant dentries necessary to
detect files opened for writing on a stacked filesystem a new d_real_type
D_REAL_FILEDATA is introduced that allows callers to access all relevant
files involved in a stacked filesystem.

  Stefan

Stefan Berger (2):
  ovl: Define D_REAL_FILEDATA for d_real to return dentry with data
  ima: Fix detection of read/write violations on stacked filesystems

 fs/overlayfs/super.c              |  6 ++++++
 include/linux/dcache.h            |  1 +
 security/integrity/ima/ima_main.c | 27 ++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.43.0


