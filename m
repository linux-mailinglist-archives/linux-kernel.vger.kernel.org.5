Return-Path: <linux-kernel+bounces-84660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45B86A9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15858B232D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394B2D044;
	Wed, 28 Feb 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggtDxgkU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD2D042
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108350; cv=fail; b=t96Tqg72eDllBUgQ78BnR1wJ7VzVgKnnRd/2PE6DOcWuBZtu6TwcbuXyvWbhKz3Q8HcZoO7tScMfXYtL+a4DrBm9Rjuli3deYaU5DJUBlOUFM5K9AfXdcJEiwyawmDU5RdVPPPBV3Ywn8ioywpNJDwnt1BnZ02WVauxt/XZ1SqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108350; c=relaxed/simple;
	bh=bYiJQdvoGJlmI1Fh6UB/tewlIgcLXDixY9djQUiiAmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPqkTnC6dZDQ6ulu+IK3ojgGbhb9tum3k08KIxPAVPyr/DQ9BWXnzV8fxAysqfPGvZul96vMh3/YSEW8gNX/tKOWrTFeGYqUR0VDrdGwlh/tdrcahPob7YsY5MNcHa9RgCuWJcK48YhG1zANfcUrej80D80aXOaPxg/PsfRVpyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggtDxgkU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709108348; x=1740644348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYiJQdvoGJlmI1Fh6UB/tewlIgcLXDixY9djQUiiAmg=;
  b=ggtDxgkU1OWSJWWqLL8RQVhWcKX+QnINgOx3UgEWMPMKh+0CqRK5YkJa
   PNWN0aY8lBqHeRl34clvUvuNOcyiUtJnPRfDSrqELypIX6FJIgeXksRtv
   WC/Q3K9N1ZRDDpKLl9mRhCbp92Pe9/YDUc8qVBfO8vVNDmSli6t/WZCh0
   wEgwwPXcDD9nJFaFq0PK+M3qKs03F00OjtCES+nfYdb5bZZnwr87ot4Di
   LrcdoeJ2IVzsbp9kaFWvcTuITIRaaRNpKGRq6/QwAmVD/5Mn0gKD/1rfU
   LxiX7f4pCjp2b4GVN1hJuNEkvuOzJ2j980HLHRn7yQuiUdCHRdScqJgOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="21042393"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="21042393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 00:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11972480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 00:19:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 00:19:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 00:19:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 00:19:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlRQM++y5MNLENSEUtYjedGFJp/IMT8DBAmrGi+EMuNYTNccVggbZYtmIC9y6/DNLZ+i0zGHVWRK1WBhUSGeurhjtrrya4vxN/uB5I1y2G1RHBPUBYp+EXlbB0pioPp/tejc9QizoqaEZiwU6+2lvI0SLQ73QzwMt/wBnI74xsNYdPJsZjzufy71dkWpIhIxr7MHe7Uzx0xaaqo2dP17J28EFiyEvdAKfxWlfb2JoUKyPI4M3ZfSiitHbhbWfsBdpYlcieNZrXUVEfE2MOU9oKd3xj3jPCCEWLuDNGnipaYJCbyHRvPZJ7mDOM+78FasUlrs55w6oUtI62X5fgJx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnmTqhZeMKZCjoo18tX43hG+DyUgyBuKlxhIyTHM/8c=;
 b=BCB44dgIldtCXIeFUdvZqkrW4kbCNSbZZtZgbWR9c7uSEH+7/vUljWjsQhzz7o7nadYQAfLMTQj3PA0zeWgEw+lQllDMgOwXtjx/S4emrzU1IooBHJtpon+jWkPPAFciGct+wWMOmYdgpweiMG98tvIAxDvdh/vgfL8fdifsof12FVTepxey6rMTeJabA6hyjr/6kz4E2Y20qM8qIDJlfSesXupNajqo4607rU8gcmGJtCMMuqwTKGZ/qnsNj8Hbv6nHKUulGRwXJ/jAMd6vjlNI1awneKfpMXwOcruykNf7sK89LS8utJg9Qx05eStv8V9JGkTtqu2xDFjlIS0BAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.20; Wed, 28 Feb
 2024 08:19:04 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2%5]) with mapi id 15.20.7339.023; Wed, 28 Feb 2024
 08:19:04 +0000
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
Thread-Index: AQHaY24BYYe2VBw7MEGkR20e9s7pwrEfdnRA
Date: Wed, 28 Feb 2024 08:19:04 +0000
Message-ID: <MW5PR11MB5787E314C6DDA3D37FC1992F8D582@MW5PR11MB5787.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: e22f91a6-0f9c-4d77-2cef-08dc3835ed10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwHchRjgvGQeDLjdnv7H3vNi4ckeGzXMGH4Il+Y0vXGAeXR3qxBnw+Wmfga+IcY1n2UhF3V1e+kpGXKdNqDEi5W33PzvM3mSmbon1/BO26goSwLWJ/BVDvX/p4xivzUrm6t4WZLpiNxdFgGikTkGzdP8Gbtws/DN50drLg8ko77vIRxvYbL71ZG97aI1V/K4vs2TPagEox3zcXhwmiv0PE3CqekI0hvo7JvASlEnNR7WaAZu9NVQbZMcouWzB/zmKBGlEr6B4SjeXiMsAYQUTlGbmtkr3ihaH+t8YQ11WHR4QQCMShC8CCkRr/HejncoGwW64LaHtSNWlrBKImvsAlfFXGOUzBhNu+d+eVKxOKM33/6C1JWwo9Tt+KSRP8nP+UeFT9h9xzSecARDR8H9gBB7VMB9o+UcvfsSL7jH2zbcDqeCRjkMpS+wIfGoNPir6JPDtILZeQa7kAY10dfPMdLDIETIFV7hhW7rYkBdAIztZzLmRMzRUxdOvI95TjBtw1057juqKE/HD71etcjDbwVesJvD4CnoNFF1c/Nhoo0xbpgAlx9wzEc2F2zcNnQD2UU1GGLI9t+W006oHR01jWXIlWAhQ1lPHQsH5rsZrNRg+W/xMf1k1ElMtSaNdfuV6r4ut3amU/ZiZmPO5zzhvx+0OQPsd1kDePxJt9CFzdC5mLs6NrOsEWjxWwSPn7qWW4vFjmRgwFU/kcxbYVhpINozk9x7dbdgzk+EIbcB0qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ogUtpj8tc7/Eck7cjLwtFsOtZLZ9P2AGXNVqn5XiMdAEbFHjOE/8AM6BudT9?=
 =?us-ascii?Q?9YVWTSga5bPKnHlN0KTmGnhbCeDFL7HlOuDHoxeg85pBQ6dvjISw8wv11YOh?=
 =?us-ascii?Q?eK86IXOI3BFsJDBKg707p4UD0RI6uhco36kFsNjj5Jp8ljIo6A/z7wFml/kq?=
 =?us-ascii?Q?VIIBeSVb2uXIEfK4FvFR2+zXBlTQTWvmO33kAYx9fgliNR2nYws8UuzMDikI?=
 =?us-ascii?Q?xMUI8RG8n5ohfx9a/0qYBp+3aCihz6KKmH7tNiKBEcD6NdVve97FlmcSWWKO?=
 =?us-ascii?Q?bf8QuyjThlJlKYYe/IRRms2IBA87HDxDHiwVUgMh1oihMs7dX/QQPCpiYrqi?=
 =?us-ascii?Q?FzkO5sf+dkC2ve5UveByAJ9jpsyKqfiow6OU4Ilpd3Nfja9fdQhszrpnVP4X?=
 =?us-ascii?Q?L+fRahG/n3OzHzGT5xAGba1u8q+JYefEXdKTF/cTbMpa9MKn7pKUIhg6T7Fq?=
 =?us-ascii?Q?px9CY8H7D8ebFKoBJVcUGTo4FsKUd4FReocvT6dkT+O2ArTjvnoSZrd3UzJa?=
 =?us-ascii?Q?g17qXeNVp9zzH4ni2Rc1ICotvx6PDmxmE57jE8wPihqhdsd5u8SBjCUrqTS6?=
 =?us-ascii?Q?O4pgivcd3srVRfDkgyhpgtzUh8ksu+v+FayeLLfQcSsVH/ZYVDGCxO1I1fmt?=
 =?us-ascii?Q?dg7Jifs6BbGC1oPutBPuU245PzaXckHNulqV+JkbmC/Z7liXj9jEfimtPWyx?=
 =?us-ascii?Q?3fY4IdIlB3rFkZKXPs1YOjrtBQI+bnIGOD7s54HydLbfz+jXI0urcLjQevm7?=
 =?us-ascii?Q?wacXtLL3+F5rh72wLxrUylcZAO7nvOxcX651ACJaQD9rBZokyTCuxuPrVgHH?=
 =?us-ascii?Q?iOZXKLb/u0UEQ1MhctpdghPIqkc3dDT0A1X0X/MyOlyqjhLW90/HWPWlIjFi?=
 =?us-ascii?Q?Y4TCOYoG4HD3mzHGBjVQDtvkOTDU9hfznmNAArjiTLNUrL03E/TtL/ImTwE6?=
 =?us-ascii?Q?9lMqWKaDarptjjxNXU3tCcxXtWaYbZRV7U9zyBJJKNwE2B74M/0rflDyzjKu?=
 =?us-ascii?Q?3PTl2KtQSB2pSrCPiRgiRGl3lY+ONeyXjqfJvNHrO2jhKmEj3ezWaFLaKZ+D?=
 =?us-ascii?Q?iwlqzs5Di0yWumeqeOhAwKujxfyO+/i7R/J0LwBuGfmNTymy2fulZwFojwXy?=
 =?us-ascii?Q?6flChJSZwI8hg8fbYtenBjtXLxTxXZDHSAYbrUDieQrP3+5jdBdTKi/mzTyz?=
 =?us-ascii?Q?z1eidY2rASjv/Iz5S8ezvSwDx1zXDh3yHF0o2e6OdQcScaS5UHInxKXKo/bx?=
 =?us-ascii?Q?UWfi1/DyfDZJlnEvRHfvQ2KocK3BmGbgEkQv1Wn2+92xzOCzmAETNdLPh8ej?=
 =?us-ascii?Q?+F+FxQLk/8/HslGmobSNHqs9qyMuaxymi/m4EkLyF6VVdaC0Q3yB2tgM2N4W?=
 =?us-ascii?Q?5+NRA4+99hR3QBMuFhPOR0gRAUeqYXdyhUDlNGyOdiaZgb/ziaybVdlyIdlf?=
 =?us-ascii?Q?Dp7DbH5KpVMG1vVhBL5lPlxw25M0J6P0AZyjquj4IL/UTgTsmDPzonZb5J1J?=
 =?us-ascii?Q?QCOYTco0ovATPuO+OBEVX9zaKgZyNU0Ga2QVVhPZoENzqwRQh3YwriQCKfFF?=
 =?us-ascii?Q?OuRx+yU9z/hGaX0P3lsXIiNYQnSf8YppZR3DMEHK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f91a6-0f9c-4d77-2cef-08dc3835ed10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:19:04.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tnvmbkaOvXWfQs4e1SU3Ui/6ver/NYnG2MbTt5THvX+NZY1PhwPkLnjmhsLwzjk6tj3EjneXO7rB+juDLxkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
> wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT. This leads =
to
> sleeping in atomic context.
>=20
> Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
> where it can be safely called.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>
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


