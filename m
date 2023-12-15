Return-Path: <linux-kernel+bounces-532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE6281428B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CC21C221AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B13DDCA;
	Fri, 15 Dec 2023 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdiCH6C8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D810797
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702625905; x=1734161905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zPCRJqITGD+98gkI+4OVx5rQL+6vZkkwLce8IReGN6g=;
  b=BdiCH6C8geXLML6AtS0r6IuWSni6dFfGN3iOtb4GMWCLUJTurv/rR2HM
   Afdrejm7fKpT4vmX69apO8jbJ0LKnI/FxedTVK381ATPqVxbSxyQcqDTu
   e8Dew5mPUD87S/9uURBKywtQadl0BhEZT47twP3a/60fOIC9Sf2OwhA1M
   moFaxJA4EAq/HTX7vTfRriuwqgmX1JDtrTXSbDiLkSyvmNdKuAGTvtM2t
   j1AoQrUs8kDKxO645mQLmtSsJKXZokxrYoxZ/4FaWsoijPB45hy8kEw/N
   ya/xjp+xGKHMSyOytZDSI+N3urFA7X32K0MJm8EZ38WGIyluio7zWOV42
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385660451"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385660451"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:38:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803620494"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="803620494"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 23:38:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:38:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:38:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 23:38:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 23:38:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isKlG3n4CiEeBsCOw5SEHf3oxWlUNs6NCS+tDnNgK8NRnDlo6hfdQBlr/8ZSVm0ZRLlx1CjHfKZbVBY+oGsPw4oRkjYKzpGN2DUVyBPtRG07dRZ4NYCcJiDYz3ZnjygasnVr0O8K9D5Zwr60/IKMXwfQbnAya43jsZINhVw+ZKC81CDtM5yLILJf7uzM6ZoTXAd5BbGln5ynSA5Hox2Tfp/l/vxRPZjkmcjo71dScg1BmacBpgHACJRQeuM6mHQkHvxlkCXgM1wRlEyEuPErJQ0tlVSfbb4Yw5vnYsrWsMWD15+zCQaPLVpr7b97dlm9/Us/RflBoMYF1Di6OLd7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPCRJqITGD+98gkI+4OVx5rQL+6vZkkwLce8IReGN6g=;
 b=E1qxdKHLSohT4KjOUV0ipTLY/L40E9E8fscLbaBfry/lZnuP/WfUBk4KitO/V2+YNFIFhGz5aqsHVjTMEypIG0mrUw9jj7hvaYfpP7tNbTcRaK1EyHK9m2GdiK2lOUH8Z2rQC1rFX4SyjeaT+/2M6sJRS1V7nz8yilLcXTH9Xp0KT7jM2J/7nlSi1zjS+CTkfkWZLGdJY4fGfmkPQ41YdWQGqz72h8DXw029dlMYonnDZGx602e4U2SwhCUCRUu3SqSQMz7QYkBFPfL2JTpI7zlM/kUJUCo1ak4lqllFs3J3QkR/FnrEe+jLm/vBjMTSdZEaaDHYG0PvfPGyCTVLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:38:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:38:19 +0000
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
Subject: RE: [RFC PATCH 4/6] iommufd: Introduce data struct for AMD nested
 domain allocation
Thread-Topic: [RFC PATCH 4/6] iommufd: Introduce data struct for AMD nested
 domain allocation
Thread-Index: AQHaLRSwdefkH5ERoUGP+SW1YrC2V7CnQEaAgAK4t6A=
Date: Fri, 15 Dec 2023 07:38:19 +0000
Message-ID: <BN9PR11MB5276083231E7C7C6FFCC6E248C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-5-suravee.suthikulpanit@amd.com>
 <20231213140359.GU3014157@nvidia.com>
