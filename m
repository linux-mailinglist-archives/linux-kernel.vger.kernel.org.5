Return-Path: <linux-kernel+bounces-122489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597F88F86A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEED0B22246
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6550A6E;
	Thu, 28 Mar 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGZhXlhx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D27710A1A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609933; cv=fail; b=dA6VqimNzc4ajAD/tQedVpibSAfDa1EhrwP9Ac1FbA996uJ6QlRbZfD3raqOwYi3s6GWeZdRO3FmE8yhKlFQrZgSAtIxxRxYxwNqav5m2kJUF1/eVuI31CjNm2x7RgficLzVOGI9E0NczIquiBIG4ZzZtKh0ZmSs+A3p5MENBMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609933; c=relaxed/simple;
	bh=Bpd9RulmhBOILYOSI1f8VrgBEOpx4E9vdoSRyROhUc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2F1T1Y5de6xbtW/B/PbT3gGMzOWAzBAryNk/jCFuYG3uaUdxbhhWOAOJpmsI9qPwJsZQH6vfO86AoJnROzZrukNFYVWsShxZS/Iwx3rWXeZAWqHiXiM+5mqwQA2KlwQYI62Oi/Nh5l+Yh3RuHzd1iP7HeWAyo2z2l6ws94J/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGZhXlhx; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711609931; x=1743145931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bpd9RulmhBOILYOSI1f8VrgBEOpx4E9vdoSRyROhUc8=;
  b=gGZhXlhxG7va5q06w64NH2+NsDzq/AtLAIwsTqjc2o9Kl3C0ihR1pWjM
   kqWL92QNc6vnA2Umin49fpeXTFsHWLqYZjkeIXMjaXAYf99STdv5kmcLq
   JYe1U++W1/QsJSmthimejFiMzaItOVTqCizzvYrtUXhwgto8NJCiXvnq+
   ah+9RRc9niwHn17SH4TbYuhRU7DWswh9fL2xU5NKX7qxxu2mQHB/Dx1KG
   qBXeB4WQCzciUd1g8nnLnVyCroMtdUsMT2/ykzN+b+FElOIeKL35pEX6N
   Glq5gaWJin9c4SYHhbCcvGTNE0rad5DBjKhfuDkvnyI+iNlriVcENeoq/
   A==;
X-CSE-ConnectionGUID: XDMvq+9TTN2QkZ6qiHSIyw==
X-CSE-MsgGUID: kaGJCV/8Sti3eEWux9lhMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24239004"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="24239004"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16378240"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:12:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:12:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:12:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:12:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyUBkvXCoA011/TRcoMExufRNgV7zByv6GbM0ssVVMNBlxFW2TTr4dGIDWLKvRzK5DXjoEYC8gz45C+pkXtUCgZvkTx+viOQ2Wis7i5gjrBx4GY17/o7mkArV/dDQRlg6/WsIBk56d8v99hFUik/oOweNRW9YHRi3PrTCz6QW7MUG+BwI6UrXyVWQnhffdpOaAqTBb2C0wap4El/VCB9jptswh+/B1/RoJ4m9yiBlLnyxMU8t4NZH3oPciEU1F5GGZqM9KRYfeSc6+n7gnG+bNQysGJRkIw7c1H0YqEDcNRKYNneSB67IY8RUN6K2foi4phq4Rux1Xm9jC58iK7EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiGnPnXzyt28EolXN3vmd2si+vRzzGWzo2IVJ5+OS2s=;
 b=KBTjgMGf5TYEQWhMrP1vXDxBzwFWLU6h8NbEIBC50S4PPb2NimlGqu5iy4lpEFbLFMwfG95t6DaAze/qxNJ0O5tVEq3nb6cn8pBSx2UGs9pdYafidfvzkOE2NFh5czA1qvyqT8ud3o0SKq8v5E9lf1UL0ZCHqDSujWyMNPg/z9dz+0q992Zm52BiAu0U+9qlbzMXFoUj03q4mjZFRP/j+FORipwKwJGTgDRWqGEFxz48Qp3ZEMsQyahNgATPxF7jEAWft26RAr7hKNJzckrt9IpY+i+swTMj4kCmFjWd98ueDU0UDt6l15gXhSTM0FPCKRjw56+FWvlDOE2dIIsqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Thu, 28 Mar
 2024 07:12:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:12:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaflqwfTup1ArZ00iKq9wT+H7xNLFMvHPg
