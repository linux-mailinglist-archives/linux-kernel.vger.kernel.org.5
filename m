Return-Path: <linux-kernel+bounces-122513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F060688F8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E9E1F24610
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ADD53813;
	Thu, 28 Mar 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmHHqylG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406451009
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611583; cv=fail; b=pCC65XYNY8BfmqHv+3ZP/8r66/KmxyhkTg87aRSyyEuvqGcyKCaS1qxIeruuQSRC661P95Y5xybxLLHk/bOCAtklWOQHO605CFWFgi2vmCXFmujDn0sb3FuSjiZYwmLBDAMXBNgDoLq5kUHSAce8jkkZVvEEPgrmuAXiiqmkIZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611583; c=relaxed/simple;
	bh=cLif9aNQqm5IcaG3sCJIrEzBU8fV54yBzUxMJoSCxps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MX8xD8r5Pnw0PjiemqhMoazCzGnoVHGLGDZSonDIsyvc2QO0SsEZwhItSpUDsiC2y00YSaXsogCwIuQOqtJXNOEyxntZebGJZIpAMQ+lUvRpn+TOZZ2rStMO4JOJabueUAQr7CMh79tfrjnFW4m4/OVanqdFDWWlqL5MjUFyggg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmHHqylG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711611582; x=1743147582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLif9aNQqm5IcaG3sCJIrEzBU8fV54yBzUxMJoSCxps=;
  b=QmHHqylG6Gi34Rq4f2QjxZqCboChiXn9b5VrRgzD66eiBckUuBWR+hYU
   a8e6irgcMEPs9/JtdfKltvvh9N2Z3ESSouvwMiUsDayUMPXtrUXWkLtgf
   tS0WnRZ5z6vGVcyTPE5d3FHUCUZRDv7PJ6SfEB+OvmdI5DkPCModj13a4
   kok3Cocn5ItlH+HeduLtXitHAxnXO2LaSgwpzTWw11NBnqH4zUKnIP+6Y
   J7xhIutHhGiVfyZat6r1PFNzCza5JJdHGdYexyUOfdvZxMOJJwth8pey5
   H1JrN+DF1Iu65Ht1NycF5sMqjs+P5E9WuJ9kcGIMlZPL2YGlPWaKVxZ0U
   g==;
X-CSE-ConnectionGUID: 7yFkAjadRPK+F5GGKYYvdQ==
X-CSE-MsgGUID: VKpLWXDxSx2x/qWYgV7GrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6878269"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6878269"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21062150"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:39:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:39:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:39:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUKZAoNmLOM+8LtptqAfbeNts0Js64dJGXMJuW6VoylY4Y89bTJs0PkYk/lBqhtmiwrYnO9nPwidcaFkZCfMM+zFwBnOfT7WOzFDi1tqwjMOIjoeF4oXGb7tz1vNMOBRi/xgar6wytDqJk9+6Ct2WjNcgXVYcoRmPsRgcPUWgCFvEcne1pi4+yDUicdsHIfc8W76ZBNmVgpxIhuEmGxIBKQIBXQ+9sRHNMgaleM+pmWs9rinbeIdbgDSOHrvFEcW30goXelOqzgUKzvzWJ0dUEpKNiFw0YHMmko42xln5tgItF7x9h7Lsv/7F5QNF7XMsAY60pFxwErLaCSVs3xr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNdW8h+vIw3z3Lmi4ueglsrXL7RhfQh+uSp2plKqUyA=;
 b=SIYQVnDB+N0tn5zLQUFLHrz5Zms/0zy2IMlNcL263SctAITpwQdDg0MjyhE3IsorW8AMyzj0N3451jMCmW2ZddJAEySYFQ3/ekPUtgwfiOWeJqrbouy8LF+Dh8NbkvmdFm0qA+z+v63lniMoWpN4AlxUf7+e7Fi3G/cPK05rYsxQ2/1VJ4ziGr/jjz9h5YBqBsgtkoEv5TvoV6oQusA7zKIPM9eCONxDNWGEBavDFozok/HAHRtrCfXtHhqTZkzQptdkH4I2r7caTQo1NTd7+ntu6Pg4z6u5Lrdidz2hEtU1xeomLO4By2eJVOO/hcS20YOc2t5ZMgsZJhVIL4zzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:39:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:39:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaflqwAocS3d3S90WqoPDmpOE9v7FMwc/Q
