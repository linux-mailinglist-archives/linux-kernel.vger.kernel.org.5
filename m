Return-Path: <linux-kernel+bounces-92972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E648728D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA951F24130
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042A12AAE3;
	Tue,  5 Mar 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/e6h0dm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097F128829;
	Tue,  5 Mar 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671217; cv=fail; b=fUYr0vSaO4ZLN6iAtFUWxFYLYVHCDhO1H75blWwUfvzjWdTfZZ7zZFhKrcGp/FF06drrGbpe+zbtGSZhh3xVsH/aTgrrkxq95XXmFSvIGV7wWjFEroWfA1E0ZFl+RA9Qwld5IVA/i0F57TVheAHuJuJldjEZtWgJEdsg9bNzUmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671217; c=relaxed/simple;
	bh=VZDKn5U2eJ7Q1Q+L28rmGStZLZsnFhTUv/MyqDp237g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ba7Rtsp+4TYx0KjSx+IO0wXwBg1skYD5Pik/M0q6cr2/bdRU3R7XxjsYuxVZi5Ako459/0Fmm1xG9J1QPWl8vt3v0GCo3dRoMgYrk0xJQpMoHqK+2nYFwtXKjIBYlkblQmPWqMvNXKVzmKMKXg22lo+BaW9Y41pA2WYp+fBT6OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/e6h0dm; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWAHcHTbu7fbUm+8aNCA7Ep4yy3MzO8ppFqqfX73kTOMpxSYBhwtwbHi95jCFr0i33SbvQcZvd0Wr1XbGB3dyoFyRAFDRZbJ4E6Q8nUCdaFgfYMJLfPsZeGWxNWT5dDNTMhfT/T+G6DzCSAEGNbybrxfB0z4aysj7D8kLB6Ci0SChe8o8wQdKmXZT50i7MNXaOoycD5AzKAMB89SBwG4e9kzRq5hwnWWcKZJAjruDZCRRaF7wbr+ujRvABjWS81eP0Y4STWAEOPNMHI2L71qSCr/n3sbLIjKkyQqHZ3sDfFD6uVKFyddTxUJHiqbX6r78+Hvocc0dEWLSG2sdw99ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP6vWPQk/SfqfcyYTesfOpWmp8gSYQX80UDrCXBT5iU=;
 b=Gw47zR6SdEc0XXWdtpgTEYap49pCYsNaJIpIawbqOmC3qgspvqfDrInXdtWyxG+8zuz2UwvI9efVaaZQc4xXTnh0D5eBFJmBy0SbqGE4X7uaj9fPymbmlMGU2TrndQKq87mCF4BnnpxZfGiHS3XOtpuIzik7HqI49raCKSIZoZnigruBOTmFsjXUxqFFNb9ivpbV+w5MID/rWIc9llbrkbvqREJgIxbAswbmryXiQfeaVz474TFxUg9TKN7KuA+FXcHwbETPTerdMGhQ7N7IVY4tcIoETgHVZGpD9NBbTmZg+ZsWaCGJmlwQX/4MQKOGENFCtJ/YkEUr1fM+NEdgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP6vWPQk/SfqfcyYTesfOpWmp8gSYQX80UDrCXBT5iU=;
 b=e/e6h0dmnJeqOiu3AKN64BLI7ma39f7wnkBrOKL5DBrE+539yZaqsOMWONfpRXonFXMDf59l/pbC66nH9faOZcUI6Lh097d0oKYp7wbCBw0z08gS/yMfXT8ys1XJ1q5946RPiN/MdR/3BaHnQoCiiPFW0ebdYnDzSSaNbu2UAX7gP3SH0FOKK7dFN5UyaeASijlrVK+x8u4qY50j+fRBljo+jfBmIT7Sh0prW1e+wAaVuMFNIN3LKkZUgwMCdP1nXnKc/CZEnUH8CiEWfPv+zyVXIrxUJ58onm5Rk0LRiDp8SemR8I0mzhw8J3DwCQgjKzyQIr4F92+MIvUnmhAWaQ==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 20:40:12 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::4578:4ad4:b52f:3b0]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::4578:4ad4:b52f:3b0%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 20:40:12 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Asmaa Mnebhi
	<asmaa@nvidia.com>
Subject: RE: [PATCH net-next v1] mlxbf_gige: add support to display pause
 frame counters
Thread-Topic: [PATCH net-next v1] mlxbf_gige: add support to display pause
 frame counters
Thread-Index: AQHabxB4RB2Az1LWjUel7zzqlypQjLEpeXOAgAAiepA=
Date: Tue, 5 Mar 2024 20:40:11 +0000
Message-ID:
 <DM6PR12MB553455E2ABC9C8FFE2D324B1C7222@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20240305151851.533-1-davthompson@nvidia.com>
 <20240305103443.70e1f619@kernel.org>
