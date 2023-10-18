Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1E7CDFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjJRO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345557AbjJRO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:29:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98FD53;
        Wed, 18 Oct 2023 07:16:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69571C433B7;
        Wed, 18 Oct 2023 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638581;
        bh=qjvN2bnmMbmAA4PUT4YieRCvJ+HkSdtm5o9amMQbses=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nF8s0tnlyPu8FIXF6K3xHUMI2TbVfJ97XVohcpPzkD+wn8sGabqW65T/N31X/3pDm
         sI8Yb+OspWfFWIvjyYFT0kurQloFYxK1XyYI9T1NgQv0VtGYIKmcPyCfyMeB9yDG99
         b9Esde6Wglakih1JcL7bzi461zHNsMPUEIXCWkUemjNO2qQDTxPbmTq7TkIB0pgKvv
         eLDjvODkxwMQRwVWDOAf8/GoF0IwJ4u06PBauXywf+3Xp86Mgn64HvXrhCw+He47c/
         hjd2Mv7arVIO9DXJ8YP0ZKgxE6DlpHnpROa8WcTatYGMYKT9tPrI4LOnWB8faoP9Ov
         9V1w4PRQM2jCw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 3/7] irqchip/stm32-exti: add missing DT IRQ flag translation
Date:   Wed, 18 Oct 2023 10:16:08 -0400
Message-Id: <20231018141613.1335848-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141613.1335848-1-sashal@kernel.org>
References: <20231018141613.1335848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.327
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit 8554cba1d6dbd3c74e0549e28ddbaccbb1d6b30a ]

The STM32F4/7 EXTI driver was missing the xlate callback, so IRQ trigger
flags specified in the device tree were being ignored. This was
preventing the RTC alarm interrupt from working, because it must be set
to trigger on the rising edge to function correctly.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231003162003.1649967-1-ben.wolsieffer@hefring.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 45363ff8d06f0..1b55199ea1b4a 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -127,6 +127,7 @@ struct irq_domain_ops irq_exti_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int __init stm32_exti_init(struct device_node *node,
-- 
2.40.1

