Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277D17656EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjG0PGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjG0PGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:06:24 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8952D78;
        Thu, 27 Jul 2023 08:06:03 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RCaFWb026230;
        Thu, 27 Jul 2023 17:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=YgyxpEp3AxX/oTnC63UwO2tMjhlVZ0Pi4rcy64P8JJM=;
 b=55s7MqVytyRvNCS1kj1Fe5g/EiwS9go9S9KmZAPt69ZtVywmmxK8Jf4Y9Q7sl9mnIdqC
 pG/Pp64c61u3egD9Sm4KbWXNl09G3Fns1nJ1q7fmS8VDc5S5cUMsqKat5GpGw2JKr1zo
 RMSBSEdw5CW7jtE8o44kWWpNVdNc3W0aa+o0Ojy5VdHbRoERrP4BYWShO/cCjk/hJoZ4
 vOoNin2xIWg9zndD7yz7xI2/U4DMAwwKeUwbbyZVM8T50GIJvdj/uJLMo/+sMSv5uPy+
 MdhbWuuMncIFq2X/1R3tpNYQZlzEWtJPj04Hv4q3YVyYqX9I+te9ueqxAmCoOTLULLzY Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3n7wtc1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:05:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1782010002A;
        Thu, 27 Jul 2023 17:05:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F7B7209BA7;
        Thu, 27 Jul 2023 17:05:45 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:05:44 +0200
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
Subject: [RFC v2 07/11] iio: adc: stm32-dfsdm: add scaling support to dfsdm
Date:   Thu, 27 Jul 2023 17:03:18 +0200
Message-ID: <20230727150324.1157933-8-olivier.moysan@foss.st.com>
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

Add scaling support to STM32 DFSDM.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 77 +++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 96f4e0c64cdc..dba1a8ef5451 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/iio/adc/stm32-dfsdm-adc.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
 #include <linux/iio/sysfs.h>
@@ -77,6 +78,7 @@ struct stm32_dfsdm_adc {
 
 	/* ADC specific */
 	unsigned int oversamp;
+	struct iio_backend **backend;
 	struct completion completion;
 	u32 *buffer;
 
@@ -600,6 +602,8 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct iio_backend *backend;
 	const char *of_str;
 	int ret, val;
 
@@ -648,6 +652,12 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	if (ret != -EINVAL)
 		df_ch->alt_si = 0;
 
+	backend = fwnode_iio_backend_get(node, 0);
+	if (IS_ERR(backend))
+		return dev_err_probe(&indio_dev->dev, PTR_ERR(backend), "Failed to get backend\n");
+
+	adc->backend[df_ch->id] = backend;
+
 	return 0;
 }
 
@@ -1091,7 +1101,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	long timeout;
-	int ret;
+	int ret, idx = chan->scan_index;
 
 	reinit_completion(&adc->completion);
 
@@ -1101,6 +1111,13 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
+	if (!adc->backend[idx]->ops->enable)
+		return -EINVAL;
+
+	ret = adc->backend[idx]->ops->enable(adc->backend[idx]);
+	if (ret < 0)
+		return ret;
+
 	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				 DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(1));
 	if (ret < 0)
@@ -1134,6 +1151,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	stm32_dfsdm_process_data(adc, res);
 
 stop_dfsdm:
+	ret = adc->backend[idx]->ops->disable(adc->backend[idx]);
+
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
 	return ret;
@@ -1198,7 +1217,14 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 				int *val2, long mask)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int ret;
+
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
+	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
+	int ret, idx = chan->scan_index;
+
+	if (flo->lshift < chan->scan_type.shift)
+		max = flo->max >> (chan->scan_type.shift - flo->lshift);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -1232,6 +1258,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		*val = adc->sample_freq;
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale is expressed in mV.
+		 * When fast mode is disabled, actual resolution may be lower
+		 * than 2^n, where n=realbits-1.
+		 * This leads to underestimating input voltage. To
+		 * compensate this deviation, the voltage reference can be
+		 * corrected with a factor = realbits resolution / actual max
+		 */
+		adc->backend[idx]->ops->read_raw(adc->backend[idx], val, val2, mask);
+
+		*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1), max);
+		*val2 = chan->scan_type.realbits;
+		if (chan->differential)
+			*val *= 2;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * DFSDM output data are in the range [-2^n,2^n],
+		 * with n=realbits-1.
+		 * - Differential modulator:
+		 * Offset correspond to SD modulator offset.
+		 * - Single ended modulator:
+		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n, and Vref to 2^n.
+		 * Add 2^n to offset. (i.e. middle of input range)
+		 * offset = offset(sd) * vref / res(sd) * max / vref.
+		 */
+		adc->backend[idx]->ops->read_raw(adc->backend[idx], val, val2, mask);
+
+		*val = div_u64((u64)max * *val, BIT(*val2 - 1));
+		if (!chan->differential)
+			*val += max;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -1360,7 +1421,10 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
 	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
 	 */
-	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				 BIT(IIO_CHAN_INFO_SCALE) |
+				 BIT(IIO_CHAN_INFO_OFFSET);
+
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
@@ -1451,7 +1515,12 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 	if (!ch)
 		return -ENOMEM;
 
-	stm32_dfsdm_generic_chan_init(indio_dev, adc, ch);
+	adc->backend = devm_kzalloc(&indio_dev->dev, sizeof(*adc->backend) * adc->dfsdm->num_chs,
+				    GFP_KERNEL);
+	if (!adc->backend)
+		return -ENOMEM;
+
+	ret = stm32_dfsdm_generic_chan_init(indio_dev, adc, ch);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

