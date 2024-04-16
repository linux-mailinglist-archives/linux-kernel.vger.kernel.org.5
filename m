Return-Path: <linux-kernel+bounces-147277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CC8A71DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C228582D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63521131BD0;
	Tue, 16 Apr 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8XONC5Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112D6CDC8;
	Tue, 16 Apr 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286987; cv=fail; b=S8wcaTXdE76/Phvox9QhcgQTX3LmhBO0SBEUTh1YcOSJ6KR3kcTHn5nbMyp8mGlJO8uCScj9pL6FpLp5ncmwdKkle7sW4/qpl2GLegCzcQ/R/GQH6srGpSWHOeW7ARAKzEutraebnkXlEPF6B2QKk0GnGTd740OECkIbFa0fD/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286987; c=relaxed/simple;
	bh=x9k98lt4Ic3fFuAb9pPqNvxUH3afEnWmIn0lPqi0UuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BxzlW0nWPMDE2ExjYlkSZ3Huvikgi5DvHFtOh+KCJAA7xIUtZXMMnzc8OoD1RhDSNP5YbOySvwyaFf4rV9OJhZhmNm/WjlNJr3XOS5z9OvZTo3oUatXznUqwGp63EdGuDPdiIPc5Htea+X0aZG/NOjxa/Mfoj4dSfD1joaqtxeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8XONC5Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713286982; x=1744822982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9k98lt4Ic3fFuAb9pPqNvxUH3afEnWmIn0lPqi0UuM=;
  b=Q8XONC5QR/N4mrZg6rPInw2050h9Yl79Ff5gREfNsTrBWShVz/LoSdJT
   3FAPc0+a/wT2cz9znX3WkUjOi3j/9W/8OPwow/7G2krhYZ7Br6xTFgPH5
   Fzb8jtjA/YeVvxclLKrcX1spmw6mnk+QfsO9U5uQqoTDVvOTptRAYlZSt
   C4u1VF54YZYLfAfxmw7VYh6IJ81Dx8BE+3YSqSDh3fLpdz202ukIdd6w+
   veeGddteCkMxviKvIDoC8q4rQ29CC680y4fjvrnsLoyp645DpcWZT+bxq
   Qm/SF4STDj12K/2EjozqcSuWfkq/OiZk0qSV71Q9nu0o0Q0jiyr4IZ1Pm
   Q==;
