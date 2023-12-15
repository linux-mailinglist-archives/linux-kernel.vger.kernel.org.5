Return-Path: <linux-kernel+bounces-541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0608142A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A7C1C2241F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28E182A7;
	Fri, 15 Dec 2023 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fH+qowFg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739D14F95
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702625988; x=1734161988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kf64ymlA2NRUDnMctcj7dF2+lLh/Yt6uDGAQ25TX+AE=;
  b=fH+qowFgf3+Jhq7+pOpX5W5Epo3v3fORlAWVXd21+IflacbIX5wZmSAl
   n6d5B75hg7HQNHbqkhSGgwwRA7RVERQ5Xa/T0M+2pw+RWD3L/tpC42vgS
   AcQBBjsQzQpuCeq/Ky2HJKB4FNh8q99Pz7qCiOq17ZCjB1dGCMs4OOVVC
   tovCXBxNJ+KzMCLxMNQHPbSkK1Br4Ilc2gHy7yWf2nFlDkRSk+Ao/AAbX
   2D3JfGukoHj+sbQ6kdev24eAC7t6WxAJtuXB+NXvCCs0EvC3nJG6RY0wH
   vKBySzqhPXZ+YK7gjtkGmX5a0cXBlS9zxIioGHr+rAafcBXk3KubqYyLA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375388630"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="375388630"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724364721"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="724364721"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 23:39:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:39:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:39:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 23:39:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 23:39:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr2KvMBTVtolK89zfS689eed/UAhSJSJ2cafyUMZ0RtrfWY22Bkl290zylEiYCvTdSOnNXhs5tMq7Uf/umAr0JgjqBtpDTFdkEDobISmUcIlkZAfHrHc2R6WieJ9WsDHljXoXSR9MsaymALSHuS/kPRrch/OlQNWJFLnWWo9LCXczgKVv0yjHLtipmxm6Xbm4cR1FeLeRcdKC76ORqYnce8xMYSgYZoTtsVupWoFJQffrzMPBhx3TQp6r4aL/IKyZ270xyNA6aaHXndJLz7t7IKdh52qyNyDtvCEZtRzHxo8PMe9WlmgFi45MyxLdXHs2WJYVEOLQVKvR7+rTNDG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+XRD554vJ9gcDKPXpxna5fnAkDgkLY/oOEcK7/c0aQ=;
 b=M+9U9abl9cJFRA5W9/WuAOFMiAZU38IYmVbfP8p4lU0b0tQGxXA/GXTiuKB7E9+FEJ1vsrVYXUwl66t7XjoG+3544hVy5rqy6wb+YA6Oje9ciiTF+Q0HwPv1VhsX/SB9TEVko9Vwu1Hg2qUSNj6koqBJLNiFBMOGm7QyfV7vv6VQVPKlAobUQTF+XfwDB7YDwT8xv3Xwz4SHI7e9gB0Y78LyfqJzPNvN8WeJJsn7nw/weolcnxWSu4YKxCgeJaNHa7Y6AlDqVIDwlWCx9mdWBNgKbZI1KF9o85B0+uiXY+U90wxoH6mC6Xqvpzx17u+ZCxiRtzjaYTXLxY3qAxIEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 07:39:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:39:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>, "pandoh@google.com"
	<pandoh@google.com>, "loganodell@google.com" <loganodell@google.com>
Subject: RE: [RFC PATCH 5/6] iommu/amd: Introduce helper functions to setup
 GCR3TRPMode
Thread-Topic: [RFC PATCH 5/6] iommu/amd: Introduce helper functions to setup
 GCR3TRPMode
Thread-Index: AQHaLRSghPqwSI/GWkO0t5FR0qd6ALCnPUSAgAK797A=
Date: Fri, 15 Dec 2023 07:39:43 +0000
Message-ID: <BN9PR11MB52765E5B6A22918FC9B438818C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-6-suravee.suthikulpanit@amd.com>
 <20231213135313.GE3259566@nvidia.com>
