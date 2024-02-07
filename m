Return-Path: <linux-kernel+bounces-56108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE584C609
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AE61F2215A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8F200C7;
	Wed,  7 Feb 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvDEuVih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643E208A0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293473; cv=fail; b=cpaSvfytK7BbXcu4yZhKGH+pe09U41znIHRSdvukQOaexl8jg3B3wSSQn+2vOgBKqtF4toX+gxAOIo4VkkDQTRloJ80p7wXfr11qlnSqvkgLhvpSiVYsjijuBKsMAcJAb+Y43YqtGbXuXflOUv6ZSQ7ImKjbFwNBYLLXzOpdHC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293473; c=relaxed/simple;
	bh=AwReVH9oFhHXyaXqGAnljqbs7aRGTDVXQNEyxRkJ9WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQuqngkjBckXn+HmPPEfvI2Yy3YjERpeet3dWr20Bhol8BEJUMrztrV96i4c1W9Sx+msfi05UhLSM+ezRWx91KDKyV8aqZdFYOl519LH4UAd7DZgwZswkTpSIpXJXEUurz7F0QzUYF0BrM99Qqols5PA3GwAGAeDeAPI0AwhLQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvDEuVih; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293472; x=1738829472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AwReVH9oFhHXyaXqGAnljqbs7aRGTDVXQNEyxRkJ9WM=;
  b=EvDEuVihZfxoWLrl927RieL3vphiQKRl66HvWAtDaFg1cz2EgUTRyguK
   n9vsuDa62ixKU8OLVq2zKDT/gTv/x8v3tL5V7vEt4jZqOdYfAM0+giBQU
   ERItXxWMMMbX5YO0ehnT4yzw3Fju2lrIVagUfo8DEsKP8a1q//rmwqG6L
   dEp2tO+GVB/3YdDonkKN9P2IoJxx2ubWPyjLJ7JSWtMcQDS7JJqQM8xp3
   FFIYW9PSv45tI9eSgn9kcJgjZVCPqnc2YO4qA5Gnme7lm0LkXrQbJWPdI
   XgLUXtT4Q6VVzo/Vz/wRRJBRnUYaj74SxuTUduXJ1m6+R88eM6ofYGCO2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4718580"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="4718580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1289383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 00:11:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 00:11:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 00:11:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 00:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKnQre+4uM4I2T5KbU/SbhoVPtcD7BrvhmKQE81DMwrzf2GkCJDV6S0iqBDDFLisWHjqFirFX/AYSN8mep0VHiZ/qCRAMt4xYlLoRGmMdWn5nI+HiIUSqsIoN1FtqzAx1Fwq07EP8+2wN1aLj3s40FnOZ0p99jDhiixBB1jlSUtVaCezEswtz2gTj5PLjqQv8omH+ePuB+uHBlMN8bjliMoLsFuKfB0x+q5ul1PqlZq8XrfGYkCNroYZpvEbRR7hnOww2MKbE2x9/NPlmC/YT4iNKopCc5JtdZ+GVLduJseCAAiWi+X139jK79ryOlTMEn1eh90RSNFLrCgf8QsJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hjVbVJ/lApkO3FXMc12HTc4Fj+ael7ECvi4//rq3GU=;
 b=EuPCpAag5SWq2b3I5uq2S88Ek23dPXE4IBxDIE/Re8pNqa4epdglNMcfEAcRAzB6o3RTOu5m8udq1NJNpNYZPnGhfUjChp1/VajJGOsIC9J8zSFyIwNJWChV9eyI7a4HsoHS+0BNDbwm8NIQtPkDlaWBdDOr6SnHXCGjdgxZ+Tsla43t6NKsqg91jUqImiyQtw6kjwaAEK7+/Jd3mLJLsLxMHefo3p/sAJQcNr1oAbZwQ2O1inJVUHdM6dC8SSbYgEMgfCVJhxT47de0CsflieQ+Jts5SGgYm4oX6/Aif92jrBv+2OVR2jFV5sgSaUy8ftz8Iqx+pzFdOKLi1uWuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 7 Feb
 2024 08:11:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 08:11:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Topic: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Index: AQHaTQbdnqiGZVOmpEOcHKLJUGm2irD+nkbw
