Return-Path: <linux-kernel+bounces-5813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1A818FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F31C23A17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B5381B8;
	Tue, 19 Dec 2023 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bviq4pVH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E3381A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703010758; x=1734546758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=es96I2Yyq0YsnQdVs3EqcqjWXaKAHHZnbXnVEB1iyXY=;
  b=Bviq4pVHEA2aJwZuKWA63ujiq7njUrwkhJk6jJPBbD9XNfe2M/LAukjY
   S8FUS1aC8DSFT9qauBn+9yWsHjMHig0IJZ3SsGmNHi/ISUbpaVPcAIXX/
   gOZ15Zi8MDix0jYFANFLd9hmN3lmSqAhPYGtMyY7iuS/pP94QBto5Pnir
   O8kfGp9kO0KLDdXpTSXOp2yskA+k1LOuC0nOUxV4yPFbHzQshe2rSB6P0
   bgl0aerlP3XENA74+a10PdSFwso1jdISiH2F0wuU63l7RJy1WIW2MhRQP
   UadUEnuwKh/+clMY9+tg3dIdqVLASLU2fXYX954nQCty8p70jiordG4xc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="395431602"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="395431602"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 10:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="10486871"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 10:32:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:32:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:32:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 10:32:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 10:32:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYv+B3XcBLUYfXoMlqrfZYsXEVnQHzdXU5EZLq5eAJ3zfm8d+ltP0lNxY/zzfGkIKowlIpxhz9qMFk5Ya3x2rryD/GJfXn9G16yAu2af+FlFDnVj76t5RWRbuLpq8Pl3ldPX6tJOo2cglBA/LxW1xjJaSlRwZmhtn4ARvjvY5wbNZbxiyiRGKr+ztdOeYvJbphlXoiQ1AYGUo13PwmbeW2BjRXpl8XdDTVIkjyGSNHQwEY0orKUblO3B25jnVr3ARm0zEYH7WaaNFDDNVYbHucvFQkKaKEgKGyNNm7itEWpxeA8LljssI0Af9IE4VqYl4YMzXA52J9qD9DL/ajm6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dZkYB90jVi6GsjfLIzwYSDLbx3x7DFmeZw4ECJNrJ0=;
 b=HxxIj+PaXf2PkJAraC/f413xIENVd7Sk/6TOPMDfNhGOAyU8b2u4jdPfG7SExQypnIbraK3n3yZmrMF0VAImGbdu9TyM9mncjl3yDJFxCKGttjapQ1aQ5d26tI2v8w6jMCPuxzft4BKPYDIqUBpHsYLfu1uM/tW4yfRCl6wJUAUT7gW6EX6xeM5oOi+Njl2eOs/MNMRqjgTJQXshFpH+IhmbDjGiAiST0KjI5FUaXOtasdOZm/CtPyw0iAno8prGTGY0Ms1XcYnTQ8LhRfQT7+9qP8142XnInKQCfaEA5976A2QNeVMgCZDAav1aAYssCA4+Do8iEnTxgRvcSp6lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by MW6PR11MB8409.namprd11.prod.outlook.com (2603:10b6:303:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 18:32:31 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 18:32:31 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>, "William
 Breathitt Gray" <william.gray@linaro.org>, David Hildenbrand
	<david@redhat.com>, Oscar Salvador <osalvador@suse.de>, Kevin Hilman
	<khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Brown, Len"
	<len.brown@intel.com>
Subject: RE: [PATCH] driver core: mark remaining local bus_type variables as
 const
Thread-Topic: [PATCH] driver core: mark remaining local bus_type variables as
 const
Thread-Index: AQHaMpEHnG+TLmy1q0aP6ABzV9Z91bCw5b+QgAADIoCAAAREcA==
Date: Tue, 19 Dec 2023 18:32:31 +0000
Message-ID: <MW5PR11MB5811C5C0624C8414FB43F241DD97A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <2023121908-paver-follow-cc21@gregkh>
 <MW5PR11MB5811AB2DDE57E309A329F5BEDD97A@MW5PR11MB5811.namprd11.prod.outlook.com>
 <2023121943-slather-collide-f61c@gregkh>
In-Reply-To: <2023121943-slather-collide-f61c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|MW6PR11MB8409:EE_
x-ms-office365-filtering-correlation-id: ce77579c-5297-4ac3-d38d-08dc00c0dcad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EERMlJhbjvFkXtE+r5OD49UfBmdo+yaPc42GQE9WeNUfyksc68738ze3XNDv2LScZ4KuULjV6m4GTXkrzQ0OkGAx1yMkLtEj1FiQv/HcL35BzeI9m4WDk584C6PKDxzOnR13zXrB68np5Yrd699skZoPX4QTAP3CJTsS2BFaA9XCnMCTtS7U0ciUaydMmVY0C8owjBGA9BLFE0LEN1O6YxJRX6FgjMYDCTvCDHkCxwTq4WN2gh3/Z7T7hJ6RSKc+HJP9YKomwgmJQ1kafuW71uWyIy4Q49pGowIhd5gzijp4PVOJ/5c6hWSz1hmICaI9/ioehacWrY1OsVXOzwNoRbQZltlQZ7QKmvQi5dYZ3nAC0D72nm2JD7kjm+SdaKNdpzSd2aiQXLiwPMY9wurN2OUVf8SQNpdmcUDdZ0CHgwOeiT4HdgoyHLfHxKPo9RoM7yG5wajPsUyNykdvrnyiD1fiRBCmcX2MSsJRzftPj17DkrB1D53DMmL5Z6CvYyyGuH3uobEsSfZPMfolGywoaPiicRgb8iRMadhAAVn/CfUpSi1lCJYAlkYSrnQGSZUJXwWa9MYWmX2T3ztVDwYwIEeA7Icc1wvBnUjXIfboRXLl3QWMdUJ5r5bFUYghHf9R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(83380400001)(41300700001)(82960400001)(122000001)(38100700002)(5660300002)(26005)(9686003)(52536014)(54906003)(76116006)(53546011)(66556008)(66476007)(66446008)(66946007)(316002)(6916009)(64756008)(107886003)(7696005)(8936002)(478600001)(6506007)(71200400001)(2906002)(8676002)(4326008)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPcyR3E8ZsygeUGn5WglNTszxX/fYMfXS1Gz5PeeflljjVQNoCEfRoqHpKE6?=
 =?us-ascii?Q?iNtHUxb3fWCnDEF6UBCObsDDhd/4hW7MUvL54TVaG3+lziz04ZpHnGgKxkOy?=
 =?us-ascii?Q?DWYvL2ZYn0I+4XxMAMJEjhJsTRQw0K4bauJNbeZz40ACGlRaw9Vksz0g/P46?=
 =?us-ascii?Q?8JMkbQpEspMeArwoWDgHFR5pDeOeQXHXuXZQjS/zSxG9Q6Umfah3+T6FG2R9?=
 =?us-ascii?Q?BQvW7sXDaGdPKxFv/do15yx3S6WoqU5SVTZF9c37vfrz5sTdX9NxmBKd3V8d?=
 =?us-ascii?Q?UW3yOPwsnHKIyA97JAIXfDA0MMySA+Ry8UfcsJUKpmvuEuswj5tyWam3eTmD?=
 =?us-ascii?Q?EXXEUpYFR/we8CGwMh/yS+bCD0Km+PLQLev6xBpkVQ7EbDBXDN61EZe+D/3m?=
 =?us-ascii?Q?fgJBteqaE74FWD24cqDBkpHWHXvIVR+rRJ+bRj6zWAEQddaqrKQcatiQ+6VU?=
 =?us-ascii?Q?TVc85PU/yb5KQee2zt6cCmFoooGKxJTkdH1Q153LD1zDbDYlSipD1KVZ09Vw?=
 =?us-ascii?Q?E0zmkxCCF33k5v+7apPqm4KopAaZxuqLBWh6hPgYM6oy5hhljTFYxUMKh76D?=
 =?us-ascii?Q?KLWvNf4j+zOjtcYAx6/LMZaW9i3ES1s4WYjHn0J7f1trpRkQsgx7QF079sYE?=
 =?us-ascii?Q?kHkzB5OjdZa6E0+PQTRdPX7ystpRFDTm/a7r32V5BZSuiheXNF2Z60h1AWiL?=
 =?us-ascii?Q?Jo7GmUUJCG1s9sZ9DOD2zcuR1yHIDDC/UD2+eh+VTpLOc2JfoLOQC+HdaW6M?=
 =?us-ascii?Q?5QsZssy1KMpT+FzT3ZKAH4DbCkKXg/vcYhLg8bZkcQziwcojF9o6DlQzpETB?=
 =?us-ascii?Q?GtxHtsksjrqATy246ICvMFvmz6Z+/TYKUexj4z+FunirJcI7SRkIeiaVNAnF?=
 =?us-ascii?Q?df+/nfPdx6b2Fj0DVsjvZiYgk12wqP2kIJY1MV8qNtpLTk1zJt9Fiqr58JIP?=
 =?us-ascii?Q?03dlum3pJ4H9FoH/H3kqxjGkerQVvO6QHCToAADjkMeMERuOnzsAMWCwdV2z?=
 =?us-ascii?Q?d16WYxNhe3hzReC7g9VzJs1lk6g+RJq/DfS3truy/IsgSYC+L4y8ep9h4ZpD?=
 =?us-ascii?Q?sITqJgrwDMGyrFcu9OTtyR5qH1eYINAMyjmAK7Ux9nz2X0UcdB//hQn/4f/d?=
 =?us-ascii?Q?Zb25eFtHqFuXld4U69Mn7+m88HICJ6nTB51zaNRrHIsOMGdektaxro3XTSpa?=
 =?us-ascii?Q?TLQO9/Wbhz+tSYN1ZbXDmEyUrhdDoLv3vO89Ql3PrCUwud9JtI4Uc675pomu?=
 =?us-ascii?Q?OVMKUtulgW3SBoeHOmpuayl2J3tx9hIhzZfMd7vSTWdGKsoY9WH99z6uUIF2?=
 =?us-ascii?Q?RDMBHjU9W0/gnB4cSnWzyUsjuLfZtNaqCPDgOrV+cNsgwKkvHO7pO3myCmUc?=
 =?us-ascii?Q?iHUwX5T4u/3Wekgz+rhBw3hxJ3fszChJxlZZeI7/WlbNd6zY3IZFWCE3OqBV?=
 =?us-ascii?Q?fcWV+i0XGF3Zdzbc8HAuTbDkN5R3dW9K5fwoaE5HG+gm82+D7c9nz3EUbrqV?=
 =?us-ascii?Q?LRWZJaESAAZIE75G7F0eNKUzr74btVjLoHpw7FyZLoQGDg30SldbE8Yjf2MK?=
 =?us-ascii?Q?UuJWhycgCG/BzEJH9Sx9A/JfV2ISMVn+sQU3ih5T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce77579c-5297-4ac3-d38d-08dc00c0dcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 18:32:31.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqekp38dT7sKLUSb1xJD9kCaTfuvaAdU5brbTlfSGXi0fbFSJKiAAgFkECFzJayP35pADJKp85YP9fwZkQ4zm25IluG0o0ZyAMgJLXGag1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8409
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 19, 2023 10:13 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: rafael@kernel.org; linux-kernel@vger.kernel.org; Weiny, Ira
> <ira.weiny@intel.com>; William Breathitt Gray <william.gray@linaro.org>;
> David Hildenbrand <david@redhat.com>; Oscar Salvador
> <osalvador@suse.de>; Kevin Hilman <khilman@kernel.org>; Ulf Hansson
> <ulf.hansson@linaro.org>; Brown, Len <len.brown@intel.com>
> Subject: Re: [PATCH] driver core: mark remaining local bus_type variables=
 as
> const
>=20
> On Tue, Dec 19, 2023 at 06:02:33PM +0000, Ertman, David M wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, December 19, 2023 7:35 AM
> > > To: rafael@kernel.org; linux-kernel@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ertman, David
> M
> > > <david.m.ertman@intel.com>; Weiny, Ira <ira.weiny@intel.com>;
> William
> > > Breathitt Gray <william.gray@linaro.org>; David Hildenbrand
> > > <david@redhat.com>; Oscar Salvador <osalvador@suse.de>; Kevin
> Hilman
> > > <khilman@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Brown,
> Len
> > > <len.brown@intel.com>
> > > Subject: [PATCH] driver core: mark remaining local bus_type variables=
 as
> > > const
> > >
> > > Now that the driver core can properly handle constant struct bus_type=
,
> > > change the local driver core bus_type variables to be a constant
> > > structure as well, placing them into read-only memory which can not b=
e
> > > modified at runtime.
> > >
> > > Cc: Dave Ertman <david.m.ertman@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: William Breathitt Gray <william.gray@linaro.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Oscar Salvador <osalvador@suse.de>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/base/auxiliary.c    | 2 +-
> > >  drivers/base/isa.c          | 2 +-
> > >  drivers/base/memory.c       | 2 +-
> > >  drivers/base/node.c         | 2 +-
> > >  drivers/base/power/domain.c | 2 +-
> > >  drivers/base/soc.c          | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > > index 4d4c2c8d26c4..d3a2c40c2f12 100644
> > > --- a/drivers/base/auxiliary.c
> > > +++ b/drivers/base/auxiliary.c
> > > @@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device
> > > *dev)
> > >  		auxdrv->shutdown(auxdev);
> > >  }
> > >
> > > -static struct bus_type auxiliary_bus_type =3D {
> > > +static const struct bus_type auxiliary_bus_type =3D {
> > >  	.name =3D "auxiliary",
> > >  	.probe =3D auxiliary_bus_probe,
> > >  	.remove =3D auxiliary_bus_remove,
> > > diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> > > index 675ad3139224..e23d0b49a793 100644
> > > --- a/drivers/base/isa.c
> > > +++ b/drivers/base/isa.c
> >
> > LGTM - ACK
>=20
> So, is that an "Acked-by:" type response?  We need something standard
> for our tools to pick up...
>=20
> thanks,
>=20
> greg k-h

Sorry about that :)

Acked-by: Dave Ertman <david.m.ertman@intel.com>

