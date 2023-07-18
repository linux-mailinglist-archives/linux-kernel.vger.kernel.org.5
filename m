Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9F758083
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGRPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjGRPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:13:01 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E0170C;
        Tue, 18 Jul 2023 08:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oROhxqtESt8XNtiZp1Op04daozdROxuvB+ijyaYUtmwwd9Sl3ieGmbvZXlZhslpIiiE6sBzgaH559LHcq9bK3ecHL3lxOSvwqE0JTk48OoN/lNyke+doR8MWehWquMyddqPbeXsayX22mg5ANB9UGwyKeZ858rPJSkUvUxrqTxbQZ4C2s3LcsdzUbC5wZxjydQvn65VbHaO5K9amA6FLbcja8L0uQHecw+qz9x8Ivwa0KGer0Mcn2CCLmj/e5EkHhP821A+KiZDN498h3mkVtJtsx4re6W895Q3bU3pclpHLZzqNdaeqP6iFW3OF1DBO5b8M6nwBlVb2WwFK0IpiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQeBP0r5b6fH55JrpvHtQpom3OuX8C2X2z1qcYLDpao=;
 b=JKZkuL8A1Xmxy3pkxt5ZSiGHGWG9uvWogxX+N2X3lUmRq16lqngvFGRD5O6BMaKYbJgYaJ7YgID7AL67BMP6TzkpFqlWJ+90hM7Bv8UqzEpNSQxQCxQAg42l11DUc0J1Ls9KZLDkaG6DH3Av/kqHUTLTNYJNZGB1DzEj1mZ88fr4NHUFh2qfYKSBeFNfAMZPHfxSI/psL6iFY68GBSB/2o/fqIOFoKAypE/7lhOgb5fsWJSHPbt3UV4GYlA9avq/2j2Wt1liBbWBxiIJlVEyj2wH8rmkwlTQvMxGUkl62yKuHDpsQ9Kfa5xM6M4n8uhxmoWwSQQQpNn5bHdNiVgGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQeBP0r5b6fH55JrpvHtQpom3OuX8C2X2z1qcYLDpao=;
 b=GwpAIMmxmLtu5M3myi8uiHcwo1s+BcjXGpGCkXgcj3yd4GK7PrIYj/m+9ec9OjpPIP34oAqIWmgll5Z45AbCZ2ex6O0vslkvNrQGuqHYkNN6k8pOIl+Gvyaq/Q7cgXKqCyyX3BaTnlPheZvHVyeiwUnZkYHW+tlqQw9JobSrC3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB8PR08MB5482.eurprd08.prod.outlook.com (2603:10a6:10:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:12:57 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4fd7:91a9:a92b:295a]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4fd7:91a9:a92b:295a%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:12:57 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 18 Jul 2023 17:12:45 +0200
