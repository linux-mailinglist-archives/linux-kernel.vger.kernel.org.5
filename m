Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB57BDD96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376897AbjJINK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376779AbjJINKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6159E;
        Mon,  9 Oct 2023 06:10:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9vDe055536;
        Mon, 9 Oct 2023 08:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856997;
        bh=wzciJJ2YTFJVP2b52Ols5dE9idQaEIAPyxn7t7coENY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CWfc5bqvAQaJLN6j/XkXFrcmRO0vP4UOBG90Wuk/yJGdrSYaYvBOOi1EAw0NVax0+
         rTI6Y4wz9EjS+CG1H3MYsND92S/ZyE9UfpJ+37vJ+g3xUiPPA/ocBLSxdRiI/moDuI
         m5RAW9qI3zIt0EGQivA2/hf1/czJQjlwqs3/cWG4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9vr6014598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9uYE007422;
        Mon, 9 Oct 2023 08:09:56 -0500
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
Subject: [PATCH v10 10/13] media: cadence: csi2rx: Populate subdev devnode
Date:   Mon, 9 Oct 2023 18:39:36 +0530
Message-ID: <20231009-upstream_csi-v10-10-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=bDHn/MyiN9Cg1dBR/V+/tvt/oG+ArF4duwVMUN+kd6w=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/st6XqfcSRECGzh8gspwZdhiJGOXJDFbNkmQ
 2yEKKpbYtaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7LQAKCRBD3pH5JJpx
 RVmAEACdtqsZMsiylF4NAfMIE2WT+Pq8Db2VpoPxWm0zq6gcuy7eOdX6rrry8TPhQLP6zr0Vy1u
 sXJpAizqJLsGDw9pLNdrGM6DD4bBkUIHC9LFRF18JL+Bhbg7tS3WCpr6bfOZIJP0UTVRVUgxxnQ
 8hNTso1LvKTsXrBzT8GReQN/s6V0L1XMpTW21ATreVisbWn8Hx6eHPslspd0IDWq5UO9cbNruhK
 TC8rbMJr1Rkmgrdqy32B+ozS2FZiO6OQzB+EB+t9+eyQ4DcN7H2FIgJF5dkU5iy/rf9nopfXhMx
 chZlz05N6KOIoBBIhODTWZ/5FAZv85Bi6OznIUZPHvjHW8j57eGaAuW9EOxjzASw/NWTCGY82Fe
 wZ1R7Juy9eGHORHhGhwBwV+WCZ2p6Q8wbyG3JlLt+zDZqzS9b3NM1EcXd0qd/EaZef0sfOTvUpl
 C/Qi3nFFYqpoj1JxrjDW1MOMNa2cdthljgz6vQexM7TpvZ+PUIcIojcJQ5rnb/wH14DAOOun1mB
 bG8nd2CftzfGXL7oBeLNMHfREOFx6EYP4e14NRhc3y4zG4Urxf02z9048rDCF38l2WrRO14GPNo
 VIZ1KRpwspstUA94VIoZdAt2wISbIhTlfjyKHowDwKA7B3m7p3NQAaVIZedV+ThqXNggqOrHx13
 tG7JlSe0uP0Nfaw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The devnode can be used by media-ctl and other userspace tools to
perform configurations on the subdev. Without it, media-ctl returns
ENOENT when setting format on the sensor subdev.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 812f31dfaab1..d0c2a5b3d0d5 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -668,6 +668,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.42.0
