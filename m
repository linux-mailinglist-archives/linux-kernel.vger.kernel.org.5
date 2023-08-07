Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17998771C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHGIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHGIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A14170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AB1BE0008;
        Mon,  7 Aug 2023 08:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIUXjeBWaacBxz6WsBbjN0nfgEPspA1Ri8UkX9Lqn/c=;
        b=GJ4O90d8uLjV6gqbzggm04xNN1c1GAYLfxnH+HXe4fc8uKvmeqmLg2Gb0nwcj/DbtJzC1q
        x4PxtNJ1tFCgghhyhgYx91lYmH+zvOFPRA5Z5wDRoqgpaFKzGWp1fBDiqBfmNA/c2KOgoX
        nEWMaI6auNK4sWQf41wVQ9AIuU2Yg8/IAwBHc/tOmQ+mdJZhexsbNBiRAJLfPZjFIzuSQ0
        EloDDFHZrpo5r5QuNkC83vCRWWynLUskhZ3jPV7BO0bbg21bzIB+beNw1+NoV/tR51OnsD
        WgHwLsD7KgEh9av+dc8WvDMehvm9Shite7jUKGRSSvrNiTQn74hvqNzysQ/W2Q==
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
Subject: [PATCH v8 4/8] nvmem: core: Track the registered devices
Date:   Mon,  7 Aug 2023 10:24:15 +0200
Message-Id: <20230807082419.38780-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