Date: Thu, 28 Mar 2024 07:39:32 +0000
Message-ID: <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5288:EE_
x-ms-office365-filtering-correlation-id: ca3a8690-b03f-40cc-3734-08dc4efa3543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cT7L8PZ+wpAk8agLoJmIAT7cEC5vM2CxUjpPHJCToPtefqiFsNecmjt1C1+72tRxBwYiW+LQkMzQxEiJpxLzGxVeCOF+KOR5o2kC82QbXUrH/hZS8hRn0CMoFXRMfQTTMtLg8ra0i4ypBQ9OyBrJava78HUAzUqvbayWFOikxbhZz08Q0/ySZdUGivvz5gpP1SID/PcSxpNH22FjZLtU3kzueAPeL8NUk8ygpvvwTxP9wukGW4bKOjd0dZ3E4MZASNZ+JopfG11nVpypfk6uu4TGHgdUITh/gVo59MZT0LL/KkbkDWDQhRuSI0XHMrkPDlRAkNSCR/wDJUnl0FpbuQCLfFBCTvCg08nWRKFvhGm2LojWgxSbCdpbrzN6RIvCjgSnbS1tXmhr+8CARu2C5cM/EwplCxnJJWRx6BdiMkyTGjdyCjah5V7U1C8tYqhxSGf9VcT+ys09MPwM92k2CZU9gyXwQs2cGwP5emigIqYi1u8c9C2xEQZd6AFHtfYro8y9av7yuztPGmc7oDCuL1cdbNdBvgjqhWTvNN81E6H4P/B2fPGQFpgvz9+qnC7ZL/297rDvxu0p9s8yNIia+6ke1v9Cc7DvppNEY9+DRL10ImXpsDP8wO+z2yG6VD9QDbt/9tnXKyMlrSabMpV/zxjBbA3eMxlheiw/o6mJRMNtdLdy6ZxLrR5B3FWVYT+Y07MiW+d7Eqmkak1/c8qYyqbdLoFfVGQQ3DtImR9n+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Z+lx5wOpa/fHVXfSwGlwEBwDcGUVbA9Gx6PmsQDz+fvVrqhopVKbBBN45hp?=
 =?us-ascii?Q?8wEVl+YDTOX6tCx+ObLDJ/uUHekygOZUXV1o21cORqpDgrbU9DasSxvcJIaF?=
 =?us-ascii?Q?PwiwqS3tG9KkVYUiBbZiFH9UowOPIHXV3OTTQqPkIOVY0fsDEwHNs8gfEqPt?=
 =?us-ascii?Q?mGhuqguQeH2+g1X1UHukfaRDrlW5IEl4omOzIN06ppJnmpQG/YSsZ6X/NC4I?=
 =?us-ascii?Q?X1cSBg3m760kIOgAjHHjTXlfukQQXb9mlU7LaQulB3I3Q61tbTmNW1OaLCmS?=
 =?us-ascii?Q?TKT93s4HyRLTy8RtiyG9adVGohuBer6f27Ukw+Wr1q5lZEyYZHWN6ajf2lRQ?=
 =?us-ascii?Q?DZq+Qk6euRBEAmotCcRe9ZKUE4jMrfcPi8ouHFkJ/H8T+O8B92yb6pQ7yhgo?=
 =?us-ascii?Q?0+u05NcoJCIjmPwQFfmg0cnPHYRbrRQcqI659k/AxgnW/PvPyGxiKinc69FI?=
 =?us-ascii?Q?ryhA+kO/kw8MJM6rFlPHl3cLbmzBIarnlAEa0xc0naUAm4FpfvNKxU0p4IIG?=
 =?us-ascii?Q?UGFhXc/ChlHB9n+W6sIMVO1Np60ctxKecxxWHGEGOz6XkBJGDCEXBhHHx5ij?=
 =?us-ascii?Q?M5cinOjt40S6shhWw8XSLULp0aftPtCpPZ6IvIGVgyD/pg02Tzy/D5r3CnGN?=
 =?us-ascii?Q?FhdVYwkCWsAhNbhHk1s6Qpi3Ucbg3M0V1qR6clniUVtFKD8bZ35BPkCsKv7f?=
 =?us-ascii?Q?/aobaJOcEgQxpJKCEAciZ+4yj50ZS767r+oCA1pf6CtokJK9JIlRy4bJo6XX?=
 =?us-ascii?Q?SMGuGa9cLD2C8iB+rxUkHtnb6BF5+qoAripU0bGZ/K4ENldHltUYrD/LBJZb?=
 =?us-ascii?Q?4/WkSP8KRukxQae2v5J8348/inxO7BqS2j4QEwfibs0deJT3EtxYWcBWrnkw?=
 =?us-ascii?Q?PNMJYHuQzVa+6/j9UGJ08s4W50sH0TiwE98lcS8d7RCuMUR9tUHzk1lmVATC?=
 =?us-ascii?Q?P6VMZSPnn59S1kDOylRP1rCUNs8rS/il3JSu9ip1Tl6lSpcBKiqa9z+R1/kU?=
 =?us-ascii?Q?ToKxv6nwGnrxA6yIr95LpA685pD5KfjJ4VjykaEayQbBDX90GmXvqwIPrgpu?=
 =?us-ascii?Q?9OeChPr/8nm3WK3ztk2gXSkDf7tMLlExP/vepHmsg3KyTdq33tcyWq4jChSO?=
 =?us-ascii?Q?ul3SJ10c23VTZkHHS5hAfCCu27jzwi3PNccg+ANtjzgLmnHkqZ2ibTTbSnbY?=
 =?us-ascii?Q?KXyDrsufTxJLl7viuRzI3GkQDZ7Iu6YNvKbQoqwTz8+5uzw6BPGyZYEgLAr4?=
 =?us-ascii?Q?79ZPXVaf23qUp/p84UIIq5RXM+VOk/IITMep8IYv2S0ve3LifPRFXJMZdAaU?=
 =?us-ascii?Q?d61L3KeoCeI6tfT4P12FgZ89Q78GF6ALhRbzJoR3yBPuLSa8aIr/tdDvtRDo?=
 =?us-ascii?Q?aJPuxd8V1Mp0GJ+ba0v1RR1EJHnUhJuHuYjR4w8rTqgq1Q0SaROKMED0lL+M?=
 =?us-ascii?Q?dcXtk4Tr30GJze1+gctGWpi/1QYGbTxjGaPOARALWfVO1592unFXS5JsDCQN?=
 =?us-ascii?Q?KTk+mRjek5rerJmxrZ7+/nyAk6NPV3y4XYjUbKG429fTWezZvwD0FMLBB/+c?=
 =?us-ascii?Q?W7KQLLmuBMehQ5nYEGQmTtgWpvELZYoy2VajZzPA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a8690-b03f-40cc-3734-08dc4efa3543
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:39:32.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6k7/K5G6nZlN+5VXf5ZAFaZmyFGN77xtB4Sa3yx5ECQbalFYLiXIZS8ZFuW7Cx/yCG7Ct0U2bBUoMCGiI7H2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> +
> +static unsigned long calculate_psi_aligned_address(unsigned long start,
> +						   unsigned long end,
> +						   unsigned long *_pages,
> +						   unsigned long *_mask)
> +{
> +	unsigned long pages =3D (end - start + VTD_PAGE_SIZE - 1) >>
> VTD_PAGE_SHIFT;

this doesn't sound correct. You'd want to follow aligned_nrpages().

> +		case CACHE_TAG_TYPE_DEVTLB:
> +			if (tag->pasid =3D=3D IOMMU_NO_PASID)
> +				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
> +						   info->ats_qdep, addr,
> mask);
> +			else
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info-
> >pfsid,
> +							 tag->pasid, info-
> >ats_qdep,
> +							 addr, mask);
> +
> +			quirk_extra_dev_tlb_flush(info, addr, mask, tag-
> >pasid, info->ats_qdep);
> +			break;
> +		case CACHE_TAG_TYPE_PARENT_DEVTLB:
> +			/*
> +			 * Address translation cache in device side caches the
> +			 * result of nested translation. There is no easy way
> +			 * to identify the exact set of nested translations
> +			 * affected by a change in S2. So just flush the entire
> +			 * device cache.
> +			 */
> +			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info-
> >ats_qdep,
> +					   0, MAX_AGAW_PFN_WIDTH);
> +			quirk_extra_dev_tlb_flush(info, 0,
> MAX_AGAW_PFN_WIDTH,
> +						  IOMMU_NO_PASID, info-
> >ats_qdep);
> +			break;

