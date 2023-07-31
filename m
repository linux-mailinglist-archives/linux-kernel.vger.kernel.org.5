Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8F76903B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjGaIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGaIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:30:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58518E;
        Mon, 31 Jul 2023 01:29:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TqJ3048214;
        Mon, 31 Jul 2023 03:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792192;
        bh=TOWtliwygNzBGb/ibCY8FAVxTe5ucabVCXVLqbPzG3A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fIaJGn2unbPw1Mt23rzSRB9Xi/xzDurGKkWRWJl2eeau5u5D4skECMlckWefBU/u7
         XjQiKNYmuxFGLMQHN+moB7U5Gx+i94eX9bIXy17oIUCfW1l+Z2Pq4UogZIQsohujPU
         sWaP7l9EsvZh7NCBBg7boCX7691xyKtgXgcLsrlE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8Tqg9106791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TpWw016622;
        Mon, 31 Jul 2023 03:29:51 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 13/16] media: cadence: csi2rx: Add link validation
Date:   Mon, 31 Jul 2023 13:59:31 +0530
Message-ID: <20230731-upstream_csi-v8-13-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=lSNQlPKlsyGFmQvca0Tc9mreF/svzWnzPl4bNCF+Gbw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xuFFxXCi/8J1ntBEIvudOu6QOmI5HLZgulr
 QzzMndDLi2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsbgAKCRBD3pH5JJpx
 RY8ND/9opPlc0xzjTFQ+5dHh0andZMH995yAV6YSP9Vn7g7jA/sVh41wZ+4dABSJ+SOgHDYzySX
 joGnF95eVSFz4LKXjkqcCo8Opzyem6zKhqhltK9C1WDIjkkpqgJa9qpDb6OynQ9NuG1xpK0Pm3u
 Nd3ALQBThfBCjjPbxjyU+uknE5PGi5PYE4AJGk17jwPdl0p2VS0SySenjQjuFwGuwFLoh4dOJZf
 QA2ZqMY0ETpL7jj91OEiv786R5Mgh6pH6qhgIb1tFpNLcHP+ILcfr4TOGzMJGh9Eo/Sq5euaeYm
 yTiX2MFTEX5VRGPmiNMhxTDkwUKxSRLcJ3G+QGisJ/eyLkQDO36peXpv8iFUGNnrE/98XNrqbBU
 Xv4Qmk+rzdCnJaLvWfK1eNrNxeB4TlZRnAA0qNfeJBLcSR+7Mm8i8xl1atEeK2pYS4HCylET8y6
 mcO2CyEiFST9+8O4FbvT2ejLdxJw8VJi+DRndcQvBwNl8O953MibGx0GC7pXn0E2T+jtqrT6TCn
 PnswgYqHCnytTUdlZV5QrKb3rixrTfYxdTmPOyjyYF2KS+wgasY8sJI8YiPZmnsVtqHkT0173PJ
 wiKVlodoY/xAOhQckAkOWTqD4r8SuJp/4RN5MlxFpA25V/YcRIdozOTtKwaSpEri6nMZXBCTRxq
 emb1kfpe2Pptyqg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Add media link validation to make sure incorrectly configured pipelines
are caught.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index d82a8938932f..aec33d28a66f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -463,6 +463,10 @@ static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.pad		= &csi2rx_pad_ops,
 };
 
+static const struct media_entity_operations csi2rx_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 			      struct v4l2_subdev *s_subdev,
 			      struct v4l2_async_connection *asd)
@@ -679,6 +683,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
 	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.41.0
