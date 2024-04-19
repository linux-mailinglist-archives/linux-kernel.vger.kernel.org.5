Return-Path: <linux-kernel+bounces-151680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341A8AB1F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573BD1C22AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAB12FF70;
	Fri, 19 Apr 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ZXSONQvo"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3112F38C;
	Fri, 19 Apr 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540929; cv=fail; b=gvA3/hPuO7ff/VEes37Qk1CiNfQyAkwfTqTi63dX4jSlKhgg9IBrsNAbaeQu7TWz1XYzvdFkYMUtc29CMOrr+0vdBGSz46lYRCxtmKwtXW9zKRPY8GtEVfWE71LnEQtYcR+o8qySEAYquZSZ9+E6kibqQ5UWCNEhzQE5gjOo1tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540929; c=relaxed/simple;
	bh=PuSNGlBFSpx0Tt9bjTmgjx+ImbAsAl9Li1Wnxb/N/lU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J0CLvyTP40wEarrZXr1YeF/OIwwGA/ek3nly5wO/hG7HM1MPD1pIewowmsLTRVAE6nicxTmzbQpiTXvCRiUov6CKHTfVqvzHyoTSyMnL8+Qxrd0Tw3wzGSGqqSDDPqDpxy/AaJpP7Hsvq4GWZhb5/u7XIgkQpi7YSKuVbNh8hoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ZXSONQvo; arc=fail smtp.client-ip=40.107.104.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3bIrfvkrc3Ux03NvwXaZ69VBNP96P2TKwtCZvlL3HgtD0V2S5cjpUJKzyf6Gne0LX1hUxy9QmuJXWzSZp6OkmtqlTVNvSVz8kEd6RuK//hnByH11Nk5YwELrF28Q+w7pvcW31/h3WimrutnpcLAvWRITvkFOx2LaWZrXZQcijZaB1C76oH5LdqSBYgauPzQXFv02be4LrjY4C7sQLzQK31R9nRYL55EqTpMI418dPIupSRiOPZyusubFAaTFhrIHTdP2YTEvj1dedgksk/82ZsV5KALnF36/ayM91VtiPhgg3ITH1Q2o07c+tvrcxrRGJU+PveDTbMkzc2Vj9EDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9RbH4nM0ooqwDabojCFlLl1GAl/UCmyMPRdVOIzlMA=;
 b=W8s5X+ifG6WsQNZiHwXa2IxceUo92a400eYN/H0fZjtxJbQd/8XURPA6LGVGN8aaa5VLEFfNOksfIhtZ0j0HAzlicrjz3xCK34JC/6jKwXOlN5tHxhlaHXmE3g7QP+xoraKD6HGy6sr52ZWv4GJkZc6Waq1UKNqy8Onz4Qvjqy3HM1KBBEruEvRn4fba/0JjQUp0klQQy8ZOn70kbQoTYJwFdLANceInLoo26jVTDBjl6u9HTSNTyCr2yE1DCHStUEC4+PzOox/pCzA8D3CXA2ogX9ZjDrpTuL3z0rYQJJp7NH5BW38zxm9hX4ggoaNqxZA2XI8BOFq9uNjiJSISTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9RbH4nM0ooqwDabojCFlLl1GAl/UCmyMPRdVOIzlMA=;
 b=ZXSONQvo1e2070VnpZPDlKHyJdIRsxjm3WjhxDfFwviQ8N7QP3FjnGfGpmBMl6VJFuOrMLraVZIXIEl3rm1+a3Nrsm6jJCkervkz6myWeFT1KQDohckwxF/j48rrarC7J8joN9C7qMuQivc3g+UqjIWz/tZxyavFAJvLl6xvo5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:35:25 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 15:35:25 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH net-next 0/2] net: phy: adin: add support for setting led-,
 link-status-pin polarity
Date: Fri, 19 Apr 2024 17:35:16 +0200
Message-Id: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSPImYC/x2MSQqAMAwAvyI5G6j78hXxUDTVgERpiyjFv1s9z
 GEOMwEcWSYHfRLA0smOd4mSpQlMq5aFkOfokKu8VGXWoZ5Z8PjYN23Z31go05i2MnVT1RC7w5L
 h638OIORR6PIwPs8LF4YjHG0AAAA=
