Return-Path: <linux-kernel+bounces-108904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD128811AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE78B1C214AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50E1EB27;
	Wed, 20 Mar 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTWSKouq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96A1DFD9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937888; cv=fail; b=FpkZmY9JK70GwC8qYZqSlW9F0RKAIqB2o/pUdKoIb9jKfEbNoGqk8wyK13tH0cz3JD4QTIx9N1U8rQIcpsGjK+HkQuMk8SIfhAPive9xeZe5ji96NuLiYbIg3fYf3UIJcQDI75V30kK/puHDMC3L3BNI7eS5kpS7GVHsCAuecFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937888; c=relaxed/simple;
	bh=/vfyFUEnNyyMQoCe0NVRyRb6AtPfbi1M0UPNTIXmHS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KyUDfKqtB9ZsTnQcfEtwQo+ns2GND33eFHAMN7pstOmTybyrV/6SMl/0JT7ASoYusk+xmikOMOCo5gLMJq5vITI2eNB8CH4+IxtmPzaWFNn4e4fplOYJL+kE37LjWoqrD1G1fk7Lv63Jgn4m0MaAYgyfZIRqTOZC+/M0a3u342w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTWSKouq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710937886; x=1742473886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vfyFUEnNyyMQoCe0NVRyRb6AtPfbi1M0UPNTIXmHS8=;
  b=KTWSKouqKc8Y1eIkb3H7sozEiDKDVOBKpQ3AFt1hbuSuHIizw9FYwXck
   I4WlowamQHaIi3sr9HEehctsjxOMVp0r4e9EKwtK3FLHowteJLyyMaoba
   K00qnM+w9OfVVg8W/7o/vrYWBxUDITagqZXZsV1iMjJT6G6sb4udj1flT
   pRGgK9UC3LY3AIuWlWYOOafh2rkHrniz/KCQanGcOY7ExcZggCMtema+Z
   2yVPgWO7kxqAwbbcEmRkcS7SURT2xAniYL/MTlGOY2CGYdTlBAAiXRjqp
   Q34Z+AEL8SkwYEmk7LN+Jh+usqeiUm+tNzw8p6b9BdquGLRNtJu/6TwNO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="28332946"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="28332946"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 05:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18862649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 05:31:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 05:31:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 05:31:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 05:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPhAbh4BdBC6w46e3B9pFzG9cEDp2T4Fweu8BfExkoMRt3dRNKyuOWfHPwniYUEdp9SfItomK/57r9jxTNBfqBiee6mRXMA2irgIbsxFcYmb2kSvQsCkIMFrs/KhVimBpH3onrHksINUZyAnLSswH2MXLVnQF7SUpe5PSV0th2wp8GUf+kqSLqisHq9pJekXGA5P270jrwSWtKeEvEMPul74W9e2qx9cQetZ6q/6StZVYSeybfnf8pTWTzCKEKH9qvE/eHSbZNLi8LAP/ZFgusUVyMyQ1IDOved75qzxAL26AtlwJvlxehGu2YJc9lJ0Zg+V/l6xzYUpNChqFSUNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMER5pQnh0Rjqc6NfgwWO9pfWBCvMamsBb1C6JvPvpQ=;
 b=OVOOl5/OLKcOTTBmq6uNQqyUkF0LgnD58tyLNKofAitJeWDvi/l+XxMQfZeRpMVZfSokHvpYo+EsV8shGjM61kXu2W6xSU64OCHV6Pt2hKBisi+SqomXG5msisSAyXoQ0LQ0736aJ4obRrLOsbc2H1ZIeyYslZDxc7ylFEyBI298OT/KTiRbSoFbIvYqH6ru1/18/LMmYbs90ztOj7zRhbLWi7kuQkn3xeGOf9rbk3mSiTCnx+YnC2wNFmKZg+HgU/hE00HCOAQIu/WzU2024PkifnqVZ8jrpaEkVKVMFQbMEcErTEvGY5Q4J90w7Y7Cou5DrZhPTFVStIeq6aWvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 12:31:17 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 12:31:17 +0000
