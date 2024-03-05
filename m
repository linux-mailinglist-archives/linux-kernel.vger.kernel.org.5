Return-Path: <linux-kernel+bounces-92710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176508724C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C6A28A951
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3DAD27E;
	Tue,  5 Mar 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN32+OlP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6682134CC;
	Tue,  5 Mar 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657340; cv=fail; b=tE5OVgf89D4HYJbF6Hxv4qoNFeGOPe7MsNJOov0R3BuHQ4KbZEuZkMnSo5wF4R8Jp9W6fSk+fLdyxJ2dhoijtLXAu9f/pfs27BQAkXbMbRW9dWishEro0IbuYi2Ecoh6ebl9b7UWgsArdYuPhILjAQwMvE4dMpqn+qKn/BgBIVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657340; c=relaxed/simple;
	bh=0Z5sESx7apkUWmV4dSaU5NRT7CLzUqYCohdxHG02Qco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdonIdct6DYQMkMyNVN5eiV/lUIKn/vK8TWLd/92M0yMW2ya1QNAbin4OtLXqGIa1spWK8NJMpKy39eqwHAnx6g0DyAt95XjbCFZzsnOPkMl8KpALoq6Q2UPxUc+XXwMIH5QHEDczctJyZD6QSNlZcWgPr1oq2SC2qRzJBYytfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN32+OlP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657339; x=1741193339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Z5sESx7apkUWmV4dSaU5NRT7CLzUqYCohdxHG02Qco=;
  b=YN32+OlPpzRnwjDVZ5h5ktG3Ao76tznx6l1GYn8UieqNz2/wSyDlX92n
   DY4/SHRC1VRpLN5nfe2RwMQJuslxcysGQ6t0ntpHCVpwZ24vpeaJzQTSD
   fApaX+8Mupk4Qas6hHyYZEjGnJbtVPMZxHvrVpHiX5f9GJLOubS8vWnsS
   14NEhrHkp+PYDfuaEGM8yFCef7A0URXPsBlf0eH0W3DppSnU7KHWVnSJ2
   TJ2tZmvMrtTTkZ6wjKoVN0uOWJPR9s+8Xl4kBIQAlEI1hxoXXW909g8ff
   H94ok38TLqWi2Oinyv4iKNxB0U6diCnlet2hOKr1ZD5emNnJYBL2g6kOs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4392325"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4392325"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40436984"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 08:48:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 08:48:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 08:48:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 08:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzO3kq6CO365NCKkMvExTT5IAZgsCMZ/yoltGLtaDX2Lqk2OdkrXUG4cbveI4wmTgBACFH8g4yAWG8rG4jZRFbp9D6/DQNXO0dnZJb7qf8ARin0jJeHE2SzvDGLuiG/qxb1whPVBTquLJtPgl+XzAGqLlQO7jjUQN2ThpjTFrvZDhRmWKC4Z80HzqmR9B/RRxJ3UEOBR5wwyYxPGfbQeA5AwKR69JL/BL6EO1EJESkUvkz1nRj9SDKqoFXPNm/j5eB548eJD8R51sqAIVPdm4nW0WsyBRhh/4snVJ29Mt7CqRKzgXpwF3HwUpFmSmk8QVXrt1xpn0jI5CIPy8g7Geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAFd5T7RMSlECvui898/CVua/nG48wqFFAg5hIZfN+c=;
 b=IIgHdrkgQ0lnJE7W92ohI7TzudxsM7OjbVFphEKrIqi3pL4wciq9+Km2IKFT7/j12q1mzGMWG9E/Rg3sTeq3AbzYi6YGrLpw2datgNqia6R1yVZgXpyu+TAqHxHOf0PpEwaF9+FT5F3X0p/FKUB0Bz5OUV7Cah+IMcsOk1mQMvnYAWDwop3aZIB2N+wEDWiM5Rr/bwoR6n/p5fjuyDMa8TcIcDM1K0M9HmaQNhNche42HJe5fS7/XU3RWPZc1JGytzJ/1/GyqxnkqV0aOIDVLQMw/h5PJVV/iIGDVIqi3l9j6aS0HO5PGe48yR0x+ayIEGPNC3u7XJmbR+xHOWg0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 16:48:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 16:48:54 +0000
