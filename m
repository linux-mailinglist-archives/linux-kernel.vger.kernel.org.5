Return-Path: <linux-kernel+bounces-31276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC0832BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855391F20FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406554657;
	Fri, 19 Jan 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge88Fbvp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6A537FC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675980; cv=none; b=MpgF80Y/Blj8w1SQWTohQ868fX4eYkTEbd2TNl68LSaUFKvKG1H4CUmH3UlatjqMOy048Df5EKGcN6Y7DxByytVtZQhJHmIdm+kStc2J6YjGMgwLx2I4TSRMYQUXgil/K8esx6Aer+Pvk23Sozp6jAq4kEQktWBE0GmX2B1DAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675980; c=relaxed/simple;
	bh=wUT0GblWyaSCMG72ho7DyANlHY+TnVrL4D5EcwG8bRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=WBIGlhrXL0DwWwou4TA4Mcc/Z3bbJzKNd8MVIviXFGcegsr1eKADDXZzvSo3jKDk0VNVh/6xVVgwnEyYQdKyQzfXbrw+TlsUVwUudqeEBafAOKal6YmBT1GznObUrK3Shcl1NytbZYGdjYGV38G5OGD+KAldXWq/FxWkH9BLhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge88Fbvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705675977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a7b5wka3jZpJDrQA4DTDzEctwPm/eZO0QdaDBfGD0Sk=;
	b=ge88FbvpbKwuxXPX7aegNouVPnGzDM+33csKcWsGUAVObVDbYeddYw5LVRRuWFrRfckeiE
	B/1M83TKwAmpo12iplP3a6gvNrlkV4kulYJFTmLSPECwJbhSBLkOllMVTWbJ5d1dZXU4cm
	6uo9IA37H2Kzr5LrKT3o9tEg/IRr9yY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-y_u4cXE2P_WuQzhDc2Y6SA-1; Fri,
 19 Jan 2024 09:52:53 -0500
X-MC-Unique: y_u4cXE2P_WuQzhDc2Y6SA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF48C3C2A1DC;
	Fri, 19 Jan 2024 14:52:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 528F451D5;
	Fri, 19 Jan 2024 14:52:44 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 00/14] Split crash out from kexec and clean up related config items
Date: Fri, 19 Jan 2024 22:52:27 +0800
Message-ID: <20240119145241.769622-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Motivation:
=============
Previously, LKP reported a building error. When investigating, it can't
be resolved reasonablly with the present messy kdump config items.

 https://lore.kernel.org/oe-kbuild-all/202312182200.Ka7MzifQ-lkp@intel.com/

The kdump (crash dumping) related config items could causes confusions:

Firstly,
---
CRASH_CORE enables codes including
 - crashkernel reservation;
 - elfcorehdr updating;
 - vmcoreinfo exporting;
 - crash hotplug handling;

Now fadump of powerpc, kcore dynamic debugging and kdump all selects
CRASH_CORE, while fadump
 - fadump needs crashkernel parsing, vmcoreinfo exporting, and accessing
   global variable 'elfcorehdr_addr';
 - kcore only needs vmcoreinfo exporting;
 - kdump needs all of the current kernel/crash_core.c.

So only enabling PROC_CORE or FA_DUMP will enable CRASH_CORE, this
mislead people that we enable crash dumping, actual it's not.

Secondly,
---
It's not reasonable to allow KEXEC_CORE select CRASH_CORE.

Because KEXEC_CORE enables codes which allocate control pages, copy
kexec/kdump segments, and prepare for switching. These codes are
shared by both kexec reboot and kdump. We could want kexec reboot,
but disable kdump. In that case, CRASH_CORE should not be selected.

 --------------------
 CONFIG_CRASH_CORE=y
 CONFIG_KEXEC_CORE=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_FILE=y
    ---------------------

Thirdly,
---
It's not reasonable to allow CRASH_DUMP select KEXEC_CORE.

That could make KEXEC_CORE, CRASH_DUMP are enabled independently from
KEXEC or KEXEC_FILE. However, w/o KEXEC or KEXEC_FILE, the KEXEC_CORE
code built in doesn't make any sense because no kernel loading or
switching will happen to utilize the KEXEC_CORE code.
 ---------------------
 CONFIG_CRASH_CORE=y 
 CONFIG_KEXEC_CORE=y 
 CONFIG_CRASH_DUMP=y
 ---------------------

