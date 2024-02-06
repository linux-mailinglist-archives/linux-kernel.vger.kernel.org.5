Return-Path: <linux-kernel+bounces-55072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEDF84B73F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF9FB29775
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE513341C;
	Tue,  6 Feb 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="dF2eRb4B"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D4133282;
	Tue,  6 Feb 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227993; cv=fail; b=fQXT40XQ3LyrndmVtU1i1IvIT7X2SYoOOUvx/W8T7twtIV4cJ+XIfPp/Pjl19Qd76Od7XdCYCaT4qBhs4BWctF7cptMkMl2+5NjgCsous/SHc9xqdqEPajagdmk4ZQbhChsRiXVrls1WVC5CmzT+J4MCja92t1QkJLZIlwIX78k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227993; c=relaxed/simple;
	bh=GYIorgCuxQ34b4lu1hFXgE4alR4MOyW2uxp4IG/bCFo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=myWzs+q4T485D6VYLw6d2DogvZWW0waLaYheylYWGVZWdmJcvskacA5HACYxSWEF9rSGPmRR5MqK2tRFwMRdjH8mW8bEUFwJd+McrAT+52IgcpJ6EGGBmGdFewj68sDrUdg1ksapvI0Hys2DEFmUAtLqVvuIVo1Ober0epLJSC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=dF2eRb4B; arc=fail smtp.client-ip=40.107.21.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6oSlyVIfaSZvM3DA2Sbi4xwJLnG4f/N3CYjPhHsgg6grTRCtMiNklZ1u02pj2BHoqiSDT31AnR6qi0KkW0LgVPlEEi+2afbFFmVzo9xAr8JZ84gLmjQbpL+2IYqSS3snyF8V4ON2iNuCoMywg68FoazIPVHYUnerxiOZhVR56NXy9LoUvrXlPeFYgZbM/RBhlQNu1wpVhl/x6iFG03Vy+tjFPNI0a7oNaan5UKyIkpOWXT8VxrvJ/iRjZT19U8TsJGT3AZ9BAfgnQ1hNm2Po62d6HoWnh1KWbklr/+sfNRPuos3+azGfQRmerYCfe5+p7VolPk0m/GGzJUILx+2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwxTPyHk173LH7OLvpI8Mk3rAWKwhtS83y1hH7zVRz4=;
 b=YH93Wxukr54uPpRBex1hLPDx+gT2a6AsM/CXeYHce/tDXlv9UBT5UN+EIowlPvNV6FicYwjSdwa/1Ztw8QDyxVNTYzyVk6QdMZ9VKSYEv/HSZTgQXpScPeOLvre7x+KJJsdzr5zWEU1iMORNANkPzTbOzLKQkvB8YMaqzSyG4E4FPY3LX5ej1R8bjwsDlORX5esiYTiwRv36uY2X/lGHpU8vZhdQqAe+yMptLlfaCxXg1HesvQ7X3MwbM6Z51hIsFcQVNKQ4J2Qh7qPTz3IMtycaB13a3zd2Zm943+SoXge+6kwMQizm5Ia4Q/ROjCe3fVUmWQk46cIwR/HQlJbxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwxTPyHk173LH7OLvpI8Mk3rAWKwhtS83y1hH7zVRz4=;
 b=dF2eRb4BnxIhFRcubtNPiYn8pKBSTN8G2wXHGfbhPqBNiC1W7aIHHG8EE2JdOhsYDa30bqt5TJYpQHwRwqoINYw9u4tebyhbHhVfIPNXlQj3L9PtmmiMO2tLBX5NwfJeR75uvNwEA9SQj70G4312Gfj8V9PzSk0dVXVCQUslXQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:40 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:40 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:33 +0100