In-Reply-To: <20231213140359.GU3014157@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: e8b3d795-5f42-4b14-8951-08dbfd40cece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+F0TsGkicRqGLasVTRK+uJDK6W+Cg7tGW/8j7HiQRruRfqYWcO1/SnKOXdeZC4A44TTm5adsYxeHxjOZc/WQZ5bnFOdetIvAuOGmH88Bk4Lu5s0In04h6hltccYPYXjn6lqWIhowOhLyeTqTOxxcin4xjYK19OGRRx9bj3Gra5G69KXGKuyC/gl4+LK2MUnSaGdDSq6r45eRzUW59rxaPuTU1jeV55JDkcwbEjLCXMMvZxdYD6lcdnEJV1la86eeFBY3qKUqOv30Ap43O1voZbx1Ev9MbwexQD3NBLVUU3XzTgyQN+JG7RYepOemhQoT30NwPPMGxvYR/qkv8wo3G0Zdo13rc04D95+lyUifPLg75Pmla0tOPkHR7ycdbtfz/H4d3P3Q4fBh/89bAL1lxRnXu9ZL0GUida+0/0AB5X0TlNVOJznEW7BtBoOr6vt8nWQxYdhGeUnhEU6feZtM0G7cu+uXyW/OC1Oiy2/VRS9j1mSKDq6psQXb/wlCOz9myrZQ+7OFbBeFidCbnvqNDmk3HzRugfgcqrk3nSJ1hgHgGm4fqek45FiIBuDaeWL5gXxvlo30MthsIoj2kraXtFE84E5HEd37N/giU75XeNE4vrgRhJl1kOar+fgNKn4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(86362001)(82960400001)(38070700009)(55016003)(6506007)(478600001)(7696005)(26005)(71200400001)(66556008)(64756008)(52536014)(4326008)(54906003)(76116006)(110136005)(66946007)(66446008)(66476007)(9686003)(316002)(8936002)(8676002)(41300700001)(33656002)(5660300002)(7416002)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BrElgfND85T9P1wfWVz2dC73ipfzywxZx4BG5w3usfni5arzlrN03F46kFA3?=
 =?us-ascii?Q?h/ZIgsJv3lv3IXMTiT7dbXalMAWUqVfWTfRd2jEUu2metI/+loAQ7WffPmsZ?=
 =?us-ascii?Q?nZmZbN2Mffns2fYMErH+SVBsDZpzWf1T7JkCe4zG2OCwL6vdFLdLx4cP2usW?=
 =?us-ascii?Q?tO+j/j4TItt3ooaEeMT/jo+UAC0Ce+62ugkrH4NuKRTwV0bxlCm8iseNgjas?=
 =?us-ascii?Q?9fG9n1ojoKGie0VxHq5D2GAXJa+TGmSBkHALn/YW3TqjZHFJhr8elzZRX+eU?=
 =?us-ascii?Q?aoHV5Cukh/yVfXq9zn6NkrcHBzX3lSJ0ZL9J64LqvfJgYfGJtUxUO7VlCIvr?=
 =?us-ascii?Q?N3Ci5+4P2GD2vuyZORlCfv68KrJGEQywYoLrhVBNUVWz8AuVNxZRYtnEpqxb?=
 =?us-ascii?Q?nci1mamOB1EVNJrSLgBI3m/Usa4Rk2lQTC43cgJdAKaLkzr0SyKE3HL6V6Xe?=
 =?us-ascii?Q?cIUnXm60DC8ZRh8KanKJOiPZw/ecwDNJsonSJDj4isujVl1M2Emalu1XjgEJ?=
 =?us-ascii?Q?JxSTQ/KOlDThqC+6zYGqWyIfJx2iU393ygY/ClPdHgQoOyJxDCEYr2uLuzIL?=
 =?us-ascii?Q?ZEuamjaBsYx7hDLS8dc3/pkM6IJA1aoor6bNQe/ru97+5vi/b8k2MvD/mMGK?=
 =?us-ascii?Q?est7+WispzNPKteEPVENub0Vh5Ip7MeLoXiC/aHNkx3iYPrmFa1kaXbeJ+If?=
 =?us-ascii?Q?IOrJhNSQSZHWIYK9sLnKlYrbiqDPP8EGDwZPUEKlwZwP7AskG8bhIvDsM4lB?=
 =?us-ascii?Q?jSvHS2HExI/qhVsxIAxNUelx4yxqK7Yhpbii3dUnZU3GOx1LXS6e0SGa8isl?=
 =?us-ascii?Q?k43EZrD7PPcYDawGcr8Xn4KOyaG3X6mFhw+7EMKO2Dd39ygbLIaaCzWb4HNL?=
 =?us-ascii?Q?DVDaCl2j4gyaorHtTvC6qXUtpmCNZFcV3cf7gcsC/TVekroUFO5fbrE1q60X?=
 =?us-ascii?Q?VstmWBJBxc1ZsoTj8dku5nrd2Dyq6irDpHVv5vLQaP6Nbyf9FfAXT7XtmgBM?=
 =?us-ascii?Q?rKutwSBy/itexp8fuBmI9lnfL28OQpNie8+/9eWxm+UKC3CqHxeiGqTkzqXJ?=
 =?us-ascii?Q?pTxpazDEyNzOIVguCVqOEDh7j/zC7knmRVPLqJ2+Q27zjGlhpcgSEdfLk0at?=
 =?us-ascii?Q?qW5icGgqzUrGLLgbBP+xWy9YX+CEYXieCdm+your6GsHBzgdO/JZjBk6xL30?=
 =?us-ascii?Q?b08oJ8gr6fqLim8kSiTQeRCK39qG/QGs0SWKfDsouZx5p5wNfnDBCyB6Rg7t?=
 =?us-ascii?Q?FsVA52vtgA9PW9lvJFllc6N+sOaWteTfT+eNmHpZIWSNGyzQZSOrt2Jc/zTs?=
 =?us-ascii?Q?8uuKB9hdaBy7YQEO728RyNf8UtFe0KxeD/hQopp5h9YNOjvU7rdLkWKCsGoP?=
 =?us-ascii?Q?Xt7J/2jP0MnVAje/v3m1YNzYsZHdkHS9k18Vcwpzd7XDpz095HWHFUTNu2eJ?=
 =?us-ascii?Q?L0fiWeybNLM5/A43gv+ID0sEj1zX+FLtahrFckNt/188QP7AHv3O0/dEIdWv?=
 =?us-ascii?Q?zM7alPZbP55ZSKU8T6EzMiFqe7kohteXVRqL7m5VT9D2GqolGHHmUnhXy1Zl?=
 =?us-ascii?Q?bVyErg5ahF/wGg96C8ksp8gb0sApPgcorJdjzIpz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b3d795-5f42-4b14-8951-08dbfd40cece
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:38:19.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXRwJ8hdJjiSXSIA6tzj5UDex9ZFYV1UvHAa6r+TCcb1gFuapb8tXS6Rrdoh2Nx82F2mLTPlwKCJaiTBzr2LBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, December 13, 2023 10:04 PM
>=20
> The viommu object should hold the GID. I'm not sure you need a GID
> right now (can you just issue invalidation on the physical side?), but
> if you do need GID to bridge until the viommu is ready it should
> probably be allocated by and stored in the nesting parent.
>=20

and how is GID different from existing Domain ID of nesting parent?

