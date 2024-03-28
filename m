Return-Path: <linux-kernel+bounces-122550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317C88F94D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99503B24BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40853E06;
	Thu, 28 Mar 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDSTTl0v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87F4F8BB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612782; cv=fail; b=nuL0rHf9HpNkF0v4SCPeMp4ILFEUs+n4AoHNSBe2/sKnwq/LfYFFaQomCi7Pd+CmipkKo76KXFMBG9DS8FJWg7wo7BIwOMpcv0xJmkuK73t5Tw2TQl0U2mvAGJFzfPYF1ozP4EqZNTDfiRzXAi63EjIRD9dFTVppcpo1IvbcjSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612782; c=relaxed/simple;
	bh=jHBy+GE/xmvFSWWS01FbmNUaN4OvdDuXLKsN8j6atD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaX7QNCYukh+koWZCQJkqtPMO5G7uysmvzcv6doRTsO0iBU8Vmo5K62bjCYYYp62/Fa5SOi5vWAzjxmUNcvLKMLSvUTAKaalYeJoESalE9KUZ13SB+KMtm7IOtNnn+hAqhB/38O5pxfagxTxsnfY7tOhi8OSzAywtlS8blApNl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDSTTl0v; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711612781; x=1743148781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jHBy+GE/xmvFSWWS01FbmNUaN4OvdDuXLKsN8j6atD8=;
  b=bDSTTl0vAECC2FZb+PKu/s1S2csFNNVNSYhC//GVNj29EzqNWocTp5ad
   nDEfADBjdaMhcOcgR5auWM9RVMcDyfWi0341p2iPj5rgmrjpzWe806PJ8
   kSNDesHrx3PsNpw95zZqYk82+UNShHUIkrQPMsyVkjk+T5yRhJkUMz7D0
   b6JgvdcMJZvJrQ/N7wuiCdF+4KjmlaSXjfS2O2Ktf5GdHHCa7Gcyga0Yd
   5CwyTVMh5u3t1Gqaiap2BZwtfX7ELfQBJ/RoagpmHri9l8NzoPTMtwGtS
   4sESG+NDoXWouQKeZMmdoXnR+1H4Y2xh4GwcnNKFua5ydvIuKtulxfEKw
   Q==;
X-CSE-ConnectionGUID: rLYmA6QyQXOTUD0yWOLQDA==
X-CSE-MsgGUID: +rz5ja+gSAal7PtY1hiUKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17303203"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17303203"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21283800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:59:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:59:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:59:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElKm03THVFf/YUo3Bxp6LaQEdkK9fgqJYZGYee4OjShyM0tp8TsUFAnHEjV8X8RKghP+boRpix3jbMeRIHnGUDSpRezAQWSgB4T6Okr8du0eU4hQo0D2sRnzu8i/uRXQM939mFtq6uJCpJDlbryThKLz+RBRI9E9gjpmsXLrnQsEFXsPkD1kmecA4Wi/vyqTlAFiwkzn33VOQiyZIqsRbA5ghofTFk6LYuXvqAJGBqUqg0070D7mPHfTOcvlzwa2SqROWE+l/mIGdeg/qDfPCYXVC36JbB2S7aY7F3s54LiKO5Mm15Kuq5EPRi+8PVPmSIHMMZSlhKOBG/KrXip7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trP0ICJ2bhE2EJ4CZHga05jnk6rDIP5hUBU2cYh0pBU=;
 b=fKBkr5woLdQIJL9sYMNKnuRDiJrmtXeaoH3GS9YvOVYB+TycdAIinJur1vb97TsEqSxmZkPpfN2pPjsTOoDbYAhiWlZ41sp3RtlFqrs76x4ANSn/HqgMTgNsDrSzQg1/hXmyTkMpgMJp8NmmZeqWwQW9BXXGQPbvEjScPq3isx1nk/vR8OEi8VIdyA9JHj9hu4smS2Solw9AKPg5X7olPXQPcwA7GQRtuaZtjy3oLZiXxnlXP8PBLJeZPFZCAflpjZ9X7zOAzDVkKb8KTKrCapWxTxkDA0m2guofLpRf+ZByS1EAlJR8RpDS2uGge7uQPOIQEtmvKXuDUD4qMadscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 07:59:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:59:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/12] Consolidate domain cache invalidation
