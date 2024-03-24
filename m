Return-Path: <linux-kernel+bounces-114052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A2D888F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2536B28EA49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE12308BB;
	Sun, 24 Mar 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1YXT89R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43FE12FF8C;
	Sun, 24 Mar 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321334; cv=none; b=gF10x/JM4Gv25jrXwmLGJMZ0Sd4NZLjxLg8I3Kfm68f9oXfZKb+AkjLJdD9WNmcsrca50StojTfjGsv9qBPNxKN8y8HjbD//oXEk/dmgzqEW3enUm//7mE8M7KNihL5TTzdTDHjFDLRl6oyk7ojbMYKLZIC0T3imXEGeTkJN/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321334; c=relaxed/simple;
	bh=AsxC7B+GPHNTX2xciWRGMv74b90S2K8qA2lh8E+xwjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4A6VektDiRpnWtjyvNoIHGQP2wqop4T/YZnmzvBXitlNamY8+7djiKOzZRdP4hy6t3hfII3Ol2e7OVfZDLGEwuyTuc5QdNPfMYby+nmKqk55U00ly+mEq8VLVeBIAQAgidhZTy18NsTDsAFsiNxgXuplTRYMhv3JMwXg41FRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1YXT89R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD798C433A6;
	Sun, 24 Mar 2024 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321332;
	bh=AsxC7B+GPHNTX2xciWRGMv74b90S2K8qA2lh8E+xwjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1YXT89REjo8C2R2O5oFoTvjlb1i8Qb3uxlRKSJYS3ousb4j0+DhiHcYUe2MFjWXm
	 dlTLEzrfIgQ/GGOiSmBh8SI0UCYomBf8zKmuwCMe3kIfGkLkoPy80bdFUxwy1CMza3
	 EO7HrFDu9XGwQ6Ooc+1BsuQC6e/GAcqLbAsUCTTWO5BXCoRErRo3ghLvVie68PYU+q
	 KWpvLZlfK0Iw6suZBK3xELBeofv3sd6vqQ8YgOk9K8wdLAmqlOmqfXaBNl2Vyd5HV8
	 ONc9sYjREoRe5kUekqctXTDQkBi9vyR+BQVpX41evlUy3DnjJOBoq/oSOnD7Ojl85F
	 iBy56SOQ73/nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fei Wu <fei2.wu@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 056/638] perf: RISCV: Fix panic on pmu overflow handler
Date: Sun, 24 Mar 2024 18:51:33 -0400
Message-ID: <20240324230116.1348576-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fei Wu <fei2.wu@intel.com>

[ Upstream commit 34b567868777e9fd39ec5333969728a7f0cf179c ]

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
Link: https://lore.kernel.org/r/20240228115425.2613856-1-fei2.wu@intel.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/riscv_pmu_sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index cd8a2b9efd787..d80b4b09152df 100644
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
2.43.0


