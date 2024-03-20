Return-Path: <linux-kernel+bounces-108587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEA880CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0274283CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691B41C73;
	Wed, 20 Mar 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="fEIBGJRr"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2091.outbound.protection.outlook.com [40.107.6.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2F23DE;
	Wed, 20 Mar 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921510; cv=fail; b=XSqi0VoPRuLMsvJoJzJYlUuHRyf3Mnp8wwICrw8OQW8IC8MVwWTquMBwTzUM6Oo8JFIPpBtPSIO1Q5y9T7xXTuJlgwELUxH3tJty682j8wJNpeqlTit9W6vGTVqwz2W/jlRSRa7FIrEKSlf2bz6xcv4fvwA0je3vOrBq7+kkJBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921510; c=relaxed/simple;
	bh=CRZ0sSYsoUecSbz+oUC0fLIT0nSbJZhwa7o6rQIIR/k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=olAvEino1GsAfClrujWvQBnxpwqtOkKyi2pel2Nzs6dVGjgQeZxcPYJubDOmApOS4HdBxneNJdhQTUdZ5hzGQF0UPoGf1Hx7Y/lTmko4gZokzG/Aa/faxwXB+QU7YHSe1mPFzqoQuuC4QiKFP6MZC9jb2oTwHZfu4oagsbjSmAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=fEIBGJRr; arc=fail smtp.client-ip=40.107.6.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T63C+xc7h2jEdRvepaDLnqY7qgnsy361GAFnWL0KjaUfZD2+RMr6Jz1M2VdFmAZfSnw2RFCM9vFLS5YLd1E4YZnoVbxnNbm3eBv23j2/CVuk/+cZRyTsIaHZs4evMFog4Eq0zoOna0ppJpp6uvxo7PM23lOQ2LErI+CHbNsaW/MXXFGXNgQMSDCLVjyf9rCr8XYFMoxfWlCeuiq5ksp19QIbXIU+kz1opu9FVE6/1P7ULju8M/q7TutBh0n4QtKXhmCnMEBpU4l+vLW3ZRRFD5blgWJ5EXQ2J4BpHZBuplbEYVqhVgHO4DwjoFx6BLiAQC6sjyb4oxki2+VQdbZY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+IO+awHoDqlqKjGNEtdGlN859aV5MdUs044vwjEIJE=;
 b=Ln9s9hUDuo2FZXJDEvLPlTLWi3qa/aPIdPJmU9nee7cLwzCEuWtInUPcM5bVNkQ+Mj5GKd+jYGABgP2ZjoSEYZ2frhMAgANkIi/PKVul4y7zicrukf0L1GLEsWuUnPyz5FkM7S4ouOD7iDfQe0dy6dGLilvGSoishXEEQVh+reBzYE1218XfvUUp2DvaOD8u4iMeCV5V7t2OKPEBooATPLKaAh4MIyS1P+I72eaWwdreVAS6VDiCd6LBK7XmyfExRodtVOeVWVQ2blPD7ihytZqfGxTBS9avHZj2iPLh1LZP4jgwwHf5v6wAnNCOPuVBw+AtG/kIqSgbVTeCmbKGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+IO+awHoDqlqKjGNEtdGlN859aV5MdUs044vwjEIJE=;
 b=fEIBGJRrPkaQIwwStjeW877PT8p6Ui0qn+SoO6nRPyVUth1xZ6a3L0FuQ5/HQvtOcMtcCRTgGL1itGPad1y6jxi77o9gvwRnuv8sXiDPI/kDf8qE8rbiavWsNHD5h4CMk5kLuU6qVxXV4Y77uGJDND9mIRcGrsCgjMK1t64Ly5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB8703.eurprd08.prod.outlook.com (2603:10a6:150:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 07:58:19 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:58:17 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Mar 2024 08:58:09 +0100
Subject: [PATCH v8 4/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-feature-ts_virtobj_patch-v8-4-cab6e7dcb1f6@wolfvision.net>
References: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
In-Reply-To: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710921491; l=3456;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=CRZ0sSYsoUecSbz+oUC0fLIT0nSbJZhwa7o6rQIIR/k=;
 b=WRwmy6ZSnciUyXQAk16pOUHYUsKKRQiOTj1pJZayRYy1A+TOWjjC4mDmLBm3URVwrTV56ViXh
 DlJotJOQr/8BvgmlyF520IuWWcadGXiMDei/RTa6dtc2Gfc7l0Tfgy4
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a985c7-a1ee-4db0-d4e9-08dc48b37dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Me/mEcxh1J1YgyIU7TJ/LFQq9G6xSMcpHaGT3/WJm30FwbxhGG03b9J6oFMuxDt2MkXriDZoWEooVaOEekdpx/SmSj/fDcIvKx+7fTZ5YyzEElJ2maQ3Z6Lj2IsnwKSCA81F86WJ5SvatWd4cuTewrV7u56goMleB5e3vp8whphjlUVJQGIO4vH5PN73SDf7ASt1yIRVBD6dqrlOZYJBwSoy7N8gidv0lsjg53kPnKjtleS/q1r/OPqPis2JP6M02kwyTSAqbryYsrXVXjAs98ZA8bH0js26UhfD/QD85V1Xeyi6IghmJvzEx2Q7F8zL73/IiV/Om84xpNl3pC87JWaMFIe7904797GJY+mMhr8cPfJ0NuVgpHNR8GVr1aEmFwgGyKTVl0vpN9tEK9r9ZtdcDHnBlfCJI41ksh+YJFnJzBvKheaGUnoFB12DW9xBLhA28Z5VD/7w0y4EloIHf+PVhjYDSXxr+HCDZj2qqhY70JGQaXQAqVrhg7DCqx3lpN3wRDGDEkCLksc+qKV+OE8E8SnNt1ogEmdA8fKuehJoKEyW1LPwe3Mm3Iq4AtS84AvJiRaM4Jf+PXWtqr3Qtv0v6hOAzUxLdxuXGQ59s9ZbZss2PfT9Unm8AAxgNfES54a8XsLtXqHtiejj/UylhwKDSZhC1N0vp9LxuHt4/7PP/gIiuU/Jd49zoPRowYFZAzKZuEzo6WmRAugJ9zMtVesOX/0NED0cqlgb2in6NW4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnVGMkE2eUtzVnJOZ1dWSEltN3MwQzhCYk96ekIzSHV2WGtQSzFqVHUrMUZY?=
 =?utf-8?B?aEFQOHROeGZOczllSFl3RWtNZW5kckhoaDc1WjFMTUdLV3Zra1ZlS2M2SDlz?=
 =?utf-8?B?SldLeVBKbUd3NG1wQVlIcmhhWXR6SzVCSVhRUkNSVzJHb1hTNTFYRkord25a?=
 =?utf-8?B?SDkwNjBidHRydWIrWVdteDlUQnIraUlFT2lLMUxyNmlPSHVKTWZFT0FhYUNG?=
 =?utf-8?B?VFhsMFpRYm9kMHdUVDZoVlJiOG1XNkRzYS9IMS9YU3pHSVc1MTNHUE1DMWZB?=
 =?utf-8?B?VmY2bjcyUGFpMUtTMEhoejNhOUZTTFYvQTJYb3dVSWVvVjg1Z3lDYU9LWUo0?=
 =?utf-8?B?U1N6RGlsTkRmZEhCU2t2ejM5aHE4emlhangxUnJvZ2pIWERlREIxREdZTUpB?=
 =?utf-8?B?bEZBaitxR0QreThyTHdDd1lwZ2Q4c09GTVoyM0plMm1sam81bldHZ2J0ajFR?=
 =?utf-8?B?YW9LTEJwWGJPU0UraEFvYUtqQ0JXYW9NVXhCRFo4THlIRms4aHNLczZGSDF4?=
 =?utf-8?B?bjFZQTRNbUFkS094eU4ySGU1ZEdHd0F4K3lsa0ZhMDNBSDd0MEx6cUVaYWNJ?=
 =?utf-8?B?OVhTWlJ0MmkyY0l0dFJBV1hYMCtlcDQwVlVqcTZzMTBBQjRNbWdKWWdvemE0?=
 =?utf-8?B?VkZFVUs0a3czYitLSWlQSHg1eEFWSlNiNS8waFc1Q3BNMnJmckJaRXFtcnYr?=
 =?utf-8?B?WjhTdWhUcDFKOU9KNmtUZmNnK3JlZWN4WnM2eGd4ZGgxZ2lzaEZFNE1OKy9S?=
 =?utf-8?B?em85V2Z2VWhwZ1d0dGRsVlZPY0prc2JNVUVpQmtEN1E0bHJXdmhqelJ3K3lZ?=
 =?utf-8?B?UFl3TzlPOHg5L05Tb09QQkRNZFZDbjRCc1REcnNvS3RKYXF6Y1pxVGxCSnFT?=
 =?utf-8?B?Vm9TZm9xbWY1Y2pQTEdGWjVTTy9oK00wbWtpaVorS2xYalVrYmRucEhFdXcw?=
 =?utf-8?B?aFpDVlRoMVJ0bVpYNVRaby9JdmpZTTZyWTZRZVhJeTNwMXJWRmZIcjI0VnUx?=
 =?utf-8?B?emxGenVsRHlsdUk1TUJ4ZkJIMnpIVnd4M3huaGZ0NkszazRxUWRJVjVqbzZv?=
 =?utf-8?B?cnV2MlNscFF2WmQwVERHd0N0NnZsZmtOVktkWWt2MGJwcW1saFNvaGE2SkZV?=
 =?utf-8?B?bHphREFybS82VGVWc01GVlpHMVpKa0hpYVFVM0JlQ25DOHVzN0dtbkFYRUhk?=
 =?utf-8?B?VEN6bFJ6NXJXZGRteWZyM1lJcmFJQXBFTW8wYzdVeFR6RTRjclZuTTYrYVFt?=
 =?utf-8?B?d3pocGpXeVBMbGtoOUxDT3BMUGNOaHFWVG8wbmk2aFRtOWh6eHdobmROWFR6?=
 =?utf-8?B?dWlZajVDUHNRQUlYUmFMU1BVQlBDQUNacElJQStiWnJSalBxTXppYmZ2cWt3?=
 =?utf-8?B?SmpSTVhKdFVvRWhkWTBubUdocWlPOU5kYWhvT1F2c0w4WDFNUEJ0Z01aUlFL?=
 =?utf-8?B?LzdKSkxyMy9qbjB6RXdXSDNIaVZZcTRnaVU2VGhVS0ZTcnYzZFJYeU9rYzI1?=
 =?utf-8?B?eU5IMnNrcjJCUi9SRzdYU0lFMXVURm0zSXBWTzBWMmdQWTNjeGp3Sktnakcz?=
 =?utf-8?B?a1Q0bVhMNGsxbXFwbThrNFg3YUxWRHFkMzArdlVFRVBWT0xlbW5qREhnaVhK?=
 =?utf-8?B?QWJ1RnJEdGJHUjc5eE4rNUVLT2JZVDF1N2c2SXNiTGFTcExuVWhzU0RQRU9t?=
 =?utf-8?B?TndVdUJyVmIvdjlrRnJhOWEzRmRsOUpOYm1pRVhsc2pEaE04WUpHcFNGSzNp?=
 =?utf-8?B?SVFRRi9TakFOcVN0eDByYVIvU1JtSWNTTGhodlVjZStwWFNlVkVmZHkyUmxx?=
 =?utf-8?B?ZTA1NHZ3NGhNYzRnYTJhQ2FIUnJycXdMeEFxeHRPWG5YUXdFWTVyNHZUMFRW?=
 =?utf-8?B?NVYzZW5ra1V6bTlsVXBtNFhxWlV1R1BEZW8zcVZTdWRoam9MOFd6U3NkNGFI?=
 =?utf-8?B?TlA2WCthTFB6L1hmcjZ2dkhqd01UcWZ1dlpIQjlCUTdJTjdQQmRrNXQxdDFC?=
 =?utf-8?B?YVExcjZlbjNORlRrK2hBZ0cyRXNXdWZrRXV5UXlYSlVSdDR2VGYyVnJoMnV5?=
 =?utf-8?B?RXd5ZWFlYy8wN3YzT1BvRkNiR1cxRmFtSEhCbGlHazdGNUgxYUVkN1Y3Z0FU?=
 =?utf-8?B?K2k1NGQzdVBFL2hPKzBYWnNBR1dNTnVTditSeWtkRnNxVml0TWFPcDNpRHFI?=
 =?utf-8?Q?FRhXNGEtnT/eyJNwleIjOmU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a985c7-a1ee-4db0-d4e9-08dc48b37dd2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:58:12.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZZtvVfZwDgo2goRUpCLxFeX4IWGJDzy7Fmw3bBP0yyb3cbeGQV2fdfmpG3IBz0ZYe2rJxDmQVVVEfZFHEmN1UiQqyzZ8aeLaI1GsM6ehHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8703

Use touch-overlay to support overlay objects such as buttons and a resized
frame defined in the device tree.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..4fa31447dbc1 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/touch-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -57,6 +58,7 @@ struct st1232_ts_data {
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
 	const struct st_chip_info *chip_info;
+	struct list_head touch_overlay_list;
 	int read_buf_len;
 	u8 *read_buf;
 };
@@ -138,14 +140,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 
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
+		if (touch_overlay_process_event(&ts->touch_overlay_list, input,
+						contact ? &x : NULL,
+						contact ? &y : NULL, i))
+			continue;
 
+		if (contact) {
+			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)
 				z[n_contacts] = ts->read_buf[i + 6];
@@ -292,18 +300,30 @@ static int st1232_ts_probe(struct i2c_client *client)
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
+	INIT_LIST_HEAD(&ts->touch_overlay_list);
+	error = touch_overlay_map(&ts->touch_overlay_list, input_dev);
+	if (error)
+		return error;
+
+	if (touch_overlay_mapped_touchscreen(&ts->touch_overlay_list)) {
+		/* Read resolution from the overlay touchscreen if defined */
+		touch_overlay_get_touchscreen_abs(&ts->touch_overlay_list,
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

-- 
2.40.1