In this case, what is worse, on arch sh and arm, KEXEC relies on MMU,
while CRASH_DUMP can still be enabled when !MMU, then compiling error is
seen as the lkp test robot reported in above link.

 ------arch/sh/Kconfig------
 config ARCH_SUPPORTS_KEXEC
         def_bool MMU

 config ARCH_SUPPORTS_CRASH_DUMP
         def_bool BROKEN_ON_SMP
 ---------------------------

Changes:
===========
1, split out crash_reserve.c from crash_core.c;
2, split out vmcore_infoc. from crash_core.c;
3, move crash related codes in kexec_core.c into crash_core.c;
4, remove dependency of FA_DUMP on CRASH_DUMP;
5, clean up kdump related config items;
6, wrap up crash codes in crash related ifdefs on all 9 arch-es
   which support crash dumping;

Achievement:
===========
With above changes, I can rearrange the config item logic as below (the right
item depends on or is selected by the left item):

    PROC_KCORE -----------> VMCORE_INFO

               |----------> VMCORE_INFO
    FA_DUMP----|
               |----------> CRASH_RESERVE

                                                    ---->VMCORE_INFO
                                                   /
                                                   |---->CRASH_RESERVE
    KEXEC      --|                                /|
                 |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
    KEXEC_FILE --|                               \ |
                                                   \---->CRASH_HOTPLUG


    KEXEC      --|
                 |--> KEXEC_CORE (for kexec reboot only)
    KEXEC_FILE --|

Test
========
On all 8 architectures, including x86_64, arm64, s390x, sh, arm, mips,
riscv, loongarch, I did below three cases of config item setting and
building all passed. Let me take configs on x86_64 as exampmle here:

(1) Both CONFIG_KEXEC and KEXEC_FILE is unset, then all kexec/kdump
items are unset automatically:
# Kexec and crash features
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# end of Kexec and crash features

(2) set CONFIG_KEXEC_FILE and 'make olddefconfig':
---------------
# Kexec and crash features
CONFIG_CRASH_RESERVE=y
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC_FILE=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y
CONFIG_CRASH_MAX_MEMORY_RANGES=8192
# end of Kexec and crash features
---------------

(3) unset CONFIG_CRASH_DUMP in case 2 and execute 'make olddefconfig':
------------------------
# Kexec and crash features
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC_FILE=y
# end of Kexec and crash features
------------------------

Note:
For ppc, it needs investigation to make clear how to split out crash
code in arch folder. Hope Hari and Pingfan can help have a look, see if
it's doable. Now, I make it either have both kexec and crash enabled, or
disable both of them altogether.

