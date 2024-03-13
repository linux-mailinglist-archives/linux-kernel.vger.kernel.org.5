Return-Path: <linux-kernel+bounces-102509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E043F87B315
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B41C21E84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43151C4F;
	Wed, 13 Mar 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQs2Medn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623191A38E8;
	Wed, 13 Mar 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363496; cv=none; b=d6X26yLNErsTDHs2ilVr9IZwTa+BanGLHQrPv2dEdq+b2T7PtRQGxokdDWj6PzsB+5JkmkdqcXbgzMhQVoEvk+P2FbPR78lzV5qnUC5TcK3a0bhQlBbQvP55SncCPdycs7BzszYFYASIPXD0v52s5qZBdouT+KwRI6A7XyQMbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363496; c=relaxed/simple;
	bh=alb5ymLAMq/qTYU6rhTwwfBGamSExk2vgHrexAkzTqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPIb+6ZzSp9NtSBz8ad2juE1hs4BkozHqt0cjWCBuFaqAMeTOKdoLT8BFKFG7eVuDbWR/sz2AIZ7J+0ioMa12C+GGwyuhFL/JzFpAQLHkbEvl4CaL7R+SsJyioSO63eZ4XT8Jb1lkeg608k5kNXPBGAEoOU97ma9Ysu05B5ugMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQs2Medn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DGraI4006974;
	Wed, 13 Mar 2024 20:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lC+CWytan5xtF4ASqrgCjXjedFAbcidykNFLvI1oAhg=;
 b=qQs2MednltN9YaejeK1qPNikKlXozuL0GLq9JHJPXeUI0IJLcU4w48Af7RsZALeiXnFo
 X79ugglpYQFpjfPv8fRNS9T1XT6I6Nl2+istc26TUGu4SVH6tAv7EKGOaGPw15oKD+XC
 i6qHjgpMFHLboJfUbexZfIYYH9dykVjs2L9GUpylLhaJQWPw928CUIacye+glJlPBHF9
 KKkkBrKHKJAJviTtViyhQ2A3XEhxZPtGwoEMQK+t45f/OparMNqQXVsoTfWrYbaHujsp
 EhEK4Yu55ssNiLkw8EkIf8yEday2TWN+WomRQ6qZfNaz2rgWK7nqWYzFY8ewO4qUlX5n aQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wug29k1p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DIMqai014861;
	Wed, 13 Mar 2024 20:58:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33p0gw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DKw8dj29950648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:58:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB3B65803F;
	Wed, 13 Mar 2024 20:58:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50BA058060;
	Wed, 13 Mar 2024 20:58:08 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.59.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 20:58:08 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v3 0/5] s390/vfio-ap: ap_config sysfs attribute for mdevctl automation
Date: Wed, 13 Mar 2024 16:58:02 -0400
Message-ID: <20240313205807.30554-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: klUTMC5yknQrCZXv9kR-Oi5d_jiQ6yBY
X-Proofpoint-GUID: klUTMC5yknQrCZXv9kR-Oi5d_jiQ6yBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130160

Mdevctl requires a way to atomically query and atomically update a vfio-ap
mdev's current state. This patch set creates the ap_config sysfs attribute.
This new attribute allows reading and writing an mdev's entire state in one go.
If a newly written state is invalid for any reason the entire state is rejected
and the target mdev remains unchanged.

Changelog
==========
v3
  - Optimization: hot unplug functions skip apcb update if nothing was actually
    unplugged.
  - Hot unplug functions modified to zero bitmaps before use.
  - Rename ap_matrix_length_check to ap_matrix_overflow_check
  - Fixed omissions and errors in several commit messages and the docs.
  - Added Tested-by tags.
v2
  - Rebased patched on top of latest master
  - Reworked code to fit changes introduced by f848cba767e59
      s390/vfio-ap: reset queues filtered from the guest's AP config
  - Moved docs changes to separate patch


Jason J. Herne (5):
  s390/ap: Externalize AP bus specific bitmap reading function
  s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
  s390/vfio-ap: Ignore duplicate link requests in
    vfio_ap_mdev_link_queue
  s390/vfio-ap: Add write support to sysfs attr ap_config
  docs: Update s390 vfio-ap doc for ap_config sysfs attribute

 Documentation/arch/s390/vfio-ap.rst   |  30 ++++
 drivers/s390/crypto/ap_bus.c          |  13 +-
 drivers/s390/crypto/ap_bus.h          |  22 +++
 drivers/s390/crypto/vfio_ap_ops.c     | 220 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 5 files changed, 262 insertions(+), 29 deletions(-)

-- 
2.41.0


