Return-Path: <linux-kernel+bounces-107627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368D87FF57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E4B219F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46C81748;
	Tue, 19 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GEGs+LCz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C881721;
	Tue, 19 Mar 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857564; cv=none; b=F2KQQs/zqVv36k9eU/lndlUQmtvqcetjoAsj1PHEBikNW7vBfO2cRuaFB8O1sK7FdhG39YeKop88kiATabAH+a/QAMqo9x2MMkPLmIVf5t15c4YExABgtsUY/TTOA+Ko6KPLNoJUQ8aNOdMKPn2Bp2/rRC5j+kSEEpIkFGDFzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857564; c=relaxed/simple;
	bh=Abt9mI7mwwBB9jZu3TI9gYIRdAPLvtQ5Dl+cfVtjSlM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CxHL1/xfN06U77uVzzwale5MkOmXREFZACXHaBpBbrMwgoXIClc3OVIBFx6ny2oeaLyxIV+OmcBO/+hht26Q1syF2TQQIUXiS/bvjFvnkwvbwcP4gsIK9OZ7feUntkJiCL03qFF9nZxUsB2/5rin8AiKqhkKHs4yQa8Yov0l4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GEGs+LCz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDZTTE008822;
	Tue, 19 Mar 2024 14:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=Dw26mjNf1fPILZJGOMpSeRxWsmkXg9zk8OeDZ4EQGh0=;
 b=GEGs+LCzNUjJvyc5j1Vm9pV1Ion6vh1pv/WLDpaYR91eqiKDa6DMfRRqNLTR7cj6VTK4
 q/bB4Oges7HRJT/pwzdvcETJsZtYLmKxa24hEUUFsjU2hHOpGSy8nHOfKQg1MyN5slcV
 R2d1e7cdbmyePPdYCDpbcMQ2tRUONugS4Ao25TagmZKIlo6TN9TVkFguD+tBoob5NBiG
 2IrbUBUbSVFEQ0BPrXzTN6W9s/kgIukqqPiT5eTT6PD/4pybujHinjbTIeq6WAicrE5c
 a9nvZ9LzfA4iqL9o7AwXQCmJ5/65ZqJZfmklc6qs8WXVD9wVyREwnARpEXdlEkWF16MU bg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyb39rk9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 14:12:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JCdQlQ002824;
	Tue, 19 Mar 2024 14:12:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2fjka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 14:12:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JECWYl9896264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 14:12:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8927E2004E;
	Tue, 19 Mar 2024 14:12:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F2B02004D;
	Tue, 19 Mar 2024 14:12:32 +0000 (GMT)