Subject: [PATCH 1/2] drm/panel: sitronix-st7789v: add panel orientation
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-feature-st7789v-v1-1-76d6ca9b31d8@wolfvision.net>
References: <20230718-feature-st7789v-v1-0-76d6ca9b31d8@wolfvision.net>
In-Reply-To: <20230718-feature-st7789v-v1-0-76d6ca9b31d8@wolfvision.net>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689693175; l=2588;
 i=michael.riesch@wolfvision.net; s=20230406; h=from:subject:message-id;
 bh=zXaxnG0Q2EtwQPM71/6274e9MYjrKlx+BpihRQedYDo=;
 b=EkH5JoMpUEk9bWa34uNJmoW/bFoz/L/s8n1ZwgEUEA6glX0pbUUDrYZBpfsWbNhdr/mp+DxLI
 hs5d7h2nWC/DQsnfgBa91EPZ0q/pbMNAaMTi+iAcaarPHwVAB3VKzy3
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=G03kuYHL670EcdsWaNfVA7KnHWmkSpj98XziQm/hjbk=
X-ClientProxiedBy: VI1PR08CA0247.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB8PR08MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: e11e0863-14bb-4f9c-4f27-08db87a177b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfniSOMw52X6/Vh/dvgAnbD07Rf6x8ChF2rwMRXb717irEK0Ap0fDBDW/aZ5k/0mO8SIENma4alWJgJqIYnbWycJG1zOeX1pvxOhqGFm+EMkyhWwLq9EJt76HLNfoUBifThqbgxOBojmeSE1rjdH3zfeno34l7GIDtB7f1B2KtNpOPWGyNFXGgRxu53waH3ENBv7awOQCT20jUN+kqWs9W0RQMKSKUva9RJUcDWflXmlKA4Tv6PFQqlxQI9/lblTb299KKW1sNnOdV7hCExGaTVGnyhJVDqmlp6LE44uIepN58z2eFrkGeqT7h5VPu1oGyIOLewrZSeak0C4VhJiZmDOfnOv+Ut8aG30jQEMODbQuBeSHEgooD1VKIEVQAeHU5Gqa6E5SU0ekndnujeGfK/87KaFRdjy7WSYriyfl6hzgEtP6c0e31UqNMjyb1hcZUEpe+hgLEUIzTE+9INaztd+y7peA1vs8bvFszCIfBxak1wqGQm6SG+u5vgn2L3/jGI3lS7XeCTxEYdFt63B+Skaj+00VPsBLR3L7IBG1jyRSgkgtxDjf1rD8XY62u72KmHY48fARsi3NKU1HWiupBePuNj9hd2jFUFFnj2ZtYnSgDAN+hZVprncFiUpOFQTlf5A2oTkyQALqa775hREbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(451199021)(186003)(110136005)(478600001)(6506007)(26005)(107886003)(6666004)(6486002)(6512007)(83380400001)(2906002)(66476007)(2616005)(52116002)(6636002)(41300700001)(38350700002)(86362001)(5660300002)(4326008)(38100700002)(66946007)(316002)(66556008)(36756003)(8936002)(7416002)(8676002)(44832011)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlA0eUJ0WDdaNkkzSjZVcHF0Z0UyTFE1UjZsa2k5Vi9PbE5KVU5HbTlTRVl6?=
 =?utf-8?B?TWdLcWdLMGZpd3grcmUvelJYR28vVTZYMEpRYlQ4ZFhYQWd3dEFuVEZ5Z2Mv?=
 =?utf-8?B?NUpiVXUyTDhwYTNKaFM3TCttZzBNOEpHek83M0NqYzdrZFcxWndsSEdyeWtM?=
 =?utf-8?B?bVNwZEdrY3VFTmxKcFlCSUpiOENCVVlaSXlxNWpRM21tYVFOcUxxTkJWR3dj?=
 =?utf-8?B?Tnh4QW1pUXNjcWt2Y2h2U0NoMWZHTkJTR1h1M3FmbHlMWHZNa1RGZERlVEN6?=
 =?utf-8?B?MTk5empCVllHdExGODZ4VnVWQldIVlozekd2cUQ2U3Qra29WUEM0bmZoUGNC?=
 =?utf-8?B?TTVIUGhQS1R5ZHFhWHZ6dkZDZkxQVGQ2T0ZFcWxweXFqWmh3bXRFbXd5TGZy?=
 =?utf-8?B?UVNuQlM1OXdiWFdmWUVKejZWTkhtZUZIMXpJU0tZTWlLV0RBcEJuS2hCTDlv?=
 =?utf-8?B?UHhLTEpBZzV0RTNIakNFeW9FdUJ0cGloQVNGRVBrMFNiRnpnSDFtTlZhNzU4?=
 =?utf-8?B?TmVOd2FnZTd1VUJ3R05FemZ4VEljV2VWMlNIOCtrUXBlckdjU2VyaFQ5bFdI?=
 =?utf-8?B?c0NSamx3c3JOSzdsQ24yS044TEh3WndNbnpSNkRwbDhoVkN1eENmcWYrN1Jo?=
 =?utf-8?B?NHVvRWVJeTN3UFphVDZucnlWdmdJa3p1RHBxV1d1MGI2VU85eFV0elpxajh4?=
 =?utf-8?B?OWZYQitHUm5RTm1za3kzRjlFa2N6eDdVTFFRQ1ViOTVuRkxTaWhDSEpPRElX?=
 =?utf-8?B?cGd6cDRWa1ZFWm9iVW5GcXowTzVmcFVmNTB2TnVERlpuK1FHRGZvcGZOYVQr?=
 =?utf-8?B?TXhsWEk1Y2FwU0tNNTFyVlF1L0hiLzZncHlUbUo1UjIzYUc0NERtdkFVZDhH?=
 =?utf-8?B?S2VqUUd5R1NPMWVaY1p4WW1RUlhZMGVQVVFGNGgzeE80cG1VeDBjY1lnMWI5?=
 =?utf-8?B?b0UyQStINWVPM1B4cHN4bm5ZMnVmL0FvQkJZK3NLdWp4NE12VG9qWXJUVDdK?=
 =?utf-8?B?aGE5S1YrK2R1UTRFU3dXbElGYzBSVlFmNW9OMzIyUTJaR09yRFY3WUloYWdh?=
 =?utf-8?B?Mi9jZ2x6NnNlRVFNaXZ0Y1NDNE1FckUrVzJrM1hrRVhtU0hCUncyWVRLcEpZ?=
 =?utf-8?B?blM5QVcrNWt2bGQvSzNLRU4yWTNaMzYvY0pLbnVrK3pKYkJHQnNGbHcyVWw2?=
 =?utf-8?B?bkY3VHdzVFFNdWRuSHlXSDNzOU02WjNYK0d3emdKWGljR3FIdnp0NE1PWG5K?=
 =?utf-8?B?R3JQbEJnSjJTazRQT2VzSWlQVE56cVM1WGhmVTBLRm1qU24ya0VvRTRHOE94?=
 =?utf-8?B?aS85clZqdFVPR1BmOG4xYi9xTnJ3K0xocndYcy9rcWNrNFlDZTA1cDZVNmpI?=
 =?utf-8?B?SXJWUENPUlZJRU5sOXVuS1BobkVpVXU4WUd3WUw0V1U2UzRXQ1AvTzhJbStv?=
 =?utf-8?B?dFRERWVFcnprTzBYaE50VGIwSzJxYU5SSGd3WC8vbHN6UTY2VEY3RXp5TGo5?=
 =?utf-8?B?b1NUNFRlV1ZIMy9ZQy9iZnpEVTM3YXNvdmgzVjRGNnFjVjlxenVOQXREZEgv?=
 =?utf-8?B?cjkzY0dOTHBUbmNBOHVtQXd2YWxlaUdyclJ4NlFONzlNWmdDcFdPMEpjT1lP?=
 =?utf-8?B?Y0dhTHp6MkxydFp2VXZiRWlJSU1iWlBLck9OQ1JVVkZzZ2RROUk2K2ljeXRQ?=
 =?utf-8?B?LzlvRmxENnQ4V0U4ZkJITUkzb0ZwYkhESWU3OU5DWjBwTlo0eGpIRWhldU4y?=
 =?utf-8?B?TGRIZnZpRFlqT2NESlZNZ3hKUGliM2FKSDJ4KzhETlRYZkIxV1pxN2pPV1ZI?=
 =?utf-8?B?MDYrUExJVVBtYThKc2p0Ujh3WEd0bWJRU2VZeVhaSFJvMXFVSFFRemxQZjFO?=
 =?utf-8?B?aWxmWXh1eFUza2VNaWlJdTRVellGQU9CSHdhZnZDdGRrOGJpb2xuajZBNDZS?=
 =?utf-8?B?R3Z0UTJGd1dXd2NkSXdTbU90VjZSbkREMVVwajF3RTM5NVo3bWVhZ241NUZF?=
 =?utf-8?B?N1R5Q2djbG5NdWtKditUM1FHZ2RTY0NGN1N4OFIyYk5KcDNUMmlVaUZqdGZU?=
 =?utf-8?B?Y1RMZm5QSElFbGdMUTV4UEpyRGQ3OUxURmEwWkROTnduaHd5eE1kUHVNck52?=
 =?utf-8?B?ZG1jazN3aERrQ1huNThPMkxQN1BCK2FtdDkvQXowSlBwMGRzTlloQkE3N1ZY?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e11e0863-14bb-4f9c-4f27-08db87a177b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:12:57.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Goa+gS/Gf1EV5ZumI1ouzhPSmzwdGHQyK4TMGzYlAyWaI0ge6Qbc/7EAV6U4r3dQOQmojgwL5TsAQcP9iLngqh9eMkPsIkgOGxxbvrGVhFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determine the orientation of the display based on the device tree and