Message-ID: <10e7de42-d0c4-45d8-a9f8-bd8e9d4b84db@intel.com>
Date: Tue, 5 Mar 2024 08:48:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
 <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
 <SJ1PR11MB60839371908CDC17A01F2167FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <428622f8-8dd9-40c8-8762-6bdef6d3a785@intel.com>
 <SJ1PR11MB6083C8DF1FD451CD43D6726FFC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083C8DF1FD451CD43D6726FFC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e78e26e-0ff6-4410-b8f0-08dc3d342470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWh4I8zC+UTa++Pbw7JpRBbawOHyfvVAH8qZVNGVSDAzQmwQOy6uQltf1LLVDDbjnq/BSdReu1o6As6VmmzpwczMf6nRlP9IPpJRYcdldY1F8++aiHnJNq0Kvj4xYncYxo0P0vNrjMdnfXc9CTNGsbBxM9PjL9mfaGqwy3R7PJtoKCJgVQdroeET5N7j5zUPI2eqbBPMwSJwsBDmIsYhYMomqk8MYQnJXrKJnNwsnA47muAie4vC6E2t4F6878fx3EcaVilssDOeqF3cNCgsOAzsPeZOkhUUsQJlGypISiyNFmGsVfwxt7i6uXhTfnNwUFtmmPXhJZWksnNHNh+m/Rth9G33um8QVDiIQ3svC1CDxw1q0B2x+wKBKYm/7BALRw23PnlYFZv7xghWZITfKFFMA6zPfrf+Z+hz8snVs3kTX75711puV+Ud4HZqAYYiO4UUTCz3cxhO8mUpxKAkDle329XW180lHOUIPin68Wdcjdl843eiVhadXvN12EPjgstwmXk3A3YtFgTZMS0O56ubavLiRj2Ag8G8ahMZyunbEfMkV7llv9XxJtXJYoT+p2iuTCDKNm8jgznTu16uAEb/L2P0KhQl7WK/XucOxvTBOCgI9UHWlsSC5BTGMdlkm07b5d6lBW93fsITqiUL0VTe0gd3ffUA8/UwppgopYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1o4Vm1jcE5nQ3FDbmVoRWNlWE00SW1wK1VkejFVY0duRlFwbzFDNTN6bkgw?=
 =?utf-8?B?ekJrd3FIeWpySnYxK014NEw3ZDB6NHFqUHhVdWFCQmdFMWJQQUNTTFJ6VlBi?=
 =?utf-8?B?QUxGbnVnaURGN0JIRmJFUjNZb2MyYm1uQm1WZVVpdkJ6UUZNOUhlc1AvcDJn?=
 =?utf-8?B?MXBaQUdSblVHckN2WXVxa08xMDZ3ZVV1NGt5UE02cG5HaytuN0wvUXhoR2dM?=
 =?utf-8?B?c0NQREdOenp4Tm44ckpLTzNaa0dtWDJ2ZjlTejd2cFE0MGV5bWV0aVA5YmRl?=
 =?utf-8?B?ZXFKV2lGZXRrOHkrcGZ0MUdseHFhWHJ2K01UNDhvbVJKS3cxbzFpTkhESjRP?=
 =?utf-8?B?VlZ0K00reHBISVl4T0FUcEJjVEdaK1UxQzJVUDZDY2NhS2VScjBpMmZCZ2ZT?=
 =?utf-8?B?RGtUQVZ6MzhKNFgvSlp3d0RmY2RaT2N6ZWhycSt0T2UrVmo2WkhLeG9ad01t?=
 =?utf-8?B?Sk80TVovYVpNZzdoQldBRmdPWHZxMVN4RzQzQk1SMENvVlB1cnNDVGVoRXNZ?=
 =?utf-8?B?Zk43OVhWTXpEWW9UYy9qa0czN2YrMkxUT1VTUW1lakdQVE41Ymc5Y05RVVFY?=
 =?utf-8?B?WktpOHJGKzZXM0lxcTYxL2grZENLbExHOVlHQkJqVXBxaStwb2JSanRObkNM?=
 =?utf-8?B?WXpLcVNkZytrUmx1cTU5MVpRVjNGWEN2RXlqMWE1NjVxYU9RYytMKzM5YXRJ?=
 =?utf-8?B?a2VZZnU4dU50OHNOcC9ibkFtWTBFZU03VkRMZ2FrYmROakhpSUJGaDJGaFY5?=
 =?utf-8?B?b1BpU3I2dFVvWkFnK2ZNOXVIRVkzcEM2Qk9WOTlibjlmNFNiQU1pL1RheW5X?=
 =?utf-8?B?M1ladjdoU2N2TWRBdkRNLy94VjVZWVFUQ1JPMnMyK0ZrZWRNK0RHbnNSSE1p?=
 =?utf-8?B?SDhHZks0R1V2VEpyekE4a2ROd2FOVWVEUVVXS0I0QWJmWkpxV1F2anltRE9u?=
 =?utf-8?B?UFIrZUo2UDB3Z0NkdStWdHptNjZlblVrVGEwNkFXeThKUEMyUmszb2pzZC85?=
 =?utf-8?B?clE0MWt6NzNNajg1UzI2NmxIUUNlbHNVQldtaEtoeDlFTS9HQWJBK2IrR2dV?=
 =?utf-8?B?WFhTa0lBa2VLNGYrQ3pXVGowVWdtRE15aW10aStxV2dYT0M0LzFxZUpTMzZ6?=
 =?utf-8?B?VFlwNnZFak9iLzlnSTEvUlJ1ZTZ3NTNXSW1kU08vSXEvMzlTeE5tV25Xd0VZ?=
 =?utf-8?B?OTVSRjk2RXh2amFBYXd6QVI2OFl2M09HUERTUndKNGlicEpXZmNnMmprdmNm?=
 =?utf-8?B?QjlyZDBoNEM1TjVneUhxbUxEQjBReTdEZG1oSzczbzlOdVRyTG12aDlveHpW?=
 =?utf-8?B?ZU42T1pDNGFvMEtMRDJra2JvdGtHMzgxRDRKOEgxOFg0MVNSM0tRKzJoNE15?=
 =?utf-8?B?VXFIdWJLUE1WTDFQV0IrZHZBSWppbWU5eWNoMUhyMHZ0RG5aYmE0NnBWdmFq?=
 =?utf-8?B?RUozYUxmaUdHSE4yRnVhUnE0TmhhVVZ1aUJ5OVhtV1Z2ZDBsV0wzWXlFZUZt?=
 =?utf-8?B?aERwenZRN3JCVU1YUWNwOWd6ZFY1bVZic1BFNjVYNVRsaGU3YjNVMzE2M0FN?=
 =?utf-8?B?b3lEVkVEYlo2M0pxdng0Y1RGTk9FWjFwWi8vVWxqd3FWa3hpR1Z5TmN5M25N?=
 =?utf-8?B?TFphZ0FiT0pzVkZDT0wzQjhEeWxvNVd2VXlJempPVEVlUElaZzBadjRDclBV?=
 =?utf-8?B?VmdmWmU5Qk9nUkJZbnVzdm53MGhVbm52Vm5aYjdpYldxQ0dmRkg0Qko0ZEhy?=
 =?utf-8?B?bUlDUm12c2Y2aU13Q2Z0ZDJZNm5hTFU4bUFRVEtDN2ljTDdGK1IwSDdtZFo1?=
 =?utf-8?B?cC9FM1FFQW81OWNEL0FlNVJVMEMxK1A2UW5idFFQalY2cmx0cGhVbEJLU1Js?=
 =?utf-8?B?UmNKQ2NpQ2NYM3V6RlpJYTVjdkRaZXF2T214SWQ5QkVyeE5qRXhFVkxjSmZJ?=
 =?utf-8?B?YmE5dFFZdVFEZG1HN1hUUnNva2ZaOVpsZVA0WWxNWXhUcGp2aXB2UUw3c1JE?=
 =?utf-8?B?MjVLK2VPMjI5MkVKenVCZkEvSzQyL1g4d0V4SE9QQmZQTDVzeExLRDhjaGY5?=
 =?utf-8?B?Q2ZIa3lZaDNKVFg5ZnIzR3pwbmtaUVZteDJkdzErS3ZFWXFJZ1NlQWVtYXlM?=
 =?utf-8?B?UXhod1Z4NTBCRDdkaUl6TW1VMFYzdzFmb1FwZVRIOGErck02Ni9zeHlwajdp?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e78e26e-0ff6-4410-b8f0-08dc3d342470
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:48:54.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i/+6DbmFSWJt4ikBKGAoECQIMKkRjwGO1Z0NxyEkKCGql7TklgnKVLbug4nzQq1FA/7XZS0+cuYtVhlCiVYNmSdlnJIBD1dkIlyduXmsX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

