Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E0769041
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGaIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGaIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:30:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BFE56;
        Mon, 31 Jul 2023 01:30:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Trdh038442;
        Mon, 31 Jul 2023 03:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792193;
        bh=PDQzrcsyIWoQUkN7yFLXQsVX+NVhWg1yd6L7eS4+MDM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s+nnnv2BvDOYsMSryZ028LknFrgCFwybH3BonV0iH3EPdjEVb5qN5ZJ2pEmKhIt4U
         6g9fN0eCUHF4HI32S9zVriWWjglk940wn0uyQewYgjmhgHe5QQ40cNXbuT9oR+HYSQ
         NOaI0h7NjdironuSftAgLDT35Gnw3I1T46P0K8+4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8Tref012016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:53 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TqdF042012;
        Mon, 31 Jul 2023 03:29:53 -0500
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
Subject: [PATCH v8 14/16] media: cadence: csi2rx: Support RAW8 and RAW10 formats
Date:   Mon, 31 Jul 2023 13:59:32 +0530
Message-ID: <20230731-upstream_csi-v8-14-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=AKVjO0CK0Wb+0rYPtuwRRSbLnnBHaMvq8vFCll7HWBQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xv5CU9imuLg6j7xlbdDkY3VAi/AN3bV9tUT
 QkMjlIkJumJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsbwAKCRBD3pH5JJpx
 RXypEACCCViMSrv9s7qtfsLxhLdVVF/l9BXqyUQ7b1kx8WE0LdBrhEiJnwQSeOhlI5/hGat/nYu
 MdyJprqFWymw5wIIOIGCu4p6oBNyEnlj+LNQtAPY6kDX0TWIXCpkdaY75H7ZYCuixGV0rBC5RjL
 F+DhMfgtYNIFvBG9fQT8GSQsHRL6FdyKBjj15H709ukiFQic+Q/BS1XRtveTs7LN934Ai2K4EeX
 +SDc4cwn3DMFnsmJodMOiGLPXKEG+UdpSpN5oYJm3aI0sOMLMYxCSCHBEL9pc1SF5Uoq6Tii+kT
 SpoAz4FXvssm2/IK+VYXFIDcywqU9Zw/l0JL487p0suGsTs/93PS+J23F/EHe3lRW3gLyPj6nVW
 m3beHOkV5Jq8piewXKtMKMhEykiQaH/WH64ubNu58zRDFWXfMzgPDvEuIXD1ow1J9JoXRx59+Uo
 KUxzJT56K0SxrRYJ3WVuhPuCXzEGORODgimPa6GAUD7LWlGaHeq0BH4u78SUgOWlBmABO3fwrUu
 dLA6Jcs8f4/SWJ9oxowz/SMcU6U/ux5V2xDsW2O37uaEoBoQhVcV6mpaWsnCQX9aLHmfOaGON4g
 tWp3nilNj9WaZyPUcbaPM7TFLg4d5+AH9U/ZK0GH2hiNmSSVidRheQlHJf7VSLEVl+wUeVNHf93
 EP4z/or+creRUfA==
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

Many CSI-2 sensors (specifically IMX219) send RAW bayer data instead of
processed YUV or RGB, so add support for 8-bit and 10-bit bayer formats.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
New in v8

 drivers/media/platform/cadence/cdns-csi2rx.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index aec33d28a66f..bac74474841a 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -122,6 +122,38 @@ static const struct csi2rx_fmt formats[] = {
 		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
 		.bpp	= 16,
 	},
+	{
+		.code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.bpp	= 8,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.bpp	= 8,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.bpp	= 8,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.bpp	= 8,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.bpp	= 10,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.bpp	= 10,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.bpp	= 10,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.bpp	= 10,
+	},
 };
 
 static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)

-- 
2.41.0
