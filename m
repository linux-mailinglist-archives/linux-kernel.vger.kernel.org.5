Return-Path: <linux-kernel+bounces-111305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB48886A75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D873B26CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF953EA98;
	Fri, 22 Mar 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="tHpe1s9y"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2181.outbound.protection.outlook.com [40.92.62.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338583D3A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103642; cv=fail; b=VWgmt8ypELwvLoNHB4kCsuZITeLKut+be7uUkWKxpa0hrXcltQTaTSvx9Y5qsO3fGSSlwaope0y6+m7UA1jxeXVxabs3EtUMlESgzeevX1fKQ/e6q842ieRjwx0spAi5IMmaMjQlBqCRCJjrnN9muLVfevnT0R54cJsu8Rf03So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103642; c=relaxed/simple;
	bh=q2CSOORofJAO2oPdxbMV8QGH9tynPBLZaTq9JpjMcko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+Ao2pLyoPXYEtcmN6E8+sWfwi0d9TYU8fH8GO8EFeRz/309giOeK86XGHjbhT4+Iy+2oTqdY+LZOnrzHyXlU3YRxjTa18h4qNLZJb5+eKTFc54RyVb35AV3oyUFVwHOM62EPX70aGZiE14KbsnftC3VBa+KoxQ7pQZBm37y2vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=tHpe1s9y; arc=fail smtp.client-ip=40.92.62.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5/s891G6W8OyNJlnMcR4izCIGZffCgBwIOUqHmk+ZICcKyOt8Jnf6MYabKat+HgA1T5/+75sFlVd+7oB91Qf7+5fbsXRWk18cqshZsiFwk2w4nPCvI3RZzc8ERsKBkLtanjDpdGX9Gsw9P+JLxLA17leqgV/2dohgatDR9W3+c3/R5R/wrG0J1sprJmSyd8qTi7dKPPQbJvKU1/EQn6q3KgNPwK0NL/B3UE8OpvysVVKTMHQfzvCbtggTJyPPI8T5O2QuEdjvut2KpZwXn45dmz7OyPfXssIpYoRDHweY+uBS2gG5JKrc/M1tF1GjR2ty7gklM3jIs64yfLuTD0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fuo327e0tLMjSKRCCf6sFQ/r/yyShcRDGK5T10NabhY=;
 b=QfC4jMMpeMrA9G2oeNh1Njt2ggh72RyLGVH2DT4L1WALxLkteSFhVrL7RhDu3dbQE/j0sogm6jRKqz1dAtihf9F7XIcJRIRqACWRqArsDSOs+egTvrw5Vm2TzQnSj19fr9mrtdiRS99jTn3KpVx61+vIQu2Byg66oJ9Jhk2VwwDYvIOn4bGzRzxaiXPYH38/cgsVnIoBeLNidoiD0WcNIPX54sfqu1fW2m/D43O2F4oC0aWCsusI1gw5SAs5HHxSq+p/4b9PBhyutxL5UiPvUFxwRkh+A8hvCkeQg3dP65tjUHQg6mowCxl30yJayqkv9v901wM2+BuiJ7DocVzd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuo327e0tLMjSKRCCf6sFQ/r/yyShcRDGK5T10NabhY=;
 b=tHpe1s9yI/pP69oqiYL33OE+640b/TQuj1LJtrlliM9JY5j2ZtjH7ut4IlXnReAwIA0MhW75/w85ieVIUoMqyPj3BifkrfRRJBYedZH01jFz/VUdOhyFPU20gwwvP1ZL9Tw10OlIb0aTKlSJJAS+vJcbFYk0ZXPNp+WhtzMI7XjskBo8e5HqqjncXcivQl1rrF7p/AIXCBRh09A4Pmv9Zy4i1JUJfpDuEkSoRWmrxjACNp/+mcPl4G1kcQ2blhzKMYziTVhPoCog0ZE9nG+1nR2eZDEmU6rYdyUeXhbbAjYTDlpZ/W9+aqmtJ9Pl0HcYGcqLjUzuv0G7tUukibncXA==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY8P282MB5238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Fri, 22 Mar 2024 10:33:53 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:33:53 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH 2/2] platform/chrome: cros_kbd_led_backlight: Remove obsolete commands (EC_CMD_PWM_*_KEYBOARD_BACKLIGHT)
