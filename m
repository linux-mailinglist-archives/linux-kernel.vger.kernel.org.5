Return-Path: <linux-kernel+bounces-134862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D889B7FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E921C21613
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF520319;
	Mon,  8 Apr 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9LED7FP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F751BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559288; cv=fail; b=Ih79GJ3bK5qGNkvKY7bgebr2MKo3gZiby78vsxZ6ow0v0Jjl7EfcIbBvX1vRWFgWmo9Uc0XWgLS4/wrR4h1BIwe+81w8pPOoqOdAAf5NdZegWHZh9FrN8+KrQj+01MAD9xoSR5E/oXvClc1Ede1tXK4UnkccJbSS/QjhjqeUCC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559288; c=relaxed/simple;
	bh=muUpHKCIJw1g5eYtBFGTcROnVSZEx/7Zr3nwPLuH1oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUrOG53ykxH2kXLTJAO9hjwVFB/bQwnYsakI8Cib5AbzGPYAiUFF2hccPPkANvO8/rhvv8McMdwSloAdae2Ifj4hEU+JaQlw7PE65JNqA7jS/2NYyO95q+O5BHe2/LqTMHl8zrqtq+Lrd8zUPVq+i9jv20eEjeOVZyv5fn5aTx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9LED7FP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712559286; x=1744095286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=muUpHKCIJw1g5eYtBFGTcROnVSZEx/7Zr3nwPLuH1oc=;
  b=T9LED7FP6vT1Ce+3u2lwkYYwSmSxI/XGM9dcZyKi1w8YtinVrzLgPwzW
   53kWk1BDLFmc6tmxLzHI6lCRVuVuxoC6obqhZvMDY6i1UgCXJyuW6sOSM
   Iu7xgObkwNS0OMufL89bSu1ETmeppG1uiS80E2FIoLnqHfCgJrikSRk4j
   rzdD4yf/WsS/j2zuuHYTMRuRbfEB58FOh78TP+4sGxw4D1MetBGtt+Gxu
   EsfuYaj/RLjQGwsey/ZJcX70lpVAGmQm/bO8yMO74+ibnGWVEyYjcaJTP
   391ORbtUjIeEKBwD8kZh9x+CvRT0DG1aGgwRc4d400Ml0IxfXd19gESOz
   A==;
