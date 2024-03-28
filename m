Return-Path: <linux-kernel+bounces-122528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C629688F918
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CE61C29039
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FB51C34;
	Thu, 28 Mar 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCTSWRD7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47212E78
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612124; cv=fail; b=h66ISuHyDZ59/CuDX0Up67jz5dz88/p8beeujvp1xA2395w5GIhtv1Z2PbIpCLsVTyyjX6WNIue54mHmKziqDBIsgzAIo4NASHvUQJ4CFJyWvP+9NzG1qmDZhGO+0ypTetx7CQlxJsin2aAr1r75SO6DPzdy7E6HQS+Vn7coqjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612124; c=relaxed/simple;
	bh=ZXjiqLWOohwL6vnL7RL/M9YWWwR5Q0NbLlogLWoM/tU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXSqgmfi0PaQLe1MSGrfLYDu18JlCbtes4VYplpyAVt9PPKBLADghdlC3x+JzD9lNVJKMQIbg0xaDWY5o/e2ViElGLSgCrSu0qucJIoZdiLsto3rzlc0BeEVunV3MPvb7r58zuJhNp1QTGiJ/W5nTcQF7x8gyDqb8YmsxKbNi/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCTSWRD7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711612123; x=1743148123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXjiqLWOohwL6vnL7RL/M9YWWwR5Q0NbLlogLWoM/tU=;
  b=iCTSWRD7UwbLD74Zp3hyoigkeygMM+jIwa4M3oEwzOYxruT4iWw+cJ+P
   xYgmyjN41fpiiqHa5wxvSSiFvnF7u1VxhbxWyw8oolxbjv/dH44B7uE3e
   p/lsLJTXI+G1W83fnuBygpZ0eWyetjo9GwLR1XfCYr2dN9D+F2ghZICXV
   sYAZy4EH9PtyDvD60AEPd9X1QCjxSdBbeszDDDJIaK+PFfb6kMYJVY7WE
   YVvLhdCovsjrr3sAbZvRCfaLgMSu8POu3IZacwXbgQFRQewC50HnnCNql
   tfpqlYWOcA6zquaoH/IKK3km+2Xm2Rk37jUNH1Z3JiB9NmpX3QT0TitzD
   g==;
X-CSE-ConnectionGUID: zzWZ0muqQbaKbvPzMeNcdw==
X-CSE-MsgGUID: 5KbtOLP0TEGP9dpkhbyYXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17301630"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17301630"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21279992"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:48:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:48:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:48:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAHeyKh2en7QNu6f7+6Iym+T1GsBEcIbQFJnOWUUg9ztCnURG6ubUbXwTpWGBI0gpMuBouyhZHslhVWOt10y6M1SrkPrAU6iYEDhSpbK3Asx+AR7rhkRThxcIDidGAZXY7lASbPw6X6AGSscrR8503EAFYwoO+LHNTRaO0ZjAAmF7NccmUz3Jz6eQGbn/gPPuqtFyJrgTVeGty3r7RcYhNWBMX6Xe3UV6EZmVusXKLn9QFaOlT1HZKB0EJ5msXJYrldA0newxQrrrogbQZh/tPKxOwtcpbosz0fl6LOrwSokeuPxj9NYfozSikkPLvOHbaXz84X+dWj5yaGQoC2Few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ehSDFRrLcxUf762jTegJzUmbbjtLGURc8POAgNVnOU=;
 b=QVH84WjDHQrSg9W7cumq8MT1R5VLd25GtxmL9I27OIgWW9GERZVVCga/gpb0XdFsfTCPZ17tfVIBKF4GwOWF6TI7HiOrVPP8nNXizApllPFA74A+kS2Q+TGh7qCwQej5Xd5T98fJizzifaxx4Whw70/HzBisdx3PWZQ16g4aBrUDRMMOGncNQErh2sGRt0dYaitCeAx5fXm96Nj0QAUPrIjzP1XhbXjHB1FDCdOCZ3up980UkV6eqz3htw8TnJEmA2L0SnJKBhiDI3BiADezCiRPa2lAu69snCPZZUc5z1e7CdqOLcCForI70PaDKD6964sfe0UcTIxFuQ45kkLvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:48:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:48:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
