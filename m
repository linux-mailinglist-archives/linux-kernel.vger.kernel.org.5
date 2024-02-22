Return-Path: <linux-kernel+bounces-75847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DC85EFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505541F23C16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68560168AC;
	Thu, 22 Feb 2024 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIPElUu2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EF1775B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572384; cv=fail; b=GvOFgUeLeyEfBoc0HAOxISJxtM4oi/wnSVLZPkR6F9WHb87Re2kd+UEGsuIBypOL13uYyD3Duf31Sa6kDPEvYDpiUAN7OTHS/CuMU4+JHmjnNMh01Kd28kA5hzqIvPj129fN4VV9G8tG3YHdYGahyN+wioPvO1cFu49pJUrLBzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572384; c=relaxed/simple;
	bh=mw8kS/eVrUPrxE7hXFj9RX0ksvUbt3LPWXC0X2MeFzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZghsSoKyNUVIS4GxpS2dzDwtQerPVqV2kwT+YNkZgJEdY/njtfOkPbfy5G7pWZMIaR19mjoy8SVgSfGkuIhskHODFVrk90lKSfDTG+pDbgSeZMKGtoTFEpPECvkMuDj5wjfitS3qg6SXp/yvsLoICqx0i16X0t0byMJ0uWhzVGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIPElUu2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708572382; x=1740108382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mw8kS/eVrUPrxE7hXFj9RX0ksvUbt3LPWXC0X2MeFzw=;
  b=PIPElUu2A4pqiDpZGQ2/VjSQflKp+/VDJkgBQCvacke/cBQeOcDg2fWz
   Cf51NsmJfhdykpX6Nq/Q4FVNLa99Dl0h+SVnCm5eD76TcX4EKr+7FAK1R
   5/ELrc6ZvcuQHm2ePQ4tOUVlZFxfbropwROMLbmAgMJDTxogI05PELxao
   SKFgfnLvFTt8b7J0s8ZNbHVmxd5lXTe/8/5M81R/CB/BkP2wMVzSdbyKT
   ui+hSG3BD0ehzmucmYbtzO2esz+/WvAw1gtW/sQyEM4xdKoDI5u1wlizL
   bhsImOXpsapvjuXKaxnk6dyZ+vxgWSlmxJkKJGkv7annR6dTvqHphQkBJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20206136"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20206136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 19:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5516884"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 19:26:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 19:26:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 19:26:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 19:26:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMyfyfnIs3gDe75fdS8elpJs1zcwL3VeISR8mF8tR6cy9To7OPPGWy5woN/Qun8ivGjbMgXdBLoe/oIMxZZRx6IJp4PoeUwlyPPRYH11LQAW1NSPdpvQtZntLZy5sGHDMBqrC4EcDYh8bfupcmOei7ypnhBjAuS6HRZNyYQgNuHsxmOagAO/wjh6japZKZHMHviKxdSkiaPW97MIU6w0ztBjBlcse9n+4v/+dlzEX70XuZCFl68xsox3iCdIn4oCDcynQuP+i3t3iZrlkNxdvKPtlFz3x+bl9PA+B7HxZ2XIX6xSRghhGqrTQigzK6rMu9PsiwRNFKT0zm/FGTYlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/qn4ERc3iNLjhMUw7KO3nlKEEgAXvk22JmXGvivKcE=;
 b=JGte5NaRVb4HCq9kSbXrMcjCSYPaxouOzC9R5a46HyzF2pUOa5EyP7/lT0GctaCmwC0+6I/cEzcR/YUvnwoZ1K00mO4k/2k4eQXJBRnWHD1JKbkKNndILU10ETS2SYN+PLG0xfDBgPLe/BPwf2chSEDQAMt56yz9eRVf0GqRen8tzicHeProQD5OSMy+wK1jovzr9Sr/zg2rLUAOlZyqgBt5HWiycP4LdpKiD5muUAui+YMW3AiM0uAl+OVx/1cAjhSVVC1uWULilocsEwuvgCADhcmzHcwOadDoSB0YzjmU/HvhEyrOdMZKtHmNe+Ar0rURvSBc64ZyTg41qPzn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 03:26:19 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 03:26:18 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ
 handler