Date: Fri, 22 Mar 2024 20:27:59 +1000
Message-ID:
 <SY4P282MB3063D447DA09D35F5FBD4721C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322102800.1322022-1-s.horvath@outlook.com.au>
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [xcla9VZ8m/6GwZ6d+Io/C7rkYK4AIWt7E30yCe0/PdTm+3jaINrD1YQS69ohbGN5KfXFar0MPJw=]
X-ClientProxiedBy: SYCPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:e::21) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <20240322102800.1322022-3-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY8P282MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a207680-89e6-4600-a1a8-08dc4a5b9240
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wBETH778bwXOyPdlBl/m4Nk1EdI9ZtBYhfKVX6V29SvsTa0kLgMpelDRNMcNTRxGWcoirnnKdv7B3TMiCBwQnNOOEv583h5s8LjvRMiOXbXpOgk9raQEzDaPD6aLRDsQBj35dbYlOkTVCNbwhmW9XILfFm7RKbRVdZcQQzB5Q/yrfozNtPYxGlqbRwF0t/R9+yyorUymuKq+0BvjytgIQ1S/RklB2K2Di0Nm6MLqiLojj6+CLtkHPFWKLLV7HmRsDG4f9T/jpo0wCVZhBOYkuarS5eCOebsAqY+fC+BDpFM7cLMDFiW32uZFMZiXNE60kStrvKZx5nBHktVB6fnAcreuUzq9ya8H1OA4zygfi8fYxZOBiaHjJf29emPlrh4OTeEZSRBPUmVSa9cO+kyTTMbENrj41548qB5bHOhSJXopzrVpy9BHMwFhxoPvoko8N2sMgRG6YhHZbqg4w4GwUnQTGWme0+JDwrP7YSyLuIWgFNV6Po4suNplSDzmBJjkPgNF0pbux+A5TBJyhIZUARebEnp3SkMyogQFvqZesJw76I/3pBFuLR2w5WvqbglCOxTPgCpgeM/OGng/L1E235vgknvtrit1E0/o0BUJJui2LYHzEtGOoF5Cfur2hN0c
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQyqeuQBxI4utWl9jwteQQfnT/zA81/T5GUaBLrVOqaT9W94FiH37ur5OTag?=
 =?us-ascii?Q?aAmky2+XsL9Mhb7fG/p3OKOV2tzCKkPH14Cv+MuDMCdLoLZtNAgZ1pAwaw8t?=
 =?us-ascii?Q?mrBqLp4iOB++hA8vddxDDq63Pc3eUXD7MWtXNYl6fYmdL7Q+48yhh76VLlek?=
 =?us-ascii?Q?/a7ZAlXFzMgcK8r9YVfpxXdFOS0kXF63oSd5bxECjedthormO5uunMDmXVzY?=
 =?us-ascii?Q?xlpXBFO3sO1cg3hLalStAe6GzoHo9hj3kb3Yq4OlimpRAzIZSLlq6zbT3uxo?=
 =?us-ascii?Q?2GGhmbY92uH1ZpLEcgCKUm9N0WTn4eQbdUulA4zUmt1dG+PM2bbhzE+w7a7N?=
 =?us-ascii?Q?Z9EvACim3U89esEKTg/aGwhFunIOKwGbPcC4M3LyXvMQ5MDf0TDpov2LBw5c?=
 =?us-ascii?Q?x3dcbtWILPDyXP/3DJQvs8OLpIqxrpHCNOXO/4ckUdbpW07NuXKQnbxNjyYc?=
 =?us-ascii?Q?ayFPq2m+eta6Wr+S8dEUlOICIouk5AwYiXN0qBVabNc7q8NKugDfGqjtKk9A?=
 =?us-ascii?Q?zjOTq+BuDqVGCEbWf3mTRwcZBG1kwsmheI5EtUDzV/DZLGBcwFrNvISnwS+l?=
 =?us-ascii?Q?75Gkr3BOIqCvaunwPm/TQYvBQ5HZtdUlrkynxOCUPU9KjC+2IhKWDiiyJhu3?=
 =?us-ascii?Q?tXK+74Skj9Z//fH63hPfRqI/iouUypJ8WTv7e7WAYEOCSd93TuGW0T1gpesQ?=
 =?us-ascii?Q?M3oGZHYzMfv0uU3UfwptQMEzXZpfMq38pyHYsO3uhlrXG2MQvZ7TkZjAvPpq?=
 =?us-ascii?Q?cv5A80q/v8ZYSpFC2jJzSwSN0T/Q87iINhSbcIPZWxQwPs4cNyMAAn7aCCS+?=
 =?us-ascii?Q?4Xj7+mnvMOwcX7tOuV4iYYb5EHz3U35cRQiW2qOBqQm7qqrlHghILCeZInyE?=
 =?us-ascii?Q?yH+bY7At1JsXDfd08evDfjsnhFqRiRuvoxYux6OEx+i+i34wBgc2zoQZfn4S?=
 =?us-ascii?Q?GRPqOfiApTkjRpz2s6eM32hctd9tAY8m9qScH+b+MM+3XtgXIMa1T6Nvww14?=
 =?us-ascii?Q?NVL2/iy3Gjui7d+LXOF59ecu+VvPc3aHdroG3hW8ISnRiyFsJbMbiLZJmB9p?=
 =?us-ascii?Q?LZe4gIZG0UphdQfW/y2lKK4GdsLCFxWXJ5UufyZLzG9hKAWXAY5+8PMkgfXa?=
 =?us-ascii?Q?fkCA/YjYvdDJYYVuTxPGbYrcLIw2Mb+UP9QwbUngD19drRvRJ1oGcZZAm9rA?=
 =?us-ascii?Q?ff2RqlrIVP38WxmCyJmEhWtX6LK84dH0eyL5SMnH3ItJ8RA/Rlnkk1D4OIQk?=
 =?us-ascii?Q?Ltw4bo8ANfYtiheRiD76dhBz4OzEXkXFaKg4cSB4nlZyol1nPq/p6E12KE7/?=
 =?us-ascii?Q?TLuXW7YTv1GviYs+MxYmAyRg?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a207680-89e6-4600-a1a8-08dc4a5b9240
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 10:33:53.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5238

EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT and EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT
are marked as obsolete in `cros_ec_commands.h`, this patch removes the
usage of these commands from the driver.

The max brightness value is now set to `EC_PWM_MAX_DUTY` (65535) when
running on the EC, as this is the maximum value that the EC can accept.

Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 .../platform/chrome/cros_kbd_led_backlight.c  | 37 +++++++++++++------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 06e9a57536af..bc021437e8b1 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -47,10 +47,10 @@ struct keyboard_led_drvdata {
 	enum led_brightness max_brightness;
 };
 
-#define KEYBOARD_BACKLIGHT_MAX 100
-
 #ifdef CONFIG_ACPI
 
+#define ACPI_KEYBOARD_BACKLIGHT_MAX 100
+
 /* Keyboard LED ACPI Device must be defined in firmware */
 #define ACPI_KEYBOARD_BACKLIGHT_DEVICE	"\\_SB.KBLT"
 #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
@@ -114,7 +114,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 	.init = keyboard_led_init_acpi,
 	.brightness_set = keyboard_led_set_brightness_acpi,
 	.brightness_get = keyboard_led_get_brightness_acpi,
-	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
+	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
 };
 
 #endif /* CONFIG_ACPI */
@@ -127,18 +127,22 @@ keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
 {
 	struct {
 		struct cros_ec_command msg;
-		struct ec_params_pwm_set_keyboard_backlight params;
+		struct ec_params_pwm_set_duty params;
 	} __packed buf;
-	struct ec_params_pwm_set_keyboard_backlight *params = &buf.params;
+	struct ec_params_pwm_set_duty *params = &buf.params;
 	struct cros_ec_command *msg = &buf.msg;
 	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
 
 	memset(&buf, 0, sizeof(buf));
 
-	msg->command = EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT;
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_SET_DUTY;
+	msg->insize = 0;
 	msg->outsize = sizeof(*params);
 
-	params->percent = brightness;
+	params->duty = brightness;
+	params->pwm_type = EC_PWM_TYPE_KB_LIGHT;
+	params->index = 0;
 
 	return cros_ec_cmd_xfer_status(keyboard_led->ec, msg);
 }
@@ -148,23 +152,32 @@ keyboard_led_get_brightness_ec_pwm(struct led_classdev *cdev)
 {
 	struct {
 		struct cros_ec_command msg;
-		struct ec_response_pwm_get_keyboard_backlight resp;
+		union {
+			struct ec_params_pwm_get_duty params;
+			struct ec_response_pwm_get_duty resp;
+		};
 	} __packed buf;
-	struct ec_response_pwm_get_keyboard_backlight *resp = &buf.resp;
+	struct ec_params_pwm_get_duty *params = &buf.params;
+	struct ec_response_pwm_get_duty *resp = &buf.resp;
 	struct cros_ec_command *msg = &buf.msg;
 	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
 	int ret;
 
 	memset(&buf, 0, sizeof(buf));
 
-	msg->command = EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT;
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_GET_DUTY;
 	msg->insize = sizeof(*resp);
+	msg->outsize = sizeof(*params);
+
+	params->pwm_type = EC_PWM_TYPE_KB_LIGHT;
+	params->index = 0;
 
 	ret = cros_ec_cmd_xfer_status(keyboard_led->ec, msg);
 	if (ret < 0)
 		return ret;
 
-	return resp->percent;
+	return resp->duty;
 }
 
 static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
@@ -186,7 +199,7 @@ static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_
 	.init = keyboard_led_init_ec_pwm,
 	.brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
 	.brightness_get = keyboard_led_get_brightness_ec_pwm,
-	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
+	.max_brightness = EC_PWM_MAX_DUTY,
 };
 
 #else /* IS_ENABLED(CONFIG_CROS_EC) */
-- 
2.43.0


