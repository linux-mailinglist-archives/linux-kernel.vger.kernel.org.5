Return-Path: <linux-kernel+bounces-84960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8B86AE36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C750B1F21723
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E707970CA7;
	Wed, 28 Feb 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gl4HU8aJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028B6CDD9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120978; cv=none; b=cSqtxlkBiZnOw47jgubH/Tvxr0DUfeLKZPxBG8maghNloYonQsiOMx7TOW3d9t1/wlL/17QNFgDK7eWMGfWb1+5JYpAD/XMVCpbWarAE88Ty+T1VJlXDASIjhr9qCrlkshUQwGuSJ7vW9qIZ5PCVX8pPAFwChyn4R7AQKBcmrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120978; c=relaxed/simple;
	bh=Qcal8Ty64aIwuJm9sMzxN+fh8PzyQM8kaqQ/aZv5CWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R07pMxpv+olhpOAtSflu2JlRMHMagdipPQ4JSVmmN1WCSaeQT1JOHNmevNqNIn7/DvwwAc8tZqJYmoIS/6UwtNg9N3zeDdApGS2Z81ddahDkGk6zLIf4X5MJO6/qmDZvScnSC5TnxpZQJIbJQUwp39HEy72XJXlvGnVbOuNoQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gl4HU8aJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709120976; x=1740656976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qcal8Ty64aIwuJm9sMzxN+fh8PzyQM8kaqQ/aZv5CWY=;
  b=Gl4HU8aJ3hyusOlSYuJ/PI+Rkt2iY/at+VmtnaVwKC+1TUcvv7YYsFX6
   aC/vmy+Rkci9yZSiIs5ujZsbGyO7huEni/EJjQUM0sneIlzA/CliQZMzD
   ixRJPEYPIuEdyd7AlIuWPp/qX5J6NttSpyjPrUmOFcm/HVe5R2RjBDEOB
   H23Kn4BGjJ0iJeO+zMODRnjyZJJtW0ioHMCUx/rI6VQuvOswZyPlPlu6h
   +qV72tGABx8W5MgRA47yUj596p77xBeXe4REAy3t0jQo6y8Y7O+qVjUS+
   7noxAprhBmXvzgntznx9GcRfDZN24xZx71T9pNhQsjdWAJLwbicquXB5R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3633242"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3633242"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7619107"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
  by fmviesa006.fm.intel.com with ESMTP; 28 Feb 2024 03:49:32 -0800
From: Fei Wu <fei2.wu@intel.com>
To: atishp@atishpatra.org,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Fei Wu <fei2.wu@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4] perf: RISCV: Fix panic on pmu overflow handler
Date: Wed, 28 Feb 2024 19:54:25 +0800
Message-Id: <20240228115425.2613856-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(1 << idx) of int is not desired when setting bits in unsigned long
overflowed_ctrs, use BIT() instead. This panic happens when running
'perf record -e branches' on sophgo sg2042.

[  273.311852] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098
[  273.320851] Oops [#1]
[  273.323179] Modules linked in:
[  273.326303] CPU: 0 PID: 1475 Comm: perf Not tainted 6.6.0-rc3+ #9
[  273.332521] Hardware name: Sophgo Mango (DT)
[  273.336878] epc : riscv_pmu_ctr_get_width_mask+0x8/0x62
[  273.342291]  ra : pmu_sbi_ovf_handler+0x2e0/0x34e
[  273.347091] epc : ffffffff80aecd98 ra : ffffffff80aee056 sp : fffffff6e36928b0
[  273.354454]  gp : ffffffff821f82d0 tp : ffffffd90c353200 t0 : 0000002ade4f9978
[  273.361815]  t1 : 0000000000504d55 t2 : ffffffff8016cd8c s0 : fffffff6e3692a70
[  273.369180]  s1 : 0000000000000020 a0 : 0000000000000000 a1 : 00001a8e81800000
[  273.376540]  a2 : 0000003c00070198 a3 : 0000003c00db75a4 a4 : 0000000000000015
[  273.383901]  a5 : ffffffd7ff8804b0 a6 : 0000000000000015 a7 : 000000000000002a
[  273.391327]  s2 : 000000000000ffff s3 : 0000000000000000 s4 : ffffffd7ff8803b0
[  273.398773]  s5 : 0000000000504d55 s6 : ffffffd905069800 s7 : ffffffff821fe210
[  273.406139]  s8 : 000000007fffffff s9 : ffffffd7ff8803b0 s10: ffffffd903f29098
[  273.413660]  s11: 0000000080000000 t3 : 0000000000000003 t4 : ffffffff8017a0ca
[  273.421022]  t5 : ffffffff8023cfc2 t6 : ffffffd9040780e8
[  273.426437] status: 0000000200000100 badaddr: 0000000000000098 cause: 000000000000000d
[  273.434512] [<ffffffff80aecd98>] riscv_pmu_ctr_get_width_mask+0x8/0x62
[  273.441169] [<ffffffff80076bd8>] handle_percpu_devid_irq+0x98/0x1ee
[  273.447562] [<ffffffff80071158>] generic_handle_domain_irq+0x28/0x36
[  273.454151] [<ffffffff8047a99a>] riscv_intc_irq+0x36/0x4e
[  273.459659] [<ffffffff80c944de>] handle_riscv_irq+0x4a/0x74
[  273.465442] [<ffffffff80c94c48>] do_irq+0x62/0x92
[  273.470360] Code: 0420 60a2 6402 5529 0141 8082 0013 0000 0013 0000 (6d5c) b783
[  273.477921] ---[ end trace 0000000000000000 ]---
[  273.482630] Kernel panic - not syncing: Fatal exception in interrupt

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 drivers/perf/riscv_pmu_sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..452aab49db1e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -512,7 +512,7 @@ static void pmu_sbi_set_scounteren(void *arg)
 
 	if (event->hw.idx != -1)
 		csr_write(CSR_SCOUNTEREN,
-			  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
+			  csr_read(CSR_SCOUNTEREN) | BIT(pmu_sbi_csr_index(event)));
 }
 
 static void pmu_sbi_reset_scounteren(void *arg)
@@ -521,7 +521,7 @@ static void pmu_sbi_reset_scounteren(void *arg)
 
 	if (event->hw.idx != -1)
 		csr_write(CSR_SCOUNTEREN,
-			  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
+			  csr_read(CSR_SCOUNTEREN) & ~BIT(pmu_sbi_csr_index(event)));
 }
 
 static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
@@ -731,14 +731,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		/* compute hardware counter index */
 		hidx = info->csr - CSR_CYCLE;
 		/* check if the corresponding bit is set in sscountovf */
-		if (!(overflow & (1 << hidx)))
+		if (!(overflow & BIT(hidx)))
 			continue;
 
 		/*
 		 * Keep a track of overflowed counters so that they can be started
 		 * with updated initial value.
 		 */
-		overflowed_ctrs |= 1 << lidx;
+		overflowed_ctrs |= BIT(lidx);
 		hw_evt = &event->hw;
 		riscv_pmu_event_update(event);
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
-- 
2.34.1


