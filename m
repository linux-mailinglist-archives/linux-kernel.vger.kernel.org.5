Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA17656EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjG0PGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjG0PGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:06:25 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837530D8;
        Thu, 27 Jul 2023 08:06:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBD3Kf020177;
        Thu, 27 Jul 2023 17:05:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=zmIPHW6iVYvOYi7oMUl9xnnwWipA141Ebb8TXiBkQXc=;
 b=6QX4TiYSntWcuysnOPTpYG03Wm8TzRkJ2LtxGD897emCWqelSVFabxXtNYesNFEari5Y
 EPbSbqwllTxW+63FnHlS5Ol410zrPFRa7RRnazGh3VbjNzvWUxYFErLg54IKtooVLh3G
 56NnH6bT7XIj07WguEpme4jKCNC/Tr9WZXUWMg3L8TuN1Pn+cQsn+QITX3muFVJQBSu0
 Uh+k4nQ8Vhfmo5U7bHDOaFEiwjbmawtCziBNjD7YsjtHwPrj4EFLzmdZPea0ucHk+Ppq
 YqkI82l3qQQa3D/NWP7Sztoc1piiJi2IFDm3n0ZH37fWgvRuIOSg0BHKlj1VDQnkJJrz 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3qgy988r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:05:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B36C810002A;
        Thu, 27 Jul 2023 17:05:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA361209BA7;
        Thu, 27 Jul 2023 17:05:43 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:05:43 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 06/11] iio: adc: stm32-dfsdm: adopt generic channel bindings
Date:   Thu, 27 Jul 2023 17:03:17 +0200
Message-ID: <20230727150324.1157933-7-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the generic channel bindings to ease the configuration
of the DFSDM channels as consumers of the SD modulator backend device.
Also adopt unified device property API in the same patch for this RFC.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 93 ++++++++++++++++---------------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 20f7dffcecdd..96f4e0c64cdc 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -596,45 +596,35 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
 
 static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 					struct iio_dev *indio_dev,
+					struct fwnode_handle *node,
 					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
 	const char *of_str;
-	int chan_idx = ch->scan_index;
 	int ret, val;
 
-	ret = of_property_read_u32_index(indio_dev->dev.of_node,
-					 "st,adc-channels", chan_idx,
-					 &ch->channel);
+	ret = fwnode_property_read_u32(node, "reg", &ch->channel);
 	if (ret < 0) {
-		dev_err(&indio_dev->dev,
-			" Error parsing 'st,adc-channels' for idx %d\n",
-			chan_idx);
+		dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
 		return ret;
 	}
 	if (ch->channel >= dfsdm->num_chs) {
-		dev_err(&indio_dev->dev,
-			" Error bad channel number %d (max = %d)\n",
+		dev_err(&indio_dev->dev, " Error bad channel number %d (max = %d)\n",
 			ch->channel, dfsdm->num_chs);
 		return -EINVAL;
 	}
 
-	ret = of_property_read_string_index(indio_dev->dev.of_node,
-					    "st,adc-channel-names", chan_idx,
-					    &ch->datasheet_name);
+	ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev,
-			" Error parsing 'st,adc-channel-names' for idx %d\n",
-			chan_idx);
+			" Error parsing 'label' for idx %d\n", ch->channel);
 		return ret;
 	}
 
 	df_ch =  &dfsdm->ch_list[ch->channel];
 	df_ch->id = ch->channel;
 
-	ret = of_property_read_string_index(indio_dev->dev.of_node,
-					    "st,adc-channel-types", chan_idx,
-					    &of_str);
+	ret = fwnode_property_read_string(node, "st,adc-channel-types", &of_str);
 	if (!ret) {
 		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
 		if (val < 0)
@@ -644,9 +634,7 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->type = val;
 
-	ret = of_property_read_string_index(indio_dev->dev.of_node,
-					    "st,adc-channel-clk-src", chan_idx,
-					    &of_str);
+	ret = fwnode_property_read_string(node, "st,adc-channel-clk-src", &of_str);
 	if (!ret) {
 		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
 		if (val < 0)
@@ -656,10 +644,8 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->src = val;
 
-	ret = of_property_read_u32_index(indio_dev->dev.of_node,
-					 "st,adc-alt-channel", chan_idx,
-					 &df_ch->alt_si);
-	if (ret < 0)
+	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
+	if (ret != -EINVAL)
 		df_ch->alt_si = 0;
 
 	return 0;
@@ -1354,17 +1340,21 @@ static int stm32_dfsdm_dma_request(struct device *dev,
 }
 
 static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
+					 struct fwnode_handle *child,
 					 struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	ret = stm32_dfsdm_channel_parse_of(adc->dfsdm, indio_dev, ch);
-	if (ret < 0)
+	ret = stm32_dfsdm_channel_parse_of(adc->dfsdm, indio_dev, child, ch);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to parse channel\n");
 		return ret;
+	}
 
 	ch->type = IIO_VOLTAGE;
 	ch->indexed = 1;
+	ch->scan_index = ch->channel;
 
 	/*
 	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
@@ -1387,6 +1377,30 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					  &adc->dfsdm->ch_list[ch->channel]);
 }
 
+static int stm32_dfsdm_generic_chan_init(struct iio_dev *indio_dev, struct stm32_dfsdm_adc *adc,
+					 struct iio_chan_spec *channels)
+{
+	struct fwnode_handle *child;
+	int chan_idx = 0, ret;
+
+	device_for_each_child_node(&indio_dev->dev, child) {
+		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, child, &channels[chan_idx]);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "Channels init failed\n");
+			goto err;
+		}
+
+		chan_idx++;
+	}
+
+	return chan_idx;
+
+err:
+	fwnode_handle_put(child);
+
+	return ret;
+}
+
 static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
@@ -1400,7 +1414,7 @@ static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 
 	ch->scan_index = 0;
 
-	ret = stm32_dfsdm_adc_chan_init_one(indio_dev, ch);
+	ret = stm32_dfsdm_generic_chan_init(indio_dev, adc, ch);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Channels init failed\n");
 		return ret;
@@ -1422,33 +1436,24 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	int num_ch;
-	int ret, chan_idx;
+	int ret;
 
 	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
 	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
 	if (ret < 0)
 		return ret;
 
-	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node,
-					     "st,adc-channels");
-	if (num_ch < 0 || num_ch > adc->dfsdm->num_chs) {
-		dev_err(&indio_dev->dev, "Bad st,adc-channels\n");
-		return num_ch < 0 ? num_ch : -EINVAL;
-	}
+	num_ch = device_get_child_node_count(&indio_dev->dev);
+	if (!num_ch)
+		return -EINVAL;
 
-	ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch),
-			  GFP_KERNEL);
+	ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch), GFP_KERNEL);
 	if (!ch)
 		return -ENOMEM;
 
-	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
-		ch[chan_idx].scan_index = chan_idx;
-		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &ch[chan_idx]);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev, "Channels init failed\n");
-			return ret;
-		}
-	}
+	stm32_dfsdm_generic_chan_init(indio_dev, adc, ch);
+	if (ret < 0)
+		return ret;
 
 	indio_dev->num_channels = num_ch;
 	indio_dev->channels = ch;
-- 
2.25.1

