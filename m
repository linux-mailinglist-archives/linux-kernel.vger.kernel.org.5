Return-Path: <linux-kernel+bounces-3697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0B816FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB7BB22CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8344129ECD;
	Mon, 18 Dec 2023 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGa1wxSF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0E129ECA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702904719; x=1734440719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpiYM6LRzn+LQ6Efuzk0YcX1Oy2UY1kFfHQTNb4D9b8=;
  b=BGa1wxSFFDrAOM4EoFBKJfovo6cgdab+rqLvnIlUvjrk2eFfG1SLyQ9w
   WO0IjMBpfn90ftUkf4yjBVMhwgUf6285pgBZabN2U9XNEWRi9F8NdIYtP
   tjB065ZqV9MJMNpPkDiMWp2Pjy1lf/zeMq08+++WGuKw7CdgyPQBPLoMO
   BrpbUrkVYRGP9RCI1Cc+U1jxPkkqSDJfgDsQWsCG23UDbXCNqaVSKH3t6
   04RBwWG4HQKCC2MaMcBoCdvMIdM60I4H37rB/EeNDy39BKDaHmZ5vlx0R
   7mQVDauXN5UyOvpCIWXFdIj9sKqSZ51t93R8ccvSUfLPmZ2tWtn4iB3rU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="395236076"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="395236076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="23773211"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 05:05:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 05:05:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 05:05:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 05:05:17 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 05:05:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRB0vwB3xxaLHgtXeK7Qs7t+3fRWN+5cGnix8gdAyY1eAI487A3yh8eKvzs50r2dXaFVU5H4Aa7H9KwsKTKYg8eAowgafS4DSztehVUcvBU0QZ+lrK0/xUKB0RAwantKGaXjpEuxkwPylEuivc7FgEonrmpmRUsuHanWgqt7vtLCBBr6COYQnPJhulr83S8vA3UMlaK9K23bPzFt6IU3aVJksZirUSxW1Ki60enQYq1inq/r8LVcbVmlEFo2miDgncdj825q3N4QVIuSAwDQSvlCSw2jVNOH7W98zEEA33y+bsepe1Q+QlISWnXli4hZyAl+WMk/U0kMZewBbeut2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRR1z+AjZRyfV60vXkm1x1gBTP/FWGAN+u+RmyJsvsU=;
 b=J1kL56rXqz0Vksq0DX8bosm+C0TXIeD7b0OyfpfeAtDSzAbmA3+3HcVMzCAhi7eGocfp4SUzFa6XXnfM2LK7KlZ+PDbGdJpHGbWmNPRQCCqlSUszjzRdK8N0ttQRxV0S29/pFHZXUM4qnUtMYuigqhuDnHW+GDq6ummfPbBIcL0Kb7GYgiM/BvWn6UuPJMUe4rcY6rA6EeIUMaNTNVx6/DIgWKZWX2mkM4NtFKd8TpTQdEPHUkU7UC22FVQvvkOklP4tvZsKHppaOTQYRat7pCuFhLBY6AfqA6TELOW19zkEm8d/RicN1FS69ocNU34VJYkV+Dbdp1+xkxe18pgplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 13:05:11 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 13:05:11 +0000
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
Subject: RE: mm/DAMON: Profiling enhancements for DAMON
Thread-Topic: mm/DAMON: Profiling enhancements for DAMON
Thread-Index: AQHaLypE0BGAPWFioUOkts0KQWZiNLCqx5aAgAQoZXA=
Date: Mon, 18 Dec 2023 13:05:11 +0000
Message-ID: <MW5PR11MB5907791BEAA13D89C8B3948DF290A@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
 <20231215201159.73845-1-sj@kernel.org>
