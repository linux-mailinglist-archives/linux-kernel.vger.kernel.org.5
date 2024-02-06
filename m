Return-Path: <linux-kernel+bounces-55068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C484B733
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD7128BEA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D115132C00;
	Tue,  6 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="VGSxA7OA"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DD13175D;
	Tue,  6 Feb 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227985; cv=fail; b=nonmc8M8yInX6ZdfbgN2H9uBPib1Qm2q1x0vgtI/s1akIx0YUVE5qR+PFC0nWrNi6hKB3pTqDiSd3ExQjQamYVXyoMDO6hIZXixfFR7W9QJ8etk6Z+nbX8wC6Z6/vQgRhvH8VCUm3hjVHjaXdobMMBX0fuT7w0D+cQs85hKLRS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227985; c=relaxed/simple;
	bh=//IWvhnvRLsD40ZlZnt7iPa6Xvwcl74nuaLFNgT8VKY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WbRajoCk1oYtpqkOrhblpSB43XrYQksHM+9g/BdfMsBFNDv+lRFcGNO8xIzFIa7r8XI7wElNBTAhYS9+Qy/52hxDcS6DH5EFjAVf3znLa4npeGx9xESfGO2Ch8Ex/Tjceprkg/ZNpmFl3EEY6jGuEPiL+aYVZIVx2o8Jz3KPJZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=VGSxA7OA; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwWzwlV1GwXZMkKOZv3QBXhMJEij6o8h6ljMMyvbBUnwn/1SHxXuWFdb4YZ91w/Mk6gEhh6Upd4HgmIZCF4zYzkVTGw+ABBEpidVW2zFzx0ureYh3nksTWIKwtepWpKdl1WPL+oyip16vn6XeNI/HSP0a2Xvdm53uvtncAAy69ARl0qW/W3v/csd2wwgsw5Li3SSadvrJcFri/0mja4VQGRxvH3vMdjEcf4VDvxlri/P1eBuiW6sp98UvH3Mx+nspzC1b3sCANHrFG/L1sgZyj3MwE0sb25Xr4/p02eLcsYVMVcQkHt6q3sGY1jIH/HwPDKJYXahrIVA6RXbsjKtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ka7/MVJSsQ1kJLQd0zwl2qxrFUUya5rfUU/dPJo2TA=;
 b=Huw24RW9OI+Yl9R/Rit3mwHWcryMtsHGdJWZ05tqr4oDF0tY9Zosf2gM2qcvHnSE/cRQ7eX5EAcO3rserVAcgOjBzXUdUbFxH+l30jsvwjg+WMKiwqHleZBltdX1w1qZRdENdjibg4tzbttpeFDgU2fDJcEzIFv+zJ2qSln8y6LUZ0Uh7FwNKci7u9c56tTxoY38772AeVKEFxb7GWZpFiA0oyw9s5KoVYZY/vKU/0QrmUyVPc5oKY9OI5f2AVZPff00nMytLlWuzoFHV/J/mXgCtpOKG4PDy7DJFdBHWFd75ZGrWHQ18HgyuCRn610MBm3Sk8Wp4hjGEA6NtGsWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ka7/MVJSsQ1kJLQd0zwl2qxrFUUya5rfUU/dPJo2TA=;
 b=VGSxA7OAfWBlLQEZuACY2IKDrO7+fpBdwQxX/1fcOdEim3qYoM1Xxj174A0EHaowQH+PNJCB4L02kFzVEU7ezuU5HAaagFuD3WVmTgxkAnKelClyjf/yz979AJYMs/TTMHFN6rz532RWmVW1WvLDjqLDllOecokVbJ2NcjYpa8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:37 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:37 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:30 +0100
