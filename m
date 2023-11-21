Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82287F2A21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjKUKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjKUKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE8116
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4672C4166B;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=KodMV26ca7GEsuJL/H7lYOP+04Qx83r0peydFy3c6MQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=fwe9uYhzIqmrRqK9wt18UCOBkVNVij2q0PungQuybNWZZIZzyhYyoAf7TMLMrNJi/
         xm4gSEKxCPXrBZKIjzRpEov0/BGtCJnrq7IhqS1EraucS5kM8z2cetrnMnPwTHC1iE
         xwKUzQFF+w3khqGOewdieatwP0nKQEf4XcKoUoA5Gi5nIU1cvW7V3d1nYbm/7eaMej
         +pH9ESw63UqUKd0DCAWm+jbX8Bk6Z4QNCaVAr/bvqZ/88ZXOadGta/AlHJXCBl6Wx0
         2dKWXUUJKVB2I+UvJjoqmlS0vo2h66StZhQY9600j1R2iJMVQrY/iMIZbgdkHge5Xr
         b8mFo+8JLdMxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id D34AFC54FB9;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:25 +0100
Subject: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=14337;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+u9HWUghl/248aJnsS8FrYOYG77gZgAnQv1PFeCSO1s=;
 b=tbqLWeExJMbjJ/4v6zWrjsAg+GNKLGrbhle82T3llI4pz3kYW9UZcgrhxLSENOUaDU8Pte51H
 VjmpMCFmNUGCrZPHQUSqQiiq8POYbUf5lsNEjVz6alFQaRrCxEgcStS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

Move to the IIO backend framework. Devices supported by adi-axi-adc now
register themselves as backend devices.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig       |   1 +
 drivers/iio/adc/adi-axi-adc.c | 364 ++++++++----------------------------------
 2 files changed, 65 insertions(+), 300 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af56df63beff..cc42a3399c63 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -292,6 +292,7 @@ config ADI_AXI_ADC
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_BUFFER_DMAENGINE
+	select IIO_BACKEND
 	depends on HAS_IOMEM
 	depends on OF
 	help
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c247ff1541d2..b2ab2c119efa 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -17,13 +17,9 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/buffer-dmaengine.h>
-
 #include <linux/fpga/adi-axi-common.h>
