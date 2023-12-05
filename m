Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFCA804530
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbjLECn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbjLECn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:26 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC237A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:32 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58cecfb4412so3525958eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744211; x=1702349011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+doFZUOdGHfe3e+JV/h+u6c2KRCECetYvlqoS/1QVjk=;
        b=2RjRvL92eNsj8HtHxT7D/PACS/tbegyGv34eb3m75Tq7agd1G9fB20BKX5JjPW5CVS
         DAb4/5p40HWJAMhtLajUsKBtxq5kAnZ1i8/2R/fp3GMx3UCfQViIA95TKmPV/GnGUkUd
         mEcjOi4p3oSSBvTagb+1XE9rOVKy5jhnZFaL/3Pe8KSlXf9P4dISyI5x57vKDOS8Qd8t
         SGc9mQz1YVsxSodHQm8Pb6977tfWUCKuLH6xMwmhynKtcXR9LlWmi2M9CXkiqEiY0jk9
         84WG+9kQ47TgOtwhNPRsqjP5fG29G4tC1YWK8pi9J5c0ru1NofGlJNsdhVH1plQftle5
         cukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744211; x=1702349011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+doFZUOdGHfe3e+JV/h+u6c2KRCECetYvlqoS/1QVjk=;
        b=inmg4Ly4t+tI6lOpkGlA0t3MHEiENRuQhzjWQSqQEfZC1sCA3O+ZJrqdUWPXK7I8UR
         HVlnhRT/oITy+IUSFVXwaqSvb44JcjtuI643R2h12xEsmgpxp6djfkVgrLLs2Tf+hVtI
         surwnfGAco+5P6GXVvF+bYDcnXNtEt1JMS7WcYuI3Nw8cew7ZaVErSesCu2u4VtbU+6/
         b1KMO6WkRvobbbTQuygrSeVcMNla25T5QKlFw2ORnSiJCfkJ4kIk2VbruKhKye3GSdt+
         zqQf08E1f2xLXTXyMxhikYATiOCYjApCu9JGJFv+cpY+8duYHyHnNxu9CpwVH/a5ppKW
         o7lA==
X-Gm-Message-State: AOJu0Yy4rV5vvdgkoF1C/Vm7pdEu83IoE/kxhn4jWcp1F6pMW5cjpycM
        W8Dlx4qm2Wu3QWs654ZpcxrQlKFbGhkhYkutF3Kfew==
X-Google-Smtp-Source: AGHT+IESa+uIMlhGJ8omMCACn4oXC680NqScC0tWffrPykeRZIe5TFUQYcAdM2FafioZUI/dBXwO1w==
X-Received: by 2002:a05:6820:2a09:b0:58e:1c48:1ee0 with SMTP id dr9-20020a0568202a0900b0058e1c481ee0mr3283907oob.18.1701744211227;
        Mon, 04 Dec 2023 18:43:31 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:30 -0800 (PST)
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
Subject: [RFC 1/9] RISC-V: Fix the typo in Scountovf CSR name
Date:   Mon,  4 Dec 2023 18:43:02 -0800
Message-Id: <20231205024310.1593100-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205024310.1593100-1-atishp@rivosinc.com>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h         | 2 +-
 arch/riscv/include/asm/errata_list.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..88cdc8a3e654 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 83ed25e43553..7026fba12eeb 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -152,7 +152,7 @@ asm volatile(ALTERNATIVE_2(						\
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU)				\
-- 
2.34.1

