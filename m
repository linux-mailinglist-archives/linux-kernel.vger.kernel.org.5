Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1992F7BA5A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbjJEQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbjJEQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AEE7285;
        Thu,  5 Oct 2023 08:59:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 838311BF213;
        Thu,  5 Oct 2023 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696521554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozTgRpH7t0hBveOF8yXGnBl2vT15HtovIkhQFtR9B74=;
        b=Ck3ZN1IJji2OY+dMnjA+DdC2x6VAfE4ZZp7r6kuL50L/U58uuF4Frsm3crOYTr2Xr6QRD0
        +2km3T173WAQtA58ghw76qM5qNQ+nteaRCDHz1tugcKisNuWXIpTq8+UDJ1G8xw6o/VNT6
        CzzExtKtwXEV5OrA0fYuK9Hjz/MY2F9mGltJW1omwlUgWWk3MUpjiZdlF3IOY4yGTFdMik
        9M1Yp7SfHZwOfk4rh9oJaJdvXJUj6rEg6HvBo6kKScUGUobTXOrdG3JH3y3h2LsBM5yL0Z
        4+V8yieOVFLwOKkYmxKjHHkXDeL7yw0rt57oMPF6CufiaU2NdAxEhjAINHjiKQ==
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
Subject: [PATCH v12 2/7] nvmem: Clarify the situation when there is no DT node available
Date:   Thu,  5 Oct 2023 17:59:02 +0200
Message-Id: <20231005155907.2701706-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

