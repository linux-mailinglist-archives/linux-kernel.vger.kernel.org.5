Return-Path: <linux-kernel+bounces-90142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE39986FAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E600281D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC914013;
	Mon,  4 Mar 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OORFuUJ1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32013FFB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537810; cv=fail; b=kktiiid+7OhhErK6GjbVEmx1+ZCgGluP81rf4ehnT4oZMin21KBGRJn5aUaEpi9oE4i/j644TptGmy+2avOPGYQSapTkqR4/502u9uRjncaGlJGr2Wz0RMef7OnGKtLk7FzWeQdcX6vmS61ttv2Z+dXb++elmM9sDKYeNeC3ZI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537810; c=relaxed/simple;
	bh=OBq5mh2fzVs3xao7eGZW0GSk3f2fzcuPiTzEe6TcLnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=diPTr1IsH1K3qYOzJ1BZyw7K3FxkPv1va5vdHtLX7sXClVd2pMHfvgSm12ygqK/0/RTvNmXdaMyr8uQEGInatK54ayu1hxAkAHb60eAyu1PO2sVbnKzmkriBAikmLYOfDQzgWsqIdayV2zIwrJSKQ0uSwZ6dJHZ861a1tTIF704=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OORFuUJ1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709537810; x=1741073810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OBq5mh2fzVs3xao7eGZW0GSk3f2fzcuPiTzEe6TcLnM=;
  b=OORFuUJ1U7/zozVhqLzFLzhHHmrVl0IJbg5uFauO6fhuRzGs/0x9fH2e
   4qFUEOZx2U4lRLejUBorDonAdB4+fVDsCs2xYzVTwqoZqJ/ea/kGTRaym
   REwvfniCL0HIQOBThlDF7fnPkX/aoyBiiu57yt7uetVQtp5jW5PWiChgb
   S4Uf1AHedl65WwSYZRF2ogxxQD8PW96iro7EkBOfaXcYIlzO0wftCoiUm
   jdL8tXpTFmiDFAfSF417sBbzk1FINzLOwsgyGNGpaurxCrZh0CgCJtX2a
   X83Gsn5EY1kZxf7UtTd2Lvez8QwN29zkgOrhgRo24NJnRorSmv1a5Igf5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4177989"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4177989"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="39899999"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 23:36:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 23:36:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 23:36:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 23:36:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 23:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwhIWqvNBCfsuH7I5A5o7SqDqHAmqNVBXci5D6vfqRoZN41LFTeEDYfsemyHbel0TCmQsCC1FgPESYcg98mip1GXx8TzWH2q/1vrhgXREhnLqmr0zOpdQ5l0QvcNVm/AHp67vVervsifLUcXzSaSVf6fT1VQg6o21tkmgPLUXM697BLN2yuWHuCQuzqQztMRgTxkHmFRpAYa8cBZ4hyAg7YZACLeIFNvY0A5igxo67HpjZxK4aufOHRBBbdOxbB4ll4zSU5HPvqvEziYGWBvOLOBvAsk33JMM6Fc16Xt+RbAk3begyDyFtwixcK2g72/AQuKeYfj/y6jQW9RDXhX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYYwIFFtBeUqrz7GrOkPlamTfX+I4yvEFG8Z66DtGTM=;
 b=f6nHhalw1ohyJ9eDuaQ1BLAmjqUX6pEI1t+5sHtinMyQkhwmbrnO7v308pyvpz+WCGEHkaZdfNAhrHgXUxtIYE+oRi9c35IrF5X0d/Zlpfz0jbzvmPnpuww23J+1R2BCEtpnBghXHfFlZY8sJcfU5BiR5p96B+9As1AUfHmDBVffKYpciXD+K9JabtO2LpInyfc6/CUSFW2m7L8IOYX3GVEiHK3K056/wF0mKLIBE704pR5n1uY4UIlNq8Gy0yWhsiVFUYq+mxy8NpFBBqv9pPWMmJg0aibyUH6fWRfsFnEsJNd30XhU0SLm/Ne9+XMUmMAqGaRQYRilGe2Uhi1YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 07:36:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 07:36:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Index: AQHaavUDCy/i5tLpVk2E42aG3RqhHLEnNNfQ
Date: Mon, 4 Mar 2024 07:36:45 +0000
Message-ID: <BN9PR11MB52764189F754ABF69D24E2AE8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
 <20240229094613.121575-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240229094613.121575-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6086:EE_
