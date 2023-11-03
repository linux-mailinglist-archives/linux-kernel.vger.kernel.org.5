Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC87DFF1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjKCGQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjKCGPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:52 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235571B6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:46 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C388F20237;
        Fri,  3 Nov 2023 14:15:41 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992142;
        bh=2O/2ScZ3CygF88mlMVLZxyoGI2VWLFlNiAqo0wuDir4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AcFz9XeOEs1SJu6NZFof4sNJOFcXmYH7pSl9+PpGrtirABF4TXEE8e2cEI6KuyaUX
         l7n+TRiBmY0MmbMwg4ckH+EyzEavC8pTjH5XouUHEZtp4oXWzz/hrPpv+kNoJtNLvC
         sF2+WQYeymOHy+v3Z4ZXeADLh1Pp7gjx3N0EaKlXCFRtHQ/Ds6dmZtNoNCqSEXb6dD
         OmIY4hYYqe1MjHD99SHAaA24wMmfYwmDLyQWzsljnutWaomeYGZOWmWxK2xdkyf3wL
         5hF2MI/2qYFDqYLJsfRmX7SXRob/NPPy2tt/VgRU5/CF6xpZoKnqg1usCfDk52o89g
         xF1JAfsXlGn1g==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 06/10] ipmi: kcs_bmc: Integrate buffers into driver struct
Date:   Fri,  3 Nov 2023 16:45:18 +1030
Message-Id: <20231103061522.1268637-7-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate several necessary allocations into one to reduce the number
of possible error paths.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 712a80c27060..45ac930172ec 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -66,6 +66,10 @@ enum kcs_ipmi_errors {
 	KCS_UNSPECIFIED_ERROR       = 0xFF
 };
 
+#define DEVICE_NAME "ipmi-kcs"
+#define KCS_MSG_BUFSIZ    1000
+#define KCS_ZERO_DATA     0
+
 struct kcs_bmc_ipmi {
 	struct list_head entry;
 
@@ -79,24 +83,18 @@ struct kcs_bmc_ipmi {
 	wait_queue_head_t queue;
 	bool data_in_avail;
 	int  data_in_idx;
-	u8  *data_in;
+	u8   data_in[KCS_MSG_BUFSIZ];
 
 	int  data_out_idx;
 	int  data_out_len;
-	u8  *data_out;
+	u8   data_out[KCS_MSG_BUFSIZ];
 
 	struct mutex mutex;
-	u8 *kbuffer;
+	u8 kbuffer[KCS_MSG_BUFSIZ];
 
 	struct miscdevice miscdev;
 };
 
-#define DEVICE_NAME "ipmi-kcs"
-
-#define KCS_MSG_BUFSIZ    1000
-
-#define KCS_ZERO_DATA     0
-
 /* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
 #define KCS_STATUS_STATE(state) (state << 6)
 #define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
@@ -478,19 +476,15 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 
 	spin_lock_init(&priv->lock);
 	mutex_init(&priv->mutex);
-
 	init_waitqueue_head(&priv->queue);
 
 	priv->client.dev = kcs_bmc;
 	priv->client.ops = &kcs_bmc_ipmi_client_ops;
-	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	priv->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	priv->kbuffer = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
 
 	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
 	priv->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u", DEVICE_NAME,
 					   kcs_bmc->channel);
-	if (!priv->data_in || !priv->data_out || !priv->kbuffer || !priv->miscdev.name)
+	if (!priv->miscdev.name)
 		return -EINVAL;
 
 	priv->miscdev.fops = &kcs_bmc_ipmi_fops;
@@ -529,9 +523,6 @@ static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 
 	misc_deregister(&priv->miscdev);
 	kcs_bmc_disable_device(&priv->client);
-	devm_kfree(kcs_bmc->dev, priv->kbuffer);
-	devm_kfree(kcs_bmc->dev, priv->data_out);
-	devm_kfree(kcs_bmc->dev, priv->data_in);
 	devm_kfree(kcs_bmc->dev, priv);
 }
 
-- 
2.39.2

