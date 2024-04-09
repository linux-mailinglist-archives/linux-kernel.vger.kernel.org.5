Return-Path: <linux-kernel+bounces-136354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE6689D307
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19AE1C20FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F707C08B;
	Tue,  9 Apr 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvkYDYOC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29F7BB11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647821; cv=fail; b=YfrN+E/PtAHoSA/OA93jBUTZ0VCFzbxNyB4V539/tmm8nXlzQqx/yoWvDKGbfEudj79s/+1byPHJMY78Ok7f3QGRXejFyi363vkEBo6UeQfhW66RrUteJwMEiGrjLIXBQM/sKsT3r7eOPK6fRfT1vgdzkDAsjALMkIPW5Uyc0gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647821; c=relaxed/simple;
	bh=wcax+rPTONa1rVdTeDY6iWAtluCU18C9/qEjAMJyzso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zn4j4rCSYAeqaexCUclOu3HvjzVixEBjGjsneo5XejWl3ICYl+uEchCy8bfta6ifIXmT1IKc7jp2F4AJVSDx3F2Dq6egx7t5XPyP2i1zf5uWHOr1KZNiyxNLtUsTdd8q6WL5YjBqGjqS8qrPrdvHCWyiWB7bbXM4EP2pyILLswo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvkYDYOC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712647820; x=1744183820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wcax+rPTONa1rVdTeDY6iWAtluCU18C9/qEjAMJyzso=;
  b=EvkYDYOCRQs17YrUJ5BswGTgYkmEK++mWa8VIGH9UFj99zEn701h1CnZ
   6gLmX0XtdlN40KJJ7wjEUtpzlkQR6hfT9Ss0x1wKBVmE6Y24QJBID3G6O
   HbSxGZmHY1HEerS6ya7ttWNn00lzB9yGRj/lZsk2/lKB9/UHOK/htCK7q
   0o7o3HumTs6F0uJ6NLRAMZv7woCLNU3HpQs0iXSYa8Vqe11CDn1/VS39y
   WnUTFfB26bKPBgfiukJr6DDPdgOowhmzQerhHX0/cwko6rXDFkpP3uczj
   f8uX/doKxGIL0GVhSxZKuz2MAeggXp7rXxdz305KcwDSOO9qghdZW/HQr
   A==;
X-CSE-ConnectionGUID: 9D5TuE37QkqUyFnMSvDE2Q==
X-CSE-MsgGUID: 9/KGUHuaRZ6+oGSvEgwA+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11728884"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11728884"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:30:19 -0700
X-CSE-ConnectionGUID: Hx6u4VGqQbeeN2FAU6fu1A==
X-CSE-MsgGUID: kNrGpyC4RR27jGOUUwZzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20591847"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 00:30:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 00:30:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 00:30:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 00:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6HuMVHChmuh11vv7ohe/UjuNBuNPT3cSc0tAwffaUxB/W3zNDDRGHhNRV5DOSosUINWqrJ7J+BKfwts+HhbHSePno1aDC6SOAZfJ46VmDtXlUm5ui3JnT23vd6u3htS3CKKR1qOxMaNLbN4nrOhB6JAZdZlqA8RS57UVgntculuprGwYU++spi515unitBMt5ES4fJamHbMIAs9E0JcrP7q+EDInYipImMc/ckJpNZEXVA3wrRmusmfHKyQV0VjakXjTLowEqAYIcYo0cILGv97YKltr4F2DQ1Svuo72tXRvQilnBmX31gB864gt1KUvFlwe9PRXL+THmmgCCDeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVGgrLW4bBT8kvBVnofthqFPkw4OYnD7Id/GaxBzS0Q=;
 b=PdWx/ERUt21gaijO+EozJX3Hiv086Tl7VdPF1FMTzm/5CeRM1EkRWXC9pHG0MATAQNw4TbS7TZU60/Ht0MrvZAk5+RySmqZkOxqbLlf7GrQFyZabhcXEof953k1Syyv7/10oApR80Vf80edO8xojfyFiY76AUlb9+6hYsv0GBZMIAYoCuPW0idG1AF1vMvkpGYza4h5km6OCp+mkx5pUGk24L9q5hcCwkCCYSKK2diDMwDe617ADNTX03Ug0nOQ89KiiF1EjGQLMHTD+e8DBFQ3Z5xcXGa2iA/Dn0W88qSwMMuseLmHvY3AESJXf1NEGyYmNynOLg9AwGL6gc3JdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 07:30:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 07:30:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Topic: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Index: AQHaiPoC7RpD2axGS0qZEPwCpJ1HeLFfi1CA
