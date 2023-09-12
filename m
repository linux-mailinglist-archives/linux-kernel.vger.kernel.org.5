Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8C79D811
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbjILRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjILRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:52:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA6213B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c336f3f449so51730825ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541117; x=1695145917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqTrA/em/7YP7OpnvHuiTizJO+kQoS+OxvFJurohpH4=;
        b=hm6BVyYZwYf2nDuxAk7P0BzSqkG/XfT4F7k2Qb4OEA2WTvQBHvwWa140YoVrWHC2SF
         uYvNFmovO3JqyARCcau1w8oCBdB8NMVQaeqgAjnGNuf2NmOJ3jAcSaRNDEql6WGwV2fr
         4f+udYXwPGJe2UltmpzJa7z8cfKisVLdC2Y9WcfS27fg/KpuqtLCpDKOwSVQG/LeIom+
         zZKisk5bzWTDnHp6y6L8OfYeFJdHk4e/6V+E6iB8+VuXIDQIRfmzIeeNVCuBVq0yXipG
         hitO37fz8yOMdTh6J/lorsSSrbOb/Vxe+T9wQ86Nk9RZozUD4SL5yHJcp5tfH7Mm2hBO
         iYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541117; x=1695145917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqTrA/em/7YP7OpnvHuiTizJO+kQoS+OxvFJurohpH4=;
        b=q61e3bgcQ0fMzgb3OAZgp7p6BugVPrujaqzfV8UMOZcH1UxKQqrI98JLWssDOrUiZb
         Lt8BXogeNfbky4FOWivJKWdyjvMa/CjuDsmdUDWk8n7bvnNZ7wod48CMLBtegxuEE7FW
         3+FBkskuJJ99Ylwrlw9DQMQe/M6k+Isc6c0vIZ/2BEE9ZL2o4MxaIzSXrta/LiBNYCZi
         7+Sb8UXyvC/LkG90xiBjMjuPxvC2Xx45bjQXhD9CiFRKtHdHbR4RZun9JgMZKwB8x52L
         v8FMjSwiJpUlwW4t8HDe1r/xafI8y64dZYy4NQH3jTBVjaxYu4KNF17h+AvJSfwZ8ybn
         G7pg==
X-Gm-Message-State: AOJu0Yw0WdqZOmE5DBHpjrlrvTZn30Zyp/MBZXxdmmUge4gFFlS7I5Zf
        j8MEtsYkLyVcskpd6zQbnctDmg==
X-Google-Smtp-Source: AGHT+IHOMQAXHvGEr2Yq1QZKOwigoSQ0NlNzZNLT28V0wdL+L7WZASn1nNWQSRzQerV7jmwBNx3jZA==
X-Received: by 2002:a17:902:d2c5:b0:1c3:5d5c:cc99 with SMTP id n5-20020a170902d2c500b001c35d5ccc99mr369320plc.36.1694541117116;
        Tue, 12 Sep 2023 10:51:57 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:51:56 -0700 (PDT)
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
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 16/16] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Tue, 12 Sep 2023 23:19:28 +0530
Message-Id: <20230912174928.528414-17-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..6f331ac31d27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18410,6 +18410,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

