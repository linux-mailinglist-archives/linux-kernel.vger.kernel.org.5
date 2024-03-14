Return-Path: <linux-kernel+bounces-103568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F0587C136
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC91C2232F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC17316C;
	Thu, 14 Mar 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udrge53t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1018E20;
	Thu, 14 Mar 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433567; cv=fail; b=QCHiG7k9rJ06xi+mDGewJch/YCr1bQN7UuafnnwPsfYkRQYsewpY1x7xSiq/zUfN1qkLHyOUb+ZNnBtgF3UfTF9pg0dLhQi06IA6xM8JbgtZuCvlLL3fK9uIHzKgoR9KFGGbD4Kqt19FM+KLuQ1P1tsRcz+Iqlxa9Pu/I5yaUDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433567; c=relaxed/simple;
	bh=geVs2TnFi9gMjAUmFJlcaam9DynpDb1BgHQxEhC+Xs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2Ngna67OqVP0x8tfisq3f9M9CxDJdC/UHOdG6C6cfEjfuXS+Sw41o1obO4rzI5TtW3+QVRuL+CpqADl7Gi5QnqHzNGaQ1hknPiCMP2zRwHIXoShiZa0QS2QYtjwWI7pXJ+UXpLe0J77vh0U8rCpwrSXUJ5nOIwAciM2k1D53rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udrge53t; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710433563; x=1741969563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=geVs2TnFi9gMjAUmFJlcaam9DynpDb1BgHQxEhC+Xs8=;
  b=Udrge53t6ePRFpTRjfAyRG6tsQGG+tPNjTHDXI++XtP7C/0Yu8NG1m5Y
   7Y8RSqZ0p6N6e2VY6+o7wXk+q6ECdvFyEDVTKO3USFrnC8SlwPOKtbQUN
   pUvKsSQM2JDPk3Gg+0KhGxcspPy3ZY2CEX0ZcUON2VtVfZlduh6Px1ZtG
   uETtyAgh39pd+4FzYG4jGubAidaXO33zSdZbylLotVotDjU5Xx8TQxYPm
   9IuSB4GZMPDCC5b9GQ2wYzI2m32dUehrjKpdibqteSzbCeU1yXPJZJP41
   Vaxz3wlherGmNGctEBNkLwI8lFHeSahlDb2aVvQuJyY5CSwVMu9GWVgD9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5124121"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5124121"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12364055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 09:25:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 09:25:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 09:25:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 09:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO+wbXnuAR8eNvjiTyRgkkEYKKv+820DVudqhoBvbeyVsVsoaT6AjvWKH6oRIBDtVbuwkCqMFc6DLmXElJtkO9Zy3K+qcX+H3KEqPT4XuVYcCM6QWPQibzOPVhmfgPsuwLBGCbZskXznSb5j3D6+Swjz4qOrS58V7DY9MpuIljQ1WKPt70jJ4JRm4BE8JP6cHyJn5FxciTUyfXFKbAE3dXMqDVtrhaioEPmXxWAGbyIV7Bi458Fd2rOwhon9IsytHieXNW86ApaFQ59A2ro1IZsvzzWKz3c2vK+n3JKr+NzIPwrnGUVZjxZmkTGsJNfivJt1XMrE1tWcYGet9kYcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSROSoGNSedlXSQV7CzYdlhLHOlrFPsdyWbDJMdvm74=;
 b=XRg2UYYRXPx1j92caThoNTlrloUB2437+8cWP6qouJdGsmbKpPmwuMJlXx5CIGFiVRAAs54A+1EhzyLRT6bD/nq8hU0dsfCH6qpjIbwcc9vaqbx0sgp3gre+ImNIcNvNQuAbZSUGZLHByRvxYTAnLyM08Lu7VQcHdX9yxd4I5Qpyn6kVX8phhAWr1uvFdRqgn6L/DlOzwuSEXk24BKvR4NZNMTNZN+HqX8xjBcyGeErk/DRdRI9Vy+gvF5X/W/Ua3G9gryzYJ7ogLicrUrD/V4lW67Pt0DKaJwDEz4El67sprOdwkYfrElv0xZRj1KQLMGeaGIVdyfxeRDx3w+VDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Thu, 14 Mar
 2024 16:25:45 +0000