Subject: [PATCH v3 5/7] ARM: multi_v7_defconfig: update ONBOARD_USB_HUB
 name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-5-f85b04116688@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=852;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=GYIorgCuxQ34b4lu1hFXgE4alR4MOyW2uxp4IG/bCFo=;
 b=WTCI5XECxUv8tHOXzWSPX3FkfcSdhRTXvOam30EL8vNxuGPQbNnPcdwM3srNtp5pIzUNHH7B/
 itrkbdgdi1ECwAhaBtncjv/c1ywLGH+lX5CsY4rDY8IxDhpmKMggcMd
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
X-MS-Office365-Filtering-Correlation-Id: a61714f5-f31d-48ed-a7bf-08dc271bdcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xktYCAWDhjSiVInhGRLZPl5U612jiGn7QdFoh8wZOVrt0LEPAkjb8YGoR+25M+Ojx0Bam2px81ZCTfcjnDLz6ki2KxoCPscIYGf+Y9+Zec9h9AKZs9T19YO3z3BU2xM3xVRylcFLs/qBxmHjqRLlNRzdWqZPT2AVW3QK1v3tlJcM4mLR0g+KDCcdW34Dg1Qi+eZf4WU48w8G0shLIf4Lh/nIEj84zwLB2RlnSaDxNWivbYlQQ8dDasJUgHqnITlxG5Gn4jcwF9ded3q9ZHywAdw0ToQy5amdmZhZyOcmUfSpQGWQbzSlwExgs63gnjNqrdkOYjAr/U5vkyJJZB4FmygckcP5iqq6k0VYdptzES/9a/e8D7KkxwC6HOXuqEg/Kmb9w7zsc8NdOfRCzam+oZAMeqWKfIZWbugrnCqniwU/EtJOiIak6b7WPCJTrHmeXT38QU9VHKlZbm6WdNJazNf2njwGN7QUEawLH89nOI9J1m29eFW65Xmo82rKbpDVbm/IAjSJDndeHGRRZWTX0zURAFa2K1knSzo+NGWD9fzfMCxJeKXdXRi+fbABgG0ERC9u87KdvCOXGCJznayiWKZVAzfBQVrqVQIp91ORrVWKZ6v9EIcLSXHrycHOJoJC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002)(15650500001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGp4TExnbkFjajBYeDYyRG1UTHpjaDZpQ3gxa0dRbDFlL3hudUdTOWNCeERh?=
 =?utf-8?B?RkY0MDJiNlE5c2lWSjV3RjY4UnN4ZEwrTlZURkVURkptREl3YmFKaVNpbjh0?=
 =?utf-8?B?NGxNc1lhK2ZPSnlKUU5ISHlTNm1PSXZzb0daM0NyZ0hBNXFmbDBwYjVaUjNW?=
 =?utf-8?B?RU9HdDVxVHEwN2lQcXZzZXJ1T2xZYmxIU3RmVERNeGtsbURsM0E5SlV1aXZt?=
 =?utf-8?B?aGwwK0ZmZ3BDZHM5OG9ZRGVCaFBtdzZRaDlISkwvcjh6ZU9iWGJOWndZZDZK?=
 =?utf-8?B?N3FvNGN1TVNGckg5YWRxWjdEdzRDL1I5dmtjR1QwMmdEMFo1NDdiYVAyaWRJ?=
 =?utf-8?B?RTRJZGVWRmNXaWlkaXJrZnNDWFNhblRJcGRoNHc2K1g0TGhSSGR0TllTZy9Q?=
 =?utf-8?B?M3RGekp0cyt2NkVlSmpDaWhnRFY5V2pqZURIRjM5N3IreEI5RXRQTG1QVzRU?=
 =?utf-8?B?cmZtdGF5a3lOcksvcSs4eWtKTmtYaWI1azdwWmdBdnNMOVdaSUM1SHNUVW80?=
 =?utf-8?B?QVRGWThMY1dPaEdMY3ZXVDVxSFZHa0FYUnJ2ejllMDNwS2VITXFEVzZiQTR1?=
 =?utf-8?B?Tm1EQ0syMmh2cUVOcWhHeGVhRW1CSVhRMjZoazZsbG9CNFNJbXk5S2hUYkVh?=
 =?utf-8?B?OU5nUDRRMjVOeXlmRGtPcnZpa2pmZk5sL05uTTVNU05FSzRWK0RzQ01VRXRS?=
 =?utf-8?B?ZXhleUs5V2RRT1dWckZtaFE5SzNlU0w1SVA2ZHpVMWNoeU1KU21xN25acW5q?=
 =?utf-8?B?b1FpTEEwcFlrd3FVR3l2czJPK2tIaExIdUNVY21Fbkhrc0lCUThIQkh2Vk82?=
 =?utf-8?B?d1hQL3JsMWdZMThObjYwcVNIN2duQjIwQ1JQM01mUmV2eW9MbEVad3ZJTitn?=
 =?utf-8?B?UTF5Ymhud3IxZ1NicHoyc2U3azducjFFZzRNUndZaWpHL2FrcEF5RThvSjdj?=
 =?utf-8?B?ZEwvQzhwcGU4a1BuRzlYTW9Gb0NkcGtTVzhnOVVEWUJjd2xrMzB6SFdNY2Er?=
 =?utf-8?B?SHFqS2ZxUHFQd3pVbURlbXlxRWlEbUZ3dkJiRDEvRFBuNThXb012T20yNWhE?=
 =?utf-8?B?MThaQUhMcUtzOU9wczI5eEZnckVzdWJQUUxZek96UU83Wi8wQnc2WEJ4WXhR?=
 =?utf-8?B?b1dReDhrYjUxMzNYaUZZSUlVWkZlWXRZR1NWZTBuS0k4OG4xL0VWOE1NcldE?=
 =?utf-8?B?UlJFRFQyc25Xd2J4L1pRcm5iSkpjRmZSYjJqUXhtdUtrckNKeS9FRWZDNHA0?=
 =?utf-8?B?dkIrTW4xTWl0MndXNG5VS1FOeW1tQ0pLQy9FUTRFaXBLZGYwYlpGOUNrL2w0?=
 =?utf-8?B?NTVJall3aDR1MTl2OGs2c2owVGVrRnRvdGFwMkFuMjd4WGV1MGd2aTc0S0R5?=
 =?utf-8?B?aEM4UTh6b0tkL3Z2TEp3dFZ3aC80WWI4SzZRMzZ2MUZQQXhtMUw5MmxFcFVk?=
 =?utf-8?B?UTJrcy9ORDUzdmYxNVArZTRaOVJEM2RZTjc1d3NrT2pjQStBcGx3SDVEVmJn?=
 =?utf-8?B?cWFHem5wTnRldkFxc2EwMHUwanVpTWxpeEZuZHlTdCtKeTArd3g3UkM5Y0w0?=
 =?utf-8?B?YndvMVlYRkZQc29mdFg5MVQ1ZUluL0ZDbGl4RXV1dDROSGk3UkFBMXM5Mlps?=
 =?utf-8?B?QmlzTjNpRG9NbUVmQnJqdXJkZkZrNUhKRlVnQW9hdW11dG1YR2toVVRIczI0?=
 =?utf-8?B?UC8zT0hXY3A3cHdtbG9EaTNTdlBSUXFMZTZzc2N4RmxzVlUyaHpCMDhXMkYv?=
 =?utf-8?B?aS9TbXhxalNQWmhwMW5qZjhPU2ExNHhQcFhnWlQ0d0dLRTY4SXF6T3YwZkRh?=
 =?utf-8?B?TzllQkpxSGtBMnNpc3ZmOXFHa2I0UGZnTkNmcHRzQ1hCRVVHdWVLenVqSXh0?=
 =?utf-8?B?d1o5TGl2T3d1czYyZTZyVngwbytnT1lGNHB4b1JSL2ZoeHg3TW1KMDhBbitz?=
 =?utf-8?B?dlM5OFNTRDkvRVY2cHF2R0F5SmVYUG1nR3FBdzlRQlI5Uk9aUkc2NG1qRTVB?=
 =?utf-8?B?NUhuYnRlTnZoQ0xoaGw4Sk1zb05uamdlTVRTdmQ4ZVNSQ1ZHUFR2WEpBb1BZ?=
 =?utf-8?B?cFpNMnJaQ29oM2xZUWdrVUtCdGVYRWZsR1NRUXVZdi94ZGtCMUJmdncvMGlP?=
 =?utf-8?B?T0hiNUhPTjJFTjBUdzRadVJsbVdzOVlnbEpnb2YxZmlQU2hNTTFUcFJEMFgr?=
 =?utf-8?Q?P7mKunLvcJyH4icR6Fk0LOc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a61714f5-f31d-48ed-a7bf-08dc271bdcb1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:40.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugXsfhH35smGyyNErwtzLzsWyb7FZiagZLJBG0cYSQhNVqkjZWRM/2TERdOzxUndfYwkxLfHpw9T/qwEgLr/81Bck9Q/9+yqYNALo7ZzKKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

The onboard_usb_hub driver has been updated to support non-hub devices,
which has led to some renaming. Update to the new name accordingly.

Update to the new name (ONBOARD_USB_DEV) accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ecb3e286107a..6a6ebec173dc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -876,7 +876,7 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
-CONFIG_USB_ONBOARD_HUB=m
+CONFIG_USB_ONBOARD_DEV=m
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=m
 CONFIG_NOP_USB_XCEIV=y

-- 
2.40.1