Date: Thu, 28 Mar 2024 07:12:06 +0000
Message-ID: <BN9PR11MB5276A6DDE82623A32FF80F4F8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7282:EE_
x-ms-office365-filtering-correlation-id: 24f50580-c462-498b-64f6-08dc4ef66098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcYjThJdR8cA+QpW81k9Jx4fa2NpgXxUcVwhxOF0IDEY2Cj1Y9EHHm25id5r9elo2atXs7uFMVRLJ3wM+D24f1n8pxOUQTOxuGlP0yQcBu07V98avcdt3RjFAsG9bShy2GZUSgRYNPHEz+XNHYV3FoudyKaZi4F4jhbH3p7xiXJH9rfszvrxGoz/sTMG18/+eK/3DamXrOJO4JoBHi5NLM5FllDm/qO81SSIKNmOLKBCQp+jzncURQoV0E/SOl9iYeTP875gqfTcWox5cUW5+VZM20uP9Azz21zNNpn5x195SvKR6mYi6J/soKqepry8NVMGnLRSfaCryM6951IYTEERixRDm+UmE9CU2CB8eoTHv8woYcphvuN7a4iLpdbagpyM63v6waghKrd3R4X/PSst4ZkD9Q6rUOY9IMG2sgcG9A1AiXshPgdc8ul8O4bBF5nFLEtaqINTpLBe+CyXarLw92VYuN2ANZedCM2ny0F48WzGaX/qbHbNy9jXR3B/k6X9QrnohcpMXAKlBLY31OOPT4Ja24ulPgeDuFAUJSoQLu11ZVFqzVRmiRHtzGIGuYt/vnJBu8t9OEluSlv32/8Bb5uZLpXwHRviz/P5uPZShHjpcxGK7F78Q/6TQlNCjFpSADzY2w3vwMZy+XYdyv9jLQjhkU5hmT7QuWDOTErMd8yGbm1eK9FBIw9DuC72xZwqj8yKelgAaNY1dOxrsecSuUZrlAL3rPdy1eh3y08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZ5Lm041xeGVIn2tc4zqsYi0qycyDFn9yhxdB28q+cReehgpCImzVAiHSzRr?=
 =?us-ascii?Q?VD5NrBi6E2FrgzcbeOqxVFC/37mO6wplGBpzTiCsuIJ6E2FLbYS1mVYWaRcw?=
 =?us-ascii?Q?5ronuVypl+q5dRW1D4epkFb8BvMkpE/EJ2mdQuN9lDlIMWeiAVA3nzSVJsPl?=
 =?us-ascii?Q?HJ0rwHXF0F6BrN3+mwAlMdvpTo+tK5PC662bzngyha4WvDTG7YUj0C5bhK1p?=
 =?us-ascii?Q?B09RjmWJZiBJPmEOjyoXG6sJZ//5k70rqIPrqGszuD/3I1mh9rJb9pqr7V2J?=
 =?us-ascii?Q?KrIFAhq5OKpKU/j1Jye2da7Zamk5wOWXEjcM/hCF3SRcC7HSi1DPsepr0PdH?=
 =?us-ascii?Q?pv0SFNHwvocbkahe90opNeFDe0dHHNt1seiAVXbY7CL0gIdd2zpH/wN5Df4D?=
 =?us-ascii?Q?0DAOBYYi7V3tTr5VwG1264GQbAANprlTZ7C9cg2UJAkWRppnou3+QuwujZR0?=
 =?us-ascii?Q?5TBPjv4/N4LfjtHw3xX5KZf7gZnB2Vh+3KXYbfJQ132FCPxzHJVkZroVbSa1?=
 =?us-ascii?Q?IvBKlQDclq9K/1CL417Uz9KIcE9MY4i20llnArRrfx/vVu4f5n7SzDHFTz+B?=
 =?us-ascii?Q?7J7IwQ3Q/n2Y6eT6XgpU4ZgQ0z/INatI6GvFAfsOdjubx9/WXe2cxRFa3DBb?=
 =?us-ascii?Q?W8wIdblZrqaEP4qXHKNkfnm/raylCl5O43h/h1u5+56/U44nUSoLFUd8uy1w?=
 =?us-ascii?Q?KqogKAb6nfpjkNiLM7O1YsukofNu+JRhsbqssQv4ik1MZt3v3pyQmLAEfuM+?=
 =?us-ascii?Q?z0rvF+IDxJ1BArR8l/lK3n7EQP/wfxEaD/RlK7O158FmGnGQykqgr9U8mXfS?=
 =?us-ascii?Q?h9vJcyYhoUBrDzgLzCcmYqfy4LZ4unsU809t7xqlHvnQy5Cgs29WtY2w6f+L?=
 =?us-ascii?Q?uEnPvXSiRE/jcAQbD/fZuEjSXi7KUGf0pGMIYD8vGD9PAtIEyVcZZ/WBXlfc?=
 =?us-ascii?Q?rAdU/FPd4v0XceHJiikcgOkhb5dTFC9VUyZgdUNEedX3H7m6+fFbr6FaaJT3?=
 =?us-ascii?Q?nK6bc+gMYg/80Afg5uTp6qtynMAUmViGv5f6FoQOstGsIfot9kj6hQ/biSNd?=
 =?us-ascii?Q?aeoZYyk5RbtTW9AZPTkK+8gqOjTknFVPUaJi4+9cdiZJqln87GZ1cK6GqLuQ?=
 =?us-ascii?Q?LbnofqDJJvhDzuMNOy0wFRC0xfsjwS4F4lBN4lIEf2viKdh80DGM2LrfYXGd?=
 =?us-ascii?Q?tTCepDQsqO6PjOaOWLsvJYSs7OPNwk8yeogAaGue0r2NJ7H89vhGGlUanyay?=
 =?us-ascii?Q?M8j9UdqO7tow+/rH4aTl6ej1yUAQ6YsT5Bdf6h7lKX15J040Y388S+hFvSYR?=
 =?us-ascii?Q?b3SbpxdZAMYcIkYhmsN6eGaGafL+VjpW+Nw+XWcGfSWMkoLKA0j/ZTMYbexa?=
 =?us-ascii?Q?ayrnzySuXoxpAa/ragG1V/NUr6sC9BxmqPU+EiXau+aZ20FlidkNa0U4RWHf?=
 =?us-ascii?Q?72SoD1Vp6etYE/t8Cl8BpvfyZIbHVLSjZdYxNEBrVr4DIOBmO6AQAJ/B2HaH?=
 =?us-ascii?Q?V7T6HCyqyWzpOdi4vVdzsIDI3LVZsYMkMAqvQfY3fE3XUrRvs70glu2f55Kt?=
 =?us-ascii?Q?/HFYMNfVpRL6MwwuMVnK1ENAXHgoyyYa+naIC/Xd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f50580-c462-498b-64f6-08dc4ef66098
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:12:06.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRjY1mmrTzMThOPg6F4MjPTacKVZHI+Hk+QhbdALiGiK/qsDN5VQeMmTatnilKzanIyt5uVD2u1WNX/d74ilVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> +enum cache_tag_type {
> +	CACHE_TAG_TYPE_IOTLB,
> +	CACHE_TAG_TYPE_DEVTLB,
> +	CACHE_TAG_TYPE_PARENT_IOTLB,
> +	CACHE_TAG_TYPE_PARENT_DEVTLB,
> +};