In-Reply-To: <20240305103443.70e1f619@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|PH8PR12MB7301:EE_
x-ms-office365-filtering-correlation-id: f6f73830-dc20-4a24-ad79-08dc3d547474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dieciJlvJP6vxlEeitzo1g06ioMFRpeN+6HpesT6hg8hY9CMfx4vWuxYn4uJJ1EpvUdrZ9/8Vjj8W1JDOEu+JjyJuMJLrcXrXoEbrNIB+u0zimPNnwxCDzRvd5lrU10VsaUVdoGlzNVLgB+PGTozBtEEKtDETs0PT/r7SCUu48FhDkwN49WC1Eal/puPEzCW9fkQKzebvUoyq/VZrTA13lV5M1wq7dzcFH4TsF16aPWGsG3NQyqJxNHt+J8srILGcgmJeGDIvFoXtdlGDKFCYSw6AH6IWNZP1BNAP1HI0x8x8KS1u1Dn3XV7mj0FxIjibE3lJe2YauZmDRgKuXs/cXIOFIklfVo2M0Xfhy4mjTrKyUJAfuZ5XUVxo8GrPTkgU3Pe/bLq2jq4EmIAlrJgkyTjB5fiugdEhKbeon3pouKuRke9CgIGYQVyayrvPVCDSaUbm/sHdX52WvZB96czYJQiMxZ3AVoBh/X5aRbXsg3Z0iDj9GOQo8BJPWc00dfogIHxT5DtBg7mda+sxB+xn0YGoZjvcTpyXnmUFUgnf1n5xDVBxhlUM9lcpDmqFxlR6XNi/QjQYVr8YzcqcoxAa3hOB52qdPX/+++fG7hUR3w4ExJdOO66ao1wsLFadgXA47eiG6Ks6drMCQLW2/2amTIzbCQN3Lw5r3rBqltNF2XMpmsbAfbQp3unWu+0YsF2mvJ7ADPn3TnCpARK7fwlew==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SOYEP7cp0cT/v2YsvKB8+Yk/WLRV7ZomeW+3lb9QQjg5I2gTOiS3MbEaCaDv?=
 =?us-ascii?Q?za7Wdy3RDoJcD4MtDzld6J0sAcawvt18NGD1wQxo4Lipg9t8I5mLWAopLiM0?=
 =?us-ascii?Q?5boRSRhDW9xgNo1+J/11BsGLwdFbchpaL23v2URvk+ALh757laCGZ66Vxfth?=
 =?us-ascii?Q?UZRX5Ib3DppwvAmuVinCFATInlV+UX7I9VYV1ew7+roIJREDhyqILDCG6UW5?=
 =?us-ascii?Q?shHDVkBMJhIJYCF5xLJ8w8tg00qAFXsFg5CQKyT5qcXrLHZooS9SnWd66GOr?=
 =?us-ascii?Q?xetNzmwb+/+sHiPROu9ULLLajEQO8G/XGJECKbrL8t63d9ftmUbqeIDa8uYC?=
 =?us-ascii?Q?L+m7EJAmNmirLGPWE0fdUgs8jFFGlVF1CvuKcP+Lz0uaNSQ/miUxAah+uDKr?=
 =?us-ascii?Q?LajaqITcp9GRl1/y2sfTf+eUBCQyNFQxy3TRjsvTBPJnotRyJWM3EiGv88dw?=
 =?us-ascii?Q?AiAsptATgWUhhe78CouUlsCbZYQFdLzGJeTejdHANir+dOMnAQLFgqQW9BRl?=
 =?us-ascii?Q?XVJp8MEEJ0t1PdGFPehpqc5c1LeJA3lMfyJUBzoxAh92R5fIdfV2kJJetpJv?=
 =?us-ascii?Q?56Ty8ygrjJGg+CimkKSOVYKROXYK/jArgls8KDRmz+oVt9GAOj9/4JO5Ya6w?=
 =?us-ascii?Q?lqm2VyNJwbz5EZwddgnjALsOoJjk3R8ME2D6SGSZXbBSTw0fTPGGF+G+jCaq?=
 =?us-ascii?Q?4nF3/ZpHZ3PMCRPal2ZgULmlbNkl7fvGtUyfN0eLtNAGWB/qCahVZooYTDxV?=
 =?us-ascii?Q?uTF4qfsKwBElbVrXHdBZHwHipuimnxijNS30OTLOc3kNn/5bR4LxdX3mBN9w?=
 =?us-ascii?Q?yYNZ0VpFmdYxPgA1GTOdst/hd4fQRF2CVwl3TIzdYG9xdwIPhcG82SBWvE9T?=
 =?us-ascii?Q?kA9YZldpRotyH4z1cexelAVVyLwTjoQ843kA6FX1olH69LcFjRT4hHVOcwG4?=
 =?us-ascii?Q?RA6Yur46GYG62Cxr7uvJ0BG9UCZNT2j2k2tgWvFq+ydqGKaDnpk5TX2OuJIf?=
 =?us-ascii?Q?T7Jjpg0nHL1Uxxutt4pTuIsZY7+8FRbJKe9bOcTqhXQYAHjml+VBXq6TWLE8?=
 =?us-ascii?Q?oJGChP0IEetfE1COxrVwAsNVBO4b/jyV44KuoWAQeEnZPx26cywevMSNWcm5?=
 =?us-ascii?Q?fIHCbU+ckT1ujK7K2DvJhhAuYFxhEW9bDntic0gqrJlrPoAqVs2Ag6l7e0RV?=
 =?us-ascii?Q?VKI3W8DHt05vOiOLqtR2vTB+7WGpOZNzQ7RWRh3ScgBKCUknFq3dCs1LiUfl?=
 =?us-ascii?Q?JpfbO2NGifvbzwmUNh18x4e/JuLW2xeEQAcxRaDEpeOQoRhf6d8ATSG89rEy?=
 =?us-ascii?Q?aCqfjAUMvShFlyXE7lB9tDLcY19lzD0KX8jSAd40R9zjVZow9W/3GXLrb/mQ?=
 =?us-ascii?Q?kftp8b32oLH9124gUOFhUdDIgHuC1Gtg8mcjFOZGPzANAeF72sYzJXf5Scu3?=
 =?us-ascii?Q?AraNYIRorej7E/7OYr6o15ByI/ANmveUqbOYG9cVcGwjYudCHc5yP/MT5QLT?=
 =?us-ascii?Q?xclozhYra5uVkDv5U3Ipma8yGJzm4XdgVn4Z4FMs1+PNMrWw7g2mZtPpKkfY?=
 =?us-ascii?Q?aZOeyMTw0dvJnQBiad2YiWaqSN/Q9y0StRlm/mlzW0w3DEKxUpA0XdXDVBtF?=
 =?us-ascii?Q?BmSJzqEVYLihEPH/xezp9wyTKlUMnqOpY1dqwAslDnaX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f73830-dc20-4a24-ad79-08dc3d547474
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 20:40:12.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDGzi5Z9wlrY8jiqHliBmVManFkAJmz3eHfgxO8DFPaPcmZXMoWYXowdV38sirz9kuC7OgRIcnau1ZZc1vKcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, March 5, 2024 1:35 PM
> To: David Thompson <davthompson@nvidia.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Asmaa Mnebhi
> <asmaa@nvidia.com>
> Subject: Re: [PATCH net-next v1] mlxbf_gige: add support to display pause=
 frame
