Return-Path: <linux-kernel+bounces-21734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF32829379
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B722890F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974932C72;
	Wed, 10 Jan 2024 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVeJeEvO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419EDDD5;
	Wed, 10 Jan 2024 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704865907; x=1736401907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HBpCQfx2nLYB6dHcr+44bhKfXXHstQYhciu5iUkdoTs=;
  b=OVeJeEvOHsIhV1/+hWclfPb77SQBmvPjcTNzX8HcFbr7fUDjuXRAfFJC
   f71c8Np0rIbu69rblAqlvXdn9plBMmSYdip3qDqgK5OqbLykpQ4dYXXkR
   o4OuzInoe+mcuDn0uLAdNfFiVKPOc/g+2pgo8KwfSEFnKKcrL/zrqjQBD
   2Qf+DzqaLqUpw6fZH6SOMBhly23x2YM5WBQUGG1bs+sDPdczxGQ6yd1L0
   TqmP9euKq4WOvbJgJ6LgIQ83l7L4nn7VRqB6fBPnrjoLn57LLOsn5kO1d
   Jb0+Li632cmne+r5iXpkmE4DhJc45tbDb0mNb/zYZ5sqNGS2hb54L/bqi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397272623"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397272623"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852432581"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="852432581"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 21:51:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:51:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 21:51:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 21:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0oqpOEgXlteF/GBobVrI3albJlksPHHJt+YJ03R5bqgoKlkGeBNY2T9ojWvKFPwbLys2BpSiulaG4IuYflh2UUf43iu0UPFbUsjMVtnHXSOBEreXztGKg9ZKopwNLl0EO78ZVn8IkkUl819DCoYAQiHz4JYunkBcObpd5Gfo/rnz+q92xlc2H83VtfglpTvRLkYQKDnsrDqKtrCz3oTcEHBag0WpHu70dYP4yygV+0tcDrlZs9lJEntxy+V/OEmx1dwJL3aQ+IUe6ycUn6l9rL+J8AXTPektp3H+bBguScfxfE/fzL4Rb+NtzJ2pmskBan19zZF+Lbp13Gu3bhw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRFVS8dZzygfmnweZ5F26tfbafOJ4aATPOcL+EjjeAY=;
 b=KpNCRtSLQlBdiDwySz+CBmG5d42OnwEHPdjDLwiUMXJuhpntTVzLgoapGfdVCu7WuBcO6I8hL0dmGaUH8pJH4cjIhrYLKug7m/jPWF+EMwNNtVbHXGI+nG2FdBBrvnK317Hrf4NaJraVdwaAsm8+GYFJapjcSSQn5xLYs4Esqr7mhJ2gz+/n1VQUUzVekwfEmp1P01IyBvERZqJJJhw8XVcPgkGbICxU7seO4bTfmD+Z/ayEulJlz+fTcJuyprK93ZG0e7ATDiV3swrsZX2BZAXPSx6OVeMseZ3NA34dA639i5ZOnw+aSHpT03mFZ5AsuZcMy6LdJzTmef3MEwWBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:51:38 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 05:51:37 +0000
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
Subject: RE: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt routine
 generic
Thread-Topic: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt routine
 generic
Thread-Index: AQHaP6Y3nBOT49XQoEmBgv/Tuhxh/7DO0J2AgAPApkA=
Date: Wed, 10 Jan 2024 05:51:37 +0000
Message-ID: <CH0PR11MB54909CC4F6E791FFF063BA17CF692@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-3-leong.ching.swee@intel.com>
 <7euscw66rss3iux2cvf7fkvfburmlf6lo4arfx76k42gihspkz@xm3klojs4e26>