To: Michael Hennerich <michael.hennerich@analog.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d1ad0e-13ad-4508-42c9-08dc60865514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Rkblh0R3hXc3RXelBNUVpmZUhrQ0xwZjdXVHNoRnVSRG5Tc0g0a0Z5alhJ?=
 =?utf-8?B?ZmgwRVR6QXdKVCt0VVRoV2F5WVlRN3F1TUMvUFJQVGpMdWdvbVY3RVFMVDFy?=
 =?utf-8?B?eWljMjBGRG45MjVpOVorclV6ZUx4dFV5Y3BjeW4yNVNIS2swQ04ycXVoODAx?=
 =?utf-8?B?Y3ZNUUZjMEp5Qy8wbHFQRDlBZ2UydEZjMXc3dTFqbXlqRDRMQVY0eWpLNDRT?=
 =?utf-8?B?TCtreklIYXEzRnQxNitnMGtybGdWdzJHMzlEQVBHdXFaNVNHT05OM3pUR2JK?=
 =?utf-8?B?OEVhb1I0NVByUTlVSWgxU0FPVmgxUnF0cW04dnV2QVQybk1vY245YUx0UVhM?=
 =?utf-8?B?dFFaYXBTWUtiYmhlNFU5ZWxJc2RreEFSY1pUemxJNEw4RCtrbWZPYlc2QkZU?=
 =?utf-8?B?VTFKTkljYk5rUy81aTBwRUxkSXAvTE01KzRKOEd2bVV5KzBsWGNzRFZOZFp1?=
 =?utf-8?B?d1JMMWhmUkh1d1dTcWR1ZFp4dkdBSGN4WDIrYUhxdDV1Q1ZvdWFiN3ZWQldQ?=
 =?utf-8?B?S3h1YXNnRG1meDBMUmd6V28yc0hMTWxXN1IyVFo1WDNrMnhIRHVSaDlwdStX?=
 =?utf-8?B?WENUNVZrR2E4VGhjRll1YUNsYkJVM2czd0R5cUtkcmx6andqMlVuSVFqOGhV?=
 =?utf-8?B?bVBDdTdMTE9DU2FlbmRPaE8veVFiSkVFYXVqTk9jSWJUQW9uWlZzYk5xdGFm?=
 =?utf-8?B?cWFCbFQySWpsMm8wOUNhZjBRK012VTZaWk1EenUvZy81RkhMUGltdXIzOEtF?=
 =?utf-8?B?MHRPSUN1a2ZKdkFzOHFVZzlqdlR3TnZER3JoU3h1YmJFTnVMcHlGRGdBbWdE?=
 =?utf-8?B?TWtON2hVTWhZQktCY3c0NzcwZkFZdXpSYXVpdnlsTUdQMjhGUXQrMmxQbTZD?=
 =?utf-8?B?YUMzZnFPdjBmKzlrT0RybzA2aUNUemdNNGU0Q1lxdXdSR2ZDK3dhbnk1MHhV?=
 =?utf-8?B?T3dZYXM2N2hNaGpBRUN6ck5YK29xRTA0OUxwMHBINTM2cVNtZXFIdUxxN2ZF?=
 =?utf-8?B?RmN1YytCSjR5WHZhT0M3Um5LeDRpbDhmL09HNWpiYmJGMlZ6UXZxdk9pMFR4?=
 =?utf-8?B?OEZuWURrUktxaWVHMHFXNUkyRWpMWVVleVprcytXM2FHTktkUy9HTGFqMEJT?=
 =?utf-8?B?MTlJN29UTXVGdnhQM2FBWUQ3K3liYmJZUkRWZnVvSmVRR0tYdmlHRXE2S0Fn?=
 =?utf-8?B?ei80MGdFdFNBSXpVZjZnNTh1aFg3dlp1V2F3aEg4RjNLQlorMHJQL1RXSE1x?=
 =?utf-8?B?Q0xoZFF0TERQU2x6UlZiSmNWOFlPSFU4L0plR01QVnEyUmdFSkR3UExqbENw?=
 =?utf-8?B?T3VNVFM3TTlkYVZYRmNSditnQW5NK2VIODVqVURjOVorTGNEd202U3o0MlV1?=
 =?utf-8?B?Tnhwb1B2bXFRYkVFb2tkbU5aQlIwYVppemhnVmtUaVRqcHYxSklzMStKQ1hN?=
 =?utf-8?B?dllMNE1SUGVLbzJBR2pVNnEyRWRRWlUrL1dyaHNySG51SlpVRTJXK3lYS3FL?=
 =?utf-8?B?WGVTWjBNWEE4Q05HOVUxbEpNQWptU2U1UVdTRkJHTTdzb2F3aWg1YmxsWFBj?=
 =?utf-8?B?RGp3YS9TMHVjd1Z0bDdyQUp0a1IzODZJS3Y5VHYrL1hhNVFLNmdpSERZS3NE?=
 =?utf-8?B?dXkybzZsK2xYL0Nzem1tN0tTbVFhcCszTXY4RlF4N2hnM1JNMnhjMktnWlcv?=
 =?utf-8?B?WTIzanZJZ29NaUh4QlNKOUN0MndpNmlibmJlYjBrSURqbklkb3BmVm1XeGlP?=
 =?utf-8?B?NVZ3OTJlV0VTdGROYzc4REJXaVpYbzhkbGZRYnNFeGxNTHkydy8zSXlXNDFZ?=
 =?utf-8?Q?SaRXOk98SBQdPRn+N4AhDdE8TxGce9oNeYi9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGZFejRKa08xNlBuT2U5ZW93aVJqU2prMUZYMGI4UVBQcC8xaE5tem1lckZC?=
 =?utf-8?B?anBHazlKMzhTdU5TWTFIUGN3S1NmcEI2WEs5VlBrb2V0QWh6Q2p0cXYrNGM3?=
 =?utf-8?B?SDZxMCtYeHlranc4ZXVsZTFZaFlWRUxqQVVOS3lvVkhuNnFIZFRvakVROVY1?=
 =?utf-8?B?R2lLRFoxUk80RGpnZExRK2gxMkd5MGI3SWZYWnh0UWtuaDJ3YitPYWY4V2Yy?=
 =?utf-8?B?c0d2UEp4Yyt0WmliNU1sdHZrcFZwTWhOOC9JaUpieHdnR3dYanFXNTBod3Vr?=
 =?utf-8?B?TGtLU0tRNGxsa283SEw1SDhQZndIbzFQRk84WEJPZWd5b2MxOERVekN3em9m?=
 =?utf-8?B?TlZIVU95YTZTb1ArNnhnbGlRQ3ZiYStPenBQSTF0b2VGbjVWSTF2clFUU2dU?=
 =?utf-8?B?YmYvaVFuRVgxOGlYT2ZsRzhoTzk4VGNrdnRFNW9HcXpGYUxrTzVaRDA1NFBC?=
 =?utf-8?B?aEFSTTA2czJpTFZ3amNtSTlienMxRTM1cTVhM1dwSitheEJhRmRpekhCZG9K?=
 =?utf-8?B?YW51M1Nwa2hPV0FJRVoyNHk4UHhJUE5aMDQrRHNGcm5CbEVWNTZTdXQ2MzNL?=
 =?utf-8?B?L3JiQzZhekxPa1dTR2ZQMFR6UXd1SkxCdzgxdzdDVmpQQVZsTkNKU3hIOGJs?=
 =?utf-8?B?aVQ0UFFSWWVrNFRHWDNHV2dIVGdVaG9qT2ZreWtUVGVwOS9hY21xRlFCU1py?=
 =?utf-8?B?RUJPeFpRbTFKMkxwd0JvSTNCbkc4dWdLMC9SanVtdHN0aWFlMk1CZTBkaHlF?=
 =?utf-8?B?M3VvL2xkcEZPaWNySms2V0FQaFQ2MWFvV3dKaUgyM0sraVhVUDk4NkVucGs4?=
 =?utf-8?B?RWlWbUlxcHNTU3lBUXJ5UEIzWVlReG4yT01IWHlRU3dEQU01NGJ5ek5XbUta?=
 =?utf-8?B?MC9WUjJZSFpmWTRTcW5HbXQ5UVMybDA3QTFnbnpYdTVSZkhEc0Q1NG1rdnNN?=
 =?utf-8?B?eklGOVhoTFVNS1JpNEJPMVRGMG1PcU1nUzVTM1QxQ1hnaUxXY3BJWWRnU2x4?=
 =?utf-8?B?bDEzVHQwQUcvakNSbTduWFVEYkJJZkR4dFovSURXZDM1WUFUdWp1NDJ1dGw1?=
 =?utf-8?B?WVYxR2xrL1gwZUF1Mks3ZXd5cGY0SVdjTG4xekl0anhKd2lSZnFHKzlxTkR1?=
 =?utf-8?B?TDV6bFpDbGNnYzFObjJOSWZXR2IyMTJYbGIyVHg1TEt0Z0xuSXdIMVJncU5J?=
 =?utf-8?B?ZDZiZko4WHdrUnJlQ1pKS0pjaW95Q1ViSkNoU2I1QXY1SGxxeGo2RWlZT0N3?=
 =?utf-8?B?TlhDVFRZRmgzVktzc3hmUjZhVVVibXFXZzNta1dBNjBZck9MQ3ZTbkNxQXJm?=
 =?utf-8?B?dWsvUTkwMWlzbmdrS3JLVmxrRmJLWDZJWk9DRHByNW1oZGdNTjA4YThudmFz?=
 =?utf-8?B?UXc2Q0pmVVdFSVZ6Z1RGaWZrZDZkS1VucmRkWjNjazFHOVdrWm91R1NRN3ZE?=
 =?utf-8?B?ZXhjU016ZTVaRmJKRWhDUWpwSTgxL3JMc2IwbDd6Y3VKMktiNFdScEFCK2Vw?=
 =?utf-8?B?bTZkREg2SFZJNnNzSVRPOXgwdkFaSGRuTUs2SUp0ekVGeUovREpVV3d3YVc1?=
 =?utf-8?B?VGx6UXZ6LzNSbnh5Z0ZtZUFxOGwyeHc4czRtVXpuSDRuK2pVWGFoaWF1VlRE?=
 =?utf-8?B?dzA4Rjc2MEdKbVlIR1VFQlVMTVBETkJDUE9YWkMzbjVGSDlsVEdYRTBRRzh0?=
 =?utf-8?B?QUVVbHhjZUtOWVdCVE9uVXZjTGlLYW5zVzFMS0Z0Y0QrQkFhUU1PUnZJWWlz?=
 =?utf-8?B?Y01sYmo3aHJDUTg0NmUwcHZycDlXSzR3WEFIcUlkVVp0WWFsaW1TR2JWNHZ0?=
 =?utf-8?B?djRyUENBZWRBYXprS0VhV1RXRnlyN2hkQUYvK2VJakVIaHY5aVNjeWpWZ090?=
 =?utf-8?B?OFhuTVZzZFROUnV2Zk0wVmZhSW9YWnppZjdPUVl1WlRYK3k0ZDJoVEM4Vk1J?=
 =?utf-8?B?Vk5HWU5QSElva0NBNUUybW1IK1BYMnk5L3pXYW1rR0Y2YXF1ZWRBeU5rNDhE?=
 =?utf-8?B?MzFzRVJtcG45aXZEODZpblVBb2xWaTlJeWFtZGQ0cHJXbDZWdHc1ZGd5SXBk?=
 =?utf-8?B?OE13NjB1ZGU1MjZ2dVNVNXhDbmVWdjA5VXZheGhnU1RkSEg5WHdYRnNzWERO?=
 =?utf-8?Q?gRq8N4VgcJ0lg1R+FPxehykKw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1ad0e-13ad-4508-42c9-08dc60865514
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:35:25.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqKyS+yk0JI2gxxrWDyR31r4r76kw5VQOh5Girzz5RX3W8iLQZ6aFlLKj5nJlnLZ9JekpP1ecS0OXts3uzddoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

ADIN1300 supports software control over pin polarity for both LED_0 and
LINK_ST pins.

Add bindings for specifying the polarity in device-tree, and implement
settings in adin1300 phy driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      dt-bindings: net: adin: add pin polarity properties for LED_0, LINK_ST
      net: phy: adin: add support for setting led-, link-status-pin polarity

 .../devicetree/bindings/net/adi,adin.yaml          | 18 ++++++++
 drivers/net/phy/adin.c                             | 53 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240419-adin-pin-polarity-30f7f85f6756

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