Date: Tue, 9 Apr 2024 07:30:16 +0000
Message-ID: <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240407144232.190355-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6409:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1oVj7X5Ue/3ug1f2ILf3o7Fm6SNf/vTPYGZie9g0l4Nq3iO6EuuUQVi9uN08HfjyOqu6LMsvcDSst6lRx59b4yWHFwWpqYSS1Ui+o75oJTYWrUlZqbeuYXC0dIZpt8lYb4bE8iJpYnhcEg0uO6WU/3QDF0oHXqZD0MJxyRB0nTK/g2628OMTPiU7FUpIx8HIpIfC2w+2DDepqikGbKuvebtiCwGaCt0DCLwdfeH3c6uWkO3ME2j7gas/HW1XmcXCiCyJxSM3pysUbuDCvnUdNrMG8EB46Ak/xmGUx0f6HKkFSkVPKbCgHJugI2iElbb8HvJj1fu8GAb7D4qHo3yotKbNAyplegxMNWxxQpdl+ABfk/jSpjj0tMfigaVnaIC+CbKs7dAy/UMNFzX/xz1m9QNL58oCjTxnIzYun4BvhLE9oaDKxwF8smYeEEwhOygIgpUcrIMx9gs+zOyDiMdZbPKks9C5xvPspfJLzoIxz5TedefXoBp+P9ElFhj4UtJ6Ca6Lv4Iqi+52vroOx48eorIiObKCkqzl9bl8ZY/K6Z2ZPHTmUOs5l8Ry43fbpDMwjxJeDlYiE0EeBk7OzzEmyqtAw6QtM2MpFNCNmBZr4Ao1HL9Ox6HSsz0aMZS2Q3Wo1YtxU0UDomiTaEo/6PfMvv2UGlpySmCdCrHKu3zm+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nsDSNzD4tlXJLAS6uUd6suuWvLlmJrRMGsrUAOlIHoChLv6duzFi8ALroA9m?=
 =?us-ascii?Q?ljKP175eFtXAcEE0va7zZZLJ5qBmw+dSP+FfNx+UTWF+vcmx0zgBPQfULcU1?=
 =?us-ascii?Q?s8fPQzuht80S9OlQtW9lhXXx0euIQXO1RUToVipEp7nNWZGFeqSzxVsFLIDz?=
 =?us-ascii?Q?hJz0x45kS8Ko19m7QntgIDgIdWskmlYoN2uldrDOhixvxnWqKV49o/hxRWNs?=
 =?us-ascii?Q?0h6FOpnawhkUB63KHwrdDmXl0/3WVGWgw4TjrOwLejD3IQIva6duBeJlOh/q?=
 =?us-ascii?Q?qIbEcKZHQcQZdxwiXrlPnQhPlYJIK2gOvEq/Vc7JbzwkFUJ9bMf+V8RecN1T?=
 =?us-ascii?Q?0sSaNGmAZQjVSVwiuZ5OXMmGdmDK4Y+dfRHGn7H767v2EP1D1JyGUibfV5Nx?=
 =?us-ascii?Q?My+t3DCPP1ijBG8o7GNn8HABkQFTB3Hdzle66RpMm6kq5MqYBVBDPWY3/uzQ?=
 =?us-ascii?Q?TxD4CRZqzrj2Br/LAQJCdVvkg2qRZc8BNCCOKBy/46/BSysfW0wXu4c7aeJv?=
 =?us-ascii?Q?jPtS8xUzN9+PXMBdBTI8uggIC4xmumrrGistPSyFDnmnBRl0F+4UXk+HKnsA?=
 =?us-ascii?Q?tawYkhxnMy4W0oYTuxXtZ7rBrU08lwYeFyWxxd/UNEJP7nnsWM6q0nbUqghA?=
 =?us-ascii?Q?RHaqoqsiPvRMdaXIzINIu0Hiq56QphxD4+dZzN2WWLKXIFgBd6j5tnLAew7X?=
 =?us-ascii?Q?QXElBD7HyzsaGO3wUFWLHM43DDIXr3Z7D2hftGQoUe3IP+CsSIIZHmAfGXnR?=
 =?us-ascii?Q?AZJrSx+Na/YdQHwxggFUnJFBnBdu6/QXhN3bx+UPODPIcCf5w+D3/IL6/uU7?=
 =?us-ascii?Q?t5UaUKbZ+oGayKNvLazxcET/gipsBwJhKjvnkgEWIPRo3P9NEIYAgu7sv/NS?=
 =?us-ascii?Q?z+/0qhyLTTuPyYmu4UCMms8S4/ipib3wbqYfOn74hZ5bQ824XiSpbdqQok/y?=
 =?us-ascii?Q?cB68r4ow74nrewCQYEZoBWBPMQ/oW1jgTPrv0f1kKxoyeD4mfj32SqmZMMoV?=
 =?us-ascii?Q?UeXpi5sXDMRM/CiNfn/hi277SkzJbdlydBg7kCLYBpEOa+8J1KQDXwJwVhUW?=
 =?us-ascii?Q?j+U1viMwdN0oSbFxmaUFvoUcfac6i9iXmRPXKtI6KvhRtuwfO+q8o1N2zbrO?=
 =?us-ascii?Q?H3OkDE4PciO6XbVBk8Vb+NLJkcLI/FSGX6gc5HdoMhlLyqlbb7HiqR8YP30D?=
 =?us-ascii?Q?YjuIcj6M8y/N4B2Ypo4WklFf9FPcpArsapQHUu/bEaGYfrxrtmETnEx9/4YP?=
 =?us-ascii?Q?sAbhIsYjDM+yxnPNyielWo7eWY3T0bqsf+7moMa3/stxicOt10Ke4TVP/yuM?=
 =?us-ascii?Q?fMjiwIbDN1sKzAinQq8G4q9/+HPubk+82YecWRRvLKrj9F/6QofRbeU2sBmO?=
 =?us-ascii?Q?lqsh6wCcm6aWezG6RwMyXbutl+ZfImWDDaRIUpZnNBrulJCiK+LqgPKqumlh?=
 =?us-ascii?Q?Ebl7er4gLXvbQUdl5/O+Sm0cAykpA5orWagcZp0Za5PEPz7P2dHu0sKMlCFa?=
 =?us-ascii?Q?ODKM6JQ3J+ZnbIBGiRr6EwGDaJeVWrCAajIYRig1n7uc0RdsfHSUjJgJA8r6?=
 =?us-ascii?Q?i8jtEZCo4iRElFikXdGcdhyqCiYjv7uWA2fwSXMt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1c7746-bd5d-4268-a553-08dc5866e6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 07:30:16.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p1Dlvettp7FSpGMpC+FkgQXrQo01vjL+NCdsrwbw8is4/vSlKMd8sXf4heWbBoz/Vk74jRgiLGMTcqh1t11PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 7, 2024 10:43 PM
