Return-Path: <linux-kernel+bounces-82813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644A868A06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030C91F2219A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690354BF1;
	Tue, 27 Feb 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT0GFqEo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D54BCB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019643; cv=fail; b=owJtVQ4VwkhA5jQOt0V1df+ZrCwuz6jVbTv9rkF83z8/yladdQIStgkta+SbpUtAX/8CN+2U7Tt7+v3D6jRJTVeSc6r/lhoQIvS8myxFMsCWSbdAdnur6U0za/BviBBUcsGMWDzuUqtGoV66u/2mvlAHBpPOSUaLebaYZA49YD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019643; c=relaxed/simple;
	bh=0Cz3dsDKzE1MGnjk8FCEY8UrxhpNtEMN1rn8zEnBVTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dm8b6GKB886/A9IOm5M6VJWh8qWx3KrzCcGbbiELw8C9jezOVY2e5h8KMRMmiB6JUf33mB0Unm+qeYD0RLLAfG0N2I55m3uqP3R85Y2bjhxvPB6jWgJCK41HKO8d0bcWB8sd3Zzxb67xdoTyku+MJ4exflCPEgtAdKmVHGwp6/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT0GFqEo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709019641; x=1740555641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Cz3dsDKzE1MGnjk8FCEY8UrxhpNtEMN1rn8zEnBVTc=;
  b=cT0GFqEor08pIBIgUUzB7lC5pJKTbv7r6axI1H+HKcFvYlNAVTVKTQBg
   k7arPTf9eYFKZtQwYZlsDpxHxIQxiD7l8Nf0gTwjGDqtwA3TTHCgFdhYn
   q9dMC6jjSyQnJZZg/zyf3Amd1KKiDJXDWU9n81fhRBXpenYE6IKpJzk0s
   qMJynFCS2mxmkMpp+sgkYgwfdIR5iPmxcwraAImjs6tf6LsxkZhmO9Hc6
   JrMK6ZBDJEWSTe5KLOyc00xNj2CVJAqG5rikCmBeA8kkitHm2WB6YzOgV
   0bfBeFlT7zIglYLhy+P+udMKSc/rLwkcOWkiIPbj04wKSLk9YcivSVWun
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3221499"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3221499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44446921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:40:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:40:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:40:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:40:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:40:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX6HFrvOtXbsy19Rg++teXL/1hf+yVfiIzf7AXlYKq9vPJkNFJx2xdsQW8BzDtwaf9XxJboNyE86vu7DkcnobEOM1hr3+3lKZjNiqwg0bVX3HTpmB1EMYi8GN6Jp6adon0w71MCZtAe2T4OW9WOZ+91B5+oIscgtM4inxRgkyNOVSTrHxHWgtVo5Te8k4wa2iKLyJONjnX0S2nTfrV/5Ixr+1mzni5yhrPc38l1ZSBGg2xAtcP9rf1aDfstKOpcxiiT4MZiDGUar7gw3/eJDnsRo8/M738JSwxcvkAS8rx4T26oa7QpjjiGeER5qsLO88JQTa0fmhMMWXU/g+NwEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qFo3Bcc1uC+3wIKfV3OjcXh9T+XEauQmUpPuhnj/c4=;
 b=V8HvnIWOs5UoapgHl51laOFMkDgzh/tvMIJ61T1rB75qS78wXlY65D9FiXJgylMeVExBTIXXff3d4LL24/a5yM8+zk8lGqgTRQHRe6h5vaot2dj7k6cVOwmBaqh9dW1KIeHnaynFev/BZl9HIg/EZgWFc1aWf4C596Yi7O24HDw35+Y8uraFWy3gLnlP6VrP6y8gOBk/jFjUgMDERhUolb8rmDrbb9hYcYrGUSEuyNifQKoL0n/axAMPuKxqc6d+oQ5upeGyAKaMp3wMCY8/VbqO2nhl3XXu5pvKRudOpPw6bBmgWNrlTFaivJl9KZSOUnc/Af9o4Mn8g2KDe0d2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 07:40:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 07:40:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Topic: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Index: AQHaZhfXSwaK0zWAdEOfbi7sTGWj9LEd0iRA
