Return-Path: <linux-kernel+bounces-94020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CF873886
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3A61C20F24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5D133993;
	Wed,  6 Mar 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NoRK5Vms"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADF133408;
	Wed,  6 Mar 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734131; cv=none; b=UNdJ3oUhdF5o4TZl24AcTSwvVv5MA/RovOrkk1wKvqn50GBmIAfIl/homM1Tb0dCEXl0NdrJctqrVuE+65hKZc3kbBuJOwaFKBTga+yu64rsotjRyy+xYKvwgafCrHDNfFCn9pwBP/DGzEHEmeoqmdcYeIOkxO/9zbcpMp2Pfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734131; c=relaxed/simple;
	bh=rQQprYlvCLY+uWlXs27IWcw5ML66a9FSDvv4EotIk4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDAgGtylAZZ/7Swe6TH2fJpIKXzX+oUN2jyozDdaACfpF4Y7f8MuKkDI9rAhLxeVoR4s1OUfDhVQFJ2BY6LhmDA5+bAq+1+WvnXIdtwqOU0QAYB2tqJv6hfD83wxtFzSYO8ELr3xxLtDAvnElguis8Z+zK5SxQFmkU+MnVTXXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NoRK5Vms; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426E2IoD026691;
	Wed, 6 Mar 2024 14:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vSa5NR8/68M2tBeNu9nV4un6LsWPbo2+W5p6FaoDmvE=;
 b=NoRK5VmsI6V/ySsVki+/AneRAbpY7xMFa0/8felElbR6X8QVPe0hBZ9b8IHjveMwKTbr
 593vL39lQvJD7INvfdrnlgBOBzN031GHvCarCi+srnoKQ6zp7RnNbI3vYzaIfDEcuE9D
 +oZsoU1xkhsWgkP7PHklBpZD9lfcqXsgLwlTsiGCMq0XNJJPyFcXlwBff6RjHDnH0xL7
 qAirieI2zJ+ttWONiYbZgtuRJ62kvAfN/0oP30D6MFTu5u1n3WFlHHgi/jB3vs7UaUF8
 Uh7+co9NGyz0/8ruuUnKS2PhGtKuMJzYqNDfW6syABsGeS0so3BlIk5EAPwCkE/AtJAu qA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsw30cyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426CCtR5006045;
	Wed, 6 Mar 2024 14:08:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet7b28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426E8igu47448560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:08:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F87258052;
	Wed,  6 Mar 2024 14:08:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA99C58070;
	Wed,  6 Mar 2024 14:08:43 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.164.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:08:43 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v2 0/5] s390/vfio-ap: queue_configuration sysfs attribute for mdevctl automation
Date: Wed,  6 Mar 2024 09:08:38 -0500
Message-ID: <20240306140843.10782-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SCFIm59sZEgB6Jw2rCIa-t5HuSh8qbHs
X-Proofpoint-ORIG-GUID: SCFIm59sZEgB6Jw2rCIa-t5HuSh8qbHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060113

Mdevctl requires a way to atomically query and atomically update a vfio-ap
mdev's current state. This patch set creates the queue_configuration sysfs
attribute.  This new attribute allows reading and writing an mdev's entire
state in one go. If a newly written state is invalid for any reason the entire
state is rejected and the target mdev remains unchanged.

Changelog
==========
v2
  - Rebased patched on top of latest master
  - Reworked code to fit changes introduced by f848cba767e59
      s390/vfio-ap: reset queues filtered from the guest's AP config
  - Moved docs changes to separate patch

Jason J. Herne (5):
  s390/ap: Externalize AP bus specific bitmap reading function
  s390/vfio-ap: Add sysfs attr, queue_configuration, to export mdev
    state
  s390/vfio-ap: Ignore duplicate link requests in
    vfio_ap_mdev_link_queue
  s390/vfio-ap: Add write support to sysfs attr ap_config
  s390: doc: Update doc

 Documentation/arch/s390/vfio-ap.rst   |  27 ++++
 drivers/s390/crypto/ap_bus.c          |  13 +-
 drivers/s390/crypto/ap_bus.h          |  22 +++
 drivers/s390/crypto/vfio_ap_ops.c     | 206 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 5 files changed, 245 insertions(+), 29 deletions(-)

-- 
2.41.0


