Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1E7B600C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbjJCEqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbjJCEp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:45:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590DCDD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:45:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so401434b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696308344; x=1696913144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=NpXDBuxGGhPQ5kCIPJWcLPkytUmI6tmbzMl/G+Y3fx4kfMmbKk8fr1Kg5cAV1vs4Tu
         VQfxEB79xsivM4DQ4hJcDFtQA0G9WgctuqLeHnn4QyLYaD8VoKkJVj6d4LhXM8fL036r
         E6+PzPejJ/0h+6Mu+IqNXfqrKjnuS6ZvejVt+zeb/NvC8qOS0ogCyZa+p4tEIK62vN57
         8R09CyERAXrjrH7KhUhsWg4grPZMBgm1gRV19SOQhGWFDXLhjNdEX21dAHyu/qvVQ4bq
         sQB4iFmnJ0UDGIxJJLq9A68ohdCCVqGAU1fcmxje1Bv0ERRnlqsAWbQoc6DfoxPZKupa
         L6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308344; x=1696913144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=LsmNWCwS1RNYFrxa6Q4TLo8xgjNLPdvk48xx+1alwYlM7jzEQfcjC1vQPJKZG4qidR
         MHMw0gGo+KlWPckRSFNg4jEEp1CLJZN6OtyEKjChzNSBIO8YOeAnBCO4nReVX4AlKC5E
         A5dPIJahmAmJ80M8jj0zIJCJgAaT6SrrpKUAN+09g0FjD+4pWzhKaEXcApr6Amipa3lB
         MDEA3wewIzAvEQrDjYR5sRK+JLTARuP4Itt+k+939oykcls8x/5oGoSXN1O8nZX5cDEr
         xcDhOp7EMxm++S5WWrBG/ETx55DFcxbLZzHu/RiQYrPpaSKGF8JmxKCaO1YHd8WUpRRB
         v6AA==
X-Gm-Message-State: AOJu0YyQs5LYZz/rhZyxkxSrhNxFGWWmcXJ7CGfqMrxFgc7X37XrzBub
        cDlNKorOByXweP1lVbRZPgN5fQ==
X-Google-Smtp-Source: AGHT+IEPf6VZJFHiNyB06jIOgpeLIxIG7B35aAuu0113CgIcNf9v+plMLjwZEC9Lc1L+0gdLK8AvRw==
X-Received: by 2002:a05:6a20:3ca1:b0:160:643f:ad54 with SMTP id b33-20020a056a203ca100b00160643fad54mr13378897pzj.20.1696308344308;
        Mon, 02 Oct 2023 21:45:44 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0068e49cb1692sm346421pfo.1.2023.10.02.21.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:45:43 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 14/15] RISC-V: Select APLIC and IMSIC drivers
Date:   Tue,  3 Oct 2023 10:14:02 +0530
Message-Id: <20231003044403.1974628-15-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003044403.1974628-1-apatel@ventanamicro.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..45c660f1219d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -153,6 +153,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

