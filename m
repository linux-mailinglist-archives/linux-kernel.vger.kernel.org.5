Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9E771C38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHGIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjHGIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD1170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08C17E0005;
        Mon,  7 Aug 2023 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un3Uwaotmlox+IhpuLnflkjcgnz89/YG1Do8CcofnC8=;
        b=YfPsMOia1mh7NlZNTd0z0v90XmIyRDVUTiXx0sWbBjHNy62wGwzTEZn9Czg/FN6L7wf6bb
        W+Xvc0gkWGhrCW2nBx7wj1JbhEDOpVAKSEpbhENhkq4g2Omw+cpUtJGoGiDMVNvKBkBqeq
        aEG57kS+oL7xgV/5h36ZWBzIvXSrdn0b1czkCG+H4t9gjVaqy3yLbV0/G6FURf688/PTcR
        zu1C+ApkGO6ypeueKTGNgNEXDGfEuOdTl21Bu2Qcjj+1LC20E6JyFYak7vcGswajX8tvKp
        KJ9vuqCAlM+djtj43n3jFeoOe4Lc9mz7cqB8XtDB2x8kBA2OCCBkLlMwe+9Reg==
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
Subject: [PATCH v8 1/8] nvmem: core: Create all cells before adding the nvmem device
Date:   Mon,  7 Aug 2023 10:24:12 +0200
Message-Id: <20230807082419.38780-2-miquel.raynal@bootlin.com>
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

