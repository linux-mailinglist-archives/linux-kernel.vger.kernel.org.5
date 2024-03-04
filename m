Return-Path: <linux-kernel+bounces-90152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E486FB18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251AA28145C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE91643E;
	Mon,  4 Mar 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/mvkUay"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1F14AAE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538513; cv=fail; b=SgoqbG595D1viJI0wXFYc12OJvXs6sxV9CzLOUI9pyA4FD5gQnXQU00pex3hDyreUFRWjpW1havlA3EIX9x1r2i7yDNpg/JlX8zKaxlKFI3QcUmyTnzt+v3w7Dh6v1I/KtHJoUV7x4/KMNVzh1tAXyO0FJ5KpAEf1pBnJNHkTjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538513; c=relaxed/simple;
	bh=ltL53LWF4xYt0MN1u4GU07/Ls2hrU8pz1APGoyQZrW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zifz04q5ORIWpsd8jNxmQYHEf8ROWVfhXI297kzXwHVb55URrHlZ3XnyTD+IB2ddJ/5lDJ+Cc5uochBSlm3MrJrSxkT47QII/hZSAgQc5KutJOAPGGGquESC3v89HSUv7j0yRgD0Avg9fy/Brf+dlGC/SBSTBOsE1E4zBkBxsNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/mvkUay; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709538512; x=1741074512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ltL53LWF4xYt0MN1u4GU07/Ls2hrU8pz1APGoyQZrW0=;
  b=Y/mvkUaySS40xVEZN1vXep0UqhdCtQ3HSn+r3LxsMPD132k+d/j3SaHI
   35vwoFNx5ISzNvvFWICUYBaAgPOo6quxoC0ceJdH85P601M4PA6v6h7Pd
   npeUykGq0aSCFDXyHPrK2k7rooXAjjoaWWUz5sBx+9xJ7jLCt075Hw/rT
   6XsHnA8tRLteF8SSDp1QrI+ZL/d9uy5LkOQ60fDxnsCxthpEv8K38nopf
   w83EWP8au8oI8zLjTM4sTonSGugWMzxOGmooO2wAJtJt26BCbWPB0RdU7
   JNQIqO7kvm4Ibp0oz+Du0TK3Q/2krbTyqtHJJnEPucmABzlGyaHQMSE9F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14658096"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14658096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9471731"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 23:48:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 23:48:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 23:48:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 23:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz2GE5OZgZkp1D5L7bdXlij5Fvj+/ySE7JZxkE/fLNayQCY6orMPk615Hv4wmAT8P8fKNK1QkRg6ZbymTu1QB+JgWi1F90eBuqKJvigsPuv4KJAthUj8rrccaMs9+cENySK5GE/WVJQu2Kr9fmjqZKMxN8yPZASoaYxY7Hvd4lDy4UP7M3JpJnWYg6bbeXNOyzpz6tnYNQaxJNNx2or+dntXLilxWZuoDq//4NaN4wByqvUcJ5jJHFRNbDs2fXYOufznG/VM3jmyPe2W4JAHilXBq8x+F00urtnUpMuGTkhNmKbXaPgdBr6N+lUzCM4gDgaf93F0flTdJn5soB/v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBHUZwjlnI5HjPs+K+1iPq64hUn/ZGqbW6JjXG6AF6s=;
 b=W5pdEw09JI0QzjSTHs4Eb3n8QNDO3w7s5bPdxkd/VpEsuK4P3oh/i4VShSLbYgZo0opKzUmiAFXTTxqQw6saZW9k6GU1mOEL+23KLyPMhSRibAkF9GjvdeQ2rA67HamrxA+LAsVdxDYzK1ppUZSeH070roPvJObDHw2trL2E6a5Lk3l1YMWV2acMhPMx6oFt2fG5GElfYVydyopbPwCH/1zWG2UXOIM3wsZJY/+hjNDYAcgufc8E6MWW6ajfeNnT3UDaIeW4IxulPbNl/OvmY4ojMJq3Jqw78KtFJB4SMUXUyQuGORkDM7xQPFhOZ/cseCny50u/Z2PYyPD0CAMLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 07:48:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 07:48:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Topic: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Index: AQHaavVCLTBatnZFXkG2swhnu2ybRrEnN6mA
