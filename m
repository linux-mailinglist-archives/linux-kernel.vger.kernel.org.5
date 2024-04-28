Return-Path: <linux-kernel+bounces-161261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2D8B49B9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4859C2821AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2FE3C28;
	Sun, 28 Apr 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JZzklQ8I"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E820313;
	Sun, 28 Apr 2024 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280437; cv=fail; b=qDPlSnvWoJHEOetcuqYjkV6kb9h6bPbrqg9qcs3VaqnbAjGppOxwSUmpe6g+bI4CxTKuWLoFe574U4Kyev08jIXpwWn5w2U6bCP/WRd1B1Y+aUGy/dUNg4cJJ8ysrJIW12qv2YMxg9TeKIbNnpzs6E2Gu8pTlpQbtcGm8t1Yy48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280437; c=relaxed/simple;
	bh=u2zo87A70Q524uUYu37PgRp46Y/8wvYUyclK1TtgjAk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bQQNEOy8t3/TgJcANWsY6UMFepM9S20OYUKw7pu9Jgh4/iHu6XTWeetnKh5hxMuKeFKzcH38DYSzJcIoesRapl57XwkJ+dVQyVjYZQLNP3w0DaD4DxHwA9OisbbFZmfKhGbjlW1tv09OzHDlf8UYUdgFpnCjzUS72cNC2U0Y9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JZzklQ8I; arc=fail smtp.client-ip=40.107.13.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1H4uUPnSp8oSDZ2f0esfVjGbAfDYSIpeCzKJX7IkbaMILhAGAU6HULB5RDWpBw1z6pfYFCfuKx2df/vNsrUoFkNXQ26IHyU3Wmt4x0aCFqO7GsV0kbrTS/wU/6hVfL+eEVg83aozb90s0yS+beKx3hSezrKznITydDtapj83QYg6j/fftJBjvlXgLOGmO2tbiF1ifuQnaxyZVVPUaWGveLL6bSlYSr0fDjkxdwW9TnGmEmmTxztbV3FIEjOdeNg+olaIxXJycODDHIFlx84FXsicjjWOlfbp0DzeTsaYa9Q0H0aYz9qTM/h731NVNN5B7k+gBFC5jt+fpXznp9Qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=441zx7hphJsY1jNDNq1G1RFMdYNo406aXaxlkaXE8WY=;
 b=AVw176lN6LolSADN3v1x4Tb9xUDn0PLd+C/MJRuUZ5vG/Hx3PJ1oy6lr0A7mvAiT9ND/iZCHL1s3q96NbzyyYxbeowEQUtlsLLywPz5YtTP0zvnxJc2p/8dnsyBvNAZeVP3QhzEPg5FvHjLYB/gyHtBqy04MIKeCKV8yUWk/mNbzNMK2OSB+wm32EjRLXTZbmyZYXE+bxDZbuTgXLh6Ch41OsNDZXH544SGeTWsXUXYe+i140AqZWjOz5mfnyWgMT/xDyemMo85EoGtTW92YXihuP8f68SikLShAwAfTmL5WV3fZcmn1uSY1zYU/9UijunXA7XEW21JNNpTjviug0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=441zx7hphJsY1jNDNq1G1RFMdYNo406aXaxlkaXE8WY=;
 b=JZzklQ8IwEhXwfIVr/k/8JfRAJO1hb//lNwJv4R4Fux47FxyrLBDawWGA+nIGVozH/M0t+MwwWDrewqqZqCWUl/8PE2x79zjv2D1ICj5zVnbwNx+aM+iy+neI8dRYQOhLy/EIL/VtLrmNEz8LgmVjc3mpq5t9M0XT4Z2n0i6Moo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:52 +0800
