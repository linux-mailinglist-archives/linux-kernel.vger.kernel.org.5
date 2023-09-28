Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE497B1267
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjI1GNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjI1GM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:12:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDEBE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35133097583so30269785ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881574; x=1696486374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=QlHD7M2VCWNWRy8yCsO63G7PVAUPZfZfl1R8TD9paYKLMAXr65yWcF6OeC4jAaT+RH
         IfK4q9cL0IY3DPEYSPUu8ArtKc276PmJu8axDXLiKDpB0Xqa+xySl7+l1PB6hk6eLaTm
         xFmeaDNyc+genFrQKHcCPQiAFfrVFs8Ec2Mz3SB8FJaTD6PBXBnJSn2BQiX1xAt8NjiV
         pCCHZzm7jv6d6Qrst1lDNahmb/z1DLcMkQ+NA0E4moWuTPKbcr+V55ZFEuEhFG6QP/Mw
         RsrGGhHqUSPNZ9uZlYGpKXmf2wGA4D2ONma9Q57iZYrVI+Phkw1y8Xo3KMR1OF4m6lzb
         pTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881574; x=1696486374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOj9ECaB96rIjjnLWcT6tpDdCA0D2GI5mFoVxJymrv0=;
        b=KZj/aFC+inYnIRTQqUM2pLfcNcMUUBBE3Uu9ZgaP1+o17MFhdGAnF+xAalw4X/BTs+
         4zSh8o5h8aouqsz7+qdNt6wIViMEzpGcLGmA5lgINVRm0iYD3p/oJMpScu2uS/8y+Bwf
         V3fHZ1XjqiXw0JMpvIYYZY/xJrR+/8C4t/BlBXY7TXf6qOW2xRdvSy6a/mPHiWuOKlyV
         gKtY3fjgmoY1Uh55qfUkGb6jt/RH0r7MeXp7AOI//y/JRJ5JlOpDw7iOFJN6xxCXcpYN
         5ohBhKKgdu05Wb8fcJoB3VJQSBpdZEgKrlWRmtwpg/tNt75YFscEThlYp519WroDhR61
         y5Qg==
X-Gm-Message-State: AOJu0YyN7jurS70QFwQo9r9TmCllj70+O6qBouTNSnI3evpi+NPYjPxl
        27xliihbTO0buiNyRpzgSO19Fw==
X-Google-Smtp-Source: AGHT+IFBx1Jn5HFo6/K2zSwRKNfk/Rx/Wfu++Z7gO+1vnjnfhqhj2s5cTSNwlL693OWuuZEVafPJ0Q==
X-Received: by 2002:a05:6e02:1c22:b0:351:4b68:ec3d with SMTP id m2-20020a056e021c2200b003514b68ec3dmr232692ilh.16.1695881574077;
        Wed, 27 Sep 2023 23:12:54 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:12:53 -0700 (PDT)
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
Subject: [PATCH v9 04/15] irqchip/sifive-plic: Fix syscore registration for multi-socket systems
Date:   Thu, 28 Sep 2023 11:41:56 +0530
Message-Id: <20230928061207.1841513-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
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

On multi-socket systems, we will have a separate PLIC in each socket
so we should register syscore operation only once for multi-socket
systems.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e1484905b7bd..5b7bc4fd9517 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -532,17 +532,18 @@ static int __init __plic_init(struct device_node *node,
 	}
 
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state only
-	 * when context handler for current/boot CPU is present.
+	 * We can have multiple PLIC instances so setup cpuhp state
+	 * and register syscore operations only when context handler
+	 * for current/boot CPU is present.
 	 */
 	handler = this_cpu_ptr(&plic_handlers);
 	if (handler->present && !plic_cpuhp_setup_done) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
+		register_syscore_ops(&plic_irq_syscore_ops);
 		plic_cpuhp_setup_done = true;
 	}
-	register_syscore_ops(&plic_irq_syscore_ops);
 
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
-- 
2.34.1

