Return-Path: <linux-kernel+bounces-39570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EC83D2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E028F1F25647
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98CBAD4B;
	Fri, 26 Jan 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FEvW9NgR"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A258F44;
	Fri, 26 Jan 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706240188; cv=fail; b=N+b6oiidXhpOie4eR5kuKivX+kRmfEnNR26T5P4sR6kzs89pIj5CeniCUKueJXxH1EbFDxSbLiK3K3TEVupnTfwwFXktFBNFCuFQDq+k8REWIBJqNRy5+5xP8zDcN3QCpfl5sMqF8LyL/SK4eRMgv3981uMKMjM5OuK0dzkzch0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706240188; c=relaxed/simple;
	bh=AByXffH+JJqibPkmzGM3H1G+uy0WP8USylDq+TeNUQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvoTo6gaGv0Ftrvqf8xcMD3rPt9UJcTorqX3JU5vXOtBGet+ffb9mJAkih5v75dBiOOSEEkC3X+99/keLUrxEPQvlkMu/AOmz80/j2DGZEXXPPS2zEJLpJuMcOFlx0lbxAlxpfu5rds0u28wIIhkEZiJx1g3xB7PkSvOUXJejRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FEvW9NgR; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYoeVetwov5HI6FLKs9uJ+/kJgOkWP9Lz2UJXnhrM0lQlF9UI6Nt1aRHtCchZwUfUjL8BsCKHZoVvRv75R6rVhIHri8wscuWtE9/AA3XwK6hOcmiKkZigrmgrnafWwO4vBBRYOeey9r9eRVmrXYp6Cq5SuVuucvAJaOQFCL7Trd3JcysoFNFVkBG69Jm6DxqEABjRXLU90HLVDi1WzXRr9vsn/J6LRbycoj3AbRJbT9THl7Rm4d6/fjEvI/q76Dm4ZAjyxJE/uE8XbxRZfnus/yREeCEZFmf+dvr/qkegafv3g2p4dJPNTNZS15IAVf8TF9Oy4FbfSsEX2R8iBBEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hD0cThubNaqubj5bXEmLhzuTDMHE4C0Cx6s2iSLeoI=;
 b=ct6LgtFwWXGjcQ1F7R0FkxS7Nww9XsQtlbsNBGM0gJyhWC8qeB9PbgVliQQRLx61KQ8b3x4kegkP9diTR/rObJaVL7SS2B4XV04JiP37l8OaqxkteCUV1FaJFBrvJkzEOgmUGU5eFWdsFeTYa05Uquq7g+NGeTs9r1qVtzwwKio7r+qbAuZ1o3/O4ZaWEpyJMGxdJJRUA1Gn1j3euhIcgE/Oxpn6x885kart5jgjm+nwqEDXdbixbPbRtXIlcURoJWyH/5jTqmQxomg8i8qdSr1nJ1L/8gWSqFuuGWbADCfTy2K8sY6B1VPVMVV5PrAhJ8CcRiBaNHd98vcvJX5eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hD0cThubNaqubj5bXEmLhzuTDMHE4C0Cx6s2iSLeoI=;
 b=FEvW9NgRGt7xidGeG2svgJe250O0Z0fM/j+QbXPiYaJmwHiskrXAt7c+lC8Gw9vnPl74JhUZbAUB7yXmKLaoLjPj4qtsQS+pxr6ssUcOxzFURhJAL+SqJNp65nDFZx8a3GEEvO32rPJ7Hxj34bnUvzCz8WAyxs2IqfOoeiTEwE0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 03:36:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 03:36:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Martin Kaiser <martin@kaiser.cx>, Shawn Guo <shawnguo@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: Andrew Lunn <andrew@lunn.ch>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/4] gpio: vf610: allow disabling the vf610 driver
Thread-Topic: [PATCH v4 0/4] gpio: vf610: allow disabling the vf610 driver
Thread-Index: AQHaTwg1N1Zs40MLSkWNnYKumsdodrDrc4Hw
Date: Fri, 26 Jan 2024 03:36:22 +0000
Message-ID:
 <DU0PR04MB9417CAFF57ADB1CDD468D6E488792@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240124205900.14791-1-martin@kaiser.cx>
