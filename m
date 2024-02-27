Return-Path: <linux-kernel+bounces-84236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA986A3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A44B1F270FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530256761;
	Tue, 27 Feb 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFhjIZ8n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6856460;
	Tue, 27 Feb 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077832; cv=fail; b=bdCviWzyZT56voiILSLy6seg+15+wk+Oh831nmrogdQG18/cxIgMAJnT6KfwqIkYbXAHIRZCW9M2CL6tYqwxadIDMiQXykOClGC1TcIlSN4Ko5YqB4zbNi+WSdhmbmqOXW8mYuK0bS84xtNcLzCS1YPeHatl4eYYTwRW5TWQy4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077832; c=relaxed/simple;
	bh=qvJJPDbK5/q3U+euHZk52UVRXjjwp4NABxnvS1eUuHk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzrtzR6oCOcaa30Cko44Rj3jEPv/pUnhCmU7jVHxbwNQeBu/qLshd4UIjLuKwGhQIj62zqiNGTW+P00ByteyaWfEQQOS5KJmPqfVuZG+ri/0AADIXnbd1BmdPMfI69KjgZLaYyb57saUb8TXD2aW73CTJFvNaXwYJ5ZTyepGpZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFhjIZ8n; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709077830; x=1740613830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvJJPDbK5/q3U+euHZk52UVRXjjwp4NABxnvS1eUuHk=;
  b=DFhjIZ8nlfIzffwdh9DMlVO4UGSvIZbC8oMPSYE+LO+U4NtHlapqie2G
   074cMOT1M6pU9941yWIswVpfBYKwPHjjNStsNqysqMQ2lRASq3cz/XrD4
   o5cOTX4CiYEYI3A1PhkOy4+5qsRkuwGQel2StbfGhDlaSf3uY3TzQm7p9
   vPUqLOkg7vASK88fcJGmnBj1Dgb06YRGKbtNzRpL7Hmfr3MT8LlXWnguu
   6OGuN2SpKREdwfo/tHNNVzkIKwodBduvaix862eKIv8eJAkOeh9UPb9oT
   Ng/6TBRXwN5l+aleK65zWVe+/3qWqhPXKqKwvOr7O72YY4m2I6OAHd/mv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3614773"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3614773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7164708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:50:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:50:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:50:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:50:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:50:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX7gA4s2abcvpQwZmWHWtQUcOHIer1ARG7Wn1WeNOrB1d+WEDHrIK/ACyVjRmYBT8F7rwp1K8f8LzVaFqma4Ev7JcYsoYvu2Q1NKfMPno4b1SbPw8ot5aDws4z+1lKKajsG1z77KulwlVYZJ35I9t7znoYWc5zJN9+AwaZVtNx2kHkLxhD60PcG1yeECKdIJycY6WzpuReVLTu70ynoGUuT35kDpyEZIbgboBY4wOndf/XGL8CC7G3OpKGlFpj3AbZQsOwq8rLY24Y4PU17OnudoCcXlXDYnUmwRnUl0YbKXxXP1vh3J/RKBZu9FnnjLMnVYRyLsYwDoMlH4juFYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8olyBYQCH3Z2xsMn+UBRBhd6o+M/VTbINhoApAwBYWo=;
 b=FDsSp6vLlvfgkSRJpbT6XtvmGxkDLb6eCkSk+h0iVno1dAQiCYdFHq32rY1b+sZmHz+UlIa/KlT9MJe3BdY2CWRuujZX5uSsFgfxYj1M/mBUUQcyHbsIdnkJsinxQqJNC5869Uk24iXuxweoAz8nyzpiVgDj10AptwM5F1igFga+uaUXJ3IXNvEWeNEXw956JBWhd47B+yY/Zbpk+UBIsqs3RSJ5Ipr6oow+Tbhck9bP6G7pYAJ9Wb0Hkb/NDbB1CSwhNUtUguR5//t8C4+5kEgovNAZkiVIQv7jpXWt18lEpJuJTJln7JCxr+GyJGL76vETFOpNw5mimcaApdWVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 23:50:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:50:18 +0000
