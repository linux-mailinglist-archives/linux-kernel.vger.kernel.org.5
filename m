Return-Path: <linux-kernel+bounces-137969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2901F89EA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF91B22E32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114651CAA9;
	Wed, 10 Apr 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr3gs9oF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FD262A8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729670; cv=fail; b=OyL25Va6Okwy/i2Rx4f3DOD2JHFYgaKvzvlUwt0SLXgq1bgFNyoIUnVJGIoosSSmspknhArDm+51ReiZHcf9f8uLXOdHwXhqcPK0WWqZk0jksxMoKGNMw1/CxDNdroR6W5mWJNT2FHYXK245RUjWm1xle7bsj4jGm0cMc4wHIaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729670; c=relaxed/simple;
	bh=ylf0jGuQiBGYozc7WCwqqJQQmawqtytKZqTLFdI/MUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZ0X9dbxDTmRX2uBEGFSDjAJTByoOSYW1EC6/L1uuJkadFXAYjc1fWneCzfIl2O/X6WBxb44IQZlhbMhmJmv78SvqZnkGGZrBIZEx4neUWu8DnDffxUzf6XP22lTtCf/gNIMzdAsu9S+GZIE30cIJveDNyVKtBUJXdX7koTyB60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr3gs9oF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729668; x=1744265668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ylf0jGuQiBGYozc7WCwqqJQQmawqtytKZqTLFdI/MUo=;
  b=Pr3gs9oFFafsep4qHibjJzaJIZSUUZfbwxSkmlI0Cl9tkVUv13CaQePd
   dm3o2DF3oXTpmikR8mhY/cj0JoUEM4z9PE97hUYpsNzfxUvkDYK9oP9zi
   Vty+LmSHAJA/nepfVdRJQLZKSfOhHUgwDSIef6Spl/zTgco+5VxR/9YyI
   wzvm6OEsxE3hZ3+Pco71RQRarwdODPvJr8okAs/cD5Te2Tl1e8vIA6odP
   QnKlcMHMgaSVbiggeaN+i6A73FbtwsZpweJ78RptP97KVsvtGnrsEHlme
   fRXe+/OI5VKIEkcBfWXfN/DhaGb9keU+IsuZP9vPtCwbXzcX/12TxSCgT
   g==;
X-CSE-ConnectionGUID: V+MCRUkLS5uncve0Jtlp+g==
X-CSE-MsgGUID: M9tS4/J4Ri66cP2XZXHJNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11914225"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11914225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:14:27 -0700
X-CSE-ConnectionGUID: IwTZ4HwiRgGtBqK8zSW7yg==
X-CSE-MsgGUID: ktH6cI4/QSaGmOs5+/6xPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20518995"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 23:14:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:14:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:14:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 23:14:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 23:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpUeEdSIPWUPNEgjZKjm3UA34oyOO/vH8HggeEBuXzWDiuDBH9RZLl+IOd59nICO/shKLBAywnXjhdo4WSgnzT5CcuEb/mNZe76RVEau7PeDUDT1t6Blgi+dkvQ+KGbm2T+9CxyLWs+FWjByXE045LQnXUA02jHvGiGA/1q2LOr/xpfUBLKWaimhQRKEThAcIf8th8Re7VTWnETgk8/5QuTx/bmLqQ8q//BH/PtnOfiiaSshsREy5hiOS7tt3ONoP7lUCA2DVw4cPsQ4FxCLOQXmxooYT2Evk3E+YZJKbug0DcUFJVU+YCAeiTJIYbafIE2LWSHhI/6ZZF+OObXc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylf0jGuQiBGYozc7WCwqqJQQmawqtytKZqTLFdI/MUo=;
 b=f/1Yry+mNWpa835YlU1XDmygsQkooG7Qrt3lE+CeWhjrZxvlLnf9rXZmJ9u7ZZyAWxH1C3uoYhP1EXfyfrZ+qGVP6DBrC4lbd7KEuOxqOuRvP9kfiuIcBRM5fpNKxmnzaboO1ptYShL6YILT3epQv0AP6XwDB93nPFhGqeivCgNPAihQGB19nuF4H2Q2T9arvG1RVrjnSdpwuVC4kgiQlxtsbyA1YjUz3UZ5HG8TqW+kONoSUAlL4Hmx5rsNWt/PgSuxIHVnfC8kLDi3MKYvBp7GR6ct+7cY3L+kZM596+sEGFOn3VeM68Vb6fKkHW53pLQtM5n02B+L027rvNm9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 06:14:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 06:14:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Thread-Index: AQHaiwxKiFy5v0dRUUSJTg1YiSPoIrFhBm0A