Subject: [PATCH v3 2/7] usb: misc: onboard_dev: add support for non-hub
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-2-f85b04116688@wolfvision.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
In-Reply-To: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=2626;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=//IWvhnvRLsD40ZlZnt7iPa6Xvwcl74nuaLFNgT8VKY=;
 b=K49+SLff0x/mB5EwftlUC7nixFMrUfWjx7pprRRmlk/m/+4DFmqsBbGQ9tsmcEDvMpfJ9ZJZ4
 df17Or5aTCADcx31CEAH38yW21sECTZQjetqv4s0W5ueC6hkBfqsppZ
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 99caceb5-12c7-4bef-5d62-08dc271bdb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e2azl6uzqH0jmTQgXlNRNY9I+wJxzPc1xjuG9U8rWqgTOfGVD8+HI2/ZwNBwYmF9P1oC9bMZyh7/AJNwma4MJjxcj3lhDllgJG0dmWezDc2+/rYf5TJOm8LoZffnQrR38Ko3Y/2GWNrzZ8bWvCM9WJRFyO3m4VTSZ0y1Rp50XHVAu7n3etB+U6iMO1/a3nqClRoch+CV93nDc/LQmX7FBcfIjcs5dtRaxSZEnwVwPdX/2Dcz2JzccgxGtggaHKXEiWQBL8yf0MCN+lGE6TI+Jl+AE0dB3W38J5wcA2Om8vXvNICq84H8cn7pkaz9DiUskEREF7PRV91j3hMEwF5EsOJB1Z2UKroPuQFQxnUV2IJM4wDUvIt1WXzIsxwXZGQUW+15LMDMPCgXhZdquHiVqe44AKrlqUnr1i1RO5WU9+UbCrZhuvWe9a5mDjG85fuPVdgJerkRV5q55B+VQQiAVkHpEqZHF4jOfTqnXeGnktvfZFIYKgY5WjW9hN/7Yy/3zh7pwiwzqDhPxEthdm3+jODnFWUl1ZuQnVMkoGpi11S5lXX0+gv3u+lT2sR9whWW4S23ZV9pD7fKWXezRhUqk2DU3UyR8Yz+9O06AaUglB6z4bm0RT/edSuMyzj3ZgFv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ROa0F6Z0xvMDRKdWVPdlYzbTJKTlBQRmFwOVZGMmJrQloyOFRDSFB5dVk2?=
 =?utf-8?B?d3VVQ25PQitmRGZkMXhOWjZob0hORXBubWE5dDIrNDdtQmRpMzdLUXVmUGlS?=
 =?utf-8?B?LzRWems3SjVFZWwxU1dVZTFLcGRQeWk0ZVgxMjR5SGltQzArY3FCUUovNk1i?=
 =?utf-8?B?RXFYSVdiRlEzR2pVemcvVkZVcUZIMlVzdzVlQVBhb1JEVy9pOHFHWUlmZDN2?=
 =?utf-8?B?L0w0dzlDVkJQSFFFWFJCTm5ScEg5Sm5SS29oY0dIa29zbnJhdGdXeXpRZW1G?=
 =?utf-8?B?K0gyNW16eFpwaDI2UktJekg1T0RMdi9tb3BHVElWd0ZBSyswb043bEt1bEta?=
 =?utf-8?B?NnlTdWFuU2pISkxEV2k0aVhOQzVhTUJiREorK1NGTndZM1NiQm1NTlFHUFhl?=
 =?utf-8?B?dGFWejhyeWFjUkJLQXltdUQzb01xRDVxQkMwSXBQendBalV6ayt4TFUxZXE2?=
 =?utf-8?B?U1k0aFhTQ0Y0WTYvckhsRm16QlpHWnI0aFphT0tMOGpQUzJOR0hGV1YwamtR?=
 =?utf-8?B?S1RRU2RkS1laWWN0Rld3T0czTXpOY29qSXh3QkFySUpYUFpHdGFRS3FvcnFI?=
 =?utf-8?B?UTA0ODRXSFBRTlZUUGcwZVpCbEVDd1UxZVNZenZZQ0lPNC9SMEw5Mm1nUmFK?=
 =?utf-8?B?d3JmcWJZSSt6aHE3UlVyNnpYWkwvTnFoV3lzbWE2VE5ac3BCWXpKSUwzTFRR?=
 =?utf-8?B?WnNYNGNaWEpQeFRRRjJlekF4a01tYVVSWU5hM1FYSTIyWURMU0dvc0s4RjRm?=
 =?utf-8?B?ekpMcjByMzRIRlFwNUM0MUdNSHhsVTBFWlRreDVXWGt4NExqc2RNQkhWT1Q2?=
 =?utf-8?B?TVFmUTErYTdqYTBCTVJCemE3VzZKSEJjTlYwdGd0VXJJUnloYnc1WEFFcEY1?=
 =?utf-8?B?MW44WWJYVU1ld0FEdU1abDI5b2xwbDlpcVZLdFk1M2pQS2cxWHh4eDhyZVF2?=
 =?utf-8?B?T08za3hxc1U1am80ZVJYREk2RWtvMzRkYkZZc2krZlAxcFRLSmJNRENMU3Va?=
 =?utf-8?B?Z1BuSTkydHdDdS8zaXZON204ZmUvL0VjcmZ4SzQ4VlRQakoxNFJFeEExRmdI?=
 =?utf-8?B?aWE3SHNBM05Ic2JnTmhhdG9KK3BTUTRISXVjMWNCSXpNMXQ4SmE2T0VSc3RU?=
 =?utf-8?B?L1Ruamx2RTVKTTZoV0xEMzBRNXgyeGMrNjlYSzZCSTh1S2RPSXA1L1BDMHdy?=
 =?utf-8?B?cU9UTndQRk0wclZtK1hBVGh5U01kMlNoa1JnajJ3Z292RHVERmt0NXZpQmRK?=
 =?utf-8?B?NE5YMEdSU2VXd3lxd0tWSzAxK1UyUjNaRE9lR1hSUFovREdNN1A4V1NRYWhP?=
 =?utf-8?B?QUxCQkJCQUVMeEpZMks1NGhiaTk0RGY1MWkrWXloZE0zdmExRXJtdnozVTJo?=
 =?utf-8?B?bEYyRjZFbVBGQWQ2K1NZMFBmSHZQYVk5ZnZYTTlnUXNzN3p3cHNZM250QnlH?=
 =?utf-8?B?WXdOTXdERG1iRlorNnZtS0pscm02eWY5ek9PK0ZvTytXRzdMN2t1RkxROHpk?=
 =?utf-8?B?Rk1ka2lkVStoelFjcU4veHZUdDJTS1ZFUTJFV3lXUEtzZTZDTkZ5c2Jod3JZ?=
 =?utf-8?B?TnhsaGRBaFR2VzBGQk0wbWhUTjMwUnBrZkRlVEU2VThnNDRxS1BHQkIvdVh2?=
 =?utf-8?B?R0RUbjlCWEExamRJcjg5UkpmS2ErUXlBT0MwcDRlczlLUndHZDFIMzVpb0Qz?=
 =?utf-8?B?dmVDLzNBUHFpeWoxS1FPTW5UTFViMVpnaGdLR3lPU2xIM2NlNGMveFBlaVhD?=
 =?utf-8?B?WTFZM1RIV0xvZ3lYN0NOVXkzUVVZZDRwV3VvUjMzaFFYOEQzTHpiU25DZDRD?=
 =?utf-8?B?OTBGVlhybnZreDNiUVdVb2pVMVg5Tlh1eUQzZUZqaVcwV2NEU3hveHUxMWdC?=
 =?utf-8?B?OVBNdUJIK2NTTmlxZTY4VG1vNjI3QkpzRXBaN3ZMOE1PWmtGeW12eTFKMFVq?=
 =?utf-8?B?UVBVNEIwZE1XYVZvNW5WQlVFK1dSZ3RXYWxFemhQUVBiZGw4NU0vbHRoTjVJ?=
 =?utf-8?B?UzdMaHRpb1VBWWdLQzg2YzBZSk8weHhTVlJoRlErdWY2b0VINm9qZGozRFJa?=
 =?utf-8?B?T214NzRhek82RWp5WnlJTEp4d01HTVRSV3cyVlVEQ2FYa3F5OEVZVDQwam9n?=
 =?utf-8?B?Q2hEVHpLU2V2blBtdDNtQTg2NTZ2T2JwMFpHWkZnMGFlUUZ3V0JDWk5pYWVL?=
 =?utf-8?Q?aK5yCoNEnS950yFvUi07AfM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 99caceb5-12c7-4bef-5d62-08dc271bdb3b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:37.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quT0Qiaa5WCD02Q6kxBnY5rhZ+cstGuAMivvKgiTeErJ7P7v3G4ckM8MZI9NaRK11r65YNBInZ6oeklEaUHo1wgco+CYgGo9ygaWMo+/f8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

