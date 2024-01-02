Return-Path: <linux-kernel+bounces-14144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF6821858
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E04B2158F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA34C94;
	Tue,  2 Jan 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbl6oQx5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945C6AA7;
	Tue,  2 Jan 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704184055; x=1735720055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SPnNS4vQJCePUqAGStkYCrcrxz9+lbNYVm9TAu8AqKM=;
  b=hbl6oQx5M/q/8e3SWUljCUBdypnMbTStKgOTJF91vy3a1SMfGby8wrpj
   PEeJhRaquzWkUiWZP7ADtv7x8nKOXRFcx10Pw7jDpJWYnSoxZPTPlLQrE
   XS7HYhGcH9sElrlJP7jk+snT+o/zSBN2drEubz6LfUUCTpi38rQuap7g9
   aylLxl87j2fW1yusfqWAr4r6c9IyJ3nn3lwaeRmGZJCyHhswCYnK/DqEs
   O8hHADutKz4Sobz6mNm1Ei1JmjEe7NAdKzSONHiV/Booyel72Y6ngHHPw
   bxJDUTLcnawgapjdXaAC+efeZw4LjLhe7qwiHDTpoIe2JoelV6Jgp/jAp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="3691636"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="3691636"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 00:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="779628231"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="779628231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 00:27:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 00:27:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 00:27:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 00:27:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 00:27:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/AUZvmO0ecGvqr8Md9qKqMRzHjJu0SyNoZ6qQThntjpjPOBhIdeejwVhLQ+DPWaeRcr22HEsrG0YrSqjvMduIT1G8OKs0AfZEsxm7eV82RqO5SGOb1Rhpxp65RxKuZAJclqs22sLeMlCcOasgEswNidvO5Vrwz/8Yt6aDT06B26U0vB4nkyR1kN3deWfIg+MnQiQyMey081S4lJ80C519XJzkjlD/7Xvy/ooPLSmULOggFVuvyQ/+nwqXROAwWNnLPx7ZKDjpPSb4/JhgNezPWXOdx2KflH8bk+Pld40umx/wKzGS53cdWKIjPgGCtpmGBI4B+ABZyRKF0xn7PKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAawjQt6/7KKWKXLRB0I7MzhxPWDj0aMSYUxdlb8OgM=;
 b=U7Kb+Ylj/bokmuqdfhdhq/Q/OL3u06lEBf2CfumAmwHd9Ma+hEQfF+riPEMi7dLM1zzoMI1c2vriowomRttCvaWt9xt5ScXQLwGVWwmPd9WlmWpGCZALUtwECEJ0IMat2nik865WjbJMC8oweFt9DEYhK5U6VRS6mBHYZxsXiGsy3xXnvUWIlprqKnvvYWrpgTbddk237m//EslMSXeonvqbyxZ3NTAu/vJRGoCS33Vy4hBaO4iZolPxNFrm5gLc778ex1HDp0MIVX1HQk/xmk9qY02yvy+6sxT06gfBZjq3v1bbHjz1cLgQtTnRogc762/shJgqYcvDYMHTetmPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:27:22 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:27:22 +0000
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
	<devicetree@vger.kernel.org>, "G Thomas, Rohan" <rohan.g.thomas@intel.com>
Subject: RE: [PATCH net-next v1 1/4] dt-bindings: net: snps,dwmac: per channel
 irq
Thread-Topic: [PATCH net-next v1 1/4] dt-bindings: net: snps,dwmac: per
 channel irq
Thread-Index: AQHaNJoqFae4hiA+cUOkbvpEsGd9vrC1Y14AgBDb9qA=
Date: Tue, 2 Jan 2024 08:27:22 +0000
Message-ID: <CH0PR11MB54904615B45E521DE6B1A7B3CF61A@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-2-leong.ching.swee@intel.com>
 <tly7rej6uz7r36j3nm2yk6mhrbdxkvwyphj3oosar5xd3ucpey@hv4dro7emw3h>
