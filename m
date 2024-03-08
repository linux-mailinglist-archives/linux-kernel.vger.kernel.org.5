Return-Path: <linux-kernel+bounces-97690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F774876DDC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956AA1C20F65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99563BBDA;
	Fri,  8 Mar 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/K39PN+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AF1DA3A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709940387; cv=fail; b=YasAbZQhh9ykfAXqiCJcODG9dENk00ooo2iXqPxUjgsM/mSlIts/KTHoCPspu3GpROM/PVPrRgHacQJjCL0kgrEri/U1eQdajKgAxC2r08rmrd+9V5D1Mokwt7ESmnzFi209hst8oWuh5JnnjdI3348ZglFe4XSeZhBTxDccaP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709940387; c=relaxed/simple;
	bh=vC6BYnOopNCwg6nZh2S/DFMlOtesmN1evwnID2rHdqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PgjdEK+CuvNP8qdesgf2bEUQ+RZvl46eguvwJTxJt0ITTe80Os+WlUjm1aWen6ygZj7TWX/I1zxkHZ+1UIrX8f7FI8vQfwwJajbuMnkg3lcqFRST7bkZ62pzdxoZn2PfGvYuk0Xlpv95/jNwBPaU0nTk4OZRexra//8++I+pnvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/K39PN+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709940386; x=1741476386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vC6BYnOopNCwg6nZh2S/DFMlOtesmN1evwnID2rHdqc=;
  b=i/K39PN+gMv9Sgr8r7QHm98U+mAbQCoKj8drs6ffBcPVjwE0fMfjzHKL
   8XKXnCdH0DtLrUyLE+5j04po/dzOIU03Uxp+7I5kwNqgHcRIrJ7+AyMF/
   Ka45c7e8gkBG3IOWM7FMYj8XEx7OcNBzBx24gg5GQ6Zepi+iB1O2kcJgV
   5MQqvZyTv+rQ07AgsWx7zLBikp3wBrOervX0HcTKuWhTPl83UcMffXjvv
   SUIAo5qLRyHIt2KQZTLNQF1iTx0y1h3vtwzxb0Q7T6jeLtN2hwdEdM4hb
   Vlv00rxJGtIrzUSiWMXSnwW/O1pEi8cv2DKXzmbEwipconhLVkTGwF6co
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4818518"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4818518"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 15:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="41535755"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 15:26:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:26:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:26:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 15:26:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 15:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBAu+aIhJB+PO5CnNrHg0CVJEmJRQrhE+NsUdr+SUBaa1/pVoLW24oey4y4CoUPDtTpvLA2lE5tR1aqemdAFkYWg36IpHYRqY/G6QID0pxs18lWvxfo9l55jke086+ixqgvqHmU2q20CZaJy12/QjZRwmWp1axKWLXCSRf6DyDZuaCQDZcXXHKf6SP1R0YeKKbzKU6/ELQFaR2zFWKuxZ/8bmn6li3dtCceLg98If+HxJCPTVVgGh9ZOzl8OLX9w8juS9mtJdfL0KrsLkgFH0I+vDPVoOP2UESUAfM+bxyXpcEY2mNM0t5X4i86/lOxxetLEoGgXD5vA6Q3RqxOZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC6BYnOopNCwg6nZh2S/DFMlOtesmN1evwnID2rHdqc=;
 b=J6Vp51tlzL1ytNLPmocLwSR3FAKt8Yth7cLWk9iu53vpHXoIm8XYy+R1xOtxDA6Sx7Ulw2nWY/V/qsUMylFPywBXE+K0vbvmvSbMU6LzjXRBo+QQgYcuHfkfE9GKVlPEWI2kBzV0CU7ZfvJfnMcUBgbTTtG56QZv7kmrRyKakD83kvpQYfAos5j0wavhjXYDp83gqx0l404EqQ8Ej+u9qaJWUDdPqQQHM7DQNDdcIn+HXUWVMtIuiRdweMGW3VYzo4OtNJzLzGBRsbMf/HCjFENUb1R6xXZLrfhFCyOXqAkisntKHpB/GMbETIzxrO+DJ5ihMLAOoQF0nELuLL6ACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 23:26:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%4]) with mapi id 15.20.7386.009; Fri, 8 Mar 2024
 23:26:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Borislav Petkov
	<bp@alien8.de>, James Morse <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