Most of the functionality this driver provides can be used by non-hub
devices as well.

To account for the hub-specific code, add a flag to the device data
structure and check its value for hub-specific code.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/misc/onboard_usb_dev.c |  3 +++
 drivers/usb/misc/onboard_usb_dev.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index e2e1e1e30c1e..3ac21ec38ac0 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -123,6 +123,9 @@ static int __maybe_unused onboard_dev_suspend(struct device *dev)
 	if (onboard_dev->always_powered_in_suspend)
 		return 0;
 
+	if (!onboard_dev->pdata->is_hub)
+		return onboard_dev_power_off(onboard_dev);
+
 	mutex_lock(&onboard_dev->lock);
 
 	list_for_each_entry(node, &onboard_dev->udev_list, list) {
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index f13d11a84371..ebe83e19d818 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -9,51 +9,61 @@
 struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
 	unsigned int num_supplies;	/* number of supplies */
+	bool is_hub;
 };
 
 static const struct onboard_dev_pdata microchip_usb424_data = {
 	.reset_us = 1,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata microchip_usb5744_data = {
 	.reset_us = 0,
 	.num_supplies = 2,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata realtek_rts5411_data = {
 	.reset_us = 0,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata cypress_hx3_data = {
 	.reset_us = 10000,
 	.num_supplies = 2,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata cypress_hx2vl_data = {
 	.reset_us = 1,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata genesys_gl852g_data = {
 	.reset_us = 50,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct onboard_dev_pdata vialab_vl817_data = {
 	.reset_us = 10,
 	.num_supplies = 1,
+	.is_hub = true,
 };
 
 static const struct of_device_id onboard_dev_match[] = {

-- 
2.40.1