X-CSE-ConnectionGUID: rbbH24iCSM65G0+DM0g+zw==
X-CSE-MsgGUID: oNs2fvYpTYi9Ls2/VK7g3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7679195"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7679195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:54:46 -0700
X-CSE-ConnectionGUID: 4PXDQtkVQXKsH+dOodvmjg==
X-CSE-MsgGUID: hVucgHdrR4SKYq+qDPw8fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24260134"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 23:54:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 23:54:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 23:54:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 23:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTC+omjwFjQ7FMwtory9UWp/qnj1HrujAZiJh+6bmJU+dcztnBTlBEaUYw1BLwCSzvmoHN8A/9giB2DdX1NGkuwn7zhhtB+NZ0zjBvds1J12PubW1fh5d6lj5IadjxKQbQTb9huMrvDKu6USTGNbNZcewIboHpA6QZBiIYayszq3yga3KW5f9CKKqWo/29VR9iZDufbQX/T0AMFY6uOomu8wBaL9Tf5oip1fChFBOZVpY35uLkSrWM7HN+EvQc3NuhXp9QKEzJ2LeQN0DxZMkSNpTETogt61YgedlswyEJFdHDuhsvPlpIDKpVQi80h3V7sxyGDo88zUMNpVVfZOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXAaRPinNEx2WnJayzBSiHBT51U1NCs93w2DdT43Wnk=;
 b=n8OSs7lyqNfVEkJwn/o6kjkkKsy8beT4S0ZU1ctcUAH+wjie3ko393Ou0H9bs4KqnzKZ+cZP9wKWM/8b655eJbv6PI4gxHX/RCcdesA9gIOJJKXrrxuxzZlmIIcBzDK0iZaIy++VixnqQgniGWDJud0To2xnNKv/jbtEdN2Gdf+1zjRxDBvvDNr148RGFDBbdivHgyHgROTkQ2C/p6HYI6R/Xc5AE7lETsksJ7p4SjhgHT0FA9FwrYwNc8lYab9ZkINQnyENq8i7RcUKbu0sHTV/+0JZXdn/XSyprRvk7DfBN1fb22Zuqao3hzOrV0R7+uSi2GiPEs2WZPFvUOxH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6079.namprd11.prod.outlook.com (2603:10b6:8:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 06:54:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 06:54:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Dimitri Sivanich <sivanich@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, YueHaibing
	<yuehaibing@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>
Subject: RE: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Topic: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Index: AQHae9GlBWpgQbFT6kOw3+M6DonKQrFeC4YA
Date: Mon, 8 Apr 2024 06:54:41 +0000
Message-ID: <BN9PR11MB52765241E3261B58BE93E8A88C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
In-Reply-To: <Zfydpp2Hm+as16TY@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6079:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +S7l5P7ABbDO4yTXCFuvXH0atz1/0AWGvMEKGIhFdEa8Y4VehlOAi7mYGlwxBoScLD9DCks4JbiIeUaHH4Ts4xb3Wwg7kitDCBaFbGH+8KSZjLUJqkilg5R44kMTtVTgjghGkAs8fxW0YBPrisZexasp+MoSUmPwhDbayWbdEhsBO2d0ju1G9niVS/D/LcRC6526Petu9X73U4QgedAX2GMxlLtFpsmuuDnAELGAjQhUjH/LW4dY6Hep//NxEIER7KPBdroFCsShX1aWR4tbb9P5NWyQaPh9QQkZO1G/BQjC+vsSByRPvXSJCcIbUZIC+g81C6r38N+iNCI2kti9SCSY1LqMJCeyIFGvfq9t+xIZZYq5o29VkgsBCm27lRKw52r2fXlmofb3Nb9PyyzmUzwlYJ5p3zvQYkYmwjbYTDgHjSKjAWC00ed0VxtBWnq5eACRFLrJk2c/ChnK/QGcRfoTfqtYQzkNFzaGGHLhzKuH6cPTQHQfAXv4JoN8ounPnUda9kEY9ehcPw5Pz9oekrU2Kbql+ulsxOpLMOOMSTUJvINvh61wWCsUsdY9s3gOOGWx7ePj0hNnEOxBOikG5yKakX78n6QoOe9btyYv8Dv9GE+20dIjiSGJqXNa+ZwM/kMqdCj1m1wmn4kC2tx5xJGPZlSovl5ATRgtqaKvlR+ufv1GuvyUWmSHvMDet+xcCYEw/oeqpQ2PgOVrTuEI0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0N8Rz3rKYvX1hOs9k28+HOPm3L+eGhbpRcceQxpbZ7X+o5b1ch4rizdwtfcc?=
 =?us-ascii?Q?LnQ3eaOKZZq7E8eRuiCQqfYoZyYchI3aol8JcD/Fd4P00zwA0n96vcQV1p9P?=
 =?us-ascii?Q?PjFJw8J7yTvXSDaIVaLxXjHi0zyXewrNBDf2nrGpx2qC9pJJe19ff1FrnlSG?=
 =?us-ascii?Q?iM3PCG/9RHksgxIwRh4vTc0H3xM8UlmBbLG9nOvgQguNt9tI9LSUAHdgjjLV?=
 =?us-ascii?Q?PWlBRiXv/niVi5d5fKh9FC5fLCo5Q4z9gTw0wNk6ZQwwkUBEOLTiszbUaAhS?=
 =?us-ascii?Q?Q1ItiRQLJAUXXiUkav/4pUDaNFpexk/8fhnSQHjJlsMd6Qy4PxpmBOJSJo8H?=
 =?us-ascii?Q?dyoHMjUdcZjx2vgRngRZcKSK8AhJ1XWYA68K2lvs9u54MmEoMnxw1TFbTB6m?=
 =?us-ascii?Q?APMcpGGO+qebsQtlPsCwaSXoLyZBomzxoe2pklkf/2IexXJ87Junc5UAgqc2?=
 =?us-ascii?Q?UVlgAMgBhs1qr1nwGeNNDxDQboCosvlD8CksLDaoazoYlYMsWC1Ik4SK6GnI?=
 =?us-ascii?Q?hSAfP2phWblu1FFUCnWx/wz+RfSi1ZaMfGJG7Ckwo5bEp8T5HX7GQhAh2cq8?=
 =?us-ascii?Q?56JvgT6A2JqiIIG8HzlrfoE/YI2yLN7ZoRbJub5LtEddiEJdRm9S7YbHuDhy?=
 =?us-ascii?Q?APA29TM9wCfl4JS8lNlKcT5DFBXmnLu9IMu0wxTtsC2vyYO7KDEKIyRRgQxh?=
 =?us-ascii?Q?/0QWlvLKk9R65p4zgQjQKJWqQb6z1uqq2f1EEHnCdIqjkikLxDZb5Tkpur6O?=
 =?us-ascii?Q?zL7LMRKYkM6Lc2mvdzU2cUa8KDVSEjkhTPkU/scCV8Tm9HegNGQL1YSnKvJI?=
 =?us-ascii?Q?8Mlv7ZLccLFKLdHd2pvBBz29N6nZlnvK1l0TNghwUu/iPVecMZGDV+OEtFg8?=
 =?us-ascii?Q?wG/1tzo2rC/gPpx5eOIIpwGx6uFi/P/YP2dba8k3TKVKJ48WvDI/ML2W5tAC?=
 =?us-ascii?Q?mVNFXgjH/2aJgYSaDBWgjIUJt/dHOT9WaFreVoq3/hdw6Dfe/1zawxGuuE3O?=
 =?us-ascii?Q?y4HcK0ycGkLcSnNRrvd9dnv/MyOsHbtbBIdrbWOwg16nm3bbZoMbruGAueyW?=
 =?us-ascii?Q?TOCj6i1mz5Dn62cn3ZNDWjcJxZmf83i2OOTOUFSazR07rGNpFHuWDEz0D5a+?=
 =?us-ascii?Q?zS8FkOQHeHKtdP0aXGUv3oyQeS9hHXQ3mbFm+qybfhTN5Ru4MkTq/lzkJ3QA?=
 =?us-ascii?Q?IN+VPmNCwdlEgWHXotkLj/YahDU4/IOdgYgtshi2AUsq7itYELtwabm5ga2p?=
 =?us-ascii?Q?AZZmymLNIvypEzPAdPLuQAps0hV1vgD4eKfpA9637OHErNcpNHUj0A88qp3D?=
 =?us-ascii?Q?SgiSqLlx8brtSG9yO62q4X//T5asuMuYty12eujXWfcz/6TMMsQ1ArdZEgdF?=
 =?us-ascii?Q?nylpFfVf3ukJQFh6XxhQXwlLsxdDKxrnl+Ym7ejBbdHbqFDOj8nIFvv8gEJB?=
 =?us-ascii?Q?+UVbf0750O9envjVyRKHPODMOAOjHE+TZMlXNjsJ2GdZwiPBv+i/fYhyvBDu?=
 =?us-ascii?Q?3TfilG9S+xP2bsjPFJSLiksDuNv2Zxc1I9PsCIAlrXb048XdNIryoUSXC/QC?=
 =?us-ascii?Q?EElrJD0DyehUOyIU/zJAx+tH89s8po3A/hm7HZxG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74968de2-c015-4fe3-6e7d-08dc5798c41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:54:41.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6h+7gm0krE+gxprP8wU8n657zBhPgJi4ZUt5a+GS82ByVBM76kPvtzNsFzOHzjaeWyyIrPl/JILj+yXF6wDnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6079
X-OriginatorOrg: intel.com

> From: Dimitri Sivanich <sivanich@hpe.com>
> Sent: Friday, March 22, 2024 4:51 AM
>=20
> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> vectors on the boot cpu.  On large systems with high DMAR counts this
> results in vector exhaustion, and most of the vectors are not initially
> allocated socket local.
>=20
> Instead, have a cpu on each node do the vector allocation for the DMARs o=
n
> that node.  The boot cpu still does the allocation for its node during it=
s
> boot sequence.
>=20
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

