Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170467CC15B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjJQLAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjJQLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:00:24 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F10EB;
        Tue, 17 Oct 2023 04:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf+crTVOsl1KWCPdf+4mutL9lYvo5QnRrAmPtqlesGq43MC3iYajYUtV/HKKB5R6NPbDYh7qD8XMYMleghcxdKKrCJ7l+4TvegnyflWKj8wvbTHtGgUEoI59XrIWzofusQEpqeSuU5F+LPK/J5m6DfdqSUuHZxcMCrUch8btU0kcFwy7e0N4pZ/n1j3GX3uxr+jAx1WECRtwO1j6612Z8EAqLoJiTj+wnWFBY+8fcqe8pClTwxvnqjXr2NqGmmykiLhGhMhfXvZ5SJeDVod+xQzvPgsbdre4ItrcQn/FMuJy7mGlO3LW5MeiJPMFDg5Ce5/x6lywL7E4QN/CYVSO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s+e6xOeLPB29hou1wYdBocfusQeBy7NbBpEtLp6KMQ=;
 b=SQthJtuI4IehgmSyCOPLaK9j7RXWAvB4KO9Zk02KZenXXbek/X56lg2lZ0zBJM8kHkYWL+939VUHbaBBYvx0ArMitkfXqxdLb/BMbENVqyzt/WtKQ8rJHXCqLsYViG12fs4pdz+IEt53fmGiV2wTQhvwGRfwOXEi7G5IuVSkrhCb0aXI8oMLyHXz5eO6DsvUinyz/lgfUXEMJhYAxH2PnS6uCbaw0tzf2WmeRi4g8J0EkuTimc3Izuke3jQ11TCb0KTlmQQXjn6X655cyfZiB9uMtv18jlRta/b1xF2vo7d3FT83yOnpufTpbAHg3NTExlxZLufa7ZJ1TR9+uIPq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s+e6xOeLPB29hou1wYdBocfusQeBy7NbBpEtLp6KMQ=;
 b=e5bgKzsOHnOnlCoKRZlypMT/5SPWP+pYxKIi8DJCC1Wp5w72EKBX1mDB2j96Q/G0cdiFq3DSzVQSdXNqmkQU8mJ7g34BSZvHmc29Jov9EG5A6M+kF4wTwAPplO+3wr/NmSocUmexodIfaBumGIna1TK09UxGi/Q3rAWCiE1Tl84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6295.eurprd08.prod.outlook.com (2603:10a6:20b:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:00:15 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:00:15 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Tue, 17 Oct 2023 13:00:09 +0200
Subject: [PATCH v5 3/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v5-3-ff6b5c4db693@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697540413; l=5477;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=wCiL2h9+IZtOVcDxQziwk7mw/m8sSJBkQv4/SlZOqeA=;
 b=QTfUM/tIasSQRn3+wFhKeLxyHv33ZDj/X5O0uZ0RPzJHQ1fuIsMSn+mdDmgLKuqd9t34LbFuc
 1bxzt7kjuBqBB4yxiaxYNxcHVZKybVu7hz3+Y6NTK1XPPgAAmXAW96V
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa2f15b-edee-41c9-f086-08dbcf003e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8atFWAx7aL9omG4yQpnOQ0Tn8Qk2/UFiVzPzhMQemkb8MA5fmGUyUmMP3pVV/EoISiAzetmh+Cem9t1wts1S1yD2w4+e4D0epjSxLPjDi9f2pJMZc99iAR3BeGRScAtiEEEgo+2LjTzgFTVuRT5G25nJKBv0Qao9gQoWcohF529AZeU90qGy+LcROvML17qzzitkekvTWnZgU3B+XM0TYqWyjw+dmxl+b/E5Uvpbxs3+1uawBi/8JOVmHKvu1URgbyfI1hhztFn9C9/TFD1SA7lYIacMl70TDSHI4cmNxnlugYzWu32CFvni2hP4uyMnpBUS0aXSytR4jH1kzMSYmSwRxiQFvB/MfMKfPd27hyKifzbovojlgeQUE7j/sXHUvYzBA4X1pnsCAN+tvvXTQ1g25NlmLcEEN8kCA/TmCxtJINduUKci7m9G3vIel0nOKjYtVmjgidPW9eSk8iiP7jvV2fEjWlljJThqD8ptvZBYnRM97d+3WyZQr2amBHw9SPZyMiEU7un+S/kIF+TEW7clucCKIAqQbId6sSO/qjUuEAmguQgvSiQFIB4EyVslttBtpkP6PvSIaFrlPCOI+cdxm/GNkzoerP2OaIXrxU9zg8JmJUL920NILPOM274
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(478600001)(38100700002)(52116002)(6506007)(2616005)(6486002)(38350700005)(83380400001)(26005)(6512007)(6666004)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66946007)(86362001)(110136005)(2906002)(66556008)(66476007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cklHTTFFczkxcmJ1TUpqTUFKMGJ5a2JOcktNL2lCSGNYZ1RnMXVJdDRHWkY1?=
 =?utf-8?B?VVI1NmxBU25veTBkUVJOeVY1bldraFJaRDNwdzFQTmloWFRmaktLWkQ3UitD?=
 =?utf-8?B?ZWlhYXBzY1RiTTVnNFkyQU5XU2NkUm1XLzhRRlJyd09QcHpLek1rTVY2QVI0?=
 =?utf-8?B?clczVWhVbHNlT0hrckdaa3NjcmRvWXFUS3BHbTFmcU5wa2RTN2JLTEVuRTRW?=
 =?utf-8?B?WXJQRGVxb2RJQ2tsU0x6S1ZwQjVqOURIU1F4UUVsQ0g2bVROUm1nME0wV3ZB?=
 =?utf-8?B?cFMxbFBLN1Z4UTk0bC9qTktiS1dlcWtHU3NBRmxOTkFxVmg0Wm1MbGxKMFNY?=
 =?utf-8?B?dStiSWt3Z29ldFNYbXdtbGZYWVhvZkFxRGFDNjlNd0JmZUxWYUgzRmYwekVj?=
 =?utf-8?B?TnUrUDE2K2hoZy9rNS9rNTM3MXRNbkl4THIzTStDRmZDZ2xxYS95TVBKRXgv?=
 =?utf-8?B?a3dXMkcrb2NreStrbW90S1lxUnZJbE53aTNQV1ZLd29hWHIxanRuTXBBajhP?=
 =?utf-8?B?WHhoZDFGQ1Z4U1dNZjVIOVBCcmV3TVAzZ3BvblhmUVRHR3V6cDY2SnNxSjNa?=
 =?utf-8?B?ZEtMRnpjZnRKU1phblhoK1NhaDNaTW1HeVBGOWJ1QVBzTGRnVG1UTWVldFFV?=
 =?utf-8?B?Yks2eEFOWmF1cnMxOEFMNis5TVpHZFVPbTdrYTFrM2xyRVRBZHVNbmpzcXlE?=
 =?utf-8?B?S3pGM0haci95MGtTWUR4enZvcDJ2WkJSY3QvMHM2ZERHdDNUbzk5QkxOdENs?=
 =?utf-8?B?bTh2RW8rV296QmhkRGZRSmdLSDZwSU5GVW5GcmZpNThGL2RoeTkraGk4alpw?=
 =?utf-8?B?L1psMHZyTjFqSlM1QkJ6WTUzSXI1ZUpVWVFxZm1SNUlxbHpZQkYwdzRyVjlv?=
 =?utf-8?B?d2F3REtRTG4xK2FqbGxDT2Z4Q3BNUjJVQWlFUjBKVXBqb1Y2eFpDbkFpdXFQ?=
 =?utf-8?B?TXBWVURlNVVUOHhyQWNJWURWeEJWZXgyR3lWWERWSGFPMlZvN3AvODhaTmJR?=
 =?utf-8?B?cGhQSFNlYTUvTHd4UmZ4SHJiaTdMK3dNNzkrTi83RjNEQ2JxSzU0dktrdHlp?=
 =?utf-8?B?UkFRNjVpNkxZQWFITkRLenZuTVR2cnA2Q2hpaDEvT3lSVm1jeU01WXFBYXA1?=
 =?utf-8?B?MlQ0QkRjazNzWHp1aWFQYmQ4VEI5OXJzSC93cWRUdm5EWDVBZzNmbFFWK1l1?=
 =?utf-8?B?RnI0eEUwejVPZE0yeXRIT2xUZEh1NXIzNFN2emFMbGNHcGZPeER3bWFneFBK?=
 =?utf-8?B?NTZ1b0EzS1pheG92ZVpqN3B1TnNrT29sQlpJMVJKN0hpQnhiMnFmU0RuWFpW?=
 =?utf-8?B?TG55TWlQWFovajlQMDFubWdSY3FyNjdZUE02bnM3TGJNdTFKUFUvVGUyYkVW?=
 =?utf-8?B?U3ZVU25tMXJERjBhakdOVkxocjYvb2NIOFFHbnpwTE1QRjFMMHFVMzlreVlN?=
 =?utf-8?B?cVpkQTJZUkIrZjNHQjNPc2hRTnRpaXRyV2I3UGE3OXNaWXRKbnp0UnRBelNB?=
 =?utf-8?B?dTVVV2JpdmVoSHNsdUZ3Vi9IVTczcS9mS3plMEV5NnBkU0RQSmJXb3MxalJQ?=
 =?utf-8?B?QnVOU3pRNFlubEFTYVc3UXc5TFFkUGR2aDZmNDBXaVJNTXpsZTd6dlR3WUdu?=
 =?utf-8?B?VmFaNXFxWVZtei9mWUJwSWY0R2NGOXdpNFFNcnFNREYxeU1kMUZaUWdQcThl?=
 =?utf-8?B?cTcxRDFIc3JvdElINTAwNzRZQ1JsbXRwQmlDOU14UU9DL2JIN1RaQnZKTDJV?=
 =?utf-8?B?cE1QNlRVOHF2NXF1R1RLRmQvZjJadDRoNWZSMXliQm1rRyswNWgvYk5mdlg2?=
 =?utf-8?B?TjEyQm56L2MrZTZPSVNVeXV0WnpXaFZwMXJZamQwdkFkR1I4cGNVU0d2d3dV?=
 =?utf-8?B?bjJFWEFKN0dIZlo3b1FZKy9pTDhxNVZvMENka2ZoTUxyQnpkNkcrS2UwTTZx?=
 =?utf-8?B?eTVHb0tURmY5cU5Pd3V2S05kdnc5M3pRQ3dsZ2RhRVdUTnM3WFBqNklGcnJX?=
 =?utf-8?B?VzRKbnpDa1BUS1FzV3REbzVqMWhXNGc1emVHQjNLU0NLYXFhblNmKzhmWHVU?=
 =?utf-8?B?L1lIK1pGbUg4ZVVNaUxmS1NoeE5RdVNKYlZyaTdIQk9tR3E1OXlXMG5QaWtL?=
 =?utf-8?B?R3B5WjZIL2hjaXhNQ2RBdFo3bWk1M2xoTk1nRDJwaXZucUxyejVjNmUwTE1k?=
 =?utf-8?Q?tJk1Leb3XpzSvwBlyZoceic=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2f15b-edee-41c9-f086-08dbcf003e4e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:00:15.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWnJrAU2XDy6dLSd9ghe2Ark6b8AiesspZtSxl/2ZzcE3VtnlNMUtUpDm2bGiP0m9rbpI6k6vZfd3GblfOeNJrVGnQZdfvudDj7OxLkTwlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use touch-overlay to support overlay objects such as buttons and resized
frames defined in the device tree.

If an overlay-touchscreen is provided, ignore touch events outside of
the area defined by its properties. Otherwise, transform the event
coordinates to the overlay-touchscreen x and y-axis if required.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 70 ++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..d22f7d57f468 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/touch-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -56,6 +57,8 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct input_dev *overlay_keypad;
+	struct touch_overlay_map *overlay_map;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -130,6 +133,7 @@ static int st1232_ts_read_resolution(struct st1232_ts_data *ts, u16 *max_x,
 static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 {
 	struct input_dev *input = ts->input_dev;
+	struct input_dev *keypad = ts->overlay_keypad;
 	struct input_mt_pos pos[ST_TS_MAX_FINGERS];
 	u8 z[ST_TS_MAX_FINGERS];
 	int slots[ST_TS_MAX_FINGERS];
@@ -138,14 +142,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 
 	for (i = 0; i < ts->chip_info->max_fingers; i++) {
 		u8 *buf = &ts->read_buf[i * 4];
+		bool contact = buf[0] & BIT(7);
+		unsigned int x, y;
 
-		if (buf[0] & BIT(7)) {
-			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
-			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
-
-			touchscreen_set_mt_pos(&pos[n_contacts],
-					       &ts->prop, x, y);
+		if (contact) {
+			x = ((buf[0] & 0x70) << 4) | buf[1];
+			y = ((buf[0] & 0x07) << 8) | buf[2];
+		}
+		if (touch_overlay_process_event(ts->overlay_map, keypad,
+						contact ? &x : NULL,
+						contact ? &y : NULL, i))
+			continue;
 
+		if (contact) {
+			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)
 				z[n_contacts] = ts->read_buf[i + 6];
@@ -226,6 +236,7 @@ static int st1232_ts_probe(struct i2c_client *client)
 	const struct st_chip_info *match;
 	struct st1232_ts_data *ts;
 	struct input_dev *input_dev;
+	struct input_dev *overlay_keypad;
 	u16 max_x, max_y;
 	int error;
 
@@ -263,8 +274,13 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (!input_dev)
 		return -ENOMEM;
 
+	overlay_keypad = devm_input_allocate_device(&client->dev);
+	if (!overlay_keypad)
+		return -ENOMEM;
+
 	ts->client = client;
 	ts->input_dev = input_dev;
+	ts->overlay_keypad = overlay_keypad;
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
 						 GPIOD_OUT_HIGH);
@@ -286,24 +302,37 @@ static int st1232_ts_probe(struct i2c_client *client)
 
 	input_dev->name = "st1232-touchscreen";
 	input_dev->id.bustype = BUS_I2C;
+	overlay_keypad->name = "st1232-keypad";
+	overlay_keypad->id.bustype = BUS_I2C;
 
 	/* Wait until device is ready */
 	error = st1232_ts_wait_ready(ts);
 	if (error)
 		return error;
 
-	/* Read resolution from the chip */
-	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to read resolution: %d\n", error);
-		return error;
-	}
-
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);
 
+	/* map overlay objects if defined in the device tree */
+	ts->overlay_map = touch_overlay_map_overlay(ts->overlay_keypad);
+	if (IS_ERR(ts->overlay_map))
+		return PTR_ERR(ts->overlay_map);
+
+	if (touch_overlay_mapped_touchscreen(ts->overlay_map)) {
+		/* Read resolution from the overlay touchscreen if defined */
+		touch_overlay_get_touchscreen_abs(ts->overlay_map,
+						  &max_x, &max_y);
+	} else {
+		/* Read resolution from the chip */
+		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to read resolution: %d\n", error);
+			return error;
+		}
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
@@ -335,6 +364,19 @@ static int st1232_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	/* Register keypad input device if overlay buttons were defined */
+	if (touch_overlay_mapped_buttons(ts->overlay_map)) {
+		error = input_register_device(ts->overlay_keypad);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to register %s input device\n",
+				overlay_keypad->name);
+			return error;
+		}
+	} else {
+		input_free_device(ts->overlay_keypad);
+	}
+
 	i2c_set_clientdata(client, ts);
 
 	return 0;

-- 
2.39.2

