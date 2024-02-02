Return-Path: <linux-kernel+bounces-50681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0E847C82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFDC1F26A28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371B85958;
	Fri,  2 Feb 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu0RHcQ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05F3D3A7;
	Fri,  2 Feb 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913999; cv=fail; b=CoIh9zx5EMcHq9mCIYx7t6h3kyPYyq2TvstNjK3VXyvOF56V9hYgCyTr5al1tgpNGfMn7II0xgm0QqkoLGz1aUqn/3BXWyM+hUwdyRHafAAsel5u+8/jW3jgiu3LylqocYynZSSjq9MUWIunS7ODCa3AEOZjedhmZRNKtQdwnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913999; c=relaxed/simple;
	bh=v5HUEAubSUgzsCBQLuhmoCag8cFqiog+R6Vb+e/t1YA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQEVCpP63ECnv5tBJ4VzBQd8uxXm2IylBO/Z0luzXMFXovaC1VBipX32jv7HgVK/wU5MbWL2tNnpcInM7JUZU6Ox7xeEGzDuIH2YJvypQkZUkDfZJ6RMJR2TBOEUbago1RdnAlU7r8fITHVHewMn4kDNPDoaMTdyhKfFJ7vD0HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu0RHcQ1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706913997; x=1738449997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5HUEAubSUgzsCBQLuhmoCag8cFqiog+R6Vb+e/t1YA=;
  b=Fu0RHcQ1ggeEhDy7vHCe2ncSweb6GEpws8Zp7isoize788OaqGZSZZ7X
   kWa22Tc43o9b6D/GjkeYCLH5pDEj/jKc6QCGEPuJCE/eZpGYGerJvykUp
   cUPJ8lyTTG9lYBMgCbdBwp40edk6BeOyDkj3tuLk8ckKTTBM7a2O9Zya6
   ci+UCdQU2MBtrPoBgZyVPWDp32SYg56/zLWwJPGCj391LJOwplhtErmzw
   4so9vIvWkiixjBDPP2RK9xXsSCMVP0MjsFEtmUoiRsRwf3pTxOIUoO5uJ
   z5DOjI2Wp0OBO/yJEyDPc7J3fl/yQ0oQwE1ofGwgaKvianGuFaczWCFzb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="159332"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="159332"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 14:46:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="502012"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 14:46:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 14:46:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 14:46:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 14:46:34 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 14:46:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9X4LCC4pjm17wUUisOKzbYsKRdwurECNcPsfUMvpsxgEm/5fUpI86Ua/Bm3vqVDjiaAMb9sJe0OOXi9kwpOswn37to46J8kq3/ukiQU5/o3Qaw8Xg9b7Aq/kkl/D3QIadnzWWdpcX0J34a8a0cXUImcZUbSjiG6LkBx7nzPa10tRD0ot+ywzfMZPbV9f88mljQVFOi1yy4Gu2BILeoo4ntb9Kyh6/iLkqzMQQJe/vIZcALsq/K37OHE2L/64d7bVre/iUSJKQWidemtF5WpoiGQD7qA1MvBMhbQl5fXcgPSOU36fAeNjxOq6SouttR8VlzgVuih4ZGxalbqTQDbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5HUEAubSUgzsCBQLuhmoCag8cFqiog+R6Vb+e/t1YA=;
 b=G54GjG5AM+XVy5H7zlI1FVpOLR/qjuHAWAaAxDNgcZ2GteojFi72q2fkLL3+NaraIrQCB95QoIawM7uDUj5I3VGBCrFDhUC2Bb4hOOl/SqQTgqZT6FQ/Zm51Gzf5BSzldA3BFkmIhMth7ORN5+WsHi9zqCpmElDZnlnMvwvRdSi2af/VMhfj27FlN9y+qRt5nbIlY+EffNs4S5U5pKckSUPI4HyxnwDPu6iA3uXX2SmPJ2D0VzBkJ10l2tHuTJ0tkWuVPRP2FAI3PeTGj7DKUP1eOZiK/nPMfCO4obBN1MYjmxuRSlG7emYQbn8GJD9/ao0Ibw/ijTPd8T7iukDxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 22:46:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 22:46:32 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Tong Tiangen <tongtiangen@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