Date: Wed, 10 Apr 2024 06:14:24 +0000
Message-ID: <BN9PR11MB5276AEA3AA7ED2D945745D388C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240410055823.264501-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5087:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxA2p8LtX065u+wD3uHUJAg8YKBsmqAvqI4dqLTr3o2T5UkSs2pm7qmkHqQznLN5My4ucewwu+EEOcDek2H/Jccgn7Zk5IIcafcT4Va0vd3EvFBPTPf/1lQ7mtD0yc0cRvH847i4nKXb9GI5FzM4co/PqAb8nBXUbv+Et9te3w0eQVUxnxBQkTWoArQ59wVaeIgtb5U/rxMb+3SlWh6ctRza3I0IHgEXVq+vI89mUBunFGhFDiRHHA2gcpO+JyUwNQHn8xO1XUxmi41HMHTKw9iuIhaEH/iIyY8S8DDhPZ7itlwYu3K0Kd/znaXyXwa8mgNinSSRHxN3ri87ownSercV5fMlOhr++HqlLf7TfqKhuMNBiYLUdzijpuHBvGdatNEE9uWTfdKYyTmuKFG+v4ODGUVHCbql01Wbj+36qdArZDojq33IXDLN7I9SNFErAq/LT4prl56Pq7kR8l80tQcQq+t+E3t2uOSa2lDvyYlghMKyL/WIkEvmR2hNkeF41QcCY9q+6PK42UyZ+F9ah7REi9SD3SnHzmQ6XT9igjinBR9k2C8FrZAnkcnkwvL/8kUOTqYbGMER3++428f2OPyO5Ggw0ZxjBomGn5zyHTl0MmMGtOiHn2tsXNxvNmrkVWMBY2TQKgC33LL+GDcI6HKw6GtcOnHqeLRPqzo45ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wUO5SHaUvvhw/+N1PqLdagZZEO8SSpkdp7ktdR4FybemwTQbOLpMOhpQHpK+?=
 =?us-ascii?Q?1Ybgq5gmNKpuaynxZVeL6ZEk0as9Kc2wVcEp4UQeVJo2Ur3MD6Y0dyb5w7bI?=
 =?us-ascii?Q?YQNOXHjR9qLhO26vom2w+Y9GMvBu8rrcg500C06ZIKcIaj3+My/rc+2egIy5?=
 =?us-ascii?Q?uabk0RR//WsMq7yNhUQZV7epQfqYd2V9+sHTcAlaftpGUrJuU4L1YNj2lUlx?=
 =?us-ascii?Q?DIBbr5W9eHZ27AGZhFfcn0QvJLQsPOU6kGwaq8ahKFImU+T+YbzkEjwpYbb2?=
 =?us-ascii?Q?KLUgn8c60ZiqRpisHefiyt3pnfNJ95vY76sgqXmdRJvYU4qy0kGB2juw8eJH?=
 =?us-ascii?Q?YOiB3YBXludYfKDYujyKhfrGti/q8nBbmx/4BToSVOACE2V0Gr/Z1Q3wmWZf?=
 =?us-ascii?Q?I3dr4nO+im+BNAiEbT5e7X8biX3aRSF1cGbno8CZO/LZT3CdTHTj3ABB8eHD?=
 =?us-ascii?Q?zzNL+i4Xs4E5a0LpGu5fvEkc+HQvN9AEEeJI+iQZKV/uJp2J53v05avLQLo5?=
 =?us-ascii?Q?2NZzlH9hHZxVOxEKfwqQtbjI0FE1NV73LNpBTX50yAYhIpVceKQ6gJIYsG01?=
 =?us-ascii?Q?FWQx1ZInHLN30pT7jh8B4I+vY9fDboCNiCgg+ooKvn3xKq1JfKVEyCYC+uD4?=
 =?us-ascii?Q?oIK7M/pqTpXJtmn9VJtdNaMeCYEjL5UEkSry/btbmPGWair8anCp/mTFlnFe?=
 =?us-ascii?Q?i1kMm+TjVSiV7AV9OQ0woSgI8W9tn4QeSAHIoK289SreqYhSkrGOjaEkHpHf?=
 =?us-ascii?Q?YlZBjd7iEoV+OXDIjr1f+b1xXzNnRZA617m1fkIIOr3jdNRLtL31DKuZfG24?=
 =?us-ascii?Q?zq6tG6TYpl0pkPeJ0ctXF/cBesVX5hUt8eJy8zzRzEzodpYDzQZ/onVMjbII?=
 =?us-ascii?Q?K8VlBOdsHdxLZi9U3rXU3lmXCGRTwNm9wGpPkiKTmdGL6V71pX2laNesr37p?=
 =?us-ascii?Q?z8yBZpW+LE6A1R+rEqMMvU84migUjHmT24uGGOchfY4DyKpROGL3nxym5oT/?=
 =?us-ascii?Q?XSTgWBdp7cldKKqranOIzHOQHRyfmgRvL9YcNlrsaYboQasQowWJpQ4tauja?=
 =?us-ascii?Q?FVw1bDKQ8UQ67OWZskisBNpoLi54lAxxtbifd5ECQ8pJj9btLLH34euE1NhD?=
 =?us-ascii?Q?4dUjoyF8dnz9hejE2OnLJk5psvrV9KQD9d8vig7b6Xs3bC4v338A5aJC4K8f?=
 =?us-ascii?Q?4/SC6SnzE2sBDnUwzEVcDqgQEhKJ8+oeu5MTUcxsgW8TIa6/jlGCIOA/uC33?=
 =?us-ascii?Q?BuzAAKG+CGazgGRtdcBmnbj5tN9l98E9j12rKnbZi5DBaQ4pJzBlBA8kaqjp?=
 =?us-ascii?Q?xaBoXNuGPcMb6oWQU3OkQ7fKUmkYWkE7V18uAKGow6C3UVjjeKFxdTO7ivuK?=
 =?us-ascii?Q?/cV0xchICTKpvxbCpRtLilVdBviy1n73ukJ+0cczRMLezNUCKfMBNw7eluqQ?=
 =?us-ascii?Q?0p4dCZgGDUiyelZHK3pXgCoYiX+/Vtmz6nwnjwyzCx5Nulx67vP1N/q8tiJJ?=
 =?us-ascii?Q?EvKb9oQfA5AQJ//+5RrymHARr3wFDWvN2EU0oSYsd2dwHXcya6LKIxUnyeNy?=
 =?us-ascii?Q?Czh40TPPLxDWrQubUAVtHdMWhWCG9YZI2HGda6PN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a6fc38-3576-4eae-8953-08dc592577f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:14:24.0788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQYyh9UVcI+aht65hS2L6QFTEiezlrEOA/HjOoyhJtVsII48svQNVXddxOtlnBAFuUKq0PA5NktzCguLTFaxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 10, 2024 1:58 PM
>=20
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> irrelevant to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
>=20
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in caching mode.
> This is wrong and causes unnecessary performance overhead.
>=20
> The removal of caching mode check in intel_flush_iotlb_all() doesn't
> impact anything no matter the IOMMU is working in caching mode or not.
> Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
> caching-mode is on") has already disabled flush-queue for caching mode,
> hence caching mode will never call intel_flush_iotlb_all().
>=20
> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for
> domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

