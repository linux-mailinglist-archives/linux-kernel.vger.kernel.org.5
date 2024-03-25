Return-Path: <linux-kernel+bounces-116670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FC88A25D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45CA1F3C041
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B71B24E9;
	Mon, 25 Mar 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExDpmLCH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70313958D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353011; cv=fail; b=KS826znzIpajFTHnS2nwG6jm3TOihZli+HuMH2yK0R1aPCniALtIN1v1ZAnyi0Ziz/rsiUMw2O7AYBWbHyWzFK3ZaqGw2CCDbDBs/mkc2c1sQcV8MYW4rsNJRNNsrZY5eKEE6P7Ql3SnvzW6uC+Ce5esdxHtK0MRBsEluKydfXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353011; c=relaxed/simple;
	bh=fr/qXZxPB4gXTDbnY97jtYEHJLi65+XwwBg3a14T5Zc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyOuhVDsmGKIaHiQeDEbh2IMuyPU/NuokksEkK374Gf7GvCqn9L5D345xU+CV42K36iSdGzcWpq4ljwzBZ8aS4fhI0e5DD/4k0IDJVKS2scfcKBpTomlnTWPjWPud3lG9RYtLtzeGtsmfwVBUgekUafC/+2dvDAtICLuRhSuZ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExDpmLCH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711353010; x=1742889010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fr/qXZxPB4gXTDbnY97jtYEHJLi65+XwwBg3a14T5Zc=;
  b=ExDpmLCHK44t8gJAOpQMzjVWKZoBVn7R16G9X+pM6QIwgrZqKTe/4d2d
   VhnCCW66PGB1h5AJERT8+cVcAeDsUUNA25tFedwCOdc5WCcNWZFCcu3jR
   2gB1F0v9KZ+YEfIT65gvUN3TtI7jE3K/z9e4iykTeVefdTunbvP7FWqAJ
   T1M+81MjO3/pxC+/xLLSLrVmDJwrEL/wT1Zav0ARV5e0IUsJr9yAKIW/R
   CGJUiV6ND3OscKqhAw+oJZ6DImb4Nxwo7b+dGjC0CJaKX+aICEdWbNwzL
   RuCOMRLSHCxGWTbgGkUpHvPYMb5c4EyORdvfnzpTOAlpLDOO6pWnXAT9L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9297284"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9297284"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 00:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="46528646"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 00:50:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:50:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 00:50:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 00:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RianoT9wu8Wlot8hpdL4V51Zwctdgqap7k7OBfUDpd0XWatEyNp/6XeD9pkpPxEj/T50af46+b8aiMkUBcgaJaXfPeFZ5Q0toLzUu317/48Rz12492VCfCgI7rcRGIirnNfm27B4yYS5QYQDOgPxhZ7dGU3TPw0vTLGzHgp6yjz0YXva0lBADs9FyMiOmUDHi4WTM1hTlRUBT5DcNt/IqmTnaOYVgY15XiBcTSM/8vLxuArpUqmZtWkkRU6PY+W+kkx2f9RGQFUCwxcTL0IGtMkgLeX5opxkV6J0WxLAeGpLjspotzHCxDbZ34w6gBNE0t18J0oyj/i1AN1PmH1zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH8Q/Dg6A2c1bW1MUWSO29dSSVqHARNt4wbOfpD65hE=;
 b=WPUdboVPvOvh3d0p1TWfPeE5vFNH+u/ZIuszMWbjMoJWyUWFl/DrPRJESr3OUsPHZekT44SgJmYzNGYhp5xxdABTIAoNfKF+4RrseN7sVRHO6Azu/kirK5jGyvPI61fjoMt9B5s8X5D4X9QQ51zxfOGYOX5vHNBA3pG0XxtsIoYL4wpyOq4Sc33qB7qC0WDyFV678uIJdvknNTP5OYKLqTbVbRfOW+ZAeUFtHqF9D6OZ6uCMI0ke3fMPbnVpHhmLgRRu04VcM2Mja5r3xILsgv9Bz1oE6yUW54CBBYiUS/kD2LpYwzCtrdD9O2nDanS9HPn5ZWdVG9wYNy/B1bjc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:50:05 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 07:50:03 +0000
