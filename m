Return-Path: <linux-kernel+bounces-44605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1E38424ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984021F260F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530BE6A330;
	Tue, 30 Jan 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Oy6Y69yu"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB26A34F;
	Tue, 30 Jan 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617632; cv=fail; b=focjufY3D8w5hpQdDw6xISKvrPcp84ouEwQYOqf/9cY5Y/aegXWfmUsvEvZcyPgbQOmF3fNEmUlGq58bIisxBP6rqYsUMKkjYibsHnDfD4ci72+BVo/McSPyrEkxqJ2VU+mmGAU6fUiOh4ix8N8xiw6mveFrAw2W108oLn90gPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617632; c=relaxed/simple;
	bh=V7NsmgNnWJFlF/itQ9Ex8RWjiqi0iPRtBiqkbxjiYig=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TOQkfI7NKh1NN+6HvH65JT3jrOKtaVXwNJ3G7f9C4fAbq2bon1sCwx4x2JafwSPv96VBEnqLJaRgVpQk2AWH2SFZ9zWw4bZvz9uIOWTPTH2Rj4GdwGmhrawoXayfoSiQm/fZ5mJ2Q7XFgciCIwWxFz1fEfth2p3y7lgwye/HhII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Oy6Y69yu; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMT1ckDfPdp6fsbd34dE/rM50lgqJK6QQ5QooZTYfaO5FPivxoU1HyCxqblwaMTZ0GOg9v+HJmgPsuIgmETiz6kTDEdFgJ1T6TGdb5RyIEryNqlgBCi6+zhe7LkEoJHzDyDti92rI/SnoBthn1jbqVNdUDuQHBfTSdSXCWbIHOko1slX8b7UAcTBz6iY+96nHNJNopQNJcm2/tslsTM2ml93KtJfIEzOrURCyjAa4rtecOzfIyZy6eTJZ4rH14cfvR0l/LWxRf5FK+4GWSbQxY8YjNHFsQ3QGH5fEUlv8ghuFjzRI0ksdI3XZo+3LO+t0mSBtPx9V2wLVl9cITzrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxa4RP8RQluOUry7+pBnwhCmr9F9NYfO0oJ5ANkCN40=;
 b=bRFj78qy/9ZSelMVEVXVbqx9dJ3HKnx1ujwVRB/TVzhbMljpoVbX1OtraF4fWUqi26al1IsoOQ4QqAeSWSj19qW1jnbTnm9cwqphEn7CuTDDJse1hGvE+BAijiabHAYBqV8p3ehyIoUbKr/dxYRqlJzK6+QhV7r99V46OtPgb1xwfZE8cKfLryYnOFBHh1Q0sJnCbB35xAV/fEko/sVzekIhnbcvigCMNcmiIPkw/bC7DLdtZwgwGuAWojJsRyfIr1WteRwYAkmqOXDyvaxQlApwvmO8Nzl4wQw16/HRny1pJPNqEhuvxDNQmpgDrcMu4QWACyV0pc/Ld++EauE9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxa4RP8RQluOUry7+pBnwhCmr9F9NYfO0oJ5ANkCN40=;
 b=Oy6Y69yuKmefOfpGxiWTr/4V49PfTSJFa5I7gAbVWbGodLo5Z7Ia1JvYFOe8c78yK8sCEEPDXUoaDN648ExFFefiV2gXytwy9g0cnPskN+510t1vLcKxOxt7FzJPWADnkZFtRS/jp75W0bagaPYwRo/E5JfB4OA8jO+W1p90gE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9954.eurprd08.prod.outlook.com (2603:10a6:20b:638::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:27:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:27:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 30 Jan 2024 13:26:57 +0100
Subject: [PATCH 2/2] usb: misc: onboard_hub: add support for XMOS XVF3500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-onboard_xvf3500-v1-2-51b5398406cb@wolfvision.net>
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
In-Reply-To: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706617622; l=2715;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=V7NsmgNnWJFlF/itQ9Ex8RWjiqi0iPRtBiqkbxjiYig=;
 b=MCS3mXR0vHTv4dzlSeBa4msa32KzBT9J4dBEVwp+qtrx+xg9v12V0SBWTNUKEyJowaMEQ1746
 bOMbD5QlMqGAa0WIn1ezAF56C7avM+OVHbrCzIgOQ9UEfxJn0b/mOqm
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: a0290ae5-b9d8-4e6c-0ee6-08dc218ec493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1MwoWPveET13T8DqLg2XRca2fvip9QDZ2u+qATwI+C8jbzcoYTrfTx/rLmpUpeY3J2LvjzSLToEUi+dvflInPsbQlKYKQha9rVJMd5yuJsMqxx4IjG7VBMn8njcAZ751FsP9+m7WkuuhK3rvF2kcQ7G9mz7EwkB+UQstvLRLVAofTYGiRmAyrf84DBDS2o4XvyZa5rQ8p7rfigSYr9Y98ERFcF3AL39CuY3WMKPd7cel4twupiDfVAr3nTUOYGXZANpR9NxNLGR/85mfyNACiBvKYsX4CeDhCoHllrwnCUk8zoNe0hl+Ckxmpm/c0De5gvu+nqr77eulr6dT0/iHTh1TO7pFxlH0BziFAuZ1RjC1NvuRPmZHEdFo3NhFM8GU/8K6jwxHAgaNq4e/QSlOVRbRVpYbXwXe9us0KT/bmjv3q41PodztxQxUdfXFIlv1wnEvTMqiWpLqr+1i5NI/wDT1lFL3hyhquondkMzLr9chwJ+7EZa8Yl5q1JxISkP7zJg1HDYRgvYAs567cb1AVNNHl3O2ifMQtBYUATr7vgPjR/wZd23vLyMDsgb7MuNKd1z0PBiYp+0FWTi64h1B02Z+YoIWYsKcCzw4SvKTnOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(7416002)(38100700002)(5660300002)(2906002)(41300700001)(44832011)(38350700005)(36756003)(316002)(86362001)(6486002)(478600001)(966005)(107886003)(6512007)(6506007)(2616005)(6666004)(4326008)(8676002)(8936002)(66556008)(66946007)(110136005)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGhsbUs5SHZhRnBhZG9WU2ZwMFV2QUVoakVZOHczTGo2OHgvcHVyTTBRSFla?=
 =?utf-8?B?UFM4cEhKK1B0TVNTRU5kVnFkTXd1UTlYZkcveUNLL3JBVERWaXVGQjhORTdt?=
 =?utf-8?B?K01jbTlQR0hhMWlNdTlFdUNocU5QaVBVYmNaeWV1cGF0aVRWNlRKd2RDRkVM?=
 =?utf-8?B?U00zRllPbTZMcklXUDFSd3JST005RUp2ZDZUQWlQUk1JdlpscG5LSWV2WWQy?=
 =?utf-8?B?NFM5NFhFSUZzY3czZVk3YTE5dW1sZGZUcUVDdWJKZWhQOVVCdk9QNzdxOXFw?=
 =?utf-8?B?RXV3UGlHazZHRlY3bHl1ZDR1R1JCYi9YaUxSRHNBdm9BQm5lbGhmdlRBMFpS?=
 =?utf-8?B?eU8wMlFONzVCa1FjM1JaYmNnZytreFNRRW5Cd0FBZ0MwaWpCelIybnBzUUZi?=
 =?utf-8?B?b1QwQ2VETlIrcGlmWWVodVdMUkFXS1Y5K3pCOFJGLzQxZVRWMHZEMlp2czhI?=
 =?utf-8?B?NkluYkwvazNkYVFZVUNsdUlEUVpsanN4bnpuQUdQMDlUVTZjTTBFQkZNdkRH?=
 =?utf-8?B?Z1dzKzNTeXg2RWE5cGxXc1lzY2RYNFd2aUx2eEhrRXh1RFFzNmhRaVd2cVU4?=
 =?utf-8?B?Q0kyT29XNmhyMGI2REhwQTl2ZitocWpwNFhBK1V1dHFBZzEwTGw1T3RtTFVh?=
 =?utf-8?B?eE4vY3lQOFROS3pod2Z6RG01STdhTGdqU3RmNUFjK25hdVdRbERrelZ2Y3VQ?=
 =?utf-8?B?S0V2ZVZ4TlY2MEhqQ2piUkQ2cmRqazk0eHg0UldWNnZwNkt4ZXArMFpsNGMv?=
 =?utf-8?B?UjJoWDZDQ2VFRGZKdTNhWjZjM1JOQkE5Y3J0Kzd0SGdSa1JNTXVvUzBQT0di?=
 =?utf-8?B?aExKdVEydmY5alpYcWY5U3d2TXR5QjZ6VE5NTFJDakwrbUtsZDJXbVAwcnlo?=
 =?utf-8?B?RmJramdQOEZmeGJFR28xSk1ON1cxWmF1dkovSEZkaTNRRTFKUzl3clVpOWg2?=
 =?utf-8?B?VExHNDFKcnBTdTh6N2gxdXp2Z2ozVlB3K3JlRmxyNG5Pblp4WVppR2ttN0xm?=
 =?utf-8?B?UVZyRHBON0Fzc1VWL1Q4a2ZlR1Q3bXJ1WFlEMDRsKzhFMVFMMkxwdCtkeERN?=
 =?utf-8?B?NTIyVVppUzlGcDJVOXgyUE5DSGpackNybDdYOVNFZXBDcU0reEJSaVM0Mmty?=
 =?utf-8?B?aHp0c205RXYraE42a0JVbWYrY2lwNEFrVEx5OGN3VTJrLzFWVkpGdWxTaGpW?=
 =?utf-8?B?cGthNEdUZzFRMktmSDlUNHp1amlFOSt6Y2NNa1RneEVhMStlNk00bkNYV1hi?=
 =?utf-8?B?RWNmemsreWh4bzY4NDNPbDExQkpNZUpScjFBNzNYZytaMy9pWUtkT3VtREE5?=
 =?utf-8?B?THk3dU8vMnZCc05YdTdGcytiRzg2MEpXTnlwNm5zODFVUmRjck42QUVuTlh4?=
 =?utf-8?B?TkhxbFpVUE5VT3p2QnU1TTY1dlg1VDZlbFhpVlFMMzR4WS9FL1d0UzFESWN3?=
 =?utf-8?B?MmpHbEpuQTVQaXNkdUZpYXQxOUM5K1c3em1Uako1UmdQamdKS3RETjQ5S1Za?=
 =?utf-8?B?dkh0Z25JK3NPSlNmUjgycjNJNVlhUWdmTC9VRU40QnZiN3owNDI2SE5TSXJs?=
 =?utf-8?B?L2ROZ3IrQzh4eXV5WmVjd3RYZlhlV0RwMWR5Rkl2NmVnQ01qS1V2QVBpdXBU?=
 =?utf-8?B?RVVIY1lseEYrTEF5YTdhZEZIbHNrVVExLytuVFNJdnArTkdRN1ZhRjNRN2lt?=
 =?utf-8?B?dVZZM2ZRMWhhTkM4czVOaTdyeWsrQUtTQjhHZUUyQkdaelZOWjc2MEJIN05s?=
 =?utf-8?B?S28wYXV4cVQyTXRBOGZtcVNCTmdIQWMwZDV0MFRPc25RUEhuYVY2R3YzZitO?=
 =?utf-8?B?OVlnTXZ6ZTJMdjhqOC8zOW9aT1hhUC9zM2Iwa1hKb3VBSVI3NVdxOWVrd3Iv?=
 =?utf-8?B?aXpJN1JjWi80MnlEcTRPVGczWUFUQXZwMnpxZ3dEOFMrT1dhZEZ4Q1JiZUNi?=
 =?utf-8?B?QzBXcTBRL2M3R1hGVGlxQUg5WXFZcEpUQmtnWlhkNnpYVTNkQnFPOUVOdWNQ?=
 =?utf-8?B?eXlieUNWcUJUdG9CM2RJQmhJandBcWJjZDJqTlZYNTlIbEVzMDAvQVZydG5o?=
 =?utf-8?B?UGpSbk5QYUZEbGJQRXo2NDF1cnA1cEhvMWhLM3Zqa0p1VEpVQlM4TFBWNUFW?=
 =?utf-8?B?Unk3UEt2WHNDYytyTVVlejVob2I3OGw3TFpmdENDL002cXEvTzI5Mm8xV1g3?=
 =?utf-8?Q?XvNslgmn0yM5EjCEF2CugFw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a0290ae5-b9d8-4e6c-0ee6-08dc218ec493
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:27:04.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6dgNtrHRG5UHzD80o68YfWS8LSFwUinnI0UjLmgafSkkqwlLxhqL/olavEso25z3GRTkCZFvEMSqsW26/sGQ7RM4qyEGx3c+pZsJJBjpwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9954

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

This device requires a specific power sequence, which consists of
enabling the regulators that control the 3V3 and 1V0 device supplies,
and a reset de-assertion after a delay of at least 100ns. Such power
sequence is already supported by the onboard_hub driver, and it can be
reused for non-hub USB devices as well.

Once in normal operation, the XVF3500 registers itself as a USB device,
and it does not require any device-specific operations in the driver.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/misc/onboard_usb_hub.c | 2 ++
 drivers/usb/misc/onboard_usb_hub.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 0dd2b032c90b..f16ea3053f84 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -366,6 +366,7 @@ static struct platform_driver onboard_hub_driver = {
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
 #define VENDOR_ID_VIA		0x2109
+#define VENDOR_ID_XMOS		0x20B1
 
 /*
  * Returns the onboard_hub platform device that is associated with the USB
@@ -458,6 +459,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
+	{ USB_DEVICE(VENDOR_ID_XMOS, 0x0013) }, /* XMOS XVF3500 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index f360d5cf8d8a..1809c0923b98 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -56,6 +56,11 @@ static const struct onboard_hub_pdata vialab_vl817_data = {
 	.num_supplies = 1,
 };
 
+static const struct onboard_hub_pdata xmos_xvf3500_data = {
+	.reset_us = 1,
+	.num_supplies = 2,
+};
+
 static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
@@ -77,6 +82,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usb2109,817", .data = &vialab_vl817_data, },
 	{ .compatible = "usb2109,2817", .data = &vialab_vl817_data, },
+	{ .compatible = "usb20b1,0013", .data = &xmos_xvf3500_data, },
 	{}
 };
 

-- 
2.39.2


