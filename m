Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2E78C651
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjH2NnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbjH2NnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:43:06 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBFACEC;
        Tue, 29 Aug 2023 06:42:35 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TBrQKU019514;
        Tue, 29 Aug 2023 15:40:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=PwB5UAXoCWyBxCXABWMO2FWSZwa0SK8ik9JE6Z0KgzY=; b=mR
        XwklBzu1lZv2pXDoprQzD52F3B1S7lXai4jSBGk9L/tSnxtmFJZrh5d1qToeUFzF
        JIKR68O5hK5O4y4E+nPz0VFdT9XyBBgM8rTwT7+ENWRAc6sfvJ4bNOHWVF7NjWiL
        Cro+J8Osro0ojOWAE8pYaFZ8V8yx6+tI0FisHi93g1Ms4g9XVL0loPcR/r2mIMBy
        HMK+7briU+7vs3GCUBTvITLA4HSssOhjeOlqjSshzuGd3SpYALtIWWCdKs5CTfHw
        B+NxPqxUaQn44cG3n+QxecZrzwp/HFbfs0TshkPAIB7gwaO8tZqxbvq5YGU+qsOD
        z5VXygz6RGA7blPf3EmA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6tfmchm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:40:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD7B910005E;
        Tue, 29 Aug 2023 15:40:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4DB82207DB;
        Tue, 29 Aug 2023 15:40:57 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:40:57 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] mfd: stm32-timers: add support for interrupts
Date:   Tue, 29 Aug 2023 15:40:25 +0200
Message-ID: <20230829134029.2402868-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two types of STM32 timers that may have:
- a global interrupt line
- 4 dedicated interrupt lines.
Those interrupts are optional as defined in the dt-bindings. Enforce checks
on either one, four or no interrupts are provided with their names.
Optionally get them here, to be used by child devices.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/mfd/stm32-timers.c       | 46 ++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-timers.h | 11 ++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 44ed2fce0319..51fb97bdab9c 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -214,6 +214,48 @@ static void stm32_timers_dma_remove(struct device *dev,
 			dma_release_channel(ddata->dma.chans[i]);
 }
 
+static const char * const stm32_timers_irq_name[STM32_TIMERS_MAX_IRQS] = {
+	"brk", "up", "trg-com", "cc"
+};
+
+static int stm32_timers_irq_probe(struct platform_device *pdev,
+				  struct stm32_timers *ddata)
+{
+	int i, ret;
+
+	/*
+	 * STM32 Timer may have either:
+	 * - a unique global interrupt line
+	 * - four dedicated interrupt lines that may be handled separately.
+	 * Optionally get them here, to be used by child devices.
+	 */
+	ret = platform_get_irq_byname_optional(pdev, "global");
+	if (ret < 0 && ret != -ENXIO) {
+		return ret;
+	} else if (ret != -ENXIO) {
+		ddata->irq[STM32_TIMERS_IRQ_GLOBAL_BRK] = ret;
+		ddata->nr_irqs = 1;
+		return 0;
+	}
+
+	for (i = 0; i < STM32_TIMERS_MAX_IRQS; i++) {
+		ret = platform_get_irq_byname_optional(pdev, stm32_timers_irq_name[i]);
+		if (ret < 0 && ret != -ENXIO) {
+			return ret;
+		} else if (ret != -ENXIO) {
+			ddata->irq[i] = ret;
+			ddata->nr_irqs++;
+		}
+	}
+
+	if (ddata->nr_irqs && ddata->nr_irqs != STM32_TIMERS_MAX_IRQS) {
+		dev_err(&pdev->dev, "Invalid number of IRQs %d\n", ddata->nr_irqs);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int stm32_timers_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -245,6 +287,10 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 	stm32_timers_get_arr_size(ddata);
 
+	ret = stm32_timers_irq_probe(pdev, ddata);
+	if (ret)
+		return ret;
+
 	ret = stm32_timers_dma_probe(dev, ddata);
 	if (ret) {
 		stm32_timers_dma_remove(dev, ddata);
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 1b94325febb3..ca35af30745f 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -102,6 +102,15 @@ enum stm32_timers_dmas {
 	STM32_TIMERS_MAX_DMAS,
 };
 
+/* STM32 Timer may have either a unique global interrupt or 4 interrupt lines */
+enum stm32_timers_irqs {
+	STM32_TIMERS_IRQ_GLOBAL_BRK, /* global or brk IRQ */
+	STM32_TIMERS_IRQ_UP,
+	STM32_TIMERS_IRQ_TRG_COM,
+	STM32_TIMERS_IRQ_CC,
+	STM32_TIMERS_MAX_IRQS,
+};
+
 /**
  * struct stm32_timers_dma - STM32 timer DMA handling.
  * @completion:		end of DMA transfer completion
@@ -123,6 +132,8 @@ struct stm32_timers {
 	struct regmap *regmap;
 	u32 max_arr;
 	struct stm32_timers_dma dma; /* Only to be used by the parent */
+	unsigned int nr_irqs;
+	int irq[STM32_TIMERS_MAX_IRQS];
 };
 
 #if IS_REACHABLE(CONFIG_MFD_STM32_TIMERS)
-- 
2.25.1

