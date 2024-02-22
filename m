Return-Path: <linux-kernel+bounces-75897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345CD85F06E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30612843CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C8110A;
	Thu, 22 Feb 2024 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIZpelOf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE481388
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576271; cv=fail; b=btmDMAGtvNkVYcWh4928Xxurys3hydpcgncGQfWhN9p+DDi2fRoOf2dy77iHNqrfrmva7znZsHPEOJEEiulz5OY/HpeiyI8CN/R4GzUjGSkd0QZ2owK50KZCu/Ceb/LN771KMZtFNmolDLqIsa1HVxdokhB1bPdBO08hsaSBGy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576271; c=relaxed/simple;
	bh=z1x4OoP70feLHELc/rRVPQ4b+NLq1YopD1ZaQSepl94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=srkZCC1bZ9LieZEcAB2Gg3uauYMnXHyY4B/eL43BNnN+B/66OQj4rc3yECsZcASJvtlfx0HMAPJtd9jRiq/LIe5KcbpKg7wFXrHkr4QYqgWSZ4h/ypV84AA+VkXLdUMKPrPSS67GQ0ppEtdKEV/oK975xaS7Jd2zbK/2AztGq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIZpelOf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708576265; x=1740112265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z1x4OoP70feLHELc/rRVPQ4b+NLq1YopD1ZaQSepl94=;
  b=KIZpelOfERWA07jPV5C0EZz7HNwTnUADawC/gPaVDGp24bhOkUHFBTza
   MwGrfu1Zaq4Kne1ITSWfcD4qQ12zO7LuApAxx2FJyfYHdRREr5bXuyoDM
   xf91lXfG3xsx11Q27aSrLB/oKLyrE+GChPFkMsimN+vlMmjMySJGPJgTx
   8OTLT/LdWDVoxCpvzMMv3/ZfpjMEhh9iufKcQcKSHoyJu4OYODBx677cb
   joE2TXnV2FV+q2Y7fYHL50rugZGUmoqBahmVHZfGkYwSxRk9MfJm7fZXC
   GgK/7s9UkSYuI4jF/hZTCZt4drvGFiP1BfsuwACYI1PgNHbR33uLLNDvo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14201498"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14201498"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 20:31:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10073744"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 20:31:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:31:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 20:31:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 20:31:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrE47/RoJZnMLnrlCj2oq1Kn5Xk6sMw+ieZV2K/2nFDONy7NoZmqeX5O8rbSqnEjdQA80dlcRvsfKIv3ux5bIyXLzwxgqTl3VaI4e1UmwBffR7mpp1TK6kUtkAqBNQlym/taBG+Gmo7ZaZaEDJ0hEwEYHkQFTVXQaygQrVAtQb4J8qC1S964XQefK4KiIOdBabJypmJ1oUTyL9Z3Ti5uhieDfiwo1x2SPxIGhksmcz+SLnY1/gkWX9nsI/fEmj/MrUhShAGFZeVXABNaFZqRARxEAOqMAnqt0Ad3zmTd/kS1mX8MnaYyqFKDzdQAk4cav1wM0wdWvL0443hfpq1k7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PszDN0bmzITVvZMCyLFyIa52AF9hMmsNDCPBJnWk5z8=;
 b=IFftifZ4GA6WwZ6WuxXDAtJIYCqbssTBz0dvviWMBWHDa3K7xfQXdT7pjHZqTgP9Woz6OLteWE20PvDDasvy8Y7a4pGb61np9EsdPqpiEmD8VHOvFGdioIdPyyu9aGCYVuB7txH+I0EGDhtZOq23FHHBqjkAV6zLBAGTcQW7t0G9p/qxUPyi/kk3GkJVMhVKWvNQNOK6GieeSuTNc3WlMK+nbqO1pJuLQLWPqy6/3UOtBac6nBq32gQnog9Qv4YwkMtL7cOU2UrcK844HwUExMlk+bgSaLdhrJVq/IxLbkI7ZhLHtPlmJ+wHHYBLRwxtXjMqEdEfEc3L77mojkyCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 04:30:57 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 04:30:57 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] mei: vsc: Don't use sleeping condition in
 wait_event_timeout()
Thread-Topic: [PATCH v2 2/3] mei: vsc: Don't use sleeping condition in
 wait_event_timeout()
