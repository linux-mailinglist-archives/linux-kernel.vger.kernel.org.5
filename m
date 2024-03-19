Return-Path: <linux-kernel+bounces-107432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF587FC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3299B1F22DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F27F483;
	Tue, 19 Mar 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxeJm6i2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C97E10C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845815; cv=fail; b=OuzrcIlnqFj0iuor5K/UNe/R6ug8uktC6iqapdHOQk+qP7eVdyRl4HDGA/c6AbNW6/wF+9H7QAMtd1F4XSSf7Gf4zBJC4EASUKj6QZd+FXDSYybgzO14y4wfWGM3/Q3Bz+/q0Ss4ypBQ/cGx5BkIFeskmwAyuyBY2eoMjpOHfWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845815; c=relaxed/simple;
	bh=nYsjYSe48Cq8Mkz9vsfXe05B7weuzw++Y3zTuzpYsKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KtjPH8AwO2QACBmZuLP3nuHyMS2rJrO8Z0NZJjXms6nMJIlT6e+W715oIPZnj1iczvORTDkEUMMZ49SNW+hIeYob1j0AKp6ENx/PWoyfIS0p8/hz7OdMVKh/FTjPdFygDjgIb5p3a7sv7vKfLXaHoOazV1zkUENMByM6nVaNIE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxeJm6i2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710845812; x=1742381812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nYsjYSe48Cq8Mkz9vsfXe05B7weuzw++Y3zTuzpYsKk=;
  b=JxeJm6i29Yy83NoJ6uZdx/Smbv8laGIUUhhIoGd9kxC59JwcFqWlwkaa
   2FZg1qGIuDNSZXJm9QFCuI/hBju2t+VUYTMSo3XZStNT2SpqHTNuLMokK
   cOqBPPYpadWMMVdPCguKNFhK/FkQhf4KoPhSXNNMZSaypd79I2RMJG/9w
   1az/Zu5Eo1efUUS+bxn9gShPCokOLNw2zCCkMISJMlz0DkgQUu65Rw1xZ
   zRcV8an2Un3EcyXxH8yoCSsSOC10WPDEtsrC4a1NtTKLpftN7UpGAb9Rz
   jGQVIvXbejpDkxRFvCWBsvFMBG9Tyy+ogQFFIsqaMg/OyDhMUnLe6Njje
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5827568"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5827568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 03:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18346465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 03:56:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:56:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 03:56:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 03:56:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaHF75plz76kK0zs4jJrUrnT0HJMe5cnpjb5PUX3gfc4MQC1V9soRvGlRDxtWOoR0L+0sRDkQxczTby8dBHhO7GEey+O6QtbhmTBz3cxA/cJ3wAV7k8OWZR27s10ahGxlDczFib6Qe3PfNmranfCAso4jphuuaUpgD3r/lCDgTirwqr2xSSnRZWRs9x1WvWrfC8MoUku/IxTpsu7bsP0v6QiE9S332NWUExLstMqgYH1t5SX0ARbvtqV/bzx9vIefkHXCmFqQBbdNSzLdb3mXHgo7W9t333dPBcud0/qMGsLPKy9U+KsJZUZFOtrTtXebMgGoH7Rw1wiM/eUWbgxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELawWIgEjMQ8vzDwdbAOZf5AesXynglPXTs8JkXXkNs=;
 b=Nh8iIQ2KLea2cY8579X3x3Eryzs5j/ghn/N1bQ+2baIOg72SXxZZ/cVnAtmgiYzY8IspyqTItJUsASjLFUk+AqKrbgMbAg1GBYojHAz1hJgHH9k0g4tHsOQqJNapoIDuEngQMCm7Wlm9XQbUSuMjK1tBxpZoudU+8cAuGCIB/85QictxOd3N7OEYDayEyixgHNskVLk9Vsbqqr33rSp3e6seXAAy7KRSndREH90wNy3PlgF6HGz7jWkDiB7xIz/EU/qnPsC13EPMSDzEefcqnDsN0JCzMElqmubLIjkqkRgi5elrysQlEjiv7hFTFtNITysc27wY5lVV41ix4f6FOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 10:56:42 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::bcbf:4501:30f4:843b%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 10:56:42 +0000
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
Thread-Index: AQHaeTeYeVMaFIFnV0yMrKTBAlKavbE+h/4AgABRr6A=
Date: Tue, 19 Mar 2024 10:56:42 +0000
Message-ID: <MW5PR11MB5907F44D802C298E8182A1B6F22C2@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
 <20240319052054.100167-1-sj@kernel.org>
