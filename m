Return-Path: <linux-kernel+bounces-55071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A684B73E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4935CB293E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE784133412;
	Tue,  6 Feb 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="dko07vtF"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBA132C04;
	Tue,  6 Feb 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227993; cv=fail; b=Trx8UOaLRnoltQSEmOlQL9iUA/feMXD1rpERTihPwulomNGsxintlaYXdeytk3Vt4mqPj+jezruEfw68Z6BFmWSrRcysuJW8N2bhvQmTq7IvFZ1/nuVkTTWaTsmxOcz1qx8gpoQvznr6fCx0wGaIgfdi9pq9r1frVHj2Je5PI88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227993; c=relaxed/simple;
	bh=Hn7W5NquFOfa2SPwHz+COI8OES/VcCwNF5nc43UmJR0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mJ/UBfqDx+0n9+qaoK9HHIrWw7SrcZ7iz3l6uR73I50gEBRE+ghuRf9DLuKd60dLhDZWmwYp2PnZGoz11xVi7TLtoM5v6fQGZj7aBl+xgkVrbI0oKwf7Se5DyHcNqnlnRMl1uylT9X1ELY1zupjxdeWLI0YTgNT+p4Lk5zFjl9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=dko07vtF; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7EDDQZX/D06oYlw+djPNfqgmxClIi3/Sv2X0IlFdIUJzdC5XI/DmN83mk2bsx+9ti2i8PkOl6MlbvJ0roySTQNcjdoCHtrhpkAoqKSxR4zzSSQ3nNlDKFVIQIntW/NQ9T8CkLDUBaQ46s8paSrRhIUiLOVvyb7v/wIFTifVBCzYbhsHE+sGdzzVpxnp+9mnUasSuG/LzjewMwbcclxq0Q0LTGwjTz4Rk+AvtI+ilrNtRFV3JCU870/qfzNOeb+w9g8qWZ2ydp33/FyJqIpfj4+/dr4CH9yb56IHASlQoiy2TmMXxdzMnmVftFayNoC28JiEtwUxguNqggvXwOpgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbaOGiQnqMim73n95NNuOUW1VNxYpJ3bWE0RQMANOTk=;
 b=RG4po5WMArftPDjp08P9IDsjNrXfQgOytQJV9g+2NIr3+jMwWhgUupLZnw3Ylne6LlqMzPpfUCaEs3tOqBr2HHlfbM6pMjd+FqON+zV56k1bsW6lIrdR7BYp+fNB/S++29PJmqoW9wgWyv1+RQh5jWEdba61wfUyB6U6pc3cJ/Xoyw4TXYg4z6dMRKIgW3NahUX4wERj8xhwImhwztA6GKNOyRrrL2qchL35v6Ee8sENcw7HFYmd6uVfAmDnCNNaNVeCcyq/dC1hZlpDT9u76tovo6c9fIsxE73ZmOnhr6EMT1UGqaHnTR5wpjGAaQskRzrakprkf7rJlZQd7N+sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbaOGiQnqMim73n95NNuOUW1VNxYpJ3bWE0RQMANOTk=;
 b=dko07vtFiYltS+U9iBn9drqupuVMHdLVnZUD3UJL9543PXeUfpzviVKZZZ4dKVXlc4fvBMHh8yXfQxNXgyG3k3S+c0BBW/KgycRDAuoJTjzytlS2eU229AAxaShZf2iTDbuJjX3eqmEGiMFI3S1FJuRtW/BWI+M61tzTm/7FoZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:39 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:39 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:32 +0100