In-Reply-To: <7euscw66rss3iux2cvf7fkvfburmlf6lo4arfx76k42gihspkz@xm3klojs4e26>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|BL1PR11MB5239:EE_
x-ms-office365-filtering-correlation-id: cac48e4c-b4dc-42dd-d40d-08dc11a035f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HC2GwH0xMu625Dmlbf/N45G0VIgF4Ah9NKIFwpsdPmZEmROst6C6kBgRkwiVhU1nDSk/katq9yVS7yrejNJ34jW7bwAk/gix06IJeuFJIWo3eS0R58hjaJ6l5GorQ8GplB1+jHha7Ziij9bbuAY9lFqnEilCS2P/7c/2ITmuuzFHhW829Bgdv2Kc3Ge54qIqM0bc8LroUf206yUCLjKFkiwkVCVOdUXaffBIMPRzQ1oLmwjRqPP69+Tgwz90PMhbV64Atcuebs8GthB0o2AGtiMOTSIwTG7Rn0ycI2HeWPXPHQGi+DddHHHj02mMs2YG4f5sLITGLSck0ItpDZVmqVbaN5g0tOITjJ/OZ5PjekE9ueks3mJdJo+HQbeNuvUVpDi41LyCtQDlNVrnF8yTRc2KEWdPzFUB5tR8blFqV/ExQLDkT52/n2QoeUPTtbSj6IDHV0TzDn9WkjDsIlUbkTROM4VVnxAFlzamN9g9qhWKHhAmMokf1mv0VydEzC7uY/Gs6NaLSOSHKeRz0J6kj+bVKdsQqP1Qpid2cJZyMsU9ec7t8mYbG4rKFLNsvecLW31OoCtaM2lVqxYyNrj0HxdF9wq4JFWojhGz+wipm0qvSP7h0KHghciw/gpzfR5KZvZNBv59Vq1N8SAE/MM8Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(53546011)(6506007)(9686003)(107886003)(122000001)(5660300002)(38100700002)(8936002)(4326008)(8676002)(30864003)(7416002)(52536014)(2906002)(66446008)(478600001)(7696005)(54906003)(71200400001)(66476007)(66556008)(6916009)(316002)(64756008)(76116006)(66946007)(41300700001)(38070700009)(82960400001)(86362001)(33656002)(55016003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrR3fUcsiAdLqfKjEkJiluWb0HGIBJmhF0JUTZ8QJib57FV0LBoRmAV8fFcH?=
 =?us-ascii?Q?mgoq1YeAaUZbD/2uj1X6a+lSZQAnkpxAI0Pxum+hq2vBmWCNObUw6Y+Mdk7+?=
 =?us-ascii?Q?d+I/kfCVersoQimkmgqiagevx4mRmekF3+04rwEH9D5O7oxMGzVkJLVJqIWa?=
 =?us-ascii?Q?QO+Ot/2RLPqga4OFZ192RtW4jqjRNQvWm6YWXjqYesdQjhFh8hV/kORsgUF4?=
 =?us-ascii?Q?e6/m9MWUsqSjGC8d0wIyL0BQh8FrXdTWAiLW+sV5p5GRN3/W/u7lW3N4eRWM?=
 =?us-ascii?Q?U8eSYAkPgTeu/55gCzdxnqoOO60qzCrtIdXF863/WBNTvC/uZ1OOWNYgMsi1?=
 =?us-ascii?Q?8Xxux+iADlR7q4T1it9l3I9H5bcYD6EWI+u3CuXd7SdT9eg8TFvKjQjKkmdg?=
 =?us-ascii?Q?QPCOyIH8RTBlWNtVix5BFZ0SMj/xqsO5bQe/efcGAlXeStK9+dpGA1SbLGr5?=
 =?us-ascii?Q?AeV9r1E1neXIHbWtqIBmziKqOjovHtZLqw6wLpF6hUmyRgEImE0/oaHkxkAS?=
 =?us-ascii?Q?wxj6qOk7cauKHZIuqvMcpt6E0TvpKDLYovTE/Y4pfI+X4sJeIo3tzettKLJt?=
 =?us-ascii?Q?LoYUgcTvOExMI07YkS2XglMYcysL6vc+rJDbBoq6tlNqL3ZeOsNKNxzFlwQs?=
 =?us-ascii?Q?c6YT548A1MgSoHlu7fu8KqnHUPsbq3OWe1r6/tUCrg28oIdFC4fPcM12ok8y?=
 =?us-ascii?Q?KkYjzTI0QudO/NbwwAllV1LoVrc51447qjT+he0uhWMkw4PosBe0qemfW8Jv?=
 =?us-ascii?Q?yvVQPrKXlZE17Imc3Ia1zTvRhAjHKd45bqAkiTyk7sAgS8pl1A4LE7K+5Ns1?=
 =?us-ascii?Q?rQKTMLnsDweoH34bDGQpRJ54rs6/GMJR/UmDnwT7KQlKQnXbz7SXQQwX/K+k?=
 =?us-ascii?Q?h9Th5S3CdXa3jjwacvT4gNDgXDxk87CN7FlT7/LFfXWvqPzYKvtr4+qkffSK?=
 =?us-ascii?Q?QcJ1bvccU8dZdmFkeL9arHsC6OznbopQNvdRT5i2O7XwQaCRV6X6HokMBPSA?=
 =?us-ascii?Q?72tOQofZthCw1yMeAgTHKzAOe2LSA2kteAUX06vIvrAvBMy5DU3fS4/c+dKQ?=
 =?us-ascii?Q?euzqb7OWtFtVVFo4SxcSmE/7vmleciVUaPPz2Y6zEfHcpGg0LkVc8kCljAT/?=
 =?us-ascii?Q?QXFNBhUPO34+V0ayGAnlJ+pfb87IehjHMVw6uczTuEYzF5OoAl8BldW71Ivb?=
 =?us-ascii?Q?hLI674dZ8ss8Fh5HU9gTX7+j6elQzWax2MN3JtV9J7iDcCAzvCWl2QgDbCQb?=
 =?us-ascii?Q?0pB/s5JFd/CY7OU1DJuDMjdwuhIQ+CRRWUDn4QixHd9r88K3mrmMx601WRo7?=
 =?us-ascii?Q?wJxPS7brI6prsmwIsFDFwuHqZ8VEjCuj3ncXnUkG24SpDuPc0N+fthbAmxQJ?=
 =?us-ascii?Q?b0gTv0uqkVGHxe9P+cpMf6kfaTEIEoY5umnJzBpFINdyYSCqyIvkNrIW8HI0?=
 =?us-ascii?Q?AzB0/hCST18Ks4zAqlsKst3MJSYt3mY/smoo3xAtbVSLJ7ozM9hShMnbFruR?=
 =?us-ascii?Q?iKo3UnL3AziciW+TMADrrz/25POiiuYFvfmhfnzefAvemeyRII41s+PBlKtj?=
 =?us-ascii?Q?lzvQ5d5DWut/qXixv/loXjRoCNdF8TSsqTAE2cV3tM/if0jWd3L1CjAoUXqx?=
 =?us-ascii?Q?gw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cac48e4c-b4dc-42dd-d40d-08dc11a035f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:51:37.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtMzcxIj0fDx8VJrcBZDvj7WZNNtaUNBXx0TxPR0p8n1t3w8JrX2bVxp27YoY42zszd2xCialA4Pbj2df6a3vDPEOXSqzywcy1JChiUcfJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Monday, January 8, 2024 4:28 AM
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
> Subject: Re: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt
> routine generic
>=20
> On Fri, Jan 05, 2024 at 03:09:23PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > There is no support for per DMA channel interrupt for non-MSI
> > platform, where the MAC's per channel interrupt hooks up to interrupt
> > controller(GIC) through shared peripheral interrupt(SPI) to handle
> > interrupt from TX/RX transmit channel.
> >
> > This patch generalize the existing MSI ISR to also support non-MSI
> > platform.
>=20
> Basically this patch just fixes the individual IRQ handling code names.
>
Will change the commit log to below, please check if it sounds ok?
net: stmmac: Fixes individual IRQ handling code names

Individual IRQ can also be used for non-MSI platform,=20
today some of the code name for individual IRQ has
msi naming, so change msi naming to irq to make it common
for both platforms.
=20
> >
> > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
> >  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  3 ++
> >  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
> > .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 +++++++++----------
> >  include/linux/stmmac.h                        |  4 +--
> >  5 files changed, 23 insertions(+), 20 deletions(-)
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
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index ba2ce776bd4d..cf43fb3c6cc5 100644
>=20
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -427,6 +427,9 @@ static int socfpga_dwmac_probe(struct
> platform_device *pdev)
> >  	plat_dat->bsp_priv =3D dwmac;
> >  	plat_dat->fix_mac_speed =3D socfpga_dwmac_fix_mac_speed;
> >
> > +	if (stmmac_res.rx_irq[0] > 0 && stmmac_res.tx_irq[0] > 0)
> > +		plat_dat->flags |=3D STMMAC_FLAG_MULTI_IRQ_EN;
> > +
> >  	ret =3D stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> >  	if (ret)
> >  		return ret;
>=20
> This is unrelated change. It adds the individual DMA IRQs support for the=
 SoC
> FPGA platform, which AFAICS doesn't have it supported at the moment.
> Please move this into a separate patch with the commit log describing the
> change.
>=20
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
> > index 47de466e432c..57873b879b33 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -129,8 +129,8 @@ static irqreturn_t stmmac_interrupt(int irq, void
> > *dev_id);
> >  /* For MSI interrupts handling */
> >  static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
> > static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
> > -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data); -static
> > irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
> > +static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data);
> > +static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data);
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
> > @@ -3697,7 +3697,7 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  		}
> >  	}
> >
> > -	/* Request Rx MSI irq */
>=20
> > +	/* Request Rx irq */
>=20
> s/irq/IRQ
> (capitalize)
Sure, rework on v3.=20
>=20
> >  	for (i =3D 0; i < priv->plat->rx_queues_to_use; i++) {
> >  		if (i >=3D MTL_MAX_RX_QUEUES)
> >  			break;
> > @@ -3707,11 +3707,11 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  		int_name =3D priv->int_name_rx_irq[i];
> >  		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
> >  		ret =3D request_irq(priv->rx_irq[i],
> > -				  stmmac_msi_intr_rx,
> > +				  stmmac_dma_rx_interrupt,
> >  				  0, int_name, &priv-
> >dma_conf.rx_queue[i]);
> >  		if (unlikely(ret < 0)) {
> >  			netdev_err(priv->dev,
> > -				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
>=20
> > +				   "%s: alloc rx-%d  dma rx_irq %d (error:
> %d)\n",
>=20
> s/ dma/DMA
> (capitalize and drop extra space)
>=20
Thanks, rework on v3.
> >  				   __func__, i, priv->rx_irq[i], ret);
> >  			irq_err =3D REQ_IRQ_ERR_RX;
> >  			irq_idx =3D i;
> > @@ -3722,7 +3722,7 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
> >  	}
> >
> > -	/* Request Tx MSI irq */
>=20
> > +	/* Request Tx irq */
>=20
> s/irq/IRQ
>=20
rework on v3.
> >  	for (i =3D 0; i < priv->plat->tx_queues_to_use; i++) {
> >  		if (i >=3D MTL_MAX_TX_QUEUES)
> >  			break;
> > @@ -3732,11 +3732,11 @@ static int stmmac_request_irq_multi_msi(struct
> net_device *dev)
> >  		int_name =3D priv->int_name_tx_irq[i];
> >  		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
> >  		ret =3D request_irq(priv->tx_irq[i],
> > -				  stmmac_msi_intr_tx,
> > +				  stmmac_dma_tx_interrupt,
> >  				  0, int_name, &priv-
> >dma_conf.tx_queue[i]);
> >  		if (unlikely(ret < 0)) {
> >  			netdev_err(priv->dev,
> > -				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
>=20
> > +				   "%s: alloc tx-%d  dma tx_irq %d (error:
> %d)\n",
>=20
> s/ dma/DMA
>=20
> -Serge(y)
>=20
rework on v3.
> >  				   __func__, i, priv->tx_irq[i], ret);
> >  			irq_err =3D REQ_IRQ_ERR_TX;
> >  			irq_idx =3D i;
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
> > +static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data)
> >  {
> >  	struct stmmac_tx_queue *tx_q =3D (struct stmmac_tx_queue *)data;
> >  	struct stmmac_dma_conf *dma_conf;
> > @@ -6107,7 +6107,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq,
> void *data)
> >  	return IRQ_HANDLED;
> >  }
> >
> > -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> > +static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data)
> >  {
> >  	struct stmmac_rx_queue *rx_q =3D (struct stmmac_rx_queue *)data;
> >  	struct stmmac_dma_conf *dma_conf;
> > @@ -7456,8 +7456,8 @@ int stmmac_dvr_probe(struct device *device,
> >  	priv->plat =3D plat_dat;
> >  	priv->ioaddr =3D res->addr;
> >  	priv->dev->base_addr =3D (unsigned long)res->addr;
> > -	priv->plat->dma_cfg->multi_msi_en =3D
> > -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> > +	priv->plat->dma_cfg->multi_irq_en =3D
> > +		(priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN);
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

