Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6635D771C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHGIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHGIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C814110EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96901E0009;
        Mon,  7 Aug 2023 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4dYHwL4Kcq6etObC2M6cBOZ7KmMlQzjfr2hw8SBaeU=;
        b=k0m+gdyJ6Vm0q6GmoAjRjCfBdOudPAv2IYDn0ESIIZv99751WKcNHURJbrFnlLN2QegL2X
        8nFBg+SVsgeCYV5HM438lEg4vBk4pusSkGMCZp86WepN7lrWgpnAJTGrpUsCVAMtHIkqQn
        n+jTgPEXCtwiLnTp4gxQCOamku6BoiyArRG4GTO0uCLWwtdddoPGbox5reVhzk6HwxqWa/
        8pBJB0nkGHVuZ5HcrcyU4YnfgSShZaXhAohRNF7aH+tQGAb/xAMKHBlfJKF5XIRtH7wuft
        KoXKCvUzQGilbGrSlR26XLgpzU4zbAQs9/OE56ubIqf91dUsDhrXz8e/+MQw5Q==
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
Subject: [PATCH v8 5/8] nvmem: core: Notify when a new layout is registered
Date:   Mon,  7 Aug 2023 10:24:16 +0200
Message-Id: <20230807082419.38780-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell listeners a new layout was introduced and is now available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-consumer.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4e81e0aaf433..0406fbc7b750 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -776,12 +776,16 @@ int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
 	list_add(&layout->node, &nvmem_layouts);
 	spin_unlock(&nvmem_layout_lock);
 
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_ADD, layout);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__nvmem_layout_register);
 
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_REMOVE, layout);
+
 	spin_lock(&nvmem_layout_lock);
 	list_del(&layout->node);
 	spin_unlock(&nvmem_layout_lock);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 27373024856d..4523e4e83319 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -43,6 +43,8 @@ enum {
 	NVMEM_REMOVE,
 	NVMEM_CELL_ADD,
 	NVMEM_CELL_REMOVE,
+	NVMEM_LAYOUT_ADD,
+	NVMEM_LAYOUT_REMOVE,
 };
 
 #if IS_ENABLED(CONFIG_NVMEM)
-- 
2.34.1

