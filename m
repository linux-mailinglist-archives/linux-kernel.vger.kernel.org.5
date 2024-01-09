Return-Path: <linux-kernel+bounces-20628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872368282AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A011F23384
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25492942B;
	Tue,  9 Jan 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SEKrrFYq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3323C1C;
	Tue,  9 Jan 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4098I1lv014051;
	Tue, 9 Jan 2024 09:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=tL846XrawB3mTGuXI+WteT8dkNgjC+eKhN+PY+V7oOE=;
 b=SEKrrFYqTeYb3MYeC4PJWRDLn2iWx60xE/vpEBCT2snXneEGYAd8CTx2p/Y8jkACbg1V
 rzZiDGcJcKXp5yP8I+xlJs0jMCA1gYdBYI2YUBpCMPkHr2IZxtDYQsZNjb+QKEZRwxJF
 2sh2nTdz4b+2ADLrO8wKsDUPT8D+027NkYlNmcFIjp2JKZRF7HfriIIfbqRsSOTkAwjf
 bMGemxwtBR/euqbq6ENHv2QDiqVPOldxuNh4n98ul7N5TyG3UxMMntv34R83Dq2079VG
 wA5a7kyfLyY85rpIe7s5MGq1cgJJhdGRTE6McByMDoBldEBMLqxWm8IBF9xQEyYBhkj0 XQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh2gks88g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:06:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4096U16I027421;
	Tue, 9 Jan 2024 09:06:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw1w418-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:06:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40995w7L18743862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 09:05:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B549E2004B;
	Tue,  9 Jan 2024 09:05:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8872C20043;
	Tue,  9 Jan 2024 09:05:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 09:05:58 +0000 (GMT)
Date: Tue, 9 Jan 2024 10:05:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for the 6.8 merge window
Message-ID: <ZZ0MdVwe+S82dwnX@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xuk0CQ43MXJZepGDtu0z4zcFCajvzx7O
X-Proofpoint-GUID: Xuk0CQ43MXJZepGDtu0z4zcFCajvzx7O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090071

Hello Linus,

Please pull s390 changes for 6.8 merge window.

Please note three KVM commits that were agreed to go via s390 tree
as part of a floating-point unit (FPU) rework:
	KVM: s390: fix setting of fpc register
	KVM: s390: use READ_ONCE() to read fpc register value
	KVM: s390: remove superfluous save_fpu_regs() call

Also, there is revert of defconfigs update that is upstream already
as commit 3d940bb18183 ("s390: update defconfigs"):
	Revert "s390: update defconfigs"
	s390: update defconfigs

Thank you,
Alexander

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-1

for you to fetch changes up to b2b97a62f055dd638f7f02087331a8380d8f139a:

  Revert "s390: update defconfigs" (2023-12-18 10:58:58 +0100)

----------------------------------------------------------------
s390 updates for 6.8 merge window

- Add machine variable capacity information to /proc/sysinfo.

- Limit the waste of page tables and always align vmalloc area size
  and base address on segment boundary.

- Fix a memory leak when an attempt to register interruption sub class
  (ISC) for the adjunct-processor (AP) guest failed.

- Reset response code AP_RESPONSE_INVALID_GISA to understandable
  by guest AP_RESPONSE_INVALID_ADDRESS in response to a failed
  interruption sub class (ISC) registration attempt.

- Improve reaction to adjunct-processor (AP) AP_RESPONSE_OTHERWISE_CHANGED
  response code when enabling interrupts on behalf of a guest.

- Fix incorrect sysfs 'status' attribute of adjunct-processor (AP) queue
  device bound to the vfio_ap device driver when the mediated device is
  attached to a guest, but the queue device is not passed through.

- Rework struct ap_card to hold the whole adjunct-processor (AP) card
  hardware information. As result, all the ugly bit checks are replaced
  by simple evaluations of the required bit fields.

- Improve handling of some weird scenarios between service element (SE)
  host and SE guest with adjunct-processor (AP) pass-through support.

- Change local_ctl_set_bit() and local_ctl_clear_bit() so they return the
  previous value of the to be changed control register. This is useful if
  a bit is only changed temporarily and the previous content needs to be
  restored.

- The kernel starts with machine checks disabled and is expected to enable
  it once trap_init() is called. However the implementation allows machine
  checks early. Consistently enable it in trap_init() only.

- local_mcck_disable() and local_mcck_enable() assume that machine checks
  are always enabled. Instead implement and use local_mcck_save() and
  local_mcck_restore() to disable machine checks and restore the previous
  state.

- Modification of floating point control (FPC) register of a traced
  process using ptrace interface may lead to corruption of the FPC
  register of the tracing process. Fix this.

- kvm_arch_vcpu_ioctl_set_fpu() allows to set the floating point control
  (FPC) register in vCPU, but may lead to corruption of the FPC register
  of the host process. Fix this.

- Use READ_ONCE() to read a vCPU floating point register value from the
  memory mapped area. This avoids that, depending on code generation,
  a different value is tested for validity than the one that is used.

- Get rid of test_fp_ctl(), since it is quite subtle to use it correctly.
  Instead copy a new floating point control register value into its save
  area and test the validity of the new value when loading it.

- Remove superfluous save_fpu_regs() call.

- Remove s390 support for ARCH_WANTS_DYNAMIC_TASK_STRUCT. All machines
  provide the vector facility since many years and the need to make the
  task structure size dependent on the vector facility does not exist.