From: "Prasad, Aravinda" <aravinda.prasad@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "s2322819@ed.ac.uk" <s2322819@ed.ac.uk>,
	"Kumar, Sandeep4" <sandeep4.kumar@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Subramoney, Sreenivas"
	<sreenivas.subramoney@intel.com>, "Kervinen, Antti"
	<antti.kervinen@intel.com>, "Kanevskiy, Alexander"
	<alexander.kanevskiy@intel.com>
Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Topic: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Index: AQHaeTeYeVMaFIFnV0yMrKTBAlKavbE+h/4AgAIFciA=
Date: Wed, 20 Mar 2024 12:31:17 +0000
Message-ID: <MW5PR11MB5907D65A7557AA1381B477B0F2332@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
 <20240319052054.100167-1-sj@kernel.org>
In-Reply-To: <20240319052054.100167-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 62415b93-d340-446b-8b45-08dc48d9a3c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZcUQyDeYxQYSSinpq4GTRLZ+CeS30e1DbZqOKFxvLFLqvJun9dX5yIv6a/RJgijkpUbie04Y0HQF1r38iG+lbCQyyuXBUX9kmhOme9rMf8RQ8lx4BOn8Cqem88RuIqbGAPQrBzh39HRpgukVIsEZfnKCrTogJUm7/3+vN3v8eZ4bFyHOAzOGh8OaNwjV68wQmyDC3QB9vj9LBi+EY/MmFHxLsSs1X+LjtJ6Ug8QSJnMZ4FGNM2fg7zSqnqkvEGGO/2zqD9mCFFwsPwIUsxOZmVSglkHh//4x8x4id3xINaZm2lDNOz2zrzhB07NkG38QirTT860pqcsXH2xknZBvDrqiE4n7v3Z6qOFilguGgBuTNWzWrWa89TXqwtsdIgQzTdn7U73SCVw3qNAo/ZS1wZPuz5cN7gS0iXMoy1mN3xFxx3X7YPJbKtKUu/YEXcxrq8MO/0Dp3Zik81ay6Fe5A93rVw9IMnpVFRQwOZLpbLq/VeJMQLJQaGf4iovVTnteHHZI5rVXkJX1uuQZbroT3ybW5ADXvClVfTBtPW47zS5seCFWBXfcXYE1ImCV2d5NiaqnrwQzW+h4GSSMWq2uxRuLEhM0lRnLj24b6JYS9oSufhV16AlI5L9FV9AGkohfRJbkApDfZlFzhg5iYNXF6h02VavBRCCZSTsLTyf4Me5aLUebpE6/jgTQffelJVv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6LX8PS8AgSUIf2j90KrErpZYY95KBhKugFpuXuRmXdl+q1yr8OihjFWsYEee?=
 =?us-ascii?Q?pqi0de+kHaot6j+kdeTXGiB5E+xsR39CeanU8H/5P88IYUMqBvf2yTlZ6Qk9?=
 =?us-ascii?Q?Lvmkw5fAmfUAKarNkKR2Xr+AssfInCtnJvGo21lYAhZtU42Wbm94LiVvVEQF?=
 =?us-ascii?Q?O41moQKD+cHarSe0kW7st97IFuqUARf2jvyeYcdFKHqa3PL8twD2/0PQ88sp?=
 =?us-ascii?Q?NfPf3SXUBc4HqiLg9jwm8s/i/bjAQkV8rzUZrqMArAFIjkcaB4IRpk5v92pA?=
 =?us-ascii?Q?1l/iIMFKL7VxoK3aVPXcWXiu4UOW+rU/B6HHMGrOy+n71c1eRbDFEfkaUpLl?=
 =?us-ascii?Q?ck9ajYCQBc/+j26ZodQEOhIWeu8hmSlbsETVFIr45ZjL3u9rzOMFGe69z1Ie?=
 =?us-ascii?Q?4VAVClKcAYvL5oN2X+prfBLVb0donjWHlZeC7Q/vsLaR/Tezshd9/mj0e0bX?=
 =?us-ascii?Q?ChqhkQEXoQVkRwJ4BkrROTB/3bmxC9U2s23hrUSp32/d0/wi2pwIIabJ/c21?=
 =?us-ascii?Q?xauvLGu8DexOWC2vc69PSGZy+CGMdfu+skJi2XYgI39Hd/WVnasvHrODr+Je?=
 =?us-ascii?Q?5jGdhMEON/ZKIA+hhzgeMUDjemoM5N9P21+E8QRK4R4n/7JPT+11+y4nO8RR?=
 =?us-ascii?Q?6HQnyfwcOCiWI+9NIzVXRxeizX7TAMdoP/CgBE0gMFwG5+ZjZRW+UMyTwPDd?=
 =?us-ascii?Q?J/U9HQv9VRWiwLi4botvWa/gQe+vWTbx6Fo7Z7nF7Zs8rVv8S4Z7/7hmFsZ1?=
 =?us-ascii?Q?f1WUlSW3D1/dRfPN+3wVo8wyOehDk7ZSTxLI4KWKMe4+V2eM8R4ssdOmvPg3?=
 =?us-ascii?Q?AHbP5ooIGLCVFTZFGBDyhyfmZrGzPpZanCzN1ojcRHcrwkajtHawfw14QMM1?=
 =?us-ascii?Q?1+oya0PersUMYqBG1kysNt56IqS6inXYoEuztbtL1j3jLyC/DmhZmYBh3Vgi?=
 =?us-ascii?Q?LVTIzmcPKvLIPbu/kxNJI7s2sev0I3u+8G4JphLOxJ8H8WNRmohbuFqHVaYs?=
 =?us-ascii?Q?PWVb6BLRpyCkZkTZfQIg+VwhjyNpJQnYfmEZCJSg9jLK2Eu0Q1hM3IA0dK12?=
 =?us-ascii?Q?BYr7nOOUKnf7DX/EgxiMABnxTF5/i5xhNrrXmu9PEeQQ8zeKQrLMZiK0NjIx?=
 =?us-ascii?Q?77c8CFgtlo1iHMFMm9wenlIlWEpOBONlCYzoNpAWYceeTCyLqjRY+i4mg1j0?=
 =?us-ascii?Q?qEvBM7SUGXAkjUfTw0FA7YzeagyL6RLIY3WoAUtiePHUBMr/clfeagDJcAI0?=
 =?us-ascii?Q?hzwW2w7iB+lOgUU6CndEOMv0zY/vMzniJ8L5g4Rk8pfC2jqYKt+ErC9bGtA0?=
 =?us-ascii?Q?StfXLxGySSL6evENecBn7pT8X/PNngcK+AMndtyW+k3ky9ZzYkD29Ay2NGEF?=
 =?us-ascii?Q?NVIhihCHf2Cx6E//hWWnqpawjPNCBv5HSaXIMTb20pE2AgjMt3f8DucestCt?=
 =?us-ascii?Q?Y5/cMxob3pIqxgtNADvQsDOVfOlQlDAgF1RlOWXuVnyt0K1wnX8OKo1DLEzZ?=
 =?us-ascii?Q?8MjXlWEV+t0AykvYUbCIxDcyy7QeczsRUb4Vu7c53ErbJyU8HH2+HiodVeg0?=
 =?us-ascii?Q?PgMn9coVLqsRaqiXZNko01GgSeDQns/Q9QZRzPCT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5907.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62415b93-d340-446b-8b45-08dc48d9a3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 12:31:17.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qoX0cJjbOPNLqrapUoVw9VtT8b5y/8GzHxz0VZO++eg2xlSEviML5Pa/vCpp0M3EYX4eTk1dAeIvtZxAnSZhYDDXARhiVaQxaUZmXZbvJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: SeongJae Park <sj@kernel.org>
