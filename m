Return-Path: <linux-kernel+bounces-127157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F49894789
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006501C21F00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856A56B70;
	Mon,  1 Apr 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUK/ZHbN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D356754;
	Mon,  1 Apr 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012644; cv=fail; b=I0jGFqtgMlnUpNpI69jZHt5qGNnx+RS5UzrQ/6T82SCMs+HndcP/xsbFTexDZeaTs+6X4BMGqvmR3ngrURCrrP6w/QguSSOvIkxt8MjWNymQqT9k5WcOSK/sGhvMNbyrhuFi8KMq9o83RnmXbLYvzMR5UJQlWjvz/xQnHauqJsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012644; c=relaxed/simple;
	bh=XKqTfWqyOx5usUR0g6xq1vYApV2dVFCr59UqKOLJhos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVkRVVa1BlVUjtW1aFYcQJFSwcR/JDeBeyNS1o0mhJZ/viXbf8DVnTJzxY33TdirXOnvu5RjgyUT7DpTPx228qy0XuqvPZLkwVee3c4hebW5cDyUai02t8booukoqkMxpo5HofVjv9WBwseDFGZtpFfZff4qYM0J191d1vHybFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUK/ZHbN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712012642; x=1743548642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XKqTfWqyOx5usUR0g6xq1vYApV2dVFCr59UqKOLJhos=;
  b=bUK/ZHbNHXUufGK4MdygzqA0MtT76xikr9tlKLpmQpPZQAsfOSJzpYIC
   m2yAGxFmFwjFkG97yWknCfp9WReoKdNqFQd7X7e5BbFdVivUD+7+vbkgq
   vTZgb5/UvTHhXCcLGyjwd9V19z1FVJEA/+/JqWJKDv4YnT9bjwJVaTBEY
   +3QBSpNlaCLhOIKPgYs/KuisEzvd59I7F+Ic6VNzCkJAlSDWOuOON4wi/
   ZtUGZwtNOvnxyFHW9OaZMP11lE+hukpY53c+JfAXvjyEsOXB1Ga/DEfdK
   xtkVm+bJpI6N5bTMuB59p1H7kSDwwKGbPXr+qRrLt1rlOLpMyrmmwIpmO
   Q==;
X-CSE-ConnectionGUID: HRM9pKuJTlmcM2NuzpC+Xw==
X-CSE-MsgGUID: mm9gGOoiSF2sCsM4UpUOWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18607424"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18607424"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 16:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22549187"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 16:03:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 16:03:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 16:03:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 16:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgeOLmPcRuzm+j9WARkbUeC/uT58/8q66TxKHa6z5WvxIo/1ScBgGmShn1xKRu05zVtaQfDcPy+qoYCHUEDzL3dgp6VVwsXr5ZXfVIQXiRxnttvQLrdnxzFaUu005aQPSo6ktl4mKW4LzEnWm8ZjyI9hvmTmy4RhJCb/JTnyDmJU1ntVyqehkmtlxuLPalJreWPUweeu3KYROESlY7PxFLFhykGf8Bxhl7EAPQ/DnWukaf5HXYH+gJKqOniIoaNP8ZtaBkmJKu5vXGoOZnRXz+uyFPXJZLO2ZiWxDYx2jfASvwaJtkhxhPArikvrc0tMKGRXzS5BMbK/WV7ihnfktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKqTfWqyOx5usUR0g6xq1vYApV2dVFCr59UqKOLJhos=;
 b=NLavKpl7YO+2Z1eZDK/ZedSDALUHqfwfbz92U4f6GYAGnky1JdxspatCD9suuSkWz9/R7c38qbfmYLCbx0tbTgKWnNIFkeoSrik2i2Xc2BzIvnbZUI6s0wJFmXFin/43ulNBCPcYQEpJGHqrBtFxyc1KgFUnSncvvfAKWPjeIFvb5E9pbTMLWZN/JHuxMCilZie2O0U+ixwi51ayHx7fzouLgT2vfGBOepuwM+u2NVBWTCCrSZHRiJfPvpzBJeMF1WDmj6NHJB+ffD36BqKhCyg7caVkDiQ/yKWl93TWboJ9AP/v4wFt4R7HHrEs6/6KwvJLa0MuaXcaNJLgB5H2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Mon, 1 Apr
 2024 23:03:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 23:03:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, James Morse
	<james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, Drew Fustini
	<dfustini@baylibre.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
Thread-Topic: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
Thread-Index: AQHafIWhuTqTZC6FVEyiTcWcX6VsHLFN8DyAgAEFcK6ABR15gIAAAr0A
Date: Mon, 1 Apr 2024 23:03:50 +0000
Message-ID: <SJ1PR11MB6083D3C5616E60D3D03CCEB5FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
 <Zgbe2FFwyHMmmsyM@agluck-desk3>
 <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
 <d6a649fd-0bd3-4777-acb3-2b9362131796@intel.com>
