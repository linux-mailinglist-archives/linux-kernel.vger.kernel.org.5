Return-Path: <linux-kernel+bounces-159127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112A8B29BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5E528523C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C4156246;
	Thu, 25 Apr 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SX6Afvcs"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B5155A3C;
	Thu, 25 Apr 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076708; cv=fail; b=Smrxxl5Xq2/cGB0/pwxkaZMqoVLmgYTsKWltoD5TJM3k2zkWlPQBLfT/Vo66sFSArFXlCakxas7AGzV8mK274E4qFPDkIYUb0bS0wEA+bWCYFNiBNpLgM9zoudMgW1apF459eMkPZFQw/o93CHgjmPtVt4qNi+S2rwgT9HhifjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076708; c=relaxed/simple;
	bh=KUsw0dhMkFj7qR53hs2zo3pJcSwNFRAfIdjGrecPBoA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fk89JZysHrUFIygzaFMU4MUcLV2hfjdP03rLM0NQ2fA6uNo40rDtqZemMzXWu28W7HcD8TCz6wja/ZsDKY6yJv+UfHbqXVxm0lF/sN5QfMkb6LXH3/Ku+YxXu+EZuBhN8d0v94nhSvpl/7yFSNcyJNzWgMYfDW+Yey6B2lGThLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SX6Afvcs; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf9JUlGKHKTOxs1m+5PK3DR01aWlwJX03PUoA3Cy2IhJU5H7n7CO4KcJ9D+WWvklXAj6SRO3K1CxkCmpaAC20YMfLpXe8656KBlpHAUVy38BH61wxWnFKk9c1Q1CW4Ku29JnOfJm9c8NOppeLANpsYtuxPwNDUt57PK4aaPVc2U80p/MWTXJnSu7GVu10w8LeAFWO3Q5fo2g2IupQlD3MUzy2WhsXIU4Dtu5g0AnmyOnRDxM59+8Egs6/maWyBM2Zb4SBqdp9+lwCI/TLGfdOdXNcJI4hGGTVLBBAKe98KAy1Fvlw4AITrK5qwJexzoJLndJt7Y3gGLvLaEYOg210w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw7HMSGRKHTkZ7ZB98kmLpuy/Xb3D48kuCuPxQsFlcg=;
 b=elRP/MxoLMyQuwgazdwDjXthMpvY/bidJmMIeOWh4Hl5TZx8KXsyBn2GvnlnSpUyBuDYdFx/uC9/A7TepSc22t2Qw6IO1iyIZvAgLf55N/iQ4RSAsG0Y7ZlgMUSYCQxASGvmsid4hMnl02HIKtM+OfJKkQE55m1iYtljHtfuTp29wrc1dSF1lsi2T0FZlGM5d0L7uhIkgf7w22hruZErnnAj5gOsKBMyxTfcylvqYTsfEX0FxmgMBlkKFEdTkbc+tCn+BVgPa9+6TPIc7Tts760GLJp9QXSDqF0ii73jJndZh7QsOgc6QWV5WRshNGa9qcR3Mtxzm4uF14dgf0nhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw7HMSGRKHTkZ7ZB98kmLpuy/Xb3D48kuCuPxQsFlcg=;
 b=SX6Afvcs31d9MfS2u8aMXz3sHIIEcLcjUQftX1rssVR6IA0Zudv5Mr41R2BELUfrdstoYZDAtyZQaQfKC2GvXZgXGM0op2eokKJKP/rvMx/idpysnzz6Z+rheafKoq5Bm97T4Vxx8qmtBU3xjM3lf98NLmDOTG3CrBYD1684+Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:41 -0400
