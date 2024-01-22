Return-Path: <linux-kernel+bounces-32572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B81835D62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4D7B27CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C77364C5;
	Mon, 22 Jan 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWnFuQe5"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43739AF4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913546; cv=fail; b=qzGwRNk55EK67zDYediSErHBtV7DMsNehT/Z/caxSSSw5FKgRGUuV3y0RkxN5ol+c1Me90ZNtkBIIaHJOkYXXucg5FPhB2sgXz9y8Oil+yrLZyDiPkgbhUrCTLkB9wpoU2Ckyy0x2bogyD99rN8p0++b+7NhA5oK9E18+NQ/GSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913546; c=relaxed/simple;
	bh=H2eWiNw3UGpkPc0XtlDvECcjCgF02n1veBWTH/GeawA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0k4E6Rmq3SMpZdHyt/U5RlG/FNwTEHOeV6iNHOwWPjJn3THygqnhGc4M+pzEO6ZsA4ybDRyRD/mbr3cK/C+qgcy0OywtNbBm/3+6A/ilGPCxO1Y8bce/fQqWINs1IAIf/bp6BjePk8a3evyJAZ819mb9AxrJ0uaTH5Y+HRY8zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWnFuQe5; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705913545; x=1737449545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H2eWiNw3UGpkPc0XtlDvECcjCgF02n1veBWTH/GeawA=;
  b=GWnFuQe5ZWSchiL5/ROHBo5GQfj6Rh0AidvQs32WwHuISliG6U5Y8Yui
   j3MnC2PbkZzUryz83XY5vi3gwTlETTDgEDw1Jn/VmsbRpnfI6+Ax248ZM
   cXbS15Zc8hQBtBGe6+fy0ciB9+FHFrG4YPHvi1ym3j8h+YX6yhjaDDdV+
   5ticDPAAKG/yJVss11yga8nj2L1jhmS9/ic4CQcvE8M++f3NH6dWq8qnQ
   5cKQA2EPChZ/XX9ii3jZq+2xY+dRW++uR8yohqTsRW0F3EuPc6kqd26TT
   zofYqHmyZPfEzxUVWZ4dArvlYOCXwmzrG96HyWeMJLM+lMuZQGGprak48
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="398299908"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="398299908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="928931517"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="928931517"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:52:24 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:52:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:52:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP7In9Yl6LKfJzx17TsYMEgRoeeY/afnp1aINcBuqlZA8YHstaR990jPdb97y8jO1jGthoyYNc1+YHMK0YXWT7uWw0lBSZCRrDZG/pcthnhmYWQkSJsWQeDh9wUdZpTwbgMEDong0kRUGAMcnsLrqvnverQQmqa/abSVwXc0baT3hwrTTgYNAp4puKeAtge9vHTM/81au1v/fUp/8GTARhWdUN/2WXaNPMdGOJvBySqSTex50eqJ04o8NfFPcu2GbAwpAqZ60jAK1hJ/p1GqjTr0kwQooMIhJlJZvv2dohCJPJwAUS2O7c3EpRb6Bi6ZBBB5T4cBlsFWxBBbmdQxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4U5QqMaJYYScAwBcn2/OPT6nCwDwnq4vB63szlTmcs=;
 b=USQsfIsPrVDMyexUTNLamJ8WLBmr/ITIaymlqqoPzFj9B9LMGfLfYxtvVJ44FqlG4xunI/7L9f8jex7OvoCSCA1dYihFaWpFoLwK84zQC3oL/9MHcxUafyVJDFWTyh0s0Gl7YHjFQ+isl+8Q+ceKpNllT5quRyiodk+i9X8uLSf1hbgo1gqN0h3RFXNwtRKLfUL+MByK/e09JnGurBAO592OMl3MGCiqm+Q9liuVL5Ugai31w3VzEgQUgFhIvZCNAMvMttlfysEpfhQP0cHCbvCQnxv/0z8JQYkP/6AkT5TDKBlYvjaMQINtLdYxTe5cG64bRhW27XMv6Qr+FnnkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Mon, 22 Jan
 2024 08:52:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:52:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>, "pandoh@google.com"
	<pandoh@google.com>, "loganodell@google.com" <loganodell@google.com>
Subject: RE: [RFCv2 PATCH 6/7] iommu/amd: Add nested domain allocation support
Thread-Topic: [RFCv2 PATCH 6/7] iommu/amd: Add nested domain allocation
 support