In-Reply-To: <20231215201159.73845-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|IA0PR11MB7210:EE_
x-ms-office365-filtering-correlation-id: ad6efc6e-35bd-475b-2122-08dbffc9f7fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiEW7/DqweC8Dn7t7tMOKDR4fbOxVAD4cd67ilYAM6VqNhpXYNVhuFw4iH4ZSvPKnvO+/p45Z39FZX/ErfDhFs6hTAWKGROSIaD6kG4hpiojgyqSGCXpohIffnB+JBd8NrbdYR9Zkv+u56Rht3UGdenjEYqMYjBhuTXLlSkcHh47o7axxdEuSc1F88MMYJlhg+m6+H27R6/FIPDMwSkDDuN//JOQ+3Hkav6LdFQ1Xp5lXaR0uqw+lNmqHAwwEYql5HzBGlZ8tQTeSLZHTjNo5fdX19oGaRNetOZPKuENxsRL7mm7RAYH53yNhXfgaIoJhUMMp9GudufZYA43S/opPpkDlmJSq7WBwmQpnRpfPehYc8+ayp8x5JPRYiZu95+ROUsv8gIong82ajykBZWc2ohtFX+nuh5uWUzUq4FhI54xsaDOcHQXLzut8DofVnjL3YV6/7fge9IhihJDKUbQ9LrkxHUxSXLYNCgn0SGTEVEnuJoEFBb+1TcW1KK2UOLF7+q7YMePFcY5MSAgPN0vyHlTG3JxbaJydjoDCPPxzme+AcTZKoM3KcT4tEfLrDG+y2JPWSmRyqywgsgYPBRTD5duP2eUz8nhEmyq/fZVFTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(107886003)(6506007)(53546011)(7696005)(9686003)(26005)(83380400001)(478600001)(5660300002)(30864003)(2906002)(8676002)(8936002)(4326008)(66446008)(6916009)(64756008)(52536014)(76116006)(54906003)(66476007)(66556008)(66946007)(316002)(966005)(41300700001)(38100700002)(122000001)(82960400001)(38070700009)(33656002)(86362001)(66899024)(55016003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b75kUdhJs2/3uvP49wrmvzvErH8BPyeKHOfY8huL71cONXZXjkLE8N/mMWxc?=
 =?us-ascii?Q?MsJl+sDpXtFc7HQNFePOJe7lM6Ny54X4J4W4MI+BAxVqE47mjbZyCSlDnK6x?=
 =?us-ascii?Q?9ZQPoNbQSMRsqmrUNcnGeWeouYzw+PkMImfHA3baJjs/q6hKYYwAegjykJhQ?=
 =?us-ascii?Q?pAxaJGSSMuezDNNCvanDNzuy3l8kL7WmWnClX3BeL6mwxVxMDUVobG8jBnED?=
 =?us-ascii?Q?P62siLEbbMkrh2uvZLMUjzdPfeBnui+JsKyxTu73WA02RrsHXzWWZ5qZza8t?=
 =?us-ascii?Q?I/l1ekJpQWNj4tYnLyNXernP57BVlsQ3b2bnPsGrxW1kxte8JmuaEVDxzSwj?=
 =?us-ascii?Q?jRNs1yTfeYfRamH620OQZsVNgaXr9C7xiQH5E+1JiM6fMAC9x+qzBYDw2xWo?=
 =?us-ascii?Q?ny4ShSfUalgpn7sugP0zUYgPCkOSwr8atoigkcXuywVrJMlwDt69EoW4o4s4?=
 =?us-ascii?Q?Rhie9bfB+eUPtqaUb3ptJXXVVG6IPhjrzAN6dtPfsuGQxeIEQ5MYu4bWTABT?=
 =?us-ascii?Q?Ugih7Htfjw/kEPJFOGs191jOQW4mlV5DnojQILLm3LQ8NBgk+pB2rCM/5GkE?=
 =?us-ascii?Q?aqPCXRS2d/a+MpKLQeqtUfcDrfgsi5nXcYIGPmgGpD8euXq6T1v+Zg0lpmOD?=
 =?us-ascii?Q?a0EkuQ2a94tiIAIQebaI/3V0S+A6wFAJ2/S8pF5ADq+Qhxeo8HEfVHED/Ei1?=
 =?us-ascii?Q?h8gv6F+ET8HDzTRAG4ziTq8drQUTlrgh89SS1cq30wP7w9+/tNDn458+wgIo?=
 =?us-ascii?Q?r4OwHceJEqim+5d0+vz5RnQcbfudE7TU4kvp2oz6y2BWb5bVVoc4+UBaw99T?=
 =?us-ascii?Q?waxXU30w16pD39QwFTRc6yXrL32VjV9MQzN7W26Hs0Nx2FMCS4icPyREKUSu?=
 =?us-ascii?Q?/5jWqHomvSNgDDe/wA0WMPqAVat6DW6qkc70wxDRYtGZchAo8yZQQqM6hkVP?=
 =?us-ascii?Q?1US2yn7kXESVgA2H7m7TZ2yeWNLcVGk44LY33z+8qVCD++OpiOEGlIIOPKcw?=
 =?us-ascii?Q?FKHZ2cDAcDrlhDBXb6x4G2JJ3ROnJ3QiXXLo7xQy3/QElc7PRct2h0VOrUxM?=
 =?us-ascii?Q?W+tp1j0/r0KcBAf+p2p4L4xeJvxHq5FJ9Irj1D82x7xpxahitclBsri74vdP?=
 =?us-ascii?Q?J1xMEdvNoxbrVuFKiWUoOgC8fQwR9lNMGeydvaM5Bnm247MpCttaDAQ8UOKQ?=
 =?us-ascii?Q?ldPqb/UOwIqOviQMgF0ryy5rcWn2H0b0R4bgr5wQ8dqbqh9T1zY0TC6ewao5?=
 =?us-ascii?Q?KrDfMX7fLMKWzb5kE07a/nsqVHZcpe+rAW2yIUYuRi9oqtka/TVakTHt/em3?=
 =?us-ascii?Q?yiV0IvFNaGNnlsMRI/ef9g/sOjrzgSbPSJqbPa+KVn9fRsVfniyYnYtZ/SLQ?=
 =?us-ascii?Q?h7DujYAfPqdOc24AOrF9hW5DGTR0G0QPehXND4I2VNZiXmQBE/fF7MXL1qok?=
 =?us-ascii?Q?nQceSsZm29Kz7JjJEH1hWBC7Xx4+pbJ1ydWqQdYFs1y7MWKCooDfnJA6Vl3T?=
 =?us-ascii?Q?r9dYH3gNosvFOObFi42CGR68rVkkDFsRoY1vQS2RIrQgfpQsuJKyLReaH3ot?=
 =?us-ascii?Q?0xeYZjagyK+lA/h3262JbUd3XuifnjCEer4PmeJ7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6efc6e-35bd-475b-2122-08dbffc9f7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 13:05:11.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8m/sNI5BZGQbiVz0LnWVOeQh2lI3y/cqDL4IJA6zOdXJQTkFv1PzYC1eRbiFeQkOnLO0nEuX9KcRsm3g2d31tbuBm2kq7rK0u+YFb4BIBgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: SeongJae Park <sj@kernel.org>