In-Reply-To: <20240319052054.100167-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|CO1PR11MB4948:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBgiRSOwetJgtydZT/VBVBTeympJbjN4oSOhJbl9/CWlNBYggpa6c2CHQIP3N9POXRiI9RhqeCMOs5ERNpGJyDtEIVTvAMGEuELRzHTnmd0TIUjY8fI4PQORRWobQLEDkf3ajSq9kpDH0FH5co9GAfPt11yzPfY6lDXEIfCoBzn/5+pBp1l3OFDIVY+0MD9M+hBSn4CcDT7ydlZPKkShf67UP92eaQmaX84Sz0Zy8YFSJ12fcnPXRjOs18smWiGSzTZLmTsnS+BlJ4NwBvxNndZKhxGwV5hx+rvYEuzR5gY/NZpR8m+KStAaSoHbly3CSdil44szJ/7w/49yDEOxsyNZfjS0rqhw1mXvGhqj4jJN557tMpYbqswnTI8wzdpQe1z/pjA+f7MS60yyQYPUaAs16KrRdvar/gyZkpdOPtQXVtertfdW8NOrrozsRAmNtj03BCfChwem+wKn2bE8jgOsJVmWoZ/j5lljt4UNpql95Gp9K/scPSEquPxv/u/0+TiXDj7XWNPG7XWRsZqAow9ok5lhmIhaBWTOdTY14WQQ7I6+jTGXyP5Q0eSI4HDwf9bW8hvIynv7Ib5qWVhO6v133eogtCLccBbjg3+HE4dY+L376ubvqcuCr8Givdby
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WG2FOibTLTNKbBbf7+nkJVE3jncr+RDbGRB6ipG3RT+nuO+1MCNwHInCYo3O?=
 =?us-ascii?Q?kd4Abwp1/WKXmclWtaKVMNIp1B2nizUgTBxtHeOW3mIRdRJzSVumibopmNr5?=
 =?us-ascii?Q?uFqpGFA9W6TSyjGKpY8/fzY42rVqTVgUEGiniAGqiyr/X/JjSPYnGF0LMadk?=
 =?us-ascii?Q?Y4TjY3zTZeP2+A7DatymQ0RPgdPsOsFF3FQeJJX7HKOExk9vD5tHUdUQ/e0n?=
 =?us-ascii?Q?JDwnchU+9h+SeHxaSeGzCYUkaOu9uB19ZqDEKeFzpWG6kEyFWcNB3H2uzYsl?=
 =?us-ascii?Q?hsTHoK0ncgZ/TCNNuW8wFwFf/Ur7QugXTlc1tctnYQmcsPM1UjysUfycaxyX?=
 =?us-ascii?Q?AzOsTXmvwvKCNnLu2sn9m8ayhVVEalHbd0or8V0AOAC5xNlqYmuVkt3jkr5F?=
 =?us-ascii?Q?ta9+ZsUhYjpUTG0sbHE+89SgG2CUUCqYlfbh0FT4smhn3+024sWeNYnXJq30?=
 =?us-ascii?Q?4z/3mA4vVbOhz1GhmIVre3zCCNZV7rFLH5hsD4BGmhyNovbOxT0Qn/l2FyAv?=
 =?us-ascii?Q?+EoLuSB/F63sxD8Sim3S6jBu7H9dpFL4bQ5CmzVLfXvCmasMZ69WYQAvamLS?=
 =?us-ascii?Q?JPPWTgHQ3hjlu73gHisxRhw5MJKv92Xkjf/mkAog7doo1N7UY/9ikOpNGHFd?=
 =?us-ascii?Q?dAsAFt8bZhitDJR/Z9744kwISjas79Obx5ox0R/MG5mx7O1t5u8zl6N3PIJV?=
 =?us-ascii?Q?+Z/nvgYOfUvLairpmtOJtlX4ufH40NmTWtpGG2r+WVXkTsEN9o/xeDw9yaQH?=
 =?us-ascii?Q?FUiPhZc21Le6WME0Vul8sPH6aOjr/BIgk7ACVdCb56f/wc6o7GRYR56ZIgEH?=
 =?us-ascii?Q?y5HfPNImFsQWDYdMEJncCPsta6HUkAmuTjXLmQGW50jzVS1A2S+JnBwWVETL?=
 =?us-ascii?Q?N3+dcq6mE0YcqjgNrAB3HIbwTdRQ1wwllXYVhXX9svRFCca04on7qIXdL9p8?=
 =?us-ascii?Q?4CuAbRtbqacV7DgpRoRvGVbELcFV1jirDDTQZw2HDvMx8JL71yAhrhaFo4QK?=
 =?us-ascii?Q?pjgCBSLTzcjr6HgOuZF5UdRzTCTpeNxABY5t5BYZebiO9ZwyEWhrjJtLAxo8?=
 =?us-ascii?Q?GSCFRbhwzLub1gdZxXJdFgcXvgVnXn5DR7SO0ovMNGxemwqI34Bu9g0c4Piy?=
 =?us-ascii?Q?ZDQJuGCIJUZVPAfF+P3YLH1Q1eTuMsOqkgCEKX2dPbJn3fc6Sy8NJUQiSU6o?=
 =?us-ascii?Q?6RwfomSapBhbz/zqlZslnHfb9Enf9ehOOaF03+2DD7IbhtOZGOUR/HUlGTDk?=
 =?us-ascii?Q?Bs2XjOXK16+4a2w2XbqPcKfTHfWQuvfSGxVh4u86I6E6jGXucv+Jx+q6bvGF?=
 =?us-ascii?Q?hUOJK1mAHFeKG16fZ4yLWPR0Tt3QBAtSPQxRc/pTQvSf5oLaZ/4Z7XZZ6O9J?=
 =?us-ascii?Q?l9SGYoPnZV7wyeIV+AgwpO7+O5ZXGMz99r5BTQ3d30iOF/LDg3Ioc39sImMs?=
 =?us-ascii?Q?KfULCRZ0vQbVAfaNLgbN4brnoNcfKvc+LQ0jpz8j8EpXNJA7tqdo4aDICk94?=
 =?us-ascii?Q?srTezN8xQMi5PoFVYuxcX2R9ziq9gXCZZvAyhP4DP3Wi6a8xGBdviloph3+t?=
 =?us-ascii?Q?VGADSdJrWSrFoaeXhtN2na1qnOipOZZNK1JyJyU+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 199eda8a-c28b-4960-dbbe-08dc480342cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 10:56:42.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0I89CnRtne+0duoTlng1YRWvWU+bHjpCTDZ1pDOF682t9ib5njurUtTFLVzwWFYT2lDIGN3C+kQRKYeXhlJy03Sk8h7eCy9fRTsFblPYaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: SeongJae Park <sj@kernel.org>