Date: Mon, 4 Mar 2024 07:48:27 +0000
Message-ID: <BN9PR11MB52762BCC8AC154A601B6EBCA8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240229094804.121610-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: 37d0ecc6-11fd-42c3-9f55-08dc3c1f7a92
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKRnDjxv8CRVz/XMgUgiSqIaqhYFcoefiHKAgus3tLwwljKhte4Z5U1vusCuceDiNluhvtB+EGSOFereuzJ45q/KrmwZOvYzgfAMigc7s6bPOok+c7u19emROIc4m3/cj4TFmfABhojAzkdFVmSqhPjNmvxRUS22c35ImJ3lTWtmOu5JpZ3emvrJywVmsNVgDjo2gmDwTH+OBLtR2xvxSHsb+ES/uuO93mVv+xX/m0VCTGx3ApG/2iyCps2OC1xOAK6w8eyiRw4OZxaVKoISekJDBKwhi+XkFW2p56FAg0Av9YjVrcZ7GAIfvBYshQPyp9c95ID1ToaSYJg9l65Ok6+DeP0RDovJjC8yQ+A+8zIrwkoee9lK9smTEBd3GJ102EVXWr7iRjsEllJ43O2jpw7hbabRGuzC6+NlD7Pm/6xahLJwq99Z9oebRHpQB8KayBObPegXwQz/fnjg37g6MWz40sTQug+CobgSkPYxAbKYQcz/1/1LchujWZ7iVdFf+4woG1lv6/619yP71Fp9Sqx3qe7v9iGnTCfCP9d0Lyv9x5jZo/n0Ll9HMpILmRNNCFoR3pvTDY5B3wXpK5cgxTuJVtF4hCAlmqKbTC5rQwaieThH9qZFIB0zT8WegXtBAI3Wt4nFMzSrltqYofQonwzHELiGOyq+SJwxX52KyTZbL87RfkYyfhJdcgBEzTOM/mEACVC9F7U5kQtUlWH36w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fN6J34d8K7vLHnkRYCLDW5gqQF/GX7EJbjFJTQHxToRRttuXKzIiC4QZfbws?=
 =?us-ascii?Q?5Qhh8uQKFkRo6CrZrZjdMw7GGhMl6q5TtJyHhPsss+y/cLYklOIiYynzkZzl?=
 =?us-ascii?Q?ClerUETj69Q8s1TGkv5NLAcPig1nSsz7cW76l2FrYK61vvoJCbSnmCO7pWEl?=
 =?us-ascii?Q?mZfwEHPoljMcwwJBHoOWmpdaKQOnrh3bPyRD7RvZpMRTGNa3ArSaxQBlBwF6?=
 =?us-ascii?Q?qRzFiQu/UEIVDcy0TOHrVn+6E6nElERLD1FI1vDYy5vyezWCP3b+pwbEAfAc?=
 =?us-ascii?Q?s1wfsI1iGGrrmygb8fhu3ugqbF0MgbppPzGrTLzAkzOS6sZMH3FMhR2Gd2jl?=
 =?us-ascii?Q?i7FZw4LM9IfQDvjyqR+bpeOLZKxNf3yibZ+irTc532VZg1Sqp1Z680RSnOS0?=
 =?us-ascii?Q?7lW/1F+mRoPEDxKmx62loXTtC6vrqSRg9/iJEjlgJ2i5XcDHaFP2/Xal2San?=
 =?us-ascii?Q?a1sHpVzS2W/Zz01v0rH0oQ8ftG0WyZmiq9LN3EPhXMC2nJaVaiFDsXxdnFhy?=
 =?us-ascii?Q?pNLPOO6swe8yB2pgj/njbdaC/Fbw/4fAQJgbceJVzbVXMPlO0sjdmNrmPGDT?=
 =?us-ascii?Q?yxKqt9HxBnbURYQT79orbPzB2YDRJR00tK2Qkn6MZ1RSn5f6g+FD5nibccKd?=
 =?us-ascii?Q?/UpryfHJLr2BTuQXY56BZEAuRhzUylgbDbFMb099fjsPOZwe0FDQxe3yivpm?=
 =?us-ascii?Q?KrlmSMezxW+AfSOX92w+NL9F9AXuHjAF73664Jeu3hGDubI2Jr5n6Zi1BCj2?=
 =?us-ascii?Q?FZHl8OVPIJ/XKFp16pdZ03qQd+x/yqIDPbG9SHjYikbNhkKGcxs0bc8hyPHg?=
 =?us-ascii?Q?sCQBh8YpeGIPSyTGkoaSUVMqEYRBMqRUZFMpxiPJQWzCo+z+gq7MTh9vvU2S?=
 =?us-ascii?Q?w5QnF4nIEucdZLNzQt4NuD+UsHLBjmdTd2uMMZqQEN+10ZxPpVzdKihNeNxD?=
 =?us-ascii?Q?lqeK1yATJ/m8cW7jRYQuWgqvzKW6xufLZ4xWgYbV4OIrCo3dnKI+SeV1LZSV?=
 =?us-ascii?Q?nS7epv/Fvgtoh4bxNrIFGMvVrWP6gVBZUQH9+TYGjx/eew7jhvZpw5g5Plrm?=
 =?us-ascii?Q?L9L83FgvviW/RT+j87I2qL4qWErAKU6Qp7lneLbNti6wNatvRpHdv+zryJG0?=
 =?us-ascii?Q?uN2kl68PX1z7n1DA0ya8E9EhiKgwo1JLq9Y3Wh+tqYfG5d79ayZuJPxo+fGo?=
 =?us-ascii?Q?PYg4+xQEhyWTC8e2U4X6UWHtXfYrmCYu/huSuVig742URp7Rd0SlAT7RNtBg?=
 =?us-ascii?Q?8Co5eQGUrEGylqEgvOeiDxMoVa7IFwBUa+OX5UvRPHzwQsBc0BjHdSeizx13?=
 =?us-ascii?Q?DMhztXRrisJTAf5dbSzlbwwLrV/eTC5Aje4sCf951yUp+qVyiXTzWJ+N4JQh?=
 =?us-ascii?Q?Y66IYAdPuIBp39WNGF5RM6ZkDqIOUYaWZi9cmU3m2L6BwlNHMJOxNhSjf6Ot?=
 =?us-ascii?Q?GnAA7f3sXVsoMUJUu/8VTYAi0MoAnDWOMDokbCldhkARkegdk1TfwxBiBpy0?=
 =?us-ascii?Q?bDRLirN+cpM0dsTKnfI4mBLRBG+ZOiyaTU0x3mX0GIIaC18QCd4o8dpYsZbH?=
 =?us-ascii?Q?IzM2/ejM1k0UA/P8eJtFBSssKFt3EX1dDQSgu+ug?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d0ecc6-11fd-42c3-9f55-08dc3c1f7a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:48:27.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyHYHXOT9asseJ+rxl6XZ0CI4eEjxs0vHJ0fDsCr5xQjy0GDhSUuHLXUrRRraztejLK/j+AAevbpMQYRPlXKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, February 29, 2024 5:48 PM
