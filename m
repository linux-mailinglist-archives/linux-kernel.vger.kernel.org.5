Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DA7BEC7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378700AbjJIVO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378676AbjJIVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBFCF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830C3C433CA;
        Mon,  9 Oct 2023 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886057;
        bh=1P+7RFu0aISkH0ZXrfPD2UYOmjJhhQztaM/bytpbPG0=;
        h=From:To:Cc:Subject:Date:From;
        b=FUASgoOkW3H4sQJWUq9bs/q3k2ZFrbkW6yXoEQNRBCCeoUbGblQq1YqusPnfVuslw
         TBuv57UGDfJ81Tduw2FKZlgoUzEOfAZSD0ASBvNc0r/T0HygPDZKXWXFBwik98aDHq
         avNXv9TytqTqk2U/fuchQHpUylGP2wSdZ/5NveLXMdNZ328lD2gn1Kb3nNSJ/5MWbu
         TqWRDVVCa+c/OjYqsYnuo/xSoruqfk8L2D2mNeTFP0pgrxNQ0BizvOk4Xd+hT2gXof
         JiSjtHAxBhZNMFRwqFOP/Jo/BtKZQRjWkfu5zZjjZkXcePBzP7fMk7/sZJKxMC3GUV
         hmLDIDtdQ2NqQ==
Received: (nullmailer pid 3245594 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: motorola-cpcap: Drop unnecessary of_match_device() call
Date:   Mon,  9 Oct 2023 16:13:36 -0500
Message-ID: <20231009211356.3242037-6-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/motorola-cpcap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index a19691ba8d8b..d8243b956f87 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -11,7 +11,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -290,14 +290,9 @@ static const struct mfd_cell cpcap_mfd_devices[] = {
 
 static int cpcap_probe(struct spi_device *spi)
 {
-	const struct of_device_id *match;
 	struct cpcap_ddata *cpcap;
 	int ret;
 
-	match = of_match_device(cpcap_of_match, &spi->dev);
-	if (!match)
-		return -ENODEV;
-
 	cpcap = devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
 	if (!cpcap)
 		return -ENOMEM;
-- 
2.42.0

