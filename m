Return-Path: <linux-kernel+bounces-123789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBAE890DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB11295783
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF623FBB3;
	Thu, 28 Mar 2024 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxVoULlU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADD17C9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666282; cv=fail; b=Jg63EbqbXCBsJBT/2uM5dRU3NK+Rn6LzRdbtJ3ZhqEunKoko7/OvalongNZueJrq30b2frKjsXY75ykEiSD2rIBYcL9anZ0HlSvi0yC8ZBJ6QZwXxJdmp+m+I/fiXDdIQSEIfuBDisVl1O4STVQbXR3KWfhnitn+/7gjPOgc5gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666282; c=relaxed/simple;
	bh=D1Oo8jPRktAAaAIkKOWarDeyezm7bt2sKXGlTCtaLc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qx/15hTCCiaPq+zi21DIfaWLEKR1wl8Pr4mIJP9oCwHpebNyKeXV3SUISmPzMePS+cg9xKUbR62CCGbYaLkBCdFMMCXUOV5nIPDRJ03bxL7rF87aMDpWQ2Yre4dM0KMv8TXbHyb4WtudU2V+dVhNh5g9Z4Won1smVRpPrs4TN0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxVoULlU; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711666280; x=1743202280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D1Oo8jPRktAAaAIkKOWarDeyezm7bt2sKXGlTCtaLc8=;
  b=ZxVoULlUDb6veLzrIIeHTk4v1B43Z+KEvQK08jf19fwrzRO74T53iklg
   6tOZTlv1HFj6MwD/5rO5+fOV+Im28TFafK1WDqR67nCEvfBd80oW3Vq04
   fJ5xYSZIPNn0bmufic1ytYHFYWtp97oBGPINgo1a+AbiDOr+4nLFhCeH/
   pLYjxBp0cKv/oyNPFhxTTINOb/ufyNCqGKi0zSD2v2/HVdi691YFr3yok
   0OjWyvwFv8EkN3aR3naQykVDuWnXF+Fbd6pZhiOGd3wivxxIp/pAmKmg5
   anAcJA1TfsYpTxBp5QXsyZmgyLNYHcg91yBhZad6mfFdDUR+ZW2NFAhsv
   w==;
X-CSE-ConnectionGUID: Mpja0Gi9Rd20pTdhezcTkA==
X-CSE-MsgGUID: yXqp50BDR+Sqll6diqtLpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6788409"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6788409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 15:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39953521"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 15:51:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 15:51:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 15:51:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 15:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMq+gf0VHw0XTqwtLM/H+n/CGA9MysshSDTEP9hm2wBHqw/W0Anz+cZ6MHYqrGQU9WBhNdLEBxpKz3HPZB7tOdIf0lRzJAG+Xyg99S62+VbTgh/h50BgPyZLiqtEqTgjFmQelCzYqMnLx7+qyn18T0ys6J+aT2sb2X3Y7BO5QWMb238pqWURsabnh1LfUtyiZUQRhnqNFG7X0CEx65ufKEWR0S19trWIJXOCKSNSPQ0i++GpZ+LfJr7B7LYdxdczCcELOTX6yjcKZJKMdbiw8EcNJfPt1/Ax5r7kRuQhle7GUcwnpcVJlY4dJylDn3iGwN5FX38+5HyjVrkyodHT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Oo8jPRktAAaAIkKOWarDeyezm7bt2sKXGlTCtaLc8=;
 b=Q8QtnKAf8vUfuJNZtoNU19ryqnBzemZ5U1WUOtYI07HFctuwV2TI7GG5sxfEXXgbPjS5X5ivff32jLgaKGLBA6dTIzMPhfQZ3vb3pk1G93boEiNt4P1I0JsmCHxNl330Gjk66pm7OzN/Bq6KVLgTMIXr0Nyoykrr+4AP1W06t1QbwjnxsY1Ity6LxHXMbcw5+m1GEaIhYUNUAVYPUvuzC/FpXZsnUj+kARPTNe0uE2ul9hVFQHKsUnITJ/VWEFnsFmmghLpDdPy91aSxmHOl+AdHJvlVaM6FsyIhlacn8weNyhSqZy0mthg6j6TtIL2wKO8Wm3/X9U9NA7VGNJdxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 22:51:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 22:51:16 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "peternewman@google.com" <peternewman@google.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "james.greenhalgh@arm.com"
	<james.greenhalgh@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
