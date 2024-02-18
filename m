Return-Path: <linux-kernel+bounces-70296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3198595BE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B551C21550
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDAEAEB;
	Sun, 18 Feb 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYUOhT2/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C713D7A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245903; cv=fail; b=Z0gl4kjlsplfud2aSu/+mssxBvtoZfN3Yp2tC1YbXo7ruM+64upvIVqSU5AlppxaauAIUl7EtnsolqIOWP8Iu5vZrUxRDR3V3JqY1rxApDmBYf7Jb9TLVMoqe+RSGtkwzybCpC4VSaNI8TJ+BN9E5XNbJozA7+Is5Gf+2CtUBxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245903; c=relaxed/simple;
	bh=I6ZNrXliyZ7g3wSI/M47Em1I4ywJGXlqql0IbWza1KU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoafeUy4LMgNT7oaGK6/XfwkIGQeMcD50QyGWwIuKbLXyeh+qCpHyU3UsiL4KIq24R1TFMbpBlIkeWRbVby7fJdxHkceeeOTLuOsv/VrHCDlhmJjeqK76i1dQsnKotjDv/de/qbRgEK04E6wpu/JPMNepUGXzXFWBgnquGfW5Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYUOhT2/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708245902; x=1739781902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6ZNrXliyZ7g3wSI/M47Em1I4ywJGXlqql0IbWza1KU=;
  b=YYUOhT2/+0uULpdWVLNnTP7ZnsjrrPwSSDgETHh40dFZ0xOZ6atHW1f4
   SlmlM7g/Zt4zuEpMbNVFyARBa/NYc/US6lwxVO642SQp1ysYR5T4i1y9S
   k5CWLZ4RbPxmkFYIgNFMhh8vTK/VNRnNseMSsOvp48bEDN+oqp07NaqYn
   rkKPS4Obmme1Rvc2Xa8hPJm8TapH4zB+b/A+/lEPkd3kqPOlZaZOCb+KH
   m6/wzwhnvO0MyFjYDVHYGLOiTrMxxrvYty/rfESfHO0r99rV4ZepKZh33
   OF87IfioQbg5grfY84/CHWGGZJOhBxXSxJytdXKtdk4IeQKJKUXHWEp/I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2199966"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2199966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4124953"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 00:45:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 00:45:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 00:45:00 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 00:45:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz5auLXVdeP+2B7ZP6Kgl1MAMjschxLqGdP4zbPMapodIx/6o25yqmoe0mFjXIrbSN4mjqlwe/awYhNArCNnqkc8HM1Aq9YNmex/q15aFx17xSUMAjUMg31hryeYavmCqd6mEk/8rSTmyunnQF4RxfTsPCfimhtRED6Knq//PWY/+Spse9Eix9++4swVcqw4Vacj0yq1nSxIct2wTIFFFNQLl8pOkBYWy4OygbcFOtBIUYdmMwbT67W1U38SiEJrE0bFGTBQtsBasGgKb7lXENlE3+s2m/sKvH2wjCkPJDJymRF5r8JGNy0vRNY3ej2lKNwZJRwpsv/mH2iwsOlPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLbJVL9OEYGId5lKHI92MzSs60dLSWrGgm2rRUQsBT8=;
 b=M4Ypcd/JVCrPKi7UI91GOzAQqscDTU4fpD5N/Tk5qM7K++Mco7eDsw0/qXaHRyumrCQ8zQlOgObP8Lg0iBNB0JLa6BqI9zOSpST6ThMZGKSN/u4hejz7MvStP0CDPX9VWCvEuS7HElqsjTkyVhsidMUWWVIPhTNkfVmIdvj5W0LyZDdI/LQUduslbtSDCPqg+WoGgU25sFlbIsxMp5n6dATPP6IdK8s01xBmiBbVkeP/caMNojl92EJg6OZtxy8BS7IiJE29njiShRlhePHLH5KM8Ubcc6j9ROJLtpW/7PLqapVqpBcnp1v8YYCwC1jf9I82TGS+P2tSVXqfmWrZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 08:44:58 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 08:44:58 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Topic: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Index: AQHaWV7S342idETh5UKss3/1MOC1P7D+bxyAgAAEDYCAEWapMA==
