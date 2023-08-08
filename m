Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35D7743B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjHHSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjHHSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:08:10 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE663D56
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:09:22 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 93E0AD2E95
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 06:29:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 639C324000B;
        Tue,  8 Aug 2023 06:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691476180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uLCgToS16/0CGtApzHhwLVg0LDST2ybBj3RK0mHpVg=;
        b=a9ZoX82PEUVHuMLJ0ldJ9i/mxqfnVpm1OrRlYhfL5hdvTMGCNJ3vlzlbTvfBB+Z0BRxNoN
        ZjRs6//ZPBhxsmuTU5eDY/PfMQxnOgFBZ/E9S0MK0tRPIJWRVDYNBnBICVwNivvdqml5XH
        4WU216O0Ih81RT1CePWzoQl3a9OEvLnPwbvCJCCfhvlIvUSwHtqiF9VMRSOmT1qs2T8NYT
        YyFu8UJGL7GPelBSOvrCeASSbS9r6EtXx0AB8D68ryeqPE0lidf6diLIY8pn3NdJDNjqq9
        lOkQag55axHHLt+Y0Eqo7nk/nqNqil6LUQ6Kfv/N2F7iHTW9ubz2+8D6ECxKZg==
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
Subject: [PATCH v9 4/7] nvmem: core: Notify when a new layout is registered
Date:   Tue,  8 Aug 2023 08:29:29 +0200
Message-Id: <20230808062932.150588-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808062932.150588-1-miquel.raynal@bootlin.com>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 257328887263..4fb6d4d7fe40 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -772,12 +772,16 @@ int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
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