From: "Prasad, Aravinda" <aravinda.prasad@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "s2322819@ed.ac.uk" <s2322819@ed.ac.uk>,
	"Kumar, Sandeep4" <sandeep4.kumar@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Subramoney, Sreenivas"
	<sreenivas.subramoney@intel.com>, "Kervinen, Antti"
	<antti.kervinen@intel.com>, "Kanevskiy, Alexander"
	<alexander.kanevskiy@intel.com>
Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Topic: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Thread-Index: AQHaeTeYeVMaFIFnV0yMrKTBAlKavbE+h/4AgAIFciCAAkoDgIAApzzwgACdgQCAA+/JMA==
Date: Mon, 25 Mar 2024 07:50:03 +0000
Message-ID: <MW5PR11MB590713C19D7BFBD861A990E0F2362@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <MW5PR11MB5907D17C1EBC1869C553256DF2312@MW5PR11MB5907.namprd11.prod.outlook.com>
 <20240322183236.119419-1-sj@kernel.org>
In-Reply-To: <20240322183236.119419-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: 8fbac515-abbe-42e1-2a1c-08dc4ca02e8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1RoKz2Twqz3+4bfyAjlS0uAMx1/fB186+AuW8ndMNnTL5GGBOwgzJpW/tOoEk4Q4GGexrfNtWBf7PrZbauz5Ww/dHvw6FanSSHWtT6sdaOVda5/utSG9+cB8DVqCJtduwQgOWD2mijfVINmfU+eywnuvYN9mjSYFGW97UJFa/BOtUf1uW3Uts4RCYyeGwIZC1tQ9rTPSRdxXfvMZcvDItbYfj/AAD/kxczYGL792VjsANPBn5K4JXg16Es3X9kvfbHyNnyatyo3Qu168q0HO5cBiwxg24tcMaTS0Xg2PfpseNj9J414p4Kc7E63ZsC3lBn+rJFFrh3HHPLpJp11HDLh1lvKzs959s+WLwBfnLk+TOEWKQoXb4C1Lv9PESYl8kFn+MefpaqXTS5UnZcOD/RVYCZ1M1ohwiT7HJ8WE107HdUELSXT25wZumBuevFL9lQou06DA5YGitN62zvAgSqQLEe7xVRIicGtXlhQKFoQgm4DQGate7fLUNUvVe2BRc1JhoIBjPCeK3m8udq4LVec7kxQkYFEXNCPwiwXh/M2iE7Ug4C/NNVGb3mmO4/kqjIM7iHEGrh93xWHXXLOR9HdvjUngpspOX3gSjkOenNOk+f2YH1vEt59EuIGNw8DWhTX3I3/XiTT+xNId9nyWDMHH1CipgUsj4fkn5R1t/pD23T+bGCf1+nruXC0FSggJG99SObfTsEI3DF/gPnUwPC83efw3gAeIhT0kR2MPSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WXe52CZ/Ja7qqfwImhoE1P6Nk8FYW2nk+cA+WWmnBJSjBNj40+x9MNxp5aON?=
 =?us-ascii?Q?tesLRy/GZD0pJnbf3qIJMzwMSxblK9abzlGkx/lYm6x+CTeDtU1znR7+s5dU?=
 =?us-ascii?Q?9GBSeaDq0pMcfYRhvZ+EzsJiS0/gHuqhg8Taspv/VwyxB7+LrGxjjaEFlFTh?=
 =?us-ascii?Q?bXIvt/eqNpoCDDmf4xyLMM05pC+5T4m/Wai83yj6JwbOveAR7PvuIS/kOREk?=
 =?us-ascii?Q?81N0+OnqoSUAGAmguJMbOzh17tPij9lRG4RQRlk4wJhspymEDHGFrjUZc7b1?=
 =?us-ascii?Q?8ViDyRjcVm722wv4bxZYJsxmZSfx/pWQ8s1SwJhxuG0NqCFyDNvZVaVQvZAL?=
 =?us-ascii?Q?MNscgcBMKrUjiayJFzYZ8Lid17QEwQj8sk1se6ISNGPKBDNzQxSfIrUl0Tq5?=
 =?us-ascii?Q?XwM8xV7bCI5qWK3w4YucRrZSVGdspGQbVLsdL83u5kG3+PzFEfwkbFTFNTQn?=
 =?us-ascii?Q?O1+Vz9f0vG8+/ZtIj9vMounWhSIXFkO1ICEAoUuCA//BN34pEdj1J/rZg6df?=
 =?us-ascii?Q?ESYYPvhG/IJallgL8cjeqkb/E7WpHSG67KbAKjNcT9gWqWp82AGP5nd24aJ4?=
 =?us-ascii?Q?H/jiz+oQpmqSihbFTyvr+/EmstrIwiMESwH3etAtp7Ymj7ZkPESydG3WkYBX?=
 =?us-ascii?Q?nI5l5uqveBJQL6jTY+DVBKIwUg+VUm+P2nrE04kCfqV5pdBxMTmH2nwheIvs?=
 =?us-ascii?Q?jQRmqWrJmi5HFI5lGls23ozFnoM6sFI+JSX/ldmwwU+mqFUFozvCAuFOcyr7?=
 =?us-ascii?Q?aEiBAtTDWsnOq/BNBpYNegazg/gTsnHT2TUU2ANaH7PsVdg4Qdq+hK9YzDxW?=
 =?us-ascii?Q?NrWPAxShZs1pAOUy7BKZCTG1VAJHrrPMDcoT1yX037l/euuaQNum/EgksF3U?=
 =?us-ascii?Q?WnPcGtm5sP0JfPod/Vh54pzJ75gs7HL2gNweT1j0ETrtJOTtttesaxQSV2AN?=
 =?us-ascii?Q?GU0dPdky2nsUa548Y9evAyBD1EmfphBPj1sd6oXp9kc0WmjZj89AIaLZMj58?=
 =?us-ascii?Q?XJpqZoujwyAyGskUmc6OWbNEAxofLma2D4dJkMJndlnyC6SRoqNSvpxSFAWb?=
 =?us-ascii?Q?0SqBrwYlFFIC3tkTZOEu4pZzmZRlSr4/i6Zj/hhxp7NJMZ0m5yS3daxvJ7bU?=
 =?us-ascii?Q?q4FSPX53kYZWBHTHqNV6Tw3gBv9+Lo9DiwPaV0a8bj9jRPiRH+H1G/yPRPqq?=
 =?us-ascii?Q?Llm/VutjsBh34EMGDes9pnK27yZloinrj+3ge7tPKn+7LCtM9FGQ4xe2+2Br?=
 =?us-ascii?Q?qPi80rS59YX5pIXMEHtNMN8eXiE06CDV2VuIbR6BIHfW7zuyDX7uVmFsHUF2?=
 =?us-ascii?Q?xttFkOrEcB+UUN702v5XQYtVJ+pO0rgTXardVo8uK9vC1q6JCeORwfFV7amY?=
 =?us-ascii?Q?VVn4AE55cuvqHMWflUguIFq+OGKezOx2bmQGgAZ8L6Dx6Z+AaEiur1hNSfEe?=
 =?us-ascii?Q?wXalhhfG1rvwcvmJOzQIrfABMUsUEd5an/heq9JsZBvD76rGvcc6gBa3V9rO?=
 =?us-ascii?Q?0LSBkpSe5nOj46OuWgzbZ4IFcPMWZITdjrQutHK4RY6Iw+uyOyhxNQzoccxp?=
 =?us-ascii?Q?f0+ch0mxitLdJUcxUE3fkwnOOIzGSbp3/f4JbYa6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5907.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbac515-abbe-42e1-2a1c-08dc4ca02e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 07:50:03.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8lkvxblIz6eQhrPsKoi8GHauWiPqxaJckfUQS5NMC26MJ78lvyxOx8d4FbPBNiJLG/cx/UfTqBuIbUq14kAyOZFBheCGfP3cYcxyqyowok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: SeongJae Park <sj@kernel.org>
