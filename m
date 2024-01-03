Return-Path: <linux-kernel+bounces-15253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C0822929
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17F328526D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6AB1805C;
	Wed,  3 Jan 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzhiVU4U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C4182A2;
	Wed,  3 Jan 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704268648; x=1735804648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4e1hgBtuxR5D/7Xh+Gb1aESCcIHqUe7uEsR2lbJ2pc=;
  b=SzhiVU4UaWkgGgorwjDGiYabwUtIRdY56D1FtoRifK5EUQjtVj6pQChf
   iidbMO+u8724/7IUVHgUgNIcId7cFRTqdqCcPX65rIxBLFrt6pagJQTwE
   l/jzNUFsOksKIe37RrHBtqKzF3eB0eEmah0f31NhcKCtJx1BTn7XdoZmq
   rtkrlvd05bgokkxT0ICeKxv7d1Hu1kUZ0VQ7WHeNPybmgBlGVbR28czyH
   G29zgNKovhgrnTwiGcaa+YGXSZlZ/y6uiYJ3x89ALqykXcVGEAB6Z3GM4
   Vvj8Hi62bVM7bTZUs64jE8DO6TwGhydE5ZudWNxr1zR5u+EFyeY5hQQJc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="461285967"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="461285967"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 23:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="845802655"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="845802655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 23:57:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 23:57:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 23:57:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 23:57:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 23:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQf3k0TkU8ORZfvi9uIkEm8gLUa7cFZ0BAYPRrsIxXIhBbs5DIJIrXETENUA918u2tEaysHb7rSd8uBKQOVm0dzeh4qnIt8ZiB06obHd8d66BozNz/+489uEKPWo1SbGKDBFZm5ZxuAiSxeClZtGEctL6TxEezabGJMKs86f59je6Bc8Vc8gi61GTVJ5/hfyYteLT79eoy4pWk7bzkK4Wr8IzuzLcCGZhtFNTM8tkltGghId6uw6Gd8PKQN0YCB1QULAjKTTlJZHvvPLaJiIzxa5G30iL4rLFLUlRnqFdvmUpdjphUDvRZ7IRkOOaGdnCl7gcO4EKe5iew6+a7dlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOUzaiRJFGmUgt8czOK5QjVW6wqpqsSSzfecEzUah8A=;
 b=k4QCgMk19cTREHDU5aZCf3K6t5om2hg3rNT1lJdYFaFPOw3s5cbOC0BycngdEIgLtdExalI1FZQkbT8LycrYLC00gHfYvkSZ2wVs8QOyhEKGfaiBh79OjfF7JTponQMoJJpxYEfIMUcYWIYqdm24Bqptq7G/ERVrwKLD1a7XMvGkKj1H/0PDr0lSY3VqhhsqVaC13iR8Nh6hZKJeXqSOBvnoneccWlSyJ3mhLoMHAMCG0ZW8O+Jv8GJtzyL4eg2O2lLuk2TUYpD/YJQ0hMiqniWQfJx7UeyNeLMwnjTER9qcOY2gqLvTo5DIv5i/IlkPbZcLlzvbFOWRlrnWeFlNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by BN9PR11MB5337.namprd11.prod.outlook.com (2603:10b6:408:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 07:57:23 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:57:23 +0000
From: "Swee, Leong Ching" <leong.ching.swee@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: RE: [PATCH net-next v1 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Thread-Topic: [PATCH net-next v1 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Thread-Index: AQHaNJox4jd+E/aBcUiXrRKS2mOw+bC12C8AgBHyAHA=
Date: Wed, 3 Jan 2024 07:57:23 +0000
Message-ID: <CH0PR11MB54909520AD7A8B5FE4C68334CF60A@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-4-leong.ching.swee@intel.com>
 <qyiveqz3egzctymkwflgw4u6ubnpiss2x244fsepop7t3ve7ev@7x24oaiferuy>
In-Reply-To: <qyiveqz3egzctymkwflgw4u6ubnpiss2x244fsepop7t3ve7ev@7x24oaiferuy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|BN9PR11MB5337:EE_
x-ms-office365-filtering-correlation-id: d110b593-97ba-4e44-359c-08dc0c319e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gK2SFAU/KR7IlLt1DmVMILqbqE9ZrwPVdJNvGaoefc37BEuN0fuf+ZrrGIhAFMJyrTdcA4ptC8w/N13QdZ9YQs8Znz0iS1v0Br4mAl63V/jdmgFpUbyvFjQwgWDPHXfm6gu9YVe7Zl6oYvEhzeyyc4lbRrWHppLMpm9XRG1fjy8xXBvBN4lvMkgTX3NBjUyhQmJnemIhsVu2HIM9lDUO29YZLYQCj74zgvlPiJfV/O4MypFpJPDyFMRRU9/joiONI5TXxGb32rKK2GOdEgzFjA2aDhToaaO4WRMGLvaJJNuXhyRoscwkrIDGiWA5/EuHH92+xvQUp+HJpFLxdEaf2W6qBRJNa6O0QcUNcSEsTTFnS5OlbaT1yqybfVxDlnxkvTapceXxQPLcdbYP+0ri8VgYsdCKE3qimTJ/qD9Q/anBUUU3nTpIGAt9ptjAdbjvw/Lcd2y5af+AvsuSQcaycpexPdP3LAZIoslMVDUFSw6hpe1w/5wMFUxD98M33p/kE/JN8YZ+MVCfzo7UEeTMIrEWOrqhMAfGDuw9SC65JcDvEdpHis+iyAazWaqThxjHMF5vuKV36VM8GhqPFRJEprF5aw6YRDJGPrcRs+d4n7zZ81HJJVwMuBklFurjlhjB8/EN8FmzCCc9Qb0rdOz6qxlhnljyAgcBd1baeLwyL+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(7416002)(2906002)(4326008)(8676002)(8936002)(316002)(52536014)(76116006)(66446008)(64756008)(6916009)(66476007)(66556008)(66946007)(55016003)(54906003)(107886003)(26005)(9686003)(83380400001)(41300700001)(38100700002)(122000001)(82960400001)(86362001)(33656002)(6506007)(7696005)(478600001)(71200400001)(53546011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FPufNI5ATofH+7CZ1I/8pRGQax7iQ9wryZUJ8jAUUL3oFF8MKVvyFKGVtdnw?=
 =?us-ascii?Q?XwtV4yB+aLg8y62QwMuk32wgAH1P4sPqaegaasBacOxdLE1QFOrmnxGlqb7H?=
 =?us-ascii?Q?ziQJnqUhobb+yX/XXRz4iT8/NJq7ivlwV1muBrinvMU3VfE2EhhCRd29gE8v?=
 =?us-ascii?Q?s57EDdYvM/ncEElxocSz2sqnKIGZtekGT5Fe4d3vmJzc/7nYJ/VGqsb1JdaP?=
 =?us-ascii?Q?og6UL6AaDDnuQ2oja2k84uK0dLPzJ1g1EdOgIwdGVWW1TKhKsHi763EzRIdZ?=
 =?us-ascii?Q?Z4SqF58HAqOlY9kfFIsqQ1jRv7g7nB0y+M1rOtYlYmoV5EKU3gXGzoubIepa?=
 =?us-ascii?Q?7NIcQvpnx2SpV4dqV1IogLAgvdY8v13XWLtFcjC1j+jsSrhmlnpR5NJU8JaG?=
 =?us-ascii?Q?Ye1MtT29MerAv0jf1P/xV3jKSKwCIE4zwSmL3jYlf8OgfdJig81jzp9Jukiz?=
 =?us-ascii?Q?tqcgnGjTOlxcgHtL8EE5JJvBVfuYNdZkEbS8ibonhlrEpxwV6IecoCgkviBI?=
 =?us-ascii?Q?ywPHwEZjsW7OiSzfU4jF0EaIfryl+aBkjBdrbosiS3m/YasHS2Vq/uF32QJl?=
 =?us-ascii?Q?sQ5qV0BCf1W/aMheqQDpjHCIWMQZFQI2wEXfYBteF2oZihIUrSSzei0KlEE+?=
 =?us-ascii?Q?2j9jRqo8eecgUaf5B7UIoNSj+ieLq5j7O3ewUrhDT5ehlNOcJrthaXyJu0OJ?=
 =?us-ascii?Q?wVc/iyzOivRU5NdGA/v+XneMATy2/hViuF4n0h8sabexeRraVoXxdC0BJ5NB?=
 =?us-ascii?Q?NuvYvGct1OStrvv8FJfPx1W4mzlDN7Y11xEnZyxqtX2w0YP6JHQ/DTIOdClD?=
 =?us-ascii?Q?3h/AZODA1gjm/PXBBuSi0ZHRgwvNJTlvSEdguZ906HNL6M7WskKHsTpHFvg6?=
 =?us-ascii?Q?mWQ9Sk2ohKlHM+XBLwAlXI1zVQ0b/efC8Tn4kuSotv+gy3ha5eO7+zpnsoSM?=
 =?us-ascii?Q?94YyzxI81P8VgYd32x1m0h0UF2CjDckhi7fvSnKPPHMxW7uohjTwoooHY6FY?=
 =?us-ascii?Q?AFFvJjLwGxQdBEsX1qsGhVfNmmvmAiASqnschrK6Lq2SaQBZN+j/6gfOCRq/?=
 =?us-ascii?Q?bEjHIz7Cxoj6dHxdjTnx9KV5PVwCVSnvMf8cSqvAlq1U+UqzWRrKdUJG4TAA?=
 =?us-ascii?Q?z3VE7q4Ohjj9dvn/8sT6OqhUCkjysZzDMjP19hwyt17zAeNgCatUvrcwzYhs?=
 =?us-ascii?Q?4FgbIL99Tlz8phXUNUzUaREPST5xf+t5vDDr2/vUh+pCsWowzhVHc5BIGaeG?=
 =?us-ascii?Q?XbteeDZFhVpOqaSets+9mrJTaNRPjHM5nBxom09VL0bEYmUMxOLZHH0BoK1m?=
 =?us-ascii?Q?krEF5uYfIxceu7jAvc06j2dAbigfQuu8GPpJ+tqVOyuQH1JVSpg1QFMBLKe6?=
 =?us-ascii?Q?ZNYgbOrHW+yKMMQDvr3sjpH8n8ClVQbH0mjF0hwOkiQhTge6p3ozduQV8uMp?=
 =?us-ascii?Q?vl3s1vmWGaQpCFb6sLonoS0AhHiwRWeGYYfVke4lRg16kxKut7xSBoKYkmgM?=
 =?us-ascii?Q?mXEX+K03CR5UIHr3RcuBYrc0PomvlNQOeZ/KLTjBDMZcJ+exdtXFVSOEPLKA?=
 =?us-ascii?Q?TnrLZVHn1Ca8DHlOvtj7jMsLvk/5ALatthGRhbdfSqODaKkBsUKBoAUfJ2Fq?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5490.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d110b593-97ba-4e44-359c-08dc0c319e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 07:57:23.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g7aEZKYlFE9+1sHvQ/nLVDM26zyyfqUBp42atoj1KJ3idJYmyIbrBYJliIw8D3ND4r2rvB2uAU1QZZ73sYhV7oZmzlxReSNfXTtDw6CpJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5337
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Saturday, December 23, 2023 5:49 AM
> To: Swee, Leong Ching <leong.ching.swee@intel.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Giuseppe Cavallaro <peppe.cavallaro@st.com>;
> linux-stm32@st-md-mailman.stormreply.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; Teoh Ji Sheng
> <ji.sheng.teoh@intel.com>
> Subject: Re: [PATCH net-next v1 3/4] net: stmmac: Add support for TX/RX
> channel interrupt
>=20
> On Fri, Dec 22, 2023 at 01:44:50PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > Enable TX/RX channel interrupt registration for MAC that interrupts
> > CPU through shared peripheral interrupt (SPI).
> >
> > Per channel interrupts and interrupt-names are registered through,
> > Eg: 4 tx and 4 rx channels:
> > interrupts =3D <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>; interrupt-names =3D
> > "dma_tx0",
> >                   "dma_tx1",
> >                   "dma_tx2",
> >                   "dma_tx3",
> >                   "dma_rx0",
> >                   "dma_rx1",
> >                   "dma_rx2",
> >                   "dma_rx3";
> >
> > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 24
> > +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 70eadc83ca68..f857907f13a0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -710,6 +710,8 @@
> EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
> >  int stmmac_get_platform_resources(struct platform_device *pdev,
> >  				  struct stmmac_resources *stmmac_res)  {
>=20
> > +	char irq_name[8];
>=20
> By DW XGMAC v2.x IP-core design there can be up to 16 Tx channels and
> 12 Rx channels. Thus it's better to set irq_name size being at least
> (strlen("dma_tx16") + 1) =3D=3D 9 beforehand since you are adding this co=
de
> anyway and for some reason didn't consider to pick the Jisheng'
> patch up which fixed the MTL_MAX_TX_QUEUES/MTL_MAX_RX_QUEUES
> macros.
>=20
I only have 8 channels tx/rx dma irq setup, so I could not test 16 channels
Patch. Will update to 9 in v2.
> > +	int i;
>=20
> Please add an empty line between the variables declaration and the next
> statement.
>=20
Thanks. Will update this in v2.
> >  	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >
> >  	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -719,6 +721,28 @@ int stmmac_get_platform_resources(struct
> platform_device *pdev,
> >  	if (stmmac_res->irq < 0)
> >  		return stmmac_res->irq;
> >
>=20
> > +	/* For RX Channel */
> > +	for (i =3D 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> > +		stmmac_res->rx_irq[i] =3D
> platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->rx_irq[i] < 0) {
> > +			if (stmmac_res->rx_irq[i] =3D=3D -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
>=20
> What about:
>=20
> +	/* Get optional Tx/Rx DMA per-channel IRQs, which otherwise
> +	 * are supposed to be delivered via the common MAC IRQ line
> +	 */
> +	for (i =3D 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> +		irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return irq;
> +		else if (irq < 0)
> +			break;
> +
> +		stmmac_res->rx_irq[i] =3D irq;
> +	}
>=20
> It's cleaner a bit with less indentations and doesn't pollute rx_irq[]/tx=
_irq[]
> arrays with the error numbers.
>=20
Sure, will update this in v2.
> > +
> > +	/* For TX Channel */
> > +	for (i =3D 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
> > +		stmmac_res->tx_irq[i] =3D
> platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->tx_irq[i] < 0) {
> > +			if (stmmac_res->rx_irq[i] =3D=3D -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
> > +
>=20
> Please move the Tx/Rx IRQs getting loops to the bottom of the
> stmmac_get_platform_resources() method. Thus the order of the IRQs
> getting would be the same as the order of the IRQs requests implemented i=
n
> the stmmac_request_irq_multi_msi() and
> stmmac_request_irq_single() methods.
>=20
> -Serge(y)
>=20
Will move those methods to bottom in v2.
> >  	/* On some platforms e.g. SPEAr the wake up irq differs from the
> mac irq
> >  	 * The external wake up irq can be passed through the platform code
> >  	 * named as "eth_wake_irq"
> > --
> > 2.34.1
> >
> >