Message-ID: <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
Date: Tue, 27 Feb 2024 15:50:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: ea52a20b-2635-4bc0-4206-08dc37eeda2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgAPTy3i2eJxle8Z6x2LTzv0DpUf2bgD1QFaslb8gCY4PFD1wScpT/r5txvDDuQkgKXqhq7noxMcjM3YtlyTG4QCwC2TNm43UW5AhtCwjV6EAcF108f/Z2U/YVAG8BRLqW5s981U4mfdkXhWqziBXknk2051rBYpsOzBqzbCGXcxdrKyhTv/x8wUUh9Op7x8lAgwXCQUVc53q1pjTOxJIV3YM1ZuF3v/GCxMUxMcULO9m0VfZUoczHXootSwrWo/ikDpNMancyY3/xqoHEuNPyvqH2H00Hb3T/rpv2UXyc4UAa18cAMJ36D3dZvb77olDKhoK8e4iDABBwBikPIsa7ZNBRLSXeMTMfGUtSq8Eb7RcgjtiRJfCCuMb3JJ4cRBMdhYQx5aXLx5CIsJSt6fNmvkhfMpU1r4a3ANCrhhRANMIHtemE7Im6RuhYNbANJYJ/S+UJwZDPZuThM0SbsJvaCyIn+RcSwrjDzcCoTut0/ose2XKKel/VVP3m5GLpd3IxpINRGN6aq6hKbGQXiFb0Hhef1KDYnVBV73R1lgV9jcHzV3gMrT000ssONf5wU9mGKzr4AO6XhdYgb1k/Lxj5xFXS73QRV6G4YaLgriwcDK/yW8T3Y6PsRukJUkzxKhXCBLAzys0RqGPcCtTZ7CFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXlqWUord28zRkJhUVBIemlmOTRZaVdvOEpsa2h3Vld5c2xNNUJqMXJTN2Zq?=
 =?utf-8?B?ZFg4OGY4NlhieGdkeitrMERYOXhwS01JejB6RXdLT0EzQ1ZpbUlpU0FpTjdM?=
 =?utf-8?B?T2s0Uzc4RkRXeWhTNFpvck93aWtXL2FMSjU4bERiQllpaHRQMWdpQzgzdzgx?=
 =?utf-8?B?YmM2QU9JMEg2bWdSMGdncExuZW5xVHJKQ0FUZlR2V0NCc0N5Z0FUUENvWUhT?=
 =?utf-8?B?Y0RBYkd6dHpzTXNMbCsxelltd3BUVHVWbTBUSU5nNlFOZ0x4NVlLYlEyNXJD?=
 =?utf-8?B?YkdmeEFEUUNJb0J5UGFFTUVZemdFaWxCVzMxS2RONnY3RGtwTDM4aHhYeU85?=
 =?utf-8?B?TlUxOXZuekcra2JFRURROGZWQ1NSZW96YUgzYzRSMEZOb2VoTmJrK3BiclhI?=
 =?utf-8?B?ZEU4cmQrUC81S0JsTDhHcnFNb25xUHJjdWdid3BaMlFyelMrYUFYT0F5NE5T?=
 =?utf-8?B?a3ptcmpBWGtISGQrTmVpaVFrL00wUXlWNERQcko5VGxlSGxCNnZjZ3QwMFFz?=
 =?utf-8?B?bHdrcFViVFlPUDRMQlFlMnA1b0lrVFdvTzdBK1ZqT3ZTMzNTWFpiY2xoVGVR?=
 =?utf-8?B?QlQyOU5FcUNxMVRNdkdnMEkyOTFYTTh0WERqRlVQdzJ6OXVuTlZxcFZ6elRR?=
 =?utf-8?B?VjBsTFNjSGJaeUp4MzJCdWxsVmphQmd6L3VDT1pWcWtjSXpWbm8vbnhFb1RP?=
 =?utf-8?B?NUg2dHhubXJheVZGeVVDY1l2bzJyTkFoU0hveEdOY2NKQWw5YmVrckY1cDdD?=
 =?utf-8?B?d2VoS0N0SGljMS9ISmZrSnVBMi9SendHalRkNFBZV05pZllvckw3bXJzbEY5?=
 =?utf-8?B?a0VOT280OTZoWU9QUENEc1E0S0JxOXZwSVNrZHdBNGVEYTNHMzQ4bXNFMFhQ?=
 =?utf-8?B?cWpuc2o2Z0J1UURWL0NYbVVTcVpZYWNUbEJ2VFY1R05CNVVhZ0lkU1JoNTlp?=
 =?utf-8?B?YkMveDhveXUvRmd2UGxUY1VBVnNzMkszRHRmbyt5RFNYQ3d3cmlyYkgrQ3hj?=
 =?utf-8?B?SkE4Y21UaTkvQnNvVFFDN0dBL2VCTEZoWFk4cXIvZEdPZ0FhV1VvM2dHWXl6?=
 =?utf-8?B?blV4bHhEdG1DQ2pkSzE4Z2p3MDEvUDUvS2V5YmZLZlF1cGtnRFBsdDZoazZW?=
 =?utf-8?B?Y1d5Qkp6d2t0R0xyWG5PNDBvQkJOZE5Xay9GZjFXN1gxTEE0TFlncnFWM0pN?=
 =?utf-8?B?cjJLelRVaDd0THpqdkJFTG1nMEhYbDlVbVlwMVdCdi9UWXljZnI0RzFwbHpY?=
 =?utf-8?B?a25EcWRBa3A2MTZ2NkE3ZFRtcVpjUW1LNGJzSStzdGMydit4T0JCbTVwTUlE?=
 =?utf-8?B?RmZKNlhwU3htWUwwYVUxZHZKR09PMURlbkY2ZkhCby9pMzZNVmk1eDhFcERw?=
 =?utf-8?B?Nm8rRXpPK294Q0Vid0hCYkJ4Q2k4am1hZ0svYncxZDVONTZORUtXRWVxM2Nu?=
 =?utf-8?B?Qld5MXR2akZOaTM1ZUE5dW9ORnNwZnhoTGtSVGdRMTV1eWVZQnN1Q1d2YWNS?=
 =?utf-8?B?VjBBRXZUOWsyTUdCZS96dEFLNWRzTmZpVTZJSEZXbmkyZEx6MUVqeXBlZTZk?=
 =?utf-8?B?R2E2SG0xMDNIZ3hOTjBQMmJ4bFJnRFZoMEZmZHFKeHFpQS93MjNLZzZicXFM?=
 =?utf-8?B?THBqeHZYTE53Y1Z3cSs2N0VOejVBMkRBQkd2UjN6MEE5UjFNRjdNWktIZ1J3?=
 =?utf-8?B?bmdwMk04bW5QTWhMd1AyQjUwaDBhdmZWcjdZKzNJTzlYczMzUk5hY1pGdzRi?=
 =?utf-8?B?cDY5UlBWc0tyUWowZ1ZUeFVuc0FDTWFoSVhFODkydW9FcGtBY2xxWlhXUEk5?=
 =?utf-8?B?NDhLU0E5TE1EanNlSjlzR1FhbllnSVRvK3JuMmtOODg2emxlcFhRemZzMVYr?=
 =?utf-8?B?REtWNjZZcldTcXl5OVlURmZwWGpTTXkvN2puMEtGOUhvaU8zM2d6RndFWXU1?=
 =?utf-8?B?T282V213VVRKdGF6bG14cVkrQnBhWitzQ3pSYzZzRWVoVTlJYTl5aVpheGVF?=
 =?utf-8?B?dkU5SzJVNUJBR1lJYm9JY0ZwVi9lajU2R2dQQi9PYWtJRVFzTnQ2ZVQ1TlRX?=
 =?utf-8?B?RXh2bkx1eEIrdzF4QXhIME1TOGZlVXRwdHlyRlYvc2xqMnQ2SFB1V1RpalFj?=
 =?utf-8?B?aUJEK29qc2I1cG5iVjNWTitac0xraVNVSGt6bldTdFlPY0k2dThCWVZrYVFI?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea52a20b-2635-4bc0-4206-08dc37eeda2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:50:18.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbAWk8V8SFlYnmbtcvXCC2ITDNQJztsvCnnIj29CMGPgv9BEvucze78zKVtjnq2GrmGpbp5LCtwjdLWw5QKIEXSZytVq6yijx7ypr3nzXfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
