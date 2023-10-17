Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8519F7CC32B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJQM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:27:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F254A13A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:27:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578b4981526so3328867a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697545673; x=1698150473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIvH93b/sWVIbaT25hdzz+hqN4HWpQnfh8o78oWByr4=;
        b=H6b8btTW7AKlTGeCKfxtf195fNCmTGTWyh9yQgop5cwrm+nZiHNqAFDvjric98l+1K
         19Y79jsfaBCZq9vJfadtQzDRVu4ZBIl3rVMFS5lUhyH7sUFUQDMp+djpS1CCEdNym0Uo
         GzpujMIhOP5GHQW519IJvrmaCsD6WEs4MMlZpiD30lm7nCHRDg7TBOUjD8TKdJY96Xzy
         svXci8JC7LPTf6XezShAFBLLNkBbReuTj/hqAjC31u8l7HpPPgS3Fe7NfWiIcNzHLM6Q
         DoMNtG/3SrgDhvvL4jsSBhUuziT1+MywNOzHB8frNnwbq5Lu9KJLDfMHOHWaqyRZUzgV
         42gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545673; x=1698150473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIvH93b/sWVIbaT25hdzz+hqN4HWpQnfh8o78oWByr4=;
        b=N8BGugYBF8463syuJjynxV9T/2pqnfLNcpuOmAqh5GIIDbOKAJ9uQGHxUH/C8NeU98
         ecLRyJlaZ8H1i8k1TaxSQ/xMGwPe7XaDdhtNy3lEa3mv2mT5E0X9pEgO/pCMD2D0qTE0
         2r5viQroBb6QrHeT3Wc9ysvTQM8iDyAtks4iflFyvEPVgQsIUhkMq2x74kQOrnSqm/yk
         kx912PwgSMR/Q9fGb5C7q/UC/5TlIyHeE/ONdLY0zm+Hs4+Ct1PipoXfrElZ4thXGY1X
         YN02iw8CIdOHbYrDBGf70IYQRIF6sEJY54Oq+NItc0o3ib/AK5tgDESosrGxG6OR0Dpc
         o6Ag==
X-Gm-Message-State: AOJu0YxNBdA40jrqmvw+uLOzCGafqVjeBNus3e5CZ9NbGIf9cOy8O0w2
        6YKT6gZhlLBKCc9kQA+595yUwkkTit0n9vx1
X-Google-Smtp-Source: AGHT+IFSw8FIVjPWtqi/0et1umJtbVLACgN66JMBmJenEXVUlttevscGPjWw9ZWjgpb3vwv9ZAN8/Q==
X-Received: by 2002:a05:6a21:1a5:b0:154:d3ac:2076 with SMTP id le37-20020a056a2101a500b00154d3ac2076mr2166222pzb.40.1697545672936;
        Tue, 17 Oct 2023 05:27:52 -0700 (PDT)
Received: from kelvin-System-Product-Name.lan ([112.45.97.252])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001c9d235b3a0sm1406193plk.7.2023.10.17.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:27:52 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] irqchip: Drop the custom fixes for the same irq_chip name
Date:   Tue, 17 Oct 2023 20:27:18 +0800
Message-Id: <20231017122718.5062-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 021a8ca2ba23 ("genirq/generic-chip: Fix the irq_chip name
for /proc/interrupts "), the chip name of all chip types are set to the
same name by irq_init_generic_chip() now. Those custom fixes for
the same irq_chip name are no longer needed.
So drop them.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/irqchip/irq-sunxi-nmi.c | 1 -
 drivers/irqchip/irq-tb10x.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index e760b1278143..bb92fd85e975 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -192,7 +192,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name		= gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 680586354d12..d59bfbe8c6d0 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -150,7 +150,6 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 	gc->chip_types[0].regs.mask          = AB_IRQCTL_INT_ENABLE;
 
 	gc->chip_types[1].type               = IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name          = gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack       = irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask      = irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask    = irq_gc_mask_set_bit;

base-commit: 4d0515b235dec789578d135a5db586b25c5870cb
-- 
2.39.2