Thread-Topic: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
Thread-Index: AQHaflq4yxLShVORlkmqLXclud+azLFMy8WQ
Date: Thu, 28 Mar 2024 07:48:39 +0000
Message-ID: <BN9PR11MB52766C4CA9A27F34419AEE258C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-7-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5054:EE_
x-ms-office365-filtering-correlation-id: 1b4b05ff-af88-4fa2-4745-08dc4efb7b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +k9FUKmK2/DbW60lo4PaaxtVpAzk2g+KgxoqbqB44X54VzIDAzn4gYGwjQRwHjS7vEi5tzwJ+10FKratRy7cb0QHT4awyHyF0wiXfwbmJWKOxrLTIh3gJKOeoCOBT9k0nMPCmVdRFOaLMI4Gd++W4GJ12O2MSZX74RsG7+f6UNNqrFxRzmNq7UDlwUQQwW+2ZuQz+7SDNDaH7EB+YaxUikpmo400xjTEFsy9aazFpNbbt/6XhYrqfUwVxketJOcB3HjYofj+m+iujaH0lqJffDpTdv4A/bM5lEqr1cizSJ37Ngw/a+LZBbJl25sImiOBfW0eAcpZxd5dWcO3cUXE7Uk5vN1VCJyCZG7RvsdfnmGVDO/cM+CLMrA4SzuENx3YPa6GuKnvo4uiP5RnGMfwfrNjozupvpH+e09FzLcVVisg+bNgGVpTrkkWdpFX3e3aPbvkyViu1X2N7intc4KOVEdVl9a0W91NrGQre2X6KoCMebbecBXTQhhZQfsM7i0C9PUls0yXReKjyRLqK+DQHKOlGh4vTxpQJFp77XOHtPRmNwDPVAGotp+SiflnX19ijb2lLyWWvr1n0kLAA5FR0KbnJVKTpVilPLZOg956Ntzc3BcOWNV/Vl86dmun4youz0f+9NSfKliRGMZ/haqBw4WF88HRnfojVtlt2U3fI3lL4LWrvoBgik1szIJNtUdUzOFaamMB5wdBuHc9QeP81sKsn30TXGp6eLiiwlIyxFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?22Yz3pLYvDrYNVa6Ok+ZzO1r4cwZ0Ux83CNltrjhHMtGXKSB9BKDa9Sl26AR?=
 =?us-ascii?Q?7nSZLMH6X8G66o8Vf23Lrcp/62tyBCPeDjz+j09Nwna9sdODl+LsPumgT50W?=
 =?us-ascii?Q?wGeyt8F8IItCpsAmtjywDYK0mmnqn6LAtPRwnuPmDFn+rKJKhuzvQRYar5uL?=
 =?us-ascii?Q?PP/ZvYVfhe+qVeG7+iTrQnf0eXXvrgnVbBxsfRRgCZWcGwuP7nfAAQzSH/L5?=
 =?us-ascii?Q?Zkr30qgUkslZmPS1EnaagqwHGd8G7PpNdKfeJjWamzB354ORluMAC0Vz/jbp?=
 =?us-ascii?Q?EJTkoCdGi0U27eRHLUuMBpWaYMmw4Re/OUJaWOdOql4EzjqhaOo7F5EyzI2k?=
 =?us-ascii?Q?pwyDGW6kUNgExRVkifZMWVKqnEixIwHWWHDicOD4CbuObAgd/k2zW1jA7mzD?=
 =?us-ascii?Q?Nlrwa4Ryr9Od72RWzrjx6CYOFrPhVhIBWA94qFNcGCESxT1swPa4c5EgXE94?=
 =?us-ascii?Q?KXBr5PSY0770xbskZUIewIH6NHqUvywIo8WaZ8QsqQCiieJIzczHuktMHGsz?=
 =?us-ascii?Q?PiRSR5PtSCTMOML1Zb7zg1LshyEo9kewcc0OgFwd2kkvFsJrvB5F89Xx9lVN?=
 =?us-ascii?Q?fzfcP+J0bOb9jor3QV8v54FZCSB/5hYWZszrHqEhY3cDSUAPhz1fiduStKtd?=
 =?us-ascii?Q?mcNRsZ9XtLQD2Edw80KXCSgrGbFxWSL2rogGX7mclmW9PMR/QR77NPisH3me?=
 =?us-ascii?Q?8XwiaHDnEYleYgQthXrx7jVkwl5MAForiSo0dXYdvYCVCTZFffIfK5ah0NQM?=
 =?us-ascii?Q?bJsYUrFYnpdOrKOAEKHh3ulWpkh1iW6rm/WyobeD9Rm9fSsLp5QvlAhZr2ZW?=
 =?us-ascii?Q?ilS6HM1eNeFA5KP0BSXCBjIcLl1kp+Fk2kf5G+iHgt+nu3n3F0TYWRcnMbdV?=
 =?us-ascii?Q?AqXNNGBrnP0fUGbKDZksgbrkXbPY3xH4H9zfylX/hmwawopssXweVr34o/uH?=
 =?us-ascii?Q?Bzw0SqbPpKcgOZxH1oiG591kOLl9mEKkYJJMs3L3o/dIvzZWDJdK5I690oOz?=
 =?us-ascii?Q?aThW1+W64fQZBgFJ1sCS4YyUJW8jZgu7pt+fh37bLlXaYr/q24UBjLxyhZkv?=
 =?us-ascii?Q?LdPPR/rIzC8X1CfJU/BM+Orsr/hGKlrNsLa+L1/iOwPHXuPuZjMSnhbaoa1C?=
 =?us-ascii?Q?8SThZf+6xVYJitsVmBcLR1/YewyOhkti7vsPLd39JZ7WhEcQOTNQBEMAMgs8?=
 =?us-ascii?Q?y5vh9A3aL0PJ2ZS6m5xPKm5+Mbi/8V4uZqjJsr5PV7O9j4Qo+tLsJJgSzAQc?=
 =?us-ascii?Q?EtYZtSDJwQpUCh94fvHLb633pW8LuBcPqvYZGYdAd1twgskh0BatyXnml+Hv?=
 =?us-ascii?Q?ABX35msHKD6uQR4PpvIAQEgLRl/XrXkMwHxfpI0OF05xU+ryo8n/VQLze0IL?=
 =?us-ascii?Q?gtznlIxxtwn1CJ2R99HI4dFvW27CSUqG8I9xOGP/QuEQDsnB9umMMu5apB4M?=
 =?us-ascii?Q?4ciD+zX4+YZbeB4XHRJFBvppu+PVbutYNojuMr5dV4cBSDzo9JFZEhZi85oc?=
 =?us-ascii?Q?Yj3d73XB66CszhCLJy1gKfqglwgdAjlmMlICsGOr/4xRF+tVUH2ie7poIFlR?=
 =?us-ascii?Q?vGjoOIUQQq8PvX4eQiSOBS464A7E6A1VBzSCHr+A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4b05ff-af88-4fa2-4745-08dc4efb7b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:48:39.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxXkMcMSJK2z3vkJH0cWZz305T1mHLvgV8Y2bX4GDVY8zmGQvBOv7ogEZqnnXPiz2DD2mM09dRG5UVmhvJilyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> The iotlb_sync_map callback is called by the iommu core after non-present
> to present mappings are created. The iommu driver uses this callback to
> invalidate caches if IOMMU is working in caching mode and second-only
> translation is used for the domain. Use cache_tag_flush_cm_range() in thi=
s
> callback.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1c03d2dafb9d..2dcab1e5cd4d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1504,20 +1504,6 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  		iommu_flush_dev_iotlb(domain, addr, mask);
>  }
>=20
> -/* Notification for newly created mappings */
> -static void __mapping_notify_one(struct intel_iommu *iommu, struct
> dmar_domain *domain,
> -				 unsigned long pfn, unsigned int pages)
> -{
> -	/*
> -	 * It's a non-present to present mapping. Only flush if caching mode
> -	 * and second level.
> -	 */
> -	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
> -		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
> -	else
> -		iommu_flush_write_buffer(iommu);
> -}

iommu_flush_write_buffer is for a quite different issue. it's clearer to
keep it separated from the iotlb helpers.

