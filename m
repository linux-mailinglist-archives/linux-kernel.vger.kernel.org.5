Return-Path: <linux-kernel+bounces-144524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA38A4760
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436841C20F04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14F1CF8F;
	Mon, 15 Apr 2024 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffzkTaqN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA61CAAF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713154507; cv=fail; b=KxREY715PRp6XgZ/RGNI9Je2fgUxskHhnav45rpihvJPl3LRnE6P6PY0r7i0uu0xD5n4nWec9EJOo9tYmLOZf/24Os3R3LaOa1UVpKiRAdCfrO9avd+f7PExhdJXdQSnkJIKrXZsMusbFwAOpHC/D5DROQNzmXXxLuFeVyaN2cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713154507; c=relaxed/simple;
	bh=5ZxvwRYXWiu50ysET74apJaEidQ59Dpz/5lUHNu6Pxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oZvvax3TT7SgWqjrcXJBP1irameKiSb9N+fGH6Jn7bnnYrsvZxtZghWNNsodyryK27dzE74d04msCmmF3hOvcLn1l4eFNxZ0rV8qZQVc9rxKkQijR+R7VdNxHtL6czXd2hM9IGRXZW8DIdy511L/A4Y1Lz5dPJ22tjto7wDIAzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffzkTaqN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713154505; x=1744690505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ZxvwRYXWiu50ysET74apJaEidQ59Dpz/5lUHNu6Pxs=;
  b=ffzkTaqNrWeYsFCAJVgEgoPGY3GXNgtSMn7Urzo4DWPplOuUGN9yIvaP
   WCRlX9rE4/iDpW6bvmygft+3xrWFVbtr5/hMb8AKoRa9FxUTBqHZqRV9R
   RvsUtUDwZs0vaMklxYxiqFd4Q3c+Nc+BeOrc9edoVKQrM6GnPAzxVeLZq
   9jJYv3ZvXM8MEo2m68Kzbg2lAX53KhZv5uGMJ8WoZA1T87bY1D7VTbJpm
   vwBk9OUAf6gep1r0vPBM2fz6Jlje9sYu8wgCMO/8mKiYQxr/ZtgZex9pj
   KBQWbEQR2YfQTR/crigB8b/D6RyfWYOqEu6dOfG9jH2trheGO1XRNVPHr
   A==;
X-CSE-ConnectionGUID: GY75uio8R7eVtBL5HZPdWw==
X-CSE-MsgGUID: lGWyeZ1oTsuGOVC6dJlVEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19086763"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19086763"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 21:15:05 -0700
X-CSE-ConnectionGUID: TY9XrXPnScSOHWRSb6uUMw==
X-CSE-MsgGUID: RrqQj2eoRjSlejHYg9N41g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="45054292"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 21:15:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 21:15:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 21:15:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 21:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU9RQ4390KGkEA3KLMhEk1IiebzZslp/fv4iwhhAxp1PfetX1NsWj8oDf23VpnpJMUrAWTDHnbzl31J2xpKxFkDypqcw0h8sAKpJ1VQ8d2M7tCuEPEFFTH8PXa35kZwGRq3Os/Slp+B3fA7Zprc2oWGANGw2e1sHVq2aCNx2JmzFALy5sxeBB8Y/Ang+cWXLW2t2jYgEEXxenx3S6t9BeVsqY520t+OfO0B5PcDiAUR50NGe5hwAGDPzsUnsuvu4XT1uAlhgYnzbloIv+5tWU+DAsQ8/pNPMY1zLnRZBLeN83+NJzkF5N4IB/TRgzQy4ySpab5Z9UgW1aCdZFKu9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEq3RIlC+8OS4eWT9stnqEoUBADzjKtRFoTVQhiRfag=;
 b=QfNNUXotp3luQ3Uf4WqHGJ7SR78wcnV/oCNmRmgxq4sZUYBPS8ydNneyyjnUN8gGXm0FLlQCcvtwfPkagIEgqwCfdzox+pH30rJLQFWse+01MIQngB63lLZINff3t5pDJyKb1v5pBGeDQ3Yb9R6X7a5ZjxYGrhRKT7fIr9gmO4Xw2SGslVyIDK+dVHZVELYXQwCFDUaAudkEaL/zH8LxrvFZ9dTajBDmXmqkWwWEPw5Edgespi65HhGllWXWTE4zw2hq0ZO9QJjc2xHrzsqz2XhQIFlkReMZPVyy/AztYU3Lls6VYnyr1dIF0cyqvZYuZClsIsCGj2KH/GKMmrK/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 04:15:01 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990%6]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 04:15:00 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaiuw7gyA3rCRQvUattkDbYgfhd7FosdxQ
