Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EE7BB2EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjJFIUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjJFIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:20:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7FCA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:20:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1793519f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696580414; x=1697185214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivd7j2peOIOg94hicEYRZDVodglnkivL/ESOnnASd3k=;
        b=VsRTlkPRra/tDkOhYKuTbtc00CC3Km20XISfyGghdlkRyhlLyv1L98ot+MwH4lW1tX
         MSQfU7ZRKYnJjHA4zYy8+aAtQ7UyMk4nfNx1+3FPcrksA3BjGDMThnPCn6QX8Z7P7ReV
         FI/JELDOZxHux+TI4MQmW/ZAQ76j/ZnwsbfG6i+Hn2iUvjCxDPzgK/nn7B6RHKo3Hk7Q
         s323CZY0nebV3GX+U8ADr4dOQaTZIJA9HJXXPs6QvH+xBcL5P5Ei7eMr6aB1dBoXrruA
         tcjR/v0CFYd6IC+D/CxuoQAqw52AW/eHOSGWTYpbQvNj0ctOlzUmgXSoRKW8nS/G6it3
         VNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696580414; x=1697185214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivd7j2peOIOg94hicEYRZDVodglnkivL/ESOnnASd3k=;
        b=XjpiVkCyNWKNqt7JOmyQTIRcECOyAbTcHy1/Y+1UFDyc5prpxLbLhyEiV8J5tVt7o4
         ZFBQSlh/wCeYP/1cgGHD/Qbw5bvVmSsCReLl1uh9bgWEPIyV6H6WLL7kigltdxiWClx5
         GrO00r0yPtZa2gcroz5Yz1ymuqTBSHKek1cTvVbedvPBTux1A5v0NMHhdL32e/+KeBrH
         lTo/nECh0ohzyzaiAREUcjDdo3uZMyOqVE2ZFlL6NoMVAxIiZJG+xH2nHPBcrET2aIqt
         n3RV/MdAnMNxYj57aDXU/wUZVKJGaxd5Jwalhn97HGO/oCpxohDBY6/lC+7Jc1WCPNao
         nG8Q==
X-Gm-Message-State: AOJu0Yy+7GVZ32Z1SeLaBPtv/tSumbvuNoaY9WLY+QTrVIhR+VS5UDQ9
        cSgoCIeAnXLGGKFEd2NTfBCMJXEZz8EL/7B3eUE=
X-Google-Smtp-Source: AGHT+IE1AMKEMxH95GmDTdEVyZcJ7fiTghuZ3x9XqNTeH47qdaIvZlGAwBqLQVwpunerkI4rs14Rjg==
X-Received: by 2002:a05:6000:10c7:b0:31f:f893:e07f with SMTP id b7-20020a05600010c700b0031ff893e07fmr6654961wrx.12.1696580414155;
        Fri, 06 Oct 2023 01:20:14 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0032327b70ef6sm1066573wrn.70.2023.10.06.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 01:20:12 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] drivers: perf: Fix panic in riscv SBI mmap support
Date:   Fri,  6 Oct 2023 10:20:10 +0200
Message-Id: <20231006082010.11963-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following panic can happen when mmap is called before the pmu add
callback which sets the hardware counter index: this happens for example
with the following command `perf record --no-bpf-event -n kill`.

[   99.461486] CPU: 1 PID: 1259 Comm: perf Tainted: G            E      6.6.0-rc4ubuntu-defconfig #2
[   99.461669] Hardware name: riscv-virtio,qemu (DT)
[   99.461748] epc : pmu_sbi_set_scounteren+0x42/0x44
[   99.462337]  ra : smp_call_function_many_cond+0x126/0x5b0
[   99.462369] epc : ffffffff809f9d24 ra : ffffffff800f93e0 sp : ff60000082153aa0
[   99.462407]  gp : ffffffff82395c98 tp : ff6000009a218040 t0 : ff6000009ab3a4f0
[   99.462425]  t1 : 0000000000000004 t2 : 0000000000000100 s0 : ff60000082153ab0
[   99.462459]  s1 : 0000000000000000 a0 : ff60000098869528 a1 : 0000000000000000
[   99.462473]  a2 : 000000000000001f a3 : 0000000000f00000 a4 : fffffffffffffff8
[   99.462488]  a5 : 00000000000000cc a6 : 0000000000000000 a7 : 0000000000735049
[   99.462502]  s2 : 0000000000000001 s3 : ffffffff809f9ce2 s4 : ff60000098869528
[   99.462516]  s5 : 0000000000000002 s6 : 0000000000000004 s7 : 0000000000000001
[   99.462530]  s8 : ff600003fec98bc0 s9 : ffffffff826c5890 s10: ff600003fecfcde0
[   99.462544]  s11: ff600003fec98bc0 t3 : ffffffff819e2558 t4 : ff1c000004623840
[   99.462557]  t5 : 0000000000000901 t6 : ff6000008feeb890
[   99.462570] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[   99.462658] [<ffffffff809f9d24>] pmu_sbi_set_scounteren+0x42/0x44
[   99.462979] Code: 1060 4785 97bb 00d7 8fd9 9073 1067 6422 0141 8082 (9002) 0013
[   99.463335] Kernel BUG [#2]

To circumvent this, try to enable userspace access to the hardware counter
when it is selected in addition to when the event is mapped. And vice-versa
when the event is stopped/unmapped.

Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in the SBI backend")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu.c     |  3 ++-
 drivers/perf/riscv_pmu_sbi.c | 16 ++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 1f9a35f724f5..0dda70e1ef90 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -23,7 +23,8 @@ static bool riscv_perf_user_access(struct perf_event *event)
 	return ((event->attr.type == PERF_TYPE_HARDWARE) ||
 		(event->attr.type == PERF_TYPE_HW_CACHE) ||
 		(event->attr.type == PERF_TYPE_RAW)) &&
-		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) &&
+		(event->hw.idx != -1);
 }
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 9a51053b1f99..96c7f670c8f0 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -510,16 +510,18 @@ static void pmu_sbi_set_scounteren(void *arg)
 {
 	struct perf_event *event = (struct perf_event *)arg;
 
-	csr_write(CSR_SCOUNTEREN,
-		  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
+	if (event->hw.idx != -1)
+		csr_write(CSR_SCOUNTEREN,
+			  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
 }
 
 static void pmu_sbi_reset_scounteren(void *arg)
 {
 	struct perf_event *event = (struct perf_event *)arg;
 
-	csr_write(CSR_SCOUNTEREN,
-		  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
+	if (event->hw.idx != -1)
+		csr_write(CSR_SCOUNTEREN,
+			  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
 }
 
 static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
@@ -541,7 +543,8 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
-		pmu_sbi_set_scounteren((void *)event);
+		on_each_cpu_mask(mm_cpumask(event->owner->mm),
+				 pmu_sbi_set_scounteren, (void *)event, 1);
 }
 
 static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
@@ -551,7 +554,8 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
-		pmu_sbi_reset_scounteren((void *)event);
+		on_each_cpu_mask(mm_cpumask(event->owner->mm),
+				 pmu_sbi_reset_scounteren, (void *)event, 1);
 
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
-- 
2.39.2

