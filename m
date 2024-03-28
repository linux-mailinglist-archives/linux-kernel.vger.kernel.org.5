Return-Path: <linux-kernel+bounces-122527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE888F917
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88E9B25766
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FD53813;
	Thu, 28 Mar 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHaN4e39"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCE29CEF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612034; cv=fail; b=ttHjqanOqjEmRIP9tkrEVeVF38h3esT7ap3IlslKIlFvDEvX+SRwm3sO+hFmtBbNZdChPvJ1nVjpJ9a8ppJ7POKjkb9UQdHjKYeXRgU8g8mTJE6gtjRx5md7cy/FoyfAYNoM5Q3zbVuR3NJ8twVFb8ThOzV7x094vUT0Ta64rQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612034; c=relaxed/simple;
	bh=v0T+mZJrX1FFGLvRkGONpPXJ+s8OzBkB8GwCilG7oJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rz95ASQ34lSuZrxjE/sw3F+spd3+APh7gNDZa2BKNII/juS2WTSJ58/92QBr5SCJnLbekU8d+cK8GqTwt9K83WJzvs4TNFhnGI4/0fRMdECT2/igj1YsvTN5SIoVZFHRyIFm6zOBmaTqNiijpYsvX5R1q50YsoQS6z2yQNh4d+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHaN4e39; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711612032; x=1743148032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v0T+mZJrX1FFGLvRkGONpPXJ+s8OzBkB8GwCilG7oJM=;
  b=iHaN4e39QQu1e5tQvWGrdvQ7OhXb5z7ZG9fg95ImQJl9h4mp2gi8IL5h
   FYh34o+RZwoyRDKEV7qqPEQiUsRI1dkEQ1QTHQl6ORqYZX0boibxQgooV
   2gusnBRv86J14w7e26+amvUEsLExDC3ussSNIUnkpVn7HcZqH4QpiPAod
   PfxLtxz/owCKChguFMnq2SgYfuQQsS1jTURNHzGrfqG9QHbKVPIcKXbmf
   OXGC42ulr3tCiilJV7MFP0paCGHIbxYVw47jBF4krm/lEMLuiMOAl2k8Q
   6zeZf2tQlU6LRKcNGpRHvmq+am0InbX3zD7ZWGrwIWz8pA5q7vqBI0H4w
   g==;
X-CSE-ConnectionGUID: KZBUx4JgThyjefrZbZtU1w==
X-CSE-MsgGUID: IpHgKZbISgWPhHfDTIBKkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17301478"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17301478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21279248"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:47:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:47:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:47:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLr3zev/TAqRc7luqnhhysHObP1L+WfgzQ4QxgTrgkK0i+qw/CdeUogeODtqaF3LbWU8FLuG5Uo8N2c5a44YEYZgqRJeqBJjGNW+TAmsUzPiyDTU5tYCAGlNavU5w3dfd0QUtsTnA9yV+LoWaIPCYPnLbja/vdVRI4i1adaG0cX17BaViDpUTlW5KOHdlFhbjtGmiybguU6jscF6luxs9wFjVpxwKdXYSNS4LS3/aqwPwtW4WACvqvJq6zrf2Ub5ZYhEEM6JImUON2hbGVaQSnyFNxJ+5q42gzbhO2zXgtaOv9vHAhjEKQQbe5iXSiLPGdD4tHtMMO41MD9Y6Ym2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfotcbQZyq6Ng8lT3z0ykKS39SLK9bdRJht2il+MADY=;
 b=cM+VtPgWXZlIsM5Z23N2CoKqhUC6uaJTYnUr+0G8ILpdyDvb6BgzMH34ml/ECQmKwqHmhwPt6GBJ6dxe8YpJGthlTny05TTcByT/uxTkeQUPJk1qIMS++KW5z68+Jnkg4s9j3Z8mCT1UDopxJS5BrqZEhlpd9rIb5U5N6yb1T+y7Otku5o1ak0iNYCTwhHu0NfNakzRNOx91KnqVOWnLD32Ap8bpOUvf4Y9+l9xM6QrR3Uy+LYLc1r8/wl6VYB0V7QTUkSV7qy/mprymfIvKLL1Hhy7K2VXUj9GApH5eWbuAHK7uIzoeTUEEONj4/lamtffzrLICkuSo/9Z8DShm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:47:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:47:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] iommu/vt-d: Use cache_tag_flush_all() in
 flush_iotlb_all
