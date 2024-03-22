Return-Path: <linux-kernel+bounces-111409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8A886BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950F4B24EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2543FE2D;
	Fri, 22 Mar 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9+VeJG3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A2405E5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109536; cv=fail; b=LsCVemvDqxsOZtFJS2+0XpV2V3p0GWrxQl5ck09CNKuQU0xA7k4g1W/wcFpCJGPt2j5iXr9JUeE+ia3ggX4O3OgKayWSPd2ZobPJY8iGhG35dLMB6aefEKyfK8+M2TFLuBz+t2hf5k5M8Qyd32BuAxFnHozu7kPdJX3c7Bnx26w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109536; c=relaxed/simple;
	bh=BPxY2nA7ofeAc4e/DQYGX8yiDwHkY7ouWG7cDp8YaAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NdPPEQQD68MYUHUgAheOmp2J6icrQGn1WeIgzdg/GETNOQZtQMqcYiS7TPupGVAQfP/PSrR7p0zSWQxQl2m005zOxm3ePWoAAuc8WFvgeT2EZAK2E9OZm5fXPW1eI+7K+vGE/uewpMK+B7IUDUl/q/q9/mh8hcOfy0Nz/GKPErA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9+VeJG3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711109534; x=1742645534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPxY2nA7ofeAc4e/DQYGX8yiDwHkY7ouWG7cDp8YaAA=;
  b=l9+VeJG3C69G4sbGAYFlDcjs0IOdM9vTbuy55dsrKXwSNuGkLVY5hThq
   tzbP/i/okk1yPACYiFKZ95DSGFkE8qzeKvzsc5s4roxQr8kaKbBniRg5n
   3KYERNOzzZDEWTvqiwj9s2WmRXNhhrfbgEx4bhQznBJBUK0O+fOboB/Yt
   51dRJ3FGj03zo1RJhLM1AqqhO71ZRD6wsQ2nOsJTUbxddCEHESKMWrkVj
   Q2kHop3AuGvn5Rxa5kpdEr3GDlJllPbifAI3MnFujpwdTX7+xUHwRpnC4
   qopw9bcFzNNftNqKtLLpQItxLTI3rdgjGHQqKosuYu2gRZWxWtPr7nSHh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9958396"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9958396"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14853565"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 05:12:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 05:12:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 05:12:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 05:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3uvX8hwXeD9t5eV2awFPOTXcG7+7HDk/62HN1MI/TI9Xc0geimPI/lKgj3Bjhmv14Vcig9lSvTx61WvsFBiVrWBtZUy4O+1058U1/MOA8bZM5BDObuGJAr0AsrHPExM8zJbuslPy5jggcp0ijMmkTFWxqfXyCWIHP29BOUXC239/+9/N99U+zB925BOEdrw1rXmkjk2cXuvYLaa8f11cwon3s3jsEQtXFoMwkGDLYlKW8fyuECutbyOB+OO/FCRS/QF0tWrvIlVkJStkBb0iaNrmybyRrcL9r+MUiVHrbP725PNgmhMVSGw4d+uSytYBycS3aJyKkHvcln2JUMM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysDgAvpgvLWJp7Qj+JbiyFhJYabLRKEVEg2slMHbyUY=;
 b=njz2XuRvgq6Rc+IuReqwDWmzqGZKfUtOrgLQLz1Zl2aBvT/bAoccOaiTySDV+wvGbuKqyFzIwMW/vx2pMoMCI00oF0lXMyrlTGYG6xEHkv3Tix4ZlYZGp0eUU8x7eO4dIUA0MXnoyOpCKY8QF8m7lt0YDnwCTR6RG9hD5L0hkBDtQ/EdiJ9zkHBw0XHgjvMWtJequ3BKRKXdCzNSV4CmtpGLHEDT7z3HMGneyCEGNhMia4y9zRDA3wZ/cD8Ijx8SOasGRx7fnrjCFJ35/UI0VtJC4z7ecYarpOoUniyFL9st65RbYjxy/YbJByWeTMTYf26yYW1wMBerALV5yd5wYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by SA3PR11MB7435.namprd11.prod.outlook.com (2603:10b6:806:305::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Fri, 22 Mar
 2024 12:12:09 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:12:09 +0000
From: "Prasad, Aravinda" <aravinda.prasad@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "s2322819@ed.ac.uk" <s2322819@ed.ac.uk>,
	"Kumar, Sandeep4" <sandeep4.kumar@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Subramoney, Sreenivas"
	<sreenivas.subramoney@intel.com>, "Kervinen, Antti"
	<antti.kervinen@intel.com>, "Kanevskiy, Alexander"
	<alexander.kanevskiy@intel.com>
Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Topic: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Index: AQHaeTeYeVMaFIFnV0yMrKTBAlKavbE+h/4AgAIFciCAAkoDgIAApzzw
Date: Fri, 22 Mar 2024 12:12:09 +0000
Message-ID: <MW5PR11MB5907D17C1EBC1869C553256DF2312@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <MW5PR11MB5907D65A7557AA1381B477B0F2332@MW5PR11MB5907.namprd11.prod.outlook.com>
 <20240321231019.81064-1-sj@kernel.org>
In-Reply-To: <20240321231019.81064-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|SA3PR11MB7435:EE_
x-ms-office365-filtering-correlation-id: 84736e5d-154c-4387-600f-08dc4a694c66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iM8Q6dlf9IZKhcUOvGOe+uE2dFk04YsX7Efr68Tm2b0Au50Fsx/gwA5ramGlS0nEighGeye1Rw3OPfUM5Qbt5IEAxcBsf6nMtlvSHIH4MztJNYvQM54qg93nEnTver/WsAaBRG8FnN3wdK0g1Z9dTVJyD2G1x5N572DbMw8VKtXvHi98O5N1jbo3Tsn2xmrLcHWF0v75UupYWBOuV72Tm87KeckNcOIZm+809aFfO+VipyXlog0psnkfQHChayGN2OMNg+GvuGf/sR6PGDQ6Wn+FSnaoaR8gLZPJvUp/YH/KAmxijYViOte2GdvaY6sLIP1NKmZiphBWCclFX6mTCEBLucVIB9pxOv6IizBukxsVwt2by4xuJrR9skw58L75v6HTbnyMtFK98WN6FqxoXuhVs/RfWp1WIwSf3k0eLUQHwmEWXiw89EPD5vf3yGOpkSumn/Js5MB+M81OLhwqXUzGKAv1CJJUPuVoXCcuWnj3WV8NdZn4UmyWyKoFrfYsAS/xkj1+rsgU1LU7Jl7MeGy/WXruNNQrUS7XpHuvk+TYGKGSRikcgfnb6DlWxp8xz3XmuhShMbTKeZZ3ykaubui9dDDEO4gwMkLrvx0AaUbinHENxw84ykMjOn0bwL+mYBDcEg6oXwAvARH8m3hkTIxH318ekW/c6umFzz300H49OWYh5xAElt+bY1qDLt29
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LkBXWm0uDNkhRPWHotQY7EctoTEONG8/MavHK+7i/FQ05FmhKyxvWJIOGQpl?=
 =?us-ascii?Q?hSwUoJMoVsScbV2aYBZFyNlnWfheHAtwJEl0p59ucfwZ05/PM6wLZwu3IDOw?=
 =?us-ascii?Q?GE678JY4eoSCXLkCo7clE/oD23JCNDlgNbtNLck4z9FXHgVB9csC2RATn80t?=
 =?us-ascii?Q?7LOW8q6xtbntzMqCm0jzwTrHGSZPjC9a7OCGWK2OcBmOAvkC6dvW8lNjUDgS?=
 =?us-ascii?Q?ZpDXxsxnDX9WhqeQDlD/DZLpegWaq8lyryWpe39Gg9deeoMZjIAoJXh5MD+a?=
 =?us-ascii?Q?klFQzJW9x/ss6Oa+4sPQS4KdeMK/RJbjrL7wDNWwMujjbhjkmjs/aZhJSL+k?=
 =?us-ascii?Q?hpBwcb3LxgLE6PHcIRWe9QnCAI9q/g8lvFEJ4Y4tHPzBLxzgSZnUUgn+jXuR?=
 =?us-ascii?Q?WYUwhdP7D3ZJ6nMooX+YWNgLqYv1kv8W+/7MkTsKP0icwNVjVN1DVQVz6SF7?=
 =?us-ascii?Q?gURSgjiEvJT5OLEKCdH5md5XaZel1+YSj7QGnFA19ThYgqx904BCZf86kTe+?=
 =?us-ascii?Q?1NGxxKZ84AP5EGvCs1EbP4fSTrWMk2TtEL/B+p9yz91tnE0ajdl816e0+M/L?=
 =?us-ascii?Q?FbBkXyjtOBsaqak1SdJJt4yVbFBCZrvVwALiUfBtLG7KoJMUCHrhKhObC1hm?=
 =?us-ascii?Q?D7JK3RHi9H5KMaXxSq96vLRXbj3jfqoAKaaK5DstA5eHl16zIT3MtZXSphIz?=
 =?us-ascii?Q?R/m9UG+98SJWSZOyfivxQGprVOZeAYi9zLrF8KOosC16M+7qwzkB1cKSHODb?=
 =?us-ascii?Q?sEEVskZg+THbk58Z2K8PfqLQID8LN1X3x8FeZPPrSFUqC4ZATk42bkis/oBT?=
 =?us-ascii?Q?+/B3SANV8HUHA6QZVydusegEScvfwbIMRKeM+bijtZi7cAd1n+CduCRK5pjj?=
 =?us-ascii?Q?Bf4lwMPdPA+DDf0iq7XcbVbkhSnFnvqwHAz7TFZoiSx7KYeIGXbrYtDPNu78?=
 =?us-ascii?Q?8Z6rJuwnPupzTMz/Ljaha6y2n9siRdd4nv0f/M0Wly5mz7YPbi9K9vziJXyK?=
 =?us-ascii?Q?JBMZO4FSXnHT4mEaqloB5YQ8l2TQN7vRTKvyHAX8QVxDjYz8g1P1VVT+qg1N?=
 =?us-ascii?Q?OLxqvDfcTOTSFJ+eHXcDG5imTtp+efSiTqN5rCwM6jgTCTQUI715l/v30Z80?=
 =?us-ascii?Q?uwxNjZ3ZL93WkKz/ePWG2DkcadTARi6iEtq3LWRLm0PElxO4isXU+rAPMzp4?=
 =?us-ascii?Q?iBzi6x4xkGFFdlP4b/Yyt5kfMCFlMa+EtpMgMqw3ta79v852aXg+58RntgWx?=
 =?us-ascii?Q?csoLK8d/DcQnPmcSLCEvLmIG/frmVqQg0634O7wnpsVG2EAk8XEuEmery5DR?=
 =?us-ascii?Q?xptkapwNc6l2F/poNN0UqIutWZQGxx7Xzk6dQrNBXrM4EUFsmoJGc0F0xW3D?=
 =?us-ascii?Q?+crC8MnMJUChm8VjBeTmy7DwgzpaRAUtrLa5BVWNgPvdBA8o4pboUGujjEIl?=
 =?us-ascii?Q?2Xr4SeLWGN9u98s58sra5S8CHrQfnqCe4OtOlTkFgaDi5r8cnrz4pAKZVLZM?=
 =?us-ascii?Q?RbEggGKCAc7wM0OX0Qmp5jguerx3WNSLQngzOuXtKycLEI0UHIY1t9Iotqw8?=
 =?us-ascii?Q?lOj1xWoldRX78BSnNTMKDHBSnaL6WhovX9meq+t/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5907.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84736e5d-154c-4387-600f-08dc4a694c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 12:12:09.3296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRbRTEOgbKPqVmMtoOv+3NK0HcsAMKCnMZp69Af7LshoEmvRfyiwnWrpNexbUg6NmIBBA/oAXzGTMYtxonuE/A45OUfe4e9P3c0APCvbiDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7435
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: SeongJae Park <sj@kernel.org>
> Sent: Friday, March 22, 2024 4:40 AM
> To: Prasad, Aravinda <aravinda.prasad@intel.com>
> Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-
> mm@kvack.org; linux-kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar,
> Sandeep4 <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>;
> Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Subramoney, Sreenivas
> <sreenivas.subramoney@intel.com>; Kervinen, Antti <antti.kervinen@intel.c=
om>;
> Kanevskiy, Alexander <alexander.kanevskiy@intel.com>
> Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
>=20
> On Wed, 20 Mar 2024 12:31:17 +0000 "Prasad, Aravinda"
> <aravinda.prasad@intel.com> wrote:
>=20
> >
> >
> > > -----Original Message-----
> > > From: SeongJae Park <sj@kernel.org>
> > > Sent: Tuesday, March 19, 2024 10:51 AM
> > > To: Prasad, Aravinda <aravinda.prasad@intel.com>
> > > Cc: damon@lists.linux.dev; linux-mm@kvack.org; sj@kernel.org; linux-
> > > kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar, Sandeep4
> > > <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>;
> > > Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> > > <dan.j.williams@intel.com>; Subramoney, Sreenivas
> > > <sreenivas.subramoney@intel.com>; Kervinen, Antti
> > > <antti.kervinen@intel.com>; Kanevskiy, Alexander
> > > <alexander.kanevskiy@intel.com>
> > > Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for
> > > DAMON
> > >
> > > Hi Aravinda,
> > >
> > >
> > > Thank you for posting this new revision!
> > >
> > > I remember I told you that I don't see a high level significant
> > > problems on on the reply to the previous revision of this patch[1], b=
ut I show a
> concern now.
> > > Sorry for not raising this earlier, but let me explain my humble
> > > concerns before being even more late.
> >
> > Please find my comments below:
> >
> > >
> > > On Mon, 18 Mar 2024 18:58:45 +0530 Aravinda Prasad
> > > <aravinda.prasad@intel.com> wrote:
> > >
> > > > DAMON randomly samples one or more pages in every region and
> > > > tracks accesses to them using the ACCESSED bit in PTE (or PMD for 2=
MB
> pages).
> > > > When the region size is large (e.g., several GBs), which is common
> > > > for large footprint applications, detecting whether the region is
> > > > accessed or not completely depends on whether the pages that are
> > > > actively accessed in the region are picked during random sampling.
> > > > If such pages are not picked for sampling, DAMON fails to identify
> > > > the region as accessed. However, increasing the sampling rate or
> > > > increasing the number of regions increases CPU overheads of kdamond=
.
> > >
> > > DAMON uses sampling because it considers a region as accessed if a
> > > portion of the region that big enough to be detected via sampling is
> > > all accessed.  If a region is having some pages that really accessed
> > > but the proportion is too small to be found via sampling, I think
> > > DAMON could say the overall access to the region is only modest and
> > > could even be ignored.  In my humble opinion, this fits with the
> > > definition of DAMON region: A memory address range that constructed w=
ith
> pages having similar access frequency.
> >
> > Agree that DAMON considers a region as accessed if a good portion of
> > the region is accessed. But few points I would like to discuss:
> >
> > For large regions (say 10GB, that has 2,621,440 4K pages), sampling at
> > PTE level will not cover a good portion of the region. For example,
> > default 5ms sampling and 100ms aggregation samples only 20 4K pages in =
an
> aggregation interval.
>=20
> If the 20 attempts all failed at finding any single accessed 4K page, I t=
hink it
> roughly means less than 5% of the region is accessed within the user-spec=
ified
> time (aggregation interval).  I would translate that as only tiny portion=
 of the
> region is accessed within the user-specified time, and hence DAMON is ok =
to say
> the region is nearly not accessed.

I am looking at it from the other way:

To detect if a region is hot or cold at least 1% of the pages in the region=
 should
be sampled. For a 10GB region (with 2,621,440 4K pages) this requires sampl=
ing
at least 26,214 pages. For a 100GB region this will require sampling at lea=
st
262,144 pages.

If we sample at 5ms, this takes 131.072 seconds to cover 1% of 10GB and 131=
0.72
seconds to cover 100GB.=20

DAMON shows that the selected page as accessed if that page was accessed
during the 5ms sampling window. Now if we increase the sampling to 20ms to
improve access detection, then covering 1% of the region takes even longer.

>=20
> > Increasing sampling to 1 ms and aggregation to 1 second can only cover
> > 1000 4K pages, but results in higher CPU overheads due to frequent samp=
ling.
> > Even increasing the aggregation interval to 60 seconds but sampling at
> > 5ms can only cover 12000 samples, but region splitting and merging
> > happens once in 60 seconds.
>=20
> At the beginning of each sampling interval, DAMON randomly picks one page=
 per
> region, clear their accessed bits, wait until the sampling interval is fi=
nished, and
> check the accessed bits again.  In other words, DAMON shows only accesses=
 that
> made in last sampling interval.

Yes, I see this in the code:

while(time < aggregation_interval)
{
  clear_access_bit
  sleep(sampling_time)
  check_access_bit
}

I would suggest this logic instead.

while(time < aggregation_interval)
{
  Number_of_samples =3D aggregation_interval / sampling_time;

  for (i =3D 0, I < number_of_samples; i++)=20
  {
    clear_access_bit
  }=20

  sleep(aggregation_time)

  for (i =3D 0, I < number_of_samples; i++)=20
  {
    check_access_bit
  }
}

This can help in better access detection. I am sure you would
have already explored it.  =20

>=20
> Increasing number of samples per aggregation interval can help DAMON know=
s
> the access frequency of regions in finer granularity, but doesn't allow D=
AMON see
> more accesses.  Rather than that, if the aggregation interval is fixed (r=
educing
> sampling interval), DAMON can show even less amount of accesses.
>=20
> What we need here is giving the workload longer sampling time so that the
> workload can make access to a size of memory regions that large enough to=
 be
> found by DAMON.

But even with longer sampling time, we may miss the access. For example,=20
consider all the pages in the region are accessed sequentially. Now if DAMO=
N samples
a different page other than the page that is being accessed it will miss. N=
ow even if we
have longer sampling time it is possible that none of the accesses are dete=
cted.

>=20
> >
> > In addition, this worsens when region sizes are say 100GB+. We observe
> > that sampling at PTE level does not help for large regions as more
> > samples are are required. So, decreasing/increasing the sampling or
> > aggressions intervals proportional to the region size is not practical
> > as all regions are of not equal size, we can have 100GB regions as
> > well as many small regions (e.g., 16KB to 1MB).
>=20
> IMO, it becomes worse because the minimum size of accessed memory regions
> that can be found by DAMON via sampling has increased together, while you
> didn't give more sampling time (a.k.a the time to let the workload make a=
ccesses
> that DAMON can show).
>=20
> > So tuning sampling rate and aggregation interval did not help for
> > large regions.
>=20
> Due to the mechanism of the DAMON's sampling I mentioned above, I think t=
his
> is what expected.  We need to increase sampling interval.
>=20
> >
> > It can also be observed that large regions cannot be avoided. Large
> > regions are created by merging adjacent smaller regions or at the
> > beginning of profiling (depending on min regions parameter which defaul=
ts to
> 10).
> > Increasing min region reduces the size of regions but increases
> > kdamond overheads, hence, not preferable.
> >
> > So, sampling at PTE level cannot precisely detect accesses to large
> > regions resulting in inaccuracies, even though it works for small regio=
ns.
> > From our experiments, we found that with 10% hot data in a large
> > region (80+GB regions in a 1TB+ footprint application), DAMON was not
> > able to detect a single access to that region in 95+% cases with
> > different sample and aggregation interval combinations. But DAMON
> > works good for applications with footprint <50GB where regions are typi=
cally
> small.
> >
> > Now consider the scenario with the proposed enhancement. With a 100GB
> > region, if we sample a PUD entry that covers 1GB address space, then
> > the default 5ms sampling and 100ms aggregation samples
> > 20 PUD entries that is 20 GB portion of the region. This gives a good
> > estimate of the portion of the region that is accessed. But the
> > downside is that as PUD accessed bit is set even if a small set of
> > pages are accessed under its subtree this can report more access as rea=
l as you
> noted.
> >
> > But such large regions are split into two in the next aggregation inter=
val.
> > As the splitting of the regions continues, in next few aggregation
> > intervals many smaller regions are formed. Once smaller regions are
> > formed, the proposed enhancement cannot pick higher levels of the page
> > table tree and behaves as good as default DAMON. So, with the proposed
> > enhancement, larger regions are quickly split into smaller regions if
> > they have only small set of pages accessed.
>=20
> I fully agree.  This is what could be a real and important benefits.
>=20
> >
> > To avoid misinterpreting region access count, I feel that the "age" of
> > the region is of real help and should be considered by both DAMON and
> > the proposed enhancement. If the age of a region is small (<10) then
> > that region should not be considered stable and hence should not be
> > considered for any memory tiering decisions. For regions with age, say
> > >10, can be considered as stable as they reflect the actual access
> > frequency.
>=20
> I think this is a good approach, but difficult to be used by default.  I =
think we
> might be able to get the benefit without making problem at the over-repor=
ting
> accesses by using the high level accessed bit check results as a hint for=
 better