> Sent: Saturday, March 23, 2024 12:03 AM
> To: Prasad, Aravinda <aravinda.prasad@intel.com>
> Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-
> mm@kvack.org; linux-kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar,
> Sandeep4 <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>;
> Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Subramoney, Sreenivas
> <sreenivas.subramoney@intel.com>; Kervinen, Antti <antti.kervinen@intel.c=
om>;
> Kanevskiy, Alexander <alexander.kanevskiy@intel.com>
> Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
>=20
> On Fri, 22 Mar 2024 12:12:09 +0000 "Prasad, Aravinda"
> <aravinda.prasad@intel.com> wrote:
>=20
> [...]
> > > > For large regions (say 10GB, that has 2,621,440 4K pages),
> > > > sampling at PTE level will not cover a good portion of the region.
> > > > For example, default 5ms sampling and 100ms aggregation samples
> > > > only 20 4K pages in an aggregation interval.
> > >
> > > If the 20 attempts all failed at finding any single accessed 4K
> > > page, I think it roughly means less than 5% of the region is
> > > accessed within the user-specified time (aggregation interval).  I
> > > would translate that as only tiny portion of the
>=20
> I now find the above sentence is not correct.  Sorry, my bad.  Let me re-=
write.
>=20
> I think it roughly means the workload is not accessing the region in a fr=
equency
> that high enough for DAMON to observe within the user-specified time (sam=
pling
> interval).
>=20
> > > region is accessed within the user-specified time, and hence DAMON
> > > is ok to say the region is nearly not accessed.
> >
> > I am looking at it from the other way:
> >
> > To detect if a region is hot or cold at least 1% of the pages in the
> > region should be sampled. For a 10GB region (with 2,621,440 4K pages)
> > this requires sampling at least 26,214 pages. For a 100GB region this
> > will require sampling at least
> > 262,144 pages.
>=20
> Why do you think 1% of the pages should be sampled?