-#include <linux/iio/adc/adi-axi-adc.h>
+#include <linux/iio/backend.h>
+
 
 /*
  * Register definitions:
@@ -44,6 +40,7 @@
 #define   ADI_AXI_REG_CHAN_CTRL_PN_SEL_OWR	BIT(10)
 #define   ADI_AXI_REG_CHAN_CTRL_IQCOR_EN	BIT(9)
 #define   ADI_AXI_REG_CHAN_CTRL_DCFILT_EN	BIT(8)
+#define   ADI_AXI_REG_CHAN_CTRL_FMT_MASK	GENMASK(6, 4)
 #define   ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT	BIT(6)
 #define   ADI_AXI_REG_CHAN_CTRL_FMT_TYPE	BIT(5)
 #define   ADI_AXI_REG_CHAN_CTRL_FMT_EN		BIT(4)
@@ -55,286 +52,67 @@
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
-struct adi_axi_adc_core_info {
-	unsigned int				version;
-};
-
 struct adi_axi_adc_state {
-	struct mutex				lock;
-
-	struct adi_axi_adc_client		*client;
 	struct regmap				*regmap;
 };
 
-struct adi_axi_adc_client {
-	struct list_head			entry;
-	struct adi_axi_adc_conv			conv;
-	struct adi_axi_adc_state		*state;
-	struct device				*dev;
-	const struct adi_axi_adc_core_info	*info;
-};
-
-static LIST_HEAD(registered_clients);
-static DEFINE_MUTEX(registered_clients_lock);
-
-static struct adi_axi_adc_client *conv_to_client(struct adi_axi_adc_conv *conv)
-{
-	return container_of(conv, struct adi_axi_adc_client, conv);
-}
-
-void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
-{
-	struct adi_axi_adc_client *cl = conv_to_client(conv);
-
-	return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client),
-				  IIO_DMA_MINALIGN);
-}
-EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
-
-static int adi_axi_adc_config_dma_buffer(struct device *dev,
-					 struct iio_dev *indio_dev)
-{
-	const char *dma_name;
-
-	if (!device_property_present(dev, "dmas"))
-		return 0;
-
-	if (device_property_read_string(dev, "dma-names", &dma_name))
-		dma_name = "rx";
-
-	return devm_iio_dmaengine_buffer_setup(indio_dev->dev.parent,
-					       indio_dev, dma_name);
-}
-
-static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
-{
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-
-	if (!conv->read_raw)
-		return -EOPNOTSUPP;
-
-	return conv->read_raw(conv, chan, val, val2, mask);
-}
-
-static int adi_axi_adc_write_raw(struct iio_dev *indio_dev,
-				 struct iio_chan_spec const *chan,
-				 int val, int val2, long mask)
-{
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-
-	if (!conv->write_raw)
-		return -EOPNOTSUPP;
-
-	return conv->write_raw(conv, chan, val, val2, mask);
-}
-
-static int adi_axi_adc_read_avail(struct iio_dev *indio_dev,
-				  struct iio_chan_spec const *chan,
-				  const int **vals, int *type, int *length,
-				  long mask)
-{
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-
-	if (!conv->read_avail)
-		return -EOPNOTSUPP;
-
-	return conv->read_avail(conv, chan, vals, type, length, mask);
-}
-
-static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
-					const unsigned long *scan_mask)
-{
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < conv->chip_info->num_channels; i++) {
-		if (test_bit(i, scan_mask))
-			ret = regmap_set_bits(st->regmap,
-					      ADI_AXI_REG_CHAN_CTRL(i),
-					      ADI_AXI_REG_CHAN_CTRL_ENABLE);
-		else
-			ret = regmap_clear_bits(st->regmap,
-						ADI_AXI_REG_CHAN_CTRL(i),
-						ADI_AXI_REG_CHAN_CTRL_ENABLE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device *dev,
-							  size_t sizeof_priv)
-{
-	struct adi_axi_adc_client *cl;
-	size_t alloc_size;
-
-	alloc_size = ALIGN(sizeof(struct adi_axi_adc_client), IIO_DMA_MINALIGN);
-	if (sizeof_priv)
-		alloc_size += ALIGN(sizeof_priv, IIO_DMA_MINALIGN);
-
-	cl = kzalloc(alloc_size, GFP_KERNEL);
-	if (!cl)
-		return ERR_PTR(-ENOMEM);
-
-	mutex_lock(&registered_clients_lock);
-
-	cl->dev = get_device(dev);
-
-	list_add_tail(&cl->entry, &registered_clients);
-
-	mutex_unlock(&registered_clients_lock);
-
-	return &cl->conv;
-}
-
-static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
-{
-	struct adi_axi_adc_client *cl = conv_to_client(conv);
-
-	mutex_lock(&registered_clients_lock);
-
-	list_del(&cl->entry);
-	put_device(cl->dev);
-
-	mutex_unlock(&registered_clients_lock);
-
-	kfree(cl);
-}
-
-static void devm_adi_axi_adc_conv_release(void *conv)
-{
-	adi_axi_adc_conv_unregister(conv);
-}
-
-struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
-							size_t sizeof_priv)
+static int axi_adc_enable(struct iio_backend *back)
 {
-	struct adi_axi_adc_conv *conv;
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 	int ret;
 
-	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
-	if (IS_ERR(conv))
-		return conv;
-
-	ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
-				       conv);
+	 ret = regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
+			       ADI_AXI_REG_RSTN_MMCM_RSTN);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return conv;
+	fsleep(10);
+	return regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
+			       ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
 }
-EXPORT_SYMBOL_NS_GPL(devm_adi_axi_adc_conv_register, IIO_ADI_AXI);
 
-static const struct iio_info adi_axi_adc_info = {
-	.read_raw = &adi_axi_adc_read_raw,
-	.write_raw = &adi_axi_adc_write_raw,
-	.update_scan_mode = &adi_axi_adc_update_scan_mode,
-	.read_avail = &adi_axi_adc_read_avail,
-};
-
-static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info = {
-	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
-};
-
-static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
+static void axi_adc_disable(struct iio_backend *back)
 {
-	const struct adi_axi_adc_core_info *info;
-	struct adi_axi_adc_client *cl;
-	struct device_node *cln;
-
-	info = of_device_get_match_data(dev);
-	if (!info)
-		return ERR_PTR(-ENODEV);
-
-	cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
-	if (!cln) {
-		dev_err(dev, "No 'adi,adc-dev' node defined\n");
-		return ERR_PTR(-ENODEV);
-	}
-
-	mutex_lock(&registered_clients_lock);
-
-	list_for_each_entry(cl, &registered_clients, entry) {
-		if (!cl->dev)
-			continue;
-
-		if (cl->dev->of_node != cln)
-			continue;
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
-		if (!try_module_get(cl->dev->driver->owner)) {
-			mutex_unlock(&registered_clients_lock);
-			of_node_put(cln);
-			return ERR_PTR(-ENODEV);
-		}
-
-		get_device(cl->dev);
-		cl->info = info;
-		mutex_unlock(&registered_clients_lock);
-		of_node_put(cln);
-		return cl;
-	}
-
-	mutex_unlock(&registered_clients_lock);
-	of_node_put(cln);
-
-	return ERR_PTR(-EPROBE_DEFER);
+	regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
 }
 
-static int adi_axi_adc_setup_channels(struct device *dev,
-				      struct adi_axi_adc_state *st)
+static int axi_adc_data_format_set(struct iio_backend *back, unsigned int chan,
+				   const struct iio_backend_data_fmt *data)
 {
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-	int i, ret;
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
 
-	if (conv->preenable_setup) {
-		ret = conv->preenable_setup(conv);
-		if (ret)
-			return ret;
-	}
+	if (!data->enable)
+		return regmap_clear_bits(st->regmap,
+					 ADI_AXI_REG_CHAN_CTRL(chan),
+					 ADI_AXI_REG_CHAN_CTRL_FMT_EN);
 
-	for (i = 0; i < conv->chip_info->num_channels; i++) {
-		ret = regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
-				   ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
-		if (ret)
-			return ret;
-	}
+	val = FIELD_PREP(ADI_AXI_REG_CHAN_CTRL_FMT_EN, true);
+	if (data->sign_extend)
+		val |= FIELD_PREP(ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT, true);
+	if (data->type == IIO_BACKEND_OFFSET_BINARY)
+		val |= FIELD_PREP(ADI_AXI_REG_CHAN_CTRL_FMT_TYPE, true);
 
-	return 0;
+	return regmap_update_bits(st->regmap, ADI_AXI_REG_CHAN_CTRL(chan),
+				  ADI_AXI_REG_CHAN_CTRL_FMT_MASK, val);
 }
 
-static int axi_adc_reset(struct adi_axi_adc_state *st)
+static int axi_adc_chan_enable(struct iio_backend *back, unsigned int chan)
 {
-	int ret;
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
-	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
-	if (ret)
-		return ret;
-
-	mdelay(10);
-	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN,
-			   ADI_AXI_REG_RSTN_MMCM_RSTN);
-	if (ret)
-		return ret;
-
-	mdelay(10);
-	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
-			    ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
+	return regmap_set_bits(st->regmap, ADI_AXI_REG_CHAN_CTRL(chan),
+			       ADI_AXI_REG_CHAN_CTRL_ENABLE);
 }
 
-static void adi_axi_adc_cleanup(void *data)
+static int axi_adc_chan_disable(struct iio_backend *back, unsigned int chan)
 {
-	struct adi_axi_adc_client *cl = data;
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
-	put_device(cl->dev);
-	module_put(cl->dev->driver->owner);
+	return regmap_clear_bits(st->regmap, ADI_AXI_REG_CHAN_CTRL(chan),
+				 ADI_AXI_REG_CHAN_CTRL_ENABLE);
 }
 
 static const struct regmap_config axi_adc_regmap_config = {
@@ -344,33 +122,25 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.max_register = 0x0800,
 };
 
+static const struct iio_backend_ops adi_axi_adc_generic = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
-	struct adi_axi_adc_conv *conv;
-	struct iio_dev *indio_dev;
-	struct adi_axi_adc_client *cl;
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
-	unsigned int ver;
+	unsigned int ver, *expected_ver;
 	int ret;
 
-	cl = adi_axi_adc_attach_client(&pdev->dev);
-	if (IS_ERR(cl))
-		return PTR_ERR(cl);
-
-	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_adc_cleanup, cl);
-	if (ret)
-		return ret;
-
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
-	if (indio_dev == NULL)
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
 		return -ENOMEM;
 
-	st = iio_priv(indio_dev);
-	st->client = cl;
-	cl->state = st;
-	mutex_init(&st->lock);
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -380,9 +150,15 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
-	conv = &st->client->conv;
+	expected_ver = (unsigned int *)device_get_match_data(&pdev->dev);
+	if (!expected_ver)
+		return -ENODEV;
 
-	ret = axi_adc_reset(st);
+	/*
+	 * Force disable the core. Up to the frontend to enable us. And we can
+	 * still read/write registers...
+	 */
+	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
 	if (ret)
 		return ret;
 
@@ -390,37 +166,23 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (cl->info->version > ver) {
+	if (*expected_ver > ver) {
 		dev_err(&pdev->dev,
 			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
-			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
-			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
+			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
+			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
+			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
 			ADI_AXI_PCORE_VER_MAJOR(ver),
 			ADI_AXI_PCORE_VER_MINOR(ver),
 			ADI_AXI_PCORE_VER_PATCH(ver));
 		return -ENODEV;
 	}
 
-	indio_dev->info = &adi_axi_adc_info;
-	indio_dev->name = "adi-axi-adc";
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->num_channels = conv->chip_info->num_channels;
-	indio_dev->channels = conv->chip_info->channels;
-
-	ret = adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
+	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
 	if (ret)
 		return ret;
 
-	ret = adi_axi_adc_setup_channels(&pdev->dev, st);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_device_register(&pdev->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
+	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%d) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
 		 ADI_AXI_PCORE_VER_PATCH(ver));
@@ -428,6 +190,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },

-- 
2.42.1

