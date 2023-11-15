Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFC7EBCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjKOGTC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 01:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:19:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D5B8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:18:55 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ACBF024E24A;
        Wed, 15 Nov 2023 14:18:53 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 14:18:53 +0800
Received: from localhost.localdomain (161.142.156.149) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 14:18:49 +0800
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Joshua Yeong <joshua.yeong@starfivetech.com>
Subject: [PATCH 1/1] clocksource/timer-risc: Add riscv_clock_shutdown callback
Date:   Wed, 15 Nov 2023 14:18:11 +0800
Message-ID: <20231115061811.10041-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.149]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
switching out riscv timer as clock source

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/clocksource/timer-riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..588a05459b6a 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -50,12 +50,19 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static int riscv_clock_shutdown(struct clock_event_device *evt)
+{
+	sbi_set_timer(-1);
+	return 0;
+}
+
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
+	.set_state_shutdown	= riscv_clock_shutdown,
 };
 
 /*
-- 
2.25.1