Thread-Topic: [PATCH 00/12] Consolidate domain cache invalidation
Thread-Index: AQHaflqt4JqYpqo6n0++IRRqba3zUrFMzouA
Date: Thu, 28 Mar 2024 07:59:37 +0000
Message-ID: <BN9PR11MB5276088E9D595A903E9255E48C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: 641e2356-1b88-4fd6-cfd6-08dc4efd03cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFaks9Llgq45eAsROxzGZYX8afnSsudm1hs7PLZqJm70WLaxw+ajL/n1nsnXptHx4Xkacdxu44DK6GAv65V8KRsd9N+HdYfajofCvSOnj0yFfC1nf5pH6yenDocPwlnzD++DLztqB719a+0yKuBzepKtEhkagqtd/DJfN2KLTJFmnxuhjm+UTeHFsZ7Wy4E4UMQYWqE8M5BQlvuwCGE24srpqhTxqFkofcj220Sr+zct5tjeu6kVUG2nR0UCNGJQsJJLWHRXl3KX35r0BCM0NaRI4UZcA7H4LAVq5O61pH2YeN2jgNYLNft/MxSWYZIVFFfq8nxXbQS4MKLVW2mdcKOKAgNKy4ubpyYD/E3gx7JYMK7byKczcMp1GZa0cSRPKyMDYouS8MEUcKmpF0fZvnj7I3lx4f8UNlMHb7X99hlCrmlS23eicXIRQA3oQn8mBXrXPoYMwmfnFr7b9tAwRWgWWWl0pMENRIZd68YaxVY1DontCNeuu+Pd/ILVZBFxKKXQQauLyLlyuHiBvB5KF1Ua8Se/TvS0ojBrXwfyClZDYs8aldXmsMh9koPhGso6r2zJfEm65sPOqqvnvr4mvx9SE+PITbhoOB5iI3SOmvXN4BkCVXX1aaCJfig7w7YDnj8eWEOsFYKou6YROWVBqA6M50HwhHn3vdH3yxDVeYtm+qUU2boT4r2dMVlzIxPwIy5XkQBd1UTYEY61GqDiG83VwCZecnFrJtLqTKjlRZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FyaDUTmkhlht0bTKMaJux1X/1SsC8T9iskV1aq+iXwUgWPOYXD3uyXXfIyhI?=
 =?us-ascii?Q?+zzg4h6l+pHQGIDP0Uv3wEShG0Qd3kP3XPR6Uk/NekbZkeRnhEroQ1N1CWwq?=
 =?us-ascii?Q?4bFrvnTsGVW6/zy2Mlhz+ocQaENHtX638Yyt6wCkArJIRQG30kyF+DiVovjr?=
 =?us-ascii?Q?SWZm5MDVtXThd45slMT52ZsHX3Dyk+rRBqcgNniTu2ZaSomAC3moPLG1M0fj?=
 =?us-ascii?Q?HM3R0TNkmo/gJeJ5rwXLCKm43kbp6VFG9NfM5mOSXZKkn3BlYneBtKiD4943?=
 =?us-ascii?Q?kisOxvEa/9m+nhEL3mjD5N4oE4+TsvfEmkHuOx9XL0jSUeAEh0+3PQJBcI6N?=
 =?us-ascii?Q?b0VifYht6/T97cWUjZT999wdNWeoVsh18hTM34cUn/7ig56dkbZ48TfciHIv?=
 =?us-ascii?Q?qcFXI81Hha8hoogXA8nm63/JHNgX0FLllhV98MQfhuNvO11uNdk9q/E53vTL?=
 =?us-ascii?Q?UB8fjVxtF1ksRvwXg6Fo9VNyQMjkUN3HISBJjasCctByp3nFGtUs/t8Exv2n?=
 =?us-ascii?Q?wwoFlldlgjyyggu6OvKjeYyS9O1dMjkKBGxQFsZWleY2M8Y+Gv4C3MjupkEl?=
 =?us-ascii?Q?yhzmQO5rPUn91enTzZjb4G9h1KXwENnUHX+xjZPyEuzHjF9zM46qG1NBX6VE?=
 =?us-ascii?Q?EB08to07lp8hPPFpDbl8VKVwfHo2ZB2TxZ8v23TsvQxMrTy+Ufvd8shLKMUL?=
 =?us-ascii?Q?JvX9K6kx5YDA56r503jF5PMKx6Aj1Vow292xkAjwd18aNGxIbiqAeccU3qMm?=
 =?us-ascii?Q?EWyLfIkob4aNdcqi9BiSXNnRYA9c9H/1RKppIgvgJckzaHSmRCzrWAU6FWj7?=
 =?us-ascii?Q?jSV6hs5M2mATd+RHccHvyrjG/VKCjQ0YrnfOZpRkgmtu0y3SJt2veqireOFp?=
 =?us-ascii?Q?d1TIz2reuV9xZRhZgfdk9YA9scV9POnUkZzHRlh7OqpCEgOh8S1RPnx5eCwz?=
 =?us-ascii?Q?u69poerwhwRLiyxnbudbaoN/7TWtSfGroJNO11WEtQ+1ItFiXv5AXk1G5sya?=
 =?us-ascii?Q?SBtJPg5GozuBY88LBfQIbNAkb6stpPbHiPho0EbSbjXvEwd28okUB74pExRp?=
 =?us-ascii?Q?MGJS870Rw1Nw3tuIJK2iEnDdlu//GNhHnW8w8BTJ/HBe+bbq24cNvwDxp0q+?=
 =?us-ascii?Q?8/KW81H00BTCEKnSqzBt0Y4UQwmeusaOMjeVmCk+FWYSpOzGG3Eac65t4+aB?=
 =?us-ascii?Q?ppslno6L5KG8D1HnycGrWk4ZAoP3H4lb1WIAcFqA+HFmyfGQPhqbUmttfeT2?=
 =?us-ascii?Q?HLi0C9sASBxK93q+rTmPTgoDwbtExiqg2UK3IYryIgZaZNm7/wyUzld9PM06?=
 =?us-ascii?Q?ouWNARme3Qp0z0F4/YNl0EJx7tzypyfF5V+iBYqKYZjFigxh0AB+8XajCDkk?=
 =?us-ascii?Q?JdPjXMckar+pPzHxOQIfIgkI9RXY8J2c7b8AZBIpcdu7iIAEF3+wPqiuQZCQ?=
 =?us-ascii?Q?AYyUhBg+sP2xfxNhiQZeWkxbW6ryxiBmZWj/zDx7yO0irSOGDP1BqWAvh0Nf?=
 =?us-ascii?Q?jyHbK1NN9TcHCrvZ7abxpeYTZ+DJC7/OAbN60qNIbO19sn6WOPpUZNKcszxv?=
 =?us-ascii?Q?6alSJZfKVXe6jlb6B4ZJbydQmaIF2Pqz++2ttpG/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e2356-1b88-4fd6-cfd6-08dc4efd03cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:59:37.7123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKAX9braftYcEwivcBDpha445fRoTRgQlmpUuhVbbU7s5Gd5kAbsBl+dE6T3a1jCZPj5cVNpELRil0Htb9EAWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> The IOMMU hardware cache needs to be invalidated whenever the
