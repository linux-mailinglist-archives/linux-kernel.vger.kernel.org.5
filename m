Return-Path: <linux-kernel+bounces-152246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0F8ABB55
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EA11C20D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D52EAE5;
	Sat, 20 Apr 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GMmY3Dt7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8371B809;
	Sat, 20 Apr 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612193; cv=fail; b=m3YOIiZ0G8TmnhBw3SqwGu8V81tgH7Jc/e+qYH88EaT+1LXiUiAcR6+1g2Lvw/3tb4XC3us8FDLYNKFJS1k2xFppCUf6psZQuHJqUu32iWdI5JvezGyuDSX+Xc47GIxCIOHshKDvowtat3l6wEK8UC9EXp6U6QUhRPY2c8uMHMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612193; c=relaxed/simple;
	bh=4pSN99gt38h0Ev7v3kdwR39sT8HIKi4d5DlbSap0tbI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KEhfFGZWeE0N6D9ZFVaY6qfEhLlU/rNbDAT1p0SQLZ0bMaB2+e+IxWLz3X2fb7kvUKdfjMRUzSujTVhg4W/tzdAuRxvKrXmyclSoXTGvVfZA9l30u4niMOA9te37Ea3z0mkq+n4VIwqC2pFdqV8ggqrsPw1Ucmbkbd/PzbgK9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GMmY3Dt7; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwBdDydCLllf8IzX3BkxTtdmLtQL3AhcqJcpuGITd2Fnhx/GNL/rIdk6OJKm7fUAy5qzut7+icoPltrfvvr1Pal9/gUIpiqHA9/Geriqjx01rDBW/etgUg6UslMgSYwdevl4OInkEbMrEuA2lCUK/eBV05baoZulRQnEGsChAr8T+KByKXa/YLaCO4Tzn2KNtJ43N3VpWvnugGx3Xze/fOcpAJIQ6lt4R/a66VkSE5WYoqT22ktKtTcOFB6iCP+l2ptLjwj8EtuAZri8iv8LdxR6lac/Jjr4MSfnEAoyBs/qduY+REVu/Xf/EFJyQM4mzdGzDNTagCfCVb6krIygaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+aQFYcvebDOPJj4jg9nX0pgTKdnBjHUSkqcjbqyTwg=;
 b=kLgPp9HA6LgqJV3eLVWoA/lZNQZF4xKYLCzCbi3lmYVVaxeudcQnSk0Zbjxyo8s/bAtQVU5I1wsoJyYB/nsZXysD8V1N7JJVsQtXY0qkYhJ+SniGXyC/rSjFFvnNQU56aLeCwjcmM65Q0WX5PTPgQUdvUAtkxyrLI4vBHEVZNa2FTI0SX4iPmShs+7xLPu6tEHbdCMXrn/xf5PoVxLVAK3IA7LcSpcU5Ye4LhD3/o32c6JkcoWtSF1UvTDQMF6JswDeB2+ffOceN0bcyOhRp/mXaKwt8s+bs6RSZeriM+QmtHgZCvRkaxMv+uJ19z6zJi17T8epXFS7/c45fCn8KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+aQFYcvebDOPJj4jg9nX0pgTKdnBjHUSkqcjbqyTwg=;
 b=GMmY3Dt7NJZf0CRL5p9L3Xg0/A4aXwEqR5NHbZAdstfZZXZ3vq0DKYW7NEu3xw+PG6SUVbF/Fhd+cUEnEdTFxeXJulu1WlxsWnsmuEMgoJafVaj4nGfqnIpOQN3WOz7Bm0iOCGl0MOjgak8MDNjmHuqdvhWgueOCcbOBBVJZjgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 11:23:08 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 11:23:07 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH net-next v2 0/2] net: phy: adin: add support for setting
 led-, link-status-pin polarity