X-CSE-ConnectionGUID: zTBWcIt8RfmMi/xZjGkjhw==
X-CSE-MsgGUID: 2mULaPteSZ+Ag3gS5IsCFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9292954"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="9292954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:03:01 -0700
X-CSE-ConnectionGUID: 5KMVU1WcT6+g+PxtYj8Now==
X-CSE-MsgGUID: lfTiGResQnqxssNDBY13sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="45611112"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 10:03:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 10:02:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 10:02:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 10:02:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpcW4RkaggEChXtg90CdNVyaW/tVmp6w4eHnnWT7ZK1C0JjLapxhA6KaCyBTxqRzwl2VVzu+/7x+54l2GAmHpOgeCbcgof0wICOZep46AteTGxwaTNagIBvcm4clmEWIAu2qpumhX+TGbDGoVHA0ygayCDi4cRsJ9TD4tBqEY++ucB8z31RbVQQr0FUQIOQk61/dYYbGskqG+qJCikilOhZenL9/nc7UUFmNte9MCW9DmWeLrUj+QyCzHHM3619jFO5QoPxPKuculOi0vQTGDvfRlcL34H90154MjZarIGWmUpgJPKSoanE4oeGLxyL5JKqiyIuB6oDRp3CQ6q1BEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezXHlYlPjgedBwHBf1qD+6Wb4FUlaDCskn+j5c4Qri8=;
 b=BFHvVW4uAqSwe1JLNTPan+AdcN6Nj5lzyvZ9nt3RjCexbDS1DyCSzduzJ8YSIh1SixlOEF5rFOWUXc1LI1qsXPoMDq2DLvqgOD7JFGah/SYhofnjsSkSgXXfFjYvze5nUIkcl+S7xGmfGaH5F+bG9ThswqT0unb5DkaQN4K5hWVonkhPz3aMTFdN9Dzi/pAOJU9p64/6tCUZQTx7PZLR4hFBheUoxltbL4zzZ031AFu44BPE1QPEinCsXxThsS9nU7GccGWuxZ96BXUGgKs6z3lDX41MQAfHPh8M8uinjujD7c5qSKWiCNhbQsz7Tvv7rGthnWaEIMytRm5KtqqU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19)
 by SA1PR11MB8395.namprd11.prod.outlook.com (2603:10b6:806:38c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 17:02:57 +0000
Received: from LV8PR11MB8698.namprd11.prod.outlook.com
 ([fe80::fc05:bd5a:1c2a:a3bc]) by LV8PR11MB8698.namprd11.prod.outlook.com
 ([fe80::fc05:bd5a:1c2a:a3bc%5]) with mapi id 15.20.7452.019; Tue, 16 Apr 2024
 17:02:57 +0000
From: "Dumbre, Saket" <saket.dumbre@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the pm tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the pm tree
Thread-Index: AQHaj4fka4xAg1DiTEi7ZZIRwGb2grFrHxFw
Date: Tue, 16 Apr 2024 17:02:57 +0000
Message-ID: <LV8PR11MB86986F8D34F247DF56AA247080082@LV8PR11MB8698.namprd11.prod.outlook.com>
References: <20240416085414.2ca9ed0a@canb.auug.org.au>
In-Reply-To: <20240416085414.2ca9ed0a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8698:EE_|SA1PR11MB8395:EE_
x-ms-office365-filtering-correlation-id: f224d059-1640-4fcb-1abe-08dc5e37109d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Y0uXyICpJihSNJHuTkcTrFrgSwYb8StkA+vtt2OInyMH6YjC/ZvMex3qvnrHP91sNf+P7LrX0DnP8ooV8dzAuqj3nq2xGhOhOAwalkZgwwdMV28O1smTOFPi1nwoccFh83fhtXr4nnmKsnpalpRJPisyO1R+ZiKFZTFP8LMwkSbENVIeiQwaZj5Nuj7RckUvBzK8FK6pfWTK3e8XsI3yeliuOJ28RYpxjeoTWT6OqiFVMOyP+iI5op8N45KA+Ll23BtOnoMdOAW2Q0AG8ubRrz/0x7YfkijLscBMEB3qLI17sia/QpwIAlDL0Z46QkuEIXt8syCUeu13vrW5GqiX704yp0yuJN1Wi8qSeQBi0Scoq9DvvVnZUhlqE2VmrD31c4GTabdmCpY85p3asyudCr9y33iPlrIyeIH7LIu/wW52PuCAbOMMluG6UlcoVsU9d6EWZppbfzyMx16azsS9ujk+97sogm96oi6ac/gXv/BNgCoOK/NTSvK/45x08wUEF+jiiHpqzOTGzmZGspsDjj1VyzRX5u8gp5G0Jm/WVQWRrhddVmOrHxbmkc50gGwEgTuK/PfEgme/ROv7OFQp/y00jOu/wmJ33xybFOYpqslgxkfqmOZ/rDE4KEDb/JlY+XXmhsHVhlbnw00BR+XoCgPF4G68yKOANXxEmtkxrvn/p6tlN+8YI6QaZN16QeCN6XUQtuxgJQkLerqQupFtayMJYNSJ7jllgpSUmfUbS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8698.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J15kvQJ2/OL+/OmRyen6Za/iRMzus4YSKreJVogo8n3w1vHGfPRGw1GNZRvG?=
 =?us-ascii?Q?B7G1zOJIYK5hHG2RDMtBqaXX9LdxOvZOhaHcqURpRlbK+QSqTzhlZcBAXmDx?=
 =?us-ascii?Q?9/kTmzCgcFGsSdNI9cW8AESkumHvBGdo5c6z4ADEh/0YbcyvvgNI/zzYpWCX?=
 =?us-ascii?Q?7kaXz0IB9Y3+e5yvkCob0q0VjDcq2qGTBm9aJ56vbHuprorQ8reNWyIMP8Pq?=
 =?us-ascii?Q?MPgocGtJa6/ZCfAo/vh+Aumvdkh5uOSGQERYIxFiw7t8s7GwYv96gKJ+MsqN?=
 =?us-ascii?Q?yb9+ypsrWm/NZuYHKdsUlwmQ87/aIWgrGmyn4EIMYPs1ZgHDS/rm/BaS4v98?=
 =?us-ascii?Q?FsTStLo4SGE6Skcf/zkZF3JWcYInPi0PNOiY3DOdDPRUjelgWNQrM2lJlkPN?=
 =?us-ascii?Q?6VIE3BZcvq/+G3+W7jUGolDhyfenX7q1BwjQucuGWMc00K8a+chK3R707KGn?=
 =?us-ascii?Q?RkKEXSGRbaDTmElg1jjQbfR1BbIoKvkJVgdJtTKMnEGI5FBgqf/7DJCUvZRC?=
 =?us-ascii?Q?OEI6NXRgk+HjrPm+8d+6UZbgsualmTLcYJQBwJTAMsMaEqBKDqZNKN6toBYX?=
 =?us-ascii?Q?e8qCWNnmUkD8Ds7ujxPaB1Prs/I1Aimqs2+AdjEIsz9/gHX58ohGqqC3/RAd?=
 =?us-ascii?Q?hJnC9J8+vJNLG8bYkRTJ25rJRFOrSNELOupCTNBK5OS6uM5NwVQgmq/lWEhG?=
 =?us-ascii?Q?qf81juIOioSUT7HGBOwj6PrpXAauVpuZ57M9tL9SAh/NYUfe8V8oYVvCaEC8?=
 =?us-ascii?Q?jCMzGjIvYkUaDiJKfJltlTFHmVMzPtHOAzvwFXFnoK/G/IxfMPnq7QZvevdO?=
 =?us-ascii?Q?LvUCIFwsM/zwc/5o6lPo9v3W+/wwSFLAwIq3vtM/m05USKaFrXuUS9ENq+DC?=
 =?us-ascii?Q?Jnm3Xhke69mcsWnk/a38EZSo4yNtBj1edzeOGP8r0u3mp3hwIBAyyKL5EuYi?=
 =?us-ascii?Q?6MrMpptM4Yl7daXnhZXGK1YXxemBktP1iq1UpGmqdb6sbt3K8l3l+Y0B9zt9?=
 =?us-ascii?Q?Q2+NsSqLFoy4reW5w9eqNI4YiL4/R8alvJKXkid0n2JzE/Oj2EJwubK6FSIF?=
 =?us-ascii?Q?D/NxZyWKlHDqPDFo3gTFklLN+v2mnj03yMe5SnzMNTcXpe3u6M6F3sZYpgzd?=
 =?us-ascii?Q?Ojb9tjXPvQoGyxHQMSNEa5nXbzDN/V8lwGGl+aCE0FpUyBSattWOuFHhvlo3?=
 =?us-ascii?Q?7uzYksRO8d1uaj7/P7aWyuK1kLpghwlzlW2WSx0i79wiG8eikz9mktv13NTS?=
 =?us-ascii?Q?DmCXabxlwMrpOHWgzBwQX2Tv6P8r1zk0crNijTpDiOtQrdAwK9pdyTuoOoEV?=
 =?us-ascii?Q?niy+gvIkIO6Ip22FnsglO2EWCqtNQ3d8r+u3fWbGQFfh1a2si7V07Xgxnjxj?=
 =?us-ascii?Q?q94GbOmwAsd+71vw/z2BR0CXrAaUCqdJUOuU4nnUOx03+rQnxA5k/TRNSVC/?=
 =?us-ascii?Q?0DF486zmdCCMz5bXdJhkmtaVn6V1gH4CJz39JWpWLOv24ZbfEy9AJjALvCud?=
 =?us-ascii?Q?zDh1PcYp5Mfa5o9N1VwXVzG03iaKcUBgCdrwRhTlXU1aM6ENoQ6ht5+oiJ2v?=
 =?us-ascii?Q?luBmUyyC19pgYDebrREUxj8OA3Szs+y0CQJrSR/d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8698.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f224d059-1640-4fcb-1abe-08dc5e37109d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 17:02:57.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLPfK/Gw9XfxTBAPIECJ5K7oc0+k791h2TQnS0XekT5d0wuXd7snp9e0N+I70YPZcPMtKzOIzExuYxetEyipAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8395
X-OriginatorOrg: intel.com

Hi Stephen,

I am looking into which utility I need to install inside Microsoft Visual S=
tudio 2017/2019/2022 to automatically sign off all the commits I make from =
within MSVC using my Intel email address. I think I have received a similar=
 email from you a few months ago regarding missing sign-off on ACPICA commi=
ts going into the Linux kernel, but please be assured that even the previou=
s commits and the above commits were all signed-off by me (Saket Dumbre, AC=
PICA maintainer). Thank you for your email, I will ensure I will sign-off t=
he future commits and perhaps if allowed even the past commits.=20

Kind regards,
Saket Dumbre

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Monday, April 15, 2024 3:54 PM
To: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Dumbre, Saket <saket.dumbre@intel.com>; Linux Kernel Mailing List <linu=
x-kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.=
org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree

Hi all,

Commits

  e1d3f9d46f17 ("ACPICA: Update acpixf.h for new ACPICA release 20240322")
  ed5addd09827 ("ACPICA: Fix spelling and typos")
  5a02527783ca ("ACPICA: Clean up the fix for Issue #900")
  c15fe3916b77 ("ACPICA: Attempt 1 to fix issue #900")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