1% is just an example.=20

>=20
> DAMON defines the region as an address range that contains pages having s=
imilar
> access frequency.  Hence if we see a page was accessed within a given tim=
e
> interval, we can assume all pages in the page is also accessed within the=
 interval,
> and vice versa.  That's why we sample only single page per region, and ho=
w
> DAMON's monitoring overhead can be controlled regardless of the size of t=
he
> monitoring target memory.

Initially when DAMON creates "min" regions, it does not consider access fre=
quency.=20
They are created by diving the address space. So, at the beginning, these r=
egions
need not have pages with similar access frequency. But eventually, as regio=
ns are
split and merged then regions are formed that have similar access frequency=
.

We observe that hot sets are spread across the address space of the applica=
tion
and many times, only a portion of the DAMON created regions contain a hot d=
ata
as per the application's access pattern. In such cases a single sample per
region is not enough.=20

For small memory footprint applications with small region size, I agree the=
re are
absolutely no issues (also confirmed by our experiments). But for large foo=
tprint
applications (1TB+) that can have large regions (50GB+) we see these issues=
.

>=20
> To detect if the region is hot or cold, DAMON continues sampling multiple=
 times
> and use number of sampling intervals that seen the access to the region
> (nr_accesses) as the relative hotness of the region.  Hence, how many sam=
pling is
> required depends on what precision of the relative hotness the user wants=
.
> The size of the region doesn't matter here.
>=20
> Am I missing something?

As mentioned before all these are working fine for small footprint applicat=
ions (<100GB).
But as we go beyond 1TB footprint we start seeing issues. I can show you a =
demo
on 1TB+ footprint applications.

>=20
> >
> > If we sample at 5ms, this takes 131.072 seconds to cover 1% of 10GB
> > and 1310.72 seconds to cover 100GB.
> >
> > DAMON shows that the selected page as accessed if that page was
> > accessed during the 5ms sampling window. Now if we increase the
> > sampling to 20ms to improve access detection, then covering 1% of the r=
egion
> takes even longer.
> >
> > >
> > > > Increasing sampling to 1 ms and aggregation to 1 second can only
> > > > cover
> > > > 1000 4K pages, but results in higher CPU overheads due to frequent
> sampling.
> > > > Even increasing the aggregation interval to 60 seconds but
> > > > sampling at 5ms can only cover 12000 samples, but region splitting
> > > > and merging happens once in 60 seconds.
> > >
> > > At the beginning of each sampling interval, DAMON randomly picks one
> > > page per region, clear their accessed bits, wait until the sampling
> > > interval is finished, and check the accessed bits again.  In other
> > > words, DAMON shows only accesses that made in last sampling interval.
> >
> > Yes, I see this in the code:
> >
> > while(time < aggregation_interval)
> > {
> >   clear_access_bit
> >   sleep(sampling_time)
> >   check_access_bit
> > }
> >
> > I would suggest this logic instead.
> >
> > while(time < aggregation_interval)
> > {
> >   Number_of_samples =3D aggregation_interval / sampling_time;
> >
> >   for (i =3D 0, I < number_of_samples; i++)
> >   {
> >     clear_access_bit
> >   }
> >
> >   sleep(aggregation_time)
> >
> >   for (i =3D 0, I < number_of_samples; i++)
> >   {
> >     check_access_bit
> >   }
> > }
> >
> > This can help in better access detection. I am sure you would
> > have already explored it.
>=20
> The way to detect the access in the region is implemented by each monitor=
ing
> operations set (vaddr, fvaddr, and paddr).  We could implement yet anothe=
r
> monitoring operations set with a new access detection method.  Nonetheles=
s, I
> think changing existing monitoring operations sets to use this suggestion=
 while
