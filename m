Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26E755D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGQHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGQHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:52:03 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9E11F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:51:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9237360006;
        Mon, 17 Jul 2023 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689580312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un3Uwaotmlox+IhpuLnflkjcgnz89/YG1Do8CcofnC8=;
        b=lVX2afz+B4qHgh/0ieV127PWztHw9UJvh71z5wscYgDB5/SvgkKR28zKhnY88MpfJ31hF9
        5HDWe6wAG8fQvwv2dGi9OLO7TIWBQnbp8HUQs2OcxsUSVHpMGPHU0q8RBU9T3dRLdSFVcm
        UB81cej5nuRO2KkhXGtjs0uxXsKvytd9mn5Mb/8TfnTymzPH3XEG6sDBEayofBwF2tSB34
        NVNaGLUoqVyaCIGM6TbL0707/IkBJ/rr3jTPSzHZkbQNZwsTmbGwK6N9TYbR4sMv4EmZhW
        ggw34CztVbuFV8j2dz6a4oTcl1d0b4eoT/5bXGncQePmzTzfbgLp0e0ZODGPYQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 2/3] nvmem: core: Create all cells before adding the nvmem device
Date:   Mon, 17 Jul 2023 09:51:46 +0200
Message-Id: <20230717075147.43326-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717075147.43326-1-miquel.raynal@bootlin.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's pack all the cells creation in one place, so they are all created
before we add the nvmem device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3f8c7718412b..48659106a1e2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -998,12 +998,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_add(&nvmem->dev);
-	if (rval)
-		goto err_remove_cells;
-
 	rval = nvmem_add_cells_from_fixed_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
@@ -1012,6 +1006,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_add(&nvmem->dev);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
-- 
2.34.1