> quality of region split?

I agree, high level page table profiling can give hints to split the region=
 instead of
using it to detect accesses to the region.

>=20
> Also, if we can allow large enough age, the random region split will even=
tually find
> the small hot regions even without high level accessed bit hint.  Of cour=
se the hint
> could help finding it earlier.  I think that was one of my comment on the=
 first
> version of this patch.

The problem is that a large region that is split is immediately merged as t=
he split
regions have access count zero.

We observe that large regions are never getting split at all due to this.

Regards,
Aravinda

>=20
> >
> > >
> > > >
> > > > This patch proposes profiling different levels of the
> > > > application\u2019s page table tree to detect whether a region is
> > > > accessed or not. This patch set is based on the observation that,
> > > > when the accessed bit for a page is set, the accessed bits at the
> > > > higher levels of the page table tree (PMD/PUD/PGD) corresponding
> > > > to the path of the page table walk are also set. Hence, it is
> > > > efficient to check the accessed bits at the higher levels of the
> > > > page table tree to detect whether a region is accessed or not. For
> > > > example, if the access bit for a PUD entry is set, then one or
> > > > more pages in the 1GB PUD subtree is accessed as each PUD entry
> > > > covers 1GB mapping. Hence, instead of sampling thousands of 4K/2M
> > > > pages to detect accesses in a large region, sampling at the higher
> > > > level of page table tree is faster and
> > > efficient.
> > >
> > > Due to the above reason, I concern this could result in making DAMON
> > > monitoring results be inaccurately biased to report more than real ac=
cesses.
> >
> > DAMON, even without the proposed enhancement, can result in
> > inaccuracies for large regions, (see examples above).
>=20
> I think temporarily missing such tiny portion of accesses is not a critic=
al problem.
> If this is a problem, the user should increase the sampling interval in m=
y opinion.
> That said, as mentioned above, DAMON would better to improve its regions =
split
> mechanism.
>=20
> >
> > >
> > > >
> > > > This patch set is based on 6.8-rc5 kernel (commit: f48159f8,
> > > > mm-unstable
> > > > tree)
> > > >
> > > > Changes since v1 [1]
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >  - Added support for 5-level page table tree
> > > >  - Split the patch to mm infrastructure changes and DAMON
> > > > enhancements
> > > >  - Code changes as per comments on v1
> > > >  - Added kerneldoc comments
> > > >
> > > > [1] https://lkml.org/lkml/2023/12/15/272
> > > >
> > > > Evaluation:
> > > >
> > > > - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
> > > >   and 5TB with 10GB hot data.
> > > > - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
> > > >   parameters set to default value.
> > > > - DAMON+PTP: Page table profiling applied to DAMON with the above
> > > >   parameters.
> > > >
> > > > Profiling efficiency in detecting hot data:
> > > >
> > > > Footprint	1GB	10GB	100GB	5TB
> > > > ---------------------------------------------
> > > > DAMON		>90%	<50%	 ~0%	  0%
> > > > DAMON+PTP	>90%	>90%	>90%	>90%
> > >
> > > Sampling interval is the time interval that assumed to be large
> > > enough for the workload to make meaningful amount of accesses within
> > > the interval.  Hence, meaningful amount of sampling interval depends
> > > on the workload's characteristic and system's memory bandwidth.
> > >
> > > Here, the size of the hot memory region is about 100MB, 1GB, 10GB,
> > > and 10GB for the four cases, respectively.  And you set the sampling
> > > interval as 5ms.  Let's assume the system can access, say, 50 GB per
> > > second, and hence it could be able to access only up to 250 MB per
> > > 5ms.  So, in case of 1GB and footprint, all hot memory region would
> > > be accessed while DAMON is waiting for next sampling interval.
> > > Hence, DAMON would be able to see most accesses via sampling.  But
> > > for 100GB footprint case, only 250MB / 10GB =3D about 2.5% of the hot
> > > memory region would be accessed between the sampling interval.  DAMON
> cannot see whole accesses, and hence the precision could be low.
> > >
> > > I don't know exact memory bandwith of the system, but to detect the
> > > 10 GB hot region with 5ms sampling interval, the system should be
> > > able to access 2GB memory per millisecond, or about 2TB memory per
> > > second.  I think systems of such memory bandwidth is not that common.
> > >
> > > I show you also explored a configuration setting the aggregation inte=
rval
> higher.
> > > But because each sampling checks only access between the sampling
> > > interval, that might not help in this setup.  I'm wondering if you
> > > also explored increasing sampling interval.
> > >
> >
> > What we have observed that many real-world benchmarks we experimented
> > with do not saturate the memory bandwidth. We also experimented with
> > masim microbenchmark to understand the impact on memory access rate
> > (we inserted delay between memory access operations in do_rnd_ro() and
> > other functions). We see decrease in the precision as access intensity
> > is reduced. We have experimented with different sampling and
> > aggregation intervals, but that did not help much in improving precisio=
n.
>=20
> Again, please note that DAMON can show only accesses made between each
> sampling interval at a time.  The important factor for expectation of DAM=
ON's
> accuracy is, the balance between the memory access intensity of the workl=
oad,
> and the length of the sampling interval.  The workload should be access i=
ntensive
> enough to make sufficient amount of accesses between sampling interval.  =
The
> sampling interval should be long enough to allow the workload makes suffi=
cient
> amount of accesses within the time interval.
>=20
> The fact that the workloads were not saturating the memory bandwidth is n=
ot
> enough to know if that means the workload was memory intensive enough, an=
d
> the sampling interval was long enough.
>=20
> I was mentioning the memory bandwidth as only the maximum memory intensit=
y
> of the system that could be achieved.
>=20
> >
> > So, what I think is it that most of the cases the precision depends on
> > the page (hot or cold) that is randomly picked for sampling than the
> > sampling rate. Most of the time only cold 4K pages are picked in a
> > large region as they typically account for 90% of the pages in the
> > region and hence DAMON does not detect any accesses at all. By
> > profiling higher levels of the page table tree this can be improved.
>=20
> Again, agreed.  This is an important and grateful finding.  Thank you.  A=
nd again as
> mentioned above, I don't think we can merge this patch as is, but we coul=
d think
> about using the high level access bit check results as a hint to better s=
plit the
> regions.
>=20
> Indeed, DAMON's monitoring mechanism has many rooms for improvements.  I
> also have some ideas but my time was more spent on more capabilities of
> DAMON/DAMOS so far.  It was a bit intentional proiority setting since I g=
ot no real
> DAMON accuracy problem report from the production usage, and improving th=
e
> accuracy will deliver the benefit to all DAMON/DAMOS features.
>=20
> Since an important milestone of DAMOS, namely auto-tuning, has merged int=
o
> the mainline, I think I may better to spend more time on monitoring accur=
acy
> improvement.  I have some immature ideas in my head.  I will try to summa=
rize
> and share the ideas in near future.
>=20
> >
> > > Sorry again for finding this concern not early enough.  But I think
> > > we may need to discuss about this first.
> >
> > Absolutely no problem. Please let me know your thoughts.
>=20
> Thank you for patiently walking with me :)
>=20
>=20
> Thanks,
> SJ
>=20
> >
> > Regards,
> > Aravinda
> >
> > >
> > > [1] https://lkml.kernel.org/r/20231215201159.73845-1-sj@kernel.org
> > >
> > >
> > > Thanks,
> > > SJ
> > >
> > >
> > > >
> > > > CPU overheads (in billion cycles) for kdamond:
> > > >
> > > > Footprint	1GB	10GB	100GB	5TB
> > > > ---------------------------------------------
> > > > DAMON		1.15	19.53	3.52	9.55
> > > > DAMON+PTP	0.83	 3.20	1.27	2.55
> > > >
> > > > A detailed explanation and evaluation can be found in the arXiv pap=
er:
> > > > https://arxiv.org/pdf/2311.10275.pdf
> > > >
> > > >
> > > > Aravinda Prasad (3):
> > > >   mm/damon: mm infrastructure support
> > > >   mm/damon: profiling enhancement
> > > >   mm/damon: documentation updates
> > > >
> > > >  Documentation/mm/damon/design.rst |  42 ++++++
> > > >  arch/x86/include/asm/pgtable.h    |  20 +++
> > > >  arch/x86/mm/pgtable.c             |  28 +++-
> > > >  include/linux/mmu_notifier.h      |  36 +++++
> > > >  include/linux/pgtable.h           |  79 ++++++++++
> > > >  mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++=
++--
> > > >  6 files changed, 424 insertions(+), 14 deletions(-)
> > > >
> > > > --
> > > > 2.21.3