Date: Mon, 15 Apr 2024 04:15:00 +0000
Message-ID: <MW5PR11MB5881FE21211FCED9B9BCBAB189092@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240410020844.253535-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CH3PR11MB7915:EE_
x-ms-office365-filtering-correlation-id: f579d5f2-5934-48ad-f1cd-08dc5d029e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6d7xYZ65BlU7DaB2fbx0+14C7uuLZ11mdKRZODfSRSJfRmTMyAUD8UJjPUVm6GlRqUzf0yTbU0VAXXhgUky05CFGT0oDXCYs1/Y7QmsHqv4/qJ4xc9i6B6b/zBImDbmvGWhiotBVBpGNAbOwE3S8l1xFje8W7uBLTQL27zCt+5RNfrmIsOAG4X8ts/bwEnfgEUVPVha4ET5Is9WHayxvygkn30yD5pXEbqSgAC0aswvVCrUC7v+pIQfJcjqrV1hMDUtGso2aNyuE7gVq4MkJC3FXo2IHShcGBHiSmXa8iPgcrRpBBZ0e66Xj/F7d7ITxFsb0eNSt09Z24Z6BrqMUEBwTjJ/AlsGIa+zvfuVa0iWZatRzKjZ58Pv5lCd/5zDrmN+LaIHa14Pr8PoFGwIKwZ3vue4Ud+QU05RBWyB5RMYilSUJzCURS7NJ9RTIQ1HOGItaXBfvu7PK2MD3jjpHqV22o1q6wskFvWvmIYR/O78XkNZ9sOG90u4O/M5H2GYU6NkpyXxRRx1lgu4sdaZWI15qGWH46xG1mMCuJYTx/umgtuzs4E/+76pe+EDMBwQ6cjf9IIvp+R0WnNurYOSodzPk6+R0O5ETjLdcgwu6mV15mu07tG3k9P5Rt+RxqFQ8EvtpReayXkWA1QtbxvHiJOHQLWRfTYFRSbmN62LL25ziFdO3Ljl1NiqHPOKxNGY6ZmXk32HUstoE+Zh2mbirg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7rWxnjPeJOhsCGYFYoflePOZ4VlNXYS5mCaB3StmC0G8GKFO30V/HuXASxS2?=
 =?us-ascii?Q?A/vU1TbMrL0H3jktDJ/GfEAUAqepIZ+vzM1vjncVh40tVfhlIzr3O9LRLBNR?=
 =?us-ascii?Q?tFZZqI/F74jzSptulMfb+gjLIpICfSt1fxkRITIINa2+9YtMesl9f16IjhD0?=
 =?us-ascii?Q?tZCDxewd+tD1+rWO8GFCy1Qssjry0WpTN8jTk51D2JAgy6oG296q8kCDYa92?=
 =?us-ascii?Q?HaBne0Py9rqRintMZfXfgIM28rWdBmLj0zvWBOEshORuyxThX50/g4TkPdln?=
 =?us-ascii?Q?uE+GoABY8kJciXtnZSmPVy1CeXpTVlg43E31bAjwOng6QCmh6YQJkpZiXpg2?=
 =?us-ascii?Q?hPONVv1D5zO/5RQJhBH80euj+pNU1hz6A7tWmMNjNmg/HWYOLLnTQPJ/hO2s?=
 =?us-ascii?Q?m+G6xF9AObKsom+E/8PNdrFbx1EY8LePx9deJoOlZ2Ihh+r8f3oLjYau2NeH?=
 =?us-ascii?Q?u5EpjBwE+STXh1jFadUmEaJYlpa1ma9NsPI/J5n107eCVUYMSB0SSsP5OMZl?=
 =?us-ascii?Q?hB5OQ4NE7mnjshTKWdJEwjOAD5LRZ00Za0rPy/HVHu8fF4KgmoY3S7Mnk6cZ?=
 =?us-ascii?Q?3mnSXiCRlpdf6hrZvxSaN3qdQTQ/aX3kIKL8jm2cKrSvpq4cYTl1lEK5tSEB?=
 =?us-ascii?Q?uTEpskuw7KDHNzpe1l/iH3pA1d6XAgOioM+0lEsHxBhtxgbwoE5EEQJMU69z?=
 =?us-ascii?Q?f7dzX3d1SHHwXVQ6jMC2qLqqrY7WeL63ed000GSj5maX6tYqSM9mshPDx80n?=
 =?us-ascii?Q?DoRrCziDfDPauk5RiEedDBw9aX6sw4Zfei0G4bOBJQxijni3UKBD4p6S0Twg?=
 =?us-ascii?Q?xC+6pv2JwGXgi8T1bTOggFaqwq/0Db05HhzlyUQCVHhMROur+M+uB6gyY4B0?=
 =?us-ascii?Q?uMOsOvuxvzzhzSep+uLfidpgKsNDPdJE0ZEDhw0tWnQsqLc+FVx2METx7ulT?=
 =?us-ascii?Q?ONavWd0Aj0uUm//3ds+5b89KKGL8cYBzdvAPhWk3MesqLc+P+0Q2sIPc+0lX?=
 =?us-ascii?Q?TYE2VmOVpE2wd0SdfApP4NqQWYwsuQ7mdopmZfTGlGyYJ9cKu+ALTiRMT8GS?=
 =?us-ascii?Q?Ao9JszCfZn3IMaozTe7as8JugEFFRm8J0jFGcNdHhlLUy5pGo586lVnq608F?=
 =?us-ascii?Q?Jw3aGd8z3LVb5oQ+vxKhxRx9js2wFf6j0KNaG3jnDDy4+6lHIGiPg+LxamuO?=
 =?us-ascii?Q?MsVOh0S8FfSy+WGbS0dx5B8i72NYxjH0bKu43ABRUfYZhZwaX2vSRxREKj8e?=
 =?us-ascii?Q?/0YJ0UPxY/MgWjpsVjTiW1srSCy8W2z9To5R3k/W3CscizQr6Mm7DrwEGW4F?=
 =?us-ascii?Q?slGKEj7mU44Avmxx6J2sK8DwQc48joNc4llZshnQcHcfQGF5TKC/yT/dkD6u?=
 =?us-ascii?Q?sD0lKAwUxtZ7p4Lk7bSHPNuUFd+5mstQchQ4d2VePYjbcHU6vWrZzrZrM448?=
 =?us-ascii?Q?i0cfNbsrHGBt9oUH/NZUJO76ZQ+7QBJihMg/KZpXLU1QVgaGiCGnCxu+jh5g?=
 =?us-ascii?Q?O2IMkLnD2+3Fb81yE1hHuBITAPwFjVwtLgVB4cgbvP4uMyUVIScx3gkJjbEf?=
 =?us-ascii?Q?Xq3U1CrswY4RZYWpl4WeOhC4+GotZ4iLZr8b42kz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f579d5f2-5934-48ad-f1cd-08dc5d029e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 04:15:00.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCDR764Wy8cKV8MwADGqP+kjUSWClD1HXV98/419ZzyaI94cndl3IJS4t4+/QESzCZsyH8g+/Bstg5BHp0OBog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 10, 2024 10:09 AM
