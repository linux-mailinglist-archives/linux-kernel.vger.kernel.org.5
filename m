Return-Path: <linux-kernel+bounces-521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A689814268
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD91C1F2359E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC03D2FA;
	Fri, 15 Dec 2023 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPXZ308J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E510783
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702625537; x=1734161537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lJmClAlMt5MGVpChqZB0GeIavcs3avran10UsmB9KmQ=;
  b=WPXZ308Jan60AizaKxZkcUm/HXjIOjNhPuvpNoO50SxdVVinwz9YN82R
   2MrzJrzd/dmwfSlHkTs59yN4ohiSgvJjruTiHYbf7EeS26M7SF0EI/h7b
   8i/EB8vetXSuQBdahbzOHZrFU2IgzUr3WUnujx7tkbbcVa7HgWzXfwIKB
   IxYyKoe2oyJH1hiAWEWq4Y/ts/6UOtOHGbxAhy8beyPympA6yw15IYgcX
   S9jmHKN8WADMNRfsspYQT8ae8xaTgkn1Z/q5lNPZsVsZNLk+r5yRebyx7
   H0WA8aE3g96WOzx4Pwk/oFmUKKE85onQ0HA5YlTMhG8eL0IgUSmyEo8d5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394983163"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="394983163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947869155"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="947869155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 23:32:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:32:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 23:32:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 23:32:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e62gKueG3hQdO/Z7iyDHOinTvlO63L6I/C6fSholL2FRtwUBny3OXWWTlmwPm3eAp1d2MSuPsfFLsWrXpkOhbw2YwI7EXgMx93omJ8QOhC6d//y/3RG5ymXVa84L+Oj2JtTECLUnpWxiVhjmL2eI2Q3FzJ946oT1IwIOMS+isaQ5kbWOyZyT/dGri2sHmevS1/5lHheHNj9Ul/J7uPYwQTqLfUChX8blAzXgwphwEMaWQ70ZtR7FTJVudf4jbaosWKYhulCPZOmR2ZojjMLdXK+jHGNdvEqbxnQF7rFUjy2ZCp8SJ9y85+3PmltrQpLIttUrqofjNOHRTvKzCgHwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X/AO8t7PcuUJSXhFUWD3z/uHk9UfINscT7IYe+2fRE=;
 b=HdlJEO+WbEYMwdHIrMoC3Pkkrzrgq3YUVMPaMFw2hpPMjYixUxwmJvFMyXHdm1zNvm1NkawIeLIIc97VDsG8AqQBq3sWB+ufp289/eI6t8NbAd9A58LPCOxvga9Jh3Rrz+groARJGEUVxPiYgWFpNuCctM5ZLr+qIJDulZPLIaoVbUDtDHdB+JOCZcPmUgM/qB6BXBWgk81d1HSMq9jN8p/BcFpbzcX0ObMfihV2PrE9kp2q3e+Aswp6kLvpg0tv4pYSx9Tz5SXNYvi90VuCu1jYWf48ArlQap732X7+YKqAieaJUziq9bsXr8Dyxm7Nq8wguWbQk7FEpK7z1kdHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:32:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:32:08 +0000
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
Subject: RE: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu
 capability query
Thread-Topic: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu
 capability query
