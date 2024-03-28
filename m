Return-Path: <linux-kernel+bounces-123312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29486890667
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87F729B033
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DE3BBC1;
	Thu, 28 Mar 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGYc3UEr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6367A944
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645009; cv=fail; b=ZdsKE99cIOdV+ED0yvjJLL78Q0Ik1pIWzFwNRb3Wor7pShSPYfskshRF8jAq4YjurXBnt8Dw7Cw+bPpP9gLrVrB8fNds3SuYS6qxDYbd9GjNaH6D6ekyj6WbHjGxx6YNSU2EK9/OwZKL11iqD5f/B9Dx+/QY2/oX5xSNFZmjfnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645009; c=relaxed/simple;
	bh=Udv0P4110VJ5mSlovVAT+pf/yYFP3+1CxaEreDPSp1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtptAbUr4CToLrzsTyzPJ2L4nqdQGfK42URURhtPTuE2amE+axkOpGA0TazSbvoXC7lXEufR8id1h8TwZW8vnKWWIh6gtjxLVDxqD4DAukbfiM48la6Rmne9seEu9mLoqvc+zgRCF1O/YI7WOCD684TwM0LL5I+x7P9RyFO36vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGYc3UEr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711645008; x=1743181008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Udv0P4110VJ5mSlovVAT+pf/yYFP3+1CxaEreDPSp1E=;
  b=kGYc3UErRUB3icQAS9NZNe9NVcV8T1hUHlvQODzOHrZfvWXwtmCoVcKQ
   ZIRnnuj5LXajPXRq8m46whgbpmEtSfVxR+vA9c9C8jOfJ46FiMMub0GjW
   vZ7xAjMxaoHe4u8hSg6gyzKOh+GsL5wB4UYktm8MRge2zRSQ8QoX2vMfA
   kGCrP0V2WxLW3F8vf8qSsguQF3jaReOfVCSn/kkFIa43bB0TgqIgb2+NS
   NS1WAruPNY8bjD7oSBPCVqttsYm9mleRo7nSy3rFP2zW4oSZi7iwfY/ZY
   VgtZVbqqvqUpLaKK31tnc1ztMvJ1p0qJtWpGb3A+9QxigNEorPcn2uxEP
   g==;
X-CSE-ConnectionGUID: XxoM+fBfQMyJWLIJg7+GbQ==
X-CSE-MsgGUID: JyDUxjp6Q3q0uF0Jwu4iDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7415302"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7415302"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39859484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 09:56:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 09:56:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 09:56:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 09:56:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqtPC0Q1dHbO+YuZfXp+Ip1TIUjyzqvYy0WyZrO2ezYQJcHsCjLhANYB3euvwrblsP9peu7MjvyvK/+FG/Ppv2zQHr4akQaO5W4uaedGxxZKDB2jh7A9DkyxNBBwFc5JOm2MFjWEjPhJ4psbL8zWs9ndPibvsD+tSgqWnMO3TVft4axbycuu10IKQqf9vCKjRUugoZnx5dM60LEC/96d8RlZhBqsNdPtQmgNnetpHksurftnEhmshBAMmFHNi/GeUi1HkHw1Z/DyRonLSIcxNvAWNFiZRU+sBqUy5qju92ulBZVNzazisrYtRbZ0bnQMLleFbpY/oHWXrtedUMHMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udv0P4110VJ5mSlovVAT+pf/yYFP3+1CxaEreDPSp1E=;
 b=flo0TUL9fnqGq87tdTivn6TqX4eYCeQu/xDE7tjJAX0CJMlF+ExNj5KiZZ6WyPxJ6tL9XL0N3qx+W7rBENF8j5DZlNl2IkWO7wldK7S3cJto4LJtFIMSHtjTp8Lv6UuiWIU/bq67TZdActkUUFDc7twHUPVVYmX/DQEE2tENZZh/IlbFSJT3AZTZUR8We0WIY0LHZXUnyiN7vCsvxOVqccQTmu0Q8h5sDNQhS7+qkyC/m5WrpgyJdaUjlxOL+IZ/L1WZ5FVgE/kqhGw8ll4adSY1ifvdCgBEf44Zz70cvFmT3Jd/2/z6oc6sUjsgVTENp5HiQ8AYWeMJFlbtUaBlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 16:56:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:56:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAAAS4A=