Date: Sun, 18 Feb 2024 08:44:58 +0000
Message-ID: <MW5PR11MB5787BC32B9E7C3F818B6B9D98D522@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240207004304.31862-1-wentong.wu@intel.com>
 <ZcMmg1f8975whpno@kekkonen.localdomain>
 <PH7PR11MB760526EBCB4CFCDB19A03E40E5452@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB760526EBCB4CFCDB19A03E40E5452@PH7PR11MB7605.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 923da9cd-0ed9-46e7-ac2c-08dc305de368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8er1nsTpvwQgx0eu+zWDX9+JMx/k6spN3ZsP5gysyFj44ITpHznj3IEpTeUH3IlLm7tr1nY+U5cSkCZmkIzvVpMjc8MiQ2l44J3E/zWj7DcI5HLwoWoqgRThC5nb9mPJxKO1KOhLK7kNs6oNZcs9UGSc2DXZd+x8k7cZgrfUZYcIwuj9keEUyCF/Bj3UEe2tXsJRQ/M3ieeqlgKcHFfvpL23hjHhE8u/PDRrhKwk65qN6H8oclXi38N6cHt0oD0WXJX5uxQy8XpYG6Um62KND0EWprpqT1Ogj6bN/kEJhOOtmytLUl1PpcqFn2wECboLy61LOXVGQCcaeAX7tutahI8eB6mnegFgw+JD1vs9jqz3CrCksRsjWaxapwlTGK5iNmlAx+8ao1XzRyKGLKHVb4wbZsOLmSwCKYLBbQGczdC6DI48p0PvBHYg8NX7+quyvLfgEDA3pqjoAjKRNTl5KoywlcUJco5GNXpxvinJr2m4mBQG/UZ8Tj42hbGJI1mDftq7P5kaACWjF821yNwrnWgcRVklB46GFrKxLEinfU1hzg0/Js/ynEGqTcyuu0fFnLmNhIYAWg+cWM1AXqyFsE+HIaC9I7y0NQCnJfe/cwkFhXxFFGFJCUuwgvUkktFR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(71200400001)(55016003)(4326008)(4744005)(2906002)(52536014)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(38100700002)(5660300002)(86362001)(122000001)(6506007)(316002)(7696005)(9686003)(38070700009)(33656002)(110136005)(478600001)(26005)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iNzsEYt5s9oL9hbdpAT/gV5L0AfYHcuy8aRf2nyuAmW8qIkPf2sq7GblnjLh?=
 =?us-ascii?Q?6AAob/c0TiIfEuX9C6VOfp1JhWDUMYvAbJgIEsqnX7IQu612CVe2NbbEqZOh?=
 =?us-ascii?Q?nvxsM8212GQz3qABc8iYwzBMPL7RUcHpkay6t57Mc8qOUjDfzG0jYFQUE+xx?=
 =?us-ascii?Q?FmIuvxO68iu6khYBfmm60FW9jRMDgXQzTcXdAy/GAUO/BE6rd/FAlrmG2VT6?=
 =?us-ascii?Q?SdGvOyavAa27AtgCADwA8vrwP81UgRxccQq1QqpfPiUmLQcoLBYplfAnORhb?=
 =?us-ascii?Q?rWlnIhcBhajMxtpoH3vGwRsQT95kgd99x3X1HAu2Xosdb3El2pUCrcD7ymu4?=
 =?us-ascii?Q?JEE05O61H64ucCW9qvOxT7D3nkWUDhvVes3S1A3hc0M8tFYhZTFVifKpneDv?=
 =?us-ascii?Q?I2bFbFdybXXRp3e58gF8ZMRnbklS1UlIAnQzUCUdEyAXALLz2Dq3P+SYl9Of?=
 =?us-ascii?Q?h6hUMOuIM1FCJEQN326/DSHm+pQOedstNNIk7n2xgq8AJa4sZ9IE3j/VCnDX?=
 =?us-ascii?Q?+3egW9GaHsvU7Bha/qFtWcr3euiY4dEhSeGzCQVYAxPrma99T3D2VpmepKGI?=
 =?us-ascii?Q?ohBKp8Ss55wix5ti7Ip/iHARhDgUS9rln2HSWR/0Z9diZAKsX+4XYlackwdS?=
 =?us-ascii?Q?xCK4qSZHi7pAlUyMQ7DCmN39q2Be+YTJQt7ufjFMhhPSfjn/vJ2YY57137of?=
 =?us-ascii?Q?TQyZ47Ex7nFh+1TzNnneHnaou+QHgpmJHy+RX/NloIHUIWtGAZeqAqi/bAUv?=
 =?us-ascii?Q?hE/284u5rpy+nbCEs7YwKWqQ54m0wr9EiG+LqoZK7skmerNx/MXxPrZ+dLCh?=
 =?us-ascii?Q?CdJAGH9zX0cJMorDG5rULneEpfLZCn3NqWFb7tDFTraIjDvrfPlnfKb8Y+5k?=
 =?us-ascii?Q?1fg/Dja++aznSuDJpdWNuJ9079E7oaTrqfd/JJA0sdUlm379hk+8ffyff8g0?=
 =?us-ascii?Q?XvVLmX8iJ2lEsjmH5velKe8nI6TuzQ7GbCOn/gMk++PL5f1RwBW4gaHqZNXZ?=
 =?us-ascii?Q?ELilbVDAzO69nnIRLAR5+Ip0RTYEV/08GN8bAgZEwZDrS5R2D4wxPRBS3o1z?=
 =?us-ascii?Q?35w5hHOk6RbrL2eaIrFJnB3KzxyNadEnASLbiNKjXx3/Jt8+qwG0bllnj9YN?=
 =?us-ascii?Q?Guf6GHUtjDVUnrm711KjaE0+Lok0qLHKOpzypiGqEnsJOaTXFsToPsvDHTv0?=
 =?us-ascii?Q?dYI8be9JVwMNy9lNTD/sP6SglHFPPOKtu+/1E1TQssj3PVA8gdJT3Ou5k+ej?=
 =?us-ascii?Q?3WHUc2b8dI2PDuKRTWZyyxgSHnz3XkG1+yCnz1zPRfbUPpv+YGC2z7D6nAhM?=
 =?us-ascii?Q?eSyKf9uRvh8Wr/EIe0TSuhXhyAIT0yRLFyPr03+gJY68qclWAOQuYp7svrmS?=
 =?us-ascii?Q?QdPllr33OOjCj+eFZAFL90ygD9dcBhiR7p8mo4CnPuRwAcyqb8c6jcVeuMKY?=
 =?us-ascii?Q?vFMt/1oSVhCFO9cJICimcJhSSjfFjq3kJogrPMMRSg+GB19VFiWmukL+EKCj?=
 =?us-ascii?Q?ko3o1mQrIac6NxoVwD5vvYzjPhEO5onPa5GYon8hcSCQHIkEQo1hzA1s8rMT?=
 =?us-ascii?Q?xx3RzOFkBTWMWWHm4je53CYYLoHijyojak9Wa1ya?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 923da9cd-0ed9-46e7-ac2c-08dc305de368
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 08:44:58.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Lbx4pQsBXDtgurunExWLtEH60UhUmZvIAoZkmnKBDNqK08mTQpMUl3IWQ3/fALrJvoy+7fa0n5JReea1LQQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

> From: Winkler, Tomas <tomas.winkler@intel.com>
> > On Wed, Feb 07, 2024 at 08:43:04AM +0800, Wentong Wu wrote:
> > > Add IVSC device support on Meteor Lake platform.
> > >
> > > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>

Thanks, Sakari and Tomas.=20

Greg, could you please help take a look this patch? Thanks

BR,
Wentong
>=20
> >
> > > ---
> > >  drivers/misc/mei/vsc-tp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > > index 6f4a4be6ccb5..55f7db490d3b 100644
> > > --- a/drivers/misc/mei/vsc-tp.c
> > > +++ b/drivers/misc/mei/vsc-tp.c
> > > @@ -535,6 +535,7 @@ static const struct acpi_device_id
> > > vsc_tp_acpi_ids[]
> > =3D {
> > >  	{ "INTC1009" }, /* Raptor Lake */
> > >  	{ "INTC1058" }, /* Tiger Lake */
> > >  	{ "INTC1094" }, /* Alder Lake */
> > > +	{ "INTC10D0" }, /* Meteor Lake */
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
> >
> > --
> > Sakari Ailus

