Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53707DC487
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjJaChM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjJaChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:37:09 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE57F4;
        Mon, 30 Oct 2023 19:37:04 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.17])
        by gateway (Coremail) with SMTP id _____8Bx5fBNaEBld941AA--.40552S3;
        Tue, 31 Oct 2023 10:37:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.17])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxH91LaEBlgEQ3AA--.55486S2;
        Tue, 31 Oct 2023 10:37:00 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 4/5] irqchip/loongson-liointc: Fix 'loongson,parent_int_map' parse
Date:   Tue, 31 Oct 2023 10:36:57 +0800
Message-Id: <40fb5e2b35d613f1116d31876fbf79c94bec4fd1.1698717154.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1698717154.git.zhoubinbin@loongson.cn>
References: <cover.1698717154.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91LaEBlgEQ3AA--.55486S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr47Cr48trW8KrWUWr1xJFc_yoW8Jw1fpF
        srC390kr45Ka47urs8ta4vka4Sy3WYkFZrGFWxCa4SvFn5J34kZF15AF1DCF4fCr45GayY
        qr40qFWUGa15CFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVOJeDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While 'loongson,parent_int_map' is deprecated, we need to make sure that
both forms can be parsed.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index e4b33aed1c97..add2e0a955b8 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -330,6 +330,7 @@ static int __init liointc_of_init(struct device_node *node,
 	bool have_parent = FALSE;
 	int sz, i, index, revision, err = 0;
 	struct resource res;
+	const char *prop_name = "loongson,parent-int-map";
 
 	if (!of_device_is_compatible(node, "loongson,liointc-2.0")) {
 		index = 0;
@@ -350,8 +351,12 @@ static int __init liointc_of_init(struct device_node *node,
 	if (!have_parent)
 		return -ENODEV;
 
+	if (!of_find_property(node, prop_name, &i))
+		/* Fallback to 'loongson,parent_int_map', although it is deprecated. */
+		prop_name = "loongson,parent_int_map";
+
 	sz = of_property_read_variable_u32_array(node,
-						"loongson,parent_int_map",
+						prop_name,
 						&parent_int_map[0],
 						LIOINTC_NUM_PARENT,
 						LIOINTC_NUM_PARENT);
-- 
2.39.3

