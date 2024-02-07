Return-Path: <linux-kernel+bounces-56045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220FA84C545
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD58528C1A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5B1CF8B;
	Wed,  7 Feb 2024 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B25nkAt0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F871CD3A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289070; cv=fail; b=nHf5pSXnzcwLtd2qzji+6WphLCLmp6+ZLktaUSoN1yP4ku2pttnDEZ5R7aT1vT2jtXqGR0nu9O9XQj/jugnDKutRYlTF7+/d583sZlm47xPQt2SkyNUdBb9LS7+mL11rs2OWOZKEZOgZiDzwhLD6UZ7XUbcCC0ZYu82IUBPdnTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289070; c=relaxed/simple;
	bh=5ZchEAyOKeRc28EuQLm0J1U3qNEZFIqvL4M2M5NfEnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQtTy2hbR88h/gTTa6cZjUHzFBHxMNfc14uR0Ie+mRXA7D2j1D6ZMWiecWQ93qHk9Z6NnD0cuomGAZROE6SJc3CfL81md0a7u62AFg0TISUUX7uLbv7k130A3FEKlivFmIKTKJpo7IHjEgn7qxFddPCm4z0riNOMV6m4/hFg75A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B25nkAt0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707289069; x=1738825069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ZchEAyOKeRc28EuQLm0J1U3qNEZFIqvL4M2M5NfEnw=;
  b=B25nkAt0u7aPUuLt7xSG7sDCG3r8+NumVxr75pM7XRJlsheFM9HctL31
   rIDxOMWQfMpRqvmMMK4E/u291hPgGDKMUyJ4SeHj5DyKRrRCqGqhOlLew
   S6XtccPoD8bnbG/DQEnElEGCUR59Hl38O3KVnUZFIRj75cITyaEOc1cvY
   ikbOKpDHxh5csxo/lN6iyXXI2vHrs0rymqsT/+jvvkGI+ZxHv2LcWvP+v
   OyKWLpRxg4XK/ecFNXj2zaMpj16os9yKDoPyWqGJhEk53dZ6syxxXJkPq
   i4/5gPK83jPkrBBC+lLLztLufuy2gHgWyV2ctqIqRiar479RzsTR1VG13
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12008595"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="12008595"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1555991"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 22:57:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 22:57:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 22:57:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 22:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhqP3o1Qb78ndRuaR+MxuMlsdVtGXtTSvY7zCJ6RbD35mq9qY+HXam0y/wcKCwRcGoxgfhootqwF/iHmSQ7xtnqfR/mBu3SIQ8EHcHT6FEFwVJHe9pg5a2CrSsx8N/FDnscnI+wzm99MCNJC3Stss5bUNNj81hWScDQ9OWA0STNe0Zk+x8co/rtJaoTOVnGJTzd9kv/lZ/HCg1SWkCOWC6F2ByMv2St0oXBLRNXuJUHpxbUhRduYVnYrFP6eADh3UBgfyOmLcxxbZ18X8FqwBjxebEEOD/ZGJn7D49AJaPJals+t3oUeAKXxbNqmd04FXPdIVR6TeYxJ8tCFlyPTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPjDzXoDA6B5ciPSAFLFyTGoZXgSy9iDFzsQo273SxQ=;
 b=MhD67x4qb5weHqCsDhec2eC2mC5OyJT8NBbjeib38ti2ekaGv+TW/MMTBk3XzMGwqJ0ZJWN8qUQKkvhUeKA00F9LcSsuIjm9F87SgdEvF9JucUXb0RCX+9+Ni8S8JvYq5QsmOhh0yaUYJwjcUKUvuzHliI4GHLg5ljx3xYYzQZMaYn+ArAA3djLvuYeag3gi3buxguQEA88nFfq5/+Ne9im0ElSvc2URY+myei+hcPUmZAqVtw6KKMy+CPiUq+r+bZ++v6P6kFoZV/3BQIW9kYZw8eNlQRQHK4iw9COFbnLo2vDVgXIyEsATCKfGc4O+dNcvMMmI+SPtiRwi/W/dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by SN7PR11MB7465.namprd11.prod.outlook.com (2603:10b6:806:34e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 06:57:45 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::c138:faf0:9fa7:8a03]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::c138:faf0:9fa7:8a03%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:57:45 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, "Wu, Wentong"
	<wentong.wu@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Topic: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Index: AQHaWV7Sezftrxbl60GSqveRb/sUyLD+bxyAgAAD8lA=
