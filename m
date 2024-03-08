Return-Path: <linux-kernel+bounces-97693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A956D876DE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB45E1C21215
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C30B3FB89;
	Fri,  8 Mar 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIQLR7V4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDC1E4BE;
	Fri,  8 Mar 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941550; cv=fail; b=EZMnQPPYw63A6wfJztw/CttJi2vWQgnEDVuHOqWC9hJRSi3FQHvfYHa9+nv/rXR1UrUI+N9w9tZ9AKCthnYT9E3D7KogkD8eFwt91rdVpEGqGyWOYVxRVy0Ri/ZRm2o0ZdGkSbRjIGSiVIuDCHXpGRhq7G6WIoMuSQ9DnM3ZOTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941550; c=relaxed/simple;
	bh=kncbNhbgxBwE2VgGMSHS+ZRl0P+tE9+9kYTWve2kZzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKbg5DAvbrkLOGVBmGMioLsR+CGBWXmEi33P2Kh6PsD6kroK8n0G5oPjcQJf8oPtCMRQ9lXgADOF9P1n8zzm+cb92T2U2QBOoqbIpMuIuPfEa1AgIA8s3iM+h+OpIJZ596HEPJrfTOqJjrHTDezscoKwMWsla3DLevFJLvrngpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIQLR7V4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709941548; x=1741477548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kncbNhbgxBwE2VgGMSHS+ZRl0P+tE9+9kYTWve2kZzU=;
  b=HIQLR7V4+dSEo/OAC06v7F6I/kjMhO3zXOWfnCndNaUoXSDT//viromA
   GrzB7zh2h2ZK/bP2dKh++/t+SBBec0T+D3ZeNd34lUDS57Qth3AoQETff
   pzbPIYqZBw80PBZT8/OwDlVAwt/g53rehY2RL/8q4uZSX/yBEJBP1XGTt
   1xEBo9gprgBoyqsBSYrUTvqsy8RNTSwrmSIo6itZSm5ytBT+2k++hK8QZ
   LejhQpO1d5I2sVo7RY/gJCXQWnMQdXuTllKzQyPtGO5E21OgRdjjYO3hN
   9MlesPCrdrMDiBi5oXCO6FXGER0NhzbsdO7RVxoqYA/yIFWAdPV/ORehz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4851167"
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="4851167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 15:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="10698664"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 15:45:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:45:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:45:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 15:45:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 15:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzZ3f/9SnO+SGJqcMAzD7kiaXkocl6t4+MJxyuUQjwIuE8dkDpnTfRwjHivLGZf5vfrGLE61u1Xa66Py1Qe6oPHxcn46xfBpmCzOR+pVkyX0nzSCMT5ix4Qb9Fq9HrsHNRCfPOUas2g/8n7aAV1LW3qjlzxlEeSSbGfcNPCgT2gQ6p9dVJmY7AeXOTDdNCyF+TJVqaX1vxhbbByGkdvUDBIJZ5KyA5GWRFg+emE1xdadzfftyZcrdfsZsiZkwo+I214AhThrY2S3SCodtQN/HN4O3olM6TeUJZ0Wn+SPN5me5zplJVlPCWna91t9WGQFMAvF10/dUrs0ttEfhmlM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYutmjQkRw6UWn3ns03GRg6hDLvI5jtjn1cS6z77XM4=;
 b=a+rSFhgtE5XxyK0fO4g+Xu5u0fnjTzjsBbTIoC2bkT/aFfbDJX/ZglvxuB0D+OImZRLvHMP6MrJx6OgJuv9vQrptL0Is/KY6KtA0K5bCUorHJmkI90tbnj90NqGX2BB7VgCLAO0Ni3us+4cweVcXMJ496e9HiN8oJMh083GDTxUQuCs7x6PIdRP0+zFYiegyB1It3oneGTO2tEUufQTJGX/X0x63RbQSts3A3bto6zN8SH47TStvufTkWrys/A07Oe39reCMYc0PxgJoTao7ByKL2u7TiA8wE2AkuqnI4X56xhiNWvbfGm4U79C2qyjrg/uTzlEgnofWwqLyYtXZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by DS0PR11MB7285.namprd11.prod.outlook.com (2603:10b6:8:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Fri, 8 Mar
 2024 23:45:44 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2%6]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 23:45:44 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>, Sakari Ailus
	<sakari.ailus@linux.intel.com>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Topic: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Index: AQHaam3EvCzE5l33CkGR0g/9d0yezrEgGjAAgADQ1wCAAAJ5gIAAnU4AgA0EQNA=
