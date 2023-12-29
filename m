Return-Path: <linux-kernel+bounces-13071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587481FF40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75E228371E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63E111A1;
	Fri, 29 Dec 2023 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7GJJSWx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489511185;
	Fri, 29 Dec 2023 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703850671; x=1735386671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9A2T8rtE8fPevl1X5IDWOUyfJK24mLNpkXd1HhG04Q=;
  b=d7GJJSWxlG5GvICQJzZhn9S6ztZn9Jtp4vggnLIbIYwOJT2XqtdSeAV7
   9BfVPjoQkag/j/U0lqt5rDr1FdQ09lXzDM0dqs1sR6W8ELCI9DEeHpIz9
   0uQDDsZPveZnNhZ/R5r+CXXFS3f4fCCfhhWWaF1Yd04bCydTzdfGiw8e7
   HHrrK75yyG9QsYL2tYMSuNZyrO7SkvsXcKwLVygGmqdsDmUuJUf4HXbUD
   jwmeIIlKEtbkHaaccUJAG+UeKCXlEznu8WIqiQrVF4qwPI9npg+qPa8Wy
   gTXPdOG8qKxI2ZFSbxX0xOxgkUAK12lUwCVDx0MeWZ9YqQ6Y9JdIwfQB1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="396369344"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="396369344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 03:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="728582783"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="728582783"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 03:51:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 03:51:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 03:51:09 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 03:51:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiskfCrNjYz9hwbUxtPQ48XHk8QOQ9lmCM/0HWDBtX3exb9Gr7WSyC7MzjEMgQ87e33t1y0506eFozSg7/8zg46NEMl5yeAK9eQ1pMr+M0AMSAxGL2uE1RiN9ChZTJTHNk5HeaUiI7Brny68ZvWutvpTBMJr4fzUgdrvN8BGG3NKzlcUQv2UUQBzarjMcUR1tKVFHZ42tyDPTzzTESjjNGEe5PdcrI0kvbmUFB+C+xl2DFebW/ftwk/lmuM+R49DCwnK2CJHs47he+URnVIcCsHHbz7L4yea7Ic0TJhqtJACGoQD6j/f5YjRPFey66RQYusgEjNh3wGcPVYlWjIyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spFPFJfru2UlhXsqdxf4z3VfqRAFTOQWrlbiOu7AHnQ=;
 b=AGINBkAY7Ddjc4tTKkf8zjW4qd2c+EO53VVpSKoP8a3NePEesHN8I63/MRuew+rEpePkqkOyvp9PQtqa6APmNWQ6QSCqH0M5BxpWixmz/n5KtLkRZSfR4a/fNU6sembsQJYCzHxksbAknlk22tqGlOkfyiNYPJiCQu/bb/LUVrZuMFdOVXKBm4wtf9soNeA6I3+rOTcOp3zG0lS47ztQlUWIKdB/faCEV6EoLphmTjxvWpORZUN2k35NRLvhyNzDbESqhiJtFhanugBml7heu98nH3zGrsQDLAQQPdUu81VjZxxbFwdRmDlFu9aSDj2Dymn/u5/gJx4acpwz34qMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 11:51:07 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 11:51:07 +0000
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
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v1 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Thread-Topic: [PATCH net-next v1 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Thread-Index: AQHaNJo+8U9tJ0DEGUmu+Vd+sNpgu7C12k4AgApRhVA=
Date: Fri, 29 Dec 2023 11:51:06 +0000
Message-ID: <CH0PR11MB5490FBE567511E89C8F80BE5CF9DA@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-5-leong.ching.swee@intel.com>
 <prjrrsznvpnbanseqttqgtu3s6kgillyyhs5hozwxwh4kt7eiv@zmups3rcbvby>
In-Reply-To: <prjrrsznvpnbanseqttqgtu3s6kgillyyhs5hozwxwh4kt7eiv@zmups3rcbvby>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|SA2PR11MB4922:EE_
x-ms-office365-filtering-correlation-id: 2abcce0a-192f-4a88-9252-08dc086470ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ls4klg80vkckhyfLFJc2Ms/FXyAjJ+prs3Urh4FyYhHn2cTPHShr8qitkfDCLL8uskizKinGgyxxvNGv7TMoGPRgNiacSiSpS+DjTrhQtzBqCneoXpApE/jpCh9VJqj6nSC3eF7hti2t9iz/4BA+k0nfjLuN/X33cq+DM3YaFwPqRXNR9sQ8PXwanbIgoViDE2iZYiSocZJpr0xn0alBdobtS8uqthNLszcou6WXcpNTohR9X40/UyfzNME/j9yknoQYFZHv6BBWlUmNJ+jDg3LBKHKRWlL7SBpqn2CWce40kAZ/cd+cqPJaXp31CSASQoIRIXcd3dKdTo7Io4HgDZ8rI5dYFXgmlnDCeWBJbufaYjBCmdGHxt7kmBY26X5R+YVcnbdxW05cf3HS0xGO6ajNXTugQxQSyEz8+wVJ9PA5ArvvaPh2oD2oDva+4+ddGMvBeH8o0iZXmT1HITN8FWeoFuIUgellZRDul/5Vt6rPhbcDxxUhqQU+fBBXgBAlTaa2ThcpVWFcwe3PQuDCrZTh5S2SF2KsCyZTDa49EPDla8HAv3wgdE2byb4IVj2cr5YWCNxxi+MbWgJHSqDw0N7YgNTCHyp2rr9aJpWTdVAR2jgCvNzld3hCSkh0JJ8c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(122000001)(478600001)(55016003)(6916009)(86362001)(9686003)(54906003)(71200400001)(53546011)(316002)(6506007)(8936002)(83380400001)(8676002)(38070700009)(66556008)(5660300002)(66946007)(76116006)(7696005)(64756008)(66446008)(66476007)(52536014)(7416002)(4326008)(2906002)(33656002)(82960400001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WN7iOskPt5Dj35PN0FKtEfSZCQo2wa4OYeBKPXCAPKI0TIOOuJ16HFXexoLy?=
 =?us-ascii?Q?p6dEoLFzJ1VOmejbZzeE56RpJl/Nzt30CpVORtfY7S+UoS1+i8r3dqMTc9wU?=
 =?us-ascii?Q?V9ZtUdTGkzaB+7xOeKEBHafs5l+i+V9hnZ1GCXeEAIDDvKM/I+OM0OMrFXyv?=
 =?us-ascii?Q?Qc0YTCf0TIpaC+WcgQxEkhxsdNFf4Z8+r6nSh37IdozdH/R9tIri8wOWwpSK?=
 =?us-ascii?Q?/EXHAVjUTNOrtUv+o7gbqkjNfOB4k3W6nE4REj9O4uTpysn8r2UozovuCyUf?=
 =?us-ascii?Q?OYcJWbfsK4rk8t8vAv+oncPkvP2TeO7gq8qOUq3oT3SWDv5RjiwzP8RRRCQJ?=
 =?us-ascii?Q?izfQMewtJbu9/VBBloFH3oDxhT/xQHLEIaZzjRMsGnv5Nzp0aIAX1xgGhel5?=
 =?us-ascii?Q?GJ4rTNUnvOVM6KmvnQEsQIZdXTmB6IjH0E5vatCzkZLof+zLZ1wKR3tyhyJc?=
 =?us-ascii?Q?1yyBDGlHnnQ0DfSOEAa+9vuVv5FLde3WpeuLD3cUefmfXxIEuL7F2240zAgc?=
 =?us-ascii?Q?wD5fCcK36s6kk0cttW/tag7OvOmQ2eKiz8oo8dUSkkNvENjdTgreB5wCvpYb?=
 =?us-ascii?Q?5/RaZJsFpo2LLU3Vq0SCKfFLcqaGhLiLMQPINaj5oNuRMjw/VfS+1QYQGglR?=
 =?us-ascii?Q?UZXzcjp1jrqQZ+5yB4Tz10yEx0NWO794NG2dFrg983bS9hL03NRegXpsT7Zk?=
 =?us-ascii?Q?yCW+lUSc7qFVj5lVXU8DHah6NLq5YpUFnURReMHf5r/xG26LAwcFmXjNU8E+?=
 =?us-ascii?Q?2FeJqZ341x8ZqlA3OsgyjgFuiHmzxoQ4j7NIHF3y1cdMcTegZCjotBb4CqKz?=
 =?us-ascii?Q?35r2E0FEJZsql0PQpmjY4TVVyf/IJTu/MkKXvNCHGWx5tciOqn+FxHeoyxd3?=
 =?us-ascii?Q?3dD+Ra/O928W0s7ZpV5hjh/R8f0oSeMuaB2wy6kK2CRIf4WcQRgdovs2wyhn?=
 =?us-ascii?Q?xFrD+eKwNvCRtV7remOyjY737KhaK8Mdb64PfVBDxiMBpXUJBGrT4vOV2fuB?=
 =?us-ascii?Q?CHJIRkPHUaGjoy8+SfhVMHHJ+/FKwNf5yjxikkTJUfdT5amd2n2k/I68pTR9?=
 =?us-ascii?Q?8f4x/P2YS9rcSKkDoKLJxCXn0QC1coedjb59Um/QUo2+hUr2cFwUL/aUVomE?=
 =?us-ascii?Q?95oEQ2NNAbLZVGm2Wc3vBtsgvBmIMssYdfE4jXMJ0++lFv+x01UztJMszqvi?=
 =?us-ascii?Q?U43KZ+r6tLwGE1j/97YaTJxvs+UlPMyubYqf6oI8RdaD2fr4paq76ektN0Tb?=
 =?us-ascii?Q?TeSE8+nMK0VWyvqeuGDWdXCxlVOqZuVzWNCtMRzculGUls7eyJSwx8F+58tZ?=
 =?us-ascii?Q?Zx2k/S26pJKJlxmmqJUnPL0DFwEZDy/U3Q/JtMRzkvgPVDU/wFvs08BsdXu4?=
 =?us-ascii?Q?plFhox5eEGLFzfez0y3GFgceK9JGRKNxoCmu4yQPWlWnvtO26M2RNxN0BEyL?=
 =?us-ascii?Q?wxw7OqNyBZ5DvqzeM9YWqFXyVNQnyIY+ZPt4mWiEzuIihI2YV8Eluie5zSxc?=
 =?us-ascii?Q?OOLHCLTXo2i/9cq5Rkf9NeKOD4JhDQ6P8AbelmhMJS24qVTia3hzdF6zcXz8?=
 =?us-ascii?Q?ffotK079wj5PmZSMhXc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abcce0a-192f-4a88-9252-08dc086470ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 11:51:06.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHvfwaXR8dSylyBf19EIeo7HWyiHubywFXJ9rkrKXSqZwfRuS5PBmf3NssgH6b7g49WIcD6kgz7AsV250Kn7ScqbuaeL/wn4sUpMQ3MCMDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Saturday, December 23, 2023 5:57 AM
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
> Subject: Re: [PATCH net-next v1 4/4] net: stmmac: Use interrupt mode
> INTM=3D1 for per channel irq
>=20
> On Fri, Dec 22, 2023 at 01:44:51PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > Enable per DMA channel interrupt that uses shared peripheral interrupt
> > (SPI), so only per channel TX and RX intr (TI/RI) are handled by TX/RX
> > ISR without calling common interrupt ISR.
> >
> > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
> >  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++-------
> -
> >  2 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 207ff1799f2c..04bf731cb7ea 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -346,6 +346,9 @@
> >  /* DMA Registers */
> >  #define XGMAC_DMA_MODE			0x00003000
> >  #define XGMAC_SWR			BIT(0)
> > +#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
> > +#define XGMAC_DMA_MODE_INTM_SHIFT	12
> > +#define XGMAC_DMA_MODE_INTM_MODE1	0x1
> >  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
> >  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
> >  #define XGMAC_WR_OSR_LMT_SHIFT		24
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > index 3cde695fec91..dcb9f094415d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem
> *ioaddr,
> >  		value |=3D XGMAC_EAME;
> >
> >  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +	if (dma_cfg->multi_irq_en) {
> > +		value =3D readl(ioaddr + XGMAC_DMA_MODE);
> > +		value &=3D ~XGMAC_DMA_MODE_INTM_MASK;
> > +		value |=3D (XGMAC_DMA_MODE_INTM_MODE1 <<
> XGMAC_DMA_MODE_INTM_SHIFT);
> > +		writel(value, ioaddr + XGMAC_DMA_MODE);
> > +	}
> >  }
> >
> >  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv, @@
> > -365,19 +372,18 @@ static int dwxgmac2_dma_interrupt(struct
> stmmac_priv *priv,
> >  	}
> >
>=20
> >  	/* TX/RX NORMAL interrupts */
> > -	if (likely(intr_status & XGMAC_NIS)) {
> > -		if (likely(intr_status & XGMAC_RI)) {
> > -			u64_stats_update_begin(&rxq_stats->syncp);
> > -			rxq_stats->rx_normal_irq_n++;
> > -			u64_stats_update_end(&rxq_stats->syncp);
> > -			ret |=3D handle_rx;
> > -		}
> > -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> > -			u64_stats_update_begin(&txq_stats->syncp);
> > -			txq_stats->tx_normal_irq_n++;
> > -			u64_stats_update_end(&txq_stats->syncp);
> > -			ret |=3D handle_tx;
> > -		}
> > +	if (likely(intr_status & XGMAC_RI)) {
> > +		u64_stats_update_begin(&rxq_stats->syncp);
> > +		rxq_stats->rx_normal_irq_n++;
> > +		u64_stats_update_end(&rxq_stats->syncp);
> > +		ret |=3D handle_rx;
> > +	}
> > +
> > +	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> > +		u64_stats_update_begin(&txq_stats->syncp);
> > +		txq_stats->tx_normal_irq_n++;
> > +		u64_stats_update_end(&txq_stats->syncp);
> > +		ret |=3D handle_tx;
>=20
> Could you please clarify my comment to the original patch:
>=20
> On Fri, Aug 18, 2023 at 20:10:21PM +0300, Serge Semin wrote:
> > Just curious. Is this change really necessary seeing NIS IRQ is
> > unmasked and it is unmasked-OR of the RI/TI/TBU flags in the
> > DMA_CHx_Status register? Moreover based on the HW manual,
> > DMA_CHx_Status reflects raw IRQ flags status except NIS and AIS which
> > are the masked OR of the respective flags. So AFAIU NIS will be set in
> > anyway if you have RI/TI/TBU IRQs enabled.
>=20
> -Serge(y)
>=20
Thanks for your comment.=20
From my test, NIS bit value is 0 once INTM is set, even with RI/TI flags va=
lue is 1.=20
This might be the reason why previous patch set had this change.
-Jim
> >  	}
> >
> >  	/* Clear interrupts */
> > --
> > 2.34.1
> >
> >

