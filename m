Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DDD7F2A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjKUKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjKUKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC1123
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89361C433C9;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=aNABuSX/iu/FZhYqcM7nGl46V+DTa8I77sLNnNUUCbM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=j+KXFBmO0VLW/kk+YkqR74u1RvNjaYcbY30YaQTpU7OitaBTQU5F+iyZR7vLFbdek
         ZiqZ8kyMEHKkjJxeTYQr5i6o2wql53rRHBziJwLHJiKAsQPcOJaqnSPjZesXe9ujlx
         aFFHHCUgzqQTiZwQBToBmJneVvQimCOvy/TDEwNEl8ceKDE7yQQArh5WcToNF/+JeC
         G9PA2b5Mr5u0wNorE1zWPm2pl0YSYBgBMx4fpOZ2AQ38bHVCW/pR01FMh9N2MAVszy
         khKa7ZdMmAny34bXlOQyWCYkoNN49MNbV5wC/+fV8/xJCCXbCNq96HciUKZYlv9VfT
         FKpdzv/p5gnzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 76438C61D93;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:20 +0100
Subject: [PATCH 07/12] iio: adc: ad9467: fix scale setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-7-6a3d542eba35@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=8213;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5RjYNT6FmhQuBx41nfBmHPCdi4pZgV0vQHZroLMTopw=;
 b=oVQFvVd9qVYjXGGsy9vaJzyQsWgsY6P5EpBdM7AlD7XfsL8GrcP587ImNrjSzhEGZHL9JtUEJ
 ed+R8jlUjXXCZ2IFQOYQs9Cv6bWGIrsd88hj5kuqyDRXIoHBuOnCt/d
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

When reading in_voltage_scale we can get something like:

root@analog:/sys/bus/iio/devices/iio:device2# cat in_voltage_scale
0.038146

However, when reading the available options:

root@analog:/sys/bus/iio/devices/iio:device2# cat
in_voltage_scale_available
2000.000000 2100.000006 2200.000007 2300.000008 2400.000009 2500.000010

which does not make sense. Moreover, when trying to set a new scale we
get an error because there's no call to __ad9467_get_scale() to give us
values as given when reading in_voltage_scale. Fix it by computing the
available scales during probe and properly pass the list when
.read_available() is called.

