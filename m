Return-Path: <linux-kernel+bounces-89016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7786E988
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92511C25808
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0C3A1B7;
	Fri,  1 Mar 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ArRvwRo9"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766C3B194;
	Fri,  1 Mar 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321223; cv=none; b=kyWsu9KBHcQvd7w3eCtuzqzXZXG5VujIhXnY7iMSoBlPQ3sM7I8sOzsWr41HXbhOd/hp8djvqrYTJMmCkq42+4mzGkRYDCBPhWmo85mzqMLG1r5Cq2l/cNSqYk9Tj4V1bIC1iDmwTOd0v3sv/hjsMSFYxxW4tezRn2pXE/JnRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321223; c=relaxed/simple;
	bh=ljxScE5x1fMGmoZxR70bdsQl71mpsKTqENIYWvLhnPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MOWTi2GaDYlLVGWeDgXkIBNK8tH3mb2xQu4HEUNQ72HYMpdxLGpqNE//a3XEWq/zNUiHXBDzhllBQVbausLCbVgdQzr9SUDWDwLVTHUU27RCFykLjLJSSKWpqBe/HCJNnxo5Jswg4arJTdaiC4GN2OkVnKwFG8QSxL2RkzNYUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ArRvwRo9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.77.82])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35C3D20B74C0;
	Fri,  1 Mar 2024 11:26:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35C3D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709321216;
	bh=WGu8YW37brgqi1ZUilW8ClBLPCcNPQXPsBsaqdHd2jI=;
	h=From:To:Cc:Subject:Date:From;
	b=ArRvwRo96GImnyfufm73/8YYYSFL9Eduy+qRlyNKwlMf2QQrPLWMi3OXKlzaamX2J
	 FyJKZaanhzCnOMLADaydG1kQRI+kTuyCk+p3e4EIvYAgzq9npD2rvdDWgtYZyDCBhe
	 l7a4cQ3BsHhF+PcKzVaNnkWu4+4W2CoVtJ0vDvFA=
From: Jarred White <jarredwhite@linux.microsoft.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	srivatsabhat@linux.microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v3] acpi: Use access_width over bit_width for system memory accesses
Date: Fri,  1 Mar 2024 11:25:59 -0800
Message-Id: <20240301192600.2568-1-jarredwhite@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
depend on it being always on a clean 8b boundary. This was uncovered on the
Cobalt 100 platform.

SError Interrupt on CPU26, code 0xbe000011 -- SError
 CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 5.15.2.1-13 #1
 Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
 pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
 pc : cppc_get_perf_caps+0xec/0x410
 lr : cppc_get_perf_caps+0xe8/0x410
 sp : ffff8000155ab730
 x29: ffff8000155ab730 x28: ffff0080139d0038 x27: ffff0080139d0078
 x26: 0000000000000000 x25: ffff0080139d0058 x24: 00000000ffffffff
 x23: ffff0080139d0298 x22: ffff0080139d0278 x21: 0000000000000000
 x20: ffff00802b251910 x19: ffff0080139d0000 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffffdc7e111bad04 x15: ffff00802b251008
 x14: ffffffffffffffff x13: ffff013f1fd63300 x12: 0000000000000006
 x11: ffffdc7e128f4420 x10: 0000000000000000 x9 : ffffdc7e111badec
 x8 : ffff00802b251980 x7 : 0000000000000000 x6 : ffff0080139d0028
 x5 : 0000000000000000 x4 : ffff0080139d0018 x3 : 00000000ffffffff
 x2 : 0000000000000008 x1 : ffff8000155ab7a0 x0 : 0000000000000000
 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 
5.15.2.1-13 #1
 Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
 Call trace:
  dump_backtrace+0x0/0x1e0
  show_stack+0x24/0x30
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  panic+0x16c/0x384
  add_taint+0x0/0xc0
  arm64_serror_panic+0x7c/0x90
  arm64_is_fatal_ras_serror+0x34/0xa4
  do_serror+0x50/0x6c
  el1h_64_error_handler+0x40/0x74
  el1h_64_error+0x7c/0x80
  cppc_get_perf_caps+0xec/0x410
  cppc_cpufreq_cpu_init+0x74/0x400 [cppc_cpufreq]
  cpufreq_online+0x2dc/0xa30
  cpufreq_add_dev+0xc0/0xd4
  subsys_interface_register+0x134/0x14c
  cpufreq_register_driver+0x1b0/0x354
  cppc_cpufreq_init+0x1a8/0x1000 [cppc_cpufreq]
  do_one_initcall+0x50/0x250
  do_init_module+0x60/0x27c
  load_module+0x2300/0x2570
  __do_sys_finit_module+0xa8/0x114
  __arm64_sys_finit_module+0x2c/0x3c
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x180/0x1a0
  do_el0_svc+0x84/0xa0
  el0_svc+0x2c/0xc0
  el0t_64_sync_handler+0xa4/0x12c
  el0t_64_sync+0x1a4/0x1a8

Instead, use access_width to determine the size and use the offset and width
to shift and mask the bits we want to read/write out. Make sure to add a check
for system memory since pcc redefines the access_width to subspace id. If 
access_width is not set, then fallback to using the bit_width.

Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
CC: srivatsabhat@linux.microsoft.com
CC: stable@vger.kernel.org #5.15+
---
changelog:
v1-->v2:
https://lore.kernel.org/linux-acpi/20231216001312.1160-1-jarredwhite@linux.microsoft.com/
	1. Fixed coding style errors
	2. Backwards compatibility with ioremapping of address still an
		open question. Suggestions are welcomed.
v2-->v3:
	1. Created a fallback mechanism to revert to using the bit_width
	2. Re-labeled macro to GET_BIT_WIDTH
	3. Collapsed the if/else statements in the cpc_read() and cpc_write() routines

 drivers/acpi/cppc_acpi.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d155a86a8614..57de7edda7a5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -166,6 +166,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
+/* Check for valid access_width, otherwise, fallback to using the bit_width */
+#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+
+/* Shift and apply the mask for CPC reads/writes */
+#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
+					GENMASK(((reg)->bit_width), 0)))
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -780,6 +787,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
@@ -787,7 +795,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 							goto out_free;
 					}
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					/* Check for access_width for the size, otherwise use bit_width */
+					access_width = GET_BIT_WIDTH(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -983,6 +993,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -994,7 +1005,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = GET_BIT_WIDTH(reg);
 		u32 val_u32;
 		acpi_status status;
 
@@ -1018,7 +1029,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	size = GET_BIT_WIDTH(reg);
+
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -1037,18 +1050,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(reg, *val);
+
 	return 0;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = GET_BIT_WIDTH(reg);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
@@ -1070,7 +1087,12 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		val = MASK_VAL(reg, val);
+
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
-- 
2.34.1


