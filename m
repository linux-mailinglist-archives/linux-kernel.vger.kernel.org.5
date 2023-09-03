Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B303790CE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbjICQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjICQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:20:08 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7145FE;
        Sun,  3 Sep 2023 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=h9ofA
        HbdA820d7O9E53lRZ8L9GoG8FbHPVW3A/JR4Bc=; b=He7TosPKInF15QNsb7/u0
        SsyFqjcaj52HqYxshubnH3WBiihXHuOrUBe6XcFHnMeL/1w03xhCrIn1V4pQQePY
        wQZRUz3BxkFOriXyJXE/osDCr3uZ0lZSnzc8gpC3PVpBXKD0W32id/kHyJzMsWsY
        HByQK39liVylusAAKFO9/g=
Received: from localhost.localdomain (unknown [112.22.168.243])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDXHstorvRkiRZSBA--.7483S4;
        Mon, 04 Sep 2023 00:04:27 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     dmitry.torokhov@gmail.com, geert+renesas@glider.be,
        Jonathan.Cameron@huawei.com, soyer@irl.hu
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] input: gpio-keys - use spin_lock()
Date:   Sun,  3 Sep 2023 09:03:49 -0700
Message-Id: <20230903160349.3919-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXHstorvRkiRZSBA--.7483S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy8GF1kZw1rZrW5Wr15Jwb_yoWkWFb_uF
        yDWr97Cr4Utw15Krn3Gr1fAF9rKF1YvF10kw1Dtay5Kr98Zw4DC397ZrZ3Jr4Dur4xA3Z8
        Gr4UW343Cw42kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWHq7JUUUUU==
X-Originating-IP: [112.22.168.243]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBbA7fq1c7QRNYIwAAsT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the spin_lock() and spin_unlock() instead of spin_lock_irqsave()
and spin_unlock_restore()

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/input/keyboard/gpio_keys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index c928829a8b0c..a55d62e1ff6d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -468,11 +468,10 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
 	struct input_dev *input = bdata->input;
-	unsigned long flags;
 
 	BUG_ON(irq != bdata->irq);
 
-	spin_lock_irqsave(&bdata->lock, flags);
+	spin_lock(&bdata->lock);
 
 	if (!bdata->key_pressed) {
 		if (bdata->button->wakeup)
@@ -495,7 +494,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 			      ms_to_ktime(bdata->release_delay),
 			      HRTIMER_MODE_REL_HARD);
 out:
-	spin_unlock_irqrestore(&bdata->lock, flags);
+	spin_unlock(&bdata->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