parent devtlb can has pasid too, though not enabled now. As core helpers
probably we can support it now leading to simpler code:

	case CACHE_TAG_TYPE_PARENT_DEVTLB:
		//change addr/mask
		//fallthrough
	case CACHE_TAG_TYPE_DEVTLB:
		//what this patch does

> +void cache_tag_flush_all(struct dmar_domain *domain)
> +{
> +	struct cache_tag *tag;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->cache_lock, flags);
> +	list_for_each_entry(tag, &domain->cache_tags, node) {
> +		struct device_domain_info *info =3D dev_iommu_priv_get(tag-
> >dev);
> +		struct intel_iommu *iommu =3D tag->iommu;
> +		u16 sid =3D PCI_DEVID(info->bus, info->devfn);
> +
> +		switch (tag->type) {
> +		case CACHE_TAG_TYPE_IOTLB:
> +		case CACHE_TAG_TYPE_PARENT_IOTLB:
> +			if (domain->use_first_level)
> +				qi_flush_piotlb(iommu, tag->domain_id,
> +						tag->pasid, 0, -1, 0);
> +			else
> +				iommu->flush.flush_iotlb(iommu, tag-
> >domain_id,
> +							 0, 0,
> DMA_TLB_DSI_FLUSH);
> +			break;
> +		case CACHE_TAG_TYPE_DEVTLB:
> +		case CACHE_TAG_TYPE_PARENT_DEVTLB:
> +			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info-
> >ats_qdep,
> +					   0, MAX_AGAW_PFN_WIDTH);
> +			quirk_extra_dev_tlb_flush(info, 0,
> MAX_AGAW_PFN_WIDTH,
> +						  IOMMU_NO_PASID, info-
> >ats_qdep);
> +			break;
> +		}
> +	}

