Return-Path: <linux-kernel+bounces-50181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B0847569
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449C3B2DBAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAF14A4D9;
	Fri,  2 Feb 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MUTu1QGJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8214A4C3;
	Fri,  2 Feb 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892759; cv=none; b=aWIUStLF3885wEjiNHH6r7yRew9OKyfEiflXLussZqpMELEhnbaCXKWw7kdHEGlG6mNUxL8K8HKgYaI9Dp7H7Q4giPv/Y6qU9YdeDJvPcm5eOfCTyhCHfTvwDB6VyKDwbcoUkOlmQPHlmhuB2EQAe8bAedflLB6EVl1vOAKDlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892759; c=relaxed/simple;
	bh=YhZYOEt/Mhq5UOiR24gxD3SphpDnqDkRm98hcjeYxHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/5TH4EfwOUIlKqNJf1L9TCpuxOtAuRSgilYZ4XVyfcKuG6HxOjSU3sVlpc72Xwr2froptx5W0QPc44eMWTzjx+zF4WZSyTYCT0EadhXIpVDRfRWSwq41vOyKhJCWqoiujRLLH6PAq0KDAojvIj4BVXzfEvvGd3It0cTayW1bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MUTu1QGJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412DjtRg015707;
	Fri, 2 Feb 2024 16:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=mfoB8ip
	fy0L6OloPCbkGz5gD4ZpAk/e1jBDItP4Z7sE=; b=MUTu1QGJqk3zZdN8AIVKUtE
	mFcQWxkLVJFTvhDfzpIzuV0U/Z7WaRwJ4HLOwDIto12izImUD/X9LEYrcblH2mhA
	STql53jX9YK9R3VJ6s+KGrBTlxL373f/LFCzCTwP5DzLkk3xf8m+TQHzjr9Sal6s
	Kye2eU8cdsPZvBhbk3IQpc3M5/OhjHapoKBDmtl+X8Mm5jHf4msWO0Ui1FXivxGS
	qKCiGY0s+y/EfEWYZv5Kr/vhZ+1/DHzZvbdU++32+AGqCy0shsXRK6Zp6wjla2Rz
	fpsQFp39SRqjffq7oaiN6W5DM3qEsshMVFZ36ybL3PcPYmOuuo+jdjwOhtRxShg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwjhws5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:52:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412GqNLP014387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 16:52:23 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 08:52:22 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <quic_stummala@quicinc.com>,
        <quic_bjorande@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] f2fs: doc: Fix bouncing email address for Sahitya Tummala
Date: Fri, 2 Feb 2024 09:52:08 -0700
Message-ID: <20240202165208.4091800-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6-HTTPrKvZyBZbc5_9FVnicmaTolsfVZ
X-Proofpoint-ORIG-GUID: 6-HTTPrKvZyBZbc5_9FVnicmaTolsfVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=452
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020121

The servers for the @codeaurora domain are long retired and any messages
addressed there will bounce.  Sahitya Tummala has a .mailmap entry to an
updated address, but the documentation files still list @codeaurora
which might be a problem for anyone reading the documentation directly.
Update the documentation files to match the .mailmap update.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 48c135e24eb5..22d070c0de40 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -205,7 +205,7 @@ Description:	Controls the idle timing of system, if there is no FS operation
 What:		/sys/fs/f2fs/<disk>/discard_idle_interval
 Date:		September 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
+Contact:	"Sahitya Tummala" <quic_stummala@quicinc.com>
 Description:	Controls the idle timing of discard thread given
 		this time interval.
 		Default is 5 secs.
@@ -213,7 +213,7 @@ Description:	Controls the idle timing of discard thread given
 What:		/sys/fs/f2fs/<disk>/gc_idle_interval
 Date:		September 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
+Contact:	"Sahitya Tummala" <quic_stummala@quicinc.com>
 Description:    Controls the idle timing for gc path. Set to 5 seconds by default.
 
 What:		/sys/fs/f2fs/<disk>/iostat_enable
-- 
2.34.1


