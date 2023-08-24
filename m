Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C778701B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbjHXNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbjHXNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:17:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80691B0;
        Thu, 24 Aug 2023 06:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqRRfbKOeerPOyD0VOYcZYAJo61tWPYrqyJGtY7O+XANjdGsbAuqU0U+TfJc5/4v5cv7H+/12ze4OZHN2DSy0dsN0rLxbE7Ch/WQHLJVVvH8Lh1JmcmmVtMna4YNmF4uUqrSoNbnolEicBDUlNqSICJAM2e/XJyPaPDx1eyxcH5ZoO/vwlc4aVHm+tGrs8gpBzqg8QZUVkY8SWjJ9mv9FmU8Enb/aH4mmoih2Hg/qtTGv6Q3iEXxjFrEh06TpOYmVDk+HdPlgCRA1aPbj54FCVCrmFIbi0Dh9DZF0918Mc8Ft+hgqQL6bLYgVFBIM2YgqIppR/YriGnpGEwLlCe8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s+e6xOeLPB29hou1wYdBocfusQeBy7NbBpEtLp6KMQ=;
 b=WjRdTHfwaIlIF4OMRo/kbKXkkX1PiAap1FdkmBlexXc9Yf/K4CLVIaeXRBACgbPEhIHYVT3fI13y5tMrm1KolQvFu7h77ajAapcSvq6uB1j+83mw0kgmdCcLWbe8m+P6XbyXPSWRz2tdUZ+/bSH0FYWjc0WXRGQNrLCzjVpiOXowKDRcHqHYT/DufGf+BEvIEwtlefhks8LmGOzG1um9YVMjuK+RE1lphF7BjINSdJjZ1q82H8mdSgwQRgay8OS+oNDap8NxHanuTmMx+sVewEV3LbhH1Hj25p7nfLXceAA8jbmBxmcC/oUuOM808AqCBjb85GcGSPYmqFfngwXhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s+e6xOeLPB29hou1wYdBocfusQeBy7NbBpEtLp6KMQ=;
 b=SYnKLykSaLZ4BXAU83IwiuxvP0sKGyilSiAk8H51Fm1ob2NdHG9pTVnFJyFvo825RLInc6+C3U9AApuwkZJkBY4A6ITJaq2N1irGmzVdCs5KDidGcyKglxPDRVP4X720vf04j2tluxmTXThwE/zVjr5zQF3o/vgt64D8Qt12F0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 13:17:46 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:17:46 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 24 Aug 2023 15:17:11 +0200