> keeping their concepts would be not easy.

Agree.

>=20
> >
> > >
> > > Increasing number of samples per aggregation interval can help DAMON
> > > knows the access frequency of regions in finer granularity, but
> > > doesn't allow DAMON see more accesses.  Rather than that, if the
> > > aggregation interval is fixed (reducing sampling interval), DAMON can=
 show
> even less amount of accesses.
> > >
> > > What we need here is giving the workload longer sampling time so
> > > that the workload can make access to a size of memory regions that
> > > large enough to be found by DAMON.
> >
> > But even with longer sampling time, we may miss the access. For
> > example, consider all the pages in the region are accessed
> > sequentially. Now if DAMON samples a different page other than the
> > page that is being accessed it will miss. Now even if we have longer sa=
mpling
> time it is possible that none of the accesses are detected.
>=20
> If there was accesses to some pages of the region but unaccessed page has
> picked as the sampling target, someone could say only a tiny portion of t=
he region
> is accessed, so we can treat the region as not accessed at all.  That's a=
t least what
> the monitoring operations set you use here ('vaddr') thinks.
>=20
> [...]
> > > Also, if we can allow large enough age, the random region split will
> > > eventually find the small hot regions even without high level
> > > accessed bit hint.  Of course the hint could help finding it
> > > earlier.  I think that was one of my comment on the first version of =
this patch.
> >
> > The problem is that a large region that is split is immediately merged
> > as the split regions have access count zero.
> >
> > We observe that large regions are never getting split at all due to thi=
s.
>=20
> I understand this is a valid concern.  Especially because we currently sp=
lit each
> region into two sub-regions, finding small hot memory region in the middl=
e of a
> huge region could be challenging.  This concern has raised before DAMON h=
as
> merged into the mainline by Jonathan Cameron.  There was also a research =
from
> my previous colleague saying incresing the sub-regions for each split imp=
roves the
> accuracy.  Nonetheless, it increases overall number of regions and hence
> increased the overhead.  And we didn't get real issue due to this from th=
e
> production so far, so we still keeping the old behavior.  I'm thinking ab=
out a way to
> make this better.

These issues are observed only when memory footprint is large enough (1TB+)=
.
Production systems may not be using such large footprint applications yet. =
=20

>=20
> That said, the real system would have more than the single region, and th=
e access
> pattern will be more dynamic.  It will cause the region to be merged and =
split in
> more random and chaotic way.  Hence I think there is still a chance to fi=
nd the
> small hot portion eventually.  Also, the sampling regions are picked rand=
omly.  A
> page of the small hot portion will eventually picked as sampling target, =
even
> multiple times, and at least reset the 'age' of the region.
>=20
> I sometimes turn on DAMON to monitor entire physical address space (about=
 128
> GiB) of my machine and run no active workload but just a few background
> deamons.  So the system would have only small amount of accesses.  At the
> beginning, the monitoring output shows all regions as not accessed (nr_ac=
cesses
> 0) and having same 'age'.  But as time goes by, the regions are still sho=
wing no
> access (nr_accesses 0), but different ages and sizes.

Have not tired with physical address space monitoring. But for "vaddr", we =
see DAMON
working good up to 100GB footprint.=20

>=20
> Again, I'm not saying existing monitoring mechanism is perfect and optimu=
m.  We
> should continue optimizing it.  Nonetheless, the current accuracy is not =
perfectly
> proved to be too awful to be used in real world.  I know at least a few u=
nnamed
> production usages of DAMON, and they didn't complained about DAMON's
> accuracy so far.

We see this problem very consistently on large footprint applications, so c=
ould be
working fine for small footprint applications in production.

Regards,
Aravinda


>=20
>=20
> Thanks,
> SJ
>=20
> >
> > Regards,
> > Aravinda
> [...]

