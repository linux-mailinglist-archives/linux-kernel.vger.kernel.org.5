Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7B778C47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHKKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjHKKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909FE4D;
        Fri, 11 Aug 2023 03:48:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlfU8088887;
        Fri, 11 Aug 2023 05:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750861;
        bh=1J1aJsRAXsLEDQPqmI72aowBUBRI9NH3702tUKywtXg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mQn38KzWQV206KPfucGd8C4SXhs1xb5OwBinfI/AQgnJWINEDnpdPqvsjkatwCg4/
         rRjCTNL6sTWLQ3+A3BQiONm06PG2yZ8z22kL7Gg5jaLg+St1wjfEJnzuYRQKjOMCxb
         JkkaB7JXnXl18Q0PHk9KBrAbFla6MOwXA7gjpuhU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlfhB041854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlesn008170;
        Fri, 11 Aug 2023 05:47:41 -0500
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
Subject: [PATCH v9 01/13] media: dt-bindings: Make sure items in data-lanes are unique
Date:   Fri, 11 Aug 2023 16:17:23 +0530
Message-ID: <20230811-upstream_csi-v9-1-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=WA7zGtIdlvtprz5AyQp96UlSV5/LK+FjhhkDxdUUFaY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g7znUXcD9mZQ3v6I5B8Fl416WfqtaywB+S86
 oHZeeMXkb+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO8wAKCRBD3pH5JJpx
 RTY6EAClKOOm8DH9uuwJonuvJ7vJvY/hbLvSaT2BCeZXOv2JjYdiVWVEN9itu5FauDSBykBuBts
 x/YGG/iULD7xhMj0dOZukQAlPDAozrhCRU27aet/N+Op7WWa3311/mhuH1CxgNMJilHedYr5D4w
 Xy0z9tvAfLUwkk5OwhWx9fKG8s1rk61rCySZ4a2kn5vHH6p5muWcxdgwrfRxnP/cyHJx424sYRC
 jltpQMmb+fZhTZ2FfuifZIbOZGx7+bGsehEw+F8pcVziMzse+EyjDol81miHVxDsvWF2zsByFsu
 e6KNVmM3yChBiMSv6UBhdGpgvruS+JDc120gpuFcgmuZT3pVtKYRdRFMWb6KSMiKm91ty9C/Eyz
 MCn1NL/+aIAPuzHy7GTx0ZDmaOn8DibiBeHelys+Gm9EBJWPoRhXE5+MALfhXU6Ab0iwc6rcNhn
 8DSS0tCe2xEPxQJqt49oMINhBh+GfCVjpLrIMsjkuTah3xZHLWHzV3DQyCghAVAr2WevgwKouzC
 FqPRp012BjN0Eh36NNEXjDoYdfwUVX2dchXpeY7/R/zOgZ/JekYlSocLqg6YcxIbQWuz3jPdyuN
 pe5Fvc+I3ZCqekjm/LevxZC0d06Mzgz9FUyWgGZd/m7Ihp1ep15QOgnoqz18jm3GXxTnObFzS0+
 umezmD/SGCnopDQ==
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

The data-lanes property maps the logical lane numbers to the physical
lane numbers. The position of an entry is the logical lane number and
its value is the physical lane number. Since one physical lane can only
map to one logical lane, no number in the list should repeat. Add the
uniqueItems constraint on the property to enforce this.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 Documentation/devicetree/bindings/media/video-interfaces.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index a211d49dc2ac..26e3e7d7c67b 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -160,6 +160,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 8
+    uniqueItems: true
     items:
       # Assume up to 9 physical lane indices
       maximum: 8

-- 
2.41.0