Thread-Topic: [PATCH 04/12] iommu/vt-d: Use cache_tag_flush_all() in
 flush_iotlb_all
Thread-Index: AQHaflqzlxysz7sOi0aRZ4Pci9LCLbFMypQg
Date: Thu, 28 Mar 2024 07:47:08 +0000
Message-ID: <BN9PR11MB5276A9E7198B3C9E0A61A1A78C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-5-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5054:EE_
x-ms-office365-filtering-correlation-id: 0abe1e53-c1b2-40c8-e02c-08dc4efb44f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Sfw9SJlhkD22zb808rRgrDe5aKbNYMK6Py+PzNzu1Sn4PXlhqiW8YkphvREkU60aIWTSQ1kchxJzz1WyfZ7IOvpDfYlTnopNkUtPRRaNpaaCjZYXkDOXkbBZUd0Fk2XSSFxH1T9zG+4JBNotWeXxrIes7KUSnrqwxuu7eByMKrScZnRQLmUXCbMs9SlTnQfKc6PJSohSMnWjSDKst7oUUKmReWrEEZaC3+VTQS+q1q90pcmoiw8lUchIqJbDT2faWVh35CVDEu2VqJyxQ5UzEd8/trlEGRKmDYdxw5vVnB8wZEnyENB4p+4yQN2t5Lt5CeaetULZgL+mbpn4Q/J8VVdymZi+u80kl59kUSMY3d2/QadkI8vxyG4Lbh+1e58ruktuqOuidGKqiL67eGP9zSK5nAUlLF0exWvfJz8FAKvPnBhkS6lJm1oFlarH+97vj3dWAlTZZqtZc11jUMkyCy1BKz/Mvn8oGCnzLfnqw4kRPIDI68L5vH9EPiyq7ApQM3KiHQtSrIZQsLIZUUN896AVWqdNdR6AIwbE+Jrrw7dcscO4vQSTPvFzqrRyPBHfnaRXlefbORImIy9r2610OatkYMa0iGWnJz8wbahDu8hgRcjcMiQm+zT/zveFScB7hwq2t42Ml2JGoZ5eIq9mz1BYlYiIUARH1l8aJ7byTEFLHJ68fG+MdMASdoRs0pcsoTxS9C5I41ydl9phvFF3O1Rp3WY4RaMJxga+hxw7c8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D0kss5/oAawLJVhS/tu3NwTxbRvQ3UiasYeZ+ydoW9YYDpV10boRweiNVVSX?=
 =?us-ascii?Q?OnYFyQ1NX5xB/aiRXGkXmBvGWNyjpdACLLxv2xXhxvoxBrhVzKclkTul/GpD?=
 =?us-ascii?Q?ssayiuuGgJc4TQDHgDpMG1ybB/BwY/CadLJyA3cCYskEWuz60eJ16/QSfJBY?=
 =?us-ascii?Q?IVbpQ5qevMEBPHEPlwD4opT+Gl0COHze/bpxPbN6sLiuJib+VmJ5vDLA6ki/?=
 =?us-ascii?Q?JY9ZvB9wtH/IGOdKmCPzdnVr3VXrqMh2txbxvE0Dkk2+ntnCwMzP90puCryT?=
 =?us-ascii?Q?xfFjleHOkbfwzD9F2OPDCS/7Rwx++I0qOURj2LgTOCJWQpuEsXm+y8xvtTFx?=
 =?us-ascii?Q?SJ8Jps3qkiS/B/aIFrjznCNPOXCO7azoVTnKflPxUMDmivOsapCs6lzk+BRL?=
 =?us-ascii?Q?r6wP06ucFr2/L6fsL3rRAD8p1NS2EZhsUOsXcczUG1C/9sCbjGEaZqK4saum?=
 =?us-ascii?Q?Y+TXlxnoE5HHg7rrOSZESyCgTQf7iOkIae/NJPAd1c9LqPm96AOwGfueYyEb?=
 =?us-ascii?Q?p6Hm2zaXy7tTZe8vElBndkvFKaTsAGbfSFo+0UWYJQKqXgARaz580pNGPd84?=
 =?us-ascii?Q?lfWLOXxdb4aFB2OsKECZ3EcpPGhe7tjSEAn3eBPEomTsp8h74ESLDB4wBPNk?=
 =?us-ascii?Q?c0jrH8PUmlHf9673sODqaojbeDKF3m6Jpt2v0dE7TjKus3ImiZYLlfb1+d3z?=
 =?us-ascii?Q?xJBCzzhhWHR2lVx79GAly81drAes0caM+C02+NO2g2aSVgsTFWtvskkUcRvz?=
 =?us-ascii?Q?ABU5sJdp7rEprXZaOf9LHIK8540oYLVTsrXyvoFkfUVt5D7uyRnOMkfAiAys?=
 =?us-ascii?Q?1J9UR8qMBcUvdzb4rJewWAjV3MyvVpIKCRA93HeZYqy97w7Rv2XHqvuF3mTA?=
 =?us-ascii?Q?WDRYPjIACqpPPZ3FJi9zlLim0nogc99Xz/z5ubn99MfO/KdQP8fJC2w6Bgtc?=
 =?us-ascii?Q?dIzHzx3Z5GzKIZUPYzqXeiu7e3gFYHq2TLDjsqGadAu+jN+96ioODbFxo7QY?=
 =?us-ascii?Q?nYVphqn3NXkoNSjOeJlXNlvpXQPJQ+aD8BqliRhv+5DpobES0mfjCQylz0oc?=
 =?us-ascii?Q?OsaDQX3UktR9+UhakMqSqAZohCb9TAQHnygxjIiZG/C20BvE7lieheHdkRSF?=
 =?us-ascii?Q?1rO8mRTsOgAvFMha9nQq69DHq52TaUtjRey/6zzFob57TH+5cpy0ZbtqrYTZ?=
 =?us-ascii?Q?JdReKagooKSwQpLd470PRtTNZj0WzCOrLcxg3hSgzf0gWSpLIFoN6qNCAX5v?=
 =?us-ascii?Q?x2LKi4S+en27JBnha247ANuvqa8CkD6xtbVHp7ni27WEC0GQmDBf4jZr8dbD?=
 =?us-ascii?Q?PZYeDc1NEBQE3Q/GU2GrQCSAkfPoDxjdTxz3GWlXgfi0rhCPxRenQzstuIcZ?=
 =?us-ascii?Q?ceysU5ODuEyZugkdg/cPQKhEvEfKq8Xy1hFLg3nTuaSW5uSH4HBhffn8wJ9A?=
 =?us-ascii?Q?WOvSwZ5kCz4Za+X0TET/s0w6JSstSfPpDIgok/1Jba7h+VMafa2iKkZOD6G/?=
 =?us-ascii?Q?MtFOTJBWmIZpW55v4hzKUo7AIoL7xUAJq2ws0jlfiPVCPc20gPiWs090pw/L?=
 =?us-ascii?Q?hCiYLNCAHe/BU8DgIKwAZ4JFJcifccr8Vdy51iuu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abe1e53-c1b2-40c8-e02c-08dc4efb44f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:47:08.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iijArYZQLeWb2xk6LeswuD64nvIWmzgdlPrLXlNzHYQYYecgnwNqDpn6Z8CGVIuOQVsStv1K/h7XNg8wjEtUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> The flush_iotlb_all callback is called by the iommu core to flush
