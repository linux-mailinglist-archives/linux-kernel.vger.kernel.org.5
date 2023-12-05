Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F1804537
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbjLECno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbjLECnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:35 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27ED199
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:40 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d8750718adso2404755a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744220; x=1702349020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARpkTD0DGKCutL1TwjMjDMoOjcqYmkFa31lyR5g4T2Q=;
        b=KOMlUAwvldFKgdnWVLDmJTfUo6zxkGezTTyO5DgVzigxj+xvrmKAC+oVLWVemfsfUA
         F5nHpRor4TACjK5jJy6oVHWLsRnM1veLLA0pTS4cbL4jcLcpn0jYRCLF78cpnReK07Z0
         tXP1FKMdOW445sZnx7co1epZcmc7pPcl1WWRDcvgIaa7sFRglcR3LsI1LL9j1FpnosP2
         WCbYg0gE24RA1MVkxwNI+iV/C3Rc+SOU8ez5dnWQBk+NYgiDuJwq5HX8Em4/7APsAKAD
         L1o/ESgxZyC6rKs02dT7GjK1oHgr5X2rDDqlSlIZXfA9YftFZ4DMD6GxGylB7vr9nwm0
         5TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744220; x=1702349020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARpkTD0DGKCutL1TwjMjDMoOjcqYmkFa31lyR5g4T2Q=;
        b=Bu5dLdL6/WaJXURFtvj3ZsUYRkqf9+xH2QktvAU6SKOoXuhiyWCITQ4yk1dF/vzCSD
         L6/gUlDLI9fOkEkl/OJLmVfKHaFLC7E+jW8rQ5UlBPBSqbOl3M2PXP97Bq+IQCY4SrkD
         bS/+9hLhPa5qqkbqzqT0UboKlqNwd2+Yg6QMDvFFRlL6eG52EYh7aL+yQl0+GW+gJSPO
         p74b0xHZu2pl8iX9x8FKmxA0ILRA5nk7dnh5p+nFcfPoXqCDJw2mxVx3NLZ6ddqnh2EU
         QVglHD3DK4mWVrKx2GP4VbeTSJ7+pofELXOAgJyRkzcZp9OIjmvOoDWfnkXT+KfoSRt3
         uHVA==
X-Gm-Message-State: AOJu0YxmQqTfVTliUUFR3u5CKmTlLazVT6qkVlfUcVlozOkBW2x7kF9L
        CYF24Ja37DK5tWGDqk1nVSgUFafaiq2VDR3cu1D6TA==
X-Google-Smtp-Source: AGHT+IFXeXXz41Hsj4C/GCefAovxqAXWbbpNAzmIuIuJp4iWAyn+2eqWNtIeCNa4tWlwO/mFe0g5LA==
X-Received: by 2002:a05:6830:61c7:b0:6d8:74e2:7cdc with SMTP id cc7-20020a05683061c700b006d874e27cdcmr7785693otb.55.1701744219906;
        Mon, 04 Dec 2023 18:43:39 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:39 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 5/9] RISC-V: Add SBI PMU snapshot definitions
Date:   Mon,  4 Dec 2023 18:43:06 -0800
Message-Id: <20231205024310.1593100-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205024310.1593100-1-atishp@rivosinc.com>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f3eeca79a02d..29821addb9b7 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -122,6 +122,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
 };
 
 union sbi_pmu_ctr_info {
@@ -138,6 +139,13 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+/* Data structure to contain the pmu snapshot data */
+struct riscv_pmu_snapshot_data {
+	uint64_t ctr_overflow_mask;
+	uint64_t ctr_values[64];
+	uint64_t reserved[447];
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
@@ -234,9 +242,11 @@ enum sbi_pmu_ctr_type {
 
 /* Flags defined for counter start function */
 #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT (1 << 1)
 
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT (1 << 1)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
-- 
2.34.1