Date: Wed, 7 Feb 2024 06:57:45 +0000
Message-ID: <PH7PR11MB760526EBCB4CFCDB19A03E40E5452@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240207004304.31862-1-wentong.wu@intel.com>
 <ZcMmg1f8975whpno@kekkonen.localdomain>
In-Reply-To: <ZcMmg1f8975whpno@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|SN7PR11MB7465:EE_
x-ms-office365-filtering-correlation-id: 8f92ac8d-de91-4f81-4843-08dc27aa1681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cqeDoodPA8n12WglY5BWeMc0o/ScNXJ84sCfMuB/t9t0v6jfXIrbIk+F6fwlgPCcH0E5PUGSq6i3TTrJd1bGzKrbIrSxqpjaVaGWHgHHz6hfzgRDFL4R9nAkSF8gVc7dD/EF3swIl1AolsxfHpO7yuwpGPnFQpxobNbT+G4kJhBg6Mh2ZP1YlDfBzZKm/tTMaKPXp8O/QbTf+ceP1pnQni1AmSD9n7yGiLFZEGkcHrILsgxS084oZbf/GLkSl8kLS9ic5ZLhssU+kbyeJt67+4s987NfISWK6bNgCr9vPncyzzOYXfDw7kpDivdJ2F+rlMfAIsl0FpF5Fyg9Z2Gm8xC2G2FCEeFWL3mHCcGCFumGuyw+o+3EXm9ucwyR03tEAzm34jbJ+aWhf2xsp50uRNjyX/q3xKAhyNDOP41KVxj9i1VPhTJQxq4yrjlvRZ6scKjce6MGk1FaByNHSGVibDquMuyjDN/I/MZ/2NBG4KwBsPRW5Sd+ZMooMOjXZgT3o8ftveCsx/eHKGRDp3T3ore3Jg9+lj/saJs8mN5Rv+cokrwKZjK+15+M4Dyydh+rPt+iYnfIkU9Msl6kEmRIkkrAA2r90ss3Yu0tkNAfGdr7BbPOiO1K6iE2VLCaVTAR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(86362001)(41300700001)(4744005)(5660300002)(2906002)(478600001)(38070700009)(110136005)(64756008)(66556008)(54906003)(316002)(66446008)(6636002)(66946007)(76116006)(66476007)(9686003)(8936002)(8676002)(4326008)(52536014)(71200400001)(6506007)(33656002)(55016003)(82960400001)(38100700002)(122000001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MK7LyEDZxsV8SkkkV6X1RzDrFjk+aQclQ9So5uXWzd4rmgstoLgTjXEJPU5k?=
 =?us-ascii?Q?yFs/lTNFWcfYtFQB52fZ+Lq+2n3D6rbSgg5sgL1c26rn6CRoqmqDUEuE8vhF?=
 =?us-ascii?Q?XnLNMJ9mi3kYDg//bs3RrIesAdLLkJsm7iw+ViH0gAJJ56+ciwPzgpEIOUeQ?=
 =?us-ascii?Q?y42A4xaiH1ngj/V9VRKMXHxqsKNfHRV7yfK++bPEuzXLNNJmWdW8YwLkNDIF?=
 =?us-ascii?Q?4kP2Dxm6fKUh1fdmUTyno61ZOov6mtlhTqEkDh9iC7ypjeGFiQlu0ghmMh2t?=
 =?us-ascii?Q?qBoEo9IfCxIziV9HqJdOS2JZAIh4GXBDB2/lu2qB7dRXX/QCiZ9UHHMEkc2a?=
 =?us-ascii?Q?/XQYR6pAOlrJrnPgWfVKd1pjyaJloQFp/7hRq/tw7OtU+XcFjfn9AcJgV1iz?=
 =?us-ascii?Q?Pv7ZGX+2C19PQSwLpyrFSoRRs+XzRqIwpCkcliHEWk4JpGv5cxnI7lH5DVq9?=
 =?us-ascii?Q?1jFu/Q79bouRO/Y7hBLtRGGcIiw+AJr5lOaiWacDuOrcclZQzsCR5/sa/JIM?=
 =?us-ascii?Q?OcTlrDHpebIWMEw77Lfx+ioITGYYjuSPdEyyKOHfkKlBOUKxdkGVrHs1tjZu?=
 =?us-ascii?Q?QxhL+lzbYmBrIQo9FmSqw5Dgh+8QFEWrRbHX2CfFPiRIfiAxEKKrG2zVHzUT?=
 =?us-ascii?Q?x/WsMAHd1W3pKbBnrdIxXxznh6jMc1PEoKb7IkXXDu8y0UQMEvtLmCjO65wZ?=
 =?us-ascii?Q?7b76HqGNagscPtJGS86jBpbzMBajjD0p/nBJ8NNtx47tjBtgDV/iFJCDHfK5?=
 =?us-ascii?Q?v8xxOhLKMd93Q/Pk3yKqXI1kPGERWARb8Ral9Sh7+4YXWSF6Bt/iv27VDgAY?=
 =?us-ascii?Q?vNr6Oj1wDGiKKKXTmR0IZLfhvT/ROxAnBhupho40rD8WIt478NiS7FMIsxfm?=
 =?us-ascii?Q?Ga0mQDescMdNejCMA1C16Py6sLCpdc4RffEjJ5Q4KcfmgSE5a1aL4TqVsyH7?=
 =?us-ascii?Q?qyzpwuAE++vNWKGymKk5QNTdnLW8wpsWM+2X2p76Q9mlV73PuMqoN/mSSDoY?=
 =?us-ascii?Q?d2fHmXkMj1k5a+UJwDF53frA5WlxIbgYEiy7oLMwXdboxAoYs8pQguVorGHI?=
 =?us-ascii?Q?gOBDHFrzDp8ZpG1DzIsd00JF0nVkJeKcpNDokHiVwDv4NBrBNgldjRr7+MT/?=
 =?us-ascii?Q?+SylTxGaOgp0sdzaexUOOdL2nYaNZoopk2LUK+7s1OzRYnHPYJOVO+EVUniz?=
 =?us-ascii?Q?B0D7LbOX3UkacTn1/S0GddFnAm4lVc1lfSFpbzdC6TzO3Fw4kTQS9pU7J+pl?=
 =?us-ascii?Q?JHX2sDFvZ1073vrAC/6aI0t4mfV0FhSv+35zMGQNGZVT4UgBLZ+4ZNT12kWN?=
 =?us-ascii?Q?rEozXWwTyHsUndWjg5sBgZQy3jLNw+V8o+FGPNFgfZhrlzSyBsZn7fSshaoW?=
 =?us-ascii?Q?kKd+/2hx7HYV/w0NiMJWlp4kjQdYULVXGFvjYVqGOsQP3POf+oFRmrXnVMKi?=
 =?us-ascii?Q?OiIEg6ezomhpoPf1ufkdTTS4Drl8d1/8mb3PzxjzsLecbYG1J0JLsnRnpqEm?=
 =?us-ascii?Q?BZFHgBgj/URknCn+EQIUjW1ZBDZVjmkJdh3m8OjpJYrHlL8ZIDzn5YXkSmr/?=
 =?us-ascii?Q?k0tBb/Esz1sh7OZu1xMWx849mdc9/ZBlVpC9ey1J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f92ac8d-de91-4f81-4843-08dc27aa1681
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 06:57:45.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Nn929Lee9CD9BDPqC631S8N71cP9U8JpdB3lnUDt36+FtATpgTXeB/4nZuDi0bJYvzyyFIZGqsvvWAcXCAUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7465
X-OriginatorOrg: intel.com



>=20
> On Wed, Feb 07, 2024 at 08:43:04AM +0800, Wentong Wu wrote:
> > Add IVSC device support on Meteor Lake platform.
> >
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
>=20
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>

>=20
> > ---
> >  drivers/misc/mei/vsc-tp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > index 6f4a4be6ccb5..55f7db490d3b 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -535,6 +535,7 @@ static const struct acpi_device_id vsc_tp_acpi_ids[=
]
> =3D {
> >  	{ "INTC1009" }, /* Raptor Lake */
> >  	{ "INTC1058" }, /* Tiger Lake */
> >  	{ "INTC1094" }, /* Alder Lake */
> > +	{ "INTC10D0" }, /* Meteor Lake */
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
>=20
> --
> Sakari Ailus

