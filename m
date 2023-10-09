Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223B7BE814
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbjJIRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377381AbjJIRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:31:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63925B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:31:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C22C433C7;
        Mon,  9 Oct 2023 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872688;
        bh=PakgZLNGLzXC+87Hq9LZSbho3Y+2lz8rmGoxLVl+4GE=;
        h=From:To:Cc:Subject:Date:From;
        b=KkDhsBMFnsoUmGCrn712KXCDmMDgE1hE5B3lbUE2Fsen4OipNHv/pqBfvM5Fq06lx
         Dhj1NFjAtuEYg3IjINbIMpp+663FtqHbjdljWnQ01a+ESBpVvmYxtDhDz78GXjBwqq
         f7uvb9WWeVW/ga1laT9sqSsNAvAMCEyzpS9LB+pR8K6lgjMM5kmTybdr1YMw3x1+mt
         oYExEqK/pTmng0ahA/9o0QT//A24NcvGWfyjJ9QksjB5dvu/CMb+/wgc+2K0oH5f1h
         55d0XL2J27RozOgmnKsjOD+tpO9QmiOBy3MuwmojhhVFl2ofuGJHySvTTvyyH6p5aD
         1pNIhjZ7DAOYw==
Received: (nullmailer pid 2504790 invoked by uid 1000);
        Mon, 09 Oct 2023 17:31:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: wiznet: Use spi_get_device_match_data()
Date:   Mon,  9 Oct 2023 12:29:00 -0500
Message-ID: <20231009172923.2457844-5-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred spi_get_device_match_data() instead of of_match_device() and
spi_get_device_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/wiznet/w5100-spi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100-spi.c b/drivers/net/ethernet/wiznet/w5100-spi.c
index 7c52796273a4..990a3cce8c0f 100644
--- a/drivers/net/ethernet/wiznet/w5100-spi.c
+++ b/drivers/net/ethernet/wiznet/w5100-spi.c
@@ -14,8 +14,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/of_net.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #include "w5100.h"
@@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, w5100_of_match);
 
 static int w5100_spi_probe(struct spi_device *spi)
 {
-	const struct of_device_id *of_id;
 	const struct w5100_ops *ops;
 	kernel_ulong_t driver_data;
 	const void *mac = NULL;
@@ -432,14 +431,7 @@ static int w5100_spi_probe(struct spi_device *spi)
 	if (!ret)
 		mac = tmpmac;
 
-	if (spi->dev.of_node) {
-		of_id = of_match_device(w5100_of_match, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-		driver_data = (kernel_ulong_t)of_id->data;
-	} else {
-		driver_data = spi_get_device_id(spi)->driver_data;
-	}
+	driver_data = (uintptr_t)spi_get_device_match_data(spi);
 
 	switch (driver_data) {
 	case W5100:
-- 
2.42.0

