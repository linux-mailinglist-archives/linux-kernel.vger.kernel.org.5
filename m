Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6A77494F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjHHTv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjHHTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:51:04 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABC550E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:57:02 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 7F47ED2EAB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 06:29:44 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DAC0240009;
        Tue,  8 Aug 2023 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691476179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3Zr5zi6oiutEUY5SskrgH9VYy6BX6UnhftLaueXlCU=;
        b=nfxXacI46SMugrnbW8CpNixY6lUc08T2a/xyLcq9Vbw+tn1Imt9HYCNQFEQH2GV2DLKAjo
        cpfn/Ytaf3rWv0B9CCRTjwtiNscMlZkMztS7liNYaXudaLaiMbXul36dryAWNh56IIkbYF
        et65n1hyiqIq0hnUVPp2RYYbPoN4F55hO4t3+gRHjzmL3ZrLMo9P42BLsXHAKnISBbKDeK
        q5/Eh1jKAVJowXOedYJMuyfuqEfcre+PHdzYJD7+PFFnDEdq2bsvJzo/AmlP+Jg+t5QxlC
        +bjNRQp0wKEGLJhylvVpzCDK3aqz+p//qXYWZ/7PdrGAqgR3wk7QX6i8QEskkw==
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
Subject: [PATCH v9 3/7] nvmem: core: Do not open-code existing functions
Date:   Tue,  8 Aug 2023 08:29:28 +0200
Message-Id: <20230808062932.150588-4-miquel.raynal@bootlin.com>
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