could this loop be consolidated with the one in previous helper? anyway
the only difference is on addr/mask...

> +/*
> + * Invalidate a range of IOVA when IOMMU is in caching mode and new
> mappings
> + * are added to the target domain.
> + */
> +void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned
> long start,
> +			      unsigned long end)
> +{

I'm also not sure why this is worth a separate helper. why couldn't it
be managed by previous flush_range()?=20

> +	unsigned long pages, mask, addr;
> +	struct cache_tag *tag;
> +	unsigned long flags;
> +
> +	addr =3D calculate_psi_aligned_address(start, end, &pages, &mask);
> +
> +	spin_lock_irqsave(&domain->cache_lock, flags);
> +	list_for_each_entry(tag, &domain->cache_tags, node) {
> +		struct intel_iommu *iommu =3D tag->iommu;
> +
> +		/*
> +		 * When IOMMU is enabled in caching mode some non-
> present
> +		 * mappings may be cached by the IOTLB if it uses second-
> +		 * only translation.
> +		 */
> +		if (!cap_caching_mode(iommu->cap) || domain-
> >use_first_level) {
> +			iommu_flush_write_buffer(iommu);
> +			continue;
> +		}

the comment really doesn't tell what this block does. from its intention
it probably more suitable to be in the caller side as today.

> +
> +		if (tag->type =3D=3D CACHE_TAG_TYPE_IOTLB ||
> +		    tag->type =3D=3D CACHE_TAG_TYPE_PARENT_IOTLB) {
> +			/*
> +			 * Fallback to domain selective flush if no
> +			 * PSI support or the size is too big.
> +			 */
> +			if (!cap_pgsel_inv(iommu->cap) ||
> +			    mask > cap_max_amask_val(iommu->cap))
> +				iommu->flush.flush_iotlb(iommu, tag-
> >domain_id,
> +							 0, 0,
> DMA_TLB_DSI_FLUSH);
> +			else
> +				iommu->flush.flush_iotlb(iommu, tag-
> >domain_id,
> +							 addr, mask,
> +
> DMA_TLB_PSI_FLUSH);
> +		}
> +	}

You skipped devtlb invalidation. yes it's not necessary based on current
nested translation design and this part is inconsistent in different paths.

but as a semantics change you may want to first make removing devtlb
invalidation a separate patch and then do this cleanup, so bisect is easier=
.