Subject: RE: [PATCH v5 0/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v5 0/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHacaENbovBdhBKo02FgllPwDGfkrEud7oAgAAEE7A=
Date: Fri, 8 Mar 2024 23:26:21 +0000
Message-ID: <SJ1PR11MB6083361BD1C37C8791C26E6CFC272@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
 <55b868e8-6fdb-44a0-958b-892170a33f0f@intel.com>
In-Reply-To: <55b868e8-6fdb-44a0-958b-892170a33f0f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM3PR11MB8760:EE_
x-ms-office365-filtering-correlation-id: 2bbffd3e-855b-4eb3-508b-08dc3fc72a0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9YlNGkDTZfAkYJZeBpFxmMYyOKgiQLQeMAstufkOCVz2ah8dAE/81q+zNAELEVRXJ5hTymQGbgY+VtnYkOaNZjZRKqxt3xTYILlOtzETpaf9l9hCPYPBobJmQiLF0YOSSCGyaafqlECkbxd+/F9PBFBYIKssVhYK6VaOGp7sHnC7dFauNrX5d7d+8vdM7V0akLNtV5Vxja0rEp5jnPwlcpEEHCP/rXxST5bHVbgQFu8mp+ItjlMAmeEsELeyDFrpi6wUqwWQa3npInYMVh0gjHYe1aAc1A3mp6GBhkkHLvn13vKBxs30L77TU4CM26Zev/52Xky9G9cvIH9t+FG2ED8/0VPdvC5ce+A30zSj/1YE4Dh6b1S0PkfT45Y77zryS00zI2xWDlVcVznpojzxftUmP+C3fF17lQA0vErHh8KffWPD7JBCu+XfOIBgDH/ueIcLBEUmuK7WELxzdZ0ytCtPSrOaPsH5+Er57nyFl4S1qL380TANbQoJuI/q78zpX1AT5uGasqw3A1fN+zUQpnKpFGgrX9icXKlGGbOx8kuFXK/QonCm0L2BtERCPXewDi6wVH+mqvkkmwnUoPlmo9IANDv5n/1b0QmxMKmTX4VLwNpmfipKAgu4PMfxXUHCUccTrNSutndmwJcFWV41HrjBwhz/cFR0RhzRU7lZ0mHZO5y/ZuvosI1tD1BGV/MHYT9cblz9yCmeaaJVtoM4Slg+AhwDv7qHk+EucQjG3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjFaMElmMUJ5R2t3anZBRmdMRnRNbjZqNnM3TnFmbWwrQzRZZXhYOTNhaWxt?=
 =?utf-8?B?WTMzckFCR08wSGFwb3dRbUd5dWpUZ3k5cTVBYXJvRzlXOThScE84Q2ZMMWx1?=
 =?utf-8?B?MC8yVllQdlZVSmloZGFNYi81ek8yS2NTMk8zWUtwSE1kSTBrbktlWUZmclFC?=
 =?utf-8?B?SVkrMTRmZEJ2TWNsczlmM1FPdXdZem9NVEZzN2RyU1M0Nmo2UW5hQWcrNFlH?=
 =?utf-8?B?WWMxR0s4cURMMm5KL2liejFHdDRjd09YcEF0aHYzWG5RRFhUZ1JkUzgrOXQx?=
 =?utf-8?B?SFVWZmRkWUNqNkdMY3NiQXArWWxDdkc1cTI2bGVvUFQ4eThNSW8zbklRa2ow?=
 =?utf-8?B?OVY2UUMyNGt0ZjB6V1I0dTk5a1ovTkZqYlhNR3orMjFhWGFrc0ZFczd4MlBI?=
 =?utf-8?B?dmdMQVhyL2tMTnFNWEN0TU9mMHVrbGNHWXhHTmhpY1BFVVFMaEtoNUwxWXc1?=
 =?utf-8?B?Y1hRTlRtelYvbi91LzRTNUgyaWNJblFQV1hYSFE1b3BQT29FMndEc2Jwa0hi?=
 =?utf-8?B?NXVSMDUwbHJ3KzVmdlNVbVFCS2t4ZWwzallKdEYzR2k5Zmk3YWxYQ1FXQ2FP?=
 =?utf-8?B?aTRBbGt6eUd5NkdRS0ZBcy92Um9hQlk4VUZCb0plcjRuOUUzVEVUT0pXbEVX?=
 =?utf-8?B?UW9ZOWl1aEw2MDZLYmxaUmRFUXAzQ3p5SFNJd21kWkNQWVZST0FaOWE5dG1t?=
 =?utf-8?B?VnNRN3U3R1BqLzVnOFZtZ1h1Q2hvYUc0SzB2UnlyYWg5R0RPRXpyZGZiS1Z4?=
 =?utf-8?B?N1c5d3lWZHIvTzRXejNFckVYZGpHbU9DVTNDRG5jd2xic0FlNjlkUmI0VUdy?=
 =?utf-8?B?U0F5VXUydEpucDhrTCtvNi8wMmZERVkyUjh6b1RFZHFmLy8zbStxRDFzWktB?=
 =?utf-8?B?U092WlRqTVkyMHNKWE9mVzJ2b0JocTBFTi93ZExPV3o2SjEwME5uV1VHbXc1?=
 =?utf-8?B?Vyt3WkNmc1F3Qmt3YndjUXc4TkhRSzhyZkEzWlVqYzV1VVFRMUZiNmU0Vzhk?=
 =?utf-8?B?VVlpVUM4aExhT0MyQ1BKeWNpaGpuWC82MEVwRGVScDE0aFVRU21CcEZReHdv?=
 =?utf-8?B?UG05ZGtncGV0NzJtSlJFZy9XUGlLK3h5bUs4T2R3RnhZU1h6WExMbGh2NWxC?=
 =?utf-8?B?Tk9qZmZjRy9OOUU5c2JqV1pBYXEzME1DeEh0clE0c0FYWE15V1RtcFhrWHRw?=
 =?utf-8?B?Qk0xNWNobFhTeUptSFhBQStjYVFscTFWWXhvQmtoek1GOGVDVmtoUVZGeDRM?=
 =?utf-8?B?VnFkYkI1eE9ZVXZ4YjhBcTR5N2hIRzBEMzhQMU5OQjF2T2tkNHBQTkVZRXhs?=
 =?utf-8?B?UndIMFRUUlloZUZRMGF4TXMxNlNHZW0ybXRmK1dxWmg1NThoSmJqRGcwSVZz?=
 =?utf-8?B?bkhyeGVIekN1WXNyWnltamJYaDhPV3dNczcyeXFmMU5uaWxlRFJFZmRTOU9x?=
 =?utf-8?B?dktsM3F1bmNiMXJWa3orUzd0cFhCMXo4eE1xNjRnMkwwZm5EVVpuUVZxaGZB?=
 =?utf-8?B?VGdMQzI1eEhDblVtV2NoQUJEY0c1RWMwbXBxZmFWMzFnWEJrbCtuNm5tY0Q1?=
 =?utf-8?B?N3BmT21OOHI1b3RyQUM5OW1xTFlvNzlrMzNzV2JvZEt4VEQ2bUp6Zm16djY4?=
 =?utf-8?B?cnRidzNoRVNYTHJDZFNoZXNqTlY3M2JReXU2amsxL2U3NU4vYkJ0WHl0dmFE?=
 =?utf-8?B?Q3hPVlNIbnI5RU03WnZSS1hJa3Y2Rm9VT2Q5Q1Nla0dIK2ozSDdpdnJWUVNx?=
 =?utf-8?B?UXpEQUowMFBBTys1OTBVQmNsYnd6NFM3REJwSDQ0T3I2VEJWc1ZJaVNOdHo5?=
 =?utf-8?B?ZVNoTWQ1VHBRMGtDaEFvcDVNdHc0MzJqMHBNbTA5RVFTWlJYN29MUnNPOEM5?=
 =?utf-8?B?S2dVQjFZUlRadytoMVVuclIwSGhKRisvWVhDRTZsajA4N015di9VZW9qQ0tr?=
 =?utf-8?B?b1ZJQ0tMaWo3ZzlTUTR2ZnY1b0lOaDN5VStybmQ3akE2amdjVEhaZGV2Q3Zi?=
 =?utf-8?B?RVdoU2FSOHUvWm10LzNRd09BSUJiOXZPbFVKa0c5ZzA3M2lSak1rWGt6TFdO?=
 =?utf-8?B?dkNDQzBDOTlkR0FXQjRRMjlZamdQbEhTcHBHTWNxdUVGdHllQXgvcGNrU09T?=
 =?utf-8?Q?2aUe5DItYz7hEFEIE+zD92HK/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbffd3e-855b-4eb3-508b-08dc3fc72a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 23:26:21.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHuTXNGInSnCrN8lzP1AwmBMpzNIKkL/dI6TwuAGvAxvIruyb1ttkLjcOvhFjqTt/DlhjOqYxfbcikAASMatUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com

PiBBbHNvLCBjb3VsZCB5b3UgcGxlYXNlIHN0b3AgcmVmZXJyaW5nIHRvIHByZXZpb3VzIHZlcnNp
b25zIChpbiB0aGlzDQo+IGNhc2UgaXQgZXZlbiBmb2xsb3dzIHYzKSB1c2luZyAiSW4tUmVwbHkt
VG86Ij8gQWx0aG91Z2ggdjUgaGVyZQ0KPiBmb2xsb3dzIHYzLCBub3QgdjQuIFlvdSBwcmV2aW91
c2x5IFsxXSBhZ3JlZWQgYW5kIGRpZCBzbyBmb3IgdjQNCj4gYnV0IG5vdCBoZXJlLg0KDQpSZWlu
ZXR0ZQ0KDQpzb3JyeS4gV2hlbiBzZW5kaW5nIGEgcGF0Y2gsIG9yIHNlcmllcyBJIGNyZWF0ZSBh
IFNFTkQgc2hlbGwgc2NyaXB0IHdpdGgNCnRoZSAiZ2l0IHNlbmQtZW1hbCIgY29tbWFuZCBsaW5l
IHdpdGggYWxsIHRoZSAiLS10byIgYW5kICItLWNjIiBhcmd1bWVudHMNCnRvIHNlbmQgdG8gdGhl
IHJpZ2h0IHBlb3BsZSBhbmQgbWFpbGluZyBsaXN0cy4NCg0KSSBjb3BpZWQgYW4gb2xkIFNFTkQg
c2NyaXB0IGFuZCBmb3Jnb3QgdG8gZGVsZXRlIHRoZSAiLS1pbi1yZXBseS10byINCmFyZ3VtZW50
IGZyb20gdGhlIHNjcmlwdCA6LSgNCg0KV2lsbCB0cnkgdG8gZG8gYmV0dGVyLg0KDQotVG9ueQ0K

