Return-Path: <linux-kernel+bounces-32576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6939835D72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579A028838A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A736AEF;
	Mon, 22 Jan 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gas00LCs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220339AEB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913810; cv=fail; b=nbWOnWEQxQ9eS8RtAV68YWPiybKbD8d3xBps6MT/JqF9tGT87LL+DZ+L81LeTi4z7h4XphPvOc5iptayV/PFNSLaKzbHR31HcavthtRBq3xVnezZO5PSSgLgu6qGa9gK4XLFig5pQ/zIRo36w3F/XIaGQkXQabUezemZifS4xqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913810; c=relaxed/simple;
	bh=WH24CiMFkL7cCx/sbUYz5uPMtUH1fXWPAYs1os+8UGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/ZT2f6tud4YEnft1CZuug0/we+mT00OPwiVyvrrh9wvs0MAWufJ623dAEhehbUWKasFAIA5jQDWd/AevA4y3sj1+LsNJDH03OfomgU6ZpYOCA6erZeeaWF6HhtO2ofMwrrTRNOTVFNHS9dZVV0Dbw2erd6MCkJv1XrT86cq7v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gas00LCs; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705913809; x=1737449809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WH24CiMFkL7cCx/sbUYz5uPMtUH1fXWPAYs1os+8UGk=;
  b=Gas00LCsH6nwvHH7FViwwFCSJfJSE9TSsekVfqleHuJK53IF8uKDzAR/
   xRJMN1k5uXPTUwBLrfgQoMKQmZVskAkfxPblii9XqigzBPjz1A2TANu2Y
   838ew0CCXl6aYxzkl4JnvKwKYNCAXy0yH3TcTBXh/xBjJQj+QFJZXSiCu
   3d8oIv8wNeUXKoe2S9XWBEjmU/PBN6wo8WjYdTmM9QEWDJ2Y00/dpnTOu
   hJY53O9AGiW5zLDblpJm5uI6mP/F+GFlCSkw5C+ScgbuuMuAEpcifk2d1
   L+UAGvRXlBh1rkZRbd6zXGAInNrV2tCy1vTOLjIVTEOIOwKqqKp414m0s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14657795"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14657795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="819611916"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819611916"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:56:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:56:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:56:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOdt6xiZeYYOY7E9+qA5uSQPNeEFIi8qYq1GnbtrCk8YwZCnTUoGE2zrCyCvzUOsgk3CubasEh/zTkrYtVIYx+nEZ1RcQgMP+lF/kID6k/ftwy6VC0D6t4zLROYyuPsGM4qE1XTVH16Y5KqfhlS+nOGIkilz85wef1Xmwjk2BR31TWPx1GXln4cKhIcwXzM+8Nu18tW3vz9lSUBV53DgS6KYViNzPFQogFTMoBAXAnUdXTFXqKUQzhqnw2u/xgD10MT4p0qeB7jI0pCmlGCgMx3Ri/Z1bMiBSW2Yq6TxtYilbUhOq13RKSbbIRMyCJwK+WX96lg93ziDwtxqT/+t8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3141YD3ZgUI+pM1hOOqvFcT9l5ybI5ZIGvQTIfaENs=;
 b=SIV3uoyGM7u5MmefJwqLfG86FpUSFZJ99MxgClL6OSRLsBAa2llL5X2ioTXmwI+kSdW+zbW4kYa2gihkb+tRdaPuBl/JvQKMjPp7eHj2CbLwzyMonATcLly6CyEjEQPNssu7N2zfQo0m2VymihvwgsRDsTfYGnjh+HPDwT0F0+ivpkHS1o0y8QWAxtxqbactocrjjCTH+rq83/iPaF9DT+7Sv6fVLgHV/QdWDO3fbq2aCWTVpmMmnqoWm5usKCej7xPmxYbRl67mRERSry907sSzaOVlqzkkVYfKW/NBlvXHxtrjcIwpCDr3/PfJqM047LCe//7p+F0O1gt8HJ07Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Mon, 22 Jan
 2024 08:56:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:56:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>, "pandoh@google.com"
	<pandoh@google.com>, "loganodell@google.com" <loganodell@google.com>
