Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0F7F84C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbjKXTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:38:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546F98;
        Fri, 24 Nov 2023 11:38:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75138FF809;
        Fri, 24 Nov 2023 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700854696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gK80R0M7dvN1cmSQk+8Hk9wbTsrIf4Z+IhzQHo3PHu8=;
        b=T1SM1suskaIuCwd4kbvQdQEiCDN0oAjSleDEKrXTCILUIxzphNI0zhgJybSIQIrmryz7u6
        /YnbjIthrPPA0P0XS/XbSETl0b5bvcraz1J7zgh3OpmKFVws61sAhJyKQC4od1wZ0zKV4a
        gJ7aRuJowhbUd693yO0AMyFGYvQcUqN6wEoB1METfs1byt7wZAvYW//nGnGXluRlC1OZpm
        YyNG4yJzmcLh6SCr5qTpsO7AhTckcVJLxpx4hV/2kjm4/ZB9eSf909vqMpK03xTx1xJe64
        CbpNxyvWlVIqiP/MSqUVwtp8E/CiUzuOmMynCt+i9twpmHLtcvtBLN1n8FDGHg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH] nvmem: Do not expect fixed layouts to grab a layout driver
Date:   Fri, 24 Nov 2023 20:38:14 +0100
Message-Id: <20231124193814.360552-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two series lived in parallel for some time, which led to this situation:
- The nvmem-layout container is used for dynamic layouts
- We now expect fixed layouts to also use the nvmem-layout container but
this does not require any additional driver, the support is built-in the
nvmem core.

Ensure we don't refuse to probe for wrong reasons.

Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells *layout*")
Cc: stable@vger.kernel.org
Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Please note this is a temporary fix as this piece of code is going to
disappear when the NVMEM layouts 'as devices' series gets in.

 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bf42b7e826db..608b352a7d91 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -796,6 +796,12 @@ static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return NULL;
 
+	/* Fixed layouts don't have a matching driver */
+	if (of_device_is_compatible(layout_np, "fixed-layout")) {
+		of_node_put(layout_np);
+		return NULL;
+	}
+
 	/*
 	 * In case the nvmem device was built-in while the layout was built as a
 	 * module, we shall manually request the layout driver loading otherwise
-- 
2.34.1

