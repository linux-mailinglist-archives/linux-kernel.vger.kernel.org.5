Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE27DE336
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjKAPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKAPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:09:47 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468FDC;
        Wed,  1 Nov 2023 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=711TEnGr4X4OH5WFTKZ08m0PJqsxYbQSK0QR8kOpqwY=; b=0168vLjGdnZgO6PPFLKcD/FiuP
        gW82cUPqcAt7Ulf/FtaRG0yhkmuoTsZPi4o6J+HL4Icc0T09QN4RP7j0AmCwxW8rWJepU+OlGd56v
        yLq2qLfP1ui60wFHUFtxFyUxwnlPg4FEk365NF+r1+MUUm5qf1n1Ny1EGtzYrLgRAl2w06/XIluV7
        u/Kzz9n0FmOs+qvjy8aK9ypLwVGcIrRO6shiDXNqhHRNHcxUxhJncPlLwBlFr1llsUKBbTcg0fz2T
        nAOrf17AGo4OrBNuEahIgUnQrPg5+baiJBcf9GgTh5EpRHHQx3sduchpjybXGIIRKLAe4RhH1BAWz
        aeqPinkA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qyCqh-000Dho-TN; Wed, 01 Nov 2023 16:09:39 +0100
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qyCqh-000TBP-GB; Wed, 01 Nov 2023 16:09:39 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - silent spi_device_id warnings
Date:   Wed,  1 Nov 2023 16:09:17 +0100
Message-ID: <20231101150918.4157499-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27079/Wed Nov  1 08:41:09 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi_device_id entries to silent following warnings:
 SPI driver ads7846 has no spi_device_id for ti,tsc2046
 SPI driver ads7846 has no spi_device_id for ti,ads7843
 SPI driver ads7846 has no spi_device_id for ti,ads7845
 SPI driver ads7846 has no spi_device_id for ti,ads7873

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/input/touchscreen/ads7846.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index d2bbb436a77d..30758fc0e029 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1377,6 +1377,16 @@ static void ads7846_remove(struct spi_device *spi)
 	ads7846_stop(ts);
 }
 
+static const struct spi_device_id ads7846_spi_ids[] = {
+	{ "tsc2046" },
+	{ "ads7843" },
+	{ "ads7845" },
+	{ "ads7846" },
+	{ "ads7873" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, ads7846_spi_ids);
+
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name		= "ads7846",
@@ -1384,6 +1394,7 @@ static struct spi_driver ads7846_driver = {
 		.pm		= pm_sleep_ptr(&ads7846_pm),
 		.of_match_table	= ads7846_dt_ids,
 	},
+	.id_table = ads7846_spi_ids,
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
 };
-- 
2.42.0