> Sent: Tuesday, March 19, 2024 10:51 AM
> To: Prasad, Aravinda <aravinda.prasad@intel.com>
> Cc: damon@lists.linux.dev; linux-mm@kvack.org; sj@kernel.org; linux-
> kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar, Sandeep4
> <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>;
> Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Subramoney, Sreenivas
> <sreenivas.subramoney@intel.com>; Kervinen, Antti
> <antti.kervinen@intel.com>; Kanevskiy, Alexander
> <alexander.kanevskiy@intel.com>
> Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
>=20
> Hi Aravinda,
>=20
>=20
> Thank you for posting this new revision!
>=20
> I remember I told you that I don't see a high level significant problems =
on on
> the reply to the previous revision of this patch[1], but I show a concern=
 now.
> Sorry for not raising this earlier, but let me explain my humble concerns=
 before
> being even more late.

Sure, no problem. We can discuss. I will get back to you with a detailed no=
te.

Regards,
Aravinda

>=20
> On Mon, 18 Mar 2024 18:58:45 +0530 Aravinda Prasad
> <aravinda.prasad@intel.com> wrote:
>=20
> > DAMON randomly samples one or more pages in every region and tracks
> > accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> > When the region size is large (e.g., several GBs), which is common for
> > large footprint applications, detecting whether the region is accessed
> > or not completely depends on whether the pages that are actively
> > accessed in the region are picked during random sampling.
> > If such pages are not picked for sampling, DAMON fails to identify the
> > region as accessed. However, increasing the sampling rate or
> > increasing the number of regions increases CPU overheads of kdamond.
>=20
> DAMON uses sampling because it considers a region as accessed if a portio=
n of
> the region that big enough to be detected via sampling is all accessed.  =
If a
> region is having some pages that really accessed but the proportion is to=
o
> small to be found via sampling, I think DAMON could say the overall acces=
s to
> the region is only modest and could even be ignored.  In my humble opinio=
n,
> this fits with the definition of DAMON region: A memory address range tha=
t
> constructed with pages having similar access frequency.