> mappings
> in the domain are changed. Currently, domain cache invalidation is
> scattered across different places, causing several issues:
>=20
> - IOMMU IOTLB Invalidation: This is done by iterating through the domain
>   IDs of each domain using the following code:
>=20
>         xa_for_each(&dmar_domain->iommu_array, i, info)
>                 iommu_flush_iotlb_psi(info->iommu, dmar_domain,
>                                       start_pfn, nrpages,
>                                       list_empty(&gather->freelist), 0);
>=20
>   This code could theoretically cause a use-after-free problem because
>   there's no lock to protect the "info" pointer within the loop.
>=20
> - Inconsistent Invalidation Methods: Different domain types implement
>   their own cache invalidation methods, making the code difficult to
>   maintain. For example, the DMA domain, SVA domain, and nested domain
>   have similar cache invalidation code scattered across different files.
>=20
> - SVA Domain Inconsistency: The SVA domain implementation uses a
>   completely different data structure to track attached devices compared
>   to other domains. This creates unnecessary differences and, even
>   worse, leads to duplicate IOTLB invalidation when an SVA domain is
>   attached to devices belonging to different IOMMU domains.

can you elaborate how duplicated invalidations are caused?

>=20
> - Nested Domain Dependency: The special overlap between a nested domain
>   and its parent domain requires a dedicated parent_domain_flush()
>   helper function to be called everywhere the parent domain's mapping
>   changes.
>=20
> - Limited Debugging Support: There are currently no debugging aids
>   available for domain cache invalidation.
>=20
> By consolidating domain cache invalidation into a common location, we
> can address the issues mentioned above and improve the code's
> maintainability and debuggability.
>=20

overall this is a nice work!