> Sent: Tuesday, March 19, 2024 10:51 AM
> To: Prasad, Aravinda <aravinda.prasad@intel.com>
> Cc: damon@lists.linux.dev; linux-mm@kvack.org; sj@kernel.org; linux-
> kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar, Sandeep4
> <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>; Hansen,
> Dave <dave.hansen@intel.com>; Williams, Dan J <dan.j.williams@intel.com>;
> Subramoney, Sreenivas <sreenivas.subramoney@intel.com>; Kervinen, Antti
> <antti.kervinen@intel.com>; Kanevskiy, Alexander
> <alexander.kanevskiy@intel.com>
> Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
>=20
> Hi Aravinda,
>=20
>=20
> Thank you for posting this new revision!
>=20
> I remember I told you that I don't see a high level significant problems =
on on the
> reply to the previous revision of this patch[1], but I show a concern now=
.
> Sorry for not raising this earlier, but let me explain my humble concerns=
 before
> being even more late.

Please find my comments below:

>=20
> On Mon, 18 Mar 2024 18:58:45 +0530 Aravinda Prasad
> <aravinda.prasad@intel.com> wrote:
>=20
> > DAMON randomly samples one or more pages in every region and tracks
> > accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> > When the region size is large (e.g., several GBs), which is common for
> > large footprint applications, detecting whether the region is accessed
> > or not completely depends on whether the pages that are actively
> > accessed in the region are picked during random sampling.
> > If such pages are not picked for sampling, DAMON fails to identify the
> > region as accessed. However, increasing the sampling rate or
> > increasing the number of regions increases CPU overheads of kdamond.
>=20
> DAMON uses sampling because it considers a region as accessed if a portio=
n of
> the region that big enough to be detected via sampling is all accessed.  =
If a region
> is having some pages that really accessed but the proportion is too small=
 to be