x-ms-office365-filtering-correlation-id: 06a04caa-84ff-4752-990c-08dc3c1dd800
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PtotZAlkrCrYhTTsJz5TWpjH39eAn+rq7lV43Bo/vhv+QQopqRpDjtd524QNQiplZhC2BaxdccQ4fP1gZi9rifhUDj35d+Kx7q5vOC/zT3mkRg1ezkr1BFMpN2KHXx5Wl7gzdkXZ23O6pZ9TG0cTQ1tm01tqMakNPX7x3ulqoBDhUS+zomTGfw3foCm1Oy2DmgaH2pyYF3i9XYPz/yZq2YR/iX7cu5MEEd2Bf4wKCzo6pOZwI5VUbaadz5FWQVV3qMnTDPCmhAOkWakbpYFZu852f9BxNJ09FtRifAVUFlAUy1uZag8Qyfaq2hhKRXndHMTSO54w02m8EmRY/p9Pvur43zWowDg5PHM5HhYQetJXanW/SAiGSQDpnj0K18oRVXPSXhSRQhA4ZwHViIQLnGSxx74+dwTgKNbzfatF4I76O1zVb/kyV/n3cOuO01CjIVOh1hmMUDRY6z892rkbwUGUR4ftrnrmbUZarkrWOBmBloIaqjO6sPKYFsX+F78gixwyzlMu1n146G5w0xt1lqdgm7rJkagK1XYtWi4I5tB/1Hn1cS8i5B3Kh9EI+KIbsunKlV21LrSC+f7Fb0oKB/J4pEADB52dTPIQAIPxozTg8n5H1Xyqg5gZJTqqtAJvH2YNWoTwmWOI/iBMzFCJ75d8dEm5xsl+wTy6LoVY7cL7WV53SMKbEpdX6sNudZ56dVCpn/bCXS7yNM9m40aLh2GvUOazYSa/8uouZf9V/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJYmiXk6PpKT+0xu65vTJVaE3Diy2bAJcMAY9hExO1iMB9iPPJ2YRaguUTdb?=
 =?us-ascii?Q?sBY+qsr6deA+UstsVd1whHZjVBejcMCWvOfEdMuk4JU2FOeDDiWCZpiRZvtJ?=
 =?us-ascii?Q?PqJY1BZioQYK+ALrxUjiHJ0zQkdXjp2hanyyY2pEFzshOHPfdnZR8z61ISXG?=
 =?us-ascii?Q?4j+uuuI4Kxiz8fUsxnJyQyB3B8RAF6fV1ijKQI6GesSF2/cB+8hnxQRQ0RK1?=
 =?us-ascii?Q?iOJX40btax1th3oSDApYDTQtGGAO/in/7ZlqODlQdAkpYyZ1/r+r5W1vatLB?=
 =?us-ascii?Q?R44VsKBCq9bcfvdI/xZfWjqKfloi6cJKj/umL/qIKmiya2IY6EXYuUcl9Ot1?=
 =?us-ascii?Q?j3iMTdFqM9EEgRyTejcdA9yVhSbkz28b9gtH5GidTSXiIsri4Him/dI/p7Y1?=
 =?us-ascii?Q?opb5i7mbiaLxEPDrCIPehaZOeFylwHl9OzMlCZx2YvNOVwfBYltPbAhVhWsP?=
 =?us-ascii?Q?VbxIdIRm9IsRVncy2yTHx+udXpPcEOGvdrUr7FpmC2tXXBXVv1PYeRJ9GFB9?=
 =?us-ascii?Q?EaT/Ksy+Lo5A3qtEN1f9E36+yOD80p/ebcDGSRXHflNFSSKktRDPmOb9SBco?=
 =?us-ascii?Q?Hv6ounP8NZHZUqBPe/XQdmAV3K9YqHkqxX5zRMVq5fzsZgXmfUzQBKaODOx7?=
 =?us-ascii?Q?oWwjn8yYssU+XYVGlhSPc9UZwaFu+C++Z6eRBq2AQwzEoSHcsiWBwIkiMlyx?=
 =?us-ascii?Q?4D+1WqNb6mWKwFwDTDXEu+cSiSKakRC++Z/0H/Fg49Tow82ntl9TJFnFPHGy?=
 =?us-ascii?Q?KXtwi9LhD4GGSDrdWUSOLi6Ln4izlSbgh5KRTWhJ8W1ri/Lsq9YsfOYtCp7Y?=
 =?us-ascii?Q?2scWlwOwOwAnFEKA/zyRLMTCV+Usrkz34Spj3ExYU2oEtrILWUlZYBlbwXFd?=
 =?us-ascii?Q?GIPk95nIf+z9qbE4IL7YFwJywRTnLywLaA8amRSY2bqyBWeBjyyspqoRZdyJ?=
 =?us-ascii?Q?qEjw9S2T7IYj25QET3OzWB2zBVkJCdwVJ/5XBLtHFTN4Fd0ycfZo8SsnYFim?=
 =?us-ascii?Q?OZMhAn8TP1gtD9+EyM14uOcAj2xNWD5o4lSNjI0cf4dbBn/rdGO0ZQL70fwt?=
 =?us-ascii?Q?A7qxQRH72tksJzOgdflhw1XkZqVirQ2FVQ5i7D5V5CRqxD6QSfhkO1XCqlJi?=
 =?us-ascii?Q?kzMEaJ7FmAR5gcIHhJCpv8kEElEAbGgXM7AYOOhjfzxcE0Oynv9VjQm5cB7F?=
 =?us-ascii?Q?nN9e5aNXNsh+rJqJsfsXRburmL0xpPgpKfUahiuoreziOLj2M/MgP6UnC6hS?=
 =?us-ascii?Q?0GKaHV2umj7sz0BhC+uw6GaY5dosQo/2O7WB6olwT0mb/Ndksjy7IbIjz49y?=
 =?us-ascii?Q?ZkT936gGZkUaK2ijBy0d+eqeFApTkeGYCFzkL/dq81y7fZxazkLVBz6SoxiB?=
 =?us-ascii?Q?0fCiDTiDEc+cMGHde/zmGMleumzy8HUWzKc6brz96lmwbQjGbBcUnEerOH+D?=
 =?us-ascii?Q?6PcIPiJRxsYTIFUNsDFNXwrfBxL0wSjuwTEKzwkWB8UQZYBGyz6mRrxGSist?=
 =?us-ascii?Q?wL/HobStrvLYJswSf2pDVV0r4DU0w7sIxjq9W+I10SBn0VOIWfeJMzj+Itlu?=
 =?us-ascii?Q?w1iiR1A2BzEf3kQZwnfIGmvaf+oXfOgTa+2sYyQY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a04caa-84ff-4752-990c-08dc3c1dd800
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:36:45.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgnUwjoM+lxvB4SzObGmklelkdtcAtq4/a46KByigUKZATtLtJ3CLYeF8YAnHr7aiWqNiAWbYsCAKUAhLJIN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, February 29, 2024 5:46 PM
>=20
> +
> +/*
> + * Cache invalidation for changes to a scalable-mode context table
> + * entry.
> + *
> + * Section 6.5.3.3 of the VT-d spec:
> + * - Device-selective context-cache invalidation;
> + * - Domain-selective PASID-cache invalidation to affected domains
> + *   (can be skipped if all PASID entries were not-present);
> + * - Domain-selective IOTLB invalidation to affected domains;

the spec talks about domain-selective but the code actually does
global invalidation.

> + * - Global Device-TLB invalidation to affected functions.
> + *
> + * Note that RWBF (Required Write-Buffer Flushing) capability has
> + * been deprecated for scable mode. Section 11.4.2 of the VT-d spec:
> + *
> + * HRWBF: Hardware implementations reporting Scalable Mode Translation
> + * Support (SMTS) as Set also report this field as Clear.

RWBF info is a bit weird given existing code doesn't touch it

> + */
> +static void sm_context_flush_caches(struct device *dev)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +
> +	iommu->flush.flush_context(iommu, 0, PCI_DEVID(info->bus, info-
> >devfn),
> +				   DMA_CCMD_MASK_NOBIT,
> DMA_CCMD_DEVICE_INVL);
> +	qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> +	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> +	devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
> +}
> +
> +static void context_entry_teardown_pasid_table(struct intel_iommu
> *iommu,
> +					       struct context_entry *context)
> +{
> +	context_clear_entry(context);
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(context, sizeof(*context));

this is __iommu_flush_cache(). You can use it throughout this and
the 2nd series.

> +
> +void intel_pasid_teardown_sm_context(struct device *dev)
> +{

it's clearer to call it just intel_teardown_sm_context. pasid_table
is one field in the context entry. Having pasid leading is slightly
confusing.