Subject: RE: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Thread-Topic: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Thread-Index: AQHaVBOfhwOTM8ynF0GL5a5xXZOLP7D1XeaAgAAtgACAASWhAIAAYTmAgABUMXCAABFygIAAGmrggAASHgCAAAXPQA==
Date: Fri, 2 Feb 2024 22:46:32 +0000
Message-ID: <SJ1PR11MB6083FDC9D4661A9D94E26ABDFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
 <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
In-Reply-To: <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB7181:EE_
x-ms-office365-filtering-correlation-id: a13f4367-17c0-4fb0-c705-08dc2440cd67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PCDAZvl4KF1C4KyIKyUtR2/q4/W9PRILOkSQWcCFoTas174AfbfpPvKJ26tPJC5IYOhSyQuq+24G6X8YW+ge6YQvyI1yxt4e5izP/diKstfdY7VfYjXwxhWfS0uFoRYxGTiqFB22UHVO9ZnzJpms2CxoCqBkf2PRfBAIe+QvBKgBUgBEV45S7Ghi+4VCDZMs8ow8UZy0sdODbeANU+t7AvrZBA6uz/9DNnUW6zEsp1dRaVU9s1LWBHH/URbQnwYeIjz8P6cv9LVfmg27rp+kxpjN8g4MLyti+RfgmP/+2cSICp6/WRQuqXv9xMBfaisXOFs/PHkEkqvPzvDhmutP34YFw8G0N+59tFXbiERd8NpR5d6/7i+vc+RrIE3+0PHK5fVKhkxO0bEJNgycgSvNzSxtWAsoodb9n3uWdWzNPwCYbePnytguVL47r3kAyCRhrEROKVIr4EXz/jhhqNPLweLUmcPYCaNL1vHEvyBKKwM/nWUslRdVX5zv6IMxLRs+vwdHIW0kINe4ty3H13ZGvGyV2RIJMR4KeItkcl59b80x3ohrDCgcHz90Ofs4EszwD/LJlVkZkVP+QXMKw7SrGKHAhoi+Apm17T2oqTvzF2gms7GOV80804veKUI9kp6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(41300700001)(55016003)(54906003)(316002)(38070700009)(6916009)(7696005)(83380400001)(9686003)(71200400001)(6506007)(82960400001)(38100700002)(122000001)(64756008)(478600001)(66446008)(66899024)(86362001)(5660300002)(7416002)(4744005)(66476007)(66556008)(2906002)(76116006)(33656002)(8676002)(8936002)(4326008)(66946007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2RYYUViaEtTM3loVmdTTXJkekpHWkJ2QUYrNFdGNi82bCtYbTBaOEI1LzBY?=
 =?utf-8?B?ZlU0cHJNUExEb1JERjBNeHlVbDZwQ0VOVGRBNzZuUmNXV1B6OXdBVTZVMGcr?=
 =?utf-8?B?Tmd5cGVCWkwzL3NzNVBhL3I3WHlaRzNSQmJtQitrU3M3N0hUWFpGT1J2bmlh?=
 =?utf-8?B?VHNLNFJrNXBGbytGZG5DazcxbGJITlNKNURuOWt5QnZxbUJBZlVmM0NIQm9K?=
 =?utf-8?B?VzJuY0NuVVJGaHFSNlVROEV1dVNCbFA4ZEJaRVVaWUZBMGR4YlV3bmZ5MVR5?=
 =?utf-8?B?RDliSFFEUlFHUlkwNmIweVVaRjlQSnJQUG1IbDJ2NUIvZ2VUYk1LTzBmSjY5?=
 =?utf-8?B?SXcvY2dYRGNYQmJ1cytsaE0zdVJ3aUZLQ010c0prTnVIc3N2dWs2QUhjZHV1?=
 =?utf-8?B?b3FTK1pya2wzOVlKSWd4NjZkcmQ5WEFWeW5BdEY0S1JBbkMxYnhYYTRnVDRj?=
 =?utf-8?B?MXRqSEFyTGMzR1RKdjZhWGJnQ1E2azM1NklxQmVDZXZibzU0dVJ5QmFtVDk1?=
 =?utf-8?B?YWV5K28rOTV3TjR2bmJOUVJDdlNnM1dDaUVlRkRCaklWSlBPY05keFg5TmRI?=
 =?utf-8?B?MFFZU0hZc2FTZXFiSjE4RHJTWHVienBUaTdGeUpjSEVqK004U2xFRlhOVVR0?=
 =?utf-8?B?K0RoeVptWktDVVJHNXYzaWwySCtuei9RbGo0SnRUazVMY2VNQkwyZklIY1ZB?=
 =?utf-8?B?cnU3VVl2aTd1US9SV0kyaWJWWW9WMm1XYmQvVG5iQ0p5bkc2NjUxRUNWQ1R6?=
 =?utf-8?B?SXA4dWZzazJCOFM3Q3RFeTRERXJZYXhPeUpaVitjRGZYLy9iVWFHMVQ1RzBS?=
 =?utf-8?B?UlNoWEIvSEpyZlVtRUM0RGV5bGZJZDhPOW5VZ0s4UDVlRjBDYktJL0NzZTl6?=
 =?utf-8?B?WjB6NVBGUWxaK1piRm1NOWNnQ1d2ZGpTTVpFbWJhRDJqd2syQllVRWJkVlVZ?=
 =?utf-8?B?N0tjeEVVK2h5NStmV0kzV0svYUNVdXNmU3pNbmhCeVlVb2p2SUZLVzc0WUFM?=
 =?utf-8?B?ZFNmK1QyMzR4NmhTNHNhekxhSDdRc3lMdnQ5VGxITWE2UmNwZEVZUmMwNVJB?=
 =?utf-8?B?OEpVWXhRaVM5UktZY1RMVDlBUXpIYm9qQ3BwNTVHbVd0ZGp6ZmhGQ2lYMlcw?=
 =?utf-8?B?S3FKNUxSeVl3QXZYTThMY2pnUHZVMzJRck5qNGlKeVBHRzZDeFR3emduL28w?=
 =?utf-8?B?NFU0NXJOUHlhamVYei9vMk1VVWd1RUtVT0l5OGtrSm1EN2dmakNaUEpQL0Ru?=
 =?utf-8?B?NG13Vks3TVdTOGlyWFF1d2taNDBydFY2UGhqb2UzYkVsSDl0TldHOElVWVJu?=
 =?utf-8?B?RzhJNEN6bEg0ZWpaY2pXWXhCWkJzOFNFMis0VnRaZmxrM1NXbm94ZUg1emIw?=
 =?utf-8?B?ZGhkZitINDZRVkhZcVVKL2g5TlpPbFhiNHk3WjFPR3ExQVhKVk9lT3hLR1Jt?=
 =?utf-8?B?RWlWMFdnZU1vWTMrTG1Bd2kxY1RDRnUwWUNKRzR1Q2IxV2NCYkRxaDlsWEJP?=
 =?utf-8?B?NFBFUWFaS2NINm1sdmh3Vm1HdGFCTTJHRGQ0dW8vU1Q4OFpsSWxxMDU5OHFC?=
 =?utf-8?B?dEcrWkNWNFBBQ0c3RUFUYUJqY2I4MGJhU3R0UDBBNGFsamJuUFROcjdDL0xx?=
 =?utf-8?B?U1lkOWNHaDRSSjEwNHVrdGVtdGZoVlNKa3ZZcVpibEhqQUxNT0Z5U3ladUVC?=
 =?utf-8?B?NUJCcCtyVUY1SUhsQWh1ZU9DZXl0cFFjTjR6bFpWeXpoaUZmbi9yUW1aZTJJ?=
 =?utf-8?B?ZzkwdFBFMUxCS25sRmVJVEdiRkNQd3JVdTJmZTYwa0duMzdCQlhlQ3V4Zmky?=
 =?utf-8?B?TEowcStqdGM5c0NCeVRwUHpxeXdkbVVFVlAvdGZFYmpISFlyQzJLTkh3Q0Jl?=
 =?utf-8?B?UEhqakwzRVJ1WktjbXYvTWliV0JEclppSm9GOHl6WWUxVHZ6ME1iTmJWcDJO?=
 =?utf-8?B?bUlDOE5xNVNtL0F2ZnJpM1V5NndSZERpNkY1bk5CWUk5c3BQa25NaEdiWlNh?=
 =?utf-8?B?WW5XdTZ1dTJYRHd4ampGSmlGL0lYVzVSRzBJY0Q4b2tuYzd0S3RqRUpyVXhs?=
 =?utf-8?B?NGNia2RtNTMzSHNIM2t0Qzl0WlYyYmVJSEhpV2R5TXRjRys0Z3NDRDFja042?=
 =?utf-8?Q?SeMoyX4Ehwgfi4MHbk3KTzhdG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a13f4367-17c0-4fb0-c705-08dc2440cd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 22:46:32.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vfUOcZo3MH4EBM/4P2dMcp8fVFGsGaTPphwExrJpxEYuhPaCHgRzT47fvGEQZ8ot7bhbWo9C9h82kM4i+gzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
X-OriginatorOrg: intel.com

PiBOb3csIHNpbmNlIHlvdSdyZSBleHBsYWluaW5nIHRoaW5ncyB0b2RheSA6KSBwbHMgZXhwbGFp
biB0byBtZSB3aGF0IHRoaXMNCj4gcGF0Y2hzZXQgaXMgYWxsIGFib3V0PyBZb3UgaGF2aW5nIHJl
dmlld2VkIHBhdGNoIDMgYW5kIGFsbD8NCj4NCj4gV2h5IGlzIHRoaXMgcGF0dGVybjoNCj4NCj4g
ICAgICAgaWYgKGNvcHlfbWNfdXNlcl9oaWdocGFnZShkc3QsIHNyYywgYWRkciwgdm1hKSkgew0K
PiAgICAgICAgICAgICAgIG1lbW9yeV9mYWlsdXJlX3F1ZXVlKHBhZ2VfdG9fcGZuKHNyYyksIDAp
Ow0KPg0KPiBub3QgZ29vZCBhbnltb3JlPw0KPg0KPiBPciBpcyB0aGUgZ29hbCBoZXJlIHRvIHBv
aXNvbiBzdHJhaWdodCBmcm9tIHRoZSAjTUMgaGFuZGxlciBhbmQgbm90DQo+IHdhc3RlIHRpbWUg
YW5kIHBvdGVudGlhbGx5IGdldCBhbm90aGVyICNNQyB3aGlsZSBtZW1vcnlfZmFpbHVyZV9xdWV1
ZSgpDQo+IG9uIHRoZSBzb3VyY2UgYWRkcmVzcyBpcyBkb25lPw0KPg0KPiBPciBzb21ldGhpbmcg
Y29tcGxldGVseSBkaWZmZXJlbnQ/DQoNClNlZSB0aGUgY29tbWVudCBhYm92ZSBtZW1vcnlfZmFp
bHVyZV9xdWV1ZSgpDQoNCiogVGhlIGZ1bmN0aW9uIGlzIHByaW1hcmlseSBvZiB1c2UgZm9yIGNv
cnJ1cHRpb25zIHRoYXQNCiAqIGhhcHBlbiBvdXRzaWRlIHRoZSBjdXJyZW50IGV4ZWN1dGlvbiBj
b250ZXh0IChlLmcuIHdoZW4NCiAqIGRldGVjdGVkIGJ5IGEgYmFja2dyb3VuZCBzY3J1YmJlcikN
Cg0KSW4gdGhlIGNvcHlfbWNfdXNlcl9oaWdocGFnZSgpIGNhc2UgdGhlIGZhdWx0IGhhcHBlbnMg
aW4NCnRoZSBjdXJyZW50IGV4ZWN1dGlvbiBjb250ZXh0LiBTbyBzY2hlZHVsaW5nIHNvbWVvbmUg
ZWxzZQ0KdG8gaGFuZGxlIGl0IGF0IHNvbWUgZnV0dXJlIHBvaW50IGlzIHJpc2t5LiBKdXN0IGRl
YWwgd2l0aCBpdA0KcmlnaHQgYXdheS4NCg0KLVRvbnkNCg==