In-Reply-To: <tly7rej6uz7r36j3nm2yk6mhrbdxkvwyphj3oosar5xd3ucpey@hv4dro7emw3h>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|DS0PR11MB8069:EE_
x-ms-office365-filtering-correlation-id: 77629617-2263-47da-ec42-08dc0b6ca4bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGr3dNc4BG3jBGQGs81ZxqyJCe69zOy8NRKg/9spTdUbm2B1sQUOG3dWkwoZIyIq1519jhU8SoVEwrKG2QG3rg465DmSqKrwJrDDpGlwTen4tjFgxLe/qEgVTRNMWJAsNl84HdlKIvVAa2fAkqezGRxFEhjWtIbTbXWwqWSH+Cxp1HVEKwQ39nzNdlbdJI7GVVwIvwzn3PLXuvjPA9VHt7mhMqlp502zrvJnSabB4BCOP2f5Fb7U49F/UhuNDa4J77GYGqlSVUZVoKwEWjFKBX9/1/aRTGPMocVIjxxr84OaFVg3GcbepN8V/WOsAJzeAifJLGg0keWx53KovJaYAh0v2Mk4kN6A7niJODajhIrEvzwW//KbT7N5Q8wKGukWvJhSH2ashVpEAC2r0MAM8fAxBilFcjiwSIRdcW5hQGdtIIGAL2q8iH2e98QLixB63IMgiVjmZ5JtY9i4ffGLY+EopzApyUWV6+ftbW1gf6nLcplMorMz3WeFGKwN91IKPhibKeXXk5uwPoijtxy6BkFE+EyS5Y3VMkrsWmjEHpiI0fwb+76eRc5u+5311hMKtuz6Q69GitU7fmLyCNTxC9mmN2rcw2XKt49LvlP40WqDXiiMRFIf39Ol5WJW+Hxmwgsv0+LzgET6h10n/4Nctw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(107886003)(38100700002)(41300700001)(82960400001)(83380400001)(122000001)(52536014)(8936002)(8676002)(54906003)(316002)(4326008)(7416002)(5660300002)(2906002)(478600001)(71200400001)(966005)(6506007)(9686003)(53546011)(66446008)(76116006)(66556008)(66946007)(6916009)(64756008)(7696005)(66476007)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GodG9/1oXIRYoZlQ5RfWye2T5fuY3w9A1iTclbM6guQCUdfJ0VPFPzSNcbFU?=
 =?us-ascii?Q?W/UPExJXJgnMVGGgkQPyMlA1dPJCSSzOzdO4IF5oJAMwx7xe46z//hVCLZG2?=
 =?us-ascii?Q?IAzaSkewmavzijPNW5Gy5GfhrE4wfzCpPLXhVO83BS+n38hKLEmqBi68Y1NU?=
 =?us-ascii?Q?zb02+dSnsvGS+NTMGro8SlRSR8QD8e1/g6TxxQOAPyg1ip9YcYQRFXr+nhX0?=
 =?us-ascii?Q?eA7DtCDC0uCMiUAhwsYzEzZdafycBrHhmUIwo4ZisRjB0JY3o4ldYP6kAV7r?=
 =?us-ascii?Q?PxVLPZCNw9LqAIithWU+ta1nFu1A7bkQaDSYwcHbhRHl3IJck8p19+HONOyB?=
 =?us-ascii?Q?qZZ0x6OgkXLeSE5SXzU5RVhqU8YUC9D7yAbYeu2P9hQ2K56GSSoDKnBdxN4/?=
 =?us-ascii?Q?WXfCemBhOtvvmXutJ64nxI1rNHFNSnExD7exnXgnYvgiz+LYhYaTh370HV0z?=
 =?us-ascii?Q?dipXtiXsCp2xfoB5zCbdgw+Nx1ZfjXaZcF+uSJxLfbLfL1L0HyZf22DGLPVW?=
 =?us-ascii?Q?/d4NfIJieaIlAOKr1j1t7qlk9Y69VGfQUCtYc2tHcj3ToolRxVKTiutzk8mB?=
 =?us-ascii?Q?+9pTEp89gY+fJExYJcuJ0VG1qGWj33CtghGA+H+Iy9knjilCUvakeehVHwgm?=
 =?us-ascii?Q?J8bLptjo1j/H0VI7qJdXXWZBpOFHSa/DP5O03FcpN+SchvmUaUCvWrru/ckW?=
 =?us-ascii?Q?MLozRw1Uz+K7lkNu+Y2x4otjf/FXW4NiHAwGrGl3tpeVM+vrnNXhgHb1ug+/?=
 =?us-ascii?Q?4A3ejL0ahXQo0E8OHVh7PU1m3NE9n7er49YFZdwfB/AwEnAuXPlfGpkV6Zgo?=
 =?us-ascii?Q?78oYpiH9wCcFmBVbFAUjKjr9zUy7nwZxtqyN7/kIWVA78tF7i0+7/y16fCWI?=
 =?us-ascii?Q?ODrwKnYrQQDZS6QEzNaGbYitObfYapZ1ON/CrkN6BsiOqq08sqc+mUeGdrvt?=
 =?us-ascii?Q?g+YoAK2eqZEpztxgmWhM7xripNifU5w6Xmlyuaio+TGb6vlyLbGRlR/0tmiP?=
 =?us-ascii?Q?0yJ7x3uLEasd+EQQA3k+dd80R6dRygMWDHpku9eHkZkfL6ceIbZG3Tltii9E?=
 =?us-ascii?Q?rzTco+wHN3klrcSw1SGr6ols/hEEDS0iuE953uTrI6rklT4NZ48hEzeqG/0M?=
 =?us-ascii?Q?9G4GyVnI4HNy4nACpxC892jiVKmIvAaqVYVwb0XvlRwUkOMSIv+6JuZAxAMT?=
 =?us-ascii?Q?JX03bnL5JUeQ4/hMilItPQnYMelaJvaEUKLy+n2KiZS2PnTiKmvxy7A6H/Je?=
 =?us-ascii?Q?Nw9P4pQaSjkm/Q5lcHgw/UytCnxxmUnquOz7ocOPjzrCOhD0yc2YVN6rPEhP?=
 =?us-ascii?Q?ukS8ptpT9d4eKc/yZmX6SFg1176dqKJLJLDMSpI+tGYSpab5JHFMB6YOWZvV?=
 =?us-ascii?Q?uw0Gifzx05MFX8LHBq43365haOJ4QXCfjBBL0Drl8403yk9h5MSrPv+0FcMG?=
 =?us-ascii?Q?tx3OGqcfqWkACmXVcHvsiubYFwtaMX092RLZX+gjH97M7KZwCkpvDjdIZqHS?=
 =?us-ascii?Q?QmrIZCtGpQbpPWqaYexZqYzSaJLCa5oF3rETY5NkEvPRMrcolo1PRXA+jkF8?=
 =?us-ascii?Q?VFhUrjGJgr4xN1xccvvhSXAV6/55CmCeGh71Avz4euhrwfPX9YBeVoJ/ttBX?=
 =?us-ascii?Q?3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77629617-2263-47da-ec42-08dc0b6ca4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:27:22.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrEwB0v20fCx+DS3YPDH/HxnQRBTmVxtSKGK+cnZ7vdVRSWNJYaSxQ1VbVjSLXq38NagTYXobsGfQSmbU66i2jrKPjgRVwlZxkcO8ix9w2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Friday, December 22, 2023 10:51 PM
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
> netdev@vger.kernel.org; devicetree@vger.kernel.org; G Thomas, Rohan
> <rohan.g.thomas@intel.com>
> Subject: Re: [PATCH net-next v1 1/4] dt-bindings: net: snps,dwmac: per
> channel irq
>=20
> On Fri, Dec 22, 2023 at 01:44:48PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > Add dt-bindings for per channel irq.
> >
> > Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 +++++++++++++------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 5c2769dc689a..e72dded824f4 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -103,17 +103,27 @@ properties:
> >
> >    interrupts:
> >      minItems: 1
> > -    items:
> > -      - description: Combined signal for various interrupt events
> > -      - description: The interrupt to manage the remote wake-up packet
> detection
> > -      - description: The interrupt that occurs when Rx exits the LPI s=
tate
> > +    maxItems: 19
> >
> >    interrupt-names:
> >      minItems: 1
> > +    maxItems: 19
> >      items:
> > -      - const: macirq
> > -      - enum: [eth_wake_irq, eth_lpi]
> > -      - const: eth_lpi
> > +      oneOf:
> > +        - description: Combined signal for various interrupt events
> > +          const: macirq
> > +        - description: The interrupt to manage the remote wake-up pack=
et
> detection
> > +          const: eth_wake_irq
> > +        - description: The interrupt that occurs when Rx exits the LPI=
 state
