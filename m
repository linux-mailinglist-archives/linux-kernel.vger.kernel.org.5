Return-Path: <linux-kernel+bounces-82637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7C86877D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745D81F257B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCA3EA86;
	Tue, 27 Feb 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAKrDy5d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA93D988
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003006; cv=none; b=i0ZDB3JwHEWvCuy5PF36l/SE1M/Odturdvqk2rbgUV80V1BSt1i3lQiAs9dXEZNFfRq/kV6vsbJ8GSckWih0othPISp6/xy301d88cgb0OqZuvAohBGcQDHiYI/QZXvCVlc2HJO0S7U53ULk0Hx5UdRVcKqIGqmtYD360jOxzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003006; c=relaxed/simple;
	bh=zdJ2ODkJR0n1OAeFgqhQcdgBH8wAu0+3mGhii83TXAY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dAfuYWjTie4wQ39Zol3PIPAa6IQXvbKmri2x8ueU5Z5hHW0D75OGtVBluHCiKkEnVYc8KzNRORuvvJM3TRQ6g0vfgUW22ql2zvo9TaBTErZtk9Ijhju4ficbh8CImo+AfkWau/XKKxtyceJdo9zSXMCripdQJOw0ZsbNUysTCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAKrDy5d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709003005; x=1740539005;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zdJ2ODkJR0n1OAeFgqhQcdgBH8wAu0+3mGhii83TXAY=;
  b=QAKrDy5dPAKunSc0dVyS7nt0AmqOxMaGf3DhLq9QO9ccuy1p6ZzulzbL
   NQeqxjZ3kdvGPFVtZTKo8q24X6h0mnR5Y/2ZX/Qpx3ib3CRrddzBg/ocy
   TVoOKkiCiD9bP9ojDfHLNRA9cJl3NRv/Ag/AqFsbzdB24W3MX0I9V7VPs
   Zpn1rjrb0pc7/3BfBQ7WfbO2I6un6N1BXhrQ6uFCyXpu/q1xRukyGEmWa
   zTHx4uhfpcXgelkxyoQIiFY19BWCH9FSTFLPJRTRWvPUm5vu9i0Rd5ysm
   uwmiSM3rOdyEN9NiySW/v5/JmnwXCZgnw9wJYljRa+Gujsh84b8hf9/gV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3201119"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3201119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44385470"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2024 19:03:20 -0800
From: Fei Wu <fei2.wu@intel.com>
To: atishp@atishpatra.org,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fei2.wu@intel.com
Subject: [PATCH] perf: RISCV: Fix panic on pmu overflow handler
Date: Tue, 27 Feb 2024 11:07:31 +0800
Message-Id: <20240227030731.2560035-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sign extension of (1 << idx) from int is not desired when setting bits
in unsigned long overflowed_ctrs, kernel panics if 31 is a valid lidx.
This panic happens when 'perf record -e branches' on a sophgo machine.

[  212.845953] epc : ffffffff80afc288 ra : ffffffff80afd310 sp : fffffff6e36928f0
[  212.853474]  gp : ffffffff821f7f48 tp : ffffffd9033b9900 t0 : 0000002ad69e9978
[  212.861069]  t1 : 000000000000002a t2 : ffffffff801764d2 s0 : fffffff6e3692ab0
[  212.868637]  s1 : 0000000000000020 a0 : 0000000000000000 a1 : 0000000000000015
[  212.876021]  a2 : 0000000000000000 a3 : 0000000000000015 a4 : 0000000000000020
[  212.883482]  a5 : ffffffd7ff880640 a6 : 000000000005a569 a7 : ffffffffffffffd5
[  212.891191]  s2 : 000000000000ffff s3 : 0000000000000000 s4 : ffffffd7ff880540
[  212.898707]  s5 : 0000000000504d55 s6 : ffffffd902443000 s7 : ffffffff821fe1f8
[  212.906329]  s8 : 000000007fffffff s9 : ffffffd7ff880540 s10: ffffffd9147a1098
[  212.914151]  s11: 0000000080000000 t3 : 0000000000000003 t4 : ffffffff80186226
[  212.921773]  t5 : ffffffff802455ca t6 : ffffffd9058900e8
[  212.927300] status: 0000000200000100 badaddr: 0000000000000098 cause: 000000000000000d
[  212.935575] [<ffffffff80afc288>] riscv_pmu_ctr_get_width_mask+0x8/0x60
[  212.942391] [<ffffffff80079922>] handle_percpu_devid_irq+0x98/0x1e8
[  212.948855] [<ffffffff80073d06>] generic_handle_domain_irq+0x28/0x36
[  212.955521] [<ffffffff80481444>] riscv_intc_irq+0x36/0x4e
[  212.961269] [<ffffffff80ca5fce>] handle_riscv_irq+0x4a/0x74
[  212.967270] [<ffffffff80ca6afc>] do_irq+0x60/0x90
[  212.972284] Code: b580 60a2 6402 5529 0141 8082 0013 0000 0013 0000 (6d5c) b783
[  212.980036] ---[ end trace 0000000000000000 ]---
[  212.984874] Kernel panic - not syncing: Fatal exception in interrupt
[  212.991506] SMP: stopping secondary CPUs
[  212.995964] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..c87c459e52de 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -731,14 +731,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		/* compute hardware counter index */
 		hidx = info->csr - CSR_CYCLE;
 		/* check if the corresponding bit is set in sscountovf */
-		if (!(overflow & (1 << hidx)))
+		if (!(overflow & (1UL << hidx)))
 			continue;
 
 		/*
 		 * Keep a track of overflowed counters so that they can be started
 		 * with updated initial value.
 		 */
-		overflowed_ctrs |= 1 << lidx;
+		overflowed_ctrs |= 1UL << lidx;
 		hw_evt = &event->hw;
 		riscv_pmu_event_update(event);
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
-- 
2.34.1


