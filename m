Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21C80FB99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377505AbjLLXvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377507AbjLLXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:51:02 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28946BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:50:55 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d7fa93afe9so4607796a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702425054; x=1703029854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp9tJj1SA2bMEiEs1rPeqlO2QZ9OUerkC/ZIE58TG2c=;
        b=S7CJJiQecN5gJhEqxLA/wZb/buP73t1Q5veqBJUD38KyH2gGXp32vGBlNdvkFbAXgl
         /IlGziOZmxD/hpbLCx3YYmNRleGZolg1C1/Yy5EOtxq5VkuYi7kXuvqMkdAC8D1td9vL
         F6OCl+zYDml/lTwBx2p7MvEY6RgJBlOl/pjITbPdRvPWWiyAAlYOZwgvNBMkaorS0zlp
         PItGV5x8emhMmQa44Bbq5DVq9rLs5awroxUG97IpUnDvhN8rVk7rwNS2UC9UfZ0fZiRR
         1ENpeu2c9UlQK1F31T+qSbYpi48s/trLsE8FHpl9B82ikFZDNMSouEG1fAFFY6lCtaPB
         FvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425054; x=1703029854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp9tJj1SA2bMEiEs1rPeqlO2QZ9OUerkC/ZIE58TG2c=;
        b=ZYy7U/FsU37qIAo03woVKpVOvEx2pJUpufU73dUcHstry+uA/Y6PVOImSwefLbYgJY
         xBGrXJ1bDH2EpPM37E9FFFF4Lllz7XxPgocztwRNNPViMnHhElZiYjb5ZVyvtfAE7ATn
         pmHHBKl8x6IClSA2NGwieAqobooqVKshSEhks2dEePAK6Q0MTie5T8+Vy8ANZozK9K8H
         5yFbto13aJESfod4XSmvQihXwAEbOr6+ng5Qrtnq2CUJqXrq1LDfJfLKrP5nXOki+hNM
         TGf0R/WoSexIDnk5VsYsGHqYq72ULW2D5oNowBkAmoed8An4SJu9kICyQqsQGekrwmkQ
         7dpg==
X-Gm-Message-State: AOJu0YwA0sYD7QCyx3O2LD9EhZVtblF0kaeeVZZ8caE1qZOkPVgDlcgZ
        h1+l6Gel8+Ba/QlLE2SRvduAYA==
X-Google-Smtp-Source: AGHT+IGh85uH463Iu9D54CRbtbVHNWF3hVBSci6l6H9BBvasbfpo2uUNVt4CcgVWpqRZVCZKUM7zRg==
X-Received: by 2002:a05:6830:1e04:b0:6d9:a337:b639 with SMTP id s4-20020a0568301e0400b006d9a337b639mr5749974otr.60.1702425054446;
        Tue, 12 Dec 2023 15:50:54 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m19-20020a0568301e7300b006b9cc67386fsm2487295otr.66.2023.12.12.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:50:54 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
Cc:     Deepak Gupta <debug@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] riscv: abstract envcfg CSR
Date:   Tue, 12 Dec 2023 15:49:26 -0800
Message-ID: <20231212235003.2036221-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212235003.2036221-1-debug@rivosinc.com>
References: <20231212235003.2036221-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch abstracts envcfg CSR in kernel (as is done for other homonyn
CSRs). CSR_ENVCFG is used as alias for CSR_SENVCFG or CSR_MENVCFG depending
on how kernel is compiled.

Additionally it changes CBZE enabling to start using CSR_ENVCFG instead of
CSR_SENVCFG.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..b3400517b0a9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -415,6 +415,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -439,6 +440,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..98623393fd1f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -725,7 +725,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.0

