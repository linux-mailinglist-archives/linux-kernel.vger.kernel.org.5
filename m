Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFD75B715
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGTSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGTSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:50:02 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9E171B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:50:00 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48138ef0c3eso457411e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689879000; x=1690483800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47VRng0K3KEZnQHzer+QQBEt4eStFdrT5Gpil6rEOTc=;
        b=hDY9UfenLOhlxmipNDa6S19arCcMFcDXN2mksFWWmKcrGwqXEi+P6qFemmgdGpxpDW
         Ye5q6R6pTs1WR4uX9Jg1Bpi2btCK1s9qaPSVEXXP96xlQhMOc04dIq335ynBzPEqKVpO
         qr1FORNrS48wh7aI18u+9QC/eb0rmp4phXMl4DQNURuZy8JdKD7kUM6Nb92ltwcuvwz1
         v19Up7vMuB3rOtHLe2JTuijTF0wcVZtYb2WxwgRqvCeioBIquJ0WuhQ8XfolxZFolLg8
         +NmO1Ng4nafz6gpViDMTFUPi9n/EBvpc7XMxaKkh3nHp/HX0oVAcU0oD5Ntq1mdSGh+t
         4M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879000; x=1690483800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47VRng0K3KEZnQHzer+QQBEt4eStFdrT5Gpil6rEOTc=;
        b=YPzfvBkh4CPjNKKABwj2XRVBKMMN1xZ0HbvVdcyZtyGgrohnPb5LROgPsVdEpLa3Id
         kDfVaGRdne7GNWf2sfmlKvKWoPCYihAtJ36Fx0XPwyrSl5EAmDirT2QKK5wI5YFvXXio
         DrRJ88+8iwQyRo//vByRir/3tuYIIqkcvK3VGMV0com9Gu2ymUtPZAmx2rJSgCqEXJA5
         3ciR7UGhzTeC3vX5te65lhc1AZrmCdFWHZ6v2Uv+6O8Wa7tU7/ggyUC5Nvz9t5oAiZpz
         drGD5aAkUVc1TDhsZwrTALfNx8h3tBITyrcrYb+Y8w5+RZ4i/QgGLrdSppHr3UsEDOs2
         yUFQ==
X-Gm-Message-State: ABy/qLY7EyHZogHS4ctHSzYA55MNU6D3s9GofoXfHZnQcmsIe9JRgvnh
        gaCsXp3NZgoJoF6aBzW1wkUu/w==
X-Google-Smtp-Source: APBJJlGxMG0odt5XnwWXp50Eu92UKYDu9KmTr2OHhGCYdmNmFXK+GEFxafD5A4keOPMLOdyfTS+CYw==
X-Received: by 2002:a1f:4183:0:b0:471:b557:12a with SMTP id o125-20020a1f4183000000b00471b557012amr2556702vka.11.1689878999771;
        Thu, 20 Jul 2023 11:49:59 -0700 (PDT)
Received: from localhost.localdomain (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id h7-20020a0561220b6700b0047dbd48bc44sm238059vkf.17.2023.07.20.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:49:59 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RESEND PATCH 1/2] gpio: 104-dio-48e: Add Counter/Timer support
Date:   Thu, 20 Jul 2023 14:49:43 -0400
Message-ID: <9b159da19bb78df21c1dc24161188c9b8452720a.1689878150.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689878150.git.william.gray@linaro.org>
References: <cover.1689878150.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-DIO-48E features an 8254 Counter/Timer chip providing three
counter/timers which can be used for frequency measurement, frequency
output, pulse width modulation, pulse width measurement, event count,
etc. The counter/timers use the same addresses as PPI 0 (addresses 0x0
to 0x3), so a raw_spinlock_t is used to synchronize operations between
the two regmap mappings to prevent clobbering.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 127 ++++++++++++++++++++++++++++----
 2 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e382dfebad7c..49466a148678 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -858,6 +858,7 @@ config GPIO_104_DIO_48E
 	select REGMAP_IRQ
 	select GPIOLIB_IRQCHIP
 	select GPIO_I8255
+	select I8254
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
 	  104-DIO-24E). The base port addresses for the devices may be
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 8ff5f4ff5958..4df9becaf349 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/i8254.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/isa.h>
@@ -16,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/regmap.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include "gpio-i8255.h"
@@ -37,6 +39,8 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 #define DIO48E_ENABLE_INTERRUPT 0xB
 #define DIO48E_DISABLE_INTERRUPT DIO48E_ENABLE_INTERRUPT
+#define DIO48E_ENABLE_COUNTER_TIMER_ADDRESSING 0xD
+#define DIO48E_DISABLE_COUNTER_TIMER_ADDRESSING DIO48E_ENABLE_COUNTER_TIMER_ADDRESSING
 #define DIO48E_CLEAR_INTERRUPT 0xF
 
 #define DIO48E_NUM_PPI 2
@@ -75,18 +79,20 @@ static const struct regmap_access_table dio48e_precious_table = {
 	.yes_ranges = dio48e_precious_ranges,
 	.n_yes_ranges = ARRAY_SIZE(dio48e_precious_ranges),
 };
