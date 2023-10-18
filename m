Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D452F7CDF10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjJROQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjJROPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:15:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB14CD68;
        Wed, 18 Oct 2023 07:13:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F2DC433D9;
        Wed, 18 Oct 2023 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638429;
        bh=rTVhYDE+rQI0sAnXEiLXrhwq8F5WMJ6T4HrQTI0D7ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyP/EpUR48dZfhwzp4SG2wqbo7PqW+XRX8v95se9rjaGT/PkL/j0NyBR6HkPj38Op
         Adb0IBgp84yCPXpnH3KiJHpD91nh1nU1wBA8wZGzzPo3/UFiE30juYvRDyUiAacLMz
         GpCn9aN1quIHnEqzShNml3MQhQrXa9f+yXnhMX+BcBECJRknzXdxMtmTv6Uua2uTXw
         Hsunu+ov4KFsrD9lsuwTWGuZD7blHMji8ilS5f81AErbCqLbUxNJJFLdlzX6ifiUsm
         KHWcCxB5e8qutiwcbgupvjzgM3bHg0aod/5otCGlwfdUGBXvHLlpwP1/9wocalyHlS
         qWf2swF4dI5AQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/19] irqchip/stm32-exti: add missing DT IRQ flag translation
Date:   Wed, 18 Oct 2023 10:13:14 -0400
Message-Id: <20231018141323.1334898-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
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
index 8bbb2b114636c..dc6f67decb022 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -458,6 +458,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
-- 
2.40.1