Thread-Index: AQHaROtTcEDws+vJXUC8MJbA2V9QoLDllRjQ
Date: Mon, 22 Jan 2024 08:52:21 +0000
Message-ID: <BN9PR11MB527638F808D74FA9A6DED43A8C752@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-7-suravee.suthikulpanit@amd.com>
In-Reply-To: <20240112000646.98001-7-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 0ef6ed19-c2bd-4fef-fd88-08dc1b277264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pO90zoG6/zOxHKSCb6F1ZSruijeY4qPA/0dFSjW+kH6woaIM9QhtzwboTvOaMsfq/4JxjOa/K4p1GMtMwZaC5SZUGHLnSyomuM/Rn9DJmhpqjjp3p7/7nlBTX45jYuER2LTl6Y8ivrVXRRNrWdr5GP/KkU0BWY4m9k4QUOppG0zk+up/O200CwRo012r25CdVZMSCNOzmABzpPgbC0YBL+XvdBHGpdBaq9agygwiGdBGmDwWffK19QAb5/qHcHhpz8p1tUY1cO/sNZkq+xaAToWHtYE7e14KTKZyfDVD/JB2GfbE2JtOCx144M0TabENi/YBq7gZ3VA5EFmxRDPzB2q+BoukLwfNOvBX12WdAL91zzvVy9X9ti2Km5BooLgN0sg8utod3cfF9LUJ/qD5ZikPWI3gqtIxec8uofl6E5p5I0hr8lJ0E10rp5+N//9vEPFEebWhIZyaBoHyg4MqHeOcXxmb1zt0B8/KLzfuwQv7QTun1chcg38OX0WvdcrXlL1gPv98UTVwvJVMmOla/r2cY2PgvOJ0ZbQ2CZ5W1szGNwIwOXLf39yPZt/HRd45xoNHDVBz6vyqmtC2CrFpEkIMXJGd5G5Ml4JeGmt5kENzAVhsn/0RxeWRd0ipAW48
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(38100700002)(71200400001)(26005)(5660300002)(122000001)(8936002)(4326008)(8676002)(6506007)(52536014)(41300700001)(2906002)(66556008)(7416002)(7696005)(66446008)(66476007)(9686003)(54906003)(316002)(110136005)(66946007)(76116006)(64756008)(86362001)(82960400001)(33656002)(38070700009)(55016003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?romYqnbdH0O698bOLlQwQBNvvVwrP8cIb8gdYWPQN8X/1SyXvl4F5jRkEKAW?=
 =?us-ascii?Q?KQuLbtUwVsy1+lA7CE14bgFh3gow+NKaMAdhfwLflwCxrbDY/GaB+CsEmpIu?=
 =?us-ascii?Q?vmBhoTFibLCdQ1nxVEXP062AW8RUa1kCPwhcJPEsoYrCkH6PHrNZRZ5I/07r?=
 =?us-ascii?Q?TL2ILpwXDFhGQ8Z13Hn5nd6F4Ha1OlATRp6fqfi0FjUEgn8vj7sgsgWFJ4Ec?=
 =?us-ascii?Q?A6xloMb46pGrxZTL/St0DAmZRNh9E8fOqrKYI+IuLeyy8EazsPiP/2Lpqk4s?=
 =?us-ascii?Q?4MuNZgn0cwEXcTd0Pa8QpWptLreBgJy86DyHcEDYzlwruHs5oHOsJl+IfZsZ?=
 =?us-ascii?Q?1hutgDq/1068jw9O7fXCMQ9zt6BcQl0wR7ggWzbo8pTBheMBQLn82UxKBFpl?=
 =?us-ascii?Q?sepwmVqVt1o+FuRo6Q/pQDXZRalJ8a7YfUlo1O8QWoMl4sKP/8iHITWbQC2E?=
 =?us-ascii?Q?yrY0NpqbznCeMCWDffREqshb+G5sj+tYOQzeB778yjMBrJ2FnlQ9j8q1WzMP?=
 =?us-ascii?Q?NjKg9H0mS9tA3XsjIDySTKLNjIWvlacr9ml5BE0onmEvyauvy0b4fr+i/1O4?=
 =?us-ascii?Q?UDyUaRjUDf2UIkt+wRvzgan3LhqC5Q2AjUGf8tt4zIRZySrwRxfserZ+ncTE?=
 =?us-ascii?Q?CogrXzENIYH5yr8isr5PlTYvvI26P3OhSbWeg6jpbqNrIr3FChKs83KIvpcx?=
 =?us-ascii?Q?AkWSfw9E5yQkbO7eOMh0qAGZPQzro1xaeoqYDP8ur/NgJ2fL7UbYNKsvyOdj?=
 =?us-ascii?Q?9cb0is81E/raYE+0m21UT/LGWgxNT4KJ2agdXIcMWCECaimQox6AdJoxe+9A?=
 =?us-ascii?Q?48leUNaO8gNlVY+isNlJjOYZZNOxvEBBEDckCIkqys8uXzpu3Fewe1XdWHCA?=
 =?us-ascii?Q?34kZQCZ4q9rkODiFspr9u1C65yGQbnvbiwSc4/4Tj/WYzbVVzyxkjlAIA1Bt?=
 =?us-ascii?Q?Gpe+dqtYAL29bFJ9HmCG5cSJD4ktoYAQYqFQtwQMcCn9xovTFxCJbbWgTog7?=
 =?us-ascii?Q?Jh5ebIMcLFF+IE84Y5S0dCpqZOOSSno5ZqOn6LkwNgBXieF9+yQPOLss4RO7?=
 =?us-ascii?Q?xsbvFqc2iBjWf7dKa94NZ0qmVxs7ruT2p3/LlPgIkCgwtu4qS1vQ5IHYpUR7?=
 =?us-ascii?Q?fjJA9y4n110NnBwBg+OQm8kgB6xPmaqqNV6ya0Q3nq/lEVQGl1wkYR5Y7Yin?=
 =?us-ascii?Q?XviR+OU76Ijxh0nLxo071GoiT568mHJyE7IHEwjbhsJK1paxf+SZrGNkczIW?=
 =?us-ascii?Q?mkazwsqYUgpnIvDvm1gQp2ZOYdr1tizWgOo/a0Ono2P+Ez6Typp3i6YLqFUj?=
 =?us-ascii?Q?9FjmbX4jRio3lwuDmCSx3oYsL/f35HDDG4mi4RnQKXf8JLvVoDBT6VV+MNuz?=
 =?us-ascii?Q?alcwOLVGPgSs1ALOk24PAfHUt0WOMX4w7cQCfNWHLOnTA4fqS5A+jkbKNgrG?=
 =?us-ascii?Q?QwnmURvoAaNXIknHHdFTY8AJOQzbRIiyd4SqKJbQdwEfsJPgAxjN+yjxNPKY?=
 =?us-ascii?Q?RXywLXAbVUw0YV4dX0VMmdZmoDOLHKHVA341TVzmg9ePiIt1NJMV3cuJrInk?=
 =?us-ascii?Q?CVLiRgf1PIy6gSEHVEbZBFZMl/Ob90P/2PbmgZ0a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef6ed19-c2bd-4fef-fd88-08dc1b277264
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:52:21.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyvhhwIsOfmXgtAaxcIvzjLDaWWMYBwAFCnSKIPaie6Zh3eX9dwJAOhch0tg6RN0IMSbr/gz/nTe2lwTs0Undg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, January 12, 2024 8:07 AM
>=20
> To support nested translation, the parent domain is allocated with flag
> IOMMU_HWPT_ALLOC_NEST_PARENT, and stores information of the v1 page
> table
> for stage 2 (i.e. GPA->SPA), whereas the child domain stores information
> of the GCR3 root pointer table for stage 1 (i.e. GVA->GPA).

put support of NEST_PARENT in a separate patch.

> @@ -569,6 +572,9 @@ struct protection_domain {
>  	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
>  	unsigned dev_cnt;	/* devices assigned to this domain */
>  	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference
> count */
> +	struct protection_domain *parent; /* Nested parent domain */
> +	u16 guest_paging_mode;	/* Guest paging mode */
> +	u16 guest_domain_id;	/* Guest domain ID */

not used

> +struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
>  						  struct device *dev, u32 flags)
>  {
>  	bool dirty_tracking =3D flags &
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> @@ -2454,7 +2465,10 @@ static struct iommu_domain
> *do_iommu_domain_alloc(unsigned int type,
>  	if (iommu) {
>  		domain->domain.type =3D type;
>  		domain->domain.pgsize_bitmap =3D iommu->iommu.ops-
> >pgsize_bitmap;
> -		domain->domain.ops =3D iommu->iommu.ops-
> >default_domain_ops;
> +		if (type =3D=3D IOMMU_DOMAIN_NESTED)
> +			domain->domain.ops =3D &nested_domain_ops;
> +		else
> +			domain->domain.ops =3D iommu->iommu.ops-
> >default_domain_ops;
>=20
>  		if (dirty_tracking)
>  			domain->domain.dirty_ops =3D &amd_dirty_ops;

dirty_tracking doesn't apply to nested domain

> +
> +static bool check_nested_support(u32 flags)
> +{
> +	if (!(flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
> +		return true;

it's more readable by putting this check in the caller.

> +
> +	/*
> +	 * When allocated nested parent domain, the device may already
> +	 * have been attached to a domain. For example, a device is already
> +	 * attached to the domain allocated by VFIO, which contains GPA-
> >SPA mapping.
> +	 * In such case, return reference to the same domain.
> +	 */
> +	if (dev_data->domain && nested_parent) {
> +		pr_debug("%s: Found exist: protection domain id=3D%#x\n",
> +			 __func__, dev_data->domain->id);
> +		dom =3D &dev_data->domain->domain;

alloc() shouldn't deal with domain reuse. it's the decision in the
caller. If the caller wants to reuse then it can try to attach to an
existing domain if compatible.

if the caller wants to create a new domain then just follow it.

