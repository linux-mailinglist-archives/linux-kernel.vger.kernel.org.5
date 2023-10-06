Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FC7BC164
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjJFVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjJFVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:42:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD36BE;
        Fri,  6 Oct 2023 14:42:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270BDC433C9;
        Fri,  6 Oct 2023 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628570;
        bh=BY2TXeqT8YZGo3EdVf/PnRPzaAn6+6wspkNGCDNbH18=;
        h=From:To:Cc:Subject:Date:From;
        b=Qbu8V/LtW9ChV9JB3G2/g/aethYY6kFIakrXJkyc4/Nx//lOwkLY0w5TEMjC7e796
         vszD/9XBLwq0eIj8OT7M5u9UMYPlMaAUDIEqrO7uLubpgq0P9VCcfGzfymb8+TvALO
         5JPX0KzJKdNXDkiX68fmKdJAFdqk8XY1HBP2p57UdtvMS2gCBCreiXRMMyS4UYgUUx
         9OAX+auHM2RgBLZLA/y7/DgLNxU1gBq8LG6bxd8JwSV9cZyTzmqd4E7QPlIGOVHETJ
         LFuk+fNg7yP8sPXwslf5w2A8eosELUlGFCG92PEsMK0luW8GE+PUoCLnk9GwVo1se2
         4971OZ9QYjUAQ==
Received: (nullmailer pid 337511 invoked by uid 1000);
        Fri, 06 Oct 2023 21:42:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: nuvoton: Use i2c_get_match_data()
Date:   Fri,  6 Oct 2023 16:42:45 -0500
Message-Id: <20231006214246.337426-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Use preferred i2c_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index d7be03c41098..5490f7e0fa43 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -19,7 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include "tpm.h"
 
 /* I2C interface offsets */
@@ -524,7 +525,6 @@ static int get_vid(struct i2c_client *client, u32 *res)
 
 static int i2c_nuvoton_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int rc;
 	struct tpm_chip *chip;
 	struct device *dev = &client->dev;
@@ -546,15 +546,8 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
 	if (!priv)
 		return -ENOMEM;
 
-	if (dev->of_node) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(dev->driver->of_match_table, dev);
-		if (of_id && of_id->data == OF_IS_TPM2)
-			chip->flags |= TPM_CHIP_FLAG_TPM2;
-	} else
-		if (id->driver_data == I2C_IS_TPM2)
-			chip->flags |= TPM_CHIP_FLAG_TPM2;
+	if (i2c_get_match_data(client))
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
 
 	init_waitqueue_head(&priv->read_queue);
 
-- 
2.40.1

