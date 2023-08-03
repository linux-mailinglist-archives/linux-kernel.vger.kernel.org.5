Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC176E912
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHCNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjHCNDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17B14226;
        Thu,  3 Aug 2023 06:03:15 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 373CeVra009018;
        Thu, 3 Aug 2023 15:03:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=8u4d3LvlGUVXnqclczmcYRVp1j8VsBGa+/jN0gq0QF0=; b=qx
        te2mDKZaPpbobyPTxf0NdlqR2169gtOYY18MhJjhEjNZY6GEnwi8Z0s88d9612z+
        OsFanHq7SWUNkvFf2pukLcghm7v8f07jfdTdZTFEg1ruwET0nUEzjjY5IFtEbEZZ
        GGIv2x236sUW5JBLLjkYbZMXq1I6BMp3Z1eQR1IVsSiCaZiXNjDcqP+6sv1HK+ZK
        6fxFp4AIqdy3+duOaPrPam+5m45dd0WYPTDI9TFmfiGvQL5sQx5YH7nVgFlYdGY8
        CixfIJlNMqiD9lMmm4X2YkivSLbbNGECCKoCum6f6OjyFRHdh7PNvNkFjo7mtT8E
        N8s2y9Rtqgy8iOcBmJew==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s8cet04np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 15:03:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 419B010008B;
        Thu,  3 Aug 2023 15:03:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 389C62207B5;
        Thu,  3 Aug 2023 15:03:02 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 3 Aug
 2023 15:03:01 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 6/6] serial: stm32: synchronize RX DMA channel in shutdown
Date:   Thu, 3 Aug 2023 15:01:34 +0200
Message-ID: <20230803130134.155355-7-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803130134.155355-1-valentin.caron@foss.st.com>
References: <20230803130134.155355-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

In shutdown, RX DMA channel is terminated. If the DMA RX callback is
scheduled but not yet executed, while a new RX DMA transfer is started, the
callback can be executed, and then disturb the ongoing RX DMA transfer.
To avoid such a case, call dmaengine_synchronize in shutdown, after the
DMA RX channel is terminated.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 8fc0526be898..5e9cf0c48813 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1123,8 +1123,10 @@ static void stm32_usart_shutdown(struct uart_port *port)
 		dev_err(port->dev, "Transmission is not complete\n");
 
 	/* Disable RX DMA. */
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
 		stm32_usart_rx_dma_terminate(stm32_port);
+		dmaengine_synchronize(stm32_port->rx_ch);
+	}
 
 	/* flush RX & TX FIFO */
 	if (ofs->rqr != UNDEF_REG)
-- 
2.25.1

