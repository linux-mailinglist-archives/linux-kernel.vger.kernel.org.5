Return-Path: <linux-kernel+bounces-15249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBA82291F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D5D1C22FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFD1182B6;
	Wed,  3 Jan 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no/hoA0r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1E182AF;
	Wed,  3 Jan 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704268296; x=1735804296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V6kfsoGjo1K6cOiQjd/M2j1twNEo0o1sJWQD8BvXDnM=;
  b=no/hoA0ryLrFB3z0tDYj0Hl9FzOZNza8xIlxL2NxcJHgPe6ha5zB4NfS
   RSdSVnctHCiURwGU1FPSU763iqeZJLv0OKlv05EqfOyyWpRgLj8ZMcqXK
   QG7EYHnx58rXyBy97UFfnERPxy4trzqT8IEN076HnHIn6S1RteIMV5j5e
   AtyDTe/jzsVEuBnbpVm68JF+MZn/TIYAZlymfqAOUhcOlgEyfTiut7MaZ
   4/pEc06YsE/HhDtYt8uxqn9zCJKLjGYQvZjYyWaqJXiSPl5IVsG0TGC4g
   yecstraQuWbYIofhWPTTzZEXHwicjJwv3S2mdjnxUh0jsrmxJzNRcz1vI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="400783314"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="400783314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 23:51:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923464050"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="923464050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 23:51:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 23:51:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 23:51:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 23:51:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn+TJ4Po8HAhC1wal6U2xxo7NsdJT8K2W32l7qYkF9JFz+BMpHTLXyR3luo2DrNd7mmn4TriZnFWd4kJ59XeDeJMvo6jgVoUgwNIOFM10336xJMwbsMN00gp+Fim+5KFljm4dJBbopYWs2fmXMKgiOa7h9IE4VzAE2MAiY4oW6xO1iWC1NJjonefJN33Jf2VUNXjymz1EkLBn4ISlLKaaBOqnhOMTp9KcP8KaFutUdwJfBheh7XIZ8w9EORERyTCn/MyGlSiaEiSssTQdotwbhRF4vbKLh79aJPo5Zl1NI+l/Y8A6XonMd61zHrhg+dSBrmduFChCY21xdFhI4fEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBb3GDaTOPwAcKQ2RnLhRk42Wcl6S7Et3syy1i2hyMI=;
 b=EaUyE/aQgtg21LffG3jHzTNyXOIyjXiQFpZEv3i0qAZ5AugZ4/KSNnmChD3ZWuhag2CrQifvgqj5nPrYwnIZx0HosmWnm/5pj56kfqN+MRE80JKGxOoAee+SsEA8PqHPnqv1Mdf0gNjnyNHnerItInmcomuJFHsrZVRiTnJqdz7od2yLEYZwQUvzGUJSKJNZnyX8H30A4MIEG6dQPVcbz9ZtJM6paESIyHReKloReSa2b+w8gQqmKC0Ib9P1p7rcb6rS1NT+UkOHba6OFtrYES/jYZ6oz6AtJxmRtJGI3gavVlljjQgPt3wvBbiWpsUnATkpAr2Zm4F+GBeZyn4u6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 07:51:30 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:51:29 +0000
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
Subject: RE: [PATCH net-next v1 2/4] net: stmmac: Make MSI interrupt routine
 generic
Thread-Topic: [PATCH net-next v1 2/4] net: stmmac: Make MSI interrupt routine
 generic
Thread-Index: AQHaNJouWAOgg5W5hkqUfpbeaM8im7C1qbKAgBIaGuA=
Date: Wed, 3 Jan 2024 07:51:29 +0000
Message-ID: <CH0PR11MB549078C963C6FBB17AFD532BCF60A@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-3-leong.ching.swee@intel.com>
 <zwlnzllanmd6wtmn6ts7pd6y2sxgbauy4ffgqlf3yaq4uo65tw@ybigwcjpk7uf>