In-Reply-To: <d6a649fd-0bd3-4777-acb3-2b9362131796@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJq5T2Xs8jqOOowIWbejiTPx1vvA44+DmMEl0ZxIzr4Xv/UwXNSwv0L+P+uxXN/tsg5NClqbZEtdQITtnGxqKURq6iulNegpF7nk5mxd+wE4ZL363oGqivJye6Lst7xjmuFPtRNtEO7zdH+rqLoCbMLNqkhLiL5yi4OLmCGN8G72MsvTFzZzOn9FO6WWr3Y5ohYRzkZheS4fuCkNpK8mdgzW6Yy/naxy06RqxgqwoPbhkLe2Tr7Dk6UHoz19Z7K/G8ak6AFrVhzkyvsVvcfh/loeG2XIOnF3GXxjafLMp2zOp/MCv/uzeTgf8QL5ega45ODiDHwqTWh9JEaFEmUyj1MJE8cyHupkH86wk+yogyh9rcccYiVFxEgpGKQd4tDUBz49vcTdS7xPOvP5EyK0dDA+lBTykw27pUN00qUVvHY0dwXYnwfIVveTICn9W/3rM1UjO76PRfL53HW0FSToezEZkr97OIumqQtqr/ZstQ/DebzzvmQu9p30ZfBXyJ+IzVBvkkOEFJcR7iVe8ANT9hBYrVi6t7Q7ElUVpPPfTvnpgpitDhhtidjZqfYdbhX4D4zheSTTJTosMjEG8l2EinNq8ZRzqzPb5G5/SnTwnbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2c1OWpRMXV0eXUyY1A1czdHSDBJRVVpSGVlV1k1b1lmUU5uTmx6M0V4Mllj?=
 =?utf-8?B?dHo5VXZ6MnhYdmMvaHc1TXB1Um5EMTdNNVRNNEpMSEFwdUszUEJZVjg0VU5B?=
 =?utf-8?B?K052c1ZTbGptNThBamcvaGRjSWpicWp2SzBrK1g4ZE1OcW1GaExGSXJFTnJX?=
 =?utf-8?B?WmZHOFp6KzgxZ2lzbi8wK2xUK1VFbjJzYWFuSXE3TUdRY2N0dUk3d0plWXA4?=
 =?utf-8?B?aTNKblVDMXBtck5RTUZ5N1Y2aHQ5SE5Yanp6ZUhURVorckJwL2dubTRQditz?=
 =?utf-8?B?VG9JNEhuZS9hblQxREZhU3o1R214UEc1OEVzVDhrK2lzdzJkZFdIaWcwMHRL?=
 =?utf-8?B?SGpHRmJOZEQ0clE5UHdIN1p2dXVmdDhkTmthZWJPWUIwdWRNOC91QWx3eTEw?=
 =?utf-8?B?OGhFNlVsYlRpN2Jwa2YzaVhvbWM0Z2hqemtUdHNKM3gvWjFTVUxQWjMyZkdG?=
 =?utf-8?B?Vnk2dks5TC9BY1V1dWVVMWRsM2s1ZjhxQTlhazdjRU9DSkczZ1ZCdXRRYWlM?=
 =?utf-8?B?VndZY3lmdWpvR1UwL3RpaFQ2ay9HY0l0a2kyS0lCbXFXUmY3Q0NKN2VEbEwr?=
 =?utf-8?B?ajd5NE1HczRFdmJDa2dMalRvZGNYbGN0ejNFUXpjeEQyMWh5bVNFb3ZUcElU?=
 =?utf-8?B?bTduN0xZWTYrY0djcGVXekNMc3dldzRmTnkvNGNQbHE1dENlVENPZXRlRU9S?=
 =?utf-8?B?NEhSbGVURlBWb2RlNDRWNmwvNk52dFFhelI5OUhlSlY5eENNNklubWYrVHA1?=
 =?utf-8?B?eHdKMk8zNWZXVzJFSWhiVXZnSXE3b1h5d2VORkN2THdMYnVLL1VGT2gvODlj?=
 =?utf-8?B?MUh3YmU1RElIdVJ0NHZIbnFObXdLTXVjeWlEdU1RRHIvV0NzbWxrRmVMTGZz?=
 =?utf-8?B?aFNJL3ZoRlQ2a1ltTzZoMStUS0tYSzVuRnRHb3ZQenExcmJiMVpZL1J0dHVP?=
 =?utf-8?B?eXRwRkpkZEc5QUg3eTEwcTBEemFjZEN5TGNobnoyZDdGZGlDMXpkNitoVTla?=
 =?utf-8?B?WDFWWjFlMTB0L0R4eG5Jc0dkalJRRDVHM0wzSzdxZ0FEWWYvZ3lQYnpOSCtU?=
 =?utf-8?B?NWZsazNaZHQwbUo3U1ZUdENNQ3VOWVVyVTBlbG8wS0dPK1BKVCs0SzlYM2g2?=
 =?utf-8?B?bzVJN2Z4WEczSzVYV3Nweno3bVZwK29QZkNGeWRNdWNPMmt4Y3dDMEUrUitH?=
 =?utf-8?B?UXhOejFuYi8xbDlzTXpYVjRDWDNVVm9FRFFTMzJUemZ1eTBuclhuN0VDd3ZY?=
 =?utf-8?B?OWR4UTh0QW1BSXhISkkvZDd5Q1lIMHowQ3k5Slk1eStWZEVKbWFqUGZ4em5u?=
 =?utf-8?B?alh3UlNKSHlVNUcydmh1Y0V6T0hJM1B0MGZRRTZXWUtFdUpRMVFBRDJPdmk0?=
 =?utf-8?B?dk9rUlF0WmNkQ2F0d0Y4Vm9vWHdGbmNHemtJYXQrdU0wdHI5TjFSOGVlV0d6?=
 =?utf-8?B?NzJDYW8xcUlPdE9vcEhpZlVKYkN2OXFkdkVtTGhoei91cmpMamJ5YmtEUnR2?=
 =?utf-8?B?M0I1TUZ1Y0VHTnJ5WXcwWXp3QytiUTdsMW1FWjE3a1lYNU42ZnZCSTYxR29o?=
 =?utf-8?B?VUIyN1FqR2VCS2FvNWxFL0xWY3JYL3MyRnJnRjczWXVEZERYKzd2TGI1Ykgv?=
 =?utf-8?B?ZTRuQUZWSVg0djh5TWZ4K0JsU2I0RnE3STRQS0VtMlExQ0F4NCtBWHFFTG1r?=
 =?utf-8?B?LzRLQ3FSQ3N6OXF5eCtxQTRUZEN0RWhCQzhacUN0d2pyblhQT0FBY1hESnhQ?=
 =?utf-8?B?dzhERWl1WFZBSlJlZW5ZSitWMk9GNFhzbStVSmlhTlI0NjI4VWxETGlZY2FL?=
 =?utf-8?B?Ymd2cDQwWGpGZVd1MFhQVU5xSHZMUVhDaVMyTCtnditLZ28wbnBvSDRIQTF0?=
 =?utf-8?B?c2YzM2xNK1Bjb3NQOUhPU1hRREsxU1N4ZFB0bzVoTVljT1BnLzd0bzg5aHQx?=
 =?utf-8?B?dVRCYnRFdU0zUFhjb0w0Vy9NUVlTZjlwVUszdEtmWGF0VlhTR2ZERGo0Sjdt?=
 =?utf-8?B?RVhNeUZwcWlTMGVOcEtBbTdKMVU1b2pmY3JCY2Q3KzBVcGo2SkFxTEU4cjBF?=
 =?utf-8?B?ZVJSOW9oL204cjNIWmhJL1JiSnk4Yi9kUi9WOUc5Ym1HdURCY0xaOE56VHZ3?=
 =?utf-8?Q?d/P7wFZic1McQLhp9YJNQhYyy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf747c8-cf0a-4167-7ffe-08dc529ffe68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 23:03:50.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmbCSh7BRnhJcJTYvPHn/zyU8colyKwchvH7R0tqa0znoZa45jlcP5m9aLTmBZKQeU863H4GsBsk0qqxl0AVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