> Sent: Saturday, December 16, 2023 1:42 AM
> To: Prasad, Aravinda <aravinda.prasad@intel.com>
> Cc: damon@lists.linux.dev; linux-mm@kvack.org; sj@kernel.org; linux-
> kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar, Sandeep4
> <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>; Hansen,
> Dave <dave.hansen@intel.com>; Williams, Dan J <dan.j.williams@intel.com>;
> Subramoney, Sreenivas <sreenivas.subramoney@intel.com>; Kervinen, Antti
> <antti.kervinen@intel.com>; Kanevskiy, Alexander
> <alexander.kanevskiy@intel.com>; Alan Nair <alan.nair@intel.com>
> Subject: Re: mm/DAMON: Profiling enhancements for DAMON
>=20
> Hello Aravinda,
>=20
> > Subject: Re: mm/DAMON: Profiling enhancements for DAMON
>=20
> Nit.  I'd suggest to use 'mm/damon: ' prefix for consistency.  Also addin=
g [PATCH]
> prefix before that would help people easily classifying this nice mail.
>=20

ok

> And if you are posting this patch aiming not to be merged as is but to sh=
are the
> early implementation and get some comments, you could further make your
> intention clear using [RFC PATCH] prefix instead.

noted

>=20
> On 2023-12-15T13:16:19+05:30 Aravinda Prasad <aravinda.prasad@intel.com>
> wrote:
>=20
> > DAMON randomly samples one or more pages in every region and tracks
> > accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> > When the region size is large (e.g., several GBs), which is common for
> > large footprint applications, detecting whether the region is accessed
> > or not completely depends on whether the pages that are actively
> > accessed in the region are picked during random sampling.
> > If such pages are not picked for sampling, DAMON fails to identify the
> > region as accessed. However, increasing the sampling rate or
> > increasing the number of regions increases CPU overheads of kdamond.
> >
> > This patch proposes profiling different levels of the
> > application\u2019s page table tree to detect whether a region is
> > accessed or not. This patch is based on the observation that, when the
> > accessed bit for a page is set, the accessed bits at the higher levels
> > of the page table tree (PMD/PUD/PGD) corresponding to the path of the
> > page table walk are also set. Hence, it is efficient to  check the
> > accessed bits at the higher levels of the page table tree to detect
> > whether a region is accessed or not. For example, if the access bit
> > for a PUD entry is set, then one or more pages in the 1GB PUD subtree
> > is accessed as each PUD entry covers 1GB mapping. Hence, instead of
> > sampling thousands of 4K/2M pages to detect accesses in a large
> > region, sampling at the higher level of page table tree is faster and e=
fficient.
>=20
> The high level problem and solution ideas make sense to me, thank you for
> sharing these nice finding and patch!
>=20
> >
> > This patch is based on 6.6.3 kernel.
>=20
> 6.6.3 would be a nice baseline for RFC level patches, since it would let =
more
> people do test.  But for non-RFC, I'd suggest to base patches for DAMON o=
n latest
> mm-unstable[1] if possible.
>=20
> [1] https://git.kernel.org/akpm/mm/h/mm-unstable

