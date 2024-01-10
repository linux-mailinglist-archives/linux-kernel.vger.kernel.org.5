Return-Path: <linux-kernel+bounces-21729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD482936A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7113C2890AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C533DF71;
	Wed, 10 Jan 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdTfWXz2"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675153C2F;
	Wed, 10 Jan 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704865411; x=1736401411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9LeWQvpjNmTLEaW9nEPRpH/KUL4udXhzr0YhCQPv5Zg=;
  b=JdTfWXz27kKOEiqjEs7QIl7eoKs/EGUFxTxpSLu4O1jrxDrN2bHbS9+S
   g9NCwQmuGg+i+8Ui8vaqCCR5CSuk1JGjZV/m8ZowPBqPF4E2UYEbM+B1q
   z1S5JeLYI/5R7gzQkGC0wfkoTB1T3Gnk0egotB2lqSKAjC9ZeJUbWQnEy
   rV4qe6kJogurv7x1ezafry+isjQtAJ2fDhtGNNe7Q/DWuiCzLcs9WVu93
   2K2JWjQn1/Z03ScjnOuFbtv2n1A1o/w7S+dVVUCI13kqzGhILpwNv/ocj
   k0Qq4PCmi42vBjSjt8GgU4BshNwfn8LlGY3t30CWll5jPx7KMQF80/p5y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464817952"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="464817952"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955253992"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955253992"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 21:43:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:43:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 21:43:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 21:43:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG3wQ/msB5tJrVQuGUscXkx14patpe76hYFbClrIL4F+Eoau7M+pO9+bjOUqhqnxNWRQQTF2ItlsQU+TB0Q3ucpJw17LBrGvspR9cL38MhiTwszmvZaXMPU2mQKPCnkBTDYX6iOOwbpVMB3/DcLcmGo8ME8DwWt5aT4nRFlxRVPTtSqXC4W79xT5Zsqq9riXqYKXq22YX/eO2NaUxG9/FOxnfts+rFuCFdlb3HTz0Z4amd1njs+WmgruySp2Yu+Gs6GH4PboKmds0v1vScDm0Ek7Ji39hwFgP9VSBlx9HXoOrJUbx/UV+GIrQQ/wo988Ooweo3PETe9Jof9Av5gceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDbVyoDFLBBmkvkzNA5M4HI080FtJawbx6UOlkQu0es=;
 b=h/z3YWUIToWuILbeUgDcVIW1IniJ90BSh8/BjQkfDzVwpNzdLad1zHc/I5eO/NdXQeC9w4iFpYbkxmzPXFrqy6t+lmWqjfDy3l8ete9YLCZ4hGfEJ3ZWYaZAE779Nms5iTfm0lvcZqB2h+0qbUHg2TX0Qkxhj92DIxT7t7ZewQihHybLITKxPCB+Q2mYzp7dFHy2x4n3zaGuZbnOG9HFoJ26zzLDoQhDKYCNcreC11ilBKpNb4903z5t1KIW9wZ6THiveDE4Hde5y27zG8EKo6tM2lysOENyqhanUGs5djPejUT3lljK/Rqc5bNrBIo0ehZt5gnuZpt0iqF12zmXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by DS0PR11MB7406.namprd11.prod.outlook.com (2603:10b6:8:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 05:43:26 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 05:43:26 +0000
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
Subject: RE: [PATCH net-next v2 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Thread-Topic: [PATCH net-next v2 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Thread-Index: AQHaP6ZCdgIftjDRek6/+MvG5uqIGLDO13iAgAO41fA=
Date: Wed, 10 Jan 2024 05:43:26 +0000
Message-ID: <CH0PR11MB5490793807F66E011A31D1A3CF692@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-5-leong.ching.swee@intel.com>
 <jvnoq2jo3dzsw3vuqzathjuyox3xipaullzeaur3ppzlmtux5k@v64tckj7pvo2>
In-Reply-To: <jvnoq2jo3dzsw3vuqzathjuyox3xipaullzeaur3ppzlmtux5k@v64tckj7pvo2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|DS0PR11MB7406:EE_
x-ms-office365-filtering-correlation-id: d2996251-adc3-49c4-7754-08dc119f115c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5dIxIkO94TVETokFytmW7oo71vqKG8kVOtKMFasZ0ojCFkVtQjP78uMBOZyZjZT1Td0urRNWTjWr7U04vZppUnZ0FhYqnZo5Urm0Y6NOqkEPwCL+KUZ6bd0JmDd4cxZrCw1ddPipfr1jdQJQX7G69ER/Wr9KQtl25FjRE7DYQmPpdwAMuL3SdGBDU09Uzm7/q/5J+4tQaNqsRym03BllxOe/nVDwVeVSfO0/XFN6ZTd3lZlj+UJ2v1LQy8dnVLkLN+ysrZyFEJzlwvGaGYOWeGF/XmWfFfEZ8vRXC9cCvCMCU8o3cwIetARkVvyL9rlGSfToD1hD1xGvW1qyEDeFpGK1VdMkUHTnAGwmW6eTY4nuXpTHko8mcBdmIpV7APsimjkjFgQwkMLHErSrcR6jgrV6gSH+w+hQ/280IBTORyF1o26JdWI1GTil8eWsMMXcQo0mBqQ7yObJ/AFaBC7clIsPKVlhpj1ogjMS2qftIn4Yp6i0TLnuilr6loKjB6ZluAi12s3sRHJpMLl8DuziEVt/m0NYoPZk0aIlm536+ySW5mzsE7TAHx+KEbWPbS2O3Z0k95zyQN/6zVPOB0eOkwqt4uAn0olTrEssncFGzgn60ZCc576RL2zg4NcEDRxR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(9686003)(53546011)(6506007)(107886003)(122000001)(5660300002)(38100700002)(52536014)(8676002)(4326008)(8936002)(7416002)(2906002)(64756008)(6916009)(54906003)(478600001)(71200400001)(66446008)(66476007)(66556008)(316002)(7696005)(66946007)(76116006)(41300700001)(33656002)(38070700009)(82960400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E2VT61W9+Z9rB8VXbHM5dkWDvexNKV1zhsqOwt4q8tD3KwcRJ6OaBbrsnN2q?=
 =?us-ascii?Q?nrTrQ6iDeOw1vx8kVxAYlg4gk3DPBaC6F4lPb4INF9wjbD2Sra4s8n8XNTZJ?=
 =?us-ascii?Q?kjWkaSflOw4tJoAxuuWIlwz2bBBHmHwwUSHVoTNaKC4mukQVqN+FZw9/D0oC?=
 =?us-ascii?Q?lewua/zFVKZWQUCGuHYfwxjBOcGdemkV0q6dU6UIzS82Oj0g4cqhUZ+VXO6r?=
 =?us-ascii?Q?FiIemqDyr2H73La3sv//G4oStsYoi0e1K/TAKp9JjmdBh9Lzkm3qdPijb+Ud?=
 =?us-ascii?Q?NBurocIeiYg55ZDYXz68jMcoTh0UXzKZxLNvtgBGycZYG0V6pEcy4zf92LOa?=
 =?us-ascii?Q?iBTlAqyZKyW2XSvG4bZarHkSpQVzHemx2CLmlqTTZgHMMbCJmwQ5hV/Mso3V?=
 =?us-ascii?Q?732kH59mpGT/3m27DtY/GmILvDgPU45J2Wimsh/NuBwcBz5Xo/BLH4/Z9QnY?=
 =?us-ascii?Q?tpxCvsUwoQVwgzAstQZb0Vx3dHzy6mluykxMmiqPbnrTszBB4dyE9jTgdNkz?=
 =?us-ascii?Q?2Cv/t/1bxF+6ywGhzGw+vnZfDiGHTnBKGtUYSuOjhfBdHSma/SogMQNJRZ5w?=
 =?us-ascii?Q?kCpLxBkirC69PwdjGyUS5ewZpZKr+/BCvUhqwma5DAQRHYUG4FAmUfd77JN0?=
 =?us-ascii?Q?Dkx8adM0wAwyD2f8Zy8N6vE9fvnECel8TXOG5+X8VnfHklqz8rGJjsZJqDJ+?=
 =?us-ascii?Q?MTnfYViSdugIKOA/UuTsAmE5Qwi+1qcclAZX+n+P1i5AOwdvvag05xGqps8N?=
 =?us-ascii?Q?CsNbgqYQrZqzTU3nuopeBjTRmbFUTjRm7WLMx4m+EmhTYmeqJxhqWxIYeUWm?=
 =?us-ascii?Q?lafBNPqRYLcUPAx9jVHnajS2pQalfTBc4yTJji+jwkyhyL7mNXG1O619To2H?=
 =?us-ascii?Q?DJeISgHTki5CwteDZFaRfNpvK718LC9o43bmCYI6o5wjakgS7ZkdIHUH5h8c?=
 =?us-ascii?Q?jg04o38kHFFOuuXXlviwmPv3Q+rhUxmqX7D4Pco/1MY/0GdxFJTWbxLxa3r+?=
 =?us-ascii?Q?AsVMK8CZ2l9R/Fgv+EM3AJzSghLSmds4OGAWhlMCZ+ucNyQ0IncocJbLemXM?=
 =?us-ascii?Q?T8fJgzI0cSDfcrQfWhX2Gpbjln31nzzMW1J5rxqiawe1HjnlckieccqAuSRR?=
 =?us-ascii?Q?beACYUkJx+N4y3IEWmg7t+dsKGfsU6rxmZf9vc95nSJ4J2epMQo5SN+k4rEr?=
 =?us-ascii?Q?WyXjWht/DbcFWNz7CRIdr9a/N8ZVYabOclT/lyoiN6MXkNfXtDJN2cvGj+aa?=
 =?us-ascii?Q?4jwZ3sKYgZXsFYwRkPQCwLW1di040TLqC6FGn8vAQzUtca2JuzPbrSyBoo0g?=
 =?us-ascii?Q?OKXBPbiQlf5GVk939T+qHekyUwuXmeYrGhMw/rXwunWCDUHEsoghMgzOoLs3?=
 =?us-ascii?Q?Kfykh78KqeDgyr0uqLYe1SbdRryIQcjU0/x4RVwnraDGLncAucxP9CwDXRSt?=
 =?us-ascii?Q?/wpddueSdnTyNmnT5KzjeaeRo67A4+/or1Uqd3L8vnT2WNaqL+dpyvXBNVIN?=
 =?us-ascii?Q?Ii1UQCWPH1jCIv5rFJrRpIKxORPPxd/R4c7BP5i9BoiZDvfZ+LtWNhMd44Gp?=
 =?us-ascii?Q?EGA03iZY2EI5cdn9epyC2BayybY4vvvDDp5WIQG8N63Kg5snk4piHztHMHoK?=
 =?us-ascii?Q?uQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2996251-adc3-49c4-7754-08dc119f115c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:43:26.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeyWWLfRAPrYwnIFoM8p8rJqh2dr+Q6Nsy1j34x/IuBF4IctSAXBnYsIac3ZzttHeFgL08YcJlyA7GHd/NWXQLDUtRNnBNuHHTPTFfRqpYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Monday, January 8, 2024 4:52 AM
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
> Subject: Re: [PATCH net-next v2 4/4] net: stmmac: Use interrupt mode
> INTM=3D1 for per channel irq
>=20
> On Fri, Jan 05, 2024 at 03:09:25PM +0800, Leong Ching Swee wrote:
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
>=20
> > +#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
> > +#define XGMAC_DMA_MODE_INTM_SHIFT	12
> > +#define XGMAC_DMA_MODE_INTM_MODE1	0x1
>=20
> AFAICS the DW XGMAC module doesn't maintain a convention of having the
> CSR fields macro names prefixed with the CSR name. Let's drop the
> DMA_MODE suffix from the macro name then:
> +#define XGMAC_INTM_MASK		GENMASK(13, 12)
> +#define XGMAC_INTM_SHIFT		12
> +#define XGMAC_INTM_MODE1		0x1
> to have it unified with the rest of the macros in dwxgmac2.h.
>=20
> Other than that the change looks good. Thanks.
>=20
> -Serge(y)
>=20
Thanks. Will rename the macros in v3.
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
> >  	}
> >
> >  	/* Clear interrupts */
> > --
> > 2.34.1
> >
> >

