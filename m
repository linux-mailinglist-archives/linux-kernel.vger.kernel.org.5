Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7D7BC25B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJFWqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjJFWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:46:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A65A2;
        Fri,  6 Oct 2023 15:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14360C433C7;
        Fri,  6 Oct 2023 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632391;
        bh=ISXp2gYet5qklONCtk802z18uyrzOQLPrR+IectAYzM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ip2tsOOtD1XFeJ7HcnZp4uXZtSnukFsIyWAsYCrBAyJ7Gd98G6L2uARSKSDosHjsr
         o45U27aHqeQo3BoMq8wn/G1CVA+UFIdZMP0eXCq/X8LObyss/f0ivMJpRbD7c9s90M
         opjh2LE8FFS4PPeU8/aMS6dHdk0XKSlmDVnjJ1Is+7nHIa7jsuOmJNXCMm0Pm1qPRn
         WcIn3jpwOMTufPOJvJ0h4ihPHG+mlFgXNi7RLSc6zYRdLoUcywZcE6CVPAj5N5GrB+
         51oaySw4Dfd2cHCps7uMcdCbI+4B+KgXqedpJVMpy5obEWq6oazJ9RH8ukl5UtylNm
         fmnm9Lrpn6OzA==
Received: (nullmailer pid 444993 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-ps-spi: Use spi_get_device_match_data()
Date:   Fri,  6 Oct 2023 17:46:24 -0500
Message-Id: <20231006224624.444857-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred spi_get_device_match_data() instead of of_match_device() and
spi_get_device_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 44 ++++--------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 5e1e009dba89..6be7410e4f09 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -18,8 +18,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/sizes.h>
 
@@ -72,12 +71,6 @@ static struct altera_ps_data a10_data = {
 	.t_st2ck_us = 10, /* min(t_ST2CK) */
 };
 
-/* Array index is enum altera_ps_devtype */
-static const struct altera_ps_data *altera_ps_data_map[] = {
-	&c5_data,
-	&a10_data,
-};
-
 static const struct of_device_id of_ef_match[] = {
 	{ .compatible = "altr,fpga-passive-serial", .data = &c5_data },
 	{ .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
@@ -237,43 +230,16 @@ static const struct fpga_manager_ops altera_ps_ops = {
 	.write_complete = altera_ps_write_complete,
 };
 
-static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
-{
-	kernel_ulong_t devtype = id->driver_data;
-	const struct altera_ps_data *data;
-
-	/* someone added a altera_ps_devtype without adding to the map array */
-	if (devtype >= ARRAY_SIZE(altera_ps_data_map))
-		return NULL;
-
-	data = altera_ps_data_map[devtype];
-	if (!data || data->devtype != devtype)
-		return NULL;
-
-	return data;
-}
-
 static int altera_ps_probe(struct spi_device *spi)
 {
 	struct altera_ps_conf *conf;
-	const struct of_device_id *of_id;
 	struct fpga_manager *mgr;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
 
-	if (spi->dev.of_node) {
-		of_id = of_match_device(of_ef_match, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-		conf->data = of_id->data;
-	} else {
-		conf->data = id_to_data(spi_get_device_id(spi));
-		if (!conf->data)
-			return -ENODEV;
-	}
-
+	conf->data = spi_get_device_match_data(spi);
 	conf->spi = spi;
 	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
@@ -308,9 +274,9 @@ static int altera_ps_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
-	{ "cyclone-ps-spi", CYCLONE5 },
-	{ "fpga-passive-serial", CYCLONE5 },
-	{ "fpga-arria10-passive-serial", ARRIA10 },
+	{ "cyclone-ps-spi", (uintptr_t)&c5_data },
+	{ "fpga-passive-serial", (uintptr_t)&c5_data },
+	{ "fpga-arria10-passive-serial", (uintptr_t)&a10_data },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
-- 
2.40.1