Received: from MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::39be:a2b8:752e:a089]) by MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::39be:a2b8:752e:a089%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 16:25:44 +0000
From: "Willgerodt, Felix" <felix.willgerodt@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-toolchains@vger.kernel.org"
	<linux-toolchains@vger.kernel.org>
CC: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpetkov@amd.com" <bpetkov@amd.com>, "jinisusan.george@amd.com"
	<jinisusan.george@amd.com>, "matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>, "jhb@FreeBSD.org"
	<jhb@FreeBSD.org>
Subject: RE: [PATCH 0/1] Add XSAVE layout description to Core files for
 debuggers to support varying XSAVE layouts
Thread-Topic: [PATCH 0/1] Add XSAVE layout description to Core files for
 debuggers to support varying XSAVE layouts
Thread-Index: AQHadgIwSxIkfuYuPE6B9BKDFgzWiLE3GuDg
Date: Thu, 14 Mar 2024 16:25:44 +0000
Message-ID: <MN2PR11MB4566BF54DEFF9B7627B096B78E292@MN2PR11MB4566.namprd11.prod.outlook.com>
References: <20240314112359.50713-1-vigbalas@amd.com>
In-Reply-To: <20240314112359.50713-1-vigbalas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4566:EE_|IA1PR11MB7871:EE_
x-ms-office365-filtering-correlation-id: 9cd5f5de-2a84-460d-db7e-08dc44436643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8kAbsZ34uVX2C/sxdR5dtQNAnweLYZYTSrTnl7QNXq0mmn+5SFp0/G7tA85y/1qiE4myxBH+F2wHgrcRhbxZakyfXFUpgLK5panJ1fQ1JUYhvU3g4if3CCxncCDWvDCoEahccKSTw84tsGLOAm5yNhMQJmx/ZcboIjxdhFFoFnySSx/TRcxAgHC21ZvUgiSrkkF8avPIZUpamODPee4IKI5RNcVqGatz/RIG8MTWw+BY6EhM3wNQgASvf/5cHnoqqaHG+NyEbOIqAd4iC9W/4u01QTr33KDC07n9EPrN8/MMEgDpzYV4ScnvASbILspDm8e+8VVgDh/OsRRfwwYtO1fsCV7E0FWRifdKuXurh+rxIFXUJrdkAuouaJw2yhgecQ968VJtDah8EfWTaQL4kKeErcKXgXhBQjfLJzZC9W7lum9F5rC/WnRJCjVlE549qNVNe4Izr1Ix+zNrKQS0RgU+3FPsunELbB3kjbAeXWgHCb/PrZkuAY9BDTbQYYoOr+tSKGeKS8zhHfLAdhX4mXktNtUIMCRoHne3UY9gXqdTizIIKZsOgqTiLafkAv1IgQbSSjHctOedl0ouC2d7OJa5P/MPsB7kMQF++du3jWAa4VAFiyUDMYK0s/SjTAhVi+OQCxSP+zVJJymaO2e6sVkfK9q+3eI3/u+X0+/PrXDzkazqNh2yIIf3JdxIp+hDXP9hi3enCYb9O1Zr8bZhQhiioFOjz/KwUEDLElksr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFVUQWtwOGtuTlE1TXJQa3dDUEl4RlZpV2ZDUzB2ZVJTVzVqdjBIYWZqQmMy?=
 =?utf-8?B?cldjeVVaRWEzRTZ4MDFyQVVRYVRmVWJKdURHNjF0WXcxR0d1ZTd4bE9ac095?=
 =?utf-8?B?UXhxQm5CWHJHMkRIOENRdmI5L1lGTGZzR0pPcmpVNzBUYWZWaHVjS21iUjE4?=
 =?utf-8?B?anV0UHEvcm04MWlycUxnOVdVOElXdW0rMUo4bkhvZmh6MzF4Q0pNelQxNy9n?=
 =?utf-8?B?ZVVYb1U2a2tvOHNqNFhnOWlxL3BzVzhMNVlUVnRTZDFzcnludUFhTyt4b1lS?=
 =?utf-8?B?aURRcmk3M2ZhYTd1c2tUSThTcWpRVlczMXcrS1lOdlM0QkQwUGUvcjZTM3BR?=
 =?utf-8?B?aXZXNTczc0NqYmVUNWZieSt3SSt4YUo4WktKMGpuRVBPenF6dERpMnZLTXFy?=
 =?utf-8?B?K2dxK2dGMlRMTHJVRnRHbkZVUll1aVFSQ1doWnB1dlYxYllUaXVaR09OK24x?=
 =?utf-8?B?L25FRkxheERpNWk4bHdLdkxuTStSdjNUeENLa1hRc1lYVVRJcmhpQ0NrSnpS?=
 =?utf-8?B?cWxxT3JqOEVXWTRLbElGSnJDUXRJT0dwL3ZQYmJCWkk2bUJ1ckk1bUE1TWor?=
 =?utf-8?B?ZnlBbnNHOUNpS2JWYkJTN1BEVDlQb1FPYnl1VnYrRXJYa0JhMzYrUXJjRE1B?=
 =?utf-8?B?MnZaWlFpUmN1QWpGMW43N25jdlRKY0RGaWN2YWIrRVdocmFndTAxc1g1SE5o?=
 =?utf-8?B?eS9TTnZROTk3TG1ETHU1RzZJUS9rWDMrSVJXc3J5TzhUS1pTUEx5TTNTRE16?=
 =?utf-8?B?WG82RVBYVlpxaDRJd0RvUlVOeC9RakRPMk8vYVNVTmlyQUxHU3U3WkpLdDAw?=
 =?utf-8?B?d1VacEM0ZkxHeFJuYjcyVCtBSEE1T0J6Tk80UVZXeGlNQkp0Z0xoQ2RjR1Vx?=
 =?utf-8?B?VnljOGY3RytKSjJtNjFDb2RxMllySlhOQlpYU3B6Uk1mbjRKcys1OERiZ3lR?=
 =?utf-8?B?RDJQVklaNVdVcHp0cjlsY3UzdHYvR3d3VEMxNXVIc0FwTTl3YkhYV3RPazFn?=
 =?utf-8?B?VUJvR2ZJeGttMUtSOVdLV3pIb1pzemJwN0ZvVkpBOXNCeVNRclQwSjBGNDRH?=
 =?utf-8?B?UXhUWHprbU5jU3dUVTM1eEM2SGRQbGFWQzA4WWpmbEFnN0F5OWcvc2o2U0Vv?=
 =?utf-8?B?ZFdYMVJjRGNYeHpTSXArbjc3WndOQWxBWkVIZWZBS2IvOUlNZ3dPbDNGUWRw?=
 =?utf-8?B?d0NkUWNrQ3VvUWd5Y2VUaDdQempiUEhwYmd4M0Q4SjRIY2E5RE5uZGdBVTd4?=
 =?utf-8?B?YlVCZWxoaWV0T2JoY1NZcFVZNU9OQjBRYTdGRWduLzM0R3BKRDhSUWZEQjVM?=
 =?utf-8?B?YitYLytXczFCaVpIQzdkRHZNOXVrU1dYemlGTTZ6TnQvOWJCRmp3YWNSdnRC?=
 =?utf-8?B?OTh5MnA4YzY3ZlJyMmtoWmVrbWFRQXRUTjE3Z0VRQUNUUkxQN0tzQWthL3da?=
 =?utf-8?B?VkNZK0VOcU5hdDlzdU0xNjRrZjRKZE5zVVFyTEJPck5PaGM1SzJLN2FWUisz?=
 =?utf-8?B?SVE0Z0x3MFZTMm1DN2Vzd0E4STFRanorUmIwMXNTOXp0OGhJMmZVYis2d3B0?=
 =?utf-8?B?VnJodzdiUWFCWFN5VGEvNDNJVTBXMGdpSW81VDVqWk9aR2ozclpBcy93VE9w?=
 =?utf-8?B?aUNvbGpHYjY0S28vVDVNSExmK3FlRjgzNXJXTmtxc3lsemEvK2E5ZlF0djkv?=
 =?utf-8?B?Z2YxR1pUcmpTM3JTTHAvTW9tKzVyVmJ2THVaQ1RJMkRrU1p5bnNGZFlDeXNT?=
 =?utf-8?B?U0ZRNVkxU09yM1RMUVhwMFpTZXRIOVBxTGViNUduQjZwMVVSUE8xd0ZyS0RV?=
 =?utf-8?B?Szl5Q1ozMmJmR2x1OENRU1lwTWxpb05mVWFNOEd5WEx6WUNiSVdIUEQyMkly?=
 =?utf-8?B?MFNrZ1VNZ3V5d0owUXg1anU5VmNadDArNnJ4TUxxN2o3eEthL2hvWkJZZ2Qv?=
 =?utf-8?B?bnJmSGxmVkt5VWFDU29DQzA1RCtkTERrME5sRTdyY3JIeVpzc3Rlb1BpdGE1?=
 =?utf-8?B?K0dtV0M4Q3lNdXFJL250cVNiaE9YMEw0OVhsTHdkMCt3YWx4QzJTRk1CKzU2?=
 =?utf-8?B?ZkpuM2I0SnlRMjFyaVVmRHZ3OWFkdmhONUZFeHF2Q3JRY3ZJMjVzYWdFdG5l?=
 =?utf-8?B?bzFJeDJVaUh0cTBwWWptNnRXcDB1UHlURGNJejhMU1orRDR5OTZXSUVsYlVX?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd5f5de-2a84-460d-db7e-08dc44436643
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 16:25:44.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MozsTL0QBQscykHVdJUAtxiLkFD88HK0Yh7x+kJkoAeIy1mLEezF6rutweFJvuf4KFGmtcHpkur6CnZFtc/B2qs8kDxOXL0SullPD4EQEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWduZXNoIEJhbGFzdWJyYW1h
bmlhbiA8dmlnYmFsYXNAYW1kLmNvbT4NCj4gU2VudDogRG9ubmVyc3RhZywgMTQuIE3DpHJ6IDIw
MjQgMTI6MjMNCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRvb2xj
aGFpbnNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtcGVAZWxsZXJtYW4uaWQuYXU7IG5waWdnaW5A
Z21haWwuY29tOyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7DQo+IGFuZWVzaC5rdW1hckBr
ZXJuZWwub3JnOyBuYXZlZW4ubi5yYW9AbGludXguaWJtLmNvbTsNCj4gZWJpZWRlcm1AeG1pc3Np
b24uY29tOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eHBwYy0N
Cj4gZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgYnBldGtvdkBhbWQu
Y29tOw0KPiBqaW5pc3VzYW4uZ2VvcmdlQGFtZC5jb207IG1hdHpAc3VzZS5kZTsgYmludXRpbHNA
c291cmNld2FyZS5vcmc7DQo+IGpoYkBGcmVlQlNELm9yZzsgV2lsbGdlcm9kdCwgRmVsaXggPGZl
bGl4LndpbGxnZXJvZHRAaW50ZWwuY29tPjsgVmlnbmVzaA0KPiBCYWxhc3VicmFtYW5pYW4gPHZp
Z2JhbGFzQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzFdIEFkZCBYU0FWRSBsYXlvdXQg
ZGVzY3JpcHRpb24gdG8gQ29yZSBmaWxlcyBmb3IgZGVidWdnZXJzIHRvDQo+IHN1cHBvcnQgdmFy
eWluZyBYU0FWRSBsYXlvdXRzDQo+IA0KPiBUaGlzIHBhdGNoIHByb3Bvc2VzIHRvIGFkZCBhbiBl
eHRyYSAubm90ZSBzZWN0aW9uIGluIHRoZSBjb3JlZmlsZSB0byBkdW1wIHRoZQ0KPiBDUFVJRCBp
bmZvcm1hdGlvbiBvZiBhIG1hY2hpbmUuIFRoaXMgaXMgYmVpbmcgZG9uZSB0byBzb2x2ZSB0aGUg
aXNzdWUgb2YgdG9vbHMgbGlrZQ0KPiB0aGUgZGVidWdnZXJzIGhhdmluZyB0byBkZWFsIHdpdGgg
Y29yZWR1bXBzIGZyb20gbWFjaGluZXMgd2l0aCB2YXJ5aW5nIFhTQVZFDQo+IGxheW91dHMgaW4g
c3BpdGUgb2YgaGF2aW5nIHRoZSBzYW1lIFhDUjAgYml0cy4gVGhlIG5ldyBwcm9wb3NlZCAubm90
ZSBzZWN0aW9uLCBhdA0KPiB0aGlzIHBvaW50LCBjb25zaXN0cyBvZiBhbiBhcnJheSBvZiByZWNv
cmRzIGNvbnRhaW5pbmcgdGhlIGluZm9ybWF0aW9uIG9mIGVhY2gNCj4gZXh0ZW5kZWQgZmVhdHVy
ZSB0aGF0IGlzIHByZXNlbnQuIFRoaXMgcHJvdmlkZXMgZGV0YWlscyBhYm91dCB0aGUgb2Zmc2V0
cyBhbmQgdGhlDQo+IHNpemVzIG9mIHRoZSB2YXJpb3VzIGV4dGVuZGVkIHNhdmUgc3RhdGUgY29t
cG9uZW50cyBvZiB0aGUgbWFjaGluZSB3aGVyZSB0aGUNCj4gYXBwbGljYXRpb24gY3Jhc2ggb2Nj
dXJyZWQuIFJlcXVlc3RpbmcgYSByZXZpZXcgZm9yIHRoaXMgcGF0Y2guDQo+IA0KPiBTb21lIGJh
Y2tncm91bmQ6DQo+IA0KPiBUaGUgWFNBVkUgbGF5b3V0cyBvZiBtb2Rlcm4gQU1EIGFuZCBJbnRl
bCBDUFVzIGRpZmZlciwgZXNwZWNpYWxseSBzaW5jZSBNZW1vcnkNCj4gUHJvdGVjdGlvbiBLZXlz
IGFuZCB0aGUgQVZYLTUxMiBmZWF0dXJlcyBoYXZlIGJlZW4gaW5jdWxjYXRlZCBpbnRvIHRoZSBB
TUQNCj4gQ1BVcy4gVGhpcyBpcyBzaW5jZSBBTUQgbmV2ZXIgYWRvcHRlZCAoYW5kIGhlbmNlIG5l
dmVyIGxlZnQgcm9vbSBpbiB0aGUgWFNBVkUNCj4gbGF5b3V0IGZvcikgdGhlIEludGVsIE1QWCBm
ZWF0dXJlLiBUb29scyBsaWtlIEdEQiBoYWQgYXNzdW1lZCBhIGZpeGVkIFhTQVZFDQo+IGxheW91
dCBtYXRjaGluZyB0aGF0IG9mIEludGVsIChiYXNlZCBvbiB0aGUgWENSMCBtYXNrKS4gDQoNCkhp
LA0KDQpJIGFtIGEgR0RCIGRldmVsb3BlciBhbmQgdmVyeSBtdWNoIGluIGZhdm91ciBvZiBnZXR0
aW5nIHJpZCBvZiB0aGUgDQppbnRlcmltIHNvbHV0aW9uIGFkZGVkIHRvIEdEQi4gSXQgZG9lc24n
dCBzY2FsZSB3ZWxsLCBhcyBzb29uIGFzIHdlIGFkZCBuZXcgc3RhdGUNCnRoYXQgaGFzIHRoZSBz
YW1lIHNpemUgYXMgc29tZSBleGlzdGluZyBzdGF0ZS4NCg0KSSBhbSB3b25kZXJpbmcgaWYgaXQg
d291bGRuJ3QgYmUgZWFzaWVyIGZvciBldmVyeW9uZSBpZiBjb3JlZmlsZXMgd291bGQganVzdA0K
Y29udGFpbiBzcGFjZSBmb3IgYWxsIHBvc3NpYmxlIFhTQVZFIGNvbXBvbmVudHM/IFJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGUgQ1BVDQpzdXBwb3J0cyBpdCBvciB3aGV0aGVyIG9yIG5vdCBBTUQg
b3IgSW50ZWwgZXZlciBzdXBwb3J0ZWQgdGhlIGZlYXR1cmUuDQpPciBpZiB3ZSB3b3VsZCBhdCBs
ZWFzdCBub3QgZHJvcCBzb21lIHN0YXRlIGZyb20gdGhlIG1pZGRsZSwgbGlrZSBpbiB0aGlzIGNh
c2UuDQoNClJlZ2FyZHMsDQpGZWxpeA0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApSZWdpc3RlcmVk
IEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQpUZWw6ICs0
OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5kZT4KTWFuYWdp
bmcgRGlyZWN0b3JzOiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ssIFRpZmZhbnkg
RG9vbiBTaWx2YSAgCkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xl
IExhdQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNn
ZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


