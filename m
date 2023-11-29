Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98C7FD755
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjK2NAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjK2NAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:00:21 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742019BD;
        Wed, 29 Nov 2023 05:00:27 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB3RWm005228;
        Wed, 29 Nov 2023 14:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=5dNPirvASkdcY7pOymXDVq0mD0jqbY8yDoyX0nISUyg=; b=b1
        628BF7IEJfaAVkQujS5HMWpS+TQdkXb0I9SUEuCz+1YXiYjU7Ka89IP53HP0bfHn
        2AJR/4i56lsoHFnRXOWBVVNnAVjpcdCcEbT373LOfE779Kkkb5/2p7fMaHRooFD1
        1c5RPhgksPvzRw2ThoJpQsHTfPUN30g0o0IjvDr9hBMoGCJZryUIElKFEyw9j4G8
        WlbSeunqoM/3yMAAz5Hs1jSDJAxO8Do7Ew6WJirzwuaFUFNoOVO9+fa5LE+mu7pz
        DLhgB8eY8qZh9BwFRQr05B6JM3LtkU/r97BngEJhwJUV/4OKpY1zGXHRUiSeEdo9
        nj/S4Mwl1C61pcVmx4Dg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unffdw1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:00:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 573CE10005C;
        Wed, 29 Nov 2023 14:00:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6AC721BF5E;
        Wed, 29 Nov 2023 14:00:08 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 Nov
 2023 14:00:08 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] i2c: stm32f7: simplify status messages in case of errors
Date:   Wed, 29 Nov 2023 13:59:11 +0100
Message-ID: <20231129125920.1702497-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129125920.1702497-1-alain.volmat@foss.st.com>
References: <20231129125920.1702497-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid usage of __func__ when reporting an error message
since dev_err/dev_dbg are already providing enough details
to identify the source of the message.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 34dcc370e615..2a011deec3c5 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1602,6 +1602,7 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	u16 addr = f7_msg->addr;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
@@ -1611,8 +1612,7 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 
 	/* Bus error */
 	if (status & STM32F7_I2C_ISR_BERR) {
-		dev_err(dev, "<%s>: Bus error accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_err(dev, "Bus error accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
 		stm32f7_i2c_release_bus(&i2c_dev->adap);
 		f7_msg->result = -EIO;
@@ -1620,21 +1620,19 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 
 	/* Arbitration loss */
 	if (status & STM32F7_I2C_ISR_ARLO) {
-		dev_dbg(dev, "<%s>: Arbitration loss accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_dbg(dev, "Arbitration loss accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_ARLOCF, base + STM32F7_I2C_ICR);
 		f7_msg->result = -EAGAIN;
 	}
 
 	if (status & STM32F7_I2C_ISR_PECERR) {
-		dev_err(dev, "<%s>: PEC error in reception accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_err(dev, "PEC error in reception accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_PECCF, base + STM32F7_I2C_ICR);
 		f7_msg->result = -EINVAL;
 	}
 
 	if (status & STM32F7_I2C_ISR_ALERT) {
-		dev_dbg(dev, "<%s>: SMBus alert received\n", __func__);
+		dev_dbg(dev, "SMBus alert received\n");
 		writel_relaxed(STM32F7_I2C_ICR_ALERTCF, base + STM32F7_I2C_ICR);
 		i2c_handle_smbus_alert(i2c_dev->alert->ara);
 		return IRQ_HANDLED;
-- 
2.25.1

