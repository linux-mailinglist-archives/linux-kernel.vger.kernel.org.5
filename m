Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A07AEF47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjIZPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjIZPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B600120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3200b181b67so1192110f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740636; x=1696345436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plk1Hu+6o5eXVj2RFLi33sYNLLeCeOc6UN77fu78+Xg=;
        b=XyGFm7CDlljALS2QDAY5KtQ4V8TiYkjMIj42Wv28D28oi0yDG4lBsWLKIT118S7UMh
         rw5uIvzTi7EW2UypRlFzedrt9G1HOGYSlbcyv59/bRD+2E/7xTa9BQItjYcolFwnawzS
         gHFzmNNwFcnqM1T/G+puoSm3Y7dkUuXiRup2G+hF7+Cuzol/dmN8jZ9uUXABswxMt6kR
         7dJgwTbhD6JhS/KUMQHBqB0v8VmH/yXygByRAK1S/rhu2q5Xr5QtTcU5bLW86Hxlqb7I
         JdhSYLWy4aB40NasJXMN9KZUGW2Co2V1H0YYvGbqWbsjPr8kMRu2Yuvfcm6OuDfpwIOg
         h01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740636; x=1696345436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Plk1Hu+6o5eXVj2RFLi33sYNLLeCeOc6UN77fu78+Xg=;
        b=rT35JwsPq3LMIH3VuSbUc/FQkazixQxpL1uEzQOjqwaUpY/DwYC/IDEciwWho4Jczs
         fxaLDSP/Ihwo3LX0I2dbeyTqqoeJqzU/Bt0gv2rSklPdex/ldTXAG5UBQ3rHCD+NaHDi
         xDcW0HQ7ovRBAPppbdJuMxbkBPQJhJOoUk7fQdbiw7QdNZC9IG8WFaen5Ul40h4kdo3M
         gS0XIMsVq6P2rIOgHvn7luajrWDMQ/aL9xWSYMl8y2K8gtBlG8nUtrN19NT0heqFZpym
         87a7kG/EBM9Tzbf1TUNUTnxltSscLCHUl3cICTuPRjdWtl6jA2RZK5/9Ay5/AZh6tDUf
         S7Yg==
X-Gm-Message-State: AOJu0YwiUtZ9T/Hm1CulGjeEXc9l1rjg/IWEkRvKUnYIHpbtP6JU+ZjG
        VXwZlJFa6AC8NAia9XvIX7tM5Q==
X-Google-Smtp-Source: AGHT+IGiGLM2tQNC0LHIOSMpA2Dcs0WL1ooiBKmdZNYUbPFyZ9WG+S8DbiY2Rr8TxTzPGCIQ87LWlQ==
X-Received: by 2002:adf:f3d0:0:b0:31a:e772:ddf9 with SMTP id g16-20020adff3d0000000b0031ae772ddf9mr8993186wrp.4.1695740636702;
        Tue, 26 Sep 2023 08:03:56 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 5/7] riscv: add support for sysctl unaligned_enabled control
Date:   Tue, 26 Sep 2023 17:03:14 +0200
Message-Id: <20230926150316.1129648-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sysctl tuning option allows the user to disable misaligned access
handling globally on the system. This will also be used by misaligned
detection code to temporarily disable misaligned access handling.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/Kconfig                   | 1 +
 arch/riscv/kernel/traps_misaligned.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..3515510fe418 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -157,6 +157,7 @@ config RISCV
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
 	select SPARSE_IRQ
+	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 041fd2dbd955..b5fb1ff078e3 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -396,6 +396,9 @@ union reg_data {
 	u64 data_u64;
 };
 
+/* sysctl hooks */
+int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
+
 int handle_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
@@ -406,6 +409,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+	if (!unaligned_enabled)
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -502,6 +508,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+	if (!unaligned_enabled)
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.40.1