Date: Wed, 7 Feb 2024 08:11:05 +0000
Message-ID: <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240122073903.24406-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: 3b0d8d6c-fbb2-474f-5109-08dc27b45566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhHCQ03yryKnRPU1mb8X9Fqy4/7e/szZ/ip1A8PLIfTuHagFE0Z8EpnBerj7aE9dB2G5Br6PGrf12EK7prP8iNuvrppFj9GQXj0hgSHsSyx/FhNikCc3B+nlb00rQvDhMVJ40tuNY4zRHWAbTd/1L8PCLrO09H0tXJwMG3McE7QhmWHpI6ngehrGvTFJPNXenD0/lFZMu1dw0YR8+WLsZULwWvseEQgtu3m8wld5O/VptCkKvF7GqjOnxHslj0sEocZ0+4dk0eVf6JPGXkkj3jlCF5O0Cb0RD/XCGpfbAGQIPOoYhMjUUXX3sYfJrzHBkv2MxbFABNcLEPHXbZ+r8nM9D88lRX5hwbLoH3hh+ZmWbdApS+ktnA05xgcxYstRS+Wqc2jnpFpYKdKDrmYwJUgHt2Vb4ph36QEH0QrPYHITD9AhZ6XWLHpXdK3wIGBD0U1MA5GhYcEi1ViWsJg+ZGIWSp876sddmkWQ+7h4BP5QbH5Wk9xiRE4Y5g8F2rFXnxIUr3PF9G80Qt4slxrIFN7miaFx7n1UgOwlI9R3q7NY8Ac6apLkMlXjy0sVWzQbebexyLwlVZ2Bsyr94H77e0F+S8XkuN4KUszWuRZ253jqMrsJ6OHn7DRc20UtMyKSwfhmlN81URijOiiF3I8GpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(478600001)(38100700002)(9686003)(6506007)(122000001)(5660300002)(66446008)(7416002)(41300700001)(4326008)(64756008)(66556008)(2906002)(110136005)(8676002)(66476007)(316002)(7696005)(71200400001)(76116006)(52536014)(54906003)(82960400001)(66946007)(38070700009)(921011)(8936002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NPE7zgStCTIbkzeBK6PvhTDqClTpJYyml0HhvgbV50cPSO36g9hhjCzgjVQ2?=
 =?us-ascii?Q?3r/WZUBi7IiAb9yWild6ijGjV6WDORMA9sVIsH7wdNorniS4YZGOLO1oKbIV?=
 =?us-ascii?Q?NFPJaxkYyOG/uZNngFjZ+joQ4pCrnpbxr4mY+Ynfyj3/8100bYn19VA6f0Ve?=
 =?us-ascii?Q?7zpDTgnsgPkJL0i1s+u3mmLaRQ2egKPNXlSm7GcXtNKuBY3fxo7ZcSFUPeu7?=
 =?us-ascii?Q?4ZZyFU8jwE/NTo+VVsr5vOJoJaZXQ4FMAGiC6dvjl+xXiZ6vz8EkKdfEW+WE?=
 =?us-ascii?Q?y8UWPVG/9ElmrWKXTcs5FbxGERXcSN0Ao3eaeTGYuiU2ShVPBKinbMvGARZg?=
 =?us-ascii?Q?bArcrRaGRo0GWwbZd6SNcGqEOqig53lgMVARu4mvW8aukBQTRwNRVjkvRCk+?=
 =?us-ascii?Q?SATMbEW9J9TKlNadL7PZWRLJohqQE65vX1/5wpqVYpiV28txXSbIdv9NPkdu?=
 =?us-ascii?Q?ZyNz2B5QRyvkXjMrjPfef5LDHCYPgm/EbFITTQASLPxBc3NNcB1IQmGaJHna?=
 =?us-ascii?Q?GwCnZqN5ccBQUqGbLCsjOWdO9qQ1AprK0HRYtWwGIgaRMFk78ZWIqmAqHQWT?=
 =?us-ascii?Q?2ON9Y754rvFQZmAel9mIhBf4e1A9nyQ3Z8jRWwI7bc+kZgeBCBDfU9ufzQ7Q?=
 =?us-ascii?Q?wzlWCJ12vQpzs5xJrGMS2sfA4LF1ZMDKdKFQfzzj1qF8zHrMP07uxac/26U+?=
 =?us-ascii?Q?XoxYyoHx1AR60vcU8T/GjQ83jai7wczuawbcXjyRVtRnbzqdLO6UPC0yaJhN?=
 =?us-ascii?Q?/o0zFeew3uVC/gB3EfFdKsnwKVHR//xUnxJK9FkzKFMISXIRtU26+Bm15zT4?=
 =?us-ascii?Q?LGTJkYdxfz+4cSgvH5hWNn1mY1wZ3SYMCPonUg50QNstnTnR4kFzuIr10lzj?=
 =?us-ascii?Q?kMPrJMpRNVXF9B6Dvk8swAbELonxf9Pu/g9uLgY+D1juP3RLqkJq43RBCHP9?=
 =?us-ascii?Q?AzVl0Q+TV6J91EnPDgLG9RhoKOzmZjuePJhcIweuDue9OVomG09iCe6uztDn?=
 =?us-ascii?Q?rDDKj2RFqrUfC7I6yTAL4stm0iDGXKrCew5AmauM7xDwmWW//rDH1nXVfFzI?=
 =?us-ascii?Q?2bJTlec/xkMCktk+OYncXTXVQEXXZA8ar3COfUwddHnLHQSHE5NpNlwG9hfD?=
 =?us-ascii?Q?HWjTLn0B80+EVL88zap/BFVxNdBL/8sizpN54zXIs9FQYz8se1OgQK6iOb+9?=
 =?us-ascii?Q?ywNeKGOW7rurLeVzynMxhI9JxWPd7wQYJC7fmYLOawKlspLx9brzZ6Igs/bp?=
 =?us-ascii?Q?DgOKCALX5/eIy0TG2vip4vtT6iyBz/oL0xOLlPQhvc3UofothMTuErB9xWI4?=
 =?us-ascii?Q?9LBW3R4GpMCIXBLTH9tHzIo5giwmuZkR6mS0G/UUAyW4akQ7DGNInf7EcPOz?=
 =?us-ascii?Q?FzQCbXR3qaHuiOS2Sc7CkDUFJwpAhV2fbUAUAjLk1fys8k3Fklx/x1P4aPSc?=
 =?us-ascii?Q?OupOg0OYeKT/I5TbesPkWJyzzE23M6hOv6X12hfuisUSJH+ThX1HjGv1HKm6?=
 =?us-ascii?Q?lUoCD8/IWA5AwEv+E66GqvefN4XlMYCh6F87nEsgjK8J2k+17BFOoROARSfN?=
 =?us-ascii?Q?lO/X3dcgLnuGRNmaAuEolwtQT8Y3Zpa+HGgKwRUR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0d8d6c-fbb2-474f-5109-08dc27b45566
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 08:11:05.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kFhTRgBkETJnqluWkoxKiMOkCw//eBpkJrg8T3Q+rPY+y4L9FIsg1EHwlSxQtA04Gmq89h2lPz2IMic1xb0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 22, 2024 3:39 PM
>=20
> There is a slight difference between iopf domains and non-iopf domains.
> In the latter, references to domains occur between attach and detach;
> While in the former, due to the existence of asynchronous iopf handling
> paths, references to the domain may occur after detach, which leads to
> potential UAF issues.

Does UAF still exist if iommu driver follows the guidance you just added
to iopf_queue_remove_device()?

it clearly says that the driver needs to disable IOMMU PRI reception,
remove device from iopf queue and disable PRI on the device.

presumably those are all about what needs to be done in the detach
operation. Then once detach completes there should be no more
reference to the domain from the iopf path?

>=20
> +struct iopf_attach_cookie {
> +	struct iommu_domain *domain;
> +	struct device *dev;
> +	unsigned int pasid;
> +	refcount_t users;
> +
> +	void *private;
> +	void (*release)(struct iopf_attach_cookie *cookie);
> +};

this cookie has nothing specific to iopf.

it may makes more sense to build a generic iommu_attach_device_cookie()
helper so the same object can be reused in future other usages too.

within iommu core it can check domain iopf handler and this generic cookie
to update iopf specific data e.g. the pasid_cookie xarray.