Sure. Will do.

>=20
> >
> > TODO: Support 5-level page table tree
>=20
> Looking forward to that! :)
>=20
> >
> > Evaluation:
> >
> > - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
> >   and 5TB with 10GB hot data.
> > - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
> >   parameters set to default value.
>=20
> The default setup is 5ms sampling and 100ms aggregation intervals.  Was t=
here a
> reason to use 200ms aggregation interval instead of the default one?

We have experimented with other sampling interval (1ms) and aggregation
intervals (50, 100, 200). We provide data for 5ms and 200ms as it
gets 40 samples before a region is split or merged. We think that 20 sample=
s
with 5ms and 100ms for large regions (>100GB) is too less for baseline damo=
n.

>=20
> > - DAMON+PTP: Page table profiling applied to DAMON with the above
> >   parameters.
> >
> > Profiling efficiency in detecting hot data [1]:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		>90%	<50%	 ~0%	  0%
> > DAMON+PTP	>90%	>90%	>90%	>90%
>=20
> DAMON provides both frequency and a sort of recency information via
> 'nr_accesses' and 'age', respectively.  Using those together, we could mi=
nimize
> DAMON's accuracy risk.  For example, if we define hot pages with only the
> frequency information, say, pages that DAMON reported as having >=3D40
> 'nr_accesses' (100% access rate), I have no doubt at above result.  But i=
f we
> define hot page with both information, say, pages that DAMON didn't repor=
ted as
> having 0 'nr_accesses' for more than 10 'age' (not accessed for more than=
 2
> seconds), I think the number might be higher.  So I'm wondering how you d=
efined
> the hot page for this evaluation, and if you also measured with the age
> information usage.
>=20
> Note that this doesn't mean DAMON+PTP is not needed.  I think DAMON+PTP
> would be anyway better even when we use the 'age' together.  I'm just cur=
ious if
> you have considered such approaches and already have such test results.  =
I'm also
> not asking to do the tests and add those here.  But mentioning your thoug=
ht
> about such approach could also be helpful for readers of this patch, imho=
.

Will share what we observed for 5TB application.=20

When the DAMON starts with the default 10 regions, each region is 400+GB in=
 size.
What we observed was, with 20 or 40 samples per window, none of the hot pag=
es
were sampled in almost all windows. So 'nr_accesses' was 0 for all regions
throughout the run. By chance, we had nr_accesses as 1 in between, but thos=
e
regions were split and immediately merged in the next window.=20

For hot page detection, any region with access count >5 is considered hot (=
all pages in the
region is considered as hot). We experimented by aggregating the nr_accesse=
s
for different time intervals from 1 sec (used to compute precision/recall p=
lots)
to 100 seconds for real-world benchmarks. We did not use 'age'.

>=20
> >
> > CPU overheads (in billion cycles) for kdamond:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		1.15	19.53	3.52	9.55
> > DAMON+PTP	0.83	 3.20	1.27	2.55
> >
> > A detailed explanation and evaluation can be found in the arXiv paper:
> > [1] https://arxiv.org/pdf/2311.10275.pdf
> >
> > Regards,
> > Aravinda
> >
> > Signed-off-by: Alan Nair <alan.nair@intel.com>
> > Signed-off-by: Sandeep Kumar <sandeep4.kumar@intel.com>
> > Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
> > ---
>=20
> Though it's not clearly mentioned, I left only high level comments below =
assuming
> this is an RFC patch.

