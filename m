Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3987A9ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjIUSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIUSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:50:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384F8A812;
        Thu, 21 Sep 2023 10:40:50 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38L50Fug031087;
        Thu, 21 Sep 2023 10:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=Qy502fS11BZGcGDP1IGPY0i0y+SNnsTHJY1/5zxvtm0=; b=TJ
        g25FQ+BD3gx5nUATcc3daJwtIXtmhJ9wrgLm6gM0sDaPrNqL+K3myFzLUpGThAVI
        r6ANFSbmbyCSHuWclAZtgq+Jw65/CEdQknwzuWGKNOSLUL+ZyqYMS0tI/1pfivel
        c45O8evQ4IF4as5rLhuW3OP0t/ldQ0L/sjdXwhKRGs9yeaaX8WIbFHdcjoQQXoXo
        ua/ZFCBhntrzLuxFTWyxdzWKbF6behiA0BE03f9ltaTgc6A/ZJ5yScXHe9LuiFR3
        lEyB2w6zrSageCX/G5l+WnGaTbEFcbrYs+V8HLjzX8vc1XCevcnBLrGrzxRr4nUO
        tpCtRhLP81BpCydfw89A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t51sfkb9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 10:04:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D516B10005C;
        Thu, 21 Sep 2023 10:04:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD4BB21863D;
        Thu, 21 Sep 2023 10:04:23 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 10:04:23 +0200
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v3 7/9] hwrng: stm32 - support RNG configuration locking mechanism
Date:   Thu, 21 Sep 2023 10:02:59 +0200
Message-ID: <20230921080301.253563-8-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
References: <20230921080301.253563-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_06,2023-09-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "st,rng-lock-conf" DT binding property is set for a stm32-rng node,
the RNG configuration will be locked until next hardware block reset
or platform reset.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/char/hw_random/stm32-rng.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 819f062f454d..4a602d666dad 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -62,6 +62,7 @@ struct stm32_rng_private {
 	struct reset_control *rst;
 	const struct stm32_rng_data *data;
 	bool ced;
+	bool lock_conf;
 };
 
 /*
@@ -301,6 +302,9 @@ static int stm32_rng_init(struct hwrng *rng)
 
 		reg &= ~RNG_CR_CONDRST;
 		reg |= RNG_CR_RNGEN;
+		if (priv->lock_conf)
+			reg |= RNG_CR_CONFLOCK;
+
 		writel_relaxed(reg, priv->base + RNG_CR);
 
 		err = readl_relaxed_poll_timeout_atomic(priv->base + RNG_CR, reg,
@@ -439,6 +443,7 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	}
 
 	priv->ced = of_property_read_bool(np, "clock-error-detect");
+	priv->lock_conf = of_property_read_bool(np, "st,rng-lock-conf");
 
 	priv->data = of_device_get_match_data(dev);
 	if (!priv->data)
-- 
2.25.1