Date: Tue, 27 Feb 2024 07:40:29 +0000
Message-ID: <BN9PR11MB52763D19A01C804FB514419F8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240223051302.177596-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4616:EE_
x-ms-office365-filtering-correlation-id: c0964d8a-2b4a-46ab-8f1c-08dc37675f11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSegiDKytBYCTMSMmKa8TCkDtxlMBWPifBwzOri8ZsmN1skoNoxSO6R6QcGjl/0PqkqBAPFHu+lqqwWLm4u+vWxhp2ekaiFeTqAx6KM5o2xuF2HoKR5OgmfuBwDqI3ErjnYHP3WGjSKs88Qr+khPRmNG5IkjDoL8EwQyrF34l6kOpOuylwrySvCjclXarZkkQOO+EgJJKEPO19XHiLtobKDy1WcpviEnmGZvlQGTPT7A+InhZRSqVbqZtre1xWsvo5sjiJRK79/YkPNsECU2qNGInl8vsohwopHO203OsQDXvStv7F7nTb6ys0D3Yh7vTxnJOme5sQyyXOcBBb5ARTE0lbuZJN/1hphX2qvDHIWsZWK2fphmdVcZBZwWbrNVJZEhPddScT7Sj++HBmhyNKoV2GfAr7g1ZZWxbua+VnpPhNOs3duyz3eHhABu3KsrI9Z4A2Gt4X8Jd1vQifaNsIeo3q8M7g/EtlLpBpLMyVrqIiqC8XNOqYzUIOhluHkm/w6jC8RshwEGHSLjL+4n5Nhs3jy8eWWhzmkZ7Scur4D6/BFEcUjNsLA+qs3MCfR4FHN11aVYRvKoZUrtb0ZHnPTlEl2mYjLPGlGNygAhMvh2fu0UYc0a84JHreKqy18RT062ptBZfmMG/R+j3F3lCOoqNmeE5Yw21ZZ/jNWV+K6eTvP9qZTGpMeThGFHyXlkfU4EC8zhfXBL8H8TxeOVhF8q5ZVrf/d4x9SwSaVtcvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?158T2Ighs3zO7+G48cMGGnSW/SSvep8+7Q9O+lF1s2c/mar7Xz/3BRf/vj0t?=
 =?us-ascii?Q?LSffWT/ZtObiLU+njEvjYLVEfvh/ZmkGKNl8HWUBl6pyAXnr4TfFZgS1jpQs?=
 =?us-ascii?Q?yK0eOyzmN/xVO+h2Qr/ujOiewgKVd6+NZwPHw3Z/8z5YQYrNIV1uix0Qdk86?=
 =?us-ascii?Q?rEJQ1bP0fkRa/BcfTZNSEz+t3rX9JFjQUDKlxPwotgV4H7crfhirD6cPYZpq?=
 =?us-ascii?Q?PjAlM5Cwc0I4nf7J0+WnmRKH2IXYa+U2bSEIxyfQda2MgqXfQeWVVfZFQ5Ha?=
 =?us-ascii?Q?8FXqj8S9OGHM8psNn3r23CtGkMf4zVRSaGqxnLSrjg1S0+YzgyM5IyJWlzV3?=
 =?us-ascii?Q?t9Qbbgm+7LHeV8X8biv0EYsCRxffAykcz3vDxPOBhMK7oStK8fx+vqhIjHB1?=
 =?us-ascii?Q?vahe14ZGa6FyCwMbZPJ585+RJNHJ9BAGmqKP/jb89cZKjuWO3vnsZOeHtogk?=
 =?us-ascii?Q?b4teXrgbpMfuXcfhOSxdnyVYioQej1QpM4mFyqegfCyJLie7atcGoh9HlduF?=
 =?us-ascii?Q?cZC/9Cwl6tMwwmHIbc4Nk9O6o9NWxOIuIr2GBUs6hy+iigj6My5hiuYnbvMr?=
 =?us-ascii?Q?cb0dcxwBtqhSArwdVNkGRmJHjImm3HaxBhtLUYDftj+XFp8gjr8uRMZ2nxsY?=
 =?us-ascii?Q?4IhqwGrwL7UxSIc75xDCyvH64oPn9wPqcOVlqEStwAyIEilnR1pA2SKk7Tex?=
 =?us-ascii?Q?NSia/q4uTphsF61txcEQY5FjxKYbKmKOb3HwH3Z49xzdMZAzXcGsBWLAi10M?=
 =?us-ascii?Q?YqHWtq27V+JxFy7glzl95hlulbxPpwiVg7XCJwPzdbTyvyT8WGbCYY6o/hWH?=
 =?us-ascii?Q?L9aH8/0Ap73PdYAiCI8gpAQ1lEwwhDNXmK8IzG8KYcWoO765hQBemcuebnTz?=
 =?us-ascii?Q?8MihoYD70/9ZlEVtn5Z1zlwsA1ldhm8rKHu0qE0JZ1dXhAMB5Gd76xYHMC/B?=
 =?us-ascii?Q?LRUM5yjutFfcvGjLjKoI/CBwywneMFum9mrcdd7HO1znXiK8YkLiNsA20hDX?=
 =?us-ascii?Q?ldS7rpkLea4jFelQ//K7Ln0HpzenjQO4vH4dnemmTWZAaW3J/thTxwyk6SeF?=
 =?us-ascii?Q?lCuFPT9ABT2IfD6L2KMGY8aSxxzVlJFhcl8gKbzhjfYTJQnrwbjcET9U2bKh?=
 =?us-ascii?Q?Vza2yvsEc3W9jY1uH0+dSvGVudqBeNXgVrgVD8LoAyLcURXvKPP0IktmSzyN?=
 =?us-ascii?Q?wxuT6HZznipskfcuaLm1zWHjER9Obe3X8QJSXAkF+KHjvCjX4L0RS3PZ+nNO?=
 =?us-ascii?Q?RtVJlGNKQt8lU+5dQmHeXYocSO/K2+YIBXMCTFk/t/1AImpm4ZYKjzjeTTWn?=
 =?us-ascii?Q?D3i2kPzPomd2BKtYaCAfvjdtanBQwZBKpsvZV+T22PVYzmVSSwpeXAE4A9yG?=
 =?us-ascii?Q?1IyxkepFv5+Qu/dZmJsx1bU8WvNrA5fgZOGPWSKLA8bImgSJHru9aJE12Y2X?=
 =?us-ascii?Q?w0ND1n3Hfa4mFeAHyHKJO7kdHg2ihiKX0RlxaSwNhtKnwLpOTs35FVP5emn/?=
 =?us-ascii?Q?JGEO/SiWJr0eW5X0HDX4rquY0q52HllKG4LEWT7tJztp+uLggAPZvLw5BtoE?=
 =?us-ascii?Q?r8eiQcnomtp1jWXxj5JdJI0BcKb7hBDB1NQ/ckQM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0964d8a-2b4a-46ab-8f1c-08dc37675f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 07:40:29.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLFChK3qW/Cy+cAO5YdmDFAjwf6TI51JZRvOMYg3nSsgkfzF2xpgqjB96S0lMgUCyOzUyfKW2jnFvbhPLwJh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, February 23, 2024 1:13 PM
>=20
> -static void dmar_remove_one_dev_info(struct device *dev)
> -{
> -	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain =3D info->domain;
> -	struct intel_iommu *iommu =3D info->iommu;
> -	unsigned long flags;
> -
> -	if (!dev_is_real_dma_subdevice(info->dev)) {
> -		if (dev_is_pci(info->dev) && sm_supported(iommu))
> -			intel_pasid_tear_down_entry(iommu, info->dev,
> -					IOMMU_NO_PASID, false);
> -
> -		iommu_disable_pci_caps(info);
> -		domain_context_clear(info);
> -	}
> -
> -	spin_lock_irqsave(&domain->lock, flags);
> -	list_del(&info->link);
> -	spin_unlock_irqrestore(&domain->lock, flags);
> -
> -	domain_detach_iommu(domain, iommu);
> -	info->domain =3D NULL;
> -}
> -

what's required here is slightly different from device_block_translation()
which leaves context entry uncleared in scalable mode (implying the
pasid table must be valid). but in the release path the pasid table will
be freed right after then leading to a use-after-free case.

let's add an explicit domain_context_clear() in intel_iommu_release_device(=
).

with that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