In-Reply-To: <20231213135313.GE3259566@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6700:EE_
x-ms-office365-filtering-correlation-id: 2034710c-5be6-4d88-e316-08dbfd41010d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8VFb92Vw7eDFCUEJpyR0vkbyyKrHcu0/f/Yf24vtLSB5kZEbcJDruUvUzoLQL5+bNy3Z0nBCnQRtNKtgjkBSrixP73xVgC1cyYSjaoBIZbiNuj3F2c5EEOmQ2Nld01hA2vY57YayTmJWHodH+NaSGui/2W3pBuSTBsV+sWW6W8EVDaSsRnhn3z4YykodHOd6MAQPkwD2ul/N6gFDqp3+6L4Y+rVmNbcJmtdB2hIHv+84tJAM7KJxaN9hwHTMBlsDcwHIxQns80tniNd9nsDVru4XCDBzrPosGznlWPIfgxjOFx3mSlVdunZNwihWVzVJUrHo71r7ejYufeswv8tjSCQFDjJBGX+AddJZtkJewMlhQuVuJ1r15//ERB7MvPWr0GO5y8pGAu3/LGaFzv4FyV3InImiMZODYhr+K0Itryo0pTEzDbH6k/FTK81BroBY0MRvI3YOgpbFtDtikph+JuRGb9QhNz491Dv/OJuXGoPcbW3zKthQIsW8YHEqa040uGe0Cvlglk5hzl4iWMJzSGxxIwfCJXZlOIS0fW1udsKlTnuRkRVCvUU4P9OPQyGQrbx5t+UTcaUsQyGXt9IOeLIjMW/1oMaUBaMZWo/ZOMJt2uI34WCkEyFfHdOYboCKyd1NtCE8T8hx/ugSa7H5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(33656002)(4326008)(8676002)(8936002)(52536014)(86362001)(5660300002)(7416002)(38070700009)(41300700001)(478600001)(71200400001)(26005)(6506007)(7696005)(9686003)(82960400001)(55016003)(83380400001)(122000001)(76116006)(110136005)(316002)(66476007)(66446008)(66946007)(66556008)(38100700002)(64756008)(54906003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iXkM2KMvSuiAwrqTMd6Ls1T/ZlYK5v2MVvtHjiXo7DbbV21bERuFTC1yDsdx?=
 =?us-ascii?Q?TgodkXsWNxvCEEuupZqYdaHrmPIcfwQms4eG1oO9Wr8CPAjeXPNHwWoQxg1a?=
 =?us-ascii?Q?JoIFHmAmCNtvVy/+p4mx6i3H/ihG3il/ssbGUjuzk9+LaPKadgCi0h1+56tT?=
 =?us-ascii?Q?D9WWlxFijai6sRzaFEi0Fuw+BzqF5djReBBJWq/AxdTRKZv+PC5G4Y6w1f8M?=
 =?us-ascii?Q?bh2kwwcnDOic7jtE5m/QyxRdiEx9PbEBCOn8xt91obJMy81FIjm0cwZzHH77?=
 =?us-ascii?Q?pch6Tn68kABDOxbOeZyB4rU3to42/p+UXkWheufdbPtFPvUAqXs2fcZ/al8C?=
 =?us-ascii?Q?dec7e15EFv4X8KPc39Fq77SH0j8AJoNhJ75eh2OocpoOQTPxJ33CuKJPtPUB?=
 =?us-ascii?Q?vV31fZSbmhH+ZbyVq945diYAu7UrT568MTSEyxLQsa+3G2lvq9ZxGIQjf3/C?=
 =?us-ascii?Q?ms2SyuTcxHaxKh4+BxrgLFstCVwwhpszLNHwYNfgh+TJRBU9CC6k2FDrA55y?=
 =?us-ascii?Q?WQz9O8t9k6keIdIrM7bI82CW9HhpWJbUE7lle67X8Q9ki9KlAcFu28sckbXg?=
 =?us-ascii?Q?r+d2YKdL1raHiyXeeO/lOyg8Z/Q0F9iN2OLbanz6B2Q5rI4mhjpiRa8V8XSF?=
 =?us-ascii?Q?NyUmVPW+tgfSwmKhcY3br2a894h5uxgmo+cIp1nNIWw8AwbHwIJIFCWEeYQK?=
 =?us-ascii?Q?GIIAjozULfJ9Ins8zKa99pKQy9/Qc9LYPeJr9HOuKRXUqy/aEEmK4tmK5ISv?=
 =?us-ascii?Q?y8m6UZfT2N4DXFGo7IHiUdo62ZVUGnNr1V1I+kosGwNi9yddJ7EHrMMqjJ1P?=
 =?us-ascii?Q?sSn200AML+0YOBmJPJ/2h4gQAYcloy+OAWMk2QobLj5CQHlqwh3ejptucm2C?=
 =?us-ascii?Q?ErDvk7gbUmDUWZCNvG9QoxrO1LgwpsN667Y6iSdGAFrqxCTfRF9MmoG7v9+K?=
 =?us-ascii?Q?nF8LV1ECcCw52+t8O35CfRmBwSoySo8xs77JUdIAk+Esnl2QDbUeK5WcPu/1?=
 =?us-ascii?Q?FejaQj3xKfdxWRYwUtgMSu1eCxQSfNjV/UP0Lyj6u6RvI6C6PVH89gnYBeKk?=
 =?us-ascii?Q?PX+n7VDQJEtcdRwxkoadGPZnBEDMzgtbeFZ5QVKdAs7f7vhfuJTsn8Ye1btU?=
 =?us-ascii?Q?Lre9G9bId4LQxTrwp2MyxJ+q2mPrLQw+gLbBktp5Zt60zmaZBGKN+IPnhzL6?=
 =?us-ascii?Q?QFrF1kn7+bcrs1KWCsJKZhufUvgFlfLM3XimsiW2WqQae1xCNI/0R8ueCgnz?=
 =?us-ascii?Q?hkvQBMnttSTKfqXH/eLG+HZ/exD6Q2FcyIdlHjsgrnVWl51ihtflkb+M/BuC?=
 =?us-ascii?Q?Has1vXqF31L726QKXse6VGLhZGWLuU3+tRkQT+nvqGB8qKaMweBzBtZIkGtt?=
 =?us-ascii?Q?5A/6537KCZ5R2QUXxe5radNwseJiTdA/NmC89nKS8k8LDB3MjjFPTCC5qtnd?=
 =?us-ascii?Q?hSoO9+oPqb8seVk9ivxcC9hihGahF99arMv7yFvP6KtN2NHBfH9LX/FBzE4D?=
 =?us-ascii?Q?NFj4720kwGHfp+MzDbXVTSRpk7/OIgdgzX6/o+CNdflrUBv/bJlmK61Ba310?=
 =?us-ascii?Q?KVq3o27wfuh/pIbY/kGl8lCCm+HgbQyiKuI5cNdl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034710c-5be6-4d88-e316-08dbfd41010d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:39:43.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfUqLiPN+LOr16Hi2DsZdReLbFAwyxrZ4wuJj6RlpLUcWnlCDanlNQ9eVApgKTgbzWa13KeeazaDcDbbUk3yGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, December 13, 2023 9:53 PM