> all caches for the affected domain. Use cache_tag_flush_all() in
> this callback.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 93e4422c9b10..4ce98f23917c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1560,26 +1560,7 @@ static void parent_domain_flush(struct
> dmar_domain *domain,
>=20
>  static void intel_flush_iotlb_all(struct iommu_domain *domain)
>  {
> -	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> -	struct iommu_domain_info *info;
> -	unsigned long idx;
> -
> -	xa_for_each(&dmar_domain->iommu_array, idx, info) {
> -		struct intel_iommu *iommu =3D info->iommu;
> -		u16 did =3D domain_id_iommu(dmar_domain, iommu);
> -
> -		if (dmar_domain->use_first_level)
> -			domain_flush_pasid_iotlb(iommu, dmar_domain, 0,
> -1, 0);
> -		else
> -			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> -						 DMA_TLB_DSI_FLUSH);
> -
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0,
> MAX_AGAW_PFN_WIDTH);
> -	}
> -
> -	if (dmar_domain->nested_parent)
> -		parent_domain_flush(dmar_domain, 0, -1, 0);
> +	cache_tag_flush_all(to_dmar_domain(domain));
>  }
>=20

this replacement causes a functional change. Now devtlb is always
invalidated while old code doesn't do so for caching mode.

Probably you may want to first clean up all inconsistent devtlb
invalidation policies for caching mode before going to this series...

