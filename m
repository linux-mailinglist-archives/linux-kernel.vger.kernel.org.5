Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059D97F6153
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbjKWOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjKWOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:24:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C75D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:24:07 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0FB366073C3;
        Thu, 23 Nov 2023 14:24:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700749445;
        bh=hBBVYOni7cSkfCkjnkHwiGOw1ojnLHF2HyXwoM95mOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlXKF97HYmm+2kinqxiHZS0U2qBNNec2ICOCN/0Vrxb0xT/QwMbm3iUjLn5UeVLhV
         pXjjyr4uWLhOnNqm+V/aJGNuFdQAdOWtJHPPjzd0nhO3vljQuLb8McIBcVL95dI113
         s+f+DDJoE3v1YaDsMH9Dmq10O5jT5SpboCffIadjFAXaiobFhXNRZEKFzyvVhfV5/I
         20O8JS7f18nwgsDGlebzLsAiz1HGnFXEBcD3pzxd62R1HIx8kMK2HI0H1kT3d3mVwI
         wcpLP+iXtaFs0FzVXjjTHHqYz7OBltEyduB3CCfv14ByFABTOy8XmdmWCV2UZPyObb
         kfBNEq4Om8HNg==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 42AEB95B3A95; Thu, 23 Nov 2023 15:24:03 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bus: moxtet: Add spi device table
Date:   Thu, 23 Nov 2023 15:23:38 +0100
Message-ID: <20231123142403.2262032-2-sjoerd@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123142403.2262032-1-sjoerd@collabora.com>
References: <20231123142403.2262032-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The moxtet module was failing to auto-load on my system. Add a SPI id
table to allow it to do so.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

 drivers/bus/moxtet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 48c18f95660a..e384fbc6c1d9 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
 	mutex_destroy(&moxtet->lock);
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
-- 
2.42.0