> counters
>=20
> On Tue, 5 Mar 2024 10:18:51 -0500 David Thompson wrote:
> > +	/* Read LLU counters only if they are enabled */
> > +	if (mlxbf_gige_llu_counters_enabled(priv)) {
> > +		data_lo =3D readl(priv->llu_base +
> MLXBF_GIGE_TX_PAUSE_CNT_LO);
> > +		data_hi =3D readl(priv->llu_base +
> MLXBF_GIGE_TX_PAUSE_CNT_HI);
> > +		pause_stats->tx_pause_frames =3D (data_hi << 32) | data_lo;
> > +
> > +		data_lo =3D readl(priv->llu_base +
> MLXBF_GIGE_RX_PAUSE_CNT_LO);
> > +		data_hi =3D readl(priv->llu_base +
> MLXBF_GIGE_RX_PAUSE_CNT_HI);
> > +		pause_stats->rx_pause_frames =3D (data_hi << 32) | data_lo;
> > +	} else {
> > +		pause_stats->tx_pause_frames =3D 0;
> > +		pause_stats->rx_pause_frames =3D 0;
>=20
> Counters are not enabled, meaning we don't know how many frames were sent=
?
> Or pause frames are not enabled, therefore we know it's 0?
>=20
> If the latter we should add a comment clarifying that, if the former:
>=20
>  * @get_pause_stats: Report pause frame statistics. Drivers must not zero
>  *	statistics which they don't report. The stats structure is initialized
>  *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
> --
> pw-bot: cr

Hi Jakub, thank you for your comments.

In this case it's the former, so pause frames are enabled we just don't kno=
w how
many are sent or received.  I will update the driver patch accordingly and =
send v2.

Regards, Dave

