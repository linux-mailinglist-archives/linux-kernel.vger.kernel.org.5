Return-Path: <linux-kernel+bounces-33138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C4836514
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03E11C23C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157853D553;
	Mon, 22 Jan 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Shkjcaw4"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF793D968;
	Mon, 22 Jan 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932384; cv=fail; b=q6R6Iz9CfZmN9W5ByMrmVzKejbRgbBUEpzKqyhcjvNvUTvZRqoHphIpiLoDs3ZzL7Tq4lpLaUiKPMlgzOZyFcseOrmMmLeYYZV72pSqWrkTsuCZr8vaFoYfKXcFqaCmmz7Xm7VMQ1p6txw/CwbskXjF1D7QCQaPeuR4mfiNGsUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932384; c=relaxed/simple;
	bh=pznIJUEc+25xwZAlv/HAs24N4UPB8NrJ1lAJZMb1Nyw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RRmo5mBqE96lHe5z5ZaSsilTorjZG4UlgUzje59JydtyJ3KCr4KQalUgyuJ27btx++da7N4gjGrA8tv8khm/wciXMXsnI3BGcsb4ycxCYzWylCl6ErlaNqIfIPUJ9OUZVDN9ZFdEu+TF9tdtRhzUThjJTP1AEkMcELiG3tG/6ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Shkjcaw4; arc=fail smtp.client-ip=40.107.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/kh3hWIL/q+IQQr6U1yWteZN9PQ5M3FyVJ2tmhgVz9G/CkFm66hOqKjDaTODdPQAYaL1+ulZauMnVHRupUhSyIsVCr9D9USIfiYa4gXvudDBIGusjL+jiHm+9NvAPe35JFRdWd7GHHQR/48AmPl3260gzpT0UHWxFusO7TqkjBsZqf6+qOcSQhUldBwMTfn4Tqj1uaiFITB3M+T/Z05/jZJr6DG6GdjhK5oWlcBgJpLYyvFOBjCaeaGCTPSQsf2GjGpag0Pq34NUobKHm3Py8Lm8Dwgg7J3u4GOqdKHn+QNbS09bbHkAEpo84o4caVdsTGBz0jIc7TDjN5C8TPXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvFkoFdFgsCMAcV7OZmVySzP+abDVbCTmt7fIg1q5vo=;
 b=kbbsJB7cE8DU6O33VIxlotCpj06daH+/jRB3JAKdAJyd6URlCK3aeutMwHy1jetAqzk8DyHoZ1EgCfvl4YNNnPjf7QtUCbYwKhCmCJ2bfOq6+xh5zl2+oO2biaMY7AlAHGuTJc6IsFBuhiuQ9IA/AV8z+O9GGa0JaG8eHSI4ZzczQqhfrLacRmzeOIeoAoNFMUJEeM0dsNmGopq+qD9uYh0iSmsR3IjZiSKARc9QS05cWxe+z1bI1W5ELHvRUKISnLDll59P/xuu9wtN95TsaEuM8NRCPyDDVK/kcHGLlbfHZc2ZGncVsc/wvr4L0SJNX8OjJJDZH1HMF9GPNhcdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvFkoFdFgsCMAcV7OZmVySzP+abDVbCTmt7fIg1q5vo=;
 b=Shkjcaw4dA+XrTDHCWPbAQNj2AerqXO7TP4Zpqb+Oo8oY1+etzwKfeXkrWA0EOUvf9ABapnLI0MZS33tC+Uk62K8JI3CQb4NUkYo1ejd2wgVXGD6+oxDK5tMkDf0O3YcYfU3L0/17l6ilwAvS8fG1k6C2J5qPfrgPlqdpbP1Ln4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 14:06:18 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:06:18 +0000
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	ghennadi.procopciuc@oss.nxp.com
Cc: NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Subject: [PATCH v2 0/2] add uSDHC and SCMI nodes to the S32G2 SoC
Date: Mon, 22 Jan 2024 16:05:59 +0200
Message-ID: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0294.eurprd07.prod.outlook.com
 (2603:10a6:800:130::22) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3af6d7-2bae-4a6e-0647-08dc1b534dfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HQ5/wsDJjEDe8sq+S5fV/2bivgDIPp7fsf2EW66ZG72hOcMmeSPzPzzazdDzcc+8oe9b2pkt/JnQy4wQ+aPTtuSbbnlcaZenW5o/71dnuC9qntsbL8iMdPqnPMAYFH6xBGSO/RJn7K+F5PI9vv0DjeDhzooybR67hfnbZHJfCtWGq+yivQKcaHUwCAvnXfiQTLcfFrcNmPA15J4D1a6k74xS4pdIUFlqDDm70MuxfpdtI6PvZxVIaBUdsa9l00U2HRQrlFlWVmB00uozdXKMkL/XSUeA46z59BjahsRtANgY37Ezyw1bXfzC1PlJLuNko8WMaTX56PpCtiHL2GdvFgym8wckFbEAQuBNlQHNw+2Qe9Mz0pCV6scpXXRHFOppOhkWBVhhSaoUOY05SY3gO2E63MrVR61GypDt95chMcq5UdC30rZxqkBrHmCMrFshPp5YRtXaOPPgH8UafQp8TgOQJLvSLz7mjhBpxVahHoPtPMEW4uvxbqU8g6pe8pWAZDXlCD3UR4B7LtUqSUJhEtYc8/e5a/5+eDhfN3OmthKr0QYz1A90A2sGOlXBvs1ZMPOazdWdjadTXCnze0mBu3As6JtyilBAInaNytibV587bhxuK1ElgQh2FLcagJjK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38350700005)(921011)(2906002)(66476007)(54906003)(966005)(66946007)(66556008)(26005)(4744005)(6486002)(6666004)(6506007)(110136005)(478600001)(52116002)(316002)(4326008)(8936002)(8676002)(6512007)(7416002)(5660300002)(1076003)(44832011)(2616005)(83380400001)(38100700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGffbMnktrHP6Ea4Mpfkn/9T5smfa/N/OXWt9SirXThsQez9C4AQp88FTog5?=
 =?us-ascii?Q?S4Xnasbc5kH/ByP/HVK3QGcFOQX3w71iCifM2SHl49lsOq2PzIxTkewWfVa+?=
 =?us-ascii?Q?jueQfRw5nU4m8Znn63MUL0/VD2rSps0BeZdxd3HU82FImTIRUMht2fvgnvqQ?=
 =?us-ascii?Q?KHZWzRB6KlhbmjWalgcM7GZ1t4HHFiXRcLbCyuKVNzh8XzI0MhuPh6W2xXdA?=
 =?us-ascii?Q?52GT75vf01yKSiqChzm8KqO1eQxe1/+TseqRX9Yf5hOqarfpPZGP8zK0GnSd?=
 =?us-ascii?Q?HzTavsvpqGQvL73poR90Y8iTNsezz1KvDowDnPZLHrItoqZmFWTQv3ZxKKEe?=
 =?us-ascii?Q?2TRQBULFW7MAG9iwzTEpMm1/JNFBPV5IhfCDyFQ9Ej+EYUjitZBaaFfWWQx4?=
 =?us-ascii?Q?UeR6eUcck1Ck8J+zEEvZjeLhJmVYkts00ZypO8NxNLTLT281Qj0+hggw+qi8?=
 =?us-ascii?Q?dUjudkFWnEuCa60zySvX1t9prkNHMC+5GGkUJgnSzGH9OufR4uBnnZCuIX9j?=
 =?us-ascii?Q?4ZjTgEIpBUvrul1favA/wNXW32JiTTwPlmdT7y6MVqSBOJzIxjx2N57Ivp/x?=
 =?us-ascii?Q?dZ0yVpVxIJYh/HKyG1nSxnALNsrarydIoC2svhiSSlFTON6WYQXrKeRCQ2yL?=
 =?us-ascii?Q?+Org8Eo+WvbQLi3r86OX0CNlPikXxmFejiWMqrt136+hLVk13gyNx8qBQT72?=
 =?us-ascii?Q?zNjedrCvJcZyDEmknudVV1xlCw6VSygEHYQzeuAx5U08Ltnfxqwuid5dD2n3?=
 =?us-ascii?Q?JaoSQpGtd+AttANGQW1nbu5lE7TLpm+Ep/PIwUJ3qMIEVU3+AvI0CZ2Oj2zB?=
 =?us-ascii?Q?zojrbn9JlFoq6dAvZqitk5T9EX7GRnXJjMImxy6DFMJprtI2WLLR3/1FgDdY?=
 =?us-ascii?Q?WebItQMSkr3QkwoevLjeY+UymQBhR0OLX7/6z3UpCyXWho5/q/sR/gPikLFl?=
 =?us-ascii?Q?sYCi5NTvehLVJCZC/ZTtBxLqr4qD5alepZBD4DXOn3kK+iGkYnNEBLehkBc/?=
 =?us-ascii?Q?i1miHd82SqXdR3y4PPXMyiMOhPDMCxoTA21tksDPY0e2KQbl5uMo2asvJYE+?=
 =?us-ascii?Q?JbQq1FNGnBoxIX0lgZ+vucWI2juUAiIQwQiMfWqadTNre4AdNLJcqlIfkPS1?=
 =?us-ascii?Q?nzwYu5t9QXbMYNcLW0Y5dqaY4SqAYHPcQ8qLXKCEkO+Av/Hi4sESvL3cSRkr?=
 =?us-ascii?Q?zk9QSMc3iOCfnXvs0oPe/YON21PtcCUyegiCy+r0GAtMZwttfcdOQwnvgzhU?=
 =?us-ascii?Q?4joH0EA+akt+nXm+5fIB84LvyZg6g4ngYi0q2Glz3GBVLqlvpDNiPPhLAuin?=
 =?us-ascii?Q?qVaGjo3Usu2jvAnrq6NInmwhVDyCrg7+6lfIiO4LCb49mXKOBy7L3G6Yv3aU?=
 =?us-ascii?Q?UgK+E8/X76sSJ2fPKf2pKN2Jq1JoVpfsoKwqeRjxAHi9ZfaadkDNQCU6+UjS?=
 =?us-ascii?Q?tabL7HSLBxOprCP7pLBRs8A2OBBmBTHTR5SL4hEI+Z5gEF2+jJMT+mO1DhSP?=
 =?us-ascii?Q?mND7xVPyOjDjEfjjLS4HxBMAcAqoeMNM1tLInvT3ZPUEa2ZLrrKAZiMhVHwc?=
 =?us-ascii?Q?5zct+aDjVMMCDYRgfn4NWTedWvPUHrXJZnfP394lrFbzRkI3QWM/xloqj/4D?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3af6d7-2bae-4a6e-0647-08dc1b534dfc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:06:18.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2TAIj10zIVWjFv9kxClWTfw30kCUeINO8HXikuE64sJGIjlhSfDcvnDQpaJTlrGo0+jv4z82FWqGnwzvPksZQ1ffDCu5MZf2nncfU3tL0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

This patchset adds device tree support for S32G2 SCMI firmware and uSDHC
node. The SCMI clock IDs are based on a downstream version of the TF-A
stored on GitHub [0].

I can send the patches individually if you prefer that instead of
submitting them all at once.??

[0] https://github.com/nxp-auto-linux/arm-trusted-firmware

Changes in v2:
 - The SCMI clock bindings header has been removed.

Ghennadi Procopciuc (2):
  arm64: dts: s32g: add SCMI firmware node
  arm64: dts: s32g: add uSDHC node

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 37 ++++++++++++++++++-
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  6 ++-
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  6 ++-
 3 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.43.0