>=20
> +static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn=
)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct context_entry *context;
> +
> +	spin_lock(&iommu->lock);
> +	context =3D iommu_context_addr(iommu, bus, devfn, true);
> +	if (!context) {
> +		spin_unlock(&iommu->lock);
> +		return -ENOMEM;
> +	}
> +
> +	if (context_present(context) && !context_copied(iommu, bus, devfn))
> {
> +		spin_unlock(&iommu->lock);
> +		return 0;
> +	}
> +
> +	/*
> +	 * For kdump case, at this point, the device is supposed to finish
> +	 * reset at its driver probe stage, so no in-flight DMA will exist,
> +	 * and we don't need to worry anymore hereafter.
> +	 */
> +	if (context_copied(iommu, bus, devfn)) {
> +		context_clear_entry(context);
> +		if (!ecap_coherent(iommu->ecap))
> +			clflush_cache_range(context, sizeof(*context));
> +		sm_context_flush_caches(dev);
> +		clear_context_copied(iommu, bus, devfn);
> +	}

it's unclear to me why this doesn't need refer to old did as done in the
existing code. If scalable mode makes any difference could you extend
the comment to explain so people can avoid similar confusion when
comparing the different paths between legacy and sm?

anyway it's kind of a semantics change probably worth a separate patch
to special case sm for bisect and then doing cleanup...