Subject: RE: [RFCv2 PATCH 7/7] iommu/amd: Add nested domain attach/detach
 support
Thread-Topic: [RFCv2 PATCH 7/7] iommu/amd: Add nested domain attach/detach
 support
Thread-Index: AQHaROtVodYZMiVm00Kzjdh2D7R/jrDllsug
Date: Mon, 22 Jan 2024 08:56:42 +0000
Message-ID: <BN9PR11MB52769DA43BC124BF3ED255018C752@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-8-suravee.suthikulpanit@amd.com>
In-Reply-To: <20240112000646.98001-8-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 3b42cc99-6a8b-4690-451e-08dc1b280e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvci8RCQA4dt614AGiPZNobOOmIZ3c7Ooj7r5ghOw+ysvtJUfvavDH7uB1L2VbztE+5G3iM8/e9Bg2Xiy3lKsx3iKn+m+uZGoKX7/VijUUM5YEHvSZdsa5hjoQOqIm5Kf9FNLsbwnw1Q6EyKUsEOoyzV4O5xGz5lKYlaRyljFe8wzkVLSYKFVYk9BV/YUgZcOmFWbFBQybqUHaUE+SONujWOwpDslDvSFWDes7J2pb4q6QSyZQdCCTmv9jlHpK8eGONDGIuJgnpp79ihTQOb6tK5bUXkN8GRHGsFZg8TZYh6PP82k5m7w3slT6s0qJfXmsBgH+zWALNUuQGou3ZGbzey9bD41ekp67E6AhCc4UirkKtIFdIDye0eVF4z7leoT+kdrN8UGpQkQcXc5BiTigXqjiMDkLQ50oe6rVcbctUQZXgN9EJmC8EYnxxKhyMnRMQJm/ttW2UlQq0OmlsV/tGRQlRWLJAY8MCboRCyhfXbee8a5k42p+5+gw3np0E3TuFjnAnCHfTbwTcdnMLjVqATxmsszBkM8eTyqDaGOJURnZXd3Gd+/GaEANKsXZ9qJGf+pSJwCDX2xWgFBR5IkStrNzfZOPc7rffOURNpep/jD3Ef6fTeKpCDU1CFp2m+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(38100700002)(71200400001)(26005)(5660300002)(122000001)(8936002)(4326008)(8676002)(4744005)(6506007)(52536014)(41300700001)(2906002)(66556008)(7416002)(7696005)(66446008)(66476007)(9686003)(54906003)(316002)(110136005)(66946007)(76116006)(64756008)(86362001)(82960400001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LKxIMlPFwR/G9qwqz1u5kOLF5A3OFpIh4pDk11soAGq0cpKgRef9JNFP3z9m?=
 =?us-ascii?Q?Jy2dr9mK2SKdKj3Dw6sbPIKMT/V3G3r4mk3gPDmLlMTMnp1bw1ItmTQRNyyv?=
 =?us-ascii?Q?yicXdnnq/hLJvkS/i+ZBzWXSi0yA5k1FVGGoAEL5OgB2j06J2DzDMbBpyfGC?=
 =?us-ascii?Q?96DnL8ouTShLv4V0VAIW9M6FzuONfHfEOzlKfrMdzApZqjaip68kmxJKR5NZ?=
 =?us-ascii?Q?qOKafqUPQgQZEEh+2K6eJBedatTiNRXty2XEGnNL/HYkdyn/1wptsqw41qvr?=
 =?us-ascii?Q?Q9hrrMnNRW8TnwqBmsSSXmXMgZy3M2eFxcmFUYvyS4dOq93u8+kLKS1pRSWO?=
 =?us-ascii?Q?oNsiKZNxWJ8CWrTNeplxEo8FXHS5WXa+0KbkCSdH1vaKocGoaXO7vu3ukKcS?=
 =?us-ascii?Q?I1DjAKmkblwJym94JQbfqa58+0RlEpK1cjrBsjKK23AW86/Ot4zMePS+BOaP?=
 =?us-ascii?Q?AT39U9+MG0WkFF2xDozQBNrSC8XzkbCnVZUHPaZIlBNqnPxP25fQJeiiyyXm?=
 =?us-ascii?Q?g9xNA1y6DfUKYPe5FdssqGBvwyYOLUMhsC77TjZH3rKXbPuGsrZ+++PavKV/?=
 =?us-ascii?Q?kU/SbiZTeb3D8iPbm1zL/UJoJ7NhT9DQsBmdguBV9BTPjMJPUW0JW4yGlLDd?=
 =?us-ascii?Q?3/jBCXEIu8uhiTqqHyHuhXDGfvaeuKiq5oeFo1AOF2NpG9Ck0H9oy4/rsVdz?=
 =?us-ascii?Q?yv+Y88xT5tLholXTJCHTnN+lViJQXdISqUQeCHkqmVg59CVeEhJ+nk4oDSSD?=
 =?us-ascii?Q?Vd1qji6/MWOuCUZF47qK1CPvZEh9UvlxL8tsMrKUboGpr+kb8Dfa9z1fmfLX?=
 =?us-ascii?Q?aXKneWyqJ5lptxUw+dPbbSYIfpKNVhD7NFmeE6S7jyqeHFERBcabV2N3u8pZ?=
 =?us-ascii?Q?5sToNzbs6n4AJ4hPoB2WnCN922SLHDLmmFs+jCmu1mdD/Sqszk8AUdB7UAYT?=
 =?us-ascii?Q?lo+z86JS1E90XBhyy4e5zK5V3j+Ag0jU3VI7HHnzzCMY7WxrsivbtR/LGbDl?=
 =?us-ascii?Q?Uk9Nrv78aKBGBKaRyOuzETyQfW4zyGZBkhUgJc9ucEXqVoc03nl2sj6BmYEc?=
 =?us-ascii?Q?5shBebNvToJ9PT+Ff1WsLebBEzWC3F5NH7GzMll680zPyAa+IuxbySxXCfyp?=
 =?us-ascii?Q?p8grewPgjjFdWBiWck2z7VOi+BOGCHKi1bUK0ZS0Y7ruuEDTewsl81NuotRC?=
 =?us-ascii?Q?ZSkDw6PdlK8rj0epYKsidIFE6QiZXt6FafQ8Z3+XRVgktOgwe9gzCdZqjgrf?=
 =?us-ascii?Q?5pQLtVYcaj/TEJKFixNQhTz7p9yK16gYvlrqT6uhDSfGEFf3UxJujickm0zM?=
 =?us-ascii?Q?s3cZf9uSQVPoeRB5IQzD+8uJeZBvFt0rgspIVBLe3+p6fLdgcksBqRzSGIqI?=
 =?us-ascii?Q?MrBAdlDvXV5j6HxQf9BF8dUb0oITHt6I+Q7MTi5mb8AJoJi5OOV1ksusYPol?=
 =?us-ascii?Q?90OnxZKgPdPwjB1DIml+ZSaIAn1bnRKhWNjgmkKxzFbZZRGLo0TCqqeOfz0A?=
 =?us-ascii?Q?thqu9VbqNIY8x4aElykIJ78y/Nc6uWeLPDaP0GJeDVm9QfGrBXxMRdVF+7wG?=
 =?us-ascii?Q?ivAeO7WHhUSSIg5ZBUUuBobJdUA2X7z9xuDGEfOm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b42cc99-6a8b-4690-451e-08dc1b280e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:56:42.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otW3hFIoT2SXxBwgzYF7cP4zzVoE5JFFKQCwm9+ExuOYDj3eNcu4almaLbD2h5BFVjdvOcJ8kslSCpqaREby9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, January 12, 2024 8:07 AM
>=20
>=20
> -	/* Use system default */
> -	tmp =3D amd_iommu_gpt_level;
> +	if (amd_iommu_domain_is_nested(pdom)) {
> +		/*
> +		 * For nested domain, guest provide guest-paging mode.
> +		 * We need to check host capability before setting the mode.
> +		 */
> +		tmp =3D pdom->guest_paging_mode;
> +		if (tmp > amd_iommu_gpt_level) {
> +			pr_err("Cannot support Guest paging mode=3D%#x
> (dom_id=3D%#x).\n",
> +			       pdom->guest_paging_mode, pdom->id);
> +			tmp =3D amd_iommu_gpt_level;
> +		}

why not returning error to the caller