While at it, change to use .read_available() from iio_info. Also note
that to properly fix this, adi-axi-adc.c has to be changed accordingly.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c            | 47 +++++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c       | 74 ++++++++-----------------------------
 include/linux/iio/adc/adi-axi-adc.h |  4 ++
 3 files changed, 66 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 91821dee03b7..df4c21248226 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -120,6 +120,7 @@ struct ad9467_state {
 	struct spi_device		*spi;
 	struct clk			*clk;
 	unsigned int			output_mode;
+	unsigned int                    (*scales)[2];
 
 	struct gpio_desc		*pwrdown_gpio;
 	/* protect against concurrent accesses to the device */
@@ -216,6 +217,7 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 	.channel = _chan,						\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = _si,						\
 	.scan_type = {							\
 		.sign = _sign,						\
@@ -369,6 +371,26 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
+static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scales;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = info->num_scales * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 {
 	int ret;
@@ -381,6 +403,26 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
+static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	unsigned int i, val1, val2;
+
+	st->scales = devm_kcalloc(&st->spi->dev, ARRAY_SIZE(*st->scales),
+				  info->num_scales, GFP_KERNEL);
+	if (!st->scales)
+		return -ENOMEM;
+
+	for (i = 0; i < info->num_scales * 2; i++) {
+		__ad9467_get_scale(conv, i, &val1, &val2);
+		st->scales[i][0] = val1;
+		st->scales[i][1] = val2;
+	}
+
+	return 0;
+}
+
 static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 {
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
@@ -441,6 +483,10 @@ static int ad9467_probe(struct spi_device *spi)
 
 	conv->chip_info = &info->axi_adc_info;
 
+	ret = ad9467_scale_fill(conv);
+	if (ret)
+		return ret;
+
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
 	if (id != conv->chip_info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
@@ -451,6 +497,7 @@ static int ad9467_probe(struct spi_device *spi)
 	conv->reg_access = ad9467_reg_access;
 	conv->write_raw = ad9467_write_raw;
 	conv->read_raw = ad9467_read_raw;
+	conv->read_avail = ad9467_read_avail;
 	conv->preenable_setup = ad9467_preenable_setup;
 
 	st->output_mode = info->default_output_mode |
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index aff0532a974a..ae83ada7f9f2 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -144,6 +144,20 @@ static int adi_axi_adc_write_raw(struct iio_dev *indio_dev,
 	return conv->write_raw(conv, chan, val, val2, mask);
 }
 
+static int adi_axi_adc_read_avail(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+
+	if (!conv->read_avail)
+		return -EOPNOTSUPP;
+
+	return conv->read_avail(conv, chan, vals, type, length, mask);
+}
+
 static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
 					const unsigned long *scan_mask)
 {
@@ -228,69 +242,11 @@ struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_adi_axi_adc_conv_register, IIO_ADI_AXI);
 
-static ssize_t in_voltage_scale_available_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < conv->chip_info->num_scales; i++) {
-		const unsigned int *s = conv->chip_info->scale_table[i];
-
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%u.%06u ", s[0], s[1]);
-	}
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
-
-enum {
-	ADI_AXI_ATTR_SCALE_AVAIL,
-};
-
-#define ADI_AXI_ATTR(_en_, _file_)			\
-	[ADI_AXI_ATTR_##_en_] = &iio_dev_attr_##_file_.dev_attr.attr
-
-static struct attribute *adi_axi_adc_attributes[] = {
-	ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),
-	NULL
-};
-
-static umode_t axi_adc_attr_is_visible(struct kobject *kobj,
-				       struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-
-	switch (n) {
-	case ADI_AXI_ATTR_SCALE_AVAIL:
-		if (!conv->chip_info->num_scales)
-			return 0;
-		return attr->mode;
-	default:
-		return attr->mode;
-	}
-}
-
-static const struct attribute_group adi_axi_adc_attribute_group = {
-	.attrs = adi_axi_adc_attributes,
-	.is_visible = axi_adc_attr_is_visible,
-};
-
 static const struct iio_info adi_axi_adc_info = {
 	.read_raw = &adi_axi_adc_read_raw,
 	.write_raw = &adi_axi_adc_write_raw,
-	.attrs = &adi_axi_adc_attribute_group,
 	.update_scan_mode = &adi_axi_adc_update_scan_mode,
+	.read_avail = &adi_axi_adc_read_avail,
 };
 
 static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info = {
diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/adi-axi-adc.h
index 52620e5b8052..b7904992d561 100644
--- a/include/linux/iio/adc/adi-axi-adc.h
+++ b/include/linux/iio/adc/adi-axi-adc.h
@@ -41,6 +41,7 @@ struct adi_axi_adc_chip_info {
  * @reg_access		IIO debugfs_reg_access hook for the client ADC
  * @read_raw		IIO read_raw hook for the client ADC
  * @write_raw		IIO write_raw hook for the client ADC
+ * @read_avail		IIO read_avail hook for the client ADC
  */
 struct adi_axi_adc_conv {
 	const struct adi_axi_adc_chip_info		*chip_info;
@@ -54,6 +55,9 @@ struct adi_axi_adc_conv {
 	int (*write_raw)(struct adi_axi_adc_conv *conv,
 			 struct iio_chan_spec const *chan,
 			 int val, int val2, long mask);
+	int (*read_avail)(struct adi_axi_adc_conv *conv,
+			  struct iio_chan_spec const *chan,
+			  const int **val, int *type, int *length, long mask);
 };
 
 struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,

-- 
2.42.1

