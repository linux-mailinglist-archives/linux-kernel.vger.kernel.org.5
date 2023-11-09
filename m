Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834267E651B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjKIIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjKIIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:21:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B8272C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:21:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso358532f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699518090; x=1700122890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx8fHoMz9t2Gib58EAFChiWLDxqT6xmc1EVOXsB54GM=;
        b=ZtTFvv8CBmG6dRmzK6orXMEFlvPm/Ycm6ZJWDAV+LPbjvJiePcPJdLY0Xgxtm6bwU1
         HTYWGVgSsqPCq+6Kru7F/J4tN/8d3plD40iFXulyulh8Z60grWX5Ue24nGvr6eJXNBDL
         rrZWrdtx8moCxVZwnO/etMCgJGguHoXLWZgB64kkBgoOtxxQaR9DF+4PXdMyVe9Qlc3a
         uPFTVBQugVfRpUvzATC6So5eAms++9E8tllM8yLHE6RWdfy53QQBi8GQH8mBYm5NNsaS
         79RqonI+wc5EqRkuXlxB8KroV2dJ0cU1v0DTgweW7TUxxM0ZfueP/BDGH9b9Dz6bBYSu
         srpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518090; x=1700122890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zx8fHoMz9t2Gib58EAFChiWLDxqT6xmc1EVOXsB54GM=;
        b=RYa9GmujgtWewv58g68LfcQF/mlVVtWsc2tyrRreMwbbO83YsLFiV+q41CRxQ0NX5r
         3/jFDB3nljCkWDoVqFaKOEkvXw7TSgSmegYBBSZuf165nhLhwN5l//77MFvlJKJDGUp/
         uQ3ofKEbi9syo1FXaDfGL9AJJvKFKvKXWU9/3I6/owI2D65UZl+d/8hvxaGDHsUmag7m
         zOG/ExuYUxqF/fD8Mxit6yUVbF5uI/62xp6sAdvRhe52xQGaQe4c8twyKYrvX8xnB1N8
         Q69n26P4BxwLEFp+9xhCJz1rPX8ZHAfVbQEBcqCioffBhZ5N/o6+FNRXE6mw1igz0vRA
         p4Mg==
X-Gm-Message-State: AOJu0YwWWnpPiduyV/Dyns/MRFsvdASRuBg5A2MHqR0UovJ0WS5vt8wz
        5JmUG1dJGPAxUkth8aAfFUKuRA==
X-Google-Smtp-Source: AGHT+IGniq9nlBb4PH71R4r1mS9EUVv34YGMqQ4t648eQ9pLjugNiZlIlsamHM2xFhcJMWzKwDzDCQ==
X-Received: by 2002:a5d:4352:0:b0:32d:bc6e:7f0d with SMTP id u18-20020a5d4352000000b0032dbc6e7f0dmr2702303wrr.18.1699518090397;
        Thu, 09 Nov 2023 00:21:30 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000181100b0032da6f17ffdsm6821506wrh.38.2023.11.09.00.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:21:30 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] drivers: perf: Check find_first_bit() return value
Date:   Thu,  9 Nov 2023 09:21:28 +0100
Message-Id: <20231109082128.40777-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must check the return value of find_first_bit() before using the
return value as an index array since it happens to overflow the array
and then panic:

[  107.318430] Kernel BUG [#1]
[  107.319434] CPU: 3 PID: 1238 Comm: kill Tainted: G            E      6.6.0-rc6ubuntu-defconfig #2
[  107.319465] Hardware name: riscv-virtio,qemu (DT)
[  107.319551] epc : pmu_sbi_ovf_handler+0x3a4/0x3ae
[  107.319840]  ra : pmu_sbi_ovf_handler+0x52/0x3ae
[  107.319868] epc : ffffffff80a0a77c ra : ffffffff80a0a42a sp : ffffaf83fecda350
[  107.319884]  gp : ffffffff823961a8 tp : ffffaf8083db1dc0 t0 : ffffaf83fecda480
[  107.319899]  t1 : ffffffff80cafe62 t2 : 000000000000ff00 s0 : ffffaf83fecda520
[  107.319921]  s1 : ffffaf83fecda380 a0 : 00000018fca29df0 a1 : ffffffffffffffff
[  107.319936]  a2 : 0000000001073734 a3 : 0000000000000004 a4 : 0000000000000000
[  107.319951]  a5 : 0000000000000040 a6 : 000000001d1c8774 a7 : 0000000000504d55
[  107.319965]  s2 : ffffffff82451f10 s3 : ffffffff82724e70 s4 : 000000000000003f
[  107.319980]  s5 : 0000000000000011 s6 : ffffaf8083db27c0 s7 : 0000000000000000
[  107.319995]  s8 : 0000000000000001 s9 : 00007fffb45d6558 s10: 00007fffb45d81a0
[  107.320009]  s11: ffffaf7ffff60000 t3 : 0000000000000004 t4 : 0000000000000000
[  107.320023]  t5 : ffffaf7f80000000 t6 : ffffaf8000000000
[  107.320037] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[  107.320081] [<ffffffff80a0a77c>] pmu_sbi_ovf_handler+0x3a4/0x3ae
[  107.320112] [<ffffffff800b42d0>] handle_percpu_devid_irq+0x9e/0x1a0
[  107.320131] [<ffffffff800ad92c>] generic_handle_domain_irq+0x28/0x36
[  107.320148] [<ffffffff8065f9f8>] riscv_intc_irq+0x36/0x4e
[  107.320166] [<ffffffff80caf4a0>] handle_riscv_irq+0x54/0x86
[  107.320189] [<ffffffff80cb0036>] do_irq+0x64/0x96
[  107.320271] Code: 85a6 855e b097 ff7f 80e7 9220 b709 9002 4501 bbd9 (9002) 6097
[  107.320585] ---[ end trace 0000000000000000 ]---
[  107.320704] Kernel panic - not syncing: Fatal exception in interrupt
[  107.320775] SMP: stopping secondary CPUs
[  107.321219] Kernel Offset: 0x0 from 0xffffffff80000000
[  107.333051] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 439da49dd0a9..93d729213140 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -687,6 +687,11 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	/* Firmware counter don't support overflow yet */
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
+	if (fidx == RISCV_MAX_COUNTERS) {
+		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		return IRQ_NONE;
+	}
+
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
 		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
-- 
2.39.2

