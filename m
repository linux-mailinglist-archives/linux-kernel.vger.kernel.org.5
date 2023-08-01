Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2C76BC39
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjHASVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjHASVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:21:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53DF213E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:21:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DF99E0006;
        Tue,  1 Aug 2023 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690914101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIUXjeBWaacBxz6WsBbjN0nfgEPspA1Ri8UkX9Lqn/c=;
        b=m0Y3FQU7ZWxAVvM4lVxGVpPnJD1KykoHWeve45Ufs3yQIG6QC9Q0wkUZGJ3Ze5diPZ4jBU
        2QGQzsy//qSArcxQ3hGtTHAoaWuLEKzltIUmu6gH9D+f/0hu+v3RoXyMrrBceMuU/J6qvX
        wABtexQ48Lyj1yF6wUZ0aDUDs5/uV397D5k+vbYasGEIdsvE7rQGNdGWcA3h+/CyYw+LeC
        ZP43Qdr7QXHjN0Rh2+C1fJthZkfRiPYFP6KhNL69lGKN6U/KgX/5GbxdkGQwqVuLA9GjO6
        XhxaypvVOTsIIvIY5LU/cSfljQwXQa37v9n2CaaBwYOpm62j8ysXQEvpXTR7eQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v7 3/7] nvmem: core: Track the registered devices
Date:   Tue,  1 Aug 2023 20:21:28 +0200
Message-Id: <20230801182132.1058707-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
References: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a list with all the NVMEM devices registered in the
subsystem. This way we can iterate through them when needed (unused for
now).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 257328887263..4e81e0aaf433 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -23,6 +23,7 @@
 struct nvmem_device {
 	struct module		*owner;
 	struct device		dev;
+	struct list_head	node;
 	int			stride;
 	int			word_size;
 	int			id;
@@ -76,6 +77,9 @@ static LIST_HEAD(nvmem_cell_tables);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
+static DEFINE_MUTEX(nvmem_devices_mutex);
+static LIST_HEAD(nvmem_devices_list);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 static DEFINE_SPINLOCK(nvmem_layout_lock);
@@ -1012,6 +1016,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	mutex_lock(&nvmem_devices_mutex);
+	list_add_tail(&nvmem->node, &nvmem_devices_list);
+	mutex_unlock(&nvmem_devices_mutex);
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -1037,6 +1045,10 @@ static void nvmem_device_release(struct kref *kref)
 
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
 
+	mutex_lock(&nvmem_devices_mutex);
+	list_del(&nvmem->node);
+	mutex_unlock(&nvmem_devices_mutex);
+
 	if (nvmem->flags & FLAG_COMPAT)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
-- 
2.34.1