Date: Thu, 28 Mar 2024 16:56:37 +0000
Message-ID: <SJ1PR11MB60836FBDB2ADF1B3B8A02EFFFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
In-Reply-To: <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB8231:EE_
x-ms-office365-filtering-correlation-id: 237224c3-bda6-48eb-ff00-08dc4f48084d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHnt7l2iWk6YH80fP0EywLNrYdsAKIsj4n3oOdFOf1r8JZUGhxwyQNVysArQ+3iOHJqIYenwra10QWKPxMSXasm22719uWDGxnJq9Gs3tugU4SPt1r1YVwOCCaUqXKp3TglArvU0mK9byAQFfvSyCWQ/1H9EXJV9F7dBokyMyRRT+B2OgmHfarHIsrwnDmm7Yk1u22SpaZDf9Dulf2FeIgWxywMI1cgYPUbdylQho7vP+Gt1/3Lb8zX6VX6My1ATcbUothj0ol6Tu8R0D3vn6Sug8WLalQVUl8SF6H+DouLzLeQqI/L0zPqYqe0IxiFCJ74XPLLnmp1K3VLMK4s3caUF081/vDuEONDoi152wayVFuRblk45DMVdLjeUVBs7/6pS92MC66ryH0QcBu6GQ5vqPfOABKRH+sY5p2UFfuzjusMFhbnKF3QACkDcnZIXapjNV6sUqgFmThl+YrEwjGQf4s022Q46sxD9FZIU3sfRb0B2i3TfbIpxvAmnRHBzqTP55oLQus+S7RIAjK6wE6TiT+8zE/0m01++LyPJuVIHNocx34TQLW3NBIMi7/lLQV85BhGh4dEN5XQDhdwEZ8GViCWAx49NhHLr3+bMqDPz3zLUL+ycySLb+5Y0vYiHjKKYelzxbls/HG/xkTmSz70RQ5QzUIVAvxSGZD75XdpoIZwQGeQm5khducElYoc2PWwVwtC5oC1hG7UYJqmpb+UHRoezuJMAc/X3ceF1xzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnZWQ0hEUjZBWVZRSE5rVm4rdUU5NW5tWm5qK2lyNmRsR3lycTYvV2J0TlFN?=
 =?utf-8?B?cUx2dGtjMlE2OXl2QWU1VHB1OFU4cnp3azFVTTEvdDZDRmxOc1ZKQ3hncU9o?=
 =?utf-8?B?bmh1UlJ4N2pEUytvd3dBTys0NHlMM3YxUkRRY0xvb3RHb0FxY2FkcGlmQTYx?=
 =?utf-8?B?bElVRUs4ejBtaUJGc3hNTUtaUUxROFBHRDlzYzQ3engzQlkxSWxuYWYzYWgz?=
 =?utf-8?B?MGdaeTdFSnBNVHV0b1FyRlBYVjNZWWpGbDQwUDZnSnRWR1VDcUJOeEhsV0RM?=
 =?utf-8?B?T2RCcE5ERGJrVEpCL2JwMFNnVm5OTzJFcDZVa2RNUXUrOHYyTmJkM3RTNEE4?=
 =?utf-8?B?eU9xMVJ2UU8rWEN1UkREQ1lJOER6UlZaVE82OHUvdUp4dEo4YVBnOXpFcFlq?=
 =?utf-8?B?T0lWQW9zeFVkOWdpbHFSZlJ4OWdtNlAvMnh0cldnSXpOL3NxaDhwQjQwRGhX?=
 =?utf-8?B?ZDJ5bytIeTRPL3Frb3dhL2dReHJlcCttMCtuWGxza281MmVwUVZ4TzY3QUEv?=
 =?utf-8?B?c0UwQVJXa2w1Zk1QWFE2WmVtZXpMd3JWU1ZMNHFzREI4czdnQnF4YlhmK1Av?=
 =?utf-8?B?WVI2YVhPR29id3Qyd2RUNFlld2p2RlhScmZ5Z0lzQWZoMHBwSkd0RzdjUzV4?=
 =?utf-8?B?cjFyUjZUdmRGejZUK1A3dGZ0V0lZOWM3Ulg5djgxakY2VXh4aW9YVUlDMzZk?=
 =?utf-8?B?c3M3RXdvOEZXYWZyMHJwZVlVeEhMeURnQjg4TElTRHhveDU1YXdobzhhQ3hI?=
 =?utf-8?B?MXA3NG9GU2VpdmN3QWZpT3JYaW9lQTVtaTdEaUR6Ri8yelJOQTlrMi9VenM3?=
 =?utf-8?B?SkM0OGE3SFN3QjNLR1hHSUEvRXRUcVI4WUtSK05IR2ZMOUphWHpCVTdnSGM2?=
 =?utf-8?B?S0pkRlNMWFpGbVdEMWsyMW9oYUJLNFJwUWZOTjExKzlwc1dXWjRBQ0puUXdi?=
 =?utf-8?B?eUNIenhSOHd4ZkdLVEd2TitOQWNyNGhyeU5peXpKVjdYSEpSdDNBbjhVcVlI?=
 =?utf-8?B?NnFaQ3pFb1k4ZjRKNHFhVjdvNExPM0d5RnoyM3BlT0R3QjVKY05RcWpPRDlo?=
 =?utf-8?B?UkVld1NTY2NTeCtoak1wOEFOTkswa2tUNWhHKzZtb29Pb1YwdXNTUjN1bmpp?=
 =?utf-8?B?K0hNN1NpTmlPZTgzZ2xzV2d5SlMrVUpBUDR6Y2dmVHl4V0RuM2lRanpYc3RM?=
 =?utf-8?B?ZndUS1h5dHkrWDhEVGdja3pIUlJHZHhmeVlqRTA5R1NObkNwcldJcUVDR2dw?=
 =?utf-8?B?QzZRLzloZTV0L2djaDcxRkZ2V2p2bitZUDJxdzg4V2hYRDRWV3FyMStqOGdN?=
 =?utf-8?B?SlhSWk5jZ3QvT0ZFV3FCazhSc2c4MExrT0dLMWljMzV3VnkwNHcyb0JoeENH?=
 =?utf-8?B?ZmtOcFBvUVg5a3VMaTBKV0xMcnZ4eFpiQzM3alRqTStXOFZ3VEdIY3BIOUlu?=
 =?utf-8?B?N3FSeEI0bmxwcHdRbC95aFVKMGkxYlZocys2RzdoVDd6c0FVNTBmYjhYK1d4?=
 =?utf-8?B?d0ZhVkdCYW5wLzJ1MUNIKzNtMHN2NEorUnRJT29Nd0ZLRlN3KzNBc0Y2NGEz?=
 =?utf-8?B?MGFSUzgzbmRDbFYzUzhTVldESWRuM2RCem1OL0FMaWdXQ3Y3TGxZaXU0UHlm?=
 =?utf-8?B?ZkYyNnRpWStiUmo3M0EzVFZPT1F4dnBQTi8rUDdWTlUxMGhmUkRRSkVJRCty?=
 =?utf-8?B?OFZQZGp2cUpiS29Wa0Q0Y0k2SjNDSVFrUmpaRFA0Z0RUVjlwZzBKWUt3Uzhj?=
 =?utf-8?B?eUZHMVBLamk5WCtWVi9kTjExOFJzUWlyT3lPWnM4MGdxRTF0ei9CUVNHTjND?=
 =?utf-8?B?R2UyNTdRWGtSNi9hNzVwQ2FjbC9CZmZzdDRPV0pobmIzcURXQ0dsVFRiSlJ2?=
 =?utf-8?B?SzVOa0RkTEZ2TkFoZHZta3ZiY29ZOW9xY0hjeGNHekxZQ1Z3NkpzTFBaQUQ1?=
 =?utf-8?B?NUVkcFViQVdBVzVMVnI3U3p1V1htWDVBYmVRTG1nQ0o4L2NiSURaS0MyeWVX?=
 =?utf-8?B?UHFvdjVZdWcveTJIZ3p4bmNmQUczQUNKdGlkT2VzMnBZemxmejNCMlo1SjFl?=
 =?utf-8?B?dXgzeWFJS3poQW8wNEtjL0c3Rk13VmRSdEZuYW1lMVdmajVlRVZqeG1ielhU?=
 =?utf-8?Q?OzJ6ATWqwqE710oQBT/VDsMLU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 237224c3-bda6-48eb-ff00-08dc4f48084d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 16:56:37.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgcA7FehP8R42RQwhXAoJxLQFQ+cfXkGPeOIK7s0jj5NtLP0OKUFu4S1jZVnvJNu3YWJrQKgfGUNLzMx7gBByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com