Thread-Index: AQHaY23/G7Ad4wSizU2laz4CmCk5ALEVyEcQ
Date: Thu, 22 Feb 2024 04:30:57 +0000
Message-ID: <MW5PR11MB5787DEE4AE33992DFED13B2D8D562@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20240219195807.517742-3-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: 9e919f06-f2c7-480a-baeb-08dc335f1073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMwRVGM9EwP8DxapJtUCTgNacxxNr/w0k6NrlS5jsBezwxMV508aYDnwk2C7IqUDesO+MrK3pFIhqOg5P3EmlX+M48skOjXojReYPZLTVgrmVhmnt8/tZWf3dMyg+Srd6uOs1hWbvn+pfla3g78KdZ6rFoJ7XaDLwUFt9qMaCT+QnYq1fYnEYILc4FvVYgMdICTnCk1F6XFuj0a/5Aq6uCGXmp4Ye5Vj9BCvPe7G0WQfRUZClaEI7rpQ49XrkLqxuoDGnbzWdj8Rc2x0Bxf8c/HiLburXN6+qd45MGEBi4hK9Q8vXIcuAUQicTP5QFqGqfxKDrdUZgwagBfYxoMcFRcDFn1uCngo/n1qvh0lT+AM633JuOPI1mfKGmfMB9kWJo3ULi3Ba0I8FCvkQJYyUUO+au8j+rDcR2yZYuvE9TQtQiFJuSmYUsb/40GJxYFCNRdH4nFQ0Bje+G2bkL0vLnaAoJMaeT23RDq6mAEvrLbPDVJ1PGv9sZPvXMOVv5WoApAAd2Fie+BnSMyBeoP/hO2Yc3gQ920tjKev+vtWpVrsOQh+bUkkSGRR9NRGwXSiyGHantLA7nX1oPftGejMT/qq41xsgv8AQV5HNFxx0wVKxj1RXWNYR36GLOHc0jih
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xKjXUpRHzZw708EXalLvqN/fjPSznLILs53ZYz3Z2Whflv3GuLEI5ny6QE/?=
 =?us-ascii?Q?bKLPrSwS+IRZqM5K2cFHqXRkEYZhHi99pB4rXMXUswfUbW1UI5UqNpIg++n6?=
 =?us-ascii?Q?sLXTyeQPWRa/StNfl2aPcTQK3ESEWndxppatLTJwwKM4XEaztKdCdbrSKfDd?=
 =?us-ascii?Q?B+xuAygoMJSZP+lXqqSNx9QT3P0ksUnYxVnFFBGoonC50c6IOuJYVa19WwZU?=
 =?us-ascii?Q?RkBPykc+pddwwRYbVGmGgSWMipxpIutt7WNb+6PTgrmTShVtPioyqnX13JvZ?=
 =?us-ascii?Q?qLUsX+HzTidpYoNMj3tU3J7Hrd3G7rUt29rXapUiJO8j3aJQoXWFBfVNwNo1?=
 =?us-ascii?Q?YrYlCbITlkfaeVLI0xATYeT5FNfZzZtZVFJDU6gResKwTSF2C1GSAvfingwu?=
 =?us-ascii?Q?riU3hy6tIhggiytNKnbYfrCAEDS90yJSfu++vtayg10koGxUDW7d99UVv04F?=
 =?us-ascii?Q?OkTFFh/WY4QfnTeJzKDuf5dLPVd0jLUSLd3NLXRHlHvZH2VSH50Qo5bGqDPP?=
 =?us-ascii?Q?McMg0HZjh1YcVuaL7KDArc1Ki5lG89lGmrG8yJiwub/36j4+rhc7vdQgqwUu?=
 =?us-ascii?Q?cvY2RbHaVVxBpdXqfoUl/DqnlJ7rVA2zKyVP19Lap7ZFBX7sUXaHunhlY5zj?=
 =?us-ascii?Q?z8HmAwtU8s0CltpGH/xhg1CTvcF7SflE3jvDvJkKBZKGJv6IVdMN6ZJFacb1?=
 =?us-ascii?Q?8w9gf/Be7xH+F7S71sGauzU8wz5U3Iuu2BOd/sHg2TLBjAKlex7uA56sZwzy?=
 =?us-ascii?Q?CY6bmoK4Q1P/OGdQofCR4MpM0ZfwujTFM2uWlN55XRVy4gWucZ/1DrVwdytr?=
 =?us-ascii?Q?Se94odCo27hRache58EYxuntVG2rIg150r8qaGzVigaKmn5H21daew5c8BuF?=
 =?us-ascii?Q?uFr0n8i4tzwBUxNfU5WqVEBY4FhKn4/Dzloo39u0iAFZJd3Qvh8jyrr+uY7I?=
 =?us-ascii?Q?j+PRE1E32FKwlnWaFA88JzS79yVRCIHpJoDP9chp8MGnihiMLB3o1BwkZl7w?=
 =?us-ascii?Q?JeOrxA6U3wn96pLLSbieJLQFR+9mQ+sueAYgZWpA3dkFWLouohf5VVeRigjk?=
 =?us-ascii?Q?DYBtlA50PHevdMAswCNrL/9SMz09COR9N+citOGvGYEY5lhKXurvBaJjfoWz?=
 =?us-ascii?Q?gTf7dVq1NYNFE5q7nBUkqSLaKEOP/dOOiSUE5BVlcIWJfb8teGCEhn5nLxFy?=
 =?us-ascii?Q?neLMfwGuTA9cZ8WElMrxoC+bXIxdvpFLir1kDlG98VGZNA4KLbbqcLUQTqQL?=
 =?us-ascii?Q?vh8EixbqmCC2VOlGZQvQHfQkZkgEQc8UFxC9oU3vUuhk+FEdPARqrTMNywvo?=
 =?us-ascii?Q?NVn7IQud1w5E/758GMXGnLD9xvnJU2+yKmFxW1037Uf6pL2/XaXg17ewAir7?=
 =?us-ascii?Q?W5gYJj+HfPzyUPjOVamt3CKtOaJKHTytJ8qG9t48zmeoVQbZX29Lt/oDVoOB?=
 =?us-ascii?Q?GNNWUk+2njoJrhTIQvsI3WvKNTjL1dF2RseVTVLQ493yfAwgUYzi/+oqN96a?=
 =?us-ascii?Q?ytc9WzFZNqWhZ3Jzz1GV5Eh2uZEqrRIEJLJGklEFkPchZnazU3zGgXU4xoeS?=
 =?us-ascii?Q?efUQxX9wgAQz+vqHk97ygpzyijl1tC2O7zW0yoNo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e919f06-f2c7-480a-baeb-08dc335f1073
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 04:30:57.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uf8d+v02ZSzaiE8Tbw+Z1DvbMq3UbRK7CgdNxFwL3ahapnKC9G9bpRlAyX5FUukXidQnplIH2zrnEEr9dDt+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> vsc_tp_wakeup_request() called wait_event_timeout() with
> gpiod_get_value_cansleep() which may sleep, and does so as the
> implementation is that of gpio-ljca.
>=20
> Move the GPIO state check outside the call.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>