'_TYPE_' can be removed to make it shorter

> +
> +/* Checks if an existing cache tag can be reused for a new association. =
*/
> +static bool cache_tag_reusable(struct cache_tag *tag, u16 domain_id,
> +			       struct intel_iommu *iommu, struct device *dev,
> +			       ioasid_t pasid, enum cache_tag_type type)

cache_tage_match()

> +{
> +	if (tag->type !=3D type)
> +		return false;
> +
> +	if (tag->domain_id !=3D domain_id || tag->pasid !=3D pasid)
> +		return false;
> +
> +	if (type =3D=3D CACHE_TAG_TYPE_IOTLB)
> +		return tag->iommu =3D=3D iommu;
> +
> +	if (type =3D=3D CACHE_TAG_TYPE_DEVTLB)
> +		return tag->dev =3D=3D dev;
> +
> +	return false;

why do you disallow PARENT_TYPE from reusing? It's not uncommon
to have two devices attached to a same nested domain hence with
the same parent domain. Disallowing tag reuse implies unnecessarily
duplicated cache flushes...

> +}
> +
> +/* Assign a cache tag with specified type to domain. */
> +static int cache_tag_assign(struct dmar_domain *domain, u16 did,
> +			    struct device *dev, ioasid_t pasid,
> +			    enum cache_tag_type type)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct cache_tag *tag, *temp;
> +	unsigned long flags;
> +
> +	tag =3D kzalloc(sizeof(*tag), GFP_KERNEL);
> +	if (!tag)
> +		return -ENOMEM;
> +
> +	tag->type =3D type;
> +	tag->iommu =3D iommu;
> +	tag->dev =3D dev;

should we set tag->dev only for DEVTLB type? It's a bit confusing to set
it for IOTLB type which doesn't care about device. Actually doing so
is instead misleading as the 1st device creating the tag may have been
detached but then it will still show up in the trace when the last device
detach destroying the tag.

> +static int __cache_tag_assign_parent_domain(struct dmar_domain
> *domain, u16 did,
> +					    struct device *dev, ioasid_t pasid)

this pair is similar to the earlier one except the difference on type.

what about keeping just one pair which accepts a 'parent' argument to
decide the type internally?


> +/*
> + * Assigns cache tags to a domain when it's associated with a device's
> + * PASID using a specific domain ID.

s/Assigns/Assign/

> +
> +	did =3D domain_id_iommu(domain, iommu);
> +	ret =3D cache_tag_assign_domain(domain, did, dev,
> IOMMU_NO_PASID);

there are many occurrences of this pattern. What about passing in
a 'iommu' parameter and getting 'did' inside the helper? for svm
it can be specialized internally too.

> @@ -4607,10 +4623,11 @@ static void
> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	 */
>  	if (domain->type =3D=3D IOMMU_DOMAIN_SVA) {
>  		intel_svm_remove_dev_pasid(dev, pasid);
> +		cache_tag_unassign_domain(dmar_domain,
> +					  FLPT_DEFAULT_DID, dev, pasid);

is it correct to destroy the tag before teardown completes, e.g. iotlb stil=
l
needs to be flushed in intel_pasid_tear_down_entry()?