Hi Tony,

On 3/5/2024 8:37 AM, Luck, Tony wrote:
>> If I understand correctly that would always look for a valid "cpu"
>> even when none is needed. Not quite what I proposed but should
>> work. Just some wasted cycles in a non critical path. 
> 
> Reinette,
> 
> Sorry for misunderstanding. You are right. Assignment to msr_param.dom
> can also be deferred to the same point. Like this:
> 
>         list_for_each_entry(d, &r->domains, list) {
>                 hw_dom = resctrl_to_arch_dom(d);
>                 msr_param.res = NULL;
>                 for (t = 0; t < CDP_NUM_TYPES; t++) {
>                         cfg = &hw_dom->d_resctrl.staged_config[t];
>                         if (!cfg->have_new_ctrl)
>                                 continue;
> 
>                         idx = get_config_index(closid, t);
>                         if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
>                                 continue;
>                         hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> 
>                         if (!msr_param.res) {
>                                 msr_param.low = idx;
>                                 msr_param.high = msr_param.low + 1;
>                                 msr_param.res = r;
>                                 msr_param.dom = d;
>                                 cpu = cpumask_any(&d->cpu_mask);
>                         } else {
>                                 msr_param.low = min(msr_param.low, idx);
>                                 msr_param.high = max(msr_param.high, idx + 1);
>                         }
>                 }
>                 if (msr_param.res)
>                         smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
>         }

This looks good to me. 

Thank you very much.

Reinette