Date: Fri, 8 Mar 2024 23:45:44 +0000
Message-ID: <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
In-Reply-To: <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|DS0PR11MB7285:EE_
x-ms-office365-filtering-correlation-id: e0dfb7b0-87a5-498d-7dfe-08dc3fc9def2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MX5f35b1D7tka7EOhH5hX7bCNa0pXB/esd7tboFIalhGDTShT8qPmCr593DeS4T0etp3Da1Swwavr1VH1gFzwyMgZVXpPx0auL6lcg+QFW8DSOT4Ij2xmosWG0crU2sEAs706J3Iy1RQB54rc8pLq3j8RUyeQWDnh5z512k8sK/kq1pmnFkVzZ9QzAK6h3SBUX+myrqMfMLkACNq2b9sQVVEU4t0l1Jb9ys4r9DJ0H18RQcWYq6vHOehqySRR2W0AL4c3dxRA25IEaJ1e7rKo3aNdK8aGDOrgfn1xVISXuLPEAKrqyUo5Qe9uJo0+TqEiObhSkhlA2iJ4AuwP6RdEqSOv0aaLTLPAMqFRf7Z8LZQtBr+BH2aiF071mS8+PC2O8pe6rZ3rHNbJ86GuLoHNcYJhFv8gwTG9vH24lWZ9KOSLsgM9tRCBxO/1ayuXxy4kHm/kMa3Oi4OeHj05CMEM6MV12GahP9xE/HQnCAxQ75Upfc33xtqEM5gWdRCG5DgN1Yr8NzDcHw99IFK85pmGYSILEsHdbKI7Emi0S/zhJyqeeHxnLRcbaz1F45TOkrdt04ba7FhvovUUPqDGArjuGdVIBBhXC/HJvkLKcFpomSTRGm5IFF7Oz2S7XtB6lDpFpBJEmPaC7ClHVbpXK5PT+VEm32SjzgJp3BIIv21N6nLBXGjHI7r8A5XutTuSqdIIVOvWBgI+9/YXoRzf6qnUAWCVFQk+IQhr8QqMS6ICdY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2MZVZ7XXftB2Cm1WQ8AX8tYmWoyHmkeC9VIdr0muwLCdplQNb1CEn+Y7wkab?=
 =?us-ascii?Q?pr9rdIK1S6LZkSRGgCaUOMZ35Q3wv3vXnxdBWg7A4Fg7BKyiYFi0PeKaXJfS?=
 =?us-ascii?Q?kUxPndO3MaLtJ0mIOTtbiJUahcTZaPuR555pRCFSVo3Fvttc1JEiG/fPbUnH?=
 =?us-ascii?Q?DknnWw5jc1lk0N+TZ/3K05o7DudEsczoL7msONDSmHwZKDjA/ziEA/wlOGNp?=
 =?us-ascii?Q?rv9jEGMl/rcym5XzKfx+fmVAoLsetSjT/ib3cHpdPrY5ac5H26evUTt+s4lj?=
 =?us-ascii?Q?vJvue3GcjglbeDoOmTKWLxLzBCu1wD/zdL+QRQGx6p+/K8mlg2gWlgYaUseh?=
 =?us-ascii?Q?tqOIlp6tXn/TTZ407JgcNwLkMzmTB+Bw8Z510bgDY85NQf2G3U/FgSWsRbED?=
 =?us-ascii?Q?160X4+2a2X1pLTnkOZbbd6mv0uxf59XYRNywLXiBj3troRvoD0kCRUMfRV4Z?=
 =?us-ascii?Q?ObRw2QPicKwmgfKNZR9CNXH8GW4GfxSHPcrUBHXiiRMLUiVUMXDwE0Y/h5p0?=
 =?us-ascii?Q?h+T0Z5fVKDwDYevcs/AGifzR/em2dbw3X4qpMviHdXuWbvhwra2nkUw4p5ni?=
 =?us-ascii?Q?dIZwyuRI4fY4y+O04r8C9QPdr6CnPmKt1+Tg52LRjQPsXgCMnqpwVqOSn12N?=
 =?us-ascii?Q?TzCSvWCb5RVgqh/3qjpfbrZmunS3TSaX+wv6CL3dsbHOdDzlLBHqGA5bm1/l?=
 =?us-ascii?Q?8ugXF/DaVTB7ZaDyPlT4fu6j2wrwZrm43tFEipRn/3h91mPSv4Q8g4vwZ/2N?=
 =?us-ascii?Q?Yiy303++mhqJvjmIv9Rrrr+q4uEwCzE7+4+zmIv5owoY66xkNrhtkkTdVSy2?=
 =?us-ascii?Q?cW9Hl5jEu/E9dv2TeaSBskvVYVTx3QWNc/gkPFsE41LhZGIXNDEI5sZZDWe6?=
 =?us-ascii?Q?EayWS+ojd7IJ4rPV/9z6lhcUjw65myJeFyp8RniXzSWifd4cp1bqyWcz813h?=
 =?us-ascii?Q?2iCDKaO0Cl3KjtAhmvUHruyLFrnK9OzHbQ1i6St70PuoP8Oe0GENsYh0upfZ?=
 =?us-ascii?Q?q0gRLPY8DIbiOvlgXAPrGSPzB9DqdGDvEHPI4nlOv6db3LAa1wcVzE9DQNQs?=
 =?us-ascii?Q?WG6Nv3arC47JpMmhAMWfHnlO8K8foAJRLWwlDDufi0uwGBbPX8JYgtKqrCQm?=
 =?us-ascii?Q?mFOPDU/hklWM4Kxnnu90jkwZaLjSpvr8af8a1iX6JT9aYDrG1cqFgey1ZbUG?=
 =?us-ascii?Q?TQ9sZjZGga+B8tGR805jQeNlDFBBrQH1mLY2ipTGBFyZZIKUh7210ACjkTdx?=
 =?us-ascii?Q?pmLPgqVUNKNGZPgIA15IjE6nMm5C2LtaR+JdvvKcNbggShickbC25jiDJpYS?=
 =?us-ascii?Q?HKtBo2q7Y1FIq/hi7h+qhG1YpNiXcW5m0jqgjmLVu1AOpanUemVK/ddCPP4Y?=
 =?us-ascii?Q?1IRlmXFqRKKjctOH8HsCSnnkjg44THhu9lmuD6m8sTX+llqKxOI18FtQX5vb?=
 =?us-ascii?Q?4QoKm58vrPEx2iWnejeDEsxXntZNfHdBcqVAyh6t8P5EdLT0EwirLB+dpB3P?=
 =?us-ascii?Q?jP2/nbcm5uDBR3av+YMiEEd+UfXxmEDhZeVrTagjRmZQ9oC1iQ87CQhoth+4?=
 =?us-ascii?Q?Kql8PnCRVY+GopGbcARMtKmM/kFQKYC1/EtYKNlx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dfb7b0-87a5-498d-7dfe-08dc3fc9def2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 23:45:44.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XffrMsfEPimLAYeXIfzFuGPLOInoQr56pbHG1oGJ49ANUTuVGjBai+/gqcd6NIge7rmlrpsBFYhcp5FkZUp2jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