> To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Tian, Kevin <kevin.tian@intel.com>;
> Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Zhang, Tina <tina.zhang@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Lu Baolu
> <baolu.lu@linux.intel.com>
> Subject: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
>=20
> Add several helpers to invalidate the caches after mappings in the affect=
ed
> domain are changed.
>=20
> - cache_tag_flush_range() invalidates a range of caches after mappings
>   within this range are changed. It uses the page-selective cache
>   invalidation methods.
>=20
> - cache_tag_flush_all() invalidates all caches tagged by a domain ID.
>   It uses the domain-selective cache invalidation methods.
>=20
> - cache_tag_flush_range_np() invalidates a range of caches when new
>   mappings are created in the domain and the corresponding page table
>   entries change from non-present to present.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  14 +++
>  drivers/iommu/intel/cache.c | 195
> ++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c |  12 ---
>  3 files changed, 209 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 6f6bffc60852..700574421b51 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -35,6 +35,8 @@
>  #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
>  #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) &
> VTD_PAGE_MASK)
>=20
> +#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
> +
>  #define VTD_STRIDE_SHIFT        (9)
>  #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
>=20
> @@ -1041,6 +1043,13 @@ static inline void context_set_sm_pre(struct
> context_entry *context)
>  	context->lo |=3D BIT_ULL(4);
>  }
>=20
> +/* Returns a number of VTD pages, but aligned to MM page size */ static
> +inline unsigned long aligned_nrpages(unsigned long host_addr, size_t
> +size) {
> +	host_addr &=3D ~PAGE_MASK;
> +	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT; }
> +
>  /* Convert value to context PASID directory size field coding. */
>  #define context_pdts(pds)	(((pds) & 0x7) << 9)
>=20
> @@ -1116,6 +1125,11 @@ int cache_tag_assign_domain(struct
> dmar_domain *domain, u16 did,
>  			    struct device *dev, ioasid_t pasid);  void
> cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
>  			       struct device *dev, ioasid_t pasid);
> +void cache_tag_flush_range(struct dmar_domain *domain, unsigned long
> start,
> +			   unsigned long end, int ih);
> +void cache_tag_flush_all(struct dmar_domain *domain); void
> +cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long
> start,
> +			      unsigned long end);
>=20
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu); diff --git
> a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c index
> debbdaeff1c4..b2270dc8a765 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -12,6 +12,7 @@
>  #include <linux/dmar.h>
>  #include <linux/iommu.h>
>  #include <linux/memory.h>
> +#include <linux/pci.h>
>  #include <linux/spinlock.h>
>=20
>  #include "iommu.h"
> @@ -194,3 +195,197 @@ void cache_tag_unassign_domain(struct
> dmar_domain *domain, u16 did,
>  	if (domain->domain.type =3D=3D IOMMU_DOMAIN_NESTED)
>  		__cache_tag_unassign_parent_domain(domain->s2_domain,
> did, dev, pasid);  }
> +
> +static unsigned long calculate_psi_aligned_address(unsigned long start,
> +						   unsigned long end,
> +						   unsigned long *_pages,
> +						   unsigned long *_mask)
> +{
> +	unsigned long pages =3D aligned_nrpages(start, end - start + 1);
> +	unsigned long aligned_pages =3D __roundup_pow_of_two(pages);
> +	unsigned long bitmask =3D aligned_pages - 1;
> +	unsigned long mask =3D ilog2(aligned_pages);
> +	unsigned long pfn =3D IOVA_PFN(start);
> +
> +	/*
> +	 * PSI masks the low order bits of the base address. If the
> +	 * address isn't aligned to the mask, then compute a mask value
> +	 * needed to ensure the target range is flushed.
> +	 */
> +	if (unlikely(bitmask & pfn)) {
> +		unsigned long end_pfn =3D pfn + pages - 1, shared_bits;
> +
> +		/*
> +		 * Since end_pfn <=3D pfn + bitmask, the only way bits
> +		 * higher than bitmask can differ in pfn and end_pfn is
> +		 * by carrying. This means after masking out bitmask,
> +		 * high bits starting with the first set bit in
> +		 * shared_bits are all equal in both pfn and end_pfn.
> +		 */
> +		shared_bits =3D ~(pfn ^ end_pfn) & ~bitmask;
> +		mask =3D shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
> +	}
> +
> +	*_pages =3D aligned_pages;
> +	*_mask =3D mask;
> +
> +	return ALIGN_DOWN(start, VTD_PAGE_SIZE); }
It's a good idea to use the above logic to calculate the appropriate mask f=
or non-size-aligned page selective invalidation for all domains, including =
sva domain. Sounds like we plan to allow non-size-aligned page selection in=
validation.

However, currently there are some places in the code which have the assumpt=
ion that the size of the page selective invalidation should be aligned with=
 the start address, a.k.a. only size-aligned page selective invalidation sh=
ould happen and non-size-aligned one isn't expected.

One example is in qi_flush_dev_iotlb_pasid() and there is a checking:
	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order)
		pr_warn_ratelimited(...)
If the non-size-aligned page selective invalidation is allowed, the warning=
 message may come out which sounds confusing and impacts performance.

Another example is in qi_flush_piotlb() and there is a WARN_ON_ONCE() to re=
mind user when non-size-aligned page selective invalidation is being used.
	If (WARN_ON_ONCE(!IS_ALIGNED(addr, align))
		...

So, can we consider removing the checking as well in this patch-set?

Regards,
-Tina