PiBJdCBhcHBlYXJzIHRoYXQgdGhlcmUgaXMgbm8gY3VzdG9tIGhlcmUgYW5kIGl0IG1heSBqdXN0
IGJlIHNvbWVib2R5J3MgcHJlZmVyZW5jZT8NCg0KUmVpbmV0dGUsDQoNClRoYW5rcyBmb3IgZGln
Z2luZyBhcm91bmQuIEkgaGFkIHRob3VnaHQgdGhlcmUgd2FzIGdlbmVyYWwgY29uc2Vuc3VzIHRo
YXQNCm1lbW9yeSB3YXMgbWVhc3VyZWQgaW4gMl4yMCwgc3RvcmFnZSBpbiAxMF42IGFuZCBuZXR3
b3JraW5nIGluIGVpdGhlcg0KMTBeNiBvciAxMF45IChidXQgYml0cyByYXRoZXIgdGhhbiBieXRl
cy4NCg0KQnV0LCBhcyB5b3UndmUgZm91bmQsIHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSB0byBi
ZSBldmVuIHRoYXQgbXVjaCBvZg0KYSBjdXN0b20uDQoNCk1heWJlIGEgY2FzZSBmb3IgaHR0cHM6
Ly94a2NkLmNvbS85MjcvIChzaW5jZSBpdCBpcyBBcHJpbCAxc3QsIEkgcHJvcG9zZQ0KZXZlcnlv
bmUgc3RhbmRhcmRpemUgb24gVGVyYW5pYmJsZXMgcGVyIGZvcnRuaWdodFsxXSA6LSkgKQ0KDQpC
dXQgYmFjayB0byB0aGUgcGF0Y2guIEFzIHRoZXJlIGlzIG5vIHN0YW5kYXJkLCBjaGFuZ2luZyB0
aGUgZG9jdW1lbnRhdGlvbg0KdG8gYWNjdXJhdGVseSByZXByZXNlbnQgdGhlIGNvZGUgbG9va3Mg
bGlrZSBhIGdvb2Qgb3B0aW9uLg0KDQotVG9ueQ0KDQpbMV0gMSBNaUIvcyA9PSAyLjUzNjcgVG5p
YmJsZXMvZm9ydG5pZ2h0DQo=