Thread-Topic: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
Thread-Index: AQHagVSutnqhh59/j0isvptM3hkEDrFNudnw
Date: Thu, 28 Mar 2024 22:51:16 +0000
Message-ID: <SJ1PR11MB60834E052730418BA2CF8E7BFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
In-Reply-To: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4681:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qThal5MItnLBb+EKTANQ3+DVmBziPK7Sqz9M8Ak0ZTQryHM35QW164t5qjUT8MFzmHqKPlS0yVb0XvfjyP0KbrjJSEwoJN6dvvsfuqtxdSv8i+vT/FGTnP4oQbtbesG8xpA/v9NNGIZbJsu4m4Dg4temTAoa0tn++zp+CFlzqYz3TK2595OToxK0WmcrOkXbdZ5DoDpL3/X2lc4gdrQLfPd70zVtw3xWy/oac9TvMQrr72/niU5P7BAyc+xNzSVqY57JANc9I3ttfQpLDt2bjChAx7EXTwi9VVa+7iVpyLECFjItV0FP/6jX3q26nvWxOmIfh+jeuq1sPR/lBn7WwFNjFOJdg1d4c8S/bls/Pj+vmuu7NXwrhhzrgdR7975blXU/pekaV8B0gbKJvGA6RUrRsYXiVPkPkrHV+PcSbndAWkUfd4aCBfUIi1fwltJqGPfSA8pMhr2uPxckkN56nMGN9z1PrAEkw3aI+lHug1AA9fivRl2GHKM3qtCNZkmjQH3jkMAU6wjv+70ShQJy1apOnmjYDvi/gW8P7TDGnIIaqyZnpGb3J0spB55ZMZgybODTCCYmMlrsd9q1sgskB/r4d3WAzaXfaQv2sWwgrNJIxLOAb/0uFv+MEF1AGny+S5agwJBDmXLWfpbxjgtzEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yfFr0uz5TJQVT0yG2MQ126zkgpvEtCsgJKx3PFi6U0wtGH5eRaTyPzWe5MRr?=
 =?us-ascii?Q?KNUf9L0aSmA/CJNMgcahyjj8O9f6E3Ox+/4oge2RoVnB6QvJ79Mri6PCFxZM?=
 =?us-ascii?Q?W8nm6NpKcjNL0/zVy5tbdwloB6FymnmxkelbqT8wU61Q75xQOZqpxg4fFlfz?=
 =?us-ascii?Q?Jq+GTLRiLPJn1R9XE3vUvKxmAmB/FfZjz3znsS64tk8Ith4rKlx8SVo80GsX?=
 =?us-ascii?Q?uIimBj+KpvGBpNGSeaYmqh235R7yKCuhRVJW2u7FFyDa29pKjaMqiKsXxW5r?=
 =?us-ascii?Q?npv4zOJE1yNOgtPvXARnmpF214o1Z/80ZwzLNZu+mNhxrA+lFYE45u1GFm+/?=
 =?us-ascii?Q?8eX9y8vdC7yOJ2/h1xAityrsX0jiPTzoaRuVq2gmZ/y2muHgcLt3wRvJAWxK?=
 =?us-ascii?Q?/tK3DM70D+s9jhDHrv5Jtw5SCGfhHMNy/6XHWryZs3yOl9Wcq1ZI/dSJZPB7?=
 =?us-ascii?Q?qnaafX8TvCqfVfQLqDV6fu5dO7vc6Jg396lfGQPbhHNc6gubG5YxeXs7FkBn?=
 =?us-ascii?Q?40BiwVlPDQ8VEhe292u+Ya73ob4NzIxYjYwUm8Fpr1e8cYYNxpV8nLz8IFFy?=
 =?us-ascii?Q?QN0TIp3PlKQ6rEOcRhJVt9vlToRcKlOlFQqxsQr7lDeGKLemFjVnu/nPAnwq?=
 =?us-ascii?Q?VN8FE0g54Do76wlRYBonADm0fvcmZiJd9VT1PRkZmsUBFZGnccV1SzggPGnP?=
 =?us-ascii?Q?axFHZyHuiwGEunt7aYjW0dxxgdJtlvIDoMvjev8umanB8SUVnqFg+aF5pbnh?=
 =?us-ascii?Q?PkA+KYFJG/USI8i6G446wYD//cjRWFYVhH+t+o06j4c1XXgcdd5zMHr8NftN?=
 =?us-ascii?Q?yhLUBtMtoCPg/K9DrV4xl1HIL+He58RHI0gBTULffwMQttvqNh/56dO9cQES?=
 =?us-ascii?Q?1Ob1VKS/5L2ShUCiC8KuVe2x8JgUXJ/FbjK+uqb1Aw65vHOBenWYWPyrWBjo?=
 =?us-ascii?Q?lLGEm3TubOoVzZfAAKPFoRgUhxbAfr4UBrEmX3yKDgbNGrrpqI4cHb7MdSAs?=
 =?us-ascii?Q?CQwLbU3nYKlnSdp98BOrNFmkH4580z3Zlrr+OEzLWgikJJn5hdhWbdDBNriZ?=
 =?us-ascii?Q?l6VzfF3JZJpsd+XvaUnPPLENcucP43I4JjNY3Wnl3U73wlcQ9Yf2n0xjqoyt?=
 =?us-ascii?Q?NYqjSuhLszUbdhViuPMllQetXP974noAtWyNUVPmcBxnu9csD5Y2aV3hR/Ci?=
 =?us-ascii?Q?8AQnghD+m5oFEavmI8YybPyL39FzVajv6iKWGIVSHFi9dsm8ZeJtmJMHobSw?=
 =?us-ascii?Q?dlZC1ZkO5OrcxS1S10C8tw7B7w0uSJ6RZLlZd2pv7S19UvpQzSZgUcf4r7+q?=
 =?us-ascii?Q?QlQikSyP1osVVOlerMDbZfK/hM7kOY79YLboFgt6qBT7XFx54CfFMnIc9SKv?=
 =?us-ascii?Q?Zub2tT+96XAmovp0apGE6OL36qpbUthiMDAAK6Eb3KgeTA2xQ884OiXXFfin?=
 =?us-ascii?Q?JHi85iP/ig2dNvGyg8u/Ongjkb1jjrtNeJlfXPjZEsGXIE3pjmIUvuQPy7tX?=
 =?us-ascii?Q?7PNjBdCJpIQqUrgScHlcgAeyUFguAp6fwC/UcNdqs04Yv42hajXPBVj6f9qd?=
 =?us-ascii?Q?Xzs9o+efrlaYh4exkXTLuYIx3/ei0qlLnBVsC35k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db9ab19-e207-493b-2f2b-08dc4f7993c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 22:51:16.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hnJ4sikWE7JlO9bVKZ+oSQk0Knqi8r+kgvKAF4tbIOHoVs5jDPkq+ZhMAGwYu+RzXLU78IO/+HLT2yUu2+wIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

> Add a tick_nohz_full_enabled() check to ensure that tick_nohz_full_mask
> has been initialized and can thus be accessed safely.
>
> Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for lim=
bo/overflow")
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

