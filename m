Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2875944D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGSLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGSLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:36:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C1173B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66872d4a141so4489550b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689766575; x=1690371375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm/Oy62GG5LOKEKm8aDmdi3uLhhg7069oiCusHUmNGk=;
        b=HdQckYlvZeBySvDiX8tlb1tJ7YW9/2OgiFOly4y3PxePbfYKDn+HFEmstzTYZJSqBC
         OxAaq0MZ4i2ZFoAPOlBLd8QYjG3+ed0xisinqHvrY7iySbs7ahYzBH58RIC0ofjQ1ipo
         Vir0JPZt4msdq30fFWdy9uSffwn9JeCZYig6eE3sFM9DO7AWyr/vyCUA6o1oME01Y+9M
         HyYC5M0RbPuC99buY29YoAJH+O4xWZ5LueWLWTwwoSf+VV0sLfpuEtTUhGDupEffYjj8
         LVIgP11/o+Nf6I1o0X4r9TMXC85qubMxMVan8n78c7815JtIxzLFYzQF4gaj6bjII5US
         vuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766575; x=1690371375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm/Oy62GG5LOKEKm8aDmdi3uLhhg7069oiCusHUmNGk=;
        b=Fqko12v63zAbnyKVaca1fJ2q4RPOMfxj2rtd1E2HCQNn963bpRPfspvVmZhCaXSZyA
         cVQ8Fpz2ubUTln95JzBFOyTCwcqkupRXvMarhSKob4qIUx1bvBrrld06aRGQshIUaBZn
         cDGTZdBn5Udmx0aez2iwo/ZdezjQdKLSZk6b9Nb1d/ZBj0UrW8uVAdCu0sixvzhurvm2
         +o11HMK0hOuVchZ6nNXZkAsJEnS9WZF9ilEMbqBbpm+n90+e2IZoDHEg640/REQfynZ3
         sBW1j6PsojVlC3xLDLBhTEmGEveBdLxWbC2Ne63dm5HMN1FPjbpyh6aUxeXTixAIGnyn
         dwsg==
X-Gm-Message-State: ABy/qLZV3XHFdMiHti81k8f6eWEt/0suPN8GrJKEizBHz0aDUDq2y4mG
        /IepsUp4KjFIC9FWp6xXEs690g==
X-Google-Smtp-Source: APBJJlF9KkVAOZTxPQhHCUYRj/xBbn98tqZ5FCY/+NRn4YJZBXv7vkPAdAECC8UNMIgBibyx8IAUew==
X-Received: by 2002:a05:6a20:1615:b0:126:9081:2156 with SMTP id l21-20020a056a20161500b0012690812156mr2151013pzj.4.1689766575090;
        Wed, 19 Jul 2023 04:36:15 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.130])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00669c99d05fasm3050408pfn.150.2023.07.19.04.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:36:14 -0700 (PDT)
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
Subject: [PATCH v6 04/14] irqchip/sifive-plic: Use platform driver probing for PLIC
Date:   Wed, 19 Jul 2023 17:05:32 +0530
Message-Id: <20230719113542.2293295-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719113542.2293295-1-apatel@ventanamicro.com>
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC driver does not require very early initialization so let us
replace use of IRQCHIP_DECLARE() with IRQCHIP_PLATFORM_DRIVER_xyz()
so that PLIC is probed through platform driver probing.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 56b0544b1f27..dc02f0761ced 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -569,8 +569,10 @@ static int __init plic_init(struct device_node *node,
 	return __plic_init(node, parent, 0);
 }
 
-IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
-IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_PLATFORM_DRIVER_BEGIN(sifive_plic)
+IRQCHIP_MATCH("sifive,plic-1.0.0", plic_init)
+IRQCHIP_MATCH("riscv,plic0", plic_init) /* for legacy systems */
+IRQCHIP_PLATFORM_DRIVER_END(sifive_plic)
 
 static int __init plic_edge_init(struct device_node *node,
 				 struct device_node *parent)
@@ -578,5 +580,7 @@ static int __init plic_edge_init(struct device_node *node,
 	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
 }
 
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(edge_plic)
+IRQCHIP_MATCH("andestech,nceplic100", plic_edge_init)
+IRQCHIP_MATCH("thead,c900-plic", plic_edge_init)
+IRQCHIP_PLATFORM_DRIVER_END(edge_plic)
-- 
2.34.1