-static const struct regmap_config dio48e_regmap_config = {
-	.reg_bits = 8,
-	.reg_stride = 1,
-	.val_bits = 8,
-	.io_port = true,
-	.max_register = 0xF,
-	.wr_table = &dio48e_wr_table,
-	.rd_table = &dio48e_rd_table,
-	.volatile_table = &dio48e_volatile_table,
-	.precious_table = &dio48e_precious_table,
-	.cache_type = REGCACHE_FLAT,
-	.use_raw_spinlock = true,
+
+static const struct regmap_range pit_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x3),
+};
+static const struct regmap_range pit_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2),
+};
+static const struct regmap_access_table pit_wr_table = {
+	.yes_ranges = pit_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_wr_ranges),
+};
+static const struct regmap_access_table pit_rd_table = {
+	.yes_ranges = pit_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_rd_ranges),
 };
 
 /* only bit 3 on each respective Port C supports interrupts */
@@ -102,14 +108,56 @@ static const struct regmap_irq dio48e_regmap_irqs[] = {
 
 /**
  * struct dio48e_gpio - GPIO device private data structure
+ * @lock:	synchronization lock to prevent I/O race conditions
  * @map:	Regmap for the device
+ * @regs:	virtual mapping for device registers
+ * @flags:	IRQ flags saved during locking
  * @irq_mask:	Current IRQ mask state on the device
  */
 struct dio48e_gpio {
+	raw_spinlock_t lock;
 	struct regmap *map;
+	void __iomem *regs;
+	unsigned long flags;
 	unsigned int irq_mask;
 };
 
+static void dio48e_regmap_lock(void *lock_arg) __acquires(&dio48egpio->lock)
+{
+	struct dio48e_gpio *const dio48egpio = lock_arg;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
+	dio48egpio->flags = flags;
+}
+
+static void dio48e_regmap_unlock(void *lock_arg) __releases(&dio48egpio->lock)
+{
+	struct dio48e_gpio *const dio48egpio = lock_arg;
+
+	raw_spin_unlock_irqrestore(&dio48egpio->lock, dio48egpio->flags);
+}
+
+static void pit_regmap_lock(void *lock_arg) __acquires(&dio48egpio->lock)
+{
+	struct dio48e_gpio *const dio48egpio = lock_arg;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
+	dio48egpio->flags = flags;
+
+	iowrite8(0x00, dio48egpio->regs + DIO48E_ENABLE_COUNTER_TIMER_ADDRESSING);
+}
+
+static void pit_regmap_unlock(void *lock_arg) __releases(&dio48egpio->lock)
+{
+	struct dio48e_gpio *const dio48egpio = lock_arg;
+
+	ioread8(dio48egpio->regs + DIO48E_DISABLE_COUNTER_TIMER_ADDRESSING);
+
+	raw_spin_unlock_irqrestore(&dio48egpio->lock, dio48egpio->flags);
+}
+
 static int dio48e_handle_mask_sync(const int index,
 				   const unsigned int mask_buf_def,
 				   const unsigned int mask_buf,
@@ -176,6 +224,9 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	struct i8255_regmap_config config = {};
 	void __iomem *regs;
 	struct regmap *map;
+	struct regmap_config dio48e_regmap_config;
+	struct regmap_config pit_regmap_config;
+	struct i8254_regmap_config pit_config;
 	int err;
 	struct regmap_irq_chip *chip;
 	struct dio48e_gpio *dio48egpio;
@@ -187,21 +238,58 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
+	if (!dio48egpio)
+		return -ENOMEM;
+
 	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
 	if (!regs)
 		return -ENOMEM;
 
+	dio48egpio->regs = regs;
+
+	raw_spin_lock_init(&dio48egpio->lock);
+
+	dio48e_regmap_config = (struct regmap_config) {
+		.reg_bits = 8,
+		.reg_stride = 1,
+		.val_bits = 8,
+		.lock = dio48e_regmap_lock,
+		.unlock = dio48e_regmap_unlock,
+		.lock_arg = dio48egpio,
+		.io_port = true,
+		.wr_table = &dio48e_wr_table,
+		.rd_table = &dio48e_rd_table,
+		.volatile_table = &dio48e_volatile_table,
+		.precious_table = &dio48e_precious_table,
+		.cache_type = REGCACHE_FLAT,
+	};
+
 	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
 	if (IS_ERR(map))
 		return dev_err_probe(dev, PTR_ERR(map),
 				     "Unable to initialize register map\n");
 
-	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
-	if (!dio48egpio)
-		return -ENOMEM;
-
 	dio48egpio->map = map;
 
+	pit_regmap_config = (struct regmap_config) {
+		.name = "i8254",
+		.reg_bits = 8,
+		.reg_stride = 1,
+		.val_bits = 8,
+		.lock = pit_regmap_lock,
+		.unlock = pit_regmap_unlock,
+		.lock_arg = dio48egpio,
+		.io_port = true,
+		.wr_table = &pit_wr_table,
+		.rd_table = &pit_rd_table,
+	};
+
+	pit_config.map = devm_regmap_init_mmio(dev, regs, &pit_regmap_config);
+	if (IS_ERR(pit_config.map))
+		return dev_err_probe(dev, PTR_ERR(pit_config.map),
+				     "Unable to initialize i8254 register map\n");
+
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -225,6 +313,12 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	if (err)
 		return dev_err_probe(dev, err, "IRQ registration failed\n");
 
+	pit_config.parent = dev;
+
+	err = devm_i8254_regmap_register(dev, &pit_config);
+	if (err)
+		return err;
+
 	config.parent = dev;
 	config.map = map;
 	config.num_ppi = DIO48E_NUM_PPI;
@@ -245,3 +339,4 @@ module_isa_driver_with_irq(dio48e_driver, num_dio48e, num_irq);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-DIO-48E GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(I8254);
-- 
2.41.0

