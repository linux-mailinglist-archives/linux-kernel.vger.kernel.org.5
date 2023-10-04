Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223207B97E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjJDWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjJDWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:22:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E2EC6;
        Wed,  4 Oct 2023 15:22:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E7391C0009;
        Wed,  4 Oct 2023 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gsso1VG1TaOtkSVVCJF5rMb/bS6AWoE0lsnGm4HjbN8=;
        b=H/x9tHbLI+7zWMC7ihWzo6QZnyW+b3IX0j/v+z5ek+ReixQc0nq9OPnhURCokEEYyt5bbl
        MojFzE3gnUlGqjBUXSIeriTcGfg9pwJGolU1twWcNSc+RvM3/O7sBDLctQB/J5iPn/4RDB
        kGKGoXNVkilXzE8kfB7MMgeN3r4FD+FqFI+OtHu0EqoupxezVybFk2zt7LFYktNTC4WpUa
        I0/f/ijb1bGu/MQtv2st3yvokJUjzASjIkoKYXaxlMIbhi9u7tDFDejUNjzWZPQfwhjOh9
        eiSfq3huHDgCWLxYdA2DlUFl7gjNk8fxI36VXGTCgltZLIq9qZBXvt7szPGMRg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v11 3/7] nvmem: Move of_nvmem_layout_get_container() in another header
Date:   Thu,  5 Oct 2023 00:22:32 +0200
Message-Id: <20231004222236.411248-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004222236.411248-1-miquel.raynal@bootlin.com>
References: <20231004222236.411248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/nvmem-provider.h | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 286efd3f5a31..c63057a7a3b8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -844,14 +844,6 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
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
index 4523e4e83319..960728b10a11 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -241,7 +241,6 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
-struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
@@ -254,12 +253,6 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
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
index dae26295e6be..d260738ad03c 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -205,6 +205,16 @@ void nvmem_layout_unregister(struct nvmem_layout *layout);
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout);
 
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
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -242,6 +252,10 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 	return NULL;
 }
 
+static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
+{
+	return NULL;
+}
 #endif /* CONFIG_NVMEM */
 
 #define module_nvmem_layout_driver(__layout_driver)		\
-- 
2.34.1

