Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A5771C39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjHGIYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjHGIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CE1708
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F056E0002;
        Mon,  7 Aug 2023 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3Zr5zi6oiutEUY5SskrgH9VYy6BX6UnhftLaueXlCU=;
        b=nYNjKgZojkY01P0C3FHtSizaXI7pck8xMwF4KtpouU1pc5Ba06KmbaRp25HKsflW9S1/gz
        5YL15TmIXUdkZYYmJHBDGSYtdYKD6wYl8EOIjaFqVPS8qLHooCa0gNKnnLhe3jbN5i8YCs
        vFS/8AfxHvvY9C8vlYJBjaIWEUlto7xEC+v5dkCk3YgQJJxFUe8J9vDQGAc5Vima++G1HT
        vX6eVtCqBXTesRK2qiCWWBvevHVQEwaybQag2pnboyAXxWHsbgOp4+HUf/rmTiTEXbVkwi
        fsTo7Z10z6TfjLzCe52VfhbDV26zO/BnE7UUPo4GNekFjH6qu+AjnYeyqMToJQ==
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
Subject: [PATCH v8 3/8] nvmem: core: Do not open-code existing functions
Date:   Mon,  7 Aug 2023 10:24:14 +0200
Message-Id: <20230807082419.38780-4-miquel.raynal@bootlin.com>
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

Use of_nvmem_layout_get_container() instead of hardcoding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 48659106a1e2..257328887263 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -786,10 +786,10 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
-	struct device_node *layout_np, *np = nvmem->dev.of_node;
+	struct device_node *layout_np;
 	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
-	layout_np = of_get_child_by_name(np, "nvmem-layout");
+	layout_np = of_nvmem_layout_get_container(nvmem);
 	if (!layout_np)
 		return NULL;
 
-- 
2.34.1