ok

>=20
> >  arch/x86/include/asm/pgtable.h |   17 +++++
> >  include/linux/damon.h          |   13 ++++
> >  include/linux/pgtable.h        |   31 ++++++++
> >  mm/damon/core.c                |   28 ++++++++
> >  mm/damon/vaddr.c               |  146
> +++++++++++++++++++++++++++++++++++++---
>=20
> Seems this improvement is only for vaddr.  Would this great improvement b=
e able
> to be applied to paddr.c in future?

Applying to paddr.c requires some h/w support. Not sure if we can directly =
extend it.

>=20
> >  5 files changed, 223 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/pgtable.h
> > b/arch/x86/include/asm/pgtable.h index e02b179ec..accdabb95 100644
> > --- a/arch/x86/include/asm/pgtable.h
> > +++ b/arch/x86/include/asm/pgtable.h
> > @@ -169,6 +169,11 @@ static inline int pud_young(pud_t pud)
> >  	return pud_flags(pud) & _PAGE_ACCESSED;  }
> >
> > +static inline int pgd_young(pgd_t pgd) {
> > +	return pgd_flags(pgd) & _PAGE_ACCESSED; }
> > +
> >  static inline int pte_write(pte_t pte)  {
> >  	/*
> > @@ -681,6 +686,18 @@ static inline pud_t pud_mkwrite(pud_t pud)
> >  	return pud_clear_saveddirty(pud);
> >  }
> >
> > +static inline pgd_t pgd_clear_flags(pgd_t pgd, pgdval_t clear) {
> > +	pgdval_t v =3D native_pgd_val(pgd);
> > +
> > +	return native_make_pgd(v & ~clear);
> > +}
> > +
> > +static inline pgd_t pgd_mkold(pgd_t pgd) {
> > +	return pgd_clear_flags(pgd, _PAGE_ACCESSED); }
> > +
> >  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >  static inline int pte_soft_dirty(pte_t pte)  { diff --git
> > a/include/linux/damon.h b/include/linux/damon.h index
> > c70cca8a8..8521a62ec 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -19,6 +19,14 @@
> >  /* Max priority score for DAMON-based operation schemes */
> >  #define DAMOS_MAX_SCORE		(99)
> >
> > +/* DAMON profiling levels */
> > +enum damon_profile_level {
> > +	PTE_LEVEL,
> > +	PMD_LEVEL,
> > +	PUD_LEVEL,
> > +	PGD_LEVEL,
> > +};
>=20
> I'd prefer more detailed kerneldoc comments.  Also, I think this new enum=
 is not
> really needed.  Please read my comment for damon_va_mkold() below for my
> detailed opinion.

ok

>=20
> > +
> >  /* Get a random number in [l, r) */
> >  static inline unsigned long damon_rand(unsigned long l, unsigned long
> > r)  { @@ -57,6 +65,8 @@ struct damon_region {
> >  	unsigned int age;
> >  /* private: Internal value for age calculation. */
> >  	unsigned int last_nr_accesses;
> > +	/* Page table profiling level */
> > +	enum damon_profile_level profile_level;
>=20
> Seems this field is set for every damon_va_mkold(), and used on only the =
function
> call, and following damon_va_young() call.  That allows the following
> damon_va_young() skips the unnecessary recalculation of this field.  Unle=
ss the
> profile_level calculation is a big deal, I think letting damon_va_young()=
 do the
> calculation once more and keeping this struct simple may be better.

Yes. We can let damon_va_young do the recalculation of the profile_level.

We did it this way because we experimented with higher page table levels th=
at is
beyond the address space covered by the region to improve convergence (see=
=20
the "flex" variant in the paper).  =20

>=20
> >  };
> >
> >  /**
> > @@ -656,6 +666,9 @@ int damon_stop(struct damon_ctx **ctxs, int
> > nr_ctxs);  int damon_set_region_biggest_system_ram_default(struct
> damon_target *t,
> >  				unsigned long *start, unsigned long *end);
> >
> > +enum damon_profile_level pick_profile_level(unsigned long start,
> > +		unsigned long end, unsigned long addr);
> > +
>=20
> Seems damon_va_mkold() is the only caller of this function.  I think defi=
ning this
> as static on the same source file will make change simpler.

Sure

>=20
> >  #endif	/* CONFIG_DAMON */
> >
> >  #endif	/* _DAMON_H */
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h index
> > af7639c3b..82d5f67ea 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -935,6 +935,37 @@ static inline void arch_swap_restore(swp_entry_t
> > entry, struct folio *folio)  #define flush_tlb_fix_spurious_fault(vma,
> > address, ptep) flush_tlb_page(vma, address)  #endif
> >
> > +/*
> > + * When walking page tables, get the address of the current/passed
> > +boundary,
> > + * or the start address of the range if that comes earlier.
> > + */
> > +
> > +#define pgd_addr_start(addr, start)			\
> > +({	unsigned long __boundary =3D (addr) & PGDIR_MASK;	\
> > +	(__boundary > start) ? __boundary : (start);	\
> > +})
> > +
> > +#ifndef p4d_addr_start
> > +#define p4d_addr_start(addr, start)			\
> > +({	unsigned long __boundary =3D (addr) & P4D_MASK;	\
> > +	(__boundary > start) ? __boundary : (start);	\
> > +})
> > +#endif
> > +
> > +#ifndef pud_addr_start
> > +#define pud_addr_start(addr, start)			\
> > +({	unsigned long __boundary =3D (addr) & PUD_MASK;	\
> > +	(__boundary > start) ? __boundary : (start);	\
> > +})
> > +#endif
> > +
> > +#ifndef pmd_addr_start
> > +#define pmd_addr_start(addr, start)			\
> > +({	unsigned long __boundary =3D (addr) & PMD_MASK;	\
> > +	(__boundary > start) ? __boundary : (start);	\
> > +})
> > +#endif
>=20
> Seems these are only used from mm/damon/vaddr.c.  If so, I think moving t=
hese
> definitions into the file may better to read.

ok.
=20
>=20
> > +
> >  /*
> >   * When walking page tables, get the address of the next boundary,
> >   * or the end address of the range if that comes earlier.  Although
> > no diff --git a/mm/damon/core.c b/mm/damon/core.c index
> > fd5be73f6..2a7d5c041 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -31,6 +31,33 @@ static struct damon_operations
> > damon_registered_ops[NR_DAMON_OPS];
> >
> >  static struct kmem_cache *damon_region_cache __ro_after_init;
> >
> > +/* Pick the highest possible page table profiling level for the
> > + * region corresponding to addr
> > + */
>=20
> Again, I'd prefer having a nice kerneldoc comment.

noted

>=20
> > +enum damon_profile_level pick_profile_level(unsigned long start,
> > +	unsigned long end, unsigned long addr)
>=20
> As noted above, seems this function is used from vaddr.c only.  Moving th=
is
> definition into the file may make this change simpler in my opinion.

ok

>=20
> > +{
> > +	enum damon_profile_level level =3D PTE_LEVEL;
> > +
> > +	if (pmd_addr_start(addr, (start) - 1) < start
> > +		|| pmd_addr_end(addr, (end) + 1) > end)
> > +		goto out;
>=20
> How about simply 'return PTE_LEVEL' here, and similarly for below parts?

Yes. Will do.

The code is this way as we experimented by doing a level++ or level+=3D2=20
depending on the region size before the "out" label, to experiment with
DAMON+PTP.=20

>=20
> > +	level =3D PMD_LEVEL;
> > +
> > +	if (pud_addr_start(addr, (start) - 1) < start
> > +		|| pud_addr_end(addr, (end) + 1) > end)
> > +		goto out;
> > +	level =3D PUD_LEVEL;
> > +
> > +	if (pgd_addr_start(addr, (start) - 1) < start
> > +		|| pgd_addr_end(addr, (end) + 1) > end)
> > +		goto out;
> > +	level =3D PGD_LEVEL;
> > +
> > +out:
> > +	return level;
> > +}
> > +
> >  /* Should be called under damon_ops_lock with id smaller than
> > NR_DAMON_OPS */  static bool __damon_is_registered_ops(enum
> > damon_ops_id id)  { @@ -132,6 +159,7 @@ struct damon_region
> > *damon_new_region(unsigned long start, unsigned long end)
> >
> >  	region->age =3D 0;
> >  	region->last_nr_accesses =3D 0;
> > +	region->profile_level =3D PTE_LEVEL;
> >
> >  	return region;
> >  }
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c index
> > cf8a9fc5c..b71221b3e 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -387,16 +387,76 @@ static int damon_mkold_hugetlb_entry(pte_t *pte,
> > unsigned long hmask,  #define damon_mkold_hugetlb_entry NULL  #endif
> > /* CONFIG_HUGETLB_PAGE */
> >
> > -static const struct mm_walk_ops damon_mkold_ops =3D {
> > -	.pmd_entry =3D damon_mkold_pmd_entry,
> > +static int damon_mkold_pmd(pmd_t *pmd, unsigned long addr,
> > +	unsigned long next, struct mm_walk *walk) {
> > +	spinlock_t *ptl;
> > +
> > +	if (!pmd_present(*pmd) || pmd_none(*pmd))
> > +		goto out;
> > +
> > +	ptl =3D pmd_lock(walk->mm, pmd);
> > +	if (pmd_young(*pmd))
> > +		*pmd =3D pmd_mkold(*pmd);
>=20
> Maybe we need to do the test and write at once?  Same for similar parts b=
elow.

Yes, as mentioned by Yu Zhao.

>=20
> > +
> > +	spin_unlock(ptl);
> > +
> > +out:
> > +	return 0;
> > +}
> > +
> > +static int damon_mkold_pud(pud_t *pud, unsigned long addr,
> > +	unsigned long next, struct mm_walk *walk) {
> > +	spinlock_t *ptl;
> > +
> > +	if (!pud_present(*pud) || pud_none(*pud))
> > +		goto out;
> > +
> > +	ptl =3D pud_lock(walk->mm, pud);
> > +	if (pud_young(*pud))
> > +		*pud =3D pud_mkold(*pud);
> > +
> > +	spin_unlock(ptl);
> > +
> > +out:
> > +	return 0;
> > +}
> > +
> > +static int damon_mkold_pgd(pgd_t *pgd, unsigned long addr,
> > +	unsigned long next, struct mm_walk *walk) {
> > +
> > +	if (!pgd_present(*pgd) || pgd_none(*pgd))
> > +		goto out;
> > +
> > +	spin_lock(&pgd_lock);
> > +	if (pgd_young(*pgd))
> > +		*pgd =3D pgd_mkold(*pgd);
> > +
> > +	spin_unlock(&pgd_lock);
> > +
> > +out:
> > +	return 0;
> > +}
> > +
> > +static const struct mm_walk_ops damon_mkold_ops[] =3D {
> > +	{.pmd_entry =3D damon_mkold_pmd_entry,
> >  	.hugetlb_entry =3D damon_mkold_hugetlb_entry,
> > -	.walk_lock =3D PGWALK_RDLOCK,
> > +	.walk_lock =3D PGWALK_RDLOCK},
> > +	{.pmd_entry =3D damon_mkold_pmd},
> > +	{.pud_entry =3D damon_mkold_pud},
> > +	{.pgd_entry =3D damon_mkold_pgd},
> >  };
> >
> > -static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> > +static void damon_va_mkold(struct mm_struct *mm, struct damon_region
> > +*r)
> >  {
> > +	unsigned long addr =3D r->sampling_addr;
> > +
> > +	r->profile_level =3D pick_profile_level(r->ar.start, r->ar.end, addr)=
;
> > +
> >  	mmap_read_lock(mm);
> > -	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
> > +	walk_page_range(mm, addr, addr + 1, damon_mkold_ops +
> > +r->profile_level, NULL);
>=20
> Maybe &damon_mkold_ops[r->profile_level] would easier to read?

Yes.

>=20
> >  	mmap_read_unlock(mm);
> >  }
> >
> > @@ -409,7 +469,7 @@ static void __damon_va_prepare_access_check(struct
> > mm_struct *mm,  {
> >  	r->sampling_addr =3D damon_rand(r->ar.start, r->ar.end);
> >
> > -	damon_va_mkold(mm, r->sampling_addr);
> > +	damon_va_mkold(mm, r);
> >  }
> >
> >  static void damon_va_prepare_access_checks(struct damon_ctx *ctx) @@
> > -531,22 +591,84 @@ static int damon_young_hugetlb_entry(pte_t *pte,
> > unsigned long hmask,  #define damon_young_hugetlb_entry NULL  #endif
> > /* CONFIG_HUGETLB_PAGE */
> >
> > -static const struct mm_walk_ops damon_young_ops =3D {
> > -	.pmd_entry =3D damon_young_pmd_entry,
> > +static int damon_young_pmd(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk) {
> > +	spinlock_t *ptl;
> > +	struct damon_young_walk_private *priv =3D walk->private;
> > +
> > +	if (!pmd_present(*pmd) || pmd_none(*pmd))
> > +		goto out;
> > +
> > +	ptl =3D pmd_lock(walk->mm, pmd);
> > +	if (pmd_young(*pmd) || mmu_notifier_test_young(walk->mm, addr))
> > +		priv->young =3D true;
> > +
> > +	*priv->folio_sz =3D (1UL << PMD_SHIFT);
> > +	spin_unlock(ptl);
> > +out:
> > +	return 0;
> > +}
> > +
> > +static int damon_young_pud(pud_t *pud, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk) {
> > +	spinlock_t *ptl;
> > +	struct damon_young_walk_private *priv =3D walk->private;
> > +
> > +	if (!pud_present(*pud) || pud_none(*pud))
> > +		goto out;
> > +
> > +	ptl =3D pud_lock(walk->mm, pud);
> > +	if (pud_young(*pud) || mmu_notifier_test_young(walk->mm, addr))
> > +		priv->young =3D true;
> > +
> > +	*priv->folio_sz =3D (1UL << PUD_SHIFT);
> > +
> > +	spin_unlock(ptl);
> > +out:
> > +	return 0;
> > +}
> > +
> > +static int damon_young_pgd(pgd_t *pgd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk) {
> > +	struct damon_young_walk_private *priv =3D walk->private;
> > +
> > +	if (!pgd_present(*pgd) || pgd_none(*pgd))
> > +		goto out;
> > +
> > +	spin_lock(&pgd_lock);
> > +	if (pgd_young(*pgd) || mmu_notifier_test_young(walk->mm, addr))
> > +		priv->young =3D true;
> > +
> > +	*priv->folio_sz =3D (1UL << PGDIR_SHIFT);
> > +
> > +	spin_unlock(&pgd_lock);
> > +out:
> > +	return 0;
> > +}
> > +
> > +static const struct mm_walk_ops damon_young_ops[] =3D {
> > +	{.pmd_entry =3D damon_young_pmd_entry,
> >  	.hugetlb_entry =3D damon_young_hugetlb_entry,
> > -	.walk_lock =3D PGWALK_RDLOCK,
> > +	.walk_lock =3D PGWALK_RDLOCK},
> > +	{.pmd_entry =3D damon_young_pmd},
> > +	{.pud_entry =3D damon_young_pud},
> > +	{.pgd_entry =3D damon_young_pgd},
> >  };
> >
> > -static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> > +static bool damon_va_young(struct mm_struct *mm, struct damon_region
> > +*r,
> >  		unsigned long *folio_sz)
> >  {
> > +	unsigned long addr =3D r->sampling_addr;
> >  	struct damon_young_walk_private arg =3D {
> >  		.folio_sz =3D folio_sz,
> >  		.young =3D false,
> >  	};
> >
> >  	mmap_read_lock(mm);
> > -	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
> > +	walk_page_range(mm, addr, addr + 1, damon_young_ops +
> > +r->profile_level, &arg);
>=20
> Again, '&damon_young_ops[r->profile_level]' may be easier for me to read.
>=20
> Also, I still prefer 80 columns limit.  Could we wrap this line?

Sure

>=20
> Seems pick_profile_level() is only for calculating ->profile_level which =
will be
> stored into the region for each damon_va_mkold().  And ->profile_level is=
 used to
> find proper mm_walk_ops from damon_mkold_ops[] and damon_young_ops[].
> I understand the index is saved in ->profile_level to be reused in the fo=
llowup
> damon_va_young() call, to avoid the unnecessary recalculation overhead.
>=20
> If the recalculation overhead is not a big deal, I think having functions=
 for getting
> the proper pointers to mm_walk_ops could make the change simpler?

Yes, we can do recalculation in damon_va_young(). Will incorporate.

>=20
> >  	mmap_read_unlock(mm);
> >  	return arg.young;
> >  }
> > @@ -572,7 +694,7 @@ static void __damon_va_check_access(struct
> mm_struct *mm,
> >  		return;
> >  	}
> >
> > -	last_accessed =3D damon_va_young(mm, r->sampling_addr,
> &last_folio_sz);
> > +	last_accessed =3D damon_va_young(mm, r, &last_folio_sz);
> >  	if (last_accessed)
> >  		r->nr_accesses++;
>=20
>=20
> Thanks,
> SJ