X-OriginatorOrg: intel.com

Hi Dominik,

Did you try master branch (v6.8) without IPU6 driver? There
should be problems with the IPU6 driver you use as below:

> intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> intel-ipu6 0000:00:05.0: Connected 1 cameras

If not, could you please help try it on your side? Thanks a lot

BR,
Wentong
> From: Dominik Brodowski <linux@dominikbrodowski.net>
>=20
> Hi Sakari,
>=20
> Am Thu, Feb 29, 2024 at 07:30:33AM +0000 schrieb Sakari Ailus:
> > On Thu, Feb 29, 2024 at 08:21:42AM +0100, Dominik Brodowski wrote:
> > > Hi Sakari,
> > >
> > > many thanks, this patch helps. Another issue persists, though:
> > >
> > >
> > > $ dmesg | cut -c16- | grep -E "(mei|vsc)"
> > > mei_me 0000:00:16.0: enabling device (0000 -> 0002) mei_hdcp
> > > 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound
> > > 0000:00:02.0 (ops i915_hdcp_ops) mei_pxp
> > > 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound
> > > 0000:00:02.0 (ops i915_pxp_tee_component_ops) intel_vsc intel_vsc:
> > > silicon stepping version is 0:2 mei
> > > intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe
> > > pending: (reason unknown) mei
> > > intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe
> > > pending: (reason unknown)
> >
> > You'll probably need the IPU bridge patches from that branch, too. Or
> > you can try removing the intel-ipu6 driver and modprobing it again.
>=20
> Everything is built into the kernel here - and the kernel I run is pure
> upstream (plus your patch), therefore no intel-ipu6 driver is available
> (yet) or active.
>=20
> > > During suspend entry (s2idle), the following messages are emitted:
> > >
> > > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
> > > Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2
> > > PM: Some devices failed to suspend, or early wake event detected
> > > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
> > > Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2 vsc-tp
> > > spi-INTC1094:00: wakeup firmware failed ret: -110 vsc-tp
> > > spi-INTC1094:00: wakeup firmware failed ret: -110 intel_vsc
> > > intel_vsc: wait fw ready failed: -110 intel_vsc intel_vsc: hw_start
> > > failed ret =3D -110 fw status =3D intel_vsc intel_vsc: unexpected res=
et:
> > > dev_state =3D RESETTING fw status =3D ACPI Warning:
> > > \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed
> > > 0, method requires 1 (20230628/nsarguments-232) intel_vsc intel_vsc:
> > > silicon stepping version is 0:2
> >
> > I haven't tried suspending. Is this while streaming or not?
>=20
> No streaming - in fact, without intel-ipu6 available (upstream + your pat=
ch,
> see above).
>=20
>=20
> I have now tried upstream plus the ipu6 branch; there I get one message
> indicating that something is amiss:
>=20
> 	vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
>=20
> And if I try to do a suspend&resume cycle, the machine hangs. A longer
> snippet from dmesg from upstream+ipu6 branch:
>=20
> mei_me 0000:00:16.0: enabling device (0000 -> 0002) mei_hdcp 0000:00:16.0=
-
> b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops
> i915_hdcp_ops) mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-
> 1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> intel-ipu6 0000:00:05.0: enabling device (0000 -> 0002)
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925 intel_vsc intel_vsc: silico=
n
> stepping version is 0:2
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925 vsc-tp spi-INTC1094:00:
> wakeup firmware failed ret: -110
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> intel-ipu6 0000:00:05.0: Connected 1 cameras
> intel-ipu6 0000:00:05.0: IPU6-v3[465d] hardware version 5
>=20
>=20
> Best,
> 	Dominik

