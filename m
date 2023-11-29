Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36417FDD45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjK2Qhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjK2Qhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:36 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E5D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DF1FC0008;
        Wed, 29 Nov 2023 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEqUrySQxiqBK2Xf7e40ptVb8/7simBVDiwRFnhyJTI=;
        b=SXq/ud+xRr+okUa1SU0hm65e4dwhrGCGmtXAmtbdIfDDODRbwMHu3+au+k9EscP3WiD4/y
        DaHuw4AR1q2u/215u0O8ZyIXuwSqyM3zPVI2/KdlsoCqRkfa7iv+r3Jyuq35FT13eoB09r
        5sjZDc+XF9L5Sa3ez7WnL7cwrzTe91yAZMspzJK2uzhNK/7tU32TWGeuMsPv7EUPikXRfZ
        SzzSj2wxX1cMr411KbPaO9f1tnxkdF8F61TGc9G1UTm2dFZyh5o5MdDevXpOsag48ienZC
        IL7ZI1DsVZLYB+TeKTyHSitzJjpUUOQTgT3BRYc0tmWEgQ45wIR+NU+qh7e5ig==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v14 2/8] nvmem: Move of_nvmem_layout_get_container() in another header
Date:   Wed, 29 Nov 2023 17:37:31 +0100
Message-Id: <20231129163737.698317-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem-consumer.h is included by consumer devices, extracting data from
NVMEM devices whereas nvmem-provider.h is included by devices providing
NVMEM content.

The only users of of_nvmem_layout_get_container() outside of the core
are layout drivers, so better move its prototype to nvmem-provider.h.

While we do so, we also move the kdoc associated with the function to
the header rather than the .c file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           |  8 --------
 include/linux/nvmem-consumer.h |  7 -------
 include/linux/nvmem-provider.h | 21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 608b352a7d91..b5b6ec8e04bb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -847,14 +847,6 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
 }
 
 #if IS_ENABLED(CONFIG_OF)
-/**
- * of_nvmem_layout_get_container() - Get OF node to layout container.
- *
- * @nvmem: nvmem device.
- *
- * Return: a node pointer with refcount incremented or NULL if no
- * container exists. Use of_node_put() on it when done.
- */
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
 	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 6ec4b9743e25..2d306fa13b1a 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -247,7 +247,6 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
-struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
@@ -260,12 +259,6 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-
-static inline struct device_node *
-of_nvmem_layout_get_container(struct nvmem_device *nvmem)
-{
-	return NULL;
-}
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
 #endif  /* ifndef _LINUX_NVMEM_CONSUMER_H */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e3930835235b..e5de21516387 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -244,6 +244,27 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 
 #endif /* CONFIG_NVMEM */
 
+#if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
+
+/**
+ * of_nvmem_layout_get_container() - Get OF node of layout container
+ *
+ * @nvmem: nvmem device
+ *
+ * Return: a node pointer with refcount incremented or NULL if no
+ * container exists. Use of_node_put() on it when done.
+ */
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
+
+#else  /* CONFIG_NVMEM && CONFIG_OF */
+
+static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_NVMEM && CONFIG_OF */
+
 #define module_nvmem_layout_driver(__layout_driver)		\
 	module_driver(__layout_driver, nvmem_layout_register,	\
 		      nvmem_layout_unregister)
-- 
2.34.1