Received: from osiris (unknown [9.171.33.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 14:12:32 +0000 (GMT)
Date: Tue, 19 Mar 2024 15:12:30 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.9 merge window
Message-ID: <20240319141230.23303-F-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nj1aD9EoQVC2I0db5JdZWBU6Y_eqqlVJ
X-Proofpoint-ORIG-GUID: nj1aD9EoQVC2I0db5JdZWBU6Y_eqqlVJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxlogscore=583 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190107

Hi Linus,

please pull more s390 updates for the 6.9 merge window.

Thanks,
Heiko

The following changes since commit b0546776ad3f332e215cebc0b063ba4351971cca:

  Merge tag 'printk-for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux (2024-03-12 20:54:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-2

for you to fetch changes up to 64c3431808bdab2ccef97d7a444018c416b080b5:

  s390/entry: compare gmap asce to determine guest/host fault (2024-03-17 19:08:50 +0100)

----------------------------------------------------------------
more s390 updates for 6.9 merge window

- Various virtual vs physical address usage fixes

- Add new bitwise types and helper functions and use them in s390 specific
  drivers and code to make it easier to find virtual vs physical address
  usage bugs. Right now virtual and physical addresses are identical for
  s390, except for module, vmalloc, and similar areas. This will be
  changed, hopefully with the next merge window, so that e.g. the kernel
  image and modules will be located close to each other, allowing for
  direct branches and also for some other simplifications.

  As a prerequisite this requires to fix all misuses of virtual and
  physical addresses. As it turned out people are so used to the concept
  that virtual and physical addresses are the same, that new bugs got added
  to code which was already fixed. In order to avoid that even more code
  gets merged which adds such bugs add and use new bitwise types, so that
  sparse can be used to find such usage bugs.

  Most likely the new types can go away again after some time

- Provide a simple ARCH_HAS_DEBUG_VIRTUAL implementation

- Fix kprobe branch handling: if an out-of-line single stepped relative
  branch instruction has a target address within a certain address area in
  the entry code, the program check handler may incorrectly execute cleanup
  code as if KVM code was executed, leading to crashes

- Fix reference counting of zcrypt card objects

- Various other small fixes and cleanups

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/sysinfo: allow response buffer in normal memory
      s390/iucv: fix receive buffer virtual vs physical address confusion

Andy Shevchenko (1):
      s390/cio: use while (i--) pattern to clean up

Gerald Schaefer (1):
      s390/dcssblk: fix virtual vs physical address confusion

Halil Pasic (4):
      s390/cio: introduce bitwise dma types and helper functions
      s390/virtio_ccw: fix virtual vs physical address confusion
      s390/virtio_ccw: use DMA handle from DMA API
      s390/virtio_ccw: avoid converting dma addresses / handles

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Heiko Carstens (22):
      s390/dasd_eckd: fix virtual vs physical address confusion
      s390/cio: fix virtual vs physical address confusion
      s390/vfio_ccw: fix virtual vs physical address confusion
      s390/cio: use bitwise types to allow for type checking
      s390/dasd: remove superfluous virt_to_phys() conversion
      s390/dasd: use new address translation helpers
      s390/cio,idal: code cleanup
      s390/cio,idal: remove superfluous virt_to_phys() conversion
      s390/cio,idal: fix virtual vs physical address confusion
      s390/cio: use new address translation helpers
      s390/scm: use new address translation helpers
      s390/vmur: use new address translation helpers
      s390/3215: use new address translation helpers
      s390/3270: use new address translation helpers
      s390/tape: fix virtual vs physical address confusion
      s390/zfcp: use new address translation helpers
      s390/qeth: use new address translation helpers
      s390/lcs: use new address translation helpers
      s390/ctcm: use new address translation helpers
      s390/iucv: use new address translation helpers
      s390/vfio_ccw_cp: use new address translation helpers
      s390/mm: provide simple ARCH_HAS_DEBUG_VIRTUAL support

Mete Durlu (1):
      s390/vtime: fix average steal time calculation

Ricardo B. Marliere (6):
      s390/zcrypt: make zcrypt_class constant
      s390/vmur: make vmur_class constant
      s390/vmlogrdr: make vmlogrdr_class constant
      s390/tape: make tape_class constant
      s390/raw3270: improve raw3270_init() readability
      s390/raw3270: make class3270 constant

Sven Schnelle (3):
      s390/entry: add CIF_SIE flag and remove sie64a() address check
      s390/entry: remove OUTSIDE macro
      s390/entry: compare gmap asce to determine guest/host fault

 arch/s390/Kconfig                  |   1 +
 arch/s390/Makefile                 |   1 +
 arch/s390/configs/debug_defconfig  |   1 +
 arch/s390/include/asm/ccwdev.h     |   3 +-
 arch/s390/include/asm/cio.h        |   9 +-
 arch/s390/include/asm/dma-types.h  | 103 ++++++++++++++++++++++
 arch/s390/include/asm/eadm.h       |   5 +-
 arch/s390/include/asm/fcx.h        |  13 +--
 arch/s390/include/asm/idals.h      | 176 ++++++++++++++++++++-----------------
 arch/s390/include/asm/page.h       |  30 ++++++-
 arch/s390/include/asm/processor.h  |   2 +
 arch/s390/include/asm/ptrace.h     |   2 -
 arch/s390/include/asm/qdio.h       |  17 ++--
 arch/s390/include/asm/scsw.h       |   7 +-
 arch/s390/kernel/entry.S           |  73 +++++++--------
 arch/s390/kernel/sysinfo.c         |   2 +-
 arch/s390/kernel/vtime.c           |   4 +-
 arch/s390/mm/Makefile              |   1 +
 arch/s390/mm/fault.c               |   4 +-
 arch/s390/mm/physaddr.c            |  15 ++++
 drivers/s390/block/dasd.c          |   4 +-
 drivers/s390/block/dasd_3990_erp.c |  14 +--
 drivers/s390/block/dasd_alias.c    |   6 +-
 drivers/s390/block/dasd_eckd.c     | 118 ++++++++++++-------------
 drivers/s390/block/dasd_eer.c      |   2 +-
 drivers/s390/block/dasd_fba.c      |  32 +++----
 drivers/s390/block/dcssblk.c       |   2 +-
 drivers/s390/block/scm_blk.c       |   6 +-
 drivers/s390/char/con3215.c        |   4 +-
 drivers/s390/char/fs3270.c         |  14 +--
 drivers/s390/char/raw3270.c        |  42 +++++----
 drivers/s390/char/raw3270.h        |   2 +-
 drivers/s390/char/tape.h           |  12 ++-
 drivers/s390/char/tape_class.c     |  17 ++--
 drivers/s390/char/vmlogrdr.c       |  18 ++--
 drivers/s390/char/vmur.c           |  22 ++---
 drivers/s390/cio/ccwgroup.c        |   4 +-
 drivers/s390/cio/chsc.c            |  12 +--
 drivers/s390/cio/chsc.h            |   6 +-
 drivers/s390/cio/cio.c             |   4 +-
 drivers/s390/cio/css.c             |  25 ++++--
 drivers/s390/cio/device_fsm.c      |   8 +-
 drivers/s390/cio/device_id.c       |   2 +-
 drivers/s390/cio/device_ops.c      |   5 +-
 drivers/s390/cio/device_pgid.c     |   8 +-
 drivers/s390/cio/device_status.c   |   2 +-
 drivers/s390/cio/eadm_sch.c        |   4 +-
 drivers/s390/cio/fcx.c             |  22 ++---
 drivers/s390/cio/orb.h             |   9 +-
 drivers/s390/cio/qdio_main.c       |  12 +--
 drivers/s390/cio/qdio_setup.c      |  10 +--
 drivers/s390/cio/qdio_thinint.c    |   6 +-
 drivers/s390/cio/vfio_ccw_cp.c     |  82 +++++++++--------
 drivers/s390/cio/vfio_ccw_fsm.c    |   2 +-
 drivers/s390/crypto/zcrypt_api.c   |  39 ++++----
 drivers/s390/net/ctcm_fsms.c       |   4 +-
 drivers/s390/net/ctcm_main.c       |   2 +-
 drivers/s390/net/ctcm_mpc.c        |  20 ++---
 drivers/s390/net/lcs.c             |  12 ++-
 drivers/s390/net/qeth_core_main.c  |  24 ++---
 drivers/s390/scsi/zfcp_fsf.c       |   2 +-
 drivers/s390/scsi/zfcp_qdio.c      |   4 +-
 drivers/s390/scsi/zfcp_qdio.h      |   6 +-
 drivers/s390/virtio/virtio_ccw.c   | 170 +++++++++++++++++++++--------------
 include/net/iucv/iucv.h            |   3 +-
 net/iucv/af_iucv.c                 |   8 +-
 net/iucv/iucv.c                    |  23 +++--
 67 files changed, 771 insertions(+), 553 deletions(-)
 create mode 100644 arch/s390/include/asm/dma-types.h
 create mode 100644 arch/s390/mm/physaddr.c

