Return-Path: <linux-kernel+bounces-119498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E088C9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B71C35F98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4C1B28D;
	Tue, 26 Mar 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JpRuerEy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D2171BB;
	Tue, 26 Mar 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471634; cv=none; b=b4voxtdjUGWNM83WwZ3S00X2IiUa0GoL5Npfl2jNUE2NyIlz+itdQg2McF7Yu+NU6rXVtokbjRmS+VBK5MaK3VJWwLU2cVJBtqr8qOmpifroJz7EjGvx8OigxnsL8jq34kpaYhZL1b+21w7A99rJnmWCHd+L7OpdorqxNy3YAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471634; c=relaxed/simple;
	bh=6Eo8sbBCsTIOsqtWpeUEJH4e+dWSjjhypeZcHq7Rq34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlD9w+RZZrgFUWMQ4nJioqkBwuZJCTraN4kAqAUmoQXu+h06L4MIaPfkRmgClTtw8MTqW3FDF1b226SrUdnfkAjkD6yYGGQa9mQvtfjO+wfhNw5yMJ7ZXr7vyK8lh5sOV6VLp2SGYp3awMbyEq+hZWKHwgKgQG8eSMzpLWPZkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JpRuerEy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGC2Hg030711;
	Tue, 26 Mar 2024 16:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jdUDBXXO6CtxPgyr7SyT7bSHHP781nwRUdVJEqC06gQ=;
 b=JpRuerEyxDtJ5+jfVF1S07WqRmvOSl2cGq+9rYzfv9ZYg9Ztg1O0/eLG4/CTwarnkStM
 008NYZ7TRNE6jdrqoePo9oRlFsv0qCXzYKRhz6rf8Tof4+T9jkBdv5wM4j60SjpwcepH
 VZWHKy280l3p25XmYmHknSIDpyBZFHZCll46dISJYT+cueuXD6clGUme3S60PhvXiywW
 90v0qOngR1lvhUL34UypkuLTQQzQPDAt2+r7k2cYz77fMLGArWRBMZrcNWIUKnJDAMKI
 syzUKBpyVErg0oQvuoJyY8hsfphq8Lr8E2ZZmfzGh0iDo+NgjfhfuAt39NeobWXSnHVJ Zg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x41d405hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QFoZND028685;
	Tue, 26 Mar 2024 16:47:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp8wak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QGl71w47579708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:47:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5522E5805D;
	Tue, 26 Mar 2024 16:47:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC58558057;
	Tue, 26 Mar 2024 16:47:06 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.173.44])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 16:47:06 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 0/5] s390/vfio-ap: ap_config sysfs attribute for mdevctl automation
Date: Tue, 26 Mar 2024 12:47:01 -0400
Message-ID: <20240326164706.29167-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: huQ7NphKJF9pKO4xh76z1OPh928E6OcH
X-Proofpoint-ORIG-GUID: huQ7NphKJF9pKO4xh76z1OPh928E6OcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260119

Mdevctl requires a way to atomically query and atomically update a vfio-ap
mdev's current state. This patch set creates the ap_config sysfs attribute.
This new attribute allows reading and writing an mdev's entire state in one go.
If a newly written state is invalid for any reason the entire state is rejected
and the target mdev remains unchanged.

Changelog
==========
v4
  - Added volatile cast to fixup false positive gcc warning: 
    Wstringop-overread-warning
  - Added new Reviewed-By tags
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
 drivers/s390/crypto/vfio_ap_ops.c     | 223 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 5 files changed, 265 insertions(+), 29 deletions(-)

-- 
2.41.0