Subject: [PATCH v3 6/6] pinctrl: imx: support SCMI pinctrl protocol for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-6-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=18021;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ej3XyUfHfs0m7EeJwnBpJGh1HUzXr1QHjnWHWK0fA3Q=;
 b=bt758DRq5byc8V4Wj+NZza5eJ+14h31KbZoDLDH8wSALxbl9HNzsMbYBzSHWrYpAFdewU9fDZ
 NLn6YKlcPqOD+coj3Bjm412mWWztaS7nJ7/OLd5eJBNFyudHikFUroH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e37c432-4c32-4930-f5f3-08dc6740219d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW1vK0RVUlJ5SEY4TG9ld2tWekZUeC9rbHNSdm0zaHkzbUx3ZWFWcFpqZGZR?=
 =?utf-8?B?Nm5UZDBPdnNYWkFndEc1RERHK3kvSlBsSVdtL01YeUU2RDBIem9LYUs3SVZ1?=
 =?utf-8?B?M0VVTWZidEx1MDZac29DQ2VSQmFsR0NsTURmdmtKZ2VLT0Q1ZjdDRno4Qllk?=
 =?utf-8?B?bUdvWmpTTnVtNldkaVNQbnBCMmR1VnluZnpUZ3Z0ODc1RHcyYUNqRGtkRVpk?=
 =?utf-8?B?bDhCV0ZOUVhoK3VnYnFkb0pHUHlkYUxDRUloOVlXMEJLR3ZSOHVLb0wwUnZX?=
 =?utf-8?B?MFpvT2F5NzJ4b0ttaW1yNlIrTUFtZTMyQlZ4Y3I5T2UwV3RxUDlXNTRZNnZx?=
 =?utf-8?B?ZmhyOTBZWjFQZ1lFYzZ4ZUJ3TjJ1SE1ZV1g3OFNjMFFaNmRUTUxKMUxFajNE?=
 =?utf-8?B?eDhTdk0rL2EyQmd5T2wwVVhsVFZ0Z1lyUXBkZ2VYQ1ZSN3dCNERNK09oZE9u?=
 =?utf-8?B?MFIzNW5HSE5TN2d0Qzc0eHg4WVZqbXpNN1NvYlFiN1lraXpJM1JVN1lNeWJE?=
 =?utf-8?B?SFo5cXZkOXgyTVAreTJBTlFNUlhkRzFoUytCQVhSNC9adFUrc2kxMFBVWXll?=
 =?utf-8?B?K29jS0g5bUNKWGFHQWZQT0pLOHVoZ1RDSU1BYU9ycCtGdWpYUElFU1hnaVVE?=
 =?utf-8?B?eEpJTjdkaUVsd1B5K3NvbnhWSFZyU3FVamM4VDJWK2xtZnhYTkEwSVdsS3M0?=
 =?utf-8?B?UDNjcVNyNUNncnVhYzYyNWdHUXgzdlhlM052a2NSNFF0V3N0MTN6K0RqOUtv?=
 =?utf-8?B?c2NGQkRDVUk4bS9uaTFVQUh2NDJFaHppWXFDSkhBc3FvYk94MDBSTHlNbVcz?=
 =?utf-8?B?Q1FtS09OTUQzUmtITmZpdW5WbitKWE1aMm8zTlZPZmtnU0hLNUo4dm9tU0ZQ?=
 =?utf-8?B?NEVpRlIrOG5GTWJrR3Rma01HUVFaN2toeGNtaG5IcUdaRXBGdkV6YjRrRUFq?=
 =?utf-8?B?dktqVkFhOVp6a3pCNW50clhCRG5wNDhSNURQNERVWVBNeXRFQWJQeHU4OER1?=
 =?utf-8?B?cDE5OTZnaVZVN2FqREZ0dFg3OGJROUJQTzRtaXNXZzhVTWVFZ0RYMGZ1ZFd5?=
 =?utf-8?B?TnBERERnczdoVEtqSWw1QU9nQXhSU01WMWJ4MDFJdzhKdDFYalI1Q0I3QnAv?=
 =?utf-8?B?Z0xXbGp1amZWZ0JTMFU0OUQ1SGZFeXNLOCtNR0M5Y282MlozNVZiNlY3cFFh?=
 =?utf-8?B?a0RGSDhzZ25zNzk5RjR4NERVWG9JVGRBbkhTdU1UeEhQcHFYeGx6RG41WmFa?=
 =?utf-8?B?eWRDMlVXRXJqMXRqZVBwVExHWEtNQ29NSC9FQXBpTWMwSGNMSkVTejlaWDVv?=
 =?utf-8?B?d1VZNDhQaHgydjJEY3g4cUFwM0ZiYmtqVndkRTF6UGRlWjFnaU1iWHlPUlZW?=
 =?utf-8?B?SFZ6SytxV016MzNSUlRIWFdSb3FQZjJjb1BUWk5BWDR0SGpBMEJUdHlzdTRr?=
 =?utf-8?B?Tkp4TVRjL3hibUFSUnZIa09ZTDJYSEFWVXFLZnFpQ3dZeXFoMnJUcFJGUEs2?=
 =?utf-8?B?SWpQeVV4bXlvUUxCM3RMK1QxQjhYN2FnTjQyZmJMdWtlUXpoZGg4a2Nzc2FM?=
 =?utf-8?B?cEZZLzNaTUxJRFd4azZIdGZ4cjM4dHFmelBSQTRhRW41ZDVHV3c5T2hXWlFt?=
 =?utf-8?B?aXdwNEZKZW9kRGFmblNkb3JIYndIaUpOTXpxdE1xMXlEa2hrSUZLRE9OaXRU?=
 =?utf-8?B?djZtd2UyYnZDa3ZiUnVHVEw5NzdnY01FWnhWa2NYTk9od09OUzk2NmJqRWpT?=
 =?utf-8?B?ejVWM2JOdDE5Y0hhR3U0V3B1TkpmTldHOTE0a0IySW9SVVB2cFVvUld1Zno3?=
 =?utf-8?Q?BzgbdRpJkySyw8G3xVfsWooFldka2lxAMkcC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3pmRVVMMXlFMk0wODRCbEo5alZzY0dTcXV5aEFVeHQrUXJxRmVjSDZmZDRX?=
 =?utf-8?B?K2FNRDZIblJGQW5XQlBzdDJTZ0RTS1FqbTlrNE02NUwyT2hxTnJQVEVUMzJ3?=
 =?utf-8?B?U1BCMjhodDBUUUVnNHNHV3lsZzlqcE0rd0VKUUNKTHZLVlozZ2Q5akk1TFRu?=
 =?utf-8?B?ZnVyWVN1RmxyUVY3Wkl1MG0zR0o1MnR1ejRGRjRseU56WlVXWGhKVFNXTWRW?=
 =?utf-8?B?ZGc3WnFKQmQ4Wmt4am9JLzFFaGgwRXBLbFZ0ZW9TcFB1eGxaVHQ4WjIwUktH?=
 =?utf-8?B?c1BVVmZlL0dtc05FWlpLeEVacWFDM3NibWptMU5iZ1R3K2pCdkdxdGgxNGNX?=
 =?utf-8?B?clIrbktkVDQ0NFFFa21rcU1SN01DSVZTZXc1aDVsUGV2dTAvaVR2TkhyUjhl?=
 =?utf-8?B?TkZibUJGbkh4dEhUZGlybDhXUGFBVWY4TEQ1WVVOZ0tveXIwaGxoeDd3d2JG?=
 =?utf-8?B?ME9USW1EZ3FlYitsVGpkWDF0ZlY3Z2NmME4wakZqTHU0UXpmSnc1U2E5NEdn?=
 =?utf-8?B?amFQK1Z4WmhWMEF0ZmFCZDgxNmZlNklnaXNwY3RDUVR4Rldob0ZLVHo5VUho?=
 =?utf-8?B?VE5NMWo0ODhnY0xBSC8zVU5ndWE3NU9WMTJ2b3dtNGxBSE04TldUUHdNb2hN?=
 =?utf-8?B?VEJBQTZCYXRJSkVVbzl2aE5NN294cGtuUkNVQnRwby9xUi9hek44aDNSSGFQ?=
 =?utf-8?B?emhQMW1HVXN3ZTYrYXZXcDNUVFUvTnByc0o3V2ovUURQNmorTzBVZ3ZteVo3?=
 =?utf-8?B?S2NGMHRSam5zZG8ra0ZyOG9POUJGQitGTVM5ak9Fbm94K0orOGdzejc3MS8w?=
 =?utf-8?B?RXpoV0ZveHFKRVJIalNtZCtBYm1DYW0wTEpoVHNSNUxuVDVzUkZjN0Y5d0s0?=
 =?utf-8?B?OG82Y2NZNkJsUG0xbUlmK2k3cFlzOGRhVkZOanB2aWZTK3U2MnF4VFZ6a0dS?=
 =?utf-8?B?NzV1eXdFTW43L3lkeWswUStFR0JjU1p3UkIwOWhNd2IvVnU2M0hKS2duOE0z?=
 =?utf-8?B?UVNpTlFuY3VKV0Y1RHNrVUUyRG1uaUdhRGg3c1NRb0w1QjRBa0RnVjRnWjFl?=
 =?utf-8?B?emR6L1djMTh1ZEJDWm43aDZXVnRIMzQwQXJ3NWEvUFhsSDEzWWlQZ1JMeHZU?=
 =?utf-8?B?Zzk3UEdJYUJicUJRRDVKamViblQ5b1VvcHRBOHM4emJPWkFTWTllUFBtOFRa?=
 =?utf-8?B?MzZSSG9VZC9wL3Rrc0VoSmtNQmg3Y0E3RXN1SU1aNUxaNmdpSWJ6KzZFc0xo?=
 =?utf-8?B?cEg5ckE5NlFLcEE4S28rMFNYbnZtUHBGMmg5VlY5Tk9kRGRDSFp6L0hMRTRp?=
 =?utf-8?B?eGQ1SmF3ZlB0R1ZQVmtSTFgxYktod3A3Yzhvd2FRRFpUdkJ3NlFTS2hUYXlX?=
 =?utf-8?B?VzVlTEVHY0ppVStDamRZK1owcWlJUC9DWnpZdWxDM29KL0JSQWZwYnJSSVh4?=
 =?utf-8?B?bkg4L21HZzdHU1JYTU9pcFRadjBRL0lna0RHOThnTFYxSExIRDl5Wm8yT253?=
 =?utf-8?B?N2FwTDRCVmtvYWR1NGhXcXkycWN5UVVTT0tUaE1PSm8wejN6dmhWeXREeXNy?=
 =?utf-8?B?Y0Y1T24wSnplcUF2aXFsZ0VleDZOVFY5cithZm9kNGZ2MmQrbWs4SjJLS0dK?=
 =?utf-8?B?bUlFc3Z4VnVac2dvamtWUzNaU256N1FBbTg1Zmg1S0N3ZDVGWE5YaTBKU1JY?=
 =?utf-8?B?UHYrd3UrdHdkZUc2eTAxSnBEc2loYlJOMCtqbExIWnZaLzNSalMxYkUvMjVs?=
 =?utf-8?B?UklCbjNXbEI5MG40RVFVSGNtODhKT2Z2Q1d0aUlURWZaOUVlUm03TlJCdC96?=
 =?utf-8?B?a2MvQ0I4aXBYa0Q1Y3dOcWF5UW5ySzdyellKVm1VdFVESnZ4ckZkVU5jcFNN?=
 =?utf-8?B?aUtqWFNqU1YyUDBRYjcxTWpoOVRydXpNTG1LMTBXcFl3S1BYT2k3aTVhcjll?=
 =?utf-8?B?VzBIdVNrQ05aRVpTUzU2OG1LNFNQUGRranluR0JQODlIY2wwU1JWbkRNbnFT?=
 =?utf-8?B?T3FyVDlBWWJiWGZpOEhxeTRmYjVoT1lvSGtYSHpreUF0Ry9mR0JOSzJHVEVO?=
 =?utf-8?B?TW9veTRmcGlvakF5Z3Z1T0dCRWw5bHNmY2hTcmVoWG04UUVZdzJsNE5MS1pQ?=
 =?utf-8?Q?n6U/5Lnq/dOEng3bgB039rNOS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e37c432-4c32-4930-f5f3-08dc6740219d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:32.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZxOtPwudfIkbnqtW5X5xETiHDR9PUVQ8fCb4IFIKsbC1gBbslAW9Nvuc6J9kBSjlEA1EBg6i0FGRxFR0b26zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