>=20
> >
> > This patch proposes profiling different levels of the
> > application\u2019s page table tree to detect whether a region is
> > accessed or not. This patch set is based on the observation that, when
> > the accessed bit for a page is set, the accessed bits at the higher
> > levels of the page table tree (PMD/PUD/PGD) corresponding to the path
> > of the page table walk are also set. Hence, it is efficient to check
> > the accessed bits at the higher levels of the page table tree to
> > detect whether a region is accessed or not. For example, if the access
> > bit for a PUD entry is set, then one or more pages in the 1GB PUD
> > subtree is accessed as each PUD entry covers 1GB mapping. Hence,
> > instead of sampling thousands of 4K/2M pages to detect accesses in a
> > large region, sampling at the higher level of page table tree is faster=
 and
> efficient.
>=20
> Due to the above reason, I concern this could result in making DAMON
> monitoring results be inaccurately biased to report more than real access=
es.
>=20
> >
> > This patch set is based on 6.8-rc5 kernel (commit: f48159f8,
> > mm-unstable
> > tree)
> >
> > Changes since v1 [1]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  - Added support for 5-level page table tree
> >  - Split the patch to mm infrastructure changes and DAMON enhancements
> >  - Code changes as per comments on v1
> >  - Added kerneldoc comments
> >
> > [1] https://lkml.org/lkml/2023/12/15/272
> >
> > Evaluation:
> >
> > - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
> >   and 5TB with 10GB hot data.
> > - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
> >   parameters set to default value.
> > - DAMON+PTP: Page table profiling applied to DAMON with the above
> >   parameters.
> >
> > Profiling efficiency in detecting hot data:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		>90%	<50%	 ~0%	  0%
> > DAMON+PTP	>90%	>90%	>90%	>90%
>=20
> Sampling interval is the time interval that assumed to be large enough fo=
r the
> workload to make meaningful amount of accesses within the interval.  Henc=
e,
> meaningful amount of sampling interval depends on the workload's
> characteristic and system's memory bandwidth.
>=20
> Here, the size of the hot memory region is about 100MB, 1GB, 10GB, and
> 10GB for the four cases, respectively.  And you set the sampling interval=
 as
> 5ms.  Let's assume the system can access, say, 50 GB per second, and henc=
e it
> could be able to access only up to 250 MB per 5ms.  So, in case of 1GB an=
d
> footprint, all hot memory region would be accessed while DAMON is waiting
> for next sampling interval.  Hence, DAMON would be able to see most
> accesses via sampling.  But for 100GB footprint case, only 250MB / 10GB =
=3D
> about 2.5% of the hot memory region would be accessed between the
> sampling interval.  DAMON cannot see whole accesses, and hence the
> precision could be low.
>=20
> I don't know exact memory bandwith of the system, but to detect the 10 GB
> hot region with 5ms sampling interval, the system should be able to acces=
s
> 2GB memory per millisecond, or about 2TB memory per second.  I think
> systems of such memory bandwidth is not that common.
>=20
> I show you also explored a configuration setting the aggregation interval
> higher.  But because each sampling checks only access between the samplin=
g
> interval, that might not help in this setup.  I'm wondering if you also e=
xplored
> increasing sampling interval.
>=20
> Sorry again for finding this concern not early enough.  But I think we ma=
y need
> to discuss about this first.
>=20
> [1] https://lkml.kernel.org/r/20231215201159.73845-1-sj@kernel.org
>=20
>=20
> Thanks,
> SJ
>=20
>=20
> >
> > CPU overheads (in billion cycles) for kdamond:
> >
> > Footprint	1GB	10GB	100GB	5TB
> > ---------------------------------------------
> > DAMON		1.15	19.53	3.52	9.55
> > DAMON+PTP	0.83	 3.20	1.27	2.55
> >
> > A detailed explanation and evaluation can be found in the arXiv paper:
> > https://arxiv.org/pdf/2311.10275.pdf
> >
> >
> > Aravinda Prasad (3):
> >   mm/damon: mm infrastructure support
> >   mm/damon: profiling enhancement
> >   mm/damon: documentation updates
> >
> >  Documentation/mm/damon/design.rst |  42 ++++++
> >  arch/x86/include/asm/pgtable.h    |  20 +++
> >  arch/x86/mm/pgtable.c             |  28 +++-
> >  include/linux/mmu_notifier.h      |  36 +++++
> >  include/linux/pgtable.h           |  79 ++++++++++
> >  mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++++--
> >  6 files changed, 424 insertions(+), 14 deletions(-)
> >
> > --
> > 2.21.3