> ---
>  drivers/misc/mei/vsc-tp.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 2b69ada9349e..7b678005652b 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -25,7 +25,8 @@
>  #define VSC_TP_ROM_BOOTUP_DELAY_MS		10
>  #define VSC_TP_ROM_XFER_POLL_TIMEOUT_US		(500 *
> USEC_PER_MSEC)
>  #define VSC_TP_ROM_XFER_POLL_DELAY_US		(20 *
> USEC_PER_MSEC)
> -#define VSC_TP_WAIT_FW_ASSERTED_TIMEOUT		(2 * HZ)
> +#define VSC_TP_WAIT_FW_POLL_TIMEOUT		(2 * HZ)
> +#define VSC_TP_WAIT_FW_POLL_DELAY_US		(20 *
> USEC_PER_MSEC)
>  #define VSC_TP_MAX_XFER_COUNT			5
>=20
>  #define VSC_TP_PACKET_SYNC			0x31
> @@ -101,13 +102,15 @@ static int vsc_tp_wakeup_request(struct vsc_tp *tp)
>  	gpiod_set_value_cansleep(tp->wakeupfw, 0);
>=20
>  	ret =3D wait_event_timeout(tp->xfer_wait,
> -				 atomic_read(&tp->assert_cnt) &&
> -				 gpiod_get_value_cansleep(tp->wakeuphost),
> -				 VSC_TP_WAIT_FW_ASSERTED_TIMEOUT);
> +				 atomic_read(&tp->assert_cnt),
> +				 VSC_TP_WAIT_FW_POLL_TIMEOUT);
>  	if (!ret)
>  		return -ETIMEDOUT;
>=20
> -	return 0;
> +	return read_poll_timeout(gpiod_get_value_cansleep, ret, ret,
> +				 VSC_TP_WAIT_FW_POLL_DELAY_US,
> +				 VSC_TP_WAIT_FW_POLL_TIMEOUT, false,
> +				 tp->wakeuphost);
>  }
>=20
>  static void vsc_tp_wakeup_release(struct vsc_tp *tp)
> --
> 2.39.2