>=20
> On Tue, Dec 12, 2023 at 10:01:38AM -0600, Suravee Suthikulpanit wrote:
> > +/*
> > + * For GCR3TRPMode, user-space provides GPA for the GCR3 Root Pointer
> Table.
> > + */
> > +int amd_iommu_set_gcr3tbl_trp(struct amd_iommu *iommu, struct
> pci_dev *pdev,
> > +			      u64 gcr3_tbl, u16 glx, u16 guest_paging_mode)
> > +{
> > +	struct iommu_dev_data *dev_data =3D dev_iommu_priv_get(&pdev-
> >dev);
> > +	struct dev_table_entry *dev_table =3D get_dev_table(iommu);
> > +	struct gcr3_tbl_info *gcr3_info =3D &dev_data->gcr3_info;
> > +	int devid =3D pci_dev_id(pdev);
> > +	u64 data0 =3D dev_table[devid].data[0];
> > +	u64 data1 =3D dev_table[devid].data[1];
> > +	u64 data2 =3D dev_table[devid].data[2];
> > +	u64 tmp;
>=20
> Like I said in my other email, this whole function is conceptually
> wrong - you can't read the DTE to learn the parent domain's
> contribution to the nesting DTE and you can't write to the DTE during
> allocation of a domain!
>=20

Agree. DTE is updated only at attach/detach. domain allocation should
involve things only about the domain itself.