Thread-Index: AQHaLRSbpYfs7aIYn063qqpxjr0tnLCp9wSw
Date: Fri, 15 Dec 2023 07:32:08 +0000
Message-ID: <BN9PR11MB52767952B60E86FD6C93CB1D8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
In-Reply-To: <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 078349cc-0eff-4229-4544-08dbfd3ff1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxlKbmx+c09t4H5J1FLUBC68kkrp6+hPpSVpjS7x/9U+4PQvLed9FSHXbc4qdsTFyhuK5wkG2eItxGGvGilVGdlB5h4uWXxR3D5gUcYJnpI64XstttGzUWsqX3iE05YaXIYpb5SitaQmnoJX6eSasmu4Ur5ICpPvIL5EuZN5v/2stFU4ilk84qzyb9fDyPCxeXe2o3JSy1+5VN8CKv9hVeKXWwf6aH8PatpnkmnlhqkWZOXrInLJEDdJR/q75oNxksn640JJ+8ziY6WJ6RwdOt8qsJw2Lca69GlJAXXCv2+hF+Uk46ODOC5J/ozx0pyynuZTHUQ97FQ2d9IWz+G7vdTnsQRJN32w3NYb0L735eQQO8gDyCyH19WuvrPlHAP/rZ6uNWq7v4X0X+8uJlxVR2OPEHL5rk5l4ko3BZmG5uwezfcdKFTZFYmbM+yuGarbRGTlJchvRB31hlzZaufryUM7A0e9WqwYSMIN5dtHDQUBUOTzoAoGhU0tN9NI3fEfkd4spynxc4SdNhdfsLZZIfzzmCMNJfXMcjcQIFB5YZUyz1QV1OznTUhibmplDR/f89udM7jMRY4cHpeAGm95QXdQGXcLyKfTsiY9cEGR7aGNBxtwp1m0j0/YGSRCznRa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(86362001)(82960400001)(38070700009)(55016003)(6506007)(478600001)(7696005)(26005)(71200400001)(66556008)(64756008)(52536014)(4326008)(54906003)(76116006)(110136005)(66946007)(66446008)(66476007)(9686003)(316002)(8936002)(8676002)(41300700001)(33656002)(5660300002)(7416002)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LcClQmm4JgHfEW6RplTO12827tGaxqbNR87azYcxNgcrzSoHe+A+qSZz7Dx3?=
 =?us-ascii?Q?66up+k70c9zttFj167ihfXwzVqn+KOhCN8QCxTwaWx61m1wKik93lsgFvZYK?=
 =?us-ascii?Q?1lZUhCXLGJqN5hJ3QOpkzl50GayYrBHlhppF8+Z9Jit/BT/x2fy1Npso9eJZ?=
 =?us-ascii?Q?M+74W7jLtMcaX4fd/yc6WuzZC1lUgxTPto69reQOOFEKge8k8HDrOn/FrjOy?=
 =?us-ascii?Q?qMexIrqWynmteB9OsAp857aBNRb+0H7wIMNeSHp3BIwvBDRkhXTpsNd6AhF6?=
 =?us-ascii?Q?3SkH6JUJUeL8GfZgw1iySD9750AO65wMNeTXUf2UlKrIjgYHGTH8Eh9WghCZ?=
 =?us-ascii?Q?euFNLxqSB5m9Zje8j0RwCN+8W3aa5d3gdtePp7YwPYb+/g7hA/Xl/Iixhtf4?=
 =?us-ascii?Q?aeL1D3/Ff7MUmk6nxdIT5FN9m+l+ybTa9WA0ou8vGZw6hysAZ7WGitaeHqJ0?=
 =?us-ascii?Q?ejldjhBQuiavLtF5Vj+AECKOug4b70Hc8lhqLgwjA9BOcZaUtJ3r6cUHhHoC?=
 =?us-ascii?Q?0NaM0cSoFcBSsf+8q6PNCSozA6+Tyuk0HODiz5O4gjIf/ztMzCWhb3aV6OTP?=
 =?us-ascii?Q?8CHx1Q6dHGjsqL6ik6ta9yhYm//6yMsdwIQ/S+MpLWOZjLAPNzNm9m70C4Nk?=
 =?us-ascii?Q?M8GPINppCMPje0M2O0amqcgenBGxCSyJ0IgnDxGHM69xBfW9ChPXEuiIDqnT?=
 =?us-ascii?Q?lFinfvWKNzp4XMO4Pxfg3zitVl4yaFrdDxeCUOg2+rDaA+3ed7Ue96csak/+?=
 =?us-ascii?Q?WLsPOLmoKjyCQaylJq0ZrJtgOxF80B9K/JVK4I+DnZBkN3LJlEPIaNnhGCj1?=
 =?us-ascii?Q?kQWxZ5x2VGptPG4OFIuxoKun2krFRNLhSenDyqhWXPzuIcerWpVtGI3oXQm0?=
 =?us-ascii?Q?kF7E0gk7PJo6KlKJkgRGOXAoMZUGh7W8Zv3vzmCXFQwlr8ThCO5CbXvxg3Oj?=
 =?us-ascii?Q?XGr13CS+HV0gp3zXQHe/bkikp1F4e+CP/jQpFLTO3dMwIW3EFGPw4HeMV1Yk?=
 =?us-ascii?Q?7B8+vF3FRV2b5HmpcMMlB3qseK8/S/NSksbg+drPBWGh4R5qbB5ddZWZn8gm?=
 =?us-ascii?Q?Eig1VghRO1QdXbKh3fLUn8rg2xD4XZ3NUBvXSaam14bFVMDSOMwP9ixukUkZ?=
 =?us-ascii?Q?pAC7wTmlkc2uMzEuPMNZKbuJcGc9Hp3U/fx72vPPIwqDIf99h+adWmVvAy1N?=
 =?us-ascii?Q?7BMRAasFMfm+4ycx7wTs6ktec45LL+6LKrdUEe832rojTcw0Z/njqJ8Cn9pt?=
 =?us-ascii?Q?0lYAGmRH0++7opzPle6WqYzf8MeWdN+OU/SrsvemWBdjCIXnpSNsSaweBCqG?=
 =?us-ascii?Q?FRqCKPlFxbvfbmupwCrjDYMND6zRGifiCXyI8qwJ+D1TLPMts0KUonC1dW5V?=
 =?us-ascii?Q?iLk3xm0YVepzYQ+qJ9vXAD8SmVHlQaZlef3bgbkFGxV6mx7ysU3cr9tyL93Q?=
 =?us-ascii?Q?V3IAkbnMRtLigAbG0YvLuF4FiaiBT7jgvqCyYRpp+EYjkF2ahUFB6G6pmJAa?=
 =?us-ascii?Q?le8FSlRB6jhzVQQBbS3HOra8wADsl/CgOSR8xwx1igL/FjMn6fiTLRyt40oE?=
 =?us-ascii?Q?Ar2NUArPZgs/+LXhgxUSCHI7PsikocMqur7GULqa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 078349cc-0eff-4229-4544-08dbfd3ff1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:32:08.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKTbkIaN3l6MuxjFiPmFlJpP8uLC40ljoeX2gffPNiG4U0aP/VSIdFE7iucd5ApcO/MqK6YXk1CzjKaa1NSimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Wednesday, December 13, 2023 12:02 AM
>=20
> +void amd_iommu_build_efr(u64 *efr, u64 *efr2)
> +{
> +	if (efr) {
> +		*efr =3D (FEATURE_GT | FEATURE_GIOSUP | FEATURE_PPR);
> +
> +		/* 5-level v2 page table support */
> +		*efr |=3D ((FEATURE_GATS_5LEVEL << FEATURE_GATS_SHIFT) &
> +			 FEATURE_GATS_MASK);
> +
> +		/* 3-level GCR3 table support */
> +		*efr |=3D ((FEATURE_GLX_3LEVEL << FEATURE_GLX_SHIFT) &
> +			 FEATURE_GLX_MASK);
> +
> +		/* 16-bit PASMAX support */
> +		*efr |=3D ((FEATURE_PASMAX_16 << FEATURE_PASMAX_SHIFT)
> &
> +			 FEATURE_PASMAX_MASK);
> +	}
> +
> +	if (efr2)
> +		*efr2 =3D 0;
> +}

Don't this need to check the support in hw?

