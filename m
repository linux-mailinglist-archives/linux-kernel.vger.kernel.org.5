Return-Path: <linux-kernel+bounces-123310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B10890662
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFCE1C30BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21743176;
	Thu, 28 Mar 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="JV8KQfRr"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CDD2C182;
	Thu, 28 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644972; cv=fail; b=koQ2F4V4TV/WFmfCNpPl4bdurDkMcyVn37SlwhxBlXco7mGfspILUvxgt33JtGI3SKiEWtgwmE0KiK0k2vEeao4JV+PlgVFKaBjWkOqVRqNFa0FuowpbNAHQsgbBqDJinpix/pVagVJjC0Q2zWTXdx0INQZ6djhLrLgt8YoEz78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644972; c=relaxed/simple;
	bh=XGGPJvkGtURQ8RfhDgYr49n4srDFMVXXTC4u6YyVuRc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T61ZmF+GLPYpI+NUDUEi2dMOOgsuSlWJiuXXhuTcSg5D60PdMb49DgB8BzlB7QH+NdvNAfu0jeEXXM1TT184X8bcwiyspfzMECCG1s0brdI5qtKA1VV9TGLfyRVj7QUpPHsYaExtqpL/pl/TUOTvj5VXHHIY1M23NTbPlnDhjdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=JV8KQfRr; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1x5fJyLTjw/Rc6ICcq2BTkfsNpFeIe8H0iOYF7pspLwxvnY5x51U0SaTOr1tjrTGzYzDL39pdKuVy1H5U6XHQMtBwMK+WzfjISTgUcgfGqpUSouJ02JPNpLuHhvFOOOupc9YJBMCxG0A1FDBnTOaSwvacBqcZSwXGgqRlsDHgh14rX//JC+VPtIZ0Zx3qvyamUCrO+c203IoEzcO7tiLTd1O5LJ1hwq0BGO1hDNSvyXPPX+7c071P0Lof+FAxx1E9Oavp4wveLCWonA/1u5Fn16+UHBpDBkkFcN4aqf2J9s2mz7jA2SsqEVaKbSwtKCHrDohAyHBklMUqdvj4WLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4Ta3uG0TigHUQ20gIUhmMMjWyvCjkfdwjoH3P+jiGo=;
 b=RkeK9rVitcaZeUYWto9ooPBVrUl8ueZytxZNjTS4vW57hM2nePMSA56RCyfvZ5t/msERXwUBN6B80QEJPKn/V7A911oUYpqdNZhoPi8ljdG23kVnXkhpkd/CX95HDZedy16PVsOh7ckYnDy0Cu5w3j9m/LAkH337hKc4D6YTWJX//u8d93xbHKKP/9J6/oPajiFMNvk2LVcTQk6o5WRnZoGNlnDHMzTjL0TOF+uKqrGEQvPF0541n/BD/akIVHeymDcldtlOND6H1gkGgj2jlrOYyhw77wkFA2+VD2Wiqn3RGtbTP9niLxFqqdYAECwXZ9uCvL3MSFyZ7cNg9X82lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Ta3uG0TigHUQ20gIUhmMMjWyvCjkfdwjoH3P+jiGo=;
 b=JV8KQfRrnSoOW3RfHd3Rp281RYVkbDXPh2pJWTjA8DT2UaHhzTFdoaoGHFNSvreDZFg6BlD0qKdT6tMuA+ohvsTUvpCt4sX0E/xlTJ2M+LuRaNdy3+KBNBsoaCoYkooivCEfChDWbMRTww0b77OtdKQqfxHs95kDUOk3exxcF90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB10147.eurprd08.prod.outlook.com (2603:10a6:800:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 16:56:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:56:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 28 Mar 2024 17:55:51 +0100
Subject: [PATCH RESEND 1/2] usb: typec: tipd: fix event checking for
 tps25750
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-tps6598x_fix_event_handling-v1-1-502721ff705b@wolfvision.net>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711644963; l=1960;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=XGGPJvkGtURQ8RfhDgYr49n4srDFMVXXTC4u6YyVuRc=;
 b=+eUBHuwmL5I35/9Lj6MQ01Rr1KdtMX2ppSimTf/3ZNgqT3vuCSZHwKuH305lbB9+ImJyygo8x
 iFDAwmC0lXdBwMuxAZOSf5KLOnQX6KhqA249mhXEO43cscfAyY2u1OD
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f2cf5d-bec6-4c60-d142-08dc4f47f447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sFx+N7C7PB99KO/Qn1bqd34ZLnqwnS590xBFpxh3biymQ/1WoOHiDJ+T3Kf3xrSqsTH/9P7NWMB7gAmslkN+jRHdp69L8csh+soyEvam9RgihYrXv/rFKRYv4mCTiyxBMvDMwW8C2e+Bv2QwbTb3hvNWWTehMVv/4LQyuntbIT9VUMR4oX82vr1W7TFjZzWLJYpGPusFBb/cNARrWZtslO8IQOHZeeQxAemlTtUAnpaZGVirgmF23sKMXrnacvLIDokPELoZaF9T9Mw9bdswi1vDvELycpXNni66g3bod9fcgUl3d2AA41GhR0w9duu4P/zQek19WZBWceqGB/ZeBW2/8Cfa056lEm9kH6n7BQ7mZU6lx+5eGA54K1pIg+C6I8RZt2GY0Q7Mhbj2zlstct8zbBL08HlohGQssIwP3SFmD/a7Vm2AV6jG1/r2Z3vLnCtEX5c6scLbYl0ZMZyi+AQeHo53+kh6X89MyCWa+fzcsjXLsaIxcFjBOHRIyEhMF/lqgZsUYgtpTZih5MvzlMrDBlMrOQYWXQJdhA2yD+irYTEzMMRJG8wJ903+5KP8Pa9CHuhm3EO3gmNFK8HZ4uwHSgjmjGpw144lFUdbahVW1Eff2hWc+D5o9uHdd6x1AUNAVDBHWmOrXyWlmr9YUtCCUhQ/F4KglB68t8qXZx2xY4f8V3g2jsj1nWezX3DDeM0kKSX6pqFTjYAgeVRxF7eUDhw472usU9TK1gzBlLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFcwekpoN0RHYytUcGM5UFc4eE40K3J2SlM2SGlpSEtqRCtULzJra0hFd3Y0?=
 =?utf-8?B?M2IzQWxpVDU3WUlvY0U2KzhMWmRyRmo5cUEwd2M0bTUzM0oxUlE1cGN0dU9O?=
 =?utf-8?B?dnJnV3lDQSswOGZTRVdzM1BZUVpDK3MvV2tIdElCTnRFUC9KWFpXNHNVcDl1?=
 =?utf-8?B?REJsT1M0K3RmTnVKYVBua1J0UStod2ZzT3l1RlpwalF2emxzSDBvN1VxWVRq?=
 =?utf-8?B?Yk9MekNXNTdjOVpqL1NtTnVxTVZtV0pVYUJFdURjMWo1d25WQld3LzI1c3hF?=
 =?utf-8?B?c2pwWmNweDVyMDRBY3lGYjNJR2JTM2o3L2JpdUNLcU5XeThvMFFwNyticm44?=
 =?utf-8?B?dWp3S0Y1QlQ2c2sxVGtOcUJYOVhDVlgvR2xPU0tkZUpDVy9lTTdZRUEwUTZU?=
 =?utf-8?B?Y3pSemNNTDlsN0w1Wkl3azFEQm04LytSNHh3ZGxia0FSUytwSEw5Tlp4SXlD?=
 =?utf-8?B?Zmk1Y0tZaVNuTFRVVGZnb0QwNkVwZkdzYmpWMHhMdVcya0ZYRjlFbk1ZOEJ6?=
 =?utf-8?B?ZitIKzhmcFNKQmc5N0hvZTkrcGliYTkvSjV6SElmVmFkWnVFMlFodmZRbWw4?=
 =?utf-8?B?ZVZNVjdUTnljL2tRRjRmamR0dHNyRU9FOUtwNFhOU1JRUUtiZHlobGp2Wkth?=
 =?utf-8?B?ck82UnFMbHpoRXNrZVpMOEtBU3Q5aU4yclJnNlM1RXdFek80bzh6MS9DTXNB?=
 =?utf-8?B?ZkpDbHZ4SmkzczlhUmlrbktrQTRjdnFqaWFndnpoRkZSamh4enJ1b2JQak1I?=
 =?utf-8?B?b21DNDM2ZmdlNHIvUW12RFQzaWg0NU5oMXdHcWRVT2NpdzBDMi8zRXJwejRV?=
 =?utf-8?B?a0ZDT0FRNXlwSm9CUjhOV1dJUUM2YTZzU280NU1QZG9Od3dzOTNWVkg4YUph?=
 =?utf-8?B?TzNBQk55c01MZ3pnQUxUeGZZOGdHQ0ZOUmlNSlJhQXFHUmliQzFBSVEvRFQ1?=
 =?utf-8?B?RkFuQ0wyNzI2K3BWdHRoMzdta2V4L1pQYVhVT1VtLzBOaUxFZ2I1ZlpkNlBZ?=
 =?utf-8?B?MGlKaWNidjNWeDV0RVFxejNYcDIycWV1MUJlNUNTQUR5aG5sdzVmTVp3SXBo?=
 =?utf-8?B?NHc2VzZxR0w1WWpMZHBKckxwcjE2UVBTWlZpQXhneUNmcU9DMUVpcHBnVU9j?=
 =?utf-8?B?dE5KZFIrb1BuRy9UaDMxdWFZUUpNQlhCN011R3RmZ0NyWkxBSXA2eGdrdlpi?=
 =?utf-8?B?VEsyS2ZFa05aZ2lQR2R5emlKWEd1djRyVEI3YTVJUE1JVkhJWVhKNGE3UzNE?=
 =?utf-8?B?VnBOVVVSNGtXVndqaklVQjhFcW9KdjBFdUdhT2VYSjI3MHpGajVJU2pIMVRJ?=
 =?utf-8?B?SURQTE9EVnBiSnc5OEJKZG51ay95NCtYQjN4MEtBSmczQ2xVc1JIcTJrUUpR?=
 =?utf-8?B?S0ZYRmVkWnNTenRadVVBbm9PaXJIWlh1S3ZMNzRxSkhRRHNkdFhnODdOaG95?=
 =?utf-8?B?a09zWlgrcEY0VDFERklaTGlXbStDL0JFdVJ0NXY5bjJURkh2UXdpeTdOS3l4?=
 =?utf-8?B?YVRaRGp6TGczMU5nVVRpbnlFVitqNTBhSmVJM1kzSU1NNE5aYjEyYXJDSXFv?=
 =?utf-8?B?MUIxdVlKWW1UWGZwTkluUGV3ZVZ4WXFsMmdIMUdTN1hzcVNrYXVmRHhWM3E0?=
 =?utf-8?B?cnpzOHFGKy9IZ2tseVhkaStEVFpFb1FScTNGQlhCMVBaaGhSWGN1V0dTYUcx?=
 =?utf-8?B?L1o2bkpmUVEya3ppZmZaT3djNWZhQ2d0M2tuY1poT25rNWl3cE5SRkQvc1VB?=
 =?utf-8?B?UDdiYUUzZVBHbEdia3RiV2IzNzlUMEZ5UXlsUEgwQnBTWEhzM3VIZS9Ya0Fl?=
 =?utf-8?B?MUhYWFBId3dUSVZqWGk3QU14VnNneWxCTnJRajJiY1h0eVlGNnZxanJuTUNy?=
 =?utf-8?B?ZmtQL2VTQTk1Tkd0b3RMZzhjVHFkNWd4ZXprdFJOT2NTTENDTW0rRU5UblB1?=
 =?utf-8?B?d2FTd0krZWtheXdOeXk3WHptdDdJQ2NicXFtVVMvRXFTbWxKRjZsT01qc2hp?=
 =?utf-8?B?Y0hkV0xQM09SSkpPTjhMbmc4ZDhxRDV0S21WUW1PblBEUGtXUjNVYzVtUUJJ?=
 =?utf-8?B?YlY3SjhqTGc4VkhMQ0NWKzMzdkV2TEZlZ3FHRElQRXlhKzhrbSswOGN0NkQv?=
 =?utf-8?B?ZUxMRjRQQ3hqTm90ZGwybzNFQnpyM1NNbDJQOHBnWVVJR25RY25KMWpZdytH?=
 =?utf-8?Q?Bk1GWHuUquqB7bqny854Mws=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f2cf5d-bec6-4c60-d142-08dc4f47f447
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:56:04.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpWLwWMp3mmjR96wLR0zIZaBrOqcM4w9sV3QBF4gpUryhZIwPO5RTCNVZwtXzYRij5JzmNIMwdd93hVOsEt+2yvmikNaKxhrhag5yuTgJM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10147

In its current form, the interrupt service routine of the tps25750
checks the event flags in the lowest 64 bits of the interrupt event
register (event[0]), but also in the upper part (event[1]).

Given that all flags are defined as BIT() or BIT_ULL(), they are
restricted to the first 64 bits of the INT_EVENT1 register. Including
the upper part of the register can lead to false positives e.g. if the
event 64 bits above the one being checked is set, but the one being
checked is not.

Restrict the flag checking to the first 64 bits of the INT_EVENT1
register.

Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0717cfcd9f8c..7c2f01344860 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
@@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	 * a plug event. Therefore, we need to check
 	 * for pr/dr status change to set TypeC dr/pr accordingly.
 	 */
-	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
 	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 

-- 
2.40.1