Pj4gIAlfX3U4CQkJeDg2X3N0ZXBwaW5nOw0KPg0KPiBXaHkgYXJlIHlvdSBsZWF2aW5nIG91dCBz
dGVwcGluZz8NCg0KVGhlcmUgYXJlIG9ubHkgYSBoYW5kZnVsIG9mIHBsYWNlcyB3aGVyZSBzdGVw
cGluZyBpcyBzaWduaWZpY2FudCBpbiBDUFUgbW9kZWwNCnNwZWNpZmljIGNoZWNrcyAobW9zdGx5
IGVycmF0YSBhbmQgc2lkZS1jaGFubmVsIHNlY3VyaXR5IHN0dWZmKS4gSSBkaWRuJ3Qgd2FudCB0
bw0KaGF2ZSB0byBpbnZlbnQgbmV3ICNkZWZpbmUgbmFtZXMgZm9yIGVhY2ggc3RlcHBpbmcuIEUu
Zy4gdGhlcmUgYXJlIGFib3V0DQp0aHJlZSBzZXBhcmF0ZSBzdGVwcGluZ3Mgb2YgSU5URUxfU0tZ
TEFLRV9YIG91dCBpbiB0aGUgd2lsZC4gSXQgd291bGQNCmJlIG1lc3N5IHRvIGhhdmUgdGhyZWUg
I2RlZmluZXMgYW5kIGFkZCB0aGVtIGluIGFsbCB0aGUgc3RlcHBpbmcgaW5kZXBlbmRlbnQNCmNv
ZGUgcGF0aHMuDQoNCj4gQW5kIHNpbmNlIHdlIHdhbnQgdG8gc2ltcGxpZnkgYWxsIHRoaXMsIHdo
eSBhcmVuJ3Qgd2UgcmVwbGFjaW5nIGFsbA0KPiBmL20vcyBjaGVja3MgYnkgdXNpbmcgdGhlIHdo
b2xlIENQVUlEKDEpLkVBWCB1MzIgaW5zdGVhZD8NCj4NCj4gVGhlbiB0aGUgbWFjcm9zIG5lZWQg
dG8gYnVpbGQgdGhhdCBDUFVJRCBsZWFmIHNpbXBseS4NCg0KSSBjb3VsZCBtYWtlIHRoZSByYXcg
Zm9ybWF0IG9mIHRoZSAjZGVmaW5lIHZhbHVlcyBiZSBDUFVJRCgxKS5FQVgNCndpdGggdGhlIHN0
ZXBwaW5nIG1hc2tlZCBvdXQuIEJ1dCB0aGVuIEknZCBuZWVkIHRvIGFkZCBhIG5ldyBmaWVsZCB0
bw0KdGhlIHN0cnVjdHVyZSBpbnN0ZWFkIG9mIG92ZXJsYXlpbmcgd2l0aCB0aGUgdmVuZG9yL2Zh
bWlseS9tb2RlbA0KZmllbGRzLg0KDQotVG9ueQ0K

