Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10167B97E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjJDWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjJDWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:22:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84554D8;
        Wed,  4 Oct 2023 15:22:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF33E1C0008;
        Wed,  4 Oct 2023 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozTgRpH7t0hBveOF8yXGnBl2vT15HtovIkhQFtR9B74=;
        b=cQd6LjNlsF+BeoUk5ZXFpdCXxeLsrgtit+isxZblQAIm+u0fis071wiB28G/L1Zz1WDzQo
        V49sfOGDgm9EasASWJkh35SANIbV2rLjPSOpUw4VBSaRChVqqQ/gSSvEpHG3+dINiDwagi
        j7piMSDMXA0HUPkfDf+PfDzPRlvRL1sK5xwKkPEsgguRmwmSTZC3Zh9h1uShJLeybEF0ai
        qnt8HdDjLAdjPDAVx5hEhLDZZlpnPa1dYTiifRAJZFVkBJCx1j/5meSksA/IwNIHuNjdcT
        sz5FSx5NHXaDOOYUs/wLZq7qF2lEn6nVtAA/sZT6WqkdchcGnftsEi/rOYMYxg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v11 2/7] nvmem: Clarify the situation when there is no DT node available
Date:   Thu,  5 Oct 2023 00:22:31 +0200
Message-Id: <20231004222236.411248-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004222236.411248-1-miquel.raynal@bootlin.com>
References: <20231004222236.411248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a first look it might seem that the presence of the of_node pointer
in the nvmem device does not matter much, but in practice, after looking
deep into the DT core, nvmem_add_cells_from_dt() will simply and always
return NULL if this field is not provided. As most mtd devices don't
populate this field (this could evolve later), it means none of their
children cells will be populated unless no_of_node is explicitly set to
false. In order to clarify the logic, let's add clear check at the
beginning of this helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index eaf6a3fe8ca6..286efd3f5a31 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -743,6 +743,9 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 
 static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 {
+	if (!nvmem->dev.of_node)
+		return 0;
+
 	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
 }
 
-- 
2.34.1