In-Reply-To: <zwlnzllanmd6wtmn6ts7pd6y2sxgbauy4ffgqlf3yaq4uo65tw@ybigwcjpk7uf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: 736e7122-db3c-4200-379a-08dc0c30cba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B33qIKsccUPe0IDDWE28gc07jT4QG8qSo7lREdSF22koWFDUE8jZpsqx52I3rfOFoIXFz8JNY9R9UQmxCRGFw/aTCmyqeUvXuDaMtXvK9UYwEW4XauI7kZToGZ2T088fcyzYly3PevvuV/Di7w2WGSAK8gy5nzlkJ3tUmcuuAQGGB8wmKu+oIBB4StzBay/bRi6kKd+HGFMSFhu4QwZ1rq9GTGihDbzYPWGOWtEy87Kxdp0roqIYZ4FRwGs5vIDBn0Gwlo6C0QEKYmMHDgzKoIvOttGrZhGtnvD6PyWMM4ShSx50CXYapGVPiRo5Vk7RMfGW7swDsLiGZ3IqoUi4JlgWflGpNqBbG+4rFg5JTbYOcIi3zV/qE3aBQVHLAGQ92SfFZ+B8c1jFo25NaXFAyGrFU00EPAh3u/u9mx/8lZOhqCLv3jOjrZAwfT7BoAPevebeP0jd7DXS/YBTyeemE4jo22U40k7zIM6pqPLWj4hkPe7yszP+mgSyW8mVZyKWLUE+bI64l1MHIkKXKuUnH1HMgN1mq5151JZ366fJPqxQhe4Hi0WpcgNUHWe/Wgy84Fw3yEYEUlBAX20gFhkWvK2PYYEhgYmrAIgBgHzWsY7G6k3JRrOZmyQrOCovmxx/LJK0wFol/2aO/f1ixFpfYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(7416002)(30864003)(2906002)(4326008)(8676002)(8936002)(316002)(52536014)(76116006)(66446008)(64756008)(6916009)(66476007)(66556008)(66946007)(55016003)(54906003)(107886003)(26005)(9686003)(83380400001)(41300700001)(38100700002)(122000001)(82960400001)(86362001)(33656002)(6506007)(7696005)(478600001)(71200400001)(53546011)(38070700009)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bx8Axfz/2tsj7eK8TMsTXu2fIMOhb+PO57l+jCWdM9aMgzp+TBRTy1IW+bYO?=
 =?us-ascii?Q?k899auXFgk0Lz52sJltLZkURWJHJ9NEgQI6ByQ5W51txpXa1EQRd6gMkT2VO?=
 =?us-ascii?Q?wLhrDjb/yLSc4ByOXFQiBILxKEf2eCe3f19oRsKGJNExh2VVQYj7nVIZXzo3?=
 =?us-ascii?Q?nHuvP4w9B0nyjVbYEUPFYU5cA7n3icCqTJH+rcMe61CUW2xMx4qJDr2Pvq/p?=
 =?us-ascii?Q?jBySPjwsFfbG3jYcyPD5ZEdpicNsnfQhoP/i5VYC31BFQjvvcjzuCOvOBxsP?=
 =?us-ascii?Q?0kaQpVU9rtphJ1EfwI2L1Ktc1w6IwdfL3q9G8rm9cIetiROKDQlLL8kP03iT?=
 =?us-ascii?Q?oyN+x9dD2jcjZmRiw4x9GjbFnOW3LccLUtonRtKo/qnyiecK3uGa20GA/h0f?=
 =?us-ascii?Q?xEJOHKFqBhI9PocrcKzpAICyWDI9hR9xjykfOASgxQ01ua24ZR4Yt8bKJUfp?=
 =?us-ascii?Q?VVBL6fV6IDmL7LTDmmXT2TRK5YUFF4sZEbVkNWT7C4Ln96eriBjg9DA90jnN?=
 =?us-ascii?Q?2pD8Dl3uDMRDer6Wmh2pPOWfxl7jtpM0pjzWf23nyXGNf76QdKMkSMJyrKww?=
 =?us-ascii?Q?nErmQnr22JrrH0bgKqvTs1P71GOH3++wm0zMilggpcRX8MQRkk4QcG6h/g7l?=
 =?us-ascii?Q?u6jvwlIMlsTUZ8z/zblXIFWakk/VX73SCjPkeAFv6j/CKDRrVwr2IVL+Gx2h?=
 =?us-ascii?Q?iDWSL5KTLohs0ePPWtavfxvpD16Jy7VtrmFvwj6zllpAV2wgxNDP3xdO6YOw?=
 =?us-ascii?Q?TXHbCrztImyTalWHGB7LfunmHTH9sQMm+IjJ0CKDj7GHSMU2UzTkymPLBBrd?=
 =?us-ascii?Q?OVRyJnD93dW1WYAoS2DbBnEt4Z83ciyEsMUG3pf9L/8k73DjFa8rEJrqzmmm?=
 =?us-ascii?Q?g+NGfi2VONcY5rZzG4NYymjkqWOlaMmtFPZ/CPEe+WimdXmQ4UvgtCa3KQZL?=
 =?us-ascii?Q?COSe7HuR2kvu4suh4jear2iIYAyyCHwU6gCTIh9OZrLczzEmhZwBztTuoVSR?=
 =?us-ascii?Q?8nWg41VqAWZVvYECEDCU9vGZF2PphglIoIFTWiqxN2ZUUUPhSH5fAMa1vNyc?=
 =?us-ascii?Q?Yp6M0zPpUrXQF2kp3c+GnLE5iS9F4wzwYdhbV51XOELRYNf5rmqYjuVzzsHx?=
 =?us-ascii?Q?34jnCIBe1JrXbs0u6zb9b9OzI9wFoYTOFVM8CnXVXMuVuzmUc2jaNRgG3ETE?=
 =?us-ascii?Q?TBw31EDkRus5qCNwiffbjFt6VfPIFWW1D3UbT9sqNUtAMgrgy/TFsQnxvMgz?=
 =?us-ascii?Q?2av40wX6gFH7P32pKXb2Hn/9J8EPCz0qwtNYMreS/APcPaoeDK7e5aW3Vybh?=
 =?us-ascii?Q?xp9QVlzxaInNKi9jwYJMkw9obnBxnDQHusWb5RhKZVQE/b0XztIQY3TJl8dk?=
 =?us-ascii?Q?LXbtsGIEbXimGeIFV0LGYwb4nBWFiWqrpwm2R8Oxc8b9sAx1XqDB5NRbda5t?=
 =?us-ascii?Q?uQ8US/ItuLsefP3hubS+pDWpsuKo9Ql2IHn7ZWb73O00hjaMzS8QysR8Uhv2?=
 =?us-ascii?Q?71VFlwLgL1u37JrVipLs0LsUBR43DitAc3NxVk1jI68DKML6AJZOGSuJR6/U?=
 =?us-ascii?Q?6C76Hth9aJKuRwyTmrvlqkFBLhGsTLXMsmKXloQoVA6Z101mPNa3C0zYtjNR?=
 =?us-ascii?Q?rw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 736e7122-db3c-4200-379a-08dc0c30cba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 07:51:29.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdFvgSx6p1Nnx3R2/ZGXNk3UGqMFAz+ThOgJyO47I4eMfdYWH5dSv6iSW+HDt3WisQbgFUH9LSsOCuieumtFlGm42A73tvETjKN1EcdxkV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Saturday, December 23, 2023 3:03 AM
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
> Subject: Re: [PATCH net-next v1 2/4] net: stmmac: Make MSI interrupt
> routine generic
>=20
> On Fri, Dec 22, 2023 at 01:44:49PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > There is no support for per DMA channel interrupt for non-MSI
> > platform, where the MAC's per channel interrupt hooks up to interrupt
> > controller(GIC) through shared peripheral interrupt(SPI) to handle
> > interrupt from TX/RX transmit channel.
> >
> > This patch generalize the existing MSI ISR to also support non-MSI
> > platform.
> >
> > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
> > .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
> > .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++++--------
> -
> >  include/linux/stmmac.h                        |  4 +--
> >  4 files changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > index 60283543ffc8..f0ec69af96c9 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > @@ -952,7 +952,7 @@ static int stmmac_config_single_msi(struct pci_dev
> > *pdev,
> >
> >  	res->irq =3D pci_irq_vector(pdev, 0);
> >  	res->wol_irq =3D res->irq;
> > -	plat->flags &=3D ~STMMAC_FLAG_MULTI_MSI_EN;
> > +	plat->flags &=3D ~STMMAC_FLAG_MULTI_IRQ_EN;
> >  	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
> >  		 __func__);
> >
> > @@ -1004,7 +1004,7 @@ static int stmmac_config_multi_msi(struct
> pci_dev *pdev,
> >  	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
> >  		res->sfty_ue_irq =3D pci_irq_vector(pdev, plat-
> >msi_sfty_ue_vec);
> >
> > -	plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > +	plat->flags |=3D STMMAC_FLAG_MULTI_IRQ_EN;
> >  	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n",
> > __func__);
> >
> >  	return 0;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > index 84d3a8551b03..5f649106ffcd 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > @@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem
> *ioaddr,
> >
> >  	value =3D readl(ioaddr + DMA_BUS_MODE);
> >
> > -	if (dma_cfg->multi_msi_en) {
> > +	if (dma_cfg->multi_irq_en) {
> >  		value &=3D ~DMA_BUS_MODE_INTM_MASK;
> >  		value |=3D (DMA_BUS_MODE_INTM_MODE1 <<
> DMA_BUS_MODE_INTM_SHIFT);
> >  	}
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 47de466e432c..30cc9edb4198 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -129,8 +129,8 @@ static irqreturn_t stmmac_interrupt(int irq, void
> > *dev_id);
> >  /* For MSI interrupts handling */
> >  static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
> > static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
>=20
> > -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data); -static
> > irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
> > +static irqreturn_t stmmac_tx_queue_interrupt(int irq, void *data);
> > +static irqreturn_t stmmac_rx_queue_interrupt(int irq, void *data);
>=20
> Let's use the next names instead:
>=20
> +static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data); static
> +irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data);
>=20
> It would be semantically more correct and would refer to the
> stmmac_dma_interrupt() handler.
>=20
Will rename this in v2
> >  static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32
> > queue);  static void stmmac_reset_tx_queue(struct stmmac_priv *priv,
> > u32 queue);  static void stmmac_reset_queues_param(struct stmmac_priv
> > *priv); @@ -3602,7 +3602,7 @@ static void stmmac_free_irq(struct
> net_device *dev,
> >  	}
> >  }
> >
> > -static int stmmac_request_irq_multi_msi(struct net_device *dev)
> > +static int stmmac_request_irq_multi(struct net_device *dev)
> >  {
> >  	struct stmmac_priv *priv =3D netdev_priv(dev);
> >  	enum request_irq_err irq_err;
> > @@ -3701,13 +3701,13 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  	for (i =3D 0; i < priv->plat->rx_queues_to_use; i++) {
> >  		if (i >=3D MTL_MAX_RX_QUEUES)
> >  			break;
>=20
> > -		if (priv->rx_irq[i] =3D=3D 0)
> > +		if (priv->rx_irq[i] <=3D 0)
>=20
> Why? What about just using a temporary variable in
> stmmac_get_platform_resources() to get the Per-channel DMA IRQs and not
> saving error number in priv->rx_irq[]?
>=20
stmmac_get_platform_resources() populate stmmac_resources struct, and the c=
hecking is on stmmac_request_irq_multi()
 so add 2 array to store the irq error instead?

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -35,6 +35,8 @@ struct stmmac_resources {
        int sfty_ue_irq;
        int rx_irq[MTL_MAX_RX_QUEUES];
        int tx_irq[MTL_MAX_TX_QUEUES];
+       int tx_irq_error[MTL_MAX_RX_QUEUES];
+       int rx_irq_error[MTL_MAX_TX_QUEUES];
=20
So do stmmac_priv struct.
@@ -301,6 +303,8 @@ struct stmmac_priv {
        int sfty_ue_irq;
        int rx_irq[MTL_MAX_RX_QUEUES];
        int tx_irq[MTL_MAX_TX_QUEUES];
+       int rx_irq_error[MTL_MAX_RX_QUEUES];
+       int tx_irq_error[MTL_MAX_TX_QUEUES];

-               if (priv->tx_irq[i] <=3D 0)
+               if (priv->tx_irq[i] =3D=3D 0 || priv->tx_irq_error[i] < 0)
                        continue;
 };> >  			continue;
> >
> >  		int_name =3D priv->int_name_rx_irq[i];
> >  		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
> >  		ret =3D request_irq(priv->rx_irq[i],
> > -				  stmmac_msi_intr_rx,
> > +				  stmmac_rx_queue_interrupt,
> >  				  0, int_name, &priv-
> >dma_conf.rx_queue[i]);
> >  		if (unlikely(ret < 0)) {
> >  			netdev_err(priv->dev,
> > @@ -3726,13 +3726,13 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  	for (i =3D 0; i < priv->plat->tx_queues_to_use; i++) {
> >  		if (i >=3D MTL_MAX_TX_QUEUES)
> >  			break;
>=20
> > -		if (priv->tx_irq[i] =3D=3D 0)
> > +		if (priv->tx_irq[i] <=3D 0)
>=20
> ditto.
>=20
> >  			continue;
> >
> >  		int_name =3D priv->int_name_tx_irq[i];
> >  		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
> >  		ret =3D request_irq(priv->tx_irq[i],
> > -				  stmmac_msi_intr_tx,
> > +				  stmmac_tx_queue_interrupt,
> >  				  0, int_name, &priv-
> >dma_conf.tx_queue[i]);
> >  		if (unlikely(ret < 0)) {
> >  			netdev_err(priv->dev,
>=20
> Please fix the error message strings in stmmac_request_irq_multi_msi() to=
o.
>=20
Sure, will change the error to below in v2.
                if (unlikely(ret < 0)) {
                        netdev_err(priv->dev,
-                                  "%s: alloc rx-%d  MSI %d (error: %d)\n",
+                                  "%s: alloc rx-%d  dma rx_irq %d (error: =
%d)\n",
                                   __func__, i, priv->rx_irq[i], ret);
                        irq_err =3D REQ_IRQ_ERR_RX;
                        irq_idx =3D i;

                if (unlikely(ret < 0)) {
                        netdev_err(priv->dev,
-                                  "%s: alloc tx-%d  MSI %d (error: %d)\n",
+                                  "%s: alloc tx-%d  dma tx_irq %d (error: =
%d)\n",
                                   __func__, i, priv->tx_irq[i], ret);
                        irq_err =3D REQ_IRQ_ERR_TX;

> > @@ -3811,8 +3811,8 @@ static int stmmac_request_irq(struct net_device
> *dev)
> >  	int ret;
> >
> >  	/* Request the IRQ lines */
> > -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
> > -		ret =3D stmmac_request_irq_multi_msi(dev);
> > +	if (priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN)
> > +		ret =3D stmmac_request_irq_multi(dev);
> >  	else
> >  		ret =3D stmmac_request_irq_single(dev);
> >
> > @@ -6075,7 +6075,7 @@ static irqreturn_t stmmac_safety_interrupt(int
> irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> > +static irqreturn_t stmmac_tx_queue_interrupt(int irq, void *data)
> >  {
> >  	struct stmmac_tx_queue *tx_q =3D (struct stmmac_tx_queue *)data;
> >  	struct stmmac_dma_conf *dma_conf;
> > @@ -6107,7 +6107,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq,
> void *data)
> >  	return IRQ_HANDLED;
> >  }
> >
> > -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> > +static irqreturn_t stmmac_rx_queue_interrupt(int irq, void *data)
> >  {
> >  	struct stmmac_rx_queue *rx_q =3D (struct stmmac_rx_queue *)data;
> >  	struct stmmac_dma_conf *dma_conf;
> > @@ -7456,8 +7456,11 @@ int stmmac_dvr_probe(struct device *device,
> >  	priv->plat =3D plat_dat;
> >  	priv->ioaddr =3D res->addr;
> >  	priv->dev->base_addr =3D (unsigned long)res->addr;
> > -	priv->plat->dma_cfg->multi_msi_en =3D
> > -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> > +
>=20
> > +	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
> > +		priv->plat->flags |=3D STMMAC_FLAG_MULTI_IRQ_EN;
> > +		priv->plat->dma_cfg->multi_irq_en =3D true;
> > +	}
>=20
> This is wrong. It activates the stmmac_request_irq_multi_msi() method to
> assign all the IRQ handlers to the individual IRQs. Even if DMA IRQs line=
 are
> available it doesn't mean that for instance Safety Feature IRQs too. So i=
t's
> better to rely on the glue drivers to set that flag as before and leave t=
he code
> as is.
>=20
> -Serge(y)
>=20
Will move flags handling to dwmac-socfpga.c in v2.
        plat_dat->bsp_priv =3D dwmac;
        plat_dat->fix_mac_speed =3D socfpga_dwmac_fix_mac_speed;
=20
+       if (stmmac_res.rx_irq[0] > 0 && stmmac_res.tx_irq[0] > 0) {
+               plat_dat->flags |=3D STMMAC_FLAG_MULTI_IRQ_EN;
> >
> >  	priv->dev->irq =3D res->irq;
> >  	priv->wol_irq =3D res->wol_irq;
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h index
> > dee5ad6e48c5..b950e6f9761d 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -98,7 +98,7 @@ struct stmmac_dma_cfg {
> >  	int mixed_burst;
> >  	bool aal;
> >  	bool eame;
> > -	bool multi_msi_en;
> > +	bool multi_irq_en;
> >  	bool dche;
> >  };
> >
> > @@ -215,7 +215,7 @@ struct dwmac4_addrs {
> >  #define STMMAC_FLAG_TSO_EN			BIT(4)
> >  #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
> >  #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
> > -#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
> > +#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(7)
> >  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
> >  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
> >  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> > --
> > 2.34.1
> >
> >

