Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4C7ED5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjKOVLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjKOVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:11:31 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6919AE;
        Wed, 15 Nov 2023 13:02:28 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2fc858feso44805a34.3;
        Wed, 15 Nov 2023 13:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082147; x=1700686947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MNTv3m7vV3LeSZ/LXI5jnB/Ck5QlVqFhZbxK23FsCo=;
        b=bRH/W5y8JLuZvaUSW7XtcQirDjXk1fcUPFPKG3QcM1dl7W7VBbGccHdmMlm7+7eFCp
         o4Jh79NJ8OV13B/OCGN6YX0+Xbl2uV6ojSdR2ltq6pVdk5Swgs1eQRGi03wCDCIzc2S6
         kfy1cVaGV1ctnU3XHkWys5nC3w0JkGtD4t260gFyT1HRvqd3EdPIKMzShFcfRSkAHxep
         aled+HGECG2krhPHBQkU7Hg8VmhBF6Aede8KAhcZGQo/fhZbkVut91F7H6sRwdcpQy00
         jKAvaf7NDRsnnIVODpfFIp2a3gI/jTbtRJIFPDkHAF7O/kfJ1V9IzeEjcVDjsk1GJzIf
         HY7A==
X-Gm-Message-State: AOJu0YxMf1JKKVXTN9oIiv3iaDyl5lfVjAOmXky1yVfpBKBQhyfpL/gx
        akwk64ePswqQiPgPIhIWw+Zabf2pzw==
X-Google-Smtp-Source: AGHT+IHooMCUv9Qk9trfPzv12GS9eBksyhXhbmrwBVg3IDr5zE4kIsOLVuKuiAOUFz9x3+MDMMVjjA==
X-Received: by 2002:a05:6830:1e72:b0:6ce:26ba:324 with SMTP id m18-20020a0568301e7200b006ce26ba0324mr6350826otr.15.1700082147673;
        Wed, 15 Nov 2023 13:02:27 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f5-20020a4ab005000000b0058a010374e6sm785776oon.39.2023.11.15.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:02:27 -0800 (PST)
Received: (nullmailer pid 3744123 invoked by uid 1000);
        Wed, 15 Nov 2023 21:02:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] tpm: nuvoton: Use i2c_get_match_data()
Date:   Wed, 15 Nov 2023 15:02:15 -0600
Message-ID: <20231115210215.3743873-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
2.42.0

