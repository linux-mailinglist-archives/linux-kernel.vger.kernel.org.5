Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D45769028
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjGaIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjGaI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A91A6;
        Mon, 31 Jul 2023 01:29:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Td7l128703;
        Mon, 31 Jul 2023 03:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792179;
        bh=psuyjoOHFt8mMG0vCLisbP0KuLODJVZVf6ULOORRK/g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vvgleiXNJ22AsdOaKf2voB6bv+K5RKNRFJb7d2QIqkkog02qEdqDUlmLwJahJ+BEj
         uHKkz+qbNzM5iNLxR6oGJR1qHOwslARNhz3aNfxsBnrzHP67GqXa7YGlnStYw4Ecly
         wSiviDbECf1R9KtMeRQ6ZAr233xHXGi8ikg0TXHc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8Tdkq011931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TbgI041857;
        Mon, 31 Jul 2023 03:29:37 -0500
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
Subject: [PATCH v8 04/16] media: cadence: Add support for TI SoCs
Date:   Mon, 31 Jul 2023 13:59:22 +0530
Message-ID: <20230731-upstream_csi-v8-4-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=wjdUIhPTPNUiUl5Zr2G6+NzHU9p5C+CuVkNHv5MyBA4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xmR7LVBmz+F0KVBq81OezqTDhkw6tNDZ2FQ
 VApmgRbY3mJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsZgAKCRBD3pH5JJpx
 RQKyD/sEM8vWP5l9lPuD8CjQq1lseRX/srB/8lFCIhOdLI71vJ9JxNcX37DhacH6ZdudoevlUlA
 WNVvZGbrsVOXNQh/at7M8bvPpXFA0ljuHNVEXNHCK6rVN/0tIaSyQE11MiiBtlSEsbd3psUgWP8
 yU9bDYoH8Btt4Me/DPY5KI0g3BV0nP+PzbFlg4/FyJ57fb/u+VrMDrkTQ9ySuyVOoFMSvrP90Kj
 n1k1kMcLpUjJATIAmA+6e/OaO7iMg4jMcl/Q5iDiDdL13L7fqd824/2ZTfMMXd8UBwEbXsm2v4v
 BBFX1D25oWh7dhg41l/AOgS91WeITuWwtRSH4X6Jb21oJXWxBluLj5AK5++ak2EoUscXbEyFWTl
 JE2WLzE23tUhVTK0JWeSjuSu8tPjndC02zdXFzv6MImBUQh0Nrxre1RVVnuOPa3hj3XLF7Xts8E
 wBRFl7w2jqtJff9BvpRVYzvo5wrAyU56AcsCYbu22XJ/N9FtfZ28El59OiK+Lf+VmzdyS6JA/fR
 zD7d9uKK1LhutJm3qFEADkm3D1BKQVWow7As7KBOQpjGciECmggLfi5Yjo5FY1YI32mO8OOKVUC
 1k07nAlVeNdly2aJ8IhgK/boT4TX110msN09Ne5rqUNm0lOUMArVIx0KKXrbWaYYdL8tW5rRu8Q
 /9MhtQ9N1zKC9sA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple TI SoCs (J721E, AM62) use this CSI2RX receiver, integrated with
an external DPHY and a pixel-grabber IP that unwraps the pixel data and
send it to memory via DMA.

Add a separate compatible for the TI-specific version of this IP.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
New in v8

 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 0d879d71d818..b087583d636f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -559,6 +559,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 
 static const struct of_device_id csi2rx_of_table[] = {
 	{ .compatible = "starfive,jh7110-csi2rx" },
+	{ .compatible = "ti,j721e-csi2rx" },
 	{ .compatible = "cdns,csi2rx" },
 	{ },
 };

-- 
2.41.0