- Remove the "novx" kernel command line option, as the vector code runs
  without any problems since many years.

- Add the vector facility to the z13 architecture level set (ALS).
  All hypervisors support the vector facility since many years.
  This allows compile time optimizations of the kernel.

- Get rid of MACHINE_HAS_VX and replace it with cpu_has_vx(). As result,
  the compiled code will have less runtime checks and less code.

- Convert pgste_get_lock() and pgste_set_unlock() ASM inlines to C.

- Convert the struct subchannel spinlock from pointer to member.

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/boot: always align vmalloc area on segment boundary
      Revert "s390: update defconfigs"

Anthony Krowiak (2):
      s390/vfio-ap: unpin pages on gisc registration failure
      s390/vfio-ap: set status response code to 06 on gisc registration failure

Claudio Imbrenda (1):
      s390/mm: convert pgste locking functions to C

Halil Pasic (1):
      s390/cio: make sch->lock spinlock pointer a member

Harald Freudenberger (2):
      s390/ap: store TAPQ hwinfo in struct ap_card
      s390/ap: handle outband SE bind state change

Heiko Carstens (13):
      s390/ctlreg: return old register contents when changing bits
      s390/nmi: consistently enable machine checks in trap_init()
      s390/nmi: implement and use local_mcck_save() / local_mcck_restore()
      s390/ptrace: handle setting of fpc register correctly
      KVM: s390: fix setting of fpc register
      KVM: s390: use READ_ONCE() to read fpc register value
      s390/fpu: get rid of test_fp_ctl()
      KVM: s390: remove superfluous save_fpu_regs() call
      s390/fpu: remove ARCH_WANTS_DYNAMIC_TASK_STRUCT support
      s390/fpu: remove "novx" option
      s390/als: add vector facility to z13 architecture level set
      s390/fpu: get rid of MACHINE_HAS_VX
      s390: update defconfigs

Tony Krowiak (2):
      s390/vfio-ap: improve reaction to response code 07 from PQAP(AQIC) command
      s390/vfio-ap: fix sysfs status attribute for AP queue devices

Vasily Gorbik (1):
      s390/sysinfo: add variable capacity information

 arch/s390/Kconfig                    |   1 -
 arch/s390/boot/ipl_parm.c            |   2 +-
 arch/s390/boot/startup.c             |   3 +-
 arch/s390/crypto/chacha-glue.c       |   2 +-
 arch/s390/include/asm/ap.h           |  21 ++--
 arch/s390/include/asm/ctlreg.h       |  24 +++--
 arch/s390/include/asm/fpu/api.h      |  35 +++---
 arch/s390/include/asm/fpu/internal.h |  10 +-
 arch/s390/include/asm/processor.h    |  34 ++++--
 arch/s390/include/asm/setup.h        |   2 -
 arch/s390/include/asm/sysinfo.h      |   4 +
 arch/s390/kernel/compat_signal.c     |  16 ++-
 arch/s390/kernel/crash_dump.c        |   5 +-
 arch/s390/kernel/early.c             |  12 +--
 arch/s390/kernel/fpu.c               |  12 +--
 arch/s390/kernel/machine_kexec.c     |   2 +-
 arch/s390/kernel/nmi.c               |  10 +-
 arch/s390/kernel/perf_regs.c         |   6 +-
 arch/s390/kernel/process.c           |   2 +-
 arch/s390/kernel/processor.c         |   7 +-
 arch/s390/kernel/ptrace.c            |  28 +++--
 arch/s390/kernel/setup.c             |  25 +----
 arch/s390/kernel/signal.c            |  12 +--
 arch/s390/kernel/smp.c               |   6 +-
 arch/s390/kernel/sysinfo.c           |  10 ++
 arch/s390/kernel/traps.c             |  13 ++-
 arch/s390/kernel/vmlinux.lds.S       |   1 +
 arch/s390/kvm/interrupt.c            |   2 +-
 arch/s390/kvm/kvm-s390.c             |  26 ++---
 arch/s390/lib/test_unwind.c          |   6 +-
 arch/s390/mm/pgtable.c               |  27 ++---
 arch/s390/tools/gen_facilities.c     |   1 +
 drivers/s390/cio/chsc.c              |  18 ++--
 drivers/s390/cio/chsc_sch.c          |   6 +-
 drivers/s390/cio/cio.c               |   6 +-
 drivers/s390/cio/cio.h               |   2 +-
 drivers/s390/cio/css.c               |  36 ++-----
 drivers/s390/cio/device.c            |  66 ++++++------
 drivers/s390/cio/device_pgid.c       |  12 +--
 drivers/s390/cio/eadm_sch.c          |  36 +++----
 drivers/s390/cio/vfio_ccw_drv.c      |   8 +-
 drivers/s390/cio/vfio_ccw_fsm.c      |  24 ++---
 drivers/s390/crypto/ap_bus.c         |  72 ++++++-------
 drivers/s390/crypto/ap_bus.h         |  22 +---
 drivers/s390/crypto/ap_card.c        |  18 ++--
 drivers/s390/crypto/ap_queue.c       | 200 +++++++++++++++++++++++------------
 drivers/s390/crypto/vfio_ap_ops.c    |  30 ++++--
 drivers/s390/crypto/zcrypt_api.c     |  16 +--
 drivers/s390/crypto/zcrypt_cex4.c    |  31 +++---
 lib/raid6/s390vx.uc                  |   2 +-
 50 files changed, 517 insertions(+), 455 deletions(-)

