Return-Path: <linux-kernel+bounces-5762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21225818F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC10287897
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228A3D0AC;
	Tue, 19 Dec 2023 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYCA+72H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723D3D0A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703009035; x=1734545035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=py2ZssG/xklV48QzBtIP/6/PqFkoef9jd36vPiMxVl0=;
  b=LYCA+72Hxukkkv1dH+qqcouqwakfro316h+mjBueVHfbAJdaXM233Qq4
   BZXn88D1bPiTmM69dFV5KjGf/00uitbEMV5aLnNQp8juUzdCXSpZ8R639
   cQyoDsoRxaIgL7fj7V+ClCm9X2A2tUiuEsDosU/M0ZISCIaFLuVeOI5Ry
   Axg8CHOvRxq0jGFHI69o4I5MAheO7cr46hKE+hsKIMenZCv9CaHSDfYlR
   NNo9HABKeCt46Xl9wbiU//Tr3EKqussKy7VPbbdOYXqDJdvyP+MwdQw2h
   2iNCLVcSutHdMV+fdjvKkInix+VmdozG++Vu2Dyem6Ifn+NlsMzZsb46m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380682411"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380682411"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 10:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="804978252"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="804978252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 10:02:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:02:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 10:02:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 10:02:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9widJCoF5HtxKZuRHYpGvaxSaCVIuZSsncXqWXcBLVxjD1wqNSNe4u6e+GjyAUlA4vGWeEMh7Bk0Y80WVbCtvamzOFOdLlkABhBCtdtFL162+WGE9jyI8MzKu0kL7k+j5w7eaf2P+Rxdyb8UNiaAYU0t2fXP6dBgRq3izwfESxYdi950Fdajojy0MvR8w3XXy8R3AeKm2HFu7H84y53TwSRWApKIwjR1PQCDQi++iyFxWr67LExoHZuiJe238S6SoTL3LmdYlLUKJerM7mg72+mR66k5d3AuFJ10ETwDnpm7M8e+IZMVPLnkJAcvNco49nBJFPFDTQMisDpTE+6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBrqNVVZW6ulBFD7auHdFxPR9Np1lhtveELrDiI4hE4=;
 b=jipej+VnVjtVf0Mce/rAJV/DuDSaG0ZcI+QZJsWte0DOsiGpVsA5TYvUxyt5PzThaYFWZz2LUZIp+VhnpbvQKh2qVpmROBZA1WchHeuTi8fSTRWMfaIDayC9PfHYz3U8aaBx9y1GWXiQH1OxHQSDcX0JZ5ziWWum3+v4E5O6YXEFtQAqvuEoQVGuhWqLotOmdFmOBylmBvPQFD9KvbviWgI7qQ0UcfFkzXK1mHgQU24kTC8IiT3L7XLm0EjAWc0ONyYTgJs0CgGfMO0126D32vdryeBtqruMLaHY+UH+GkRuIX8vYFWS4TriJOnLUJV13hUWNFnJloJYDyKZABbT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 18:02:34 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 18:02:34 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Weiny, Ira" <ira.weiny@intel.com>, William Breathitt Gray
	<william.gray@linaro.org>, David Hildenbrand <david@redhat.com>, "Oscar
 Salvador" <osalvador@suse.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] driver core: mark remaining local bus_type variables as
 const
Thread-Topic: [PATCH] driver core: mark remaining local bus_type variables as
 const