Subject: [PATCH v3 4/7] arm64: defconfig: update ONBOARD_USB_HUB to
 ONBOARD_USB_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-4-f85b04116688@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=792;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=Hn7W5NquFOfa2SPwHz+COI8OES/VcCwNF5nc43UmJR0=;
 b=e0yzod+fh8lrUmcWlVzmtKjRuoh/keJcLV0d5MsXgbERSsDgewE6siHzrMVFAsdNmZWdjfs9F
 nZXSZri8sprBz/dTzasIKjKyiq5vxjdUyX7pElfWzt0P9OwBYCGfCMx
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
X-MS-Office365-Filtering-Correlation-Id: e3f97cee-8dc9-4004-ea39-08dc271bdc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	roLV0vDCGATmJchWk9ts7FA++PlzJa9QfenN/yhDj1v6LU/RdqKkmJWmxtksFHek16BvJXgtReeWC9BF5JlzxTWt5MExSq3WRFh7684grU6j2VyTbjVD/0qSpqZw7Wg1pN50z5Ghc9/VOkLZVt7sSAx/IVWY2pFNWFq227aQ6ckF0YC2HNgh68gih+rOLr6N3eKrMID2BE/XQQug24/L1Qy7Qb/zS0tj5KcESdVp7utV1FqrnLSFiU7qFNiR9Ci6STw3bnZhJ0hSzIWYJBUZ0qrluzjthkDopNEry5iwCsvNIjk6nXnPQKNr2ejruRhF81fLMhDmC8q9vI/7vBb0fQjgvioelLvZeKISajCHoNaC6u/vvhWSYc6cORLvHPT+Wte1gf2HSvdKfFsb9QOn+GCiNcoCVqqhF8OrK7NLD2EMnQwQXjxcUvAr+YObckmfxrFYwwCTkNJI59oFJYB+a/8HBAf9xkWM5VmNo8bMykckqSOPaR3TCBpHO/aieiAz9CsghoxQqZ9T5+O/CXVv6x/+RhKPkhOB9nB/XJog9LqUFP8mhovHupfYoKrn6E9kNSYyReKjKZO8wDH69OJGd//N6tKAY9DUg89V/HxQrWyi2Tg6LB8yFTega2eqce9T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002)(15650500001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmo2RU5xUWdtZElrb2d1QzBZc2d5M3o1S3RoL0xQUkdjUjNiNDdlcndEZ3pJ?=
 =?utf-8?B?U1dWTEpQK21GM00yanJCQnZIakFha0NVeC9RbitUNERGR1BFSTRZd3Z2dmNH?=
 =?utf-8?B?Tks3bklOQVRkSE56QlhpaDJWemFhMnB1bE9Xdlk1MjJ5UWRSRUxWVWI4VDJO?=
 =?utf-8?B?R2JSQzdReFJiaHR5Y0YyNTdza3pQTzkyNHN0dkJobW5pemVrcGVnSld0ODRI?=
 =?utf-8?B?cGRmK09MLzlLVWVScTZwRjA3NzdHMVNnb2J1bkl4SWlkWForVzAvZ0ErVVkx?=
 =?utf-8?B?b3M3ckkreTQ1UWJNSjV4K1lIWHBzc2ZEUTRtbE5XWUdWc0xjM2c5NWpzRjZU?=
 =?utf-8?B?MVNQSlZ4bmQ5dGdGbDlwWFB1VHRQNGErYzVWVlhLMk8zZm1Rd0dLVEUwNGJD?=
 =?utf-8?B?eVZUTHRaZEE1bEJWRzFoaWtQcTJPcmpaNWttZGVLM0xmb2g3VCtnakg2bHFT?=
 =?utf-8?B?MUNCVUFDdURkMThUNUlZTmNvTVkxUUEzcnd3emF5NFkwUUtmWlA2UXpQb3hB?=
 =?utf-8?B?cGU3eHBhN2FBa3dIUEI5QjlVM29vM1RtdWlaSCtzMlQxU2ozZCs3aVF1dHJI?=
 =?utf-8?B?V21kZGd3dnYwTkQ3aEpVaFkxUi85cHdNVDJuSTVIVTFtZmt4MUpoVkN2MTVl?=
 =?utf-8?B?Tkp1N25xSU5SR0VWcGFQTWZ1Mi84SlBCVjRKWUFyUUF0N1NOUDVuZDBoYktS?=
 =?utf-8?B?a0hGRnhUSm1Fb2JvNGtwUzV0SFVWQ1B4NzRRK1U3R1Y0SDlvUWlGTGNwSW9X?=
 =?utf-8?B?a3grWnpDSVNsNXhQWjlDeUlJVStmcm43eWVzRWtpRTZSUXVOQm4vVXIrZFdv?=
 =?utf-8?B?RUg3azQrZDhBclBMWHluRWo4UkFGbmdSMHdsT2RoazExeXZFYWNSUUFPYXR0?=
 =?utf-8?B?cTJ3N25TOGdHdis5RG1pTzhHRHNLMkp4bjVhQnE3ME5FOEdac1VGQUZuNVRW?=
 =?utf-8?B?L3BLT1J6a1dxVk5oalIyNjVkM0ZGczl5TmxLK0dnbi82aWwwM0ZEVEdONTVS?=
 =?utf-8?B?bXZYN29EZkNKUDNnSXpLU2dTN0pLeU40SjlvbkVFZVg2SHpJSVNiTHY1UCtM?=
 =?utf-8?B?RHhEbmxVcjBWZEZQa3B2djZUMDJSSjIwU3BRbjZsQW82MHRzWWtadExlYjBT?=
 =?utf-8?B?V1lEVE1IZXBRYm56bFpNV3JITDFMODQ3Vnp0cGNTSkRPdXd5bG1yb2hkc1lL?=
 =?utf-8?B?K1lHT3BsVFM4bGFORkMydW1hdTZnWEtFdWY3cytVUFJJbDdDNjMza01jbUps?=
 =?utf-8?B?NVV0enowUE9tY0Y0NjJIWXU5cWJkdk5GYVhLYUhwMnZwSXIrWUxidHluNC9q?=
 =?utf-8?B?aC8wTFJicW1YUytJaTR6L1BnSldtL2d1bVFQaDVNTWNUaE9TZnlJRXFCVE94?=
 =?utf-8?B?V3BOdlpTdGlNbTQxR0lWdHFmWTBEVUdIL0ZIN1Bla0JXQXdNUDhJR2RXWWpN?=
 =?utf-8?B?UVlwRk1LVWJLS1hsMDY5OUJHSHFnR1A5d1FkOG5PNlNJS281ckxYblRwVDRW?=
 =?utf-8?B?SHJvaDZ0YmtBb09RVmJTOW9MTndubkNnSk1TbDNqcCtGN0VWcUhKUHV3UXpU?=
 =?utf-8?B?QjFFckZ3bXdOaUFaa2R4L2NVTUNCZjZWTWpDZ0MvT3pDS0VNTmlUMC9ja2F6?=
 =?utf-8?B?c1VnSHI3WmpaLzdiNnFQOVAvNjRxUlY0RXg4bTdEYTh5QndxTFlKSm9aYWVX?=
 =?utf-8?B?Z2pWMDVqRWQzd281SGpXS1lpVFUwY1NuK3VnNDRqTExaMzhRWWNjdEtiYVJp?=
 =?utf-8?B?RXMwTXJGUW5DRS90Q1pZVDJuSGEwU3N2VWpnMjgzQ215RmZ2eDJJZ2dWcXlh?=
 =?utf-8?B?ekN0T3BHamk0d1hsNmQxRkJ0VnlzQ0xZQnhXSkQ5T2tHQVV4cE95OEZLZStO?=
 =?utf-8?B?YmpFQjQxeHZjczdBd0k4WjJ2UmdGTVdVSkl6OXFMdDR4UmNTeGNtRzVDMHdZ?=
 =?utf-8?B?RE1mWnRmdUxqVlpIcm5VZjVqWlE4dXVORTBzVDhNSXlwWVpKYlpXL0MrTlRC?=
 =?utf-8?B?eDU4YkZSV2ZzVVcwZXA4QTdHZ3R5ZTNBcERjMUh0WmZvbHJ4WXdnTlgxc3BV?=
 =?utf-8?B?Qk5SYUE3QytkTnVvN1BpNnJMMkt1aGxYM3NjRGhQald1dU5YU1QxeWJERTFI?=
 =?utf-8?B?T3VEV2FuOGphaGdxSWY3djQ3QXN3NHA4TDlCQ0VJa0tPY3NxM0FoVm9uYVdT?=
 =?utf-8?Q?GWRv8Qai/Enh+/hFFLUxDt8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f97cee-8dc9-4004-ea39-08dc271bdc2d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:39.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdfP+uYjXfp2dTCIK6OQyu6bWst5NR6qeVi1NyhnECfPtVf5g1GQ+xK3c8iwtFSvPZPNWxJ8g+ISNdmGf7TPAPxPfBYqIkuAFSEOnOGl7yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

The onboard_usb_hub driver has been updated to support non-hub devices,
which has led to some renaming.

Update to the new name (ONBOARD_USB_DEV) accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..3c6196b6c984 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1047,7 +1047,7 @@ CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_QCOM_EUD=m
 CONFIG_USB_HSIC_USB3503=y
-CONFIG_USB_ONBOARD_HUB=m
+CONFIG_USB_ONBOARD_DEV=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m

-- 
2.40.1