> found via sampling, I think DAMON could say the overall access to the reg=
ion is
> only modest and could even be ignored.  In my humble opinion, this fits w=
ith the
> definition of DAMON region: A memory address range that constructed with
> pages having similar access frequency.

Agree that DAMON considers a region as accessed if a good portion of the re=
gion
is accessed. But few points I would like to discuss:

For large regions (say 10GB, that has 2,621,440 4K pages), sampling at PTE =
level
will not cover a good portion of the region. For example, default 5ms sampl=
ing
and 100ms aggregation samples only 20 4K pages in an aggregation interval.=
=20
Increasing sampling to 1 ms and aggregation to 1 second can only cover=20
1000 4K pages, but results in higher CPU overheads due to frequent sampling=
=20
Even increasing the aggregation interval to 60 seconds but sampling at 5ms =
can
only cover 12000 samples, but region splitting and merging happens once
in 60 seconds.

In addition, this worsens when region sizes are say 100GB+. We observe that
sampling at PTE level does not help for large regions as more samples are
are required. So, decreasing/increasing the sampling or aggressions interva=
ls
proportional to the region size is not practical as all regions are of not =
equal
size, we can have 100GB regions as well as many small regions (e.g., 16KB
to 1MB). So tuning sampling rate and aggregation interval did not help
for large regions.

It can also be observed that large regions cannot be avoided. Large regions
are created by merging adjacent smaller regions or at the beginning of
profiling (depending on min regions parameter which defaults to 10).=20
Increasing min region reduces the size of regions but increases kdamond
overheads, hence, not preferable.

So, sampling at PTE level cannot precisely detect accesses to large regions
resulting in inaccuracies, even though it works for small regions.=20
From our experiments, we found that with 10% hot data in a large region
(80+GB regions in a 1TB+ footprint application), DAMON was not able to
detect a single access to that region in 95+% cases with different sample
and aggregation interval combinations. But DAMON works good for
applications with footprint <50GB where regions are typically small.

Now consider the scenario with the proposed enhancement. With a
100GB region, if we sample a PUD entry that covers 1GB address
space, then the default 5ms sampling and 100ms aggregation samples
20 PUD entries that is 20 GB portion of the region. This gives a good
estimate of the portion of the region that is accessed. But the downside
is that as PUD accessed bit is set even if a small set of pages are accesse=
d
under its subtree this can report more access as real as you noted.

But such large regions are split into two in the next aggregation interval.=
=20
As the splitting of the regions continues, in next few aggregation interval=
s
many smaller regions are formed. Once smaller regions are formed,
the proposed enhancement cannot pick higher levels of the page table
tree and behaves as good as default DAMON. So, with the proposed
enhancement, larger regions are quickly split into smaller regions if they
have only small set of pages accessed.

To avoid misinterpreting region access count, I feel that the "age" of the
region is of real help and should be considered by both DAMON and the
proposed enhancement. If the age of a region is small (<10) then that
region should not be considered stable and hence should not be
considered for any memory tiering decisions. For regions with age,=20
say >10, can be considered as stable as they reflect the actual access
frequency.

>=20
> >
> > This patch proposes profiling different levels of the
> > application\u2019s page table tree to detect whether a region is
> > accessed or not. This patch set is based on the observation that, when
> > the accessed bit for a page is set, the accessed bits at the higher
> > levels of the page table tree (PMD/PUD/PGD) corresponding to the path
> > of the page table walk are also set. Hence, it is efficient to check
> > the accessed bits at the higher levels of the page table tree to
> > detect whether a region is accessed or not. For example, if the access
> > bit for a PUD entry is set, then one or more pages in the 1GB PUD
> > subtree is accessed as each PUD entry covers 1GB mapping. Hence,
> > instead of sampling thousands of 4K/2M pages to detect accesses in a
> > large region, sampling at the higher level of page table tree is faster=
 and
> efficient.
>=20
> Due to the above reason, I concern this could result in making DAMON moni=
toring
> results be inaccurately biased to report more than real accesses.

