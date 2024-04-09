Return-Path: <linux-kernel+bounces-136335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD189D2CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E0283B67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E777F3E;
	Tue,  9 Apr 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYVW2AqR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C73399B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646448; cv=fail; b=CTrgGhsZe7yKPVvFKN+3yjXQl1wLVCBMNewZhdbbWfS/Hd0SoA/K27CsSgNTEPwUjtYwCZP1pFXzOzr4snCKqCOIVtRoupGpz+2O2oCGGtSxV01Wscumgfpzxcx/FjGptNZDJ4B8Rqp4EjtkwJwWimFxo1LgHLDxM3988bCQKcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646448; c=relaxed/simple;
	bh=ZseXNn3RUY/igAz7UDgc650toes5P0AzguhBbG4cl4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UpNbRR9XF45FE7H5YoZydLhQO6HEQzb7ZPe9lx+13P5gEVena9TFu+0zN+qioJHVS3G0EhP/s6WEfmCyIRIGybas49s2cu8Ewgclf9WAzcNRe2nvLAEhhZjJK1ZxyIvEVbEBMZRaA8tDTllv+bwii/Yt8q60G56f7SHhzf0Rxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYVW2AqR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712646447; x=1744182447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZseXNn3RUY/igAz7UDgc650toes5P0AzguhBbG4cl4w=;
  b=gYVW2AqRXXuW0QhRD57OstARuIKRu+Sy9byujmrrSow/SOkinkVhHWxo
   H2yicUfH3A1eJpIeZwbdD4hUVdngleCgOgBE6CPhGxHtehIrIy2YSJGjm
   zHk+saDue5QkWa404xHF3gz5mygu2Ox1IQFDp66xN2zwT5oUkNxMrOWtH
   k2GAyjiiONBfPC6nhed5Gj0oDa0ffDVH39f4q1Qc/+4WaZ+Cx8SXg3lpM
   +zjNhiq+zhvGhEnaRGDZgYDZNZlHCWOg9/YQx3ROoj/CDjWM0ZIuSGag/
   osxBbw9RkvAVjI8OsSowf0QYivsANf2vdH1Zi1OjEQQZMhJIQESbhhs/P
   Q==;
