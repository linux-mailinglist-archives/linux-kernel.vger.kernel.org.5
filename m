Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063537BB9DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJFN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJFN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905683;
        Fri,  6 Oct 2023 06:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116B2C43397;
        Fri,  6 Oct 2023 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696600725;
        bh=xGEGTQtmdwSYwKj04O5pwjQF4+kQOGxNbHqDgmTikZA=;
        h=From:To:Cc:Subject:Date:From;
        b=VJCRyR7IBbHUluxhmUT/VAs+/Ey+KzwxBap4XkKgu3uezUXXcmpHJmRAmJ1bKkydz
         DuT5AphEYzLR3mVrKtZsoguc5dA669Vq4O9YxWcjzNhxsnLrfWJLoigkmlEppH7M1X
         KH/vHoSLhARNMZVtBu/CfeKL6vZ9ySdPLkCxaCTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: spidev: make spidev_class constant
Date:   Fri,  6 Oct 2023 15:58:40 +0200
Message-ID: <2023100639-celtic-herbs-66be@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  75
X-Developer-Signature: v=1; a=openpgp-sha256; l=2560; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xGEGTQtmdwSYwKj04O5pwjQF4+kQOGxNbHqDgmTikZA=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkKQv3KNgnpM37brLZ+lHk5waNyVa232grFo/JPWKbq3 t2/aIJMRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkSxjDgi3XPA1e3JqVG1Cw Z5ptk+JcSadoaYZ5tkcjtM5u5Vm8Y0/ggjuPLTuiz8W8AQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spidev.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d13dc15cc191..a078860a52ac 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -701,7 +701,9 @@ static const struct file_operations spidev_fops = {
  * It also simplifies memory management.
  */
 
-static struct class *spidev_class;
+static const struct class spidev_class = {
+	.name = "spidev",
+};
 
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "dh2228fv" },
@@ -804,7 +806,7 @@ static int spidev_probe(struct spi_device *spi)
 		struct device *dev;
 
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
-		dev = device_create(spidev_class, &spi->dev, spidev->devt,
+		dev = device_create(&spidev_class, &spi->dev, spidev->devt,
 				    spidev, "spidev%d.%d",
 				    spi->master->bus_num, spi_get_chipselect(spi, 0));
 		status = PTR_ERR_OR_ZERO(dev);
@@ -840,7 +842,7 @@ static void spidev_remove(struct spi_device *spi)
 	mutex_unlock(&spidev->spi_lock);
 
 	list_del(&spidev->device_entry);
-	device_destroy(spidev_class, spidev->devt);
+	device_destroy(&spidev_class, spidev->devt);
 	clear_bit(MINOR(spidev->devt), minors);
 	if (spidev->users == 0)
 		kfree(spidev);
@@ -878,15 +880,15 @@ static int __init spidev_init(void)
 	if (status < 0)
 		return status;
 
-	spidev_class = class_create("spidev");
-	if (IS_ERR(spidev_class)) {
+	status = class_register(&spidev_class);
+	if (status) {
 		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-		return PTR_ERR(spidev_class);
+		return status;
 	}
 
 	status = spi_register_driver(&spidev_spi_driver);
 	if (status < 0) {
-		class_destroy(spidev_class);
+		class_unregister(&spidev_class);
 		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 	}
 	return status;
@@ -896,7 +898,7 @@ module_init(spidev_init);
 static void __exit spidev_exit(void)
 {
 	spi_unregister_driver(&spidev_spi_driver);
-	class_destroy(spidev_class);
+	class_unregister(&spidev_class);
 	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 }
 module_exit(spidev_exit);
-- 
2.42.0