DAMON, even without the proposed enhancement, can result in inaccuracies
for large regions, (see examples above).

>=20
> >
> > This patch set is based on 6.8-rc5 kernel (commit: f48159f8,
> > mm-unstable
> > tree)
> >
> > Changes since v1 [1]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  - Added support for 5-level page table tree
> >  - Split the patch to mm infrastructure changes and DAMON enhancements
> >  - Code changes as per comments on v1
> >  - Added kerneldoc comments
> >
> > [1] https://lkml.org/lkml/2023/12/15/272
> >
> > Evaluation:
> >
> > - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
> >   and 5TB with 10GB hot data.
> > - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
> >   parameters set to default value.
> > - DAMON+PTP: Page table profiling applied to DAMON with the above
> >   parameters.
> >
> > Profiling efficiency in detecting hot data:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		>90%	<50%	 ~0%	  0%
> > DAMON+PTP	>90%	>90%	>90%	>90%
>=20
> Sampling interval is the time interval that assumed to be large enough fo=
r the
> workload to make meaningful amount of accesses within the interval.  Henc=
e,
> meaningful amount of sampling interval depends on the workload's characte=
ristic
> and system's memory bandwidth.
>=20
> Here, the size of the hot memory region is about 100MB, 1GB, 10GB, and 10=
GB
> for the four cases, respectively.  And you set the sampling interval as 5=
ms.  Let's
> assume the system can access, say, 50 GB per second, and hence it could b=
e able
> to access only up to 250 MB per 5ms.  So, in case of 1GB and footprint, a=
ll hot
> memory region would be accessed while DAMON is waiting for next sampling
> interval.  Hence, DAMON would be able to see most accesses via sampling. =
 But
> for 100GB footprint case, only 250MB / 10GB =3D about 2.5% of the hot mem=
ory
> region would be accessed between the sampling interval.  DAMON cannot see
> whole accesses, and hence the precision could be low.
>=20
> I don't know exact memory bandwith of the system, but to detect the 10 GB=
 hot
> region with 5ms sampling interval, the system should be able to access 2G=
B
> memory per millisecond, or about 2TB memory per second.  I think systems =
of
> such memory bandwidth is not that common.
>=20
> I show you also explored a configuration setting the aggregation interval=
 higher.
> But because each sampling checks only access between the sampling interva=
l,
> that might not help in this setup.  I'm wondering if you also explored in=
creasing
> sampling interval.
>

What we have observed that many real-world benchmarks we experimented
with do not saturate the memory bandwidth. We also experimented with
masim microbenchmark to understand the impact on memory access rate
(we inserted delay between memory access operations in do_rnd_ro() and
other functions). We see decrease in the precision as access intensity is
reduced. We have experimented with different sampling and aggregation
intervals, but that did not help much in improving precision.=20

So, what I think is it that most of the cases the precision depends on the =
page
(hot or cold) that is randomly picked for sampling than the sampling rate. =
Most
of the time only cold 4K pages are picked in a large region as they typical=
ly
account for 90% of the pages in the region and hence DAMON does not
detect any accesses at all. By profiling higher levels of the page table tr=
ee
this can be improved.
=20
> Sorry again for finding this concern not early enough.  But I think we ma=
y need to
> discuss about this first.

Absolutely no problem. Please let me know your thoughts.

Regards,
Aravinda

>=20
> [1] https://lkml.kernel.org/r/20231215201159.73845-1-sj@kernel.org
>=20
>=20
> Thanks,
> SJ
>=20
>=20
> >
> > CPU overheads (in billion cycles) for kdamond:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		1.15	19.53	3.52	9.55
> > DAMON+PTP	0.83	 3.20	1.27	2.55
> >
> > A detailed explanation and evaluation can be found in the arXiv paper:
> > https://arxiv.org/pdf/2311.10275.pdf
> >
> >
> > Aravinda Prasad (3):
> >   mm/damon: mm infrastructure support
> >   mm/damon: profiling enhancement
> >   mm/damon: documentation updates
> >
> >  Documentation/mm/damon/design.rst |  42 ++++++
> >  arch/x86/include/asm/pgtable.h    |  20 +++
> >  arch/x86/mm/pgtable.c             |  28 +++-
> >  include/linux/mmu_notifier.h      |  36 +++++
> >  include/linux/pgtable.h           |  79 ++++++++++
> >  mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++++--
> >  6 files changed, 424 insertions(+), 14 deletions(-)
> >
> > --
> > 2.21.3