> > +          const: eth_lpi
> > +        - description: DMA Tx per-channel interrupt
> > +          pattern: '^dma_tx[0-7]?$'
> > +        - description: DMA Rx per-channel interrupt
> > +          pattern: '^dma_rx[0-7]?$'
> > +
>=20
> > +    allOf:
> > +      - contains:
> > +          const: macirq
>=20
> As Rob correctly noted it's also better to make sure that 'macirq' is pla=
ced first
> in the array. So instead of the constraint above I guess the next one wou=
ld
> make sure both the array has 'macirq' name and it's the first item:
>=20
> allOf:
>   - maxItems: 34
>     items:
>       - const: macirq
>=20
> -Serge(y)
>=20
  interrupt-names:
    minItems: 1
    maxItems: 19
    items:
      oneOf:
        - description: Combined signal for various interrupt events
          const: macirq
        - description: The interrupt to manage the remote wake-up packet de=
tection
          const: eth_wake_irq
        - description: The interrupt that occurs when Rx exits the LPI stat=
e
          const: eth_lpi
        - description: DMA Tx per-channel interrupt
          pattern: '^dma_tx[0-7]?$'
        - description: DMA Rx per-channel interrupt
          pattern: '^dma_rx[0-7]?$'

    allOf:
      - maxItems: 19
        items:
         - const: macirq

I am getting the warning/error below when I tried the changes above (but it=
 does make sure macirq is placed first).=20
Removing maxItems create other error, did I miss anything?

/home/swiplab/build/jim/linux/net-next/Documentation/devicetree/bindings/ne=
t/snps,dwmac.yaml: properties:interrupt-names:allOf:0: {'maxItems': 19, 'it=
ems': [{'const': 'macirq'}]} should not be=20
valid under {'required': ['maxItems']}
        hint: "maxItems" is not needed with an "items" list
        from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/swiplab/build/jim/linux/net-next/Documentation/devicetree/bindings/ne=
t/snps,dwmac.yaml: properties:interrupt-names:allOf:0: {'maxItems': 19, 'it=
ems': [{'const': 'macirq'}]} should not be=20
valid under {'required': ['maxItems']}
        hint: "maxItems" is not needed with an "items" list
> >
> >    clocks:
> >      minItems: 1
> > --
> > 2.34.1
> >
> >

