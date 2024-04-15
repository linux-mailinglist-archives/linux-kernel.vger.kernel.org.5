Return-Path: <linux-kernel+bounces-145450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92168A564E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741D2280D84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95378B50;
	Mon, 15 Apr 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cd0dzL0V"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5C763F8;
	Mon, 15 Apr 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194763; cv=none; b=aF1gJBakBnRD2Xm79WH2aOaPPlEkG2Twoa0tOInRZq+o8mZX/Ae+1kX+KOYzGZL8aABkW+nUB1+2m+8/Anxedn/OQ1pBk4IQ/DlAW3L/YQJSRVXM30zTShADMf05MpmkkrBTUFg85yPV+y+6wZZDrVZT+5XPapaXWZT4+ZtJ8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194763; c=relaxed/simple;
	bh=i9eQj7lhojYBRW0/0mk4jofZg3pf6CTqO67Fb5FswCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN9cxMgRa95Q9rSQfeQxeFT+PByJ7crPoEFqV7HIRKyzTC5yj3lZQ+LR9cGV99Nhum/N1ggKJsy8hj6m/TlBDMJ3OOIvWB7X0FGOz8kwWcz6k1Gs4QWJh5oTuY/regi40CjiR1E8Tik0fc+TQYdfc6npqX9EFKIxFJy07aMuqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cd0dzL0V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FFOW9w026050;
	Mon, 15 Apr 2024 15:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jk2jHuQVg21C6LLxh4Kt+xaPngk00G7rXooowfFRmBg=;
 b=cd0dzL0V6XvVCqq3Ob6HJUZjkEbAZ2ll2YQGDVSPM1aYaVxj07llIrMP9PyuGt/qZ1rt
 ys6xiE5hVoqoZ0HAqevBQ96tr2BRWbk3GEOrQOlxfVn1UkPL/pJdBGRABD3+ui/hz41o
 r4TV9Nx6jRMhKYS3DbfeMjGBGFu0P/e0GiYhfkVhtUEiFx7uyK2waqAkANOcTt45We5V
 HezGORRUrBgxe9An0P3Oytlmjb4WLv0glbOEqbvb+WphjyS7FLoo4xbcUD+IOxydvTX6
 lLiLA2zmkMZ/DM/0BojkBH9h7XV4YSrQOuKvOZJ33TvwEYNOW+V9LaADSSsvrV5wQmBi Qg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh4r0rafd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:25:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FD1GRb023575;
	Mon, 15 Apr 2024 15:25:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnrk8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:25:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFPu1N23593548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:25:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F26755805F;
	Mon, 15 Apr 2024 15:25:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61CFA58043;
	Mon, 15 Apr 2024 15:25:55 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.81.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:25:55 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v5 0/5] s390/vfio-ap: ap_config sysfs attribute for mdevctl automation
Date: Mon, 15 Apr 2024 11:25:50 -0400
Message-ID: <20240415152555.13152-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 89rZbfIgvzSkqUmp3bMiL9ciFq8W9C3L
X-Proofpoint-ORIG-GUID: 89rZbfIgvzSkqUmp3bMiL9ciFq8W9C3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150100

Mdevctl requires a way to atomically query and atomically update a vfio-ap
mdev's current state. This patch set creates the ap_config sysfs attribute.
This new attribute allows reading and writing an mdev's entire state in one go.
If a newly written state is invalid for any reason the entire state is rejected
and the target mdev remains unchanged.

Changelog
==========
v5
  - Replaced 'volatile' Wstringop-overread-warning workaround with a much
    nicer !null check in ap_matrix_copy
  - Fixed spacing & double assignment issues reported by checkpatch.pl --strict
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
 drivers/s390/crypto/vfio_ap_ops.c     | 224 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 5 files changed, 266 insertions(+), 29 deletions(-)

-- 
2.41.0


