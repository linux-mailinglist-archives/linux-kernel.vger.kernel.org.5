Return-Path: <linux-kernel+bounces-78679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F56861721
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EFB28AE92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52F83CC4;
	Fri, 23 Feb 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkWO2gSf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2E839FB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704550; cv=fail; b=k02PU/7NPyDkXHysBYoMfyydd3WZ0frdC0rT/Gn5Js0NMFl4+UESf06wiFUOthOxAXGqZy2cqdoNudxXXV2OacDt+WhciEwFMKBK/zwWckzgYltejgFQnpFnZ687bIgojFuIF1VWT8IJswtcOSmAKZG46mVtE7/ZIeXOgID4ZwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704550; c=relaxed/simple;
	bh=kFCRpb8UGIVd2FwRgnrVjXwwTPVUcMTX8C48ocujV3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQMQ/sGq0k8CwfowGaesH//iV8jJKPiwRNz6wDe6+53vRSTJ+R+L5FMkbhXs2pml80JxawDwqYHzXvO6TX0lTIqAttaBXI2ol7yd5AWm/WT5k2wx7RZXS1hBcoV9i2jdcX5jEoYYusyO4PN6DYUqWWonxwnt6m5I1JmmbaDXiVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkWO2gSf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704548; x=1740240548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kFCRpb8UGIVd2FwRgnrVjXwwTPVUcMTX8C48ocujV3c=;
  b=RkWO2gSfAnqMO0bu00NqjOPfVnfwSwcOVc553Y/3xS7WlDw+DEtIkxE+
   SNyvmMGU6S7XfBoIfNEKlZ13ZMqgK0GCEKnQMhdaGwB9NzJeKBeryYBnE
   avjg0V4CcNgygUUCEV8nIHAxrXWicfRAsO5JiWeUfbWrFfzNXJIDJhwGv
   FMBuQYJk06CoCfJotZuPq3YV7RdV4OHqIPVZkFhvAJ1unNbFPCfms1btf
   pSCUuPpLVsSRFO9D+OF5SCY6Tup8Wqel5nFh6C2vOwddi5RuFrzQ9jS37
   ZJzU0p8/zQfv2L6roWkjbLHeCMbDGRL1Wsb0ETGBae4/HFZOAE2tI/sGP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20466605"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20466605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="29122913"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 08:09:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 08:09:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 08:09:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 08:09:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 08:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0FjstYKqjuQPbeqRHJJEra4loXXBopeTWP29XD+J6MW2g5PyALdYVFDDCYhNhkydyZ1BU5kDVkMzSPadpK1O4c01hYMtyD7Cw5S93i2zAqv7y3/FLcwU5KeLm1hjBSLwC6sbUV6aNIbWqtvX57Z9IcJIkWgBT6TNUdeOombeA+BDcEHr5HS/m14woAL7jdg+Aj5QXE5PjGAYy4fq/hsg6uGnLq6FWJclOn9ZcDhyCj0LyaeAadBVB8/+/Cv2DVCT6PHuObrdWDV7g9S4kJTOO0Fzj69hH7JNy5Ju9Kj0tN06ukFOUsWrHD+jMSer9GF52iR65PHCnrDj0t6LshDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOR3S0lAXcqaQ9ruIQE2bzopGHbzg7dKOPv97BbpjSA=;
 b=oOYRJoZbRppzTWV/7VZhR2CpbH3xyAnyyvVzgU9REIBqBuXUTyM0equR6XDfjXdXT17ngwkDsbkVx9WkszBpThrm1eC6ifGsj684/bio1Gih6GUQgpbUUwOoJzqtrdmxn0zuJt17pyMLfhmGKHvoup5oLfqrvNWdbKA0RgAHhFjcsy1QHjePJe6u+S3oTh4B9rAOYUyjSsPZRctAH9mAEhAyU0poBk0e7Yu9RqVhpkVibLvXHsPTOpesnY5pgueWrAUY1mj6JyH1Fpba6hCkq6biUGLP45/u5OP7uEJYYR6GaZyywW3Acpp8l3xiH7Ckizk55SE/ABzigg3TqTMjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) by
 DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Fri, 23 Feb 2024 16:09:03 +0000