X-OriginatorOrg: intel.com

Hi Babu,

On 2/27/2024 10:12 AM, Moger, Babu wrote:
> On 2/26/24 15:20, Reinette Chatre wrote:
>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>> On 2/23/24 16:21, Reinette Chatre wrote:

>>>> Apart from the "default behavior" there are two options to consider ...
>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>     the counters are reset unpredictably ... should this still be supported
>>>>     on ABMC systems though?
>>>
>>> I would say yes. For some reason user(hardware or software issues) is not
>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>
>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
> 
> The debug option gives wrong impression. It is better to keep the option
> open to enable the feature in normal mode.

You mentioned that it would only be needed when there are hardware or
software issues ... so debug does sound appropriate. Could you please give
an example of how debug option gives wrong impression? Why would you want
users to keep using "legacy" mode on an ABMC system?

..

>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>> User space could theoretically create more monitor groups than the number of
>> rmids that a resource claims to support using current upstream enumeration.
> 
> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
> more than this limit(r->num_rmid).
> 
> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
> RMID to assign the monitoring. So, assignment limit is
> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.

I see. Thank you for clarifying. This does make enabling simpler and one
less user interface item that needs changing.

..

>>> 2. /sys/fs/resctrl/monitor_state.
>>> This can used to individually assign or unassign the counters in each group.
>>>
>>> When assigned:
>>> #cat /sys/fs/resctrl/monitor_state
>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>
>>> When unassigned:
>>> #cat /sys/fs/resctrl/monitor_state
>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>
>>>
>>> Thoughts?
>>
>> How do you expect this interface to be used? I understand the mechanics
>> of this interface but on a higher level, do you expect user space to
>> once in a while assign a new counter to a single event or monitor group
>> (for which a fine grained interface works) or do you expect user space to
>> shift multiple counters across several monitor events at intervals?
> 
> I think we should provide both the options. I was thinking of providing
> fine grained interface first.

Could you please provide a motivation for why two interfaces, one inefficient
and one not, should be created and maintained? Users can still do fine grained
assignment with a global assignment interface.

Reinette