The generic pinctrl-scmi.c driver could not be used for i.MX95 because
i.MX95 SCMI firmware not supports functions, groups or generic
'Pin Configuration Type and Enumerations' listed in SCMI Specification.

i.MX95 System Control Management Interface(SCMI) firmware only supports
below pin configuration types which are OEM specific types:
    192: PIN MUX
    193: PIN CONF
    194: DAISY ID
    195: DAISY VAL

To support Linux generic pinctrl properties(pinmux, bias-pull-[up,
down], and etc), need extract the value from the property and map
them to the format that i.MX95 SCMI pinctrl protocol understands,
so add this driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/Kconfig            |   7 +
 drivers/pinctrl/freescale/Makefile           |   1 +
 drivers/pinctrl/freescale/pinctrl-imx-scmi.c | 574 +++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.h               |   1 +
 4 files changed, 583 insertions(+)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 27bdc548f3a7..bc23d9f7b5bb 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -7,6 +7,13 @@ config PINCTRL_IMX
 	select PINCONF
 	select REGMAP
 
+config PINCTRL_IMX_SCMI
+	tristate "i.MX95 pinctrl driver using SCMI protocol interface"
+	depends on PINCTRL_SCMI
+	help
+	  i.MX95 SCMI firmware provides pinctrl protocol. This driver
+	  utilizes the SCMI interface to do pinctrl configuration.
+
 config PINCTRL_IMX_SCU
 	tristate
 	depends on IMX_SCU
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index 647dff060477..e79b4b06e71b 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -2,6 +2,7 @@
 # Freescale pin control drivers
 obj-$(CONFIG_PINCTRL_IMX)	+= pinctrl-imx.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)	+= pinctrl-scu.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)	+= pinctrl-imx-scmi.o
 obj-$(CONFIG_PINCTRL_IMX1_CORE)	+= pinctrl-imx1-core.o
 obj-$(CONFIG_PINCTRL_IMX1)	+= pinctrl-imx1.o
 obj-$(CONFIG_PINCTRL_IMX27)	+= pinctrl-imx27.o