>=20
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> unrelated to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
>=20
> Before the scalable mode is introduced, caching mode is treated as
> an indication that the driver is running in a VM guest. This is just
> a software contract as shadow page table is the only way to implement
> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
> the scalable mode is introduced, this doesn't stand for anymore, as
> caching mode is not relevant for the first-stage translation. A virtual
> IOMMU implementation is free to support first-stage translation only
> with caching mode cleared.

I didn't get the connection to the scalable mode.

if required we can still use caching mode to imply running as a guest.
Just need to make sure its implementation conforming to the VT-d spec.

>=20
> Remove the caching mode check before device TLB invalidation to ensure
> compatibility with the scalable mode use cases.
>=20
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
> default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 493b6a600394..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  	else
>  		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>=20
> -	if (!cap_caching_mode(iommu->cap) && !map)
> +	if (!map)
>  		iommu_flush_dev_iotlb(domain, addr, mask);

as commented earlier better squash this in patch1.

>  }
>=20
> @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct
> iommu_domain *domain)
>  			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>  						 DMA_TLB_DSI_FLUSH);
>=20
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0,
> MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0,
> MAX_AGAW_PFN_WIDTH);
>  	}
>=20

I'm hesitating to agree with this change. Strictly speaking it's correct.
but w/o supporting batch invalidation this implies performance drop
on viommu due to more VM-exits and there may incur user complaints
when their VMs upgrade to a newer kernel version.

So it'd be better to keep this behavior and fix it together with batch
invalidation support. Anyway none of the viommu implementations
today (either shadow or nested translation) relies on the correct
devtlb behavior from the guest otherwise it's already broken.