X-CSE-ConnectionGUID: We/rfmggQTmbxI2dxHP1pQ==
X-CSE-MsgGUID: GKi8/PLrTcuMx72iuTN5uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33355073"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="33355073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:07:26 -0700
X-CSE-ConnectionGUID: DzJLbkB8QY6vgUqjT1evuw==
X-CSE-MsgGUID: g6LmHeEiSxKuHOk0HniofQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20703424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 00:07:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 00:07:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 00:07:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 00:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNHAnjfo7z/51QCQHokju2K0aHUT6QomheHBrAuZjdkLuGlPumli/bBo0K3yNQJzPtqi44qYDMX7u3M7mO+9Wu89WntjGOZlFBv6rWwWdX0jgjjxTBrWI0LTUXu/HtTJge7OOUOV7ROWun2YNJoyVgYtDrjEvil4Vx6GXojXzritUw/pHgfadllx+Dsc6xtVOwX+woZ5PpFZSBM9C+U+ucQGf2XpZI/hhnt20xEx4myFwA/Sw5E2MIQhx+S/p6vQr7yTyvGu8bnVUe0r//S8OMjqDMy74h9SBh4kun4vWb98PqjcA0+zwmOqwSQR/w0YcMzgSsjmn59Q/4JaCysDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVn/47zbXLDFVdzFoPvpOAH8plBudyjC4ySrqWj2v/o=;
 b=f1O7qlwuIOiKCaq9122d4dXgBP9NQ0vnFV4GCo2YvIC74bigv7vZFsts8tAbvX2Po52PzHW6z2oxAHcCfB5GXMwz5BXS6Z5ZnzW4q+t/rZNuLAWntjItY01e+5D3f6xF4XHP6ZKcIYTyEpB6QmN9TkMDm2sxaEUGkVGhkbwgenRTKuyxHSyFOGx0MOoJyx2AOwCWaKnqv8yJIIMMYnL/AIaY85ksjzT/8FHTQxxMwGyB38AojElUsaLM14Pl0ocDMi6fMfjM/CxbgT1xEL53Xqu5lvi+NnwXHy0IRhV9a98kJuiMkS1Nsg5jW/ony4Rcd356Yuqd2w9WmECGItxDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7848.namprd11.prod.outlook.com (2603:10b6:930:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 9 Apr
 2024 07:07:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 07:07:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "sivanich@hpe.com" <sivanich@hpe.com>, Thomas Gleixner
	<tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "steve.wahl@hpe.com" <steve.wahl@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Peter Zijlstra <peterz@infradead.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector
 exhaustion
Thread-Topic: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector
 exhaustion
Thread-Index: AQHahiB7n7Y2ch8WjEeOJ91b45rj4rFeEdyggAB/KgCAABntAIAA3vIA
Date: Tue, 9 Apr 2024 07:07:22 +0000
Message-ID: <BN9PR11MB52763561BFD87DE35FF4A0048C072@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
	<20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527677A69A2004A951165CC38C002@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240408090556.6165e603@jacob-builder>
 <20240408103844.1b567bce@jacob-builder>
In-Reply-To: <20240408103844.1b567bce@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7848:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsVMMYkx1U5D7lmZWnt3Qj1vc+zehBG4o94tRmM2Tviyw9Ewjnndm/obkex+uP3dkfDSR1WdCW0h/4T3Gq9WLUfDy+MdFD4eshjr5fjcrX6/LmPAHs6r2zaDKYwGB8mg5riS04rV9nM1fMcRy4w8zfiIgGzZe5eVf8A5tbc5e5MKmJSSSWGwstg1lpD0eFxjZv4g8itqyD1xGNFsGxf758j8cNt30SARj0f+nCP8ulXicRtSEammDmzT3lgcO0Va35TNn/LXL8yZbrl7IVnU0uKSMLRZ9cEBWpxDmNhM+r22I/p9kaWfuot7HWfEoI4iCEh2b/dBfn6NXp1exhZNeZLUMvlKXiutkVvgcAIPpnOeW38sKcowppqZ7U0WPQJq1r45BlZ/9g8ebIXedx/qaKxBZU28UGhqvykeLeDzKaLZ9tuah3plWPPwzxX/Zk9PAsTqT49B0Xcmw8HhFaaKV3lVKflYa2OOzPcdDhzLvtxLJQXrjlTuTbHCGWXCk2kHcvMzeeaJd59J3V51USrRWHQ8JlvKxtrKmlI/BSXSvmMQ9EkAb4kuLeCLed/aE+ATBC7SL/KsSEwF5IrZ1fjch3O7bag4anDgw6OAf6k6uGrI7ukw+MvgzWutM0ry72Ux8kuTX5ZSKXBuZys2y9/5LPFGT7IukuyFfG+sSN5FWiY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKU5K8jWnipABayClJP5wzN4CziX4PlOOEr1zRt9WeWNKlAPk8ybcBQ3lv++?=
 =?us-ascii?Q?aMf9tU/D580l5pX4YwHzKFaakFPy01hA70cCfqpgd2lKWdQbdrL9Zt8BA+oK?=
 =?us-ascii?Q?/WMwZoe3zh01v4l74FoSHji1UxOzIozMNBwiQeNtbrnmbv9zX/ZfjZiQgcTC?=
 =?us-ascii?Q?7BP0f3us2MnOL0E2OsmoE0VnScB4fG/pH3IqpiR96HpV+7+tQSnIHbNVKFqH?=
 =?us-ascii?Q?3pjx8M2Dsn7ojLci3lFMvtGwSbRMdibuND41KOUv/ZVyZaVQX+46xZ2rawYQ?=
 =?us-ascii?Q?/O0/m0i4zwCPComBANX9Dhlq3EMqjXIFeHkvLtjNAMVArX/AvAd7pPuByGJP?=
 =?us-ascii?Q?Dd63EGaxbJRBt+F1V5IvPg9RU9BQ5EoDHZzK0sPjj/nXwOGRl3cLGkunhHPV?=
 =?us-ascii?Q?sSoaKdenjDYv8KkQ8wbItZwDV6pUawMGcV0mTfUlqTR5+yxKtWwm6WGWF5nE?=
 =?us-ascii?Q?yQ+WU8BIPOasTNJ3Co30tat8wHq7ees13LFh7/TFfFnLc4kM51nOSPvMDyRj?=
 =?us-ascii?Q?Oz4cBV+zWcvXOY7laTZ1cw8PRxgWim9LwwGDUnAw+61inXMJcPKJFwqi/Dsp?=
 =?us-ascii?Q?iO5a/5lRCbi0PwDSuk7KkT0f/VxnPTJF5fH5hYG9sEpZgpgg32Dg+nso/AvD?=
 =?us-ascii?Q?/Qv9EUiKbozxilh59ellzeUvZ9txFYKDVidKaivlcG9D4zRc9O1Lih7zrgoe?=
 =?us-ascii?Q?dFWSMuh7DmmYyJIASSRkYDTJm2/heT67EGeh06RUz9y0kSpuVUoMfyixnbFo?=
 =?us-ascii?Q?qgNJPulSS5ZgZslIhC0yFMh2P7zEVSYpfVIUQUw4l3rLBuqjuYcm9lghfHwv?=
 =?us-ascii?Q?atM5hRptH/TKlufUBiobOPMRO4WLcupshEfSzSDV92HZLXwiMgKizOjKGJKW?=
 =?us-ascii?Q?C5qBNC/NbJYDwTYGCecEAdD5wPDj0mTCn59/aWw6umomdsVSNx8puxvZ1m1p?=
 =?us-ascii?Q?ZSJ8X6Q8LFHq8TjQPIiOsSzDUnUeqrII68s1hgQPT8Ye8MC/tMrirZjaQ+2W?=
 =?us-ascii?Q?CFiHrBHFiT73a0zUrp2KtOYZA/JEA7nAy8nUUEh18i9YXuauQwXZGEerbCFP?=
 =?us-ascii?Q?nT8MxrbAoYGbHMCB21XZcZtbQdGZ7G6OEBTPHnoIcEidr18RVkIhnu0GZB/b?=
 =?us-ascii?Q?uqE4f/thAIMAUzd+CRhigZ3gPUELrgVJpmmEkXMJUlgicIHADwlJDQaOvump?=
 =?us-ascii?Q?XY3qz7XZJjpImSypfZ3025Q+V3VccBtctHipCab/29f/PATn7FMkXzvHPeCc?=
 =?us-ascii?Q?eFydDLudKfGD18+SxWx+cLCNLjdjuRykVmvoYGblT0TgQnYCGMdx1afR1rAE?=
 =?us-ascii?Q?pyz730NUe27sf/r2eNrdWstkxeD3E+nDbOw+uQGpruvQ6Jy8xloj15Cy9HfT?=
 =?us-ascii?Q?OrbsolpGzEsW7EonuPo+XX2IJpSXS4ggXFIwz0gTfvr4zPlsHXnenQIQiEu6?=
 =?us-ascii?Q?EId6xiiTk8EjpryPDduBJn73C8fB86N4pRIVyR2iNd0gJG8D9e34+ufpANkh?=
 =?us-ascii?Q?0ZovnWwAZEYKSmNbPLCnH2AXREP4Y6wFbd9Su/dawOMOUPEqjxMP6CY49jYJ?=
 =?us-ascii?Q?b8p7XCA//DueFiw3KMHslgKO5CV4jv60e19+N/8n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c29516-b4b3-484d-1fb8-08dc5863b444
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 07:07:22.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJXhFT0aomHbnaqQWCK1+92khZIzD8YlgaT29Q5CxmmooBUaUuBuqwt62my8dhPxtzsv+qiQP8MZCgUX2uAu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7848
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, April 9, 2024 1:39 AM
>=20
> Hi Jacob,
>=20
> On Mon, 8 Apr 2024 09:05:56 -0700, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
>=20
> > Hi Kevin,
> >
> > On Mon, 8 Apr 2024 08:48:54 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Thursday, April 4, 2024 7:46 AM
> > > >
> > > > @@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iommu
> > > > *iommu)
> > > >  			iommu->pr_irq =3D 0;
> > > >  		}
> > > >  		free_irq(iommu->fault_irq, iommu);
> > > > -		dmar_free_hwirq(iommu->fault_irq);
> > >
> > > You still want to free the vector for the iommu which first gets the
> > > vector allocated.
> > >
> > I think we always want to keep this vector since the system always need=
s
> > one vector to share. We will never offline all the IOMMUs, right?

