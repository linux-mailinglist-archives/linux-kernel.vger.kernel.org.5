Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31F7D9D35
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjJ0PnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbjJ0PnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:43:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F0121
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c434c33ec0so19257025ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698421392; x=1699026192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W9K1WUX7xqfrQAt8QwBmELFBTwIcr4D86Jl4GnCkM4=;
        b=h+XFnV1+jn8ECK8Kag4UojjMfRME9WIvP88Z9J4hMYunakKrwo6q3uTK4AE8zKbvwH
         GmSqKKMF03YMUOpiMxV11Ggg6pG59efeWBUoWVQkcq8o9mAXk9o7nxlUseNMsiDa/oQq
         NzzIGMiASjkL1sX35lFCSmBP9OL26bQ4ptXuRN5fqBucelsPzD6BgWbWFv9+ZJE5Z0LA
         M1mGtg+SmEl0KCptsYsvqxIF9AqOlLVZaU0p52x1g3sBXFa9xpiD4n5gAHItnWfU5s9k
         vvQdCbczzBCKoowg8m1KeUzYq2RTCQzlL9osTntArAg4l4q+qEl6AOeKh2coBky7s4K+
         RoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421392; x=1699026192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1W9K1WUX7xqfrQAt8QwBmELFBTwIcr4D86Jl4GnCkM4=;
        b=Mmr224InFWKD+Ro6fP/cq4PuZkFL7ro99O4saBLEjqX5Gn1ZRkquB2NXKUBXRWeWpv
         cc0SSGJACvooYL6FGcgDP1n2Dr+5kOOlRLQctoQ/N9Pwrj7VVEYvpmNdXV3gJRkhb12t
         7VCiiIbNM9SLcuvcBGJ8QInu5SKWP5GRN67/DgGrlNsDS1KOtgTUWDtxEcG6J5R6m25/
         qsCBayN7NV0PTATpnHrwraYGe3ZoyZQK4aFPxw2zdeeOD3KCJA1hdBTTSaCw0DYczlW/
         FkN1WimGo1lhi53lZrQ6GKDlHxJJl1fa848/uHBF9Ae6pptyZz7+xVFNsuBvjc/3Qke2
         AVZA==
X-Gm-Message-State: AOJu0YxQE/YJxYq6r4/WFH6dTj/zmXERNr2SgcVRzHs5TlFB57no3rB9
        rLszHLAuwj5IYtYQI2DwVGhA+Q==
X-Google-Smtp-Source: AGHT+IGOswDgfUTCUoK516/BHDWmHydqTfz8QQKShAicFP2dUFhiT9HYYFXT4f9emNAzpG1L2TXq4A==
X-Received: by 2002:a17:902:dcc5:b0:1cc:b3f:dd81 with SMTP id t5-20020a170902dcc500b001cc0b3fdd81mr2446973pll.67.1698421392288;
        Fri, 27 Oct 2023 08:43:12 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001b9e9edbf43sm1729246plh.171.2023.10.27.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:43:11 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 1/2] RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
Date:   Fri, 27 Oct 2023 21:12:53 +0530
Message-Id: <20231027154254.355853-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027154254.355853-1-apatel@ventanamicro.com>
References: <20231027154254.355853-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
for HARTs disabled in the DT. This results in the following warning
thrown by the RISC-V INTC driver for the E-core on SiFive boards:

[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller

The riscv_of_parent_hartid() is only expected to read the hartid
from the DT so we directly call of_get_cpu_hwid() instead of calling
riscv_of_processor_hartid().

Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c17dacb1141c..157ace8b262c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -125,13 +125,14 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
  */
 int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 {
-	int rc;
-
 	for (; node; node = node->parent) {
 		if (of_device_is_compatible(node, "riscv")) {
-			rc = riscv_of_processor_hartid(node, hartid);
-			if (!rc)
-				return 0;
+			*hartid = (unsigned long)of_get_cpu_hwid(node, 0);
+			if (*hartid == ~0UL) {
+				pr_warn("Found CPU without hart ID\n");
+				return -ENODEV;
+			}
+			return 0;
 		}
 	}
 
-- 
2.34.1