Subject: [PATCH v4 3/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v4-3-5c6c0fc1eed6@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692883063; l=5477;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=wCiL2h9+IZtOVcDxQziwk7mw/m8sSJBkQv4/SlZOqeA=;
 b=0aOfbqGOID55D2nKAGaVEbrDuMotGy/iif1NwUDFWaqqnWatCMyUAOt6UPNerHI7gdYb3lAl1
 0ajP6u+cIqhCFc78JDet3JdLtw6LxkU18+m81uTC1nAq25ZviGigxY0
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bae396-59e7-483f-45cc-08dba4a481f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzxzANlSCC/Y3qlm5V8TfmINqlkWfqyXoI5P6t7I+8uHtytO/UHrUmYbJi4E/Fzolr6/vzQ7uOVxQHnSioevCTrdN9TDF2mmsHOZHhxGmpXC4SB1JyUwQ4xdnMhnGeoEMM01rKJaKykJRtRe1nzIz2d9G7bkUdEg/JDskml3F7cv0dK9UCwHQvOOgQiuGGbdu1I7ifn8/9aclGdUJuC3qobSd6AkVyIZ0Sq8mj7FUoLVBq7rKaDXWH7SdlqRYKp77qCFpS2lHB4zgsR4VYjEJ4NzgJx0RRuH7Gm+1JVoiyaY9x5/7q7kxaKJzwiEhbbfChP35sgEc/piVfS/EDH0jbs9Q0l0A/rQx+goCSts4GCgJY1WQAnjabAWD2/3HUZqEchpycnH61YyvK8QO+D4DMjUjo6H7cPgBgSxXqjDwcpmviL7WygcrwRK2or0V2vJkMnU8rmMhpQxN7aqrgqOJNWZXnG/82EAyFifO34LqosRh4g9p/+evlxX74pAbkjlcxF1fkLvK/StYbD60uHXEMtCQkWCOhQsrxYsLPWXcMfAoDp7WGWScm0PKo7DPY2hcn1A9WRkNrIuL85KSZ6taBEJV0ye9Hk2Qr4UFXM9+k2XXDajvGH6bt5yjKhSiDSu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(38350700002)(52116002)(6506007)(6486002)(5660300002)(83380400001)(44832011)(26005)(86362001)(38100700002)(8676002)(107886003)(8936002)(4326008)(2616005)(66946007)(6512007)(66556008)(316002)(66476007)(110136005)(6636002)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzN2aytmQzQzL2ZFeVJud1J3cXg0d0xXYVlraG9ocXhheXpCMHVabFRVZHdJ?=
 =?utf-8?B?RnhocFI2cWdDQlRMZ3k3VStMbzYxZW1ZZXVmYzJraDBmQTYvbWx5MUMrYXVv?=
 =?utf-8?B?VzhRUHM3S3NFZ0YvVHhzdG5vekdSYkcwc0VvdVd1RWNaL0NMajZZazBBdjBZ?=
 =?utf-8?B?MXh5TEt2NjhXdWRtMERrckhGVUhXUTl6bDhrQzlNclpkUlMzbGo2U1VxTHkw?=
 =?utf-8?B?WWFZTEtZU0ZGWWNCdFVuUFpkODMxTnA3NXZoLzNFL0I4Q1RiWHF3TmZycG8z?=
 =?utf-8?B?eE8zK25qQmxpWUZWOVRxOWkrWVk0dzltZk02dk5BemVJVjAxVDFYcFI2eHFR?=
 =?utf-8?B?Yktaa2pZOFBiWEFXampXRHM5eGRFSkFQdEF0dTlZQlVDR1VTNXRjekFvUmd0?=
 =?utf-8?B?RTJaMHZVdk5WdERZYVVnbUtqKyt2MzE0NTFyVFVzQzZmdENha0NoSFo3eWNO?=
 =?utf-8?B?LzFoUU8rNzhhdjNqNVpxcVlVMTFZNkViQ1c3OEdMalM0TW1mdVNkN2VLdXBp?=
 =?utf-8?B?MytpLzBjNFd5UERkMGlQNCsrSUlPc0M0Y0p6Tm4xWE5tNXVNRFhabVlnMVRm?=
 =?utf-8?B?WnU2RlpzNVdxZ1JsZCthVW5WMW1HNWUyZ2RjYWx3UHpqREIrSGxCQ1RvbkpQ?=
 =?utf-8?B?VkgxRVJUZmMzRDcvcWR1SnU2QlZ1ZkhhZnZCWHB6Q3BPWjYwdjZkV0tUdFZr?=
 =?utf-8?B?MjFCc1RsOTJPdTYrN0h0UUFXaFlrdWxwWlVrdDJuQ1VJZ2dLbVczb3J1VXFP?=
 =?utf-8?B?elhOQ3VlRVlKQUp2WlBZcnc5dlFKTmFocTE5QUV6aUYwcTJsd0ZQVUcwZCtn?=
 =?utf-8?B?cmpqOW5vZkpGTU8rS2Q5UzUvSVVUN1MrY1ZJbWtRd0ZRQyt5Z0Q4UFVVVTdo?=
 =?utf-8?B?RXpuOGlsQUlnaUJQN1dQblE0NGxCTWdpTHAxd01xcVhxaWJIdUR2ZDZmeFJx?=
 =?utf-8?B?dXk4ZFVyODU3RHFVd21kSDV4aHo4VDUwU1hVTXpKVDRMakJUbkx3a3ozN0NZ?=
 =?utf-8?B?MHVwVmNReFRaV2MxSUt1SWQ0TTFnMmtEQWo1M20rY1FuR1dTQy9EUGE0bkNu?=
 =?utf-8?B?U0hUVkwrYkd0T002Q1hpUEF2T0hzYjYxRFpJNTYwYldDeXBtekoxY1NzU1JV?=
 =?utf-8?B?KzY5bzhneFpvUFJUbGtoTVlkakxkYmpZN2hQQitLL3NwK1RoWG1ORCtqN04z?=
 =?utf-8?B?Rm1kTDJMT1ViZGFUVU82czFoUndEL2Y5YUs0enl2TGUrU1ZISGN3UXZKLzdP?=
 =?utf-8?B?a1ZrTlhZckhoeElLQ1A1dWlTR3NzSG5mSWtzNUxUeUJKL09BdHFIZ2ViT1Vz?=
 =?utf-8?B?Yjg4alFJWnRqMnpqQjVWU0N3UU14ZGZWNVZTWWFpOHg2RS9sTE1OSXg3RVp3?=
 =?utf-8?B?WWdNWG9lc3laUTFiU3pQdDJQSzEvSzNuYmlZRFd0RVRRb0VheXRrV1AyTUpV?=
 =?utf-8?B?Vzk0a0V4SWYxZGhXazVDUmlmMHRvNnNsQ2pxd3RJbnp2OWJCOW1LNnExeHgz?=
 =?utf-8?B?MmlJWm1lZk8yMjRnQjVSNlVybG1qSExWN25tMWVucU1reEw5LzJnYnFHUnZX?=
 =?utf-8?B?S3RiTFBFK1dFcmpEdndiY1VETUdLMWpYdHB6bXg4M1R4T0dhMTF5Umt6dVA1?=
 =?utf-8?B?cWh3SDdBZkVoYVJzeGxmRDc0TCtaUUREQUlHdlJSbDJyZVBOQ0dtNVFseTYz?=
 =?utf-8?B?MG1jWE85M094ZFNOK2JpMkpld0puYVZnditPMm9QL01JOUNFVGRyTmZmVFZj?=
 =?utf-8?B?YVFPamJ1T1lpZ3pkSXJFbi8wY3A1RlhDbVpBOVhlMG5FS1dJdnlGZUJzT2Zm?=
 =?utf-8?B?ZTkvcm9tL01QalJsU0JTWXVzZDJPSm1vWC9YaFZvTk9saEtOL1hod3gvMHlB?=
 =?utf-8?B?ekdTVm1vY0lzbzQrUTlSdG4zTW1ZTTJvWSthZmRHRm5iemtTOXU4VlRpKyto?=
 =?utf-8?B?dnJkL3RPUlNsVml2NUdnQUVqTTR1M3FGTG8yVFdYK0loOStLdkdGam1IZFdq?=
 =?utf-8?B?OWdCcGxOQThpRXJVMVhSbUhkakFha1VZZUErd3d0KzAwUnlwMXUwQk9SeW50?=
 =?utf-8?B?ZXlCT0dNMHkxOEVYa0NMcjhwK2Rab1BoZFB1bUU3cjVUT3MwOUk1OWs2eTNB?=
 =?utf-8?B?NGhwemhrU3lpNzFqbElJamliVURheElJQ2hibEdtSnhIUStmazBCSGJpKy9p?=
 =?utf-8?Q?/aQdl7oH2Yo5QthrJ+T0sIY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bae396-59e7-483f-45cc-08dba4a481f1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:17:46.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/0pud9y/jNMjk6SW5LH6UFVlM2YK9Vd42JJJVFUZNkkiNU3uhvmDzaGGEdu9DMpfqqk97gYTtp6xuHrEFT26TrGi3G3WXMYs1WeF0wz5Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
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