In-Reply-To: <20240124205900.14791-1-martin@kaiser.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7287:EE_
x-ms-office365-filtering-correlation-id: 4d75e83b-7ba2-43e8-be93-08dc1e1ff763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uln3GAKhlKQAKAABJH/4uqc1Tct2dosZuBFsYPOYmENE3DlEbV0Mh91w/fT89eJfWXfqH+xaNsyoTQcjxd7Il7lnIJLT1rMkDoWeto7epIa9mqN4O6fArbNcw3RbdQrRizE1PThW3PJN8Qrssp+qX7wmyk20NCPhSC8SbmRV+PUtJCJC5iEU/j9n+vu6hwBtNrcFfW4QSOV0UBjHAWPsCp66k5082GYDPsjbSdcasQVExIVS6Gq0g+GBvl7w6Q3di6yxZdzXNPN25hZboFBKbSEMGeVO8OFd9YzbntSj2LKPzauPkXn/1JDr7vU5/9wI6NJrGXV2S09jn+T6Y/K3zy74Q8biYsJAzjWVKm89QCOATft7tV992FiR07vW9nLYx+9gg4Pw9YUJ/sSDlJT0NjCqhZ9FpgYDONNtj4dUI+DalayixmEL489MCs2RN1ljQpJImJvy66UK/r47NaLr+N6mLtIZcum59S47ECH3TiHb5+7JPl1LHinNWAvxAp+9d4SJazRa3NjIxLmaVse1nqo5XpOBWQ9reAlDHsSiAZjOQzwgsyr+cZ4A4KCwqKk35Qa5Dpmq9jhPi3ZUrn1rRE6v2BTdwfntUwZmJQJRyoaGsagrdrfXkEwqIsNCUiWK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(2906002)(4744005)(122000001)(52536014)(5660300002)(44832011)(41300700001)(38070700009)(86362001)(33656002)(478600001)(26005)(71200400001)(7696005)(9686003)(6506007)(8936002)(8676002)(76116006)(83380400001)(54906003)(66446008)(64756008)(66946007)(66556008)(66476007)(316002)(110136005)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ks40Q/76sTR8BtIyPpI82fBqbDTwJGFF/0VQJqm/f1325J/3gKeHlA2hpn0Z?=
 =?us-ascii?Q?3m0J15H84BONBh53bf2/qAe6JU320e6MHiEJ89mJsysAiteGCH3rJCOlkqEr?=
 =?us-ascii?Q?XHvviWeSeq/uAHFUQQO9x0Yn99Pz2hmuzSa7tF5VrkwuhtSl6Vx5lEm4pHbu?=
 =?us-ascii?Q?7m+Ns2vdCTgZJSeBIiF696CkliX6xCC/oR3BVIlN37soYpDnEeU3liYU358r?=
 =?us-ascii?Q?hyKs1bx1lv08QYHRJ/jSrRofdfLimDud4N8qbfSoj+6OMUt1MGawrclst2Tt?=
 =?us-ascii?Q?DZkZWwzX9WlQ8Eqg0yc9cWjU8DRghzJfbHqYp6Xi+gbQTfI9ZfIHksMmn9NP?=
 =?us-ascii?Q?OwhgGbZN9uSxG8FNfa5UxYuELsJ2GB3m577M/2P1ny8uREojAU/ZebnWr2RN?=
 =?us-ascii?Q?zbFoEVaeNmqKqlcJYjGWKp+pzD8c2Mq4uYQX2Qxv/Y2dnJBFtjj37JK+i1kH?=
 =?us-ascii?Q?TYll5RyddykZ1oqxxcgAQib2h8CaHFzUa1yQ+Th88fKgCymxraIXesK0lhh6?=
 =?us-ascii?Q?2+FsPTsDvj7Ck7ZUdLO7v5b7V7KEagKKDQpFnHyB96kSFrhzAIFn7+IKFgb7?=
 =?us-ascii?Q?fyimhnzDb3J9/wrN9xiSADvhiM48mY9A8KVE+ciSHkam8zugFz2mgrYIYWKp?=
 =?us-ascii?Q?p990/dhHUOgcoYjsIepTi1airDRuWuTCql8xtgkYC4sA6o0cJjyXPqELvTIc?=
 =?us-ascii?Q?goRXkA5pn2lLI5kxP8T8JHkSyevA6kaN5kMdzRbnVmM1oxG3p6r4lhTZnO/M?=
 =?us-ascii?Q?2HyLB+B+26A8uNZNlpmMnYT+f1yLHL5dnmZnTCPGIxw5vQUfaTwfJBTlPq8K?=
 =?us-ascii?Q?9G/8z4OlGAAx3lYjxBh8bKgILsK56s5H9yBSm83Gd2Juj4DYAQYxtdXfEZtz?=
 =?us-ascii?Q?kKUC8VYJPwVMBk4O5q2mycBz65TsdIfP+CteKRwGGj3+G883RE5uaQdQ84A8?=
 =?us-ascii?Q?enJ7sDv/xV+tqfaZ9vvTwJo0/ihYtW3jlm/whAWhFb0nhBhTFRhGhbf9VE3E?=
 =?us-ascii?Q?k7Bs8EO5qJ9iCNzOJcYCncUC0wJ0FTBY3eNxyKxj4ABqeSPc4k+1jKJVk6lm?=
 =?us-ascii?Q?CYKYK+EE80H+0RK1jr0l/QDbPRvETwRHrQhLeEpZULEiCVOI4/c0sQtyUMbA?=
 =?us-ascii?Q?zo86lGdfAg929AeMeiUpf4Cc3yxnt1uZ+zauE9nQNVUf1oXp79ItHxbb8fjE?=
 =?us-ascii?Q?gM5k4fMGGCIOk4+koPYNgopmI8KyCpnk5ORImNcfhShRdI/+G9rxCepzk22o?=
 =?us-ascii?Q?8lQ1TPqXVxoq0kPFYPKTFsc3Wj66Xm0vurPkw0W5EPM64QTTwgg4d5GLpl3m?=
 =?us-ascii?Q?2aTe0JtiqdvTSRqurZKZo2XKs5hCiJ+JTghfjLVfy10T3CddLeHKDh46+Qcu?=
 =?us-ascii?Q?8ZXwNV9LL6uzdT2LXBobpduPvgPlX0BPLKgEJfqvIMdRIXCnjtk/tmBWyBfq?=
 =?us-ascii?Q?UJWh3dzU7kIB0I4M5NUIUz+UIik4GRDSwAvIKJDfF7hHDNfi7Brc8SBLRDMy?=
 =?us-ascii?Q?9nyBnTCyzG7MymHwqfj4MEHAMWRAHqZnV51h4J/5Pf3EodiJoiC6p5KADSxB?=
 =?us-ascii?Q?a/hAimp37Pj/kgt8MSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d75e83b-7ba2-43e8-be93-08dc1e1ff763
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:36:22.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NTL8i1NVRUga8bGuDISDNkl9my37TF5eIFStnd1a+PmAMxPnLvkRuky7IaKLIXMB2raDTcAYn5LDwDj0rs5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

> Subject: [PATCH v4 0/4] gpio: vf610: allow disabling the vf610 driver
>=20
> The vf610 gpio driver is enabled by default for all i.MX machines, withou=
t any
> option to disable it in a board-specific config file.
>=20
> Change gpio's Kconfig to allow disabling this driver. Disable it by defau=
lt
> unless we have a vf610 soc. Enable it in the defconfigs for the i.MX chip=
s that
> need it.
>=20
> While at it, enable COMPILE_TEST for the vf610 gpio driver.
>=20
> Martin Kaiser (4):
>   gpio: vf610: allow disabling the vf610 driver
>   gpio: vf610: enable COMPILE_TEST
>   ARM: imx_v6_v7_defconfig: enable the vf610 gpio driver
>   arm64: defconfig: enable the vf610 gpio driver

Reviewed-by: Peng Fan <peng.fan@nxp.com>
>=20
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  arch/arm64/configs/defconfig         | 1 +
>  drivers/gpio/Kconfig                 | 5 +++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> --
> 2.39.2


