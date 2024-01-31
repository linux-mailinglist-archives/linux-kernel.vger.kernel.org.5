Return-Path: <linux-kernel+bounces-45661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3198433B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2429F28DB93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8825684;
	Wed, 31 Jan 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxoCk8df"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DF5663;
	Wed, 31 Jan 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667515; cv=none; b=GmXQArflnEx4sCPYM4W4Jv/awF1tnrxzt1c4mQ+IKE2k0+H3mkIkn4nhPPfqn6hVvqUGJ21LKoBhQG4ljsIKnaTfiHfAHGNeeSoCAguvOdXJkLmgMWdEjhU+YAQldIPiBNBZe7v3GxDaDy+k2axm8umUcQlntNfaanuUSbMNBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667515; c=relaxed/simple;
	bh=plKPxBQ2jsb/v68hxkyJ/JuBYB+4x5Jxb3q+0BdUhZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sFgaWkB9qFut1GeG4TaimPYNAJ8Akt/DWYMFsOOS7ejIUvhxraC4/2eR5rdbO7ttF10EPd2EHjJJssl7c7M49LYjM9Jdm7aeLe5OaFwmHUWIuM2io0/yJe+357G0Y0bYNI85AppjBBfjfJFNcUSweFH47FqxXLnRcYZCTcotF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxoCk8df; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667512; x=1738203512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=plKPxBQ2jsb/v68hxkyJ/JuBYB+4x5Jxb3q+0BdUhZ0=;
  b=IxoCk8dfjaUHbY6ZnFfSCYDdFc0d4dxs2Gh46gmLng4d0bCzhbVO5FCO
   o3itjV5JeM59VRqrytXZyZdkE6Nj/K31EjfL0WfQFT38xnDBAhzoS6Qwq
   zZCIrbW0xMYbgZXb6pMm7KZEXgtDsCXC9xlapwMKbpl934tEv8rUHv8nc
   l1HH7xP27krysxEh1MwrtWhC+SQNyiZ17JQnmVLkXZZrSuPZgMOvGi1xc
   7rwK7lLUIEPIlR3fiyEb8MsxSidP9WNeEeFsHmkhTPAQEbjBMcjfFNUjy
   HjYEqlHAcCEoaaWqdIUg7nJ8LJ9xoQ7Vp/ZRlY8JN7UC9FC0Tu0sfWFjP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24938941"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24938941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907714690"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907714690"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:18:23 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 0/4] Add ACPI NUMA support for RISC-V
Date: Wed, 31 Jan 2024 10:31:57 +0800
Message-Id: <cover.1706603678.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enable RISC-V ACPI NUMA support which was based on
the recently approved ACPI ECR[1].

Patch 1/4 is generated from the acpica PR[2] and should be merged through
the acpica project. Due to this dependency, other 3 patches can only be
merged after the corresponding ACPICA patch was pulled into linux.

Patch 2/4 add the common SRAT RINTC affinity structure handler.
Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA information
from SRAT and SLIT ACPI tables.
Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig. 

Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next

[1] https://mantis.uefi.org/mantis/view.php?id=2433
[2] https://github.com/acpica/acpica/pull/926

Testing:
Since the ACPI AIA/PLIC support patch set is still under upstream review,
hence it is tested using the poll based HVC SBI console and RAM disk.
1) Build latest Qemu with the following patch backported
   https://lore.kernel.org/all/20240129094200.3581037-1-haibo1.xu@intel.com/
   https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406d8a1269b0

2) Build latest EDK-II
   https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux with the following configs enabled
   CONFIG_RISCV_SBI_V01=y
   CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
   CONFIG_HVC_RISCV_SBI=y

4) Build buildroot rootfs.cpio

5) Launch the Qemu machine
   qemu-system-riscv64 -nographic \
   -machine virt,pflash0=pflash0,pflash1=pflash1 -smp 4 -m 8G \
   -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
   -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
   -object memory-backend-ram,size=4G,id=m0 \
   -object memory-backend-ram,size=4G,id=m1 \
   -numa node,memdev=m0,cpus=0-1,nodeid=0 \
   -numa node,memdev=m1,cpus=2-3,nodeid=1 \
   -numa dist,src=0,dst=1,val=30 \
   -kernel linux/arch/riscv/boot/Image \
   -initrd buildroot/output/images/rootfs.cpio \
   -append "root=/dev/ram ro console=hvc0 earlycon=sbi"

[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
[    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
..
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1

Haibo Xu (4):
  ACPICA: SRAT: Add RISC-V RINTC affinity structure
  ACPI: NUMA: Add handler for SRAT RINTC affinity structure
  ACPI: RISCV: Add NUMA support based on SRAT and SLIT
  ACPI: RISCV: Enable ACPI based NUMA

 arch/riscv/Kconfig            |   1 +
 arch/riscv/include/asm/acpi.h |  15 +++-
 arch/riscv/kernel/Makefile    |   1 +
 arch/riscv/kernel/acpi.c      |   5 --
 arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |   4 +-
 arch/riscv/kernel/smpboot.c   |   2 -
 drivers/acpi/numa/Kconfig     |   2 +-
 drivers/acpi/numa/srat.c      |  35 ++++++++-
 include/acpi/actbl3.h         |  18 ++++-
 include/linux/acpi.h          |   7 ++
 11 files changed, 209 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/kernel/acpi_numa.c

-- 
2.34.1