Subject: [PATCH v4 05/10] arm64: dts: imx8qm-mek: add i2c0 and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-5-7fa6ab2fd64e@nxp.com>
References: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
In-Reply-To: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=1737;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KUsw0dhMkFj7qR53hs2zo3pJcSwNFRAfIdjGrecPBoA=;
 b=tckHOsj0m8Ns8mhmK2ycvKCnuyxGZsGhUkVNRw90zsM14+mFkf94WbdUKYiZh07awdsaEqqk0
 Lsv8Cal22uiAl/Io8TzbOkgfilcthiHwVXcjFzh7FoflBX2W+YsCeSU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf4fc80-bdf1-41d8-696d-08dc6565cb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2cxaG5aOERCUXlYZk8xWk5CYnBZOTJyUkZlL2xDNWtJbldib0hVT1dtam9X?=
 =?utf-8?B?eWZJV2Q4L1R1c205QXZvbXUwbUFwRkdFQnFUT2o1ZFNKQzZxeTBaYW9tR1U5?=
 =?utf-8?B?L2R2L2NlN3VtQWsvdVBCbnZrUW0rS1duNXJmVlBCbDg0d1ltRlIzU2t3YWI2?=
 =?utf-8?B?dVVubUdSTXBZa1BldXNhM2syeVhidzZZZmNTQi84M2t3KzVQcTZyYmVmMlhs?=
 =?utf-8?B?QUcwNU9SMllWTXZ3MTJPM3g4YVhGVCtKdkwwZE14Z1ZrMWpsdVNsUmFaMTBQ?=
 =?utf-8?B?bHdVdCs5N1ZJVmlZNVlsamlsVHB6T08yR00zMVZoVVRLemx0SHNBNEx6aUJi?=
 =?utf-8?B?Y1N6ZzUvQTlmN0VEaVdIK2dHaUtlSmZkcHBzRTQ4TTRKVFAyMWR4UkZUVEI4?=
 =?utf-8?B?KzZxUUFQQnNxM1daNnh3Y0J6V1ZGWG4vVEFqVzFUUHd4TlpwTjVGMlREYmtv?=
 =?utf-8?B?RmdsY25QMG1relJiMk5kcllQKzEvUk5EbUxXenhLS2d5TDUwVUp4UVdGdTho?=
 =?utf-8?B?S053aHJZeWdobmVxVitDZFdtdjA1bDFhWGdFd2tNdE9nR21hM2ptM3JNUkRC?=
 =?utf-8?B?UkEwUkRsZGdzVk9JNU5nLzJqbDNLbkhwTmJRK1BqVXdYQ3FIcWt0QUEwUGZw?=
 =?utf-8?B?V0hiN3N0dGlIZVJoUnp3S0FCMmpjZE9GVlYvM3daYTBoUlBCV056eDBsbkE4?=
 =?utf-8?B?Rm1yUkl2NzE0eVdybGg0U25oWlJsQS9nQXRCSHZpUjlMaUNRdmNJd1IvaVlP?=
 =?utf-8?B?VVZpTWlIMkUzbDdPbEZZS0c2SXhBelZoL05VVzhNdllXNG9peE5lWHFYT05r?=
 =?utf-8?B?VkJyTVkwZDZqMnU0SFN6b2JzMi9pMkEwWDdyNTFEL3B3ZVRYeUJMTXJxa3Mv?=
 =?utf-8?B?NStMK3hIRmY1UStLRUFCUUFKRGZnaEhMZlZOc0JGd1dLdDVrd3hQdHYrQ3Bv?=
 =?utf-8?B?bHV5NXoxaEhEdUV0OVNSbW82bm1HaFQ2dktFZlhxQnd3VW94QjB5d3dWdWFG?=
 =?utf-8?B?RUMzb2FOVjhNT0VGOCtXLzh2SldPQ3pGcXlqdEhjTjg5OSt2anFzcHpzYXNw?=
 =?utf-8?B?Wkpkd21FbklPWnEyMm9KNTM3NHJmc0UwT3psUGo4VFptVFVRUkpSOVFrS1Jm?=
 =?utf-8?B?UytKUEpzdGJ6MFVOV3B5QXNxR2tiMTJRVThtdHBFU1hIOGFtOGw2QTFRcldV?=
 =?utf-8?B?bHNERU5jRlBKSk5abzVlWUFBV2VYYmswY1dJcHlRc2gxWFdXaXQzUVlhOHkw?=
 =?utf-8?B?anhDSzQ4RFFzU2doN00vSGVWSkxYeE5hbDNibm9JNVVwMGY2QTRNanYyMXVB?=
 =?utf-8?B?b1FZS1NTN3A2OURKeFBwWjZveWVGczJEc1ZuWjV1ek5uWFN6dXJkZ1hSWmVH?=
 =?utf-8?B?aXE1QmpPWGdHQzNKVS82b0d2Y251cGJmam11M3pSUUVQeVBuRU1xMnFQRGxv?=
 =?utf-8?B?aWtZak1RRTBtcFliajA3S1RqVFdCOXNpZHQ0bTQ4c2NhTGx1eFMxeGhKMEVN?=
 =?utf-8?B?eFJYTWhlQVN0cnhPaVVXcWFtOWo3a0pTdFdldlltdWtSdnNBQk9nVk0wd1p5?=
 =?utf-8?B?RmRjS0VnYjQ2bW1hTWFUaHZaZ3pMck9veENoZkZWNDlWNDhuMnVtaHpiNVo3?=
 =?utf-8?B?cDJ5ZUY5bHgvWkdVYW96MmZPSjc4NFZVSHFGYmhVbEY3bFdjZEFTTHNPZ0Zu?=
 =?utf-8?B?SndVUzlzMW5xd25FT2hUU1BCWlZ3WWNxMkZUNndUcjlsSE5YY2pCN1NxYnM0?=
 =?utf-8?B?YUhKcmM3NjFDSm92UWQ2cm1LcE01SVh5R3FSK0tQeDdobkQ0UjFUQmNyZnJW?=
 =?utf-8?B?MGY2cjlVVlVQamEweVQ1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K29TRkZwa1drVjRTbEV6Zjhyd1lxMnF2U1NMbkh4Q0tONXMzVjdFR3Rzakh1?=
 =?utf-8?B?MzY3a1dmd25BV25Na2M2ZE5ZV0p5ZlJmVHlKRW1Dck11aGpxM05Ta1RBK2J1?=
 =?utf-8?B?K29iY1NMaUMxMTFnTWZ3M1BnNjN1N2hUSGFLZlcvK1I4cU00OU9sMUVMbXcy?=
 =?utf-8?B?UXJla2hjaU5vVTlFQk1nWGx0UythZWkvaUFrWW9aa2MrVTI4TnA4UXV2MUdF?=
 =?utf-8?B?ODJmQVBXeWtjcFg3eVJqVWxZVGxxRlpkdHYzQ3NWVkRDamJSNFNuQmh1U3Zt?=
 =?utf-8?B?RktGNW5ibUNGd3BiMmNyMUdjWEE0bkVFOFV2a2Q3WndrRVVOSUk5RUxHZ2lN?=
 =?utf-8?B?ajhvWWVLazQ4ZG9ETithSVdXNTRDWWtyTGFMNW9LZHRHYzYvb3BaUVJnczhS?=
 =?utf-8?B?UVJTWUplamJ1TTRtNGIyZ0ZVK1JwdzIva1lMbmVVdzI1ZEhmTzJBYVdxSzVj?=
 =?utf-8?B?T3dKNEc1b0VsMG55UEdzMFc1YUxnbXlZNUFxanVxZjFZejRqMjRneWk3Y0dm?=
 =?utf-8?B?eUZ3d2d0TEpZampoVThzOGM5ZTdKS3dLSk9YRjh4ci9LYkhZUUhSM1NQbHU2?=
 =?utf-8?B?RkVJcG83SUpCUmNicUV3bkdVSGJTOFMwdTF3amhyUGd4TGhnOEswKzkxZ3Zy?=
 =?utf-8?B?blA3b2NDaHRPWTlQMkk5ZDJYMVl3R1QzUkZMRU9ycmFiZkVZMm03TUl2eERX?=
 =?utf-8?B?ZEROcE5LVm04aVBNdmY1Vms4bXNTRERxdXN4cGJ1cFBhTnVuZ0s0WXJ3Q3Bz?=
 =?utf-8?B?eCtTQ1hZWlNScS9NUVZkZXM0UG1kOVVUVTFnMkRTZWFKNnpzWm5jbGxMSWhy?=
 =?utf-8?B?aEpHVVV1OUNzNnFENFJuNTY2Mm45U2NtOWxpY21KZFk5Vy9xb21hdkVLb3Nv?=
 =?utf-8?B?REZBSzh6dk1tRzZTREJwTHViSTF6SFI5d2hFNzlGblJIL2NLZXhWVjRNYStE?=
 =?utf-8?B?TG5nWnVPYjV5R3RPbnNZQXRvOUhDOTY0WEZzaXEzckNwLzVTTVFrM1VLUWFa?=
 =?utf-8?B?YS96MWw0eHVnSDFQMVFPaWw5VWxFUXNoVWhobzZlTWYxRW9VbWxGRy9VeXV5?=
 =?utf-8?B?bUlldVEyZXVQS2hYZjlVcEVEUkowYXo0VTZlUngxNjJhWkUyL1VlTGVIK1l0?=
 =?utf-8?B?MmprdGI5VzNIREVzdStCMzRLRWczSlNUbVBwbjROV0d3c3dvdm5vWXIyTmEv?=
 =?utf-8?B?UGtOWVZaUHcvYkFnS0lFdlJkb0dDT2p0WmFvZk5yY3VsRStEN2x0S3g0K2hj?=
 =?utf-8?B?YUVmcmxKS0xBWE1GVVhjaVk4R3pzcUxOcC92aTdIeDN6YVlQYWtoQjNzMHFZ?=
 =?utf-8?B?SGNneUgySk5sUVZaRnZXcEJ1QUl5MXBYSWp1MGFjL3lrZnNNRE1LZUcrR3Vj?=
 =?utf-8?B?YkFQVDhRVGNLTTVWVDhMQVB6eFY4UUt6RlZMcWlWOHFEczgzd1ZQeDJyTGRm?=
 =?utf-8?B?UmNOYmRGMS83MjdUTVVGa2EvamozNEd6S2RWcXdyTEhYbDdvR2lJbC9TS1lE?=
 =?utf-8?B?clBGUGV3bU9TZzBXU20vSEw0MGJuVnpIcnFTMEVEM0lKaUNseVlkZUlhNmFN?=
 =?utf-8?B?UDhlOE1NUHZyK05RRU81MkhmYzVISTlxUTQwa0FuQlZkK0NWRjY1cVplbUdQ?=
 =?utf-8?B?Y0RXWVQ5ZEJNampXRUNCd1d1WGdmM0pURkhZUThYZkxESm9ibUhabWhmTTRj?=
 =?utf-8?B?UVN2QkczbzZxMEZ2Vkw0R0F3aHlUaWxMWjhRbmMyU0V3MlUwa0Z2dmhUMmlK?=
 =?utf-8?B?MW15cE9GaEdZSkF4dmFsWHltMlFSbFNIWUZVbFU5R2hSeTI1amZrNDlsaXBS?=
 =?utf-8?B?dWZyUXJ5Wk4rQ0tic0tFaTZsZFUwYjBUUC9zSFFQZ3BKMkxCeTV1VUdBY2RY?=
 =?utf-8?B?cjFYcmNJMSsyMnByTXFXb1ZUMit3WG0yYTlhWVY5TE5ZSEUrbklLZ1hGbUhz?=
 =?utf-8?B?Qi9nR0ZJZmM1c1pYa2llRHBFbmVCVnNISjl3bng2eHh6OVl6VmtoditzR2lj?=
 =?utf-8?B?QUlWdTBMandsMDZBNmtzTUFVK04wY2wzUC9zVERvamt1d3ZySnB3UFY5bStL?=
 =?utf-8?B?L1p5cUpLUmZ0YWxyM0RlTXpGN2RqbExJcUdBTHZBaXpGcEdWNWhKK29Ta0FQ?=
 =?utf-8?Q?iIjYVDKTM2t4DiT1OtrRfLVwr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf4fc80-bdf1-41d8-696d-08dc6565cb39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:05.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w+CzfWtcPSytb6lofWYrtMW7uBetsAcT1WIVBoKVcP1zFNPWcISQYxMUJe1pivwmvR2rzdvgcWOSodd80tOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add i2c0 and all devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 6bdda248179f9..dd9dd3cb7d47c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -104,6 +104,49 @@ &asrc0 {
 	status = "okay";
 };
 
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	accelerometer@19 {
+		compatible = "st,lsm303agr-accel";
+		reg = <0x19>;
+	};
+
+	gyrometer@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+	};
+
+	light-sensor@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <11 2>;
+	};
+
+	pressure-sensor@60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gyrometer@69 {
+		compatible = "st,l3g4200d-gyro";
+		reg = <0x69>;
+	};
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -282,6 +325,13 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
 		>;
 	};
 
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL			0x06000021
+			IMX8QM_HDMI_TX0_TS_SDA_DMA_I2C0_SDA			0x06000021
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c

-- 
2.34.1