diff --git a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
new file mode 100644
index 000000000000..13c65ba51269
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based i.MX pinctrl driver
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "../pinctrl-scmi.h"
+#include "../pinctrl-utils.h"
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+
+#define DRV_NAME "scmi-pinctrl-imx"
+
+#define SCMI_NUM_CONFIGS	4
+
+struct imx_pin_group {
+	struct pingroup data;
+};
+
+struct scmi_pinctrl_imx_info {
+	struct device *dev;
+	struct imx_pin_group *groups;
+	unsigned int ngroups;
+	struct pinfunction *functions;
+	unsigned int nfunctions;
+	unsigned int grp_index;
+};
+
+/* SCMI pin control types, aligned with SCMI firmware */
+#define IMX_SCMI_NUM_CFG	4
+#define IMX_SCMI_PIN_MUX	192
+#define IMX_SCMI_PIN_CONFIG	193
+#define IMX_SCMI_PIN_DAISY_ID	194
+#define IMX_SCMI_PIN_DAISY_CFG	195
+
+/*
+ * pinmux format:
+ * pin[31:21]|mux[20:16]|daisy_value[15:12]|daisy_valid[11:11]|daisy_id[10:0]
+ */
+#define IMX_PIN_ID_MASK		GENMASK(31, 21)
+#define IMX_PIN_MUX_MASK	GENMASK(20, 16)
+#define IMX_PIN_DAISY_VAL_MASK	GENMASK(15, 12)
+#define IMX_PIN_DAISY_VALID	BIT(11)
+#define IMX_PIN_DAISY_ID_MASK	GENMASK(10, 0)
+
+static inline u32 get_pin_no(u32 pinmux)
+{
+	return FIELD_GET(IMX_PIN_ID_MASK, pinmux);
+}
+
+static inline u32 get_pin_func(u32 pinmux)
+{
+	return FIELD_GET(IMX_PIN_MUX_MASK, pinmux);
+}
+
+static inline u32 get_pin_daisy_valid(u32 pinmux)
+{
+	return FIELD_GET(IMX_PIN_DAISY_VALID, pinmux);
+}
+
+static inline u32 get_pin_daisy_val(u32 pinmux)
+{
+	return FIELD_GET(IMX_PIN_DAISY_VAL_MASK, pinmux);
+}
+
+static inline u32 get_pin_daisy_no(u32 pinmux)
+{
+	return FIELD_GET(IMX_PIN_DAISY_ID_MASK, pinmux);
+}
+
+static int pinctrl_scmi_imx_map_pinconf_type(enum pin_config_param param,
+					     u32 *mask, u32 *shift)
+{
+	u32 arg = param;
+
+	switch (arg) {
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*mask = BIT(12);
+		*shift = 12;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*mask = BIT(11);
+		*shift = 11;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*mask = BIT(10);
+		*shift = 10;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*mask = BIT(9);
+		*shift = 9;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*mask = GENMASK(8, 7);
+		*shift = 7;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		*mask = GENMASK(6, 1);
+		*shift = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_imx_dt_group_node_to_map(struct pinctrl_dev *pctldev,
+						 struct device_node *np,
+						 struct pinctrl_map **map,
+						 unsigned int *reserved_maps,
+						 unsigned int *num_maps,
+						 const char *func_name)
+{
+	struct device *dev = pctldev->dev;
+	unsigned long *cfgs = NULL;
+	unsigned int n_cfgs, reserve = 1;
+	int i, n_pins, ret;
+	u32 ncfg, val, mask, shift, pin_conf, pinmux_group;
+	unsigned long cfg[IMX_SCMI_NUM_CFG];
+	enum pin_config_param param;
+	struct property *prop;
+	const __be32 *p;
+
+	n_pins = of_property_count_u32_elems(np, "pinmux");
+	if (n_pins < 0) {
+		dev_warn(dev, "Can't find 'pinmux' property in node %pOFn\n", np);
+		return -EINVAL;
+	} else if (!n_pins) {
+		return -EINVAL;
+	}
+
+	ret = pinconf_generic_parse_dt_config(np, pctldev, &cfgs, &n_cfgs);
+	if (ret) {
+		dev_err(dev, "%pOF: could not parse node property\n", np);
+		return ret;
+	}
+
+	pin_conf = 0;
+	for (i = 0; i < n_cfgs; i++) {
+		param = pinconf_to_config_param(cfgs[i]);
+		ret = pinctrl_scmi_imx_map_pinconf_type(param, &mask, &shift);
+		if (ret) {
+			dev_err(dev, "Error map pinconf_type %d\n", ret);
+			return ret;
+		}
+
+		val = pinconf_to_config_argument(cfgs[i]);
+
+		pin_conf |= (val << shift) & mask;
+
+	}
+
+	reserve = n_pins * (1 + n_cfgs);
+
+	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps, num_maps,
+					reserve);
+	if (ret < 0)
+		goto free_cfgs;
+
+	of_property_for_each_u32(np, "pinmux", prop, p, pinmux_group) {
+		u32 pin_id, pin_func, daisy_id, daisy_val, daisy_valid;
+		const char *pin_name;
+
+		i = 0;
+		ncfg = IMX_SCMI_NUM_CFG;
+		pin_id = get_pin_no(pinmux_group);
+		pin_func = get_pin_func(pinmux_group);
+		daisy_id = get_pin_daisy_no(pinmux_group);
+		daisy_val = get_pin_daisy_val(pinmux_group);
+		cfg[i++] = pinconf_to_config_packed(IMX_SCMI_PIN_MUX, pin_func);
+		cfg[i++] = pinconf_to_config_packed(IMX_SCMI_PIN_CONFIG, pin_conf);
+
+		daisy_valid = get_pin_daisy_valid(pinmux_group);
+		if (daisy_valid) {
+			cfg[i++] = pinconf_to_config_packed(IMX_SCMI_PIN_DAISY_ID,
+							    daisy_id);
+			cfg[i++] = pinconf_to_config_packed(IMX_SCMI_PIN_DAISY_CFG,
+							    daisy_val);
+		} else {
+			ncfg -= 2;
+		}
+
+		pin_name = pin_get_name(pctldev, pin_id);
+
+		dev_dbg(dev, "pin: %s, pin_conf: 0x%x, daisy_id: %u, daisy_val: 0x%x\n",
+			pin_name, pin_conf, daisy_id, daisy_val);
+
+		ret = pinctrl_utils_add_map_configs(pctldev, map, reserved_maps,
+						    num_maps, pin_name,
+						    cfg, ncfg,
+						    PIN_MAP_TYPE_CONFIGS_PIN);
+		if (ret < 0)
+			goto free_cfgs;
+	};
+
+
+free_cfgs:
+	kfree(cfgs);
+	return ret;
+}
+
+static int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev,
+					   struct device_node *np_config,
+					   struct pinctrl_map **map,
+					   unsigned int *num_maps)
+
+{
+	unsigned int reserved_maps;
+	struct device_node *np;
+	int ret = 0;
+
+	reserved_maps = 0;
+	*map = NULL;
+	*num_maps = 0;
+
+	for_each_available_child_of_node(np_config, np) {
+		ret = pinctrl_scmi_imx_dt_group_node_to_map(pctldev, np, map,
+							    &reserved_maps,
+							    num_maps,
+							    np_config->name);
+		if (ret < 0) {
+			of_node_put(np);
+			break;
+		}
+	}
+
+	if (ret)
+		pinctrl_utils_free_map(pctldev, *map, *num_maps);
+
+	return ret;
+}
+
+static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name = pinctrl_generic_get_group_name,
+	.get_group_pins = pinctrl_generic_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_imx_func_set_mux(struct pinctrl_dev *pctldev,
+					 unsigned int selector, unsigned int group)
+{
+	/*
+	 * For i.MX SCMI PINCTRL , postpone the mux setting
+	 * until config is set as they can be set together
+	 * in one IPC call
+	 */
+	return 0;
+}
+
+static const struct pinmux_ops pinctrl_scmi_imx_pinmux_ops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux = pinctrl_scmi_imx_func_set_mux,
+};
+
+static int pinctrl_scmi_imx_pinconf_get(struct pinctrl_dev *pctldev,
+					unsigned int pin, unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	u32 mask, val, shift;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_scmi_imx_map_pinconf_type(config_type, &mask, &shift);
+	if (ret)
+		return ret;
+
+	ret = pmx->ops->settings_get_one(pmx->ph, pin, PIN_TYPE,
+					 IMX_SCMI_PIN_CONFIG, &val);
+	/* Convert SCMI error code to PINCTRL expected error code */
+	if (ret == -EOPNOTSUPP)
+		return -ENOTSUPP;
+	if (ret)
+		return ret;
+
+	config_value = (val & mask) >> shift;
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	dev_dbg(pmx->dev, "pin:%s, conf:0x%x, type: %d, val: %u",
+		pin_get_name(pctldev, pin), val, config_type, config_value);
+
+	return 0;
+}
+
+static int pinctrl_scmi_imx_pinconf_set(struct pinctrl_dev *pctldev,
+					unsigned int pin,
+					unsigned long *configs,
+					unsigned int num_configs)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	int ret;
+	int i;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	if (num_configs > SCMI_NUM_CONFIGS) {
+		dev_err(pmx->dev, "num_configs(%d) too large\n", num_configs);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_configs; i++) {
+		/* cast to avoid build warning */
+		p_config_type[i] =
+			(enum scmi_pinctrl_conf_type)pinconf_to_config_param(configs[i]);
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+
+		dev_err(pmx->dev, "pin: %u, type: %u, val: 0x%x\n",
+			pin, p_config_type[i], p_config_value[i]);
+	}
+
+	ret = pmx->ops->settings_conf(pmx->ph, pin, PIN_TYPE, num_configs,
+				      p_config_type,  p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error set config %d\n", ret);
+
+	return ret;
+}
+
+static const struct pinconf_ops pinctrl_scmi_imx_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = pinctrl_scmi_imx_pinconf_get,
+	.pin_config_set = pinctrl_scmi_imx_pinconf_set,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static int scmi_pinctrl_imx_parse_groups(struct device_node *np,
+					 struct imx_pin_group *grp,
+					 struct scmi_pinctrl_imx_info *info)
+{
+	const __be32 *p;
+	struct device *dev;
+	struct property *prop;
+	unsigned int *pins;
+	int i, npins;
+	u32 pinmux;
+
+	dev = info->dev;
+
+	dev_dbg(dev, "group: %pOFn\n", np);
+
+	/* Initialise group */
+	grp->data.name = np->name;
+
+	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
+	if (npins < 0) {
+		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
+			grp->data.name);
+		return -EINVAL;
+	}
+	if (!npins) {
+		dev_err(dev, "The group %s has no pins.\n", grp->data.name);
+		return -EINVAL;
+	}
+
+	grp->data.npins = npins;
+
+	pins = devm_kcalloc(info->dev, npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	i = 0;
+
+	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
+		pins[i] = get_pin_no(pinmux);
+		dev_dbg(info->dev, "pin reg: 0x%x", pins[i] * 4);
+		i++;
+	}
+
+	grp->data.pins = pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_imx_parse_functions(struct device_node *np,
+					    struct scmi_pinctrl *pmx,
+					    u32 index)
+{
+	struct device_node *child;
+	struct pinfunction *func;
+	struct imx_pin_group *grp;
+	const char **groups;
+	struct scmi_pinctrl_imx_info *info = pmx->priv;
+	u32 i = 0;
+	int ret = 0;
+
+	dev_dbg(info->dev, "parse function(%u): %pOFn\n", index, np);
+
+	func = &info->functions[index];
+
+	/* Initialise function */
+	func->name = np->name;
+	func->ngroups = of_get_child_count(np);
+	if (func->ngroups == 0) {
+		dev_err(info->dev, "no groups defined in %pOF\n", np);
+		return -EINVAL;
+	}
+
+	groups = devm_kcalloc(info->dev, func->ngroups, sizeof(*func->groups),
+			      GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child) {
+		groups[i] = child->name;
+		grp = &info->groups[info->grp_index++];
+		ret = scmi_pinctrl_imx_parse_groups(child, grp, info);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+		i++;
+	}
+
+	func->groups = groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_imx_probe_dt(struct scmi_device *sdev,
+				     struct scmi_pinctrl *pmx)
+{
+	int i, ret, nfuncs;
+	struct device_node *child;
+	struct scmi_pinctrl_imx_info *info = pmx->priv;
+	struct device_node *np = sdev->dev.of_node;
+
+	info->dev = &sdev->dev;
+
+	nfuncs = of_get_child_count(np);
+	if (nfuncs <= 0) {
+		dev_err(&sdev->dev, "no functions defined\n");
+		return -EINVAL;
+	}
+
+	info->nfunctions = nfuncs;
+	info->functions = devm_kcalloc(&sdev->dev, nfuncs,
+				       sizeof(*info->functions), GFP_KERNEL);
+	if (!info->functions)
+		return -ENOMEM;
+
+	info->ngroups = 0;
+	for_each_child_of_node(np, child)
+		info->ngroups += of_get_child_count(child);
+
+	info->groups = devm_kcalloc(&sdev->dev, info->ngroups,
+				    sizeof(*info->groups), GFP_KERNEL);
+	if (!info->groups)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_child_of_node(np, child) {
+		ret = scmi_pinctrl_imx_parse_functions(child, pmx, i++);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id scmi_pinctrl_imx_allowlist[] = {
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
+static int scmi_pinctrl_imx_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
+	const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+	if (!sdev->handle)
+		return -EINVAL;
+
+	if (!of_match_node(scmi_pinctrl_imx_allowlist, np))
+		return -ENODEV;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->priv = devm_kzalloc(dev, sizeof(struct scmi_pinctrl_imx_info),
+				 GFP_KERNEL);
+	if (!pmx->priv)
+		return -ENOMEM;
+
+	pmx->ph = ph;
+	pmx->ops = pinctrl_ops;
+
+	pmx->dev = dev;
+	pmx->pctl_desc.name = DRV_NAME;
+	pmx->pctl_desc.owner = THIS_MODULE;
+	pmx->pctl_desc.pctlops = &pinctrl_scmi_imx_pinctrl_ops;
+	pmx->pctl_desc.pmxops = &pinctrl_scmi_imx_pinmux_ops;
+	pmx->pctl_desc.confops = &pinctrl_scmi_imx_pinconf_ops;
+
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc);
+	if (ret)
+		return ret;
+
+	ret = scmi_pinctrl_imx_probe_dt(sdev, pmx);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-imx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_pinctrl_imx_driver = {
+	.name = DRV_NAME,
+	.probe = scmi_pinctrl_imx_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_imx_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX SCMI pin controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
index ae9e0be7c89e..c9a299241d7f 100644
--- a/drivers/pinctrl/pinctrl-scmi.h
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -22,6 +22,7 @@ struct scmi_pinctrl {
 	struct pinctrl_pin_desc *pins;
 	unsigned int nr_pins;
 	const struct scmi_pinctrl_proto_ops *ops;
+	void *priv;
 };
 
 int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx, struct pinctrl_desc *desc);

-- 
2.37.1