Baoquan He (14):
  kexec: split crashkernel reservation code out from crash_core.c
  crash: split vmcoreinfo exporting code out from crash_core.c
  crash: remove dependency of FA_DUMP on CRASH_DUMP
  crash: split crash dumping code out from kexec_core.c
  crash: clean up kdump related config items
  x86, crash: wrap crash dumping code into crash related ifdefs
  arm64, crash: wrap crash dumping code into crash related ifdefs
  ppc, crash: enforce KEXEC and KEXEC_FILE to select CRASH_DUMP
  s390, crash: wrap crash dumping code into crash related ifdefs
  sh, crash: wrap crash dumping code into crash related ifdefs
  arm, crash: wrap crash dumping code into crash related ifdefs
  mips, crash: wrap crash dumping code into crash related ifdefs
  riscv, crash: wrap crash dumping code into crash related ifdefs
  loongarch, crash: wrap crash dumping code into crash related ifdefs

 arch/arm/kernel/setup.c                       |   7 +-
 arch/arm64/Kconfig                            |   2 +-
 .../asm/{crash_core.h => crash_reserve.h}     |   4 +-
 arch/arm64/include/asm/kexec.h                |   2 +-
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/machine_kexec.c             |   2 +-
 arch/arm64/kernel/machine_kexec_file.c        |  10 +-
 .../kernel/{crash_core.c => vmcore_info.c}    |   2 +-
 arch/loongarch/kernel/setup.c                 |   7 +-
 arch/mips/kernel/setup.c                      |  17 +-
 arch/powerpc/Kconfig                          |   9 +-
 arch/powerpc/kernel/setup-common.c            |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c          |   4 +-
 arch/powerpc/platforms/powernv/opal-core.c    |   2 +-
 arch/riscv/Kconfig                            |   2 +-
 .../asm/{crash_core.h => crash_reserve.h}     |   4 +-
 arch/riscv/kernel/Makefile                    |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   9 +-
 .../kernel/{crash_core.c => vmcore_info.c}    |   2 +-
 arch/riscv/mm/init.c                          |   2 +-
 arch/s390/kernel/kexec_elf.c                  |   2 +
 arch/s390/kernel/kexec_image.c                |   2 +
 arch/s390/kernel/machine_kexec_file.c         |  10 +
 arch/sh/kernel/machine_kexec.c                |   3 +
 arch/sh/kernel/setup.c                        |   2 +-
 arch/x86/Kconfig                              |   2 +-
 .../asm/{crash_core.h => crash_reserve.h}     |   6 +-
 arch/x86/kernel/Makefile                      |   6 +-
 arch/x86/kernel/cpu/mshyperv.c                |   4 +
 arch/x86/kernel/kexec-bzimage64.c             |   4 +
 arch/x86/kernel/kvm.c                         |   4 +-
 arch/x86/kernel/machine_kexec_64.c            |   3 +
 arch/x86/kernel/reboot.c                      |   2 +-
 arch/x86/kernel/setup.c                       |   2 +-
 arch/x86/kernel/smp.c                         |   2 +-
 .../{crash_core_32.c => vmcore_info_32.c}     |   2 +-
 .../{crash_core_64.c => vmcore_info_64.c}     |   2 +-
 arch/x86/xen/enlighten_hvm.c                  |   4 +
 drivers/base/cpu.c                            |   6 +-
 drivers/firmware/qemu_fw_cfg.c                |  14 +-
 fs/proc/Kconfig                               |   2 +-
 fs/proc/kcore.c                               |   2 +-
 include/linux/buildid.h                       |   2 +-
 include/linux/crash_core.h                    | 152 ++--
 include/linux/crash_reserve.h                 |  48 ++
 include/linux/kexec.h                         |  47 +-
 include/linux/vmcore_info.h                   |  81 ++
 init/initramfs.c                              |   2 +-
 kernel/Kconfig.kexec                          |  12 +-
 kernel/Makefile                               |   5 +-
 kernel/crash_core.c                           | 764 +++++-------------
 kernel/crash_reserve.c                        | 464 +++++++++++
 kernel/{crash_dump.c => elfcorehdr.c}         |   0
 kernel/kexec.c                                |  11 +-
 kernel/kexec_core.c                           | 250 +-----
 kernel/kexec_file.c                           |  13 +-
 kernel/kexec_internal.h                       |   2 +
 kernel/ksysfs.c                               |  10 +-
 kernel/printk/printk.c                        |   4 +-
 kernel/vmcore_info.c                          | 233 ++++++
 lib/buildid.c                                 |   2 +-
 61 files changed, 1233 insertions(+), 1048 deletions(-)
 rename arch/arm64/include/asm/{crash_core.h => crash_reserve.h} (81%)
 rename arch/arm64/kernel/{crash_core.c => vmcore_info.c} (97%)
 rename arch/riscv/include/asm/{crash_core.h => crash_reserve.h} (78%)
 rename arch/riscv/kernel/{crash_core.c => vmcore_info.c} (96%)
 rename arch/x86/include/asm/{crash_core.h => crash_reserve.h} (92%)
 rename arch/x86/kernel/{crash_core_32.c => vmcore_info_32.c} (90%)
 rename arch/x86/kernel/{crash_core_64.c => vmcore_info_64.c} (94%)
 create mode 100644 include/linux/crash_reserve.h
 create mode 100644 include/linux/vmcore_info.h
 create mode 100644 kernel/crash_reserve.c
 rename kernel/{crash_dump.c => elfcorehdr.c} (100%)
 create mode 100644 kernel/vmcore_info.c

-- 
2.41.0