Thread-Topic: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ
 handler
Thread-Index: AQHaY24BYYe2VBw7MEGkR20e9s7pwrEVtjmQ
Date: Thu, 22 Feb 2024 03:26:18 +0000
Message-ID: <MW5PR11MB5787130A75404600F47A7D9C8D562@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20240219195807.517742-2-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|PH7PR11MB7500:EE_
x-ms-office365-filtering-correlation-id: 3a137114-8e3f-4936-255d-08dc335608e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8APh/4sdKCo4GocW6XREyNF/qwjNpF0awWjMpH5lmL0E61ycb7V5rI9yUfAoKY3nt+s5rMM6oYFfybgIDk3sSk+uGGherObDJSZUCaLDmytO8f17EaYDmATKIrYrr3+9IbfCWsq8HLj8dpJrzv/Rw4voBa84PxZ0azWL/m+qljDhz+yIk9DxvhEWPhBIVw+S1hMhELn3REXTXhIuNQHAUmODn0Jlxh/3fuil9Wg+VJwHF5MbkI2tDRvJdDij+ULmPpta0Wi3BFlJmwts5hjR9hLg0S+UmuTBn/PpmCposLRG0tvwSvY+sX60SxvLi5diUqSRrjrmcla6To/5jAJP1Sf5aagxLTFdwDD3MXGsdJi5S/D7QhNXoTiY7dCKqUAEqghQHd1B+cx8FIFR9cstjk3VFYofPpfK6Yy3qJMdQnQO/DRzR0rk00gV0n7ErpKqEaJ7sSiT4DiDymwtIQv+6BibvJke76+ln1VqxvRD3kRf4U7UnRYOH0Ma7sDBHmD/krm3Q1SR1jCjEFpRkR3llzRUBqAJXR7MejPjTODodwDumoia5jn0wYOaOFLic0RlJO9D7rIYhmlI0Mmi6pPDyV16+AhMeIPA8L5M4eaFxMmqZ/tPVLh5+Vv8EGsrmFH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JhYbEXZ538/tnyl/7QmJNEuVPScP4Fu4sOYx4Ai5DjIsdeiGgZ0PKOQrpDI6?=
 =?us-ascii?Q?3ECFFqlyC76uLEnYMo2/100rRokjLNZY+ZEZ5Brjv3u5KFhoGlmkixfhPIz+?=
 =?us-ascii?Q?AXWB9mBt9Gu/3G7mDAn1x2DZTQCROkQeHBH3HFSpLuE5rS6PToMMYljmb/+G?=
 =?us-ascii?Q?L+8Zi5QNGFNHTojnsnT3tcVSrxZiPOxAq+A+CxHs87/l8lsPP7F+wD7XbVk4?=
 =?us-ascii?Q?nroFmaY01ecq/OtyWtr06zDMAtvOkps4rz31QYPZVeVnM1Bw8FZcqdzImwq4?=
 =?us-ascii?Q?EFLnwLQlXwsXa9iKG3n00R3o+dTakMJU7aLgfiSKTvallfFRQWervz21Rd2t?=
 =?us-ascii?Q?cx3qe1l1ufS+0pSL3w8T0bJp1y1jRppYl/udI/uC7OnytFYWNWhAzaiUp4jF?=
 =?us-ascii?Q?vTqgGEYqVA9TzFP+HaRFDXhG+urehf9O048GDC1Eu0vfWdfsUCTYs17kKLfD?=
 =?us-ascii?Q?Gh4B02Yo0t09PKO8Kcww07fDvLxD/MWgBfbVsruwjVIQaQ4SVKyLCjYAVfAd?=
 =?us-ascii?Q?vQHEXnmeVzv7Juw/f0QL8N7sf9QfgAmaf97bvSSvsQ6c4VwbRoVZaLdmR/qD?=
 =?us-ascii?Q?JLhe4f3zS+Fxp7XDfa6HXYvOH/dLNdFRhqrgjV1fU5Gnbm+znyONZ+SMT9eK?=
 =?us-ascii?Q?xWem71ZQgy9OxIKOmqCYvhht1JajU2CBLdJKeRzDshW01oTqyHR3Yd5NB3CN?=
 =?us-ascii?Q?cU2HFS8uIpXvEzCpqku04PFC9vNQJ3ZeUXlslrzSlacVSpA4rXiDh/bu40Gq?=
 =?us-ascii?Q?gUCJMO4PL/1ZZeRX0qtC+posst9tsdeGw0lZPYIVCeB3LCAFK506BtF/PSy5?=
 =?us-ascii?Q?shMPq5AEQSn64wc359nqPDDjQYN8M4R91fW5AYIF1MOgXvP5ROOc+wF/hUBf?=
 =?us-ascii?Q?XndIBSN5lZIZWwOm8uM3P+s7xcblctCWSkXBFE1xhwbRl09shOPIreCSefyM?=
 =?us-ascii?Q?nWbXwvM0UVRurLGQf37V56RF6QIQcBhRl50Qapeizs6JF22wlPHL09CX8UOZ?=
 =?us-ascii?Q?AE8gwvol4dE7oXXSsdG0kKu1NUJR+MMj2gGrfWlE9LbROWWzWOhNTDim4ube?=
 =?us-ascii?Q?gTxHCqPyyxTfsMcRD52cRKzkMZ2Tk98z8tuefZWdTj5JPDFs73/sJh3MDjrq?=
 =?us-ascii?Q?rdfvvTY924z0UCR7Xoqf4GNFcprXSzsACqQbAWmLcE3HvkNuHIdVRnw14uFd?=
 =?us-ascii?Q?zzGcc5gxr75iyf2uqvD6AnsJL0RnRDBku0iWWFKcztbdZbXLtqrfY1SLYtWO?=
 =?us-ascii?Q?AGYEwia264a2xFXWYOFBK8lPvy+uaG0HP9w9Pb0NCebicAM1h7mAnw94Xcij?=
 =?us-ascii?Q?aykiuesi964hU4Mzniz5NAdMrjzZnfALMfvJSY4ttKyS5XLEga2Q2puak+xg?=
 =?us-ascii?Q?j6D6/R6WaEImTg94Hv7wTAUASM7QMcw7i0ykiO5R+E62NFBRGXEasAdZX7QP?=
 =?us-ascii?Q?j3t72QfHkuzMHrTd5WOZpbMkSHiCXi4ewQiOD+Cc1f+ytbcXxcDhBiM9q0CP?=
 =?us-ascii?Q?/lbBpRzpiEqGEXUOggQcVjpc/ZouaXg0cqBk9FENBlEB3yGnRjk8qClig+A5?=
 =?us-ascii?Q?a/VLyC5aHfq238iJV+JotlfOZMzfpR+IoOV4nD7i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a137114-8e3f-4936-255d-08dc335608e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 03:26:18.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ6zWx1bmo0tQmyPMuLw+zX4NgQUYjnIbsc9jeKvIq0VZNzTSZbf3+Mfn15VA6nGPUI2+idF7ASYVcSTApEGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
> wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT.

Does this mean we can't use wake_up() in isr?=20

BR,
Wentong

> This leads to sleeping in atomic context.
>=20
> Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
> where it can be safely called.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 6f4a4be6ccb5..2b69ada9349e 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -416,8 +416,6 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
>=20
>  	atomic_inc(&tp->assert_cnt);
>=20
> -	wake_up(&tp->xfer_wait);
> -
>  	return IRQ_WAKE_THREAD;
>  }
>=20
> @@ -425,6 +423,8 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void
> *data)  {
>  	struct vsc_tp *tp =3D data;
>=20
> +	wake_up(&tp->xfer_wait);
> +
>  	if (tp->event_notify)
>  		tp->event_notify(tp->event_notify_context);
>=20
> --
> 2.39.2


