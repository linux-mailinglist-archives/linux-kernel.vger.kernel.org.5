Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D42778C59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjHKKsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHKKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8900E55;
        Fri, 11 Aug 2023 03:48:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlu4d088956;
        Fri, 11 Aug 2023 05:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750876;
        bh=VIQIUwUq7rF5LQLOhQKcBWMmcl7qk82frmPGJ6vtEfE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nAifa+kYFqfJVev6SboZMz6fv1vG11l6QFviI+/OkpYzCxIwdx5HzJ8Tp59nDnkgw
         6SDImhvO/T1tcyNmvJYL0eAa3nJ14Fvj5/U/jrZNrjTUoztz3VqBbornPm5/ESElsi
         jMlv6aa9jPG+9MJqx56GIPMx8NAqQxHYj4YE+Aek=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAluPP014254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:56 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAltma019971;
        Fri, 11 Aug 2023 05:47:55 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v9 11/13] media: cadence: csi2rx: Add link validation
Date:   Fri, 11 Aug 2023 16:17:33 +0530
Message-ID: <20230811-upstream_csi-v9-11-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Ro81cyobnEUDDNNUnAs+ie3mvGkg8wjHF7FIlL5x7AU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8JETnp7fSxEYUawwNs8LP2bfE6jbcRsVAp8
 QILPVxNHIWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPCQAKCRBD3pH5JJpx
 RVJTEADUx96uguI0iqedm9PJxl+NYTjGbkn6PebuJi/B8h3C1Rknd42wGTuo5RYW8qAHNkDXDSk
 EBbMVlrbxyEn736eGXTjk6LcV+dGEQCRovqIXUaogAoI6Fn013k9s6bFzwxVQcjnp7ZCtyjHLH9
 KmZlq/4yJl5WEEj44CypMvJjJhikQdgbbjohG8jcjaVFnuM8XZU9m3rHyZodrzfPlARONJbh6ig
 r2m8h+NxQ+1HP/ngiwHxPQuJHirrJxa2RMDyxEgVlNv1ITZJP9znqesEc04+0Ab4P41D6MTiwAJ
 OBTNs8Q6f7z6ATuQTFIjrWljSEAVyOkZ+2k7NBf91hpVK22IrAxMCdNClCy+dZObPvYO4csBzSC
 kWdL0CeIagmcpR8jnBmQIuNzPjyz431h8VrxSxtXzaHkoEVmXMQLOsqeJkbI6IgHBwbC3UPFaTx
 bmM/Qd4UfXGOG7RMk0Pn4L3prFYJl7YbjqtEGdvm2Dte7JXGkvb7xEbo32Vu88UjtlUBVYjIi5U
 8fSED+wXDYIIYSlJDRnGThX5xFfLcELbth3UdLl7J20FqtbEy7eczuMUtrFCmYZYlkQP+21sMFs
 9qFHNK4m95RReTVRmJd94at5KH0Hts2JcWRzxiksHZyZauqIp8DkQevwvVY8GgfcWKd6P4TdvGa
 B5O6RejEdHJvMuw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 0947b112a573..5eeeb398cdb5 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -458,6 +458,10 @@ static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.pad		= &csi2rx_pad_ops,
 };
 
+static const struct media_entity_operations csi2rx_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 			      struct v4l2_subdev *s_subdev,
 			      struct v4l2_async_connection *asd)
@@ -674,6 +678,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
 	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.41.0