Date: Sat, 20 Apr 2024 13:22:59 +0200
Message-Id: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOlI2YC/32NTQ6CMBCFr0Jm7ZiC/FRX3sOwqHQqk2BL2kogp
 He3cgAXb/Hl5X1vh0CeKcCt2MHTwoGdzVCdChhGZV+ErDNDJapa1OUVlWaL8y9uUp7jhhdhOiM
 b03ZNC3k3ezK8Hs4HWIpoaY3Q52bkEJ3fjrOlPPo/3qVEgaQUyU5I/ZT6HtzEGv3Hngf3hj6l9
 AV3nHMgwAAAAA==
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
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: eae1eb14-3285-4d50-0538-08dc612c4089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3hHa1RVOG1Oc1MwNExyNW5LSWtIbHFQbjdHTldQY3NvSmhaLzAyMDZic0s0?=
 =?utf-8?B?RjY5cXFhR0FWR3JMd2g3TDFRRnZIRlI5TlhTekVPaU04ZlovdmFuTGtJWVBJ?=
 =?utf-8?B?MUdKTEZzaFM5RGtxdDNaejVQV3JHbEJPS0d6M2VpNW5UaWlNM1ZFYi9JWHhk?=
 =?utf-8?B?ZHhRVkhUbFNxWm9TcVhwaGNjbDd0QmNmeWMxSDJIQmsrQ2t1VlpiQU9ZcGps?=
 =?utf-8?B?c0VDQ2E2OENqVWhPNFVJbkYvdzdJOFgwYUY3Zm51a1h5T0d4OTlkb1FaS1oy?=
 =?utf-8?B?ZG45dlFXL3d1dlF5R3kzNGNTTU85TEVGc2ttTmhCR0t2bDhJM1FZaUZRck13?=
 =?utf-8?B?anVqOWVkSDJiRU5EaE5ESUZ2QnRCNmZzNkhLQ1ZwUElONjlSUVViaFFvZXB5?=
 =?utf-8?B?L3haTFVqNnlXdjBqWTR3eDkyanRvdXdxUlRJWGVraEptQWFNV2s4aEkxRklU?=
 =?utf-8?B?QXFqbG9qd2k4alE2YzVTWnFVUzJ6UURKS2dvQUFvNkFGM0FZOEwvMFZtMFUy?=
 =?utf-8?B?Y01qQUsvQlpSWVRaZTFXZDI5UkdmM0Z3SDF4NFpoelNDaitJNnp4NTdtcTVZ?=
 =?utf-8?B?SUZuckVoN00yL1p5LzhWMitBbWI4dGtzcUVnRkdiN1hQN0RUNGhsZk01Z3VZ?=
 =?utf-8?B?KzV5MSttanBPVUJpUVB6U2VaT2JTRGtYK3pLZERDYk0vZVVqT1c5N0xIcW9x?=
 =?utf-8?B?SGoydHJ0UW04a0hFREhkR1pVYU5BTy9XNkhmQytGSDQyMGdoalpJbFM3aS9M?=
 =?utf-8?B?YlQvTXlaOGk1MFZEZ2RmM2tRQ0Yyc2Z4NmZ2aCtERytySVliUFFCVm9GRHhl?=
 =?utf-8?B?UE9hU1FTWG5ZSXFqMGI5aGVwTkdqeHJZQmhYbmlGRGhUNVNGNWVvVnBpUVZ5?=
 =?utf-8?B?WGRxRFI3WEpUVDA4SzZ3M0JCcGNQY2lDelFrcnRlZ1RjcGwvRmJrcmVFLzlP?=
 =?utf-8?B?U0VzOHEwM3J4Y1pHdFhBQWdqSlVFRTg3ajNpSVZiMDBDRDNJUjdjcE5PUlc3?=
 =?utf-8?B?WXUwbjZvNHFNOStDV1UyR1RHQllwN1djYXRkL0dmdHplQzBHODcxcVlOSHhJ?=
 =?utf-8?B?VzhDNDFCVlRkRWhkUmMwMjAvMUwrb29HSVltSDJ2ZnpNSkNRaUsyVFd5ZE1n?=
 =?utf-8?B?dkZKeWQzVi94dHFlUHFFTUNCbWxFUE43TGprMDNZYkgxVU91a3ZnQXo0UnVk?=
 =?utf-8?B?b3Q5VGpCRmZJU0FLaDFRWTlNQXFoSDFyTnBWNTRZMXlpK2o5QzVJVEhYNkFk?=
 =?utf-8?B?NU8zeTBHcElKZkd5TzI2UFRGUkJVZklxTkRtQldMVU45ZE1hclZrRzllbmxL?=
 =?utf-8?B?dG5HR0NvclRPcG9VSkQ4eStpQmJmanp5WFRsWTV3YjFJcFRFbHQxb0tjSXFx?=
 =?utf-8?B?M3NUaUhDd2tKR3pPdFQ1cHZKQXFtbW9ZSUJpQVpsWGFCbEVZSjh4MU82dERh?=
 =?utf-8?B?NngyRlZremxXNyt5M2NXV1BVVFlEY1VaUVQ2dHZMV2FNRWpBOVlxSzZDZ1d5?=
 =?utf-8?B?Y0tESmIvemFVM3R3RkZFckxUczNKT0FHblRJWXZwckFxeTNoWTJmWFdXTUNW?=
 =?utf-8?B?MS9VSEM2UGVtc3hZVHQyTlNDOURlbTJvWHpkcUJDWFFycG5UMmxIN1htUlBy?=
 =?utf-8?B?bFdVTUFIZElmQ1RlZFU3Lzg1WmFJaTJIVlk0QVNLc2VLOWRsVUxpZ2p2UnFZ?=
 =?utf-8?B?RlRUeDdWODRPVGxaMDdVNklsRHByNjVud2ZvMm9CakNUNGV3cDBFZU5tcDY3?=
 =?utf-8?B?dWp0dzFGZWFMdkpnRHlUVi9RNzBvbnRXWlM1eXJncWtUQms3aW96cVk0QkRH?=
 =?utf-8?Q?QrkDlGwadXmgw9XfduqEvobeHpaQ+W2lL2AwI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTY0MVoyTXUrQ05QcldabGtsT0tLQlREOElybXF3SUhYb1c1ZXR6ZUhvcnJa?=
 =?utf-8?B?ZDlJZVlQdmZ3NUptN2lzb2FEUktFSnpDbk5XZUp1UERXMkZiV09NVWNYcmdB?=
 =?utf-8?B?VG9vRzNRM3hPdDdRQnNHcmNGU1dQeFdBbmR5VjJxNFN1WE5XMFMxR2RRbFkr?=
 =?utf-8?B?S2xQLy9WYndOU3JvS3VQSWNlbFJuWnIyMiswWE9RMEt1V0V3S0tieml6dTBK?=
 =?utf-8?B?OTl3eVVaaEQrUmRObklJNFBkRVVOVDZEMVREdGt5Z2RrY3I1TDRxWDBBZ3JU?=
 =?utf-8?B?dHJVTUhvdzQxQXpZZlltYUsrSTF3L0Jrc0pFMTcrdFdibk5CZlU2L1l3SVlB?=
 =?utf-8?B?RXVRU3duelJIZm5PYjMwT1BOblE3YW5HMUdUNlFtYjBpSyswL2cvN29NRFRC?=
 =?utf-8?B?UG5FTnJ6cEpzOEN1cXJpSjg3L09reVM3OWgxa1JJck5TblJsbU5ScHhVODhu?=
 =?utf-8?B?dk0wUnEwaGM0elltTG9LK0VmWHN6TlF3dEpSbkNZNUVxUnowVnc5OGhaUVpt?=
 =?utf-8?B?OUZ3cXJJWkNIZEREOHBLdmMxek00ZVJEUGd5N0Y5SWlkZGZtaThhNUs1NUpX?=
 =?utf-8?B?SGUycnlGbm5ndFZPSDVYQTBUUGU4ZTB1RW1pSkZ0ZUpiamt4dWFYN2Z4SzJt?=
 =?utf-8?B?LzdvbjhtdGp0SWkwMDQvTjE1a0tBcFVZcCtuR0tYZjZVakg2R3N3SXkzTjQx?=
 =?utf-8?B?ZE9VRmJzdG5kT3NGbkk0Ni9rRUtTZzFtc2xuU3VuLzFTSkdiTEl2OUppSnUw?=
 =?utf-8?B?QTlhcjd3Q0ZqSUtyTDVERVRUY3JmQkd1emxDQytnMmtSVWN4TVlMVmhqeGZS?=
 =?utf-8?B?VkJ2bDhpQ3plVlJmcTJWTG10TFhKQnpGTGc4TXdFU0V5TWhLbUswcVpEZmRD?=
 =?utf-8?B?OVZ1VllIVGFNNkd2d3dMS3hsR0tIZVQ2OWxGRjkrQnJpLzVnZXQwWTVoSHNw?=
 =?utf-8?B?MFcwMEFaN0FNSndyWnA4bHRtSE1meExoZUN2TnhSN3hpY2RNOFk4NnlmeEVv?=
 =?utf-8?B?ZTZMaCtaUkRPWkxDamg2VUxDK1kxUnhJM2pQc1IrOVdEd2J1MFJOTFI0UUZk?=
 =?utf-8?B?RzNLOEo2eWRjTVlJcVh2VXJsQjVmZHM2N004Vkc5aUxHSHR3UlJMMUtRakRL?=
 =?utf-8?B?TUVRcmN1RW5kSHB2bjJ3VC9FNTlNcENHRmRoeUxvMjR3OWpSL0NGUmFuR0FC?=
 =?utf-8?B?MkQ3S1B0NGNNTmhScm9rN1BXM2VBalRkcTYzWEdCK1NwZE9SRDBRTU9MWmpW?=
 =?utf-8?B?SmNZTXVaT2I5MlFGelpIQ2dZY2ZtK1N1bS9hMERmbWxNQTFNZk1yQk1MUmsr?=
 =?utf-8?B?cVNFVlJUaEdJM1dYUEJGekluWVVpOEdDSlpWWnZxZjBsaVZZVFZ5eGQxUG5M?=
 =?utf-8?B?WnVjVkpRQ0plRGJjVEhlSURyMnZvNTZaNTR4N3JpbFBLYTB6alpsbXFRMGdC?=
 =?utf-8?B?aWY2bUFlVjBhMEc3VVNNNHlOa1RiL3l6dzhyamt2dVJLQU5PLzhmMU5keEE0?=
 =?utf-8?B?NUVaaDZwU21mejF2MTBEOFBTSkhzZTVkQzJiRWJkUnBqSW1sVHYvMDA1Z1Vu?=
 =?utf-8?B?aTJkR3g3Y1dyTFdFWWNFM2RLM1JaZFVIVnFKZ3E4RXg0dGVxbUhZeUlXbVAx?=
 =?utf-8?B?N1pjT1ZSemRUWjdzS3gzTEdxaGk2cm5CMEJZKy81MFBSQkNjMUZNd2lJWVNh?=
 =?utf-8?B?dy81OHBOQ1NVZU8rcGU3ald1cEFLNG94UTFRVmlzVytObHBHckcrenFpVWIr?=
 =?utf-8?B?dDA0QzJPeXlrdlVtREl6ZTlOUnZyQU05NXVBc25LTDJWVEVoMXVpOWN1a1dU?=
 =?utf-8?B?a1I5djhGU1NWMTZseFRnZDNrVXo4VUJncHo3YUtQSjB4RUEyZ002RHdlTHRK?=
 =?utf-8?B?bUFZMGVma1hQempmYVZCUVlIdEZ2dlVDUXV4aVJDeTVqeVJuTER5WjBxYzlt?=
 =?utf-8?B?ZzdHZzlBZUZvK2I5Z2hXWnZqbVhrc0xvLzN1TU9zU0FWOHJmd2pEbU9MK1h3?=
 =?utf-8?B?bW8yVVp3TGtScExGZVV4a2NyR3ZjSmRERkM3L0JtcllPekRNUkhLVnEycTFJ?=
 =?utf-8?B?TURQak5IRHhXMGFBdFN6ZmNLcFFkU0ZGdWVacUVlNkNGTFJQQisxK1oyK0dD?=
 =?utf-8?Q?6v6zGCs3qyKPNKUZ9gFM8gBGs?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1eb14-3285-4d50-0538-08dc612c4089
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 11:23:06.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHX5V2dK0VVXrvR1LNt2W6vz3EqJ9rfonBRR5T7y1nLhOWrZV/q6gT1sXfSPkDqDdNa4grOxpRqNFfbWX5AjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588

ADIN1300/1200 support software control over pin polarity for both LED_0
and LINK_ST pins.

LED_0 polarity can be supported in led framework with led_polarity_set
callback in  a future patch-set.
LINK_ST is a fixed-function output not suitable for led framework.

Add bindings for specifying the polarity of LINK_ST pin in device-tree,
and implement in adin phy driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- removed led0 configuration since it can be supported through led
  framework
- Link to v1: https://lore.kernel.org/r/20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com

---
Josua Mayer (2):
      dt-bindings: net: adin: add property for link-status pin polarity
      net: phy: adin: add support for setting link-status-pin polarity

 .../devicetree/bindings/net/adi,adin.yaml          |  9 +++++++
 drivers/net/phy/adin.c                             | 29 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240419-adin-pin-polarity-30f7f85f6756

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