propagate it.

While at it, fix the indentation in the struct drm_panel_funcs.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index bbc4569cbcdc..6575f07d49e3 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -116,6 +116,7 @@ struct st7789v {
 	struct spi_device *spi;
 	struct gpio_desc *reset;
 	struct regulator *power;
+	enum drm_panel_orientation orientation;
 };
 
 enum st7789v_prefix {
@@ -170,6 +171,7 @@ static const struct drm_display_mode default_mode = {
 static int st7789v_get_modes(struct drm_panel *panel,
 			     struct drm_connector *connector)
 {
+	struct st7789v *ctx = panel_to_st7789v(panel);
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_duplicate(connector->dev, &default_mode);
@@ -188,9 +190,22 @@ static int st7789v_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = 61;
 	connector->display_info.height_mm = 103;
 
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
+	drm_connector_set_panel_orientation(connector, ctx->orientation);
+
 	return 1;
 }
 
+static enum drm_panel_orientation st7789v_get_orientation(struct drm_panel *p)
+{
+	struct st7789v *ctx = panel_to_st7789v(p);
+
+	return ctx->orientation;
+}
+
 static int st7789v_prepare(struct drm_panel *panel)
 {
 	struct st7789v *ctx = panel_to_st7789v(panel);
@@ -346,11 +361,12 @@ static int st7789v_unprepare(struct drm_panel *panel)
 }
 
 static const struct drm_panel_funcs st7789v_drm_funcs = {
-	.disable	= st7789v_disable,
-	.enable		= st7789v_enable,
-	.get_modes	= st7789v_get_modes,
-	.prepare	= st7789v_prepare,
-	.unprepare	= st7789v_unprepare,
+	.disable = st7789v_disable,
+	.enable	= st7789v_enable,
+	.get_modes = st7789v_get_modes,
+	.get_orientation = st7789v_get_orientation,
+	.prepare = st7789v_prepare,
+	.unprepare = st7789v_unprepare,
 };
 
 static int st7789v_probe(struct spi_device *spi)
@@ -382,6 +398,8 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+
 	drm_panel_add(&ctx->panel);
 
 	return 0;

-- 
2.30.2

