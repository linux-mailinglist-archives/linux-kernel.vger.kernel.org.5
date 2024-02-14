Return-Path: <linux-kernel+bounces-65587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E218E854F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B4E283FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A960B9B;
	Wed, 14 Feb 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="P+CqP9w5"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77960B82;
	Wed, 14 Feb 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929407; cv=none; b=QYArbjpac5Z6rg6qOZEIJBmrS0K78rXV5SAANyZMDq2C5+AtGhYf3sSKA/m3dyNlDhbu2jMY/d5vGogpeqRTRAW7jZUxgXP/zp6VeQzx2GYKhiPk/Gv6MFubJ+PFia31tMjfpI/PhpgY3i8df/hPAYRitQeEw37copePu+PupDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929407; c=relaxed/simple;
	bh=HOZC01PQq8rBuWyBeTnoSddfhlHiRtr2b4wpwx3HJD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIRPGm/SU1fgU5dt58Dq4B/KFp53QYbtri0E6U7WOFVyQG+9KFrLMVl9tZ5r2vrU0NotsQo9bWg1gdo2TvDxxjCvD/vYLsWALC8zE8gsdHW53uUVeTL9qLVrV6lnIl31z2xu+TPQ3aomfOPDs6vH4F587B8YlEwiSZHRckLvMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=P+CqP9w5; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ECwChl022471;
	Wed, 14 Feb 2024 16:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=uUQXaD+jY9nKrOKDmz5mQd1YdDDb64hwD+4H9IsULmA=;
 b=P+CqP9w53TZ5uyUlvhVmRq5Hr0p3nIoxJeWfElaJc36OCePYsMS7CyQNmaywYAZcDHVj
 KOLGkw1iTIkjGGl61QQUOtRLra4UufcXZEuCMiL5bT8HeXy2RgTOm61YoJ/KPnyTJVF/
 AgFxcD80C0B20a/VvgNtGUpux4zssDzgec8R0qDlq83jvtut+08J0H8GY3rjylo/REpL
 9o4sExHFAERzRAhD0sZQdfAc+8pml+aQly8LOr0qJocCQDuUz2+zIm6FiMd0xGRmB7ds
 UTTb8uaPIoS1J5AVkaRXy8o0kEHvnfwUkYo/KiikWrJuz5NSGDm2jyDKoySaXsS7W+Vf vg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w8x07ar5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:49:50 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7EEB1130E0;
	Wed, 14 Feb 2024 16:49:47 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0BA7980BA28;
	Wed, 14 Feb 2024 16:49:46 +0000 (UTC)
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/1] watchdog/hpwdt: Support Suspend and Resume
Date: Wed, 14 Feb 2024 09:49:39 -0700
Message-ID: <20240214164941.630775-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -BbiD5eZnubeqUZt5yOfCE9AslqW666u
X-Proofpoint-ORIG-GUID: -BbiD5eZnubeqUZt5yOfCE9AslqW666u
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=579 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140131

Add suspend/resume support to hpwdt.

Changes from v1
---
1) dropped dev_dbg messages in suspend/resume.

2) switch from DEFINE_SIMPLE_DEV_PM_OPS  to LATE_SYSTEM_SLEEP_PM_OPS




Jerry Hoemann (1):
  watchdog/hpwdt: Support Suspend and Resume

 drivers/watchdog/hpwdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.43.0