Received: from DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021]) by DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021%7]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 16:09:03 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clkdev: Update clkdev id usage to allow for longer names
Thread-Topic: [PATCH] clkdev: Update clkdev id usage to allow for longer names
Thread-Index: AQHaZmNNwGKZ+qsDt0uuHOIigoDEFrEYEqkAgAAEZaA=
Date: Fri, 23 Feb 2024 16:09:03 +0000
Message-ID: <DS0PR11MB64245B3F3AB02C32B53F3F64C1552@DS0PR11MB6424.namprd11.prod.outlook.com>
References: <20240223141857.3794855-1-michael.j.ruhl@intel.com>
 <Zdi-QnkPYUFWLJIe@smile.fi.intel.com>
In-Reply-To: <Zdi-QnkPYUFWLJIe@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6424:EE_|DS0PR11MB8163:EE_
x-ms-office365-filtering-correlation-id: c7f59876-06da-47d4-8e26-08dc3489c118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /AmN9v7TbeMXhr0HVyuOa7KsCMUFXVpwVvB4FT4y1p8JV8oh259OtkrIB00V0KYf5Kwn3H+Yrbs7KO12G48dVIR+P66dY/bSC0j8Di0zb/JBoaueyW2FhG8CRS0UCEvjPcqj2hHL1T5KB2q02ClfQHQv4cnd+m6lphcmWYJ1aPA5899hWVH2pHauERvweoWmxkOCOLifH9AlA2BxB7pybOIXYFF7NJ7ygaUNr0iYIgSnRGj6Bmqz0zEr0ZtAIgXtujDAxogepw+gx3ETrQfTuYafDY1xlLfT4oYr0meTmHezTPCfAhGzPoPQip1jQowZsUFITb3WR/2SlqzFaQsX0diUajYe1trarZESQTgWeBW3aUfb/qTFTXkOKfFFMrB6kqDa9st5mN//y3egA0DJrzPRmrQXLRID9HAIO+c30EsIJsntbsrwacvDqw9MTimTDhDiD1eZDczQKO88gnHwk31I2SqEsVW1C8I2kJRI98USwmQSnHiLYRQVHU4H3iZ1PoVdMib4bJUsTdaLQqS0d6IWJM0xLqPvrfAw3mUM4Ulltc6UZacuU7QGgm8WaSTa95H9MMpQdDVrrxlpnWHlgp6K4dXxKDnMnuDx5Fp90lN5141ph1mtKJh2kJ/8iC7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ppmjLnD1pR1OppVC9G/C4nq3jBkBsU5G/+uyurifBLseCmVwBeAwaK/2zd8K?=
 =?us-ascii?Q?fy/7lXkxmzJ1bHDmQfOxmfWfe0LGGSIDoz4x0NQ6AOmu4VmvqKU3e2kQ+lue?=
 =?us-ascii?Q?f5GyIWy96r8P4/lS096rEumtqDMJWmyJR2bnou6ADRXbFl4k6OI+UjaqsjQf?=
 =?us-ascii?Q?c1ruRa+1r6XpVUjCvlR8hMeP5y87brSCUDHIuSnqTdSBSd2d7+yxUEg6Kh7e?=
 =?us-ascii?Q?6cU1Qpv3IjfU3nVL539t881GK1JnkqWNZVUbzacCft21XrG15G1pnQar6Cew?=
 =?us-ascii?Q?0jfNCu8lYnPifpAJr/xRJSflilYDvoEVsiFa4eDHz/3BtEeo5OJARy6sMgKk?=
 =?us-ascii?Q?WBnmsKuphOoWTlt6OTyWzent0ZylOEUrNZFNzZHKJIvbreN0vZmaIiTqg0Nq?=
 =?us-ascii?Q?qbboTrfclOoX+HprI1JRO4jVC361NjtJxEUNjsTg3ysDW0Nb0ExyupWoUTry?=
 =?us-ascii?Q?W6RwjIVnJ99Va7Sr/6SRhqoHrv/Q87PgDCsYObFYoPmV64mDxxxO/8Eg8E7d?=
 =?us-ascii?Q?sDeOZm3m9nMPigpXUj5YbX3Xx43S/GQHFA/5eIDX16ClKrP/mbe+Oh/B1bTq?=
 =?us-ascii?Q?hJ5zW+zEjy92/PUFJNFg8IKcRWzEh2YnLRBMmUdZVNEN4yia6Q1JWuIq9XZD?=
 =?us-ascii?Q?CvWXJ7l6aP4KmtPUs5uagowxEBv7dB02PaM8MYisyVkrgE93SwpFLO0AD750?=
 =?us-ascii?Q?PDqMfQ+EUPAyYRHnzOa8f33qRdy6uRTjo1cIU8+uvhlzcqbWRuUVLa5qTtHB?=
 =?us-ascii?Q?BLny4Jftbh6cYlbDgn19m/29lL2kC8tILTMx7JDA3ymwJMyvEmH1tZdjFuHo?=
 =?us-ascii?Q?G4neN/vIISUKm2ZcRemqoahxq30GPx1YlhpU2Prv/m/cghfxh8R+aAmwXVy1?=
 =?us-ascii?Q?PFx0fpPoUoKBAQoe+3eGuceZNtF2bgA+yIZKTsnnOEihTsr3iNoqEXVQTJQY?=
 =?us-ascii?Q?mrj0OYksbWtyEF/mHFQufqJ+jvaf5xaO2K6of2hJ4ofZpW+QKVXpoPa+zA+t?=
 =?us-ascii?Q?IXVI0hUe41Jg8kaZItXiur1h0n01LYFrmm/PLY5/07WyANb+kNYrMLnIkl4j?=
 =?us-ascii?Q?DvEnP6JcGJRROTPPwSp+7uSjiKQJ3N4Dh+50JZy9jXushaShB11Hmfy+kHXB?=
 =?us-ascii?Q?cQ0+SXEqNSt4pKQAR+wcxz0rfygDiAsPT8MJY/7zNdGcgqxC5fuorF+kWx2b?=
 =?us-ascii?Q?Wd7gN5h/XuY1pRYERsOg2hvOFl4cI4knWbrD9UoOxMjxguKHn6CWaXEcrj3z?=
 =?us-ascii?Q?FQ8LS/oPMEPLMSF3O3eaMqOZC6PKHsLfUf1//eXBKIaEkBtmIgopfYq4IO01?=
 =?us-ascii?Q?Al6wRkY5yp6xVRwx4BwEGBRnMfSxiP9E2DS8hjQBOzYP7Ay41VsHJFFSJufr?=
 =?us-ascii?Q?uSf2ffel43UlWbKAzwQPcTI29LooW0wPHm9W68fqifZjtanwEPZaUehLHbSC?=
 =?us-ascii?Q?tfZfs7qXRMi/6L7DL7JXODB+nZ7PK/cZNSwK0G7Ys+OjHkAC0IovnYNF2vrF?=
 =?us-ascii?Q?fvw1qH0Tq+suwM7h/JvtDTbpoa4IJdDU+TKEUMqo7RE5gj/EpZ/MxSg5LOfB?=
 =?us-ascii?Q?seL9wo1D9l1IkZRgZ1G29tpW8P4fdBtMJfPlSa7W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f59876-06da-47d4-8e26-08dc3489c118
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 16:09:03.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w28Eh4Tw76c4zopo+k/TBCdJkp4yEGQKBBDMHoTQXsbhpZid+TagiwdHXDHvJjjS9X+W6+QqqTdHEO5UmaiKJwF3gEMVtw2rnSxOVs2Oy/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Sent: Friday, February 23, 2024 10:48 AM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Cc: linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] clkdev: Update clkdev id usage to allow for longer na=
mes
>
>On Fri, Feb 23, 2024 at 09:18:14AM -0500, Michael J. Ruhl wrote:
>> clkdev ID information is limited to arrays of 20 and 16 bytes
>> (MAX_DEV_ID/MAX_CON_ID).  It is possible that the IDs could be
>> longer that.  If so, the lookup will fail because the "real ID"
>> will not match the copied value.
>
>Perhaps you need to add a real example.

How about:

Generating a device name for the I2C Designware module using the PCI
ID can result in a name of:

i2c_designware.39424

clkdev_create will store:

i2c_designware.3942

The stored name is one off and will not match correctly during probe.

>> Increase the size of the IDs to allow for longer names.
>
>...
>
>> -#define MAX_DEV_ID	20
>> -#define MAX_CON_ID	16
>> +#define MAX_DEV_ID	32
>> +#define MAX_CON_ID	32
>
>Do we need to alter both?

It wasn't clear to why there was a difference in sizes.  At the moment the =
CON_ID isn't
causing me an issue.  Shall I drop that part of the change?

Thanks!

Mike

>--
>With Best Regards,
>Andy Shevchenko
>


