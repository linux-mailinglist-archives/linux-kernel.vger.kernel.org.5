Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162508118A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjLMQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjLMQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:05:04 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66933AC;
        Wed, 13 Dec 2023 08:05:10 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDAeIhK020074;
        Wed, 13 Dec 2023 17:04:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=vP0Cuvt
        nE+r/ntZNTtv47/xL+GFWmIspcly1Iqw0j54=; b=54WpcFRkZY3+P0q8YGNKJ1L
        3/vcUxpmMxvEPoMd4eASPOSK4gswANmkfFk33VIp8PBPN1flMJ8cdpNRDhpjtuKm
        MeXMSIwMUVzwo3n8p+c19CSPDDqMMr9N36CiyFD0chWuCK8opJx8aQvAemes3DvG
        Wms6WMBRrPT9EE5ENnb50SPvNhU5mfUKnkWkvEQ67Px/szRmrTJl0kYAzXh8R/ma
        zirqhNkc4ef3bniaAVjesfFFiLEWAiT3I5WwGQMcLdXj2Mf16RtD20L2WdtpRKak
        iQoNF0LJQEXSW/kE3pkNpkdW5KAicYTP2o2ZO6ZN8JAvRuqfGPUVs6QcLcLaGVQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uyb2k1by1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:04:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BF0B100057;
        Wed, 13 Dec 2023 17:04:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28F7A24B88D;
        Wed, 13 Dec 2023 17:04:53 +0100 (CET)
Received: from localhost (10.252.16.151) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Dec
 2023 17:04:52 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: fix NULL pointer in channel unregistration function
Date:   Wed, 13 Dec 2023 17:04:52 +0100
Message-ID: <20231213160452.2598073-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.16.151]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_09,2023-12-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__dma_async_device_channel_register() can fail. In case of failure,
chan->local is freed (with free_percpu()), and chan->local is nullified.
When dma_async_device_unregister() is called (because of managed API or
intentionally by DMA controller driver), channels are unconditionally
unregistered, leading to this NULL pointer:
[    1.318693] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
[...]
[    1.484499] Call trace:
[    1.486930]  device_del+0x40/0x394
[    1.490314]  device_unregister+0x20/0x7c
[    1.494220]  __dma_async_device_channel_unregister+0x68/0xc0

Look at dma_async_device_register() function error path, channel device
unregistration is done only if chan->local is not NULL.

Then add the same condition at the beginning of
__dma_async_device_channel_unregister() function, to avoid NULL pointer
issue whatever the API used to reach this function.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index b7388ae62d7f..491b22240221 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1103,6 +1103,9 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
 static void __dma_async_device_channel_unregister(struct dma_device *device,
 						  struct dma_chan *chan)
 {
+	if (chan->local == NULL)
+		return;
+
 	WARN_ONCE(!device->device_release && chan->client_count,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
-- 
2.25.1