Not about offline. Just about the common rule of cleaning up a resource
when all of its users are destroyed.

> > > > +
> > > > +	/*
> > > > +	 * Only the owner IOMMU of the shared IRQ has its fault event
> > > > +	 * interrupt unmasked after request_irq(), the rest are
> > > > explicitly
> > > > +	 * unmasked.
> > > > +	 */
> > > > +	if (!(iommu->flags & VTD_FLAG_FAULT_IRQ_OWNER))
> > > > +		dmar_fault_irq_unmask(iommu);
> > > > +
> > >
> > > em there is a problem in dmar_msi_mask() and dmar_msi_mask()
> > > which only touches the owner IOMMU. With this shared vector
> > > approach we should mask/unmask all IOMMU's together.
> > I thought about this as well, in addition to fault_irq,
> > dmar_msi_mask/unmask() are used for other DMAR irqs, page request and
> > perfmon. So we need a special case for fault_irq there, it is not prett=
y.

yes, that is the part which I don't really like.

> >
> > I added a special case here in this patch, thinking we never mask the
> > fault_irq since we need to cover the lifetime of the system. I have loo=
ked
> > at:
> > 1.IOMMU suspend/resume, no mask/unmask
> Actually, we do call mask/unmask in suspend/unmask noirq phase.
> And DMAR-MSI chip has IRQCHIP_SKIP_SET_WAKE flag.
>=20
> So you are right, I am missing this case where non-owner IOMMU's fault_ir=
qs
> are not masked/unmasked.
>=20

and it's not good to code a mask/unmask callback upon fixed assumptions
on when irq core may call mask/unmask as the latter part can change=20
w/o noting the broken assumption in such callback.

