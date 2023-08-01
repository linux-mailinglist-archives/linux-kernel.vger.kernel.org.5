Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC576BC38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjHASVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjHASVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:21:44 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6445D269A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:21:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BE8CE0008;
        Tue,  1 Aug 2023 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690914099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3Zr5zi6oiutEUY5SskrgH9VYy6BX6UnhftLaueXlCU=;
        b=Qwc4xWMhuvilEC8gbcLTJ38MSm192xYthNDF4cItf+Qlz+MmsgOA28ca3z/PmVV4hIIbGo
        /p77PON4HbCwGxBD36wYi/Iybj1PHNX6XKCu+CIB2or+zKU8dzSw7K+i6jMWfFXwBUOuk/
        EEt8umo6taoe7vA1wcbpE4gJQ85/unuyYegiy3Y4oDdL5G5q0pKO4LSajU/zZvpkyLKfNk
        /Nu/NYxPne1XMEZL4DBnEM2WfCtnkTMzLGdF3RsuRRDOj2EdR4WGHxAeXoH9ecUQrbT7aA
        jCMpph1MLWPtg9xi5MWFRe8ebWYaB8LJuMUt2V/i8lXkOBgJDOViGKs2h+m/gA==
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
Subject: [PATCH v7 2/7] nvmem: core: Do not open-code existing functions
Date:   Tue,  1 Aug 2023 20:21:27 +0200
Message-Id: <20230801182132.1058707-3-miquel.raynal@bootlin.com>
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

