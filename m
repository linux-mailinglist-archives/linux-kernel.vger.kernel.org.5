Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121D97B834C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbjJDPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbjJDPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF9C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651b22977so4786685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432469; x=1697037269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcEUkxfHErwG8tq/zMZua9Au/w+pS7+db1U/fyhODns=;
        b=GPEE5tKW/8Ms2NiF9y39KuR2HdmLb3no++VZaOwGz7y63NGjQEOCVudFne3yhB/HsK
         Pkmy9BpRApNtyOe305uADn5PhTJzRKpQa5GMnVpOcpMA77WA9stvBaVgv6562yutpIaT
         BfWbNq6Yx+ULq6YiACVOZaDofdeOMGhe9kh2AQdhzHtudE/AmR54qGPp1ZdCLWnkGZ6L
         AhRLouD9LNKWdb8/1pIcRwnnMnx4PacLY3kggulunoR3Hf+2hig5nELR6VpM9BLA+G9P
         J2ecPLsfJTZ5RfIJ6P7T+6qs/3fpl65HT5Z0aQlzqsBPE6ZcL+J6mzG7cF9QAWf5WSbQ
         zvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432469; x=1697037269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcEUkxfHErwG8tq/zMZua9Au/w+pS7+db1U/fyhODns=;
        b=sxSOb4dgHnyO8vqdAA9Z+jTAmQhbWpboHgDdOkVnPJhRuIflpBLtg9mdT6vq7rqseX
         XoLCmSoY8AEfemt4Zz3LlQ7Y2KzJaBuIxJGbDkAghPseA+Q/62A1I1tuBL02es7j/ADz
         wrwB5/+CPDHgn1PovA5SC2MGhkM/sexfxeozNnObA5NNDmhhxrXGqZ5CQZAB7riHauCi
         S25gycymCbE/mw56AeOxh87R9b0se//rv+94pF2G/ij6pyrPUuOHfgrp327mWSgydlpg
         /IYdFXdtJcn5En9vEgd7L0UxPYVYPiihHw7Oi6+X5DoW0XnLiOpmBverYx+/pC7yFIpx
         HQRw==
X-Gm-Message-State: AOJu0YzCmBdLwRoTR1a7g6x975Zs/faynSO7yYIFgkIdeLruJvr2KzsQ
        wQS1Z739VgvqxW1V0g3LtHTp4g==
X-Google-Smtp-Source: AGHT+IHFWUl+0+sO6traUtAHPwk77+gDj/OtZoEyAvGn4ZMrYs4/3PFND9HQ+2oEvAhOhQjndgqGJA==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr2613227wms.0.1696432468784;
        Wed, 04 Oct 2023 08:14:28 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:28 -0700 (PDT)
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
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 5/8] riscv: add support for sysctl unaligned_enabled control
Date:   Wed,  4 Oct 2023 17:14:02 +0200
Message-ID: <20231004151405.521596-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 6e167358a897..1313f83bb0cb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -638,6 +638,7 @@ config THREAD_SIZE_ORDER
 
 config RISCV_MISALIGNED
 	bool "Support misaligned load/store traps for kernel and userspace"
+	select SYSCTL_ARCH_UNALIGN_ALLOW
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
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
2.42.0