Thread-Index: AQHaMpEHnG+TLmy1q0aP6ABzV9Z91bCw5b+Q
Date: Tue, 19 Dec 2023 18:02:33 +0000
Message-ID: <MW5PR11MB5811AB2DDE57E309A329F5BEDD97A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <2023121908-paver-follow-cc21@gregkh>
In-Reply-To: <2023121908-paver-follow-cc21@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: a0d707c4-f766-4176-565b-08dc00bcad3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7pX43jaF6CPGmXykjSRT5iGF9xYQhWB2MVbSqEiYu7zbNO671Bdeb/DzfPF9FyVAaeOSGUloOYq+S9S5Na2J7ADYi67G5l94EEERpAypgRwsgSalO9gcm4jTKa046K3IFIokFShPD9x0uCfef64ca7FLOvPyzwrwCUsmrQfwiPfORYWcgg1uwyf+4YPFF3/cmlh4+DHpVBmYFINBSoT+arrp+M7V65gjTEICVd6XFPwazlVl4GO40kSV5RSO6V9vhebn6TZAyihONBbDwrhhOpao10I09wAcY/2Q0LhHjYkeZKCd1pzxdAlOTkBPZ0u7KzIULS0TL4SkVbwdojAfsWuHnOgLILCSAtgpG2tuv3zloEwHv3PkTI8ugoiOvgP2AHJFdTMOXHYkVro6c57QBy/KZSyDzNJoFBR9YHA9cBdC22pdpp80nYEW6laxNINLErCyT4lcpt6bzfosgnL+Bdf44GqpNp9R7/q0BTC2kTDM92qeSkLOeRyiMXW+qPq8VQKcwcvJvBfx008gfvi759YwSiGN2nrF8l6DJY8ezIBW4uGWk1c2ALyEv618Ry8ycd6NNSdalYSre47rlVUf8UK3zfz1f3hLeGNs54RhTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(122000001)(86362001)(55016003)(2906002)(52536014)(71200400001)(4326008)(8936002)(8676002)(110136005)(66946007)(64756008)(66476007)(66446008)(5660300002)(66556008)(54906003)(316002)(38100700002)(76116006)(33656002)(82960400001)(478600001)(9686003)(107886003)(41300700001)(53546011)(38070700009)(26005)(83380400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g2dN37qotdC6dqlwybN79TCu9hRin3ivKXuBTyGeT5CYHmqT6nxrMCwjBKjF?=
 =?us-ascii?Q?wDrIC1hnazpPBki4VOd4eAbn/5GucLTDEzdMmqq7QbUQ57qT62o8IPDo3h5H?=
 =?us-ascii?Q?7G+unIr4uIedHLiZAYI8vgVvBwuoWFgL0TOjNLJHOQNrJc7SjMSFJKNbDu3G?=
 =?us-ascii?Q?0bUqWQXdd5E0JUdz/Hm3FlgrKaG0XjR36z6uXiejnbPWJ/zGUEvfrLnjHDNg?=
 =?us-ascii?Q?OFyVrrvWXxUxiwMMKfwspWKItFmJfwHxSNFKj1WY7RuU1ql5GRAsZ679cpZc?=
 =?us-ascii?Q?fIQIjm4eSZi1hjkxFMjiNHZddsfhTiLckgSUIN/+NjK+fARx53+qVYTxyuYl?=
 =?us-ascii?Q?qWizLMNnrrNgw8TQIWqskJjsISqi+LfQpWraPeGo3cyL9IdUEoqvsg77O2RJ?=
 =?us-ascii?Q?CykVFcJaGprdqmflgD55pNVUHvlEcbJZefAxH4Zvu1RQtwoFFISAabjEFNti?=
 =?us-ascii?Q?doW6R5yiSzMK2QZJw88bhiOIuroudyvJqX8FOqrudchHszrv3NupUsfaAi4V?=
 =?us-ascii?Q?T73X/kCH8RYbuu3+6sbbbLgH7PGvnK1Poh7Ywb7QhjnVDQDBFOxswk55SVpP?=
 =?us-ascii?Q?Ib8J7XRcKitHzk9MD7felMmACOWkx0IeMqWD0lvttIZn5Zgc79pa5A3fnsns?=
 =?us-ascii?Q?xwZYNabZ4kgu31IiuNB/INqNhx/lvvjmOqYBp6S9qCr3IXfrgIkXSC+KN/FT?=
 =?us-ascii?Q?oV2DvB3vAracSZD8uf8/FI3t44J8KIO0am8U4LFzKXf/yeuO6bZNVmMiUhpt?=
 =?us-ascii?Q?o1kE1dYvgvYER8cIhch9hBEfRAEzXg+cQXfiwmBFSZD2/bsWbbW83y4Mir+0?=
 =?us-ascii?Q?xX/5cyA0tn6+YE+sf+cvnuR5+NpxL5aLaYlm6D5YAmBARbRIyP15d9w4txW4?=
 =?us-ascii?Q?565n09uI0rbMWsktJgvwROWzFgjJtd3mDrxQN1hV3F/DX26V+TiXRPqP6wBN?=
 =?us-ascii?Q?+6skj6ZmMfN02PJmo6PJ3AX0XIKo/KbjSxgIaxGLvpa4QysBpLeVm0qObwhE?=
 =?us-ascii?Q?152ABYVvaa2yztKjU2KS9TfPRDxS+CZRqvXusDtuz6H1MBvRVmXsqJbUk4Kf?=
 =?us-ascii?Q?YUOs2PSkBGt5v7O8CgmbQ9ow5xdGcIQura35t/P8oSv1CodM1wY9jaKUfXqh?=
 =?us-ascii?Q?DxmidLRP3/EMspAYLmQnkNEX/G+IE8C5XVr6ZhpwZu0FbmOLVoICF3SEogRw?=
 =?us-ascii?Q?X3Kwle6jOkpNHzGdYC3a8L0YEhnZ/QM3mQWtmrdfEcn6vW2yKrzh46eNMB0Y?=
 =?us-ascii?Q?KQbnt3XNbvVfFsI1PTMYwtEeAAFReAIZp1JY64sO37F81HZMUJtmoFbcSWel?=
 =?us-ascii?Q?ylYuUeIYIj/Awg7lPgd7IBdjrh/C6zTShc+6KG6biEF0/IARMmXqagUyu+zC?=
 =?us-ascii?Q?iVTJrore3iBcpNm3+UfDZPM2Im9sl/ZmK0d7BHhavTlYKzVp0mk8zvjno5R2?=
 =?us-ascii?Q?pN9CZ3RErw6+mcDxHfOvXbAAdZ4ZIIpLcUuhbHn3FZGwsHCUoD5ChM1EcBWp?=
 =?us-ascii?Q?/ZXYytRJrDoOTcE5lp3J0/9Yer//t3u2Hz7r74VZ1WJzsdB/jnH/oAcEUu+d?=
 =?us-ascii?Q?LLNPtHr7N1lJy2W5VguZMvzzz7kS3a/CJKjRjT90?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d707c4-f766-4176-565b-08dc00bcad3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 18:02:33.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQYueaq/OrUnmFGJPJJwIhVYXfLnoT37Q88NpuyJuhL+s+uEW+J9QE4+j4dyMul76MwvANyByO5V4gzvzOlVshfsIW31lvYwz4MkXyLhY0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 19, 2023 7:35 AM
> To: rafael@kernel.org; linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ertman, David M
> <david.m.ertman@intel.com>; Weiny, Ira <ira.weiny@intel.com>; William
> Breathitt Gray <william.gray@linaro.org>; David Hildenbrand
> <david@redhat.com>; Oscar Salvador <osalvador@suse.de>; Kevin Hilman
> <khilman@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Brown, Len
> <len.brown@intel.com>
> Subject: [PATCH] driver core: mark remaining local bus_type variables as
> const
>=20
> Now that the driver core can properly handle constant struct bus_type,
> change the local driver core bus_type variables to be a constant
> structure as well, placing them into read-only memory which can not be
> modified at runtime.
>=20
> Cc: Dave Ertman <david.m.ertman@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: William Breathitt Gray <william.gray@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/auxiliary.c    | 2 +-
>  drivers/base/isa.c          | 2 +-
>  drivers/base/memory.c       | 2 +-
>  drivers/base/node.c         | 2 +-
>  drivers/base/power/domain.c | 2 +-
>  drivers/base/soc.c          | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 4d4c2c8d26c4..d3a2c40c2f12 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device
> *dev)
>  		auxdrv->shutdown(auxdev);
>  }
>=20
> -static struct bus_type auxiliary_bus_type =3D {
> +static const struct bus_type auxiliary_bus_type =3D {
>  	.name =3D "auxiliary",
>  	.probe =3D auxiliary_bus_probe,
>  	.remove =3D auxiliary_bus_remove,
> diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> index 675ad3139224..e23d0b49a793 100644
> --- a/drivers/base/isa.c
> +++ b/drivers/base/isa.c

LGTM - ACK

DaveE

