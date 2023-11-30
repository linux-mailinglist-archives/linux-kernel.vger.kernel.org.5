Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26697FE829
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjK3EHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbjK3EHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:07:09 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C9A98;
        Wed, 29 Nov 2023 20:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Osv7Sj7KBzk0d0IQpU
        d2ITh5un8u4/k8C4CnlTjBGhQ=; b=KPak5qleSNGV4u4TydU3I2oZNb5+zRY66+
        ffkJ6EGmhd6cOHxe6O2OkFqI8Cx2NrmkrhPjr3K68imZcUiEe9jVDwMmBjHNbJQ2
        yVy0AuSot26bt5VDxQho400l0x9pgQ8NoBiQWPpQEtUccJ/id+ZinRRvXANh9/ta
        1/mOLvkKs=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3vh1UCmhl87xBEQ--.48084S2;
        Thu, 30 Nov 2023 12:06:45 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     tsbogend@alpha.franken.de
Cc:     fancer.lancer@gmail.com, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [irqchip] mips-cpu: Add error handling in mips_cpu_register_ipi_domain
Date:   Wed, 29 Nov 2023 20:06:42 -0800
Message-Id: <20231130040642.36133-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3vh1UCmhl87xBEQ--.48084S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr45uF13KrW5KF13ZF1fJFb_yoWkJFgE9a
        4FyF93GF18Kr1DtF4xCrsIqr9aqrykWrnYgr92q3WYyrWavw1kG34avr4Sqr1xWFWIyF1x
        Ja15Cw1SyF17ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_GQ6DUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwhw4glc662x+5gABsX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances the mips_cpu_register_ipi_domain function in
drivers/irqchip/irq-mips-cpu.c by adding error handling for the kzalloc
call. Previously, the function lacked proper handling for kzalloc
failures, which could lead to potential null pointer dereference issues
under low memory conditions.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/irqchip/irq-mips-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 0c7ae71a0af0..a8030c2b135c 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -238,6 +238,9 @@ static void mips_cpu_register_ipi_domain(struct device_node *of_node)
 	struct cpu_ipi_domain_state *ipi_domain_state;
 
 	ipi_domain_state = kzalloc(sizeof(*ipi_domain_state), GFP_KERNEL);
+	if (!ipi_domain_state)
+		panic("Failed to allocate MIPS CPU IPI domain state");
+
 	ipi_domain = irq_domain_add_hierarchy(irq_domain,
 					      IRQ_DOMAIN_FLAG_IPI_SINGLE,
 					      2, of_node,
-- 
2.17.1

