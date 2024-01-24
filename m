Return-Path: <linux-kernel+bounces-36448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB883A0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383441F2A546
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB61D289;
	Wed, 24 Jan 2024 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Gm6lJX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E667C8E1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073194; cv=none; b=bY1y6Axs8EcHsOQWVrP95jYOpE5nMA4xUAG6b5FceLoHhtnGQ7cmM0fV6ODauypiSkFaXe11DysEjZ1a2f5/E0StsbTG86G7MBPX2ziI2PyB1nsdaS7dTWK/VGedIu1P2YyrulxgwaCfN6Inia2POH+Gh9XlQNo39CvqatBRJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073194; c=relaxed/simple;
	bh=8IRILIHbZzm7JiU2AP+iQrJP86mAIlHIlBV5y0BJ124=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=aVWmX+yDaDc+WeJDAR/ZdCyBwWbEIyo407UGHro1RjJGVsFDe7DzsAhgcitoQx7SBNQFSyKY6VuH0qCgVz7RPNEpp2qTVFf4e3jAofAq2rj9IOA/cS1H9S9P188St26IVbP44goR9Ewa6jlljhE1cDD42ZythC77FNQwKLhcits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Gm6lJX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hMrXo75T+RiZg6Ni6slGNp8f5iS89iUB0hhC0nnqkcg=;
	b=e9Gm6lJXfQH9NTQdkrfVU9RLmzMAryJG2WvNZpOdSGrA73SsYPpl/L6pwp8+5ze6FecQVv
	nbg2FZ2L02OQn4fIY0vADK4JY5E2/CM+YsTfssJuxPS+JZvw668+iGGiRnr+E0AUIQkNYA
	Ve4lE493nVKdBGErcxWGJjp3KVZb7yw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-wtN1dBuqPpKMsbqqxC-a1w-1; Wed,
 24 Jan 2024 00:13:05 -0500
X-MC-Unique: wtN1dBuqPpKMsbqqxC-a1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2E81C04348;
	Wed, 24 Jan 2024 05:13:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 417FF1C060AF;
	Wed, 24 Jan 2024 05:12:57 +0000 (UTC)
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
Subject: [PATCH linux-next v3 00/14] Split crash out from kexec and clean up related config items
Date: Wed, 24 Jan 2024 13:12:40 +0800
Message-ID: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
6, wrap up crash codes in crash related ifdefs on all 8 arch-es
   which support crash dumping, except of ppc;

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
building all passed. Take configs on x86_64 as exampmle here:

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

Changelog
==========
v2->v3:
- In patch 2, there's conflict when rebasing to linux-next in
  kernel/crash_core.c because of below commits from Uladzislau:
  - commit 699d9351822e ("mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_init()")
  - commit 5f4c0c1e2a51 (:mm/vmalloc: remove vmap_area_list")
- In patch 13, fix the lkp reported issue by using CONFIG_CRASH_RESERVE
  ifdef, giving up the earlier IS_ENABLED(CONFIG_CRASH_RESERVE) checking in v2. 
- In patch 14, update code change after below commit merged into
  mainline:
  - commit 78de91b45860 ("LoongArch: Use generic interface to support crashkernel=X,[high,low]")

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
  mips, crash: wrap crash dumping code into crash related ifdefs
  riscv, crash: wrap crash dumping code into crash related ifdefs
  arm, crash: wrap crash dumping code into crash related ifdefs
  loongarch, crash: wrap crash dumping code into crash related ifdefs

 arch/arm/kernel/setup.c                       |   4 +-
 arch/arm64/Kconfig                            |   2 +-
 .../asm/{crash_core.h => crash_reserve.h}     |   4 +-
 arch/arm64/include/asm/kexec.h                |   2 +-
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/machine_kexec.c             |   2 +-
 arch/arm64/kernel/machine_kexec_file.c        |  10 +-
 .../kernel/{crash_core.c => vmcore_info.c}    |   2 +-
 arch/arm64/mm/init.c                          |   2 +-
 arch/loongarch/kernel/setup.c                 |   2 +-
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
 kernel/crash_core.c                           | 762 +++++-------------
 kernel/crash_reserve.c                        | 464 +++++++++++
 kernel/{crash_dump.c => elfcorehdr.c}         |   0
 kernel/kexec.c                                |  11 +-
 kernel/kexec_core.c                           | 250 +-----
 kernel/kexec_file.c                           |  13 +-
 kernel/kexec_internal.h                       |   2 +
 kernel/ksysfs.c                               |  10 +-
 kernel/printk/printk.c                        |   4 +-
 kernel/vmcore_info.c                          | 231 ++++++
 lib/buildid.c                                 |   2 +-
 62 files changed, 1228 insertions(+), 1043 deletions(-)
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


