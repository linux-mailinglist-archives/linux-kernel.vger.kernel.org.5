Return-Path: <linux-kernel+bounces-30486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA50831F51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F402287C67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02E2E3F5;
	Thu, 18 Jan 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J632SUpA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4C2E3F0;
	Thu, 18 Jan 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603942; cv=none; b=M/cOO8GOHDD3e9tm2l6agV9Hdcfm4HBv1wKv7ADlluS0ouhyEDNQJL6sBREOHhtjm/vfAUGWfnBYJLdDqXZ/yLDoqMRf4A9FxUQMMXnxX1Xr7+IjAUJsDh0pR9BHJUQxQeI3Bqq5/wiQeQkZaaP2YgklBxdg1Ib4R8wGJsQXgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603942; c=relaxed/simple;
	bh=e7rUhfjK9D2qn3KT09M/crDYpGeu7StODsXc+xtSWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Wsk0gC5GUlLAcAJEOps1IGlYbBWPcT+DDm3FfkwBwa+MSEIahcfgdjCaW0W/GMXKrTbAiowMS9caz7fBquYnelqvRBgw/IyIcHkppKcoGkdB9c+AFUjJb0RHhPY8yQxUutBnZ36p3J2KWqbUeoBlvtR/aAsbu2Q5NiemqCOokSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J632SUpA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IIW9Bn001724;
	Thu, 18 Jan 2024 18:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=XKytDmVHl5QJMXVuS8Locw92XTZUZYcapYVZPIVOR7s=;
 b=J632SUpAFyv+0LQ9gUdR7eeIdWdTI1UzUl/tnCaEcA+ZamWj8pmCKcV13Qtknf2PsO/h
 rXcVZYozuoxjXQgFSmyuxYBugBMXqJ/RkK6NScmRKx8811/1uXRqwt9EbOT7MbarWxkk
 2QUHRuHZR3SWKWENYUMEzJ7F/kYwOsyuejOumgAqTMMDp3pP840mbfw7NZ8W3EXJxrXr
 dvcyicbDEMENU/PXMwR0BC38sc06rSEQFeMn+iILleEa8ENe5GDGbXZ6tl3Z1NLXsm+X
 aLQkrv8m1nje2AqTNGnjprFVYpHAIAxI3i9x9a/Bf1vhgJ/XwYElYcPlSk3F0bNmvohn QA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq90e14d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 18:52:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40IHB2BU009413;
	Thu, 18 Jan 2024 18:52:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5unw4f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 18:52:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40IIqEO530736876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 18:52:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DAA920043;
	Thu, 18 Jan 2024 18:52:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05B4620040;
	Thu, 18 Jan 2024 18:52:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jan 2024 18:52:13 +0000 (GMT)
Date: Thu, 18 Jan 2024 19:52:12 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for the 6.8 merge window part 2
Message-ID: <ZalzXHWvCd8axzDj@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qeSK6t6zXpAVFLqXQ05TIKz2qBUuwgUe
X-Proofpoint-ORIG-GUID: qeSK6t6zXpAVFLqXQ05TIKz2qBUuwgUe
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=906 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180137

Hello Linus,

Please pull s390 changes for 6.8 merge window part 2.

Thank you,
Alexander

The following changes since commit de927f6c0b07d9e698416c5b287c521b07694cac:

  Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2024-01-10 18:18:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-2

for you to fetch changes up to b9bd10c43456d16abd97b717446f51afb3b88411:

  s390/vfio-ap: do not reset queue removed from host config (2024-01-17 13:53:06 +0100)

----------------------------------------------------------------
s390 updates for 6.8 merge window part 2

- do not enable by default the support of 31-bit Enterprise Systems
  Architecture (ESA) ELF binaries

- drop automatic CONFIG_KEXEC selection, while set CONFIG_KEXEC=y
  explicitly for defconfig and debug_defconfig only

- fix zpci_get_max_io_size() to allow PCI block stores where
  normal PCI stores were used otherwise

- remove unneeded tsk variable in do_exception() fault handler

- __load_fpu_regs() is only called from the core kernel code.
  Therefore, remove not needed EXPORT_SYMBOL.

- remove leftover comment from s390_fpregs_set() callback

- few cleanups to Processor Activity Instrumentation (PAI) code
  (which perf framework is based on)

- replace Wenjia Zhang with Thorsten Winkler as s390 Inter-User
  Communication Vehicle (IUCV) networking maintainer

- Fix all scenarios where queues previously removed from a guest's
  Adjunct-Processor (AP) configuration do not re-appear in a reset
  state when they are subsequently made available to a guest again

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/kexec: do not automatically select KEXEC option

Alexandra Winter (1):
      s390/net: add Thorsten Winkler as maintainer

Heiko Carstens (4):
      s390/compat: change default for CONFIG_COMPAT to "n"
      s390/mm,fault: remove not needed tsk variable
      s390/fpu: remove __load_fpu_regs() export
      s390/ptrace: remove leftover comment

Niklas Schnelle (1):
      s390/pci: fix max size calculation in zpci_memcpy_toio()

Thomas Richter (5):
      s390/pai: rework paixxxx_getctr interface
      s390/pai_crypto: split function paicrypt_push_sample
      s390/pai: rework paiXXX_start and paiXXX_stop functions
      s390/pai_ext: rework function paiext_copy argments
      s390/pai_ext: split function paiext_push_sample

Tony Krowiak (6):
      s390/vfio-ap: always filter entire AP matrix
      s390/vfio-ap: loop over the shadow APCB when filtering guest's AP configuration
      s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB
      s390/vfio-ap: reset queues filtered from the guest's AP config
      s390/vfio-ap: reset queues associated with adapter for queue unbound from driver
      s390/vfio-ap: do not reset queue removed from host config

 MAINTAINERS                           |   4 +-
 arch/s390/Kconfig                     |   7 +-
 arch/s390/configs/debug_defconfig     |   1 +
 arch/s390/configs/defconfig           |   1 +
 arch/s390/configs/zfcpdump_defconfig  |   1 -
 arch/s390/include/asm/pci_io.h        |  32 ++--
 arch/s390/kernel/fpu.c                |   1 -
 arch/s390/kernel/perf_pai_crypto.c    |  80 +++++-----
 arch/s390/kernel/perf_pai_ext.c       |  79 +++++-----
 arch/s390/kernel/ptrace.c             |   1 -
 arch/s390/mm/fault.c                  |   4 +-
 arch/s390/pci/pci_mmio.c              |  12 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 266 ++++++++++++++++++++++------------
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 14 files changed, 298 insertions(+), 194 deletions(-)

