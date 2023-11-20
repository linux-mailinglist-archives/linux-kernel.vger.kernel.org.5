Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AE7F0AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjKTCtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKTCte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:49:34 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5083F13A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:49:30 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8Cxrus4yVplVx87AA--.48370S3;
        Mon, 20 Nov 2023 10:49:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3tw2yVplyjFHAA--.23995S2;
        Mon, 20 Nov 2023 10:49:26 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Subject: [PATCH v2] LoongArch: Implement constant timer shutdown interface
Date:   Mon, 20 Nov 2023 10:46:52 +0800
Message-Id: <20231120024652.3191881-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3tw2yVplyjFHAA--.23995S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw48XFyUKr4rtFW8ZFyUCFX_yoW5Gw4Dpw
        sxCF9xJrWY93ZaqF1DJrs7Zr98Jw1v93y7tr97Gay8AFyjvr4fKFZ7trZ2vF4YvryFqr42
        ya1Fvw4qgrW7J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu is hot-unplugged,, it is put in idle state and function
arch_cpu_idle_dead is called. Timer interrupt for this processor should be
disabled, else there will be pending timer interrupt for the plug-out cpu,
so that vcpu is prevented from giving up scheduling when system is running
in vm mode.

This patch implements the timer shutdown interface so that the timer will
be properly disabled when a CPU is hot-unplugged.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: WANG Xuerui <git@xen0n.name>
---
Changes in v2:
  1. Remove function constant_set_state_oneshot_stopped and add detailed
implementation in constant_set_state_shutdown.
  2. Modify patch description and make it easier to understand.

---
 arch/loongarch/kernel/time.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 3064af94db9c..6a1734473aea 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -58,21 +58,6 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
-{
-	unsigned long timer_config;
-
-	raw_spin_lock(&state_lock);
-
-	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
-	timer_config &= ~CSR_TCFG_EN;
-	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
-
-	raw_spin_unlock(&state_lock);
-
-	return 0;
-}
-
 static int constant_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned long period;
@@ -92,6 +77,14 @@ static int constant_set_state_periodic(struct clock_event_device *evt)
 
 static int constant_set_state_shutdown(struct clock_event_device *evt)
 {
+	unsigned long timer_config;
+
+	raw_spin_lock(&state_lock);
+	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config &= ~CSR_TCFG_EN;
+	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
+	raw_spin_unlock(&state_lock);
+
 	return 0;
 }
 
@@ -161,7 +154,7 @@ int constant_clockevent_init(void)
 	cd->rating = 320;
 	cd->cpumask = cpumask_of(cpu);
 	cd->set_state_oneshot = constant_set_state_oneshot;
-	cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
+	cd->set_state_oneshot_stopped = constant_set_state_shutdown;
 	cd->set_state_periodic = constant_set_state_periodic;
 	cd->set_state_shutdown = constant_set_state_shutdown;
 	cd->set_next_event = constant_timer_next_event;

base-commit: 037266a5f7239ead1530266f7d7af153d2a867fa
-- 
2.39.3

