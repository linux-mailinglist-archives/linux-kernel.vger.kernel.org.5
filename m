Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523AB76BC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHASV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHASVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:21:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC0213D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:21:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9957E0007;
        Tue,  1 Aug 2023 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690914103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jd0UhfUDeWS6RJi7TPdxTJy86kv9J6eGWIB4ZKNoAwM=;
        b=n04pfgg1wSKMjJNVxmp56VFal0ugBPYkmy5t1dDuafuMyjxUYljax85DhvCfjEDCFaMv0k
        qx2383RQC98jWRdXCNqVzyTf2zsl7qNZnJX6zVgutp+LXLqRpmL9lP+2nkGSP3BXBTlaLi
        8S5iP6BH1olUkL83NxnzvB5gLaJ1x/4b5A5cdNUOUyeZnAzZWj0z4IpEu9PMLHaw55M8I2
        mIls/wv7LKlqe9sRk1RiKlPonxJkRLZwOU6cYgGpjFFmPkmM86OatEc7iof9lhp/y/MXKe
        jAcF2cA90Q4EWcdUTTlaCA+5EMAJXsWhchER8BT6xv4/vNt3Ug+2e1NJXAMPjg==
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
Subject: [PATCH v7 4/7] nvmem: core: Notify when a new layout is registered
Date:   Tue,  1 Aug 2023 20:21:29 +0200
Message-Id: <20230801182132.1058707-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
References: <20230801182132.1058707-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index fa030d93b768..859d41431e2f 100644
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

