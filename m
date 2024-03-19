Return-Path: <linux-kernel+bounces-107951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02588803F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE841C2295F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3792B9D7;
	Tue, 19 Mar 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk0OriL+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FB225DA;
	Tue, 19 Mar 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870779; cv=fail; b=Zj9bbm0oUtNYubtmAVLgtsHcQk5A8G4t0CQyQMIQKNeQn0c7w4Wqof1D/OKJA92oOWy+lnLGGUX4SttYtxi+qJ5fx91JwUqMsm316t/YL6Kqi6EwK9AnUzFthI1IMkX46QEchDhH7lsOetWvVrHFFB8zYczkC/Huglkc0im+HB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870779; c=relaxed/simple;
	bh=SGSEpVTLTeowpm6ttln/XbFVXX5s1Gu8KKvy7vU9kRs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuvsmXKVzxxJTeNUVzu6cN7GtI9VK3DEL119qqtPE4kEz+NzvY5i2g2i6V5cbo09kQHq4FeZgxJO3BaIioxZQsXJfbxA2BLZ/KpFNGG5uvn3t6ft2bYEc2XEkB2qs72ZzbVOBV7HX+PIQSMayhY4tAIMVKBw+HETMW6uYyCdYto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk0OriL+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710870777; x=1742406777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGSEpVTLTeowpm6ttln/XbFVXX5s1Gu8KKvy7vU9kRs=;
  b=Uk0OriL+gO56A8wJQYPhJA4w5QTiymE/Nj9rhkYLi6pBhvfZv/lqzA2x
   BDnSzE4tBObuBnAoX05eE4AwW8wQykecKagUZdoJ1febFWuiIingsJZ68
   ZkJtdSy4oMPAAvxgWbOHzeKVxKtvybpfa8OGfGNJeeGvceNCWpC8fN4St
   Xd2zmkSX3MwdemSkqo6caSq9VUlUlkJnnn3tzvYGGZKeFZR/a7hFEkP5w
   00Al/J86sVw3AJVl+M8Fct0VQSTXlW1KEDyA9CgdcDddaAZ+DS9rcAd/m
   dxy0znl4S5sUQnBIKa4NE71dDBn7e5hGoqdoR3eDWOt5GXdf3axXJc+Az
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5696301"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5696301"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="18618473"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 10:51:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 10:51:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 10:51:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 10:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8dHnBHSBLnjM00RldQ4INjSX0k3x58HKiYKPYMoEJWOwfum6V//8AE4IvZiuU46xwW1cNXFlxCtkh64M4ez7KJDAgqn+cjBARzwZYtXLxbEvDJAT82IingGHqRp1BCzcxFmtA+h6cxDQzWwzgbj37vdPaVUzEU6A6AALyiTfov9E7XhjQ8qiMaWUWSQz4cwsU8p8oDypT9sBv3Sqc3BdzWs7S8EihcefA9V/FVQiBWdO1UG8Msc7QdZckkrZj1+idkqCwuNwA+gIasYtofUbQ861kF4qYObEn7TOSpcFxjhZ9z17XRsYEwzHdN1tyxgvzhr9ZeukUVK+Jto5h0xzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTZlJh3jgixUtw1WKELSzbi6TcC/CLPEUr5Gyc0rtp0=;
 b=lVMolF/tEvRjU/Ed5miPTP9VXMM7PPJMz9UAi/WNO4hRUfB/lrZu6D9txU1IhJKNEhdlqeuvXItAIvXM13jVgL+gxbI1mNg0KXhL0GXD3uVZRf4ED6ta86iHYax+m3Rvv2W6yPqWoTjsAc31UsY7lpo0F1TtntvfHhdOuuo1qHG9XxRbMK8kQ+1LzoSLOt9a8C2tu+ReNz+cial8O9geKL9NP79KyPEP8XFbPpwj6DVx1sBn5XpHauYVzqKqs9jMls2x83WCTQXFWAt00FcpL2jRM3vD3XshzzRTzzVqMt8Ko2eJG99w+vkz4/AWv7+M2wBOLzg1K3dmGMY/QaLn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Tue, 19 Mar
 2024 17:51:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Tue, 19 Mar 2024
 17:51:15 +0000
Message-ID: <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
Date: Tue, 19 Mar 2024 10:51:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>
References: <20240312214247.91772-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240312214247.91772-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: f1592324-0bcd-4799-71d6-08dc483d2c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzF17EPoscJGs3REh3IQR1UFjXt+Dw8kvQ1LIZmcPK8KRnAZq/kY21KIrRs/9Z35n35fRaueE9okuD4PpXU5tjsbUh2sT6uJZmpluVqJ58bFKJG4DKj5qqYsbWhaeTurTimlJ809TrLLHJymK174GPe2O4oiz1JjOvP4qyqs/J6G2Sm3HpLOqH157wc9KdTnTgDADQpskVWlvo8nnImB6ljM7D6ml7PP2ieC6kgXOOCQb68KVPoGIozJ7SiAgBAMWSF+/tf9twchV4pax7KmedpL+AyZ0B9RoKCMQI90TI86nAlAxuB5+neuxd/wzAW+zgFsR0RloG78GQhNlU3xjnafqp5iK67NRogSiv8uSqG9rwvYESrXpsNasubQ2r7KUKa7opMw3UiYyxm6WwKUqHLWqhlSrpVUJX2Fj8xvot6pkndww4GWiz5JjJJD5Ua2FQCQEkWgFVhFlf5LK80wSlDFqg0nIdPl0rDXkVYjrw6Ix1IMDEqFPp/KJ7m6pLuT3LpovGac99Eognuspant00/i2GE2fawOkSGcStw/9+oDzUYoT+7oM8dSEdL9TEThs51tu5zrntipOkFk3/IqIUoJvyN5SlvqROZFEjD5DNMpsdIZJkBcgAFmcWxoVbZg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hKZU1tck9PMlltTzZ0ODVNQ3JIZ1dnSnpROEorYjdxalJuTHI2Z291L3g2?=
 =?utf-8?B?Y0ZhRDdQWEs3NUk0RE1FUFNTVHE3SGF2NkFUbHh2UE80K201bDMyYllYWEEw?=
 =?utf-8?B?bVBNR1A0QldOUkpET0xIUVBtcU9PS3N3QzdpbTdqL0lUTUNVSUlPa3ZDbzlX?=
 =?utf-8?B?cG5XZVdJclRRb2VYc1BPajdxZ1JJemUwWmxUdGhGYmE1dTc1aUtWVHl3U1Fv?=
 =?utf-8?B?Qkxhd2pld2MyNGxTN3dJeTlzRXB3WGlZV1k3THBiTkFzR1hiL1dBSHVBT0pZ?=
 =?utf-8?B?S24waG9kR0NkdGtpcFZJcEx1L09vbldEREo4dUU1K09WSFVsdU93c1dKUytr?=
 =?utf-8?B?WWpZcHJ2NUZrMk55S3E3L2U5TVUxd08zN3p5SGpJY3JQNjFxWTBzWUd5bWdG?=
 =?utf-8?B?b0RveXh3T3lpOE9RV0hVSldqNU95TDYxRmYxNFpoKzFHbXU4VW1qNGJxVHJP?=
 =?utf-8?B?Nk9BME1FdkwvLzVWSFJNR2RBaFFVNVNaQ1kwVUUzQ1k2aDZjdmR1T01kU2FC?=
 =?utf-8?B?a2NuOHQrd0NkNjczakgxQ0RjZlN2L2JveVFoajc4SEhNZEZOam5uVDFXdlVK?=
 =?utf-8?B?R2dSaEZYb3Z6eE9lQUo3bmZyL1drOXg2WHE3ZVZhTnpZWGY2YythS2hpSGhn?=
 =?utf-8?B?SWtNTE40RjlwV2N6UHkzYVhiend4aGpkK2t3aHo5VE9lRDVVVG1hNGlxZk9t?=
 =?utf-8?B?MEw2aThiMjRJcms3SHlRcXM4RDhnWUQwTUhMaDJ0MUtzWkhHNVBNYllwTU1F?=
 =?utf-8?B?M1RSdWhXVzluRENxYmZLYmFBOThEVC9Ec1hkU1FUWlhKcTJQZFYvNDdTcFNB?=
 =?utf-8?B?MWlDb1B3TENZOXRqY1kzMjl0ZG9vSTdNcWdUMU1NN2lmdUtWSmx1OWNqNXdT?=
 =?utf-8?B?d2ZqWjhUT3h4RWZqbXVaUmNpMldRbzVPMEZKYjFvK1dHUkFobTg5N1lNV0ZK?=
 =?utf-8?B?RG9uejRBRFBCZVJrVXJEc1ZaZkhtc2VoYjBpREY0a1Q1ZG5LQ2pqMTRXQkVz?=
 =?utf-8?B?cDhPRTVYaW4wZVJsU29rQjI2QUFBb0pIMVBPTEZsSXljNnRBOXlvRU82OXNN?=
 =?utf-8?B?eHdNVUR1RS9nd01YOGFvVW96dk1TdEN1cDRVbE5waTR3bnN6a3AyYm5iaXFq?=
 =?utf-8?B?Si8rYVA0cjhTTklFbWQ1TmhmbklkZ1pYbnFrVW5JbU5yRFVYbUdLRGltSU9t?=
 =?utf-8?B?cEppKzREQnRzWmhrc0hERldwOFZEcktVQUlTSitrMHFRVkhOM25PZjhDK1po?=
 =?utf-8?B?dnBFT09xd00zcExsUVAwVUdQaS9RWHlGNUplSkV3S0NyRlIrcVllWWRCWnc4?=
 =?utf-8?B?RFVYME1zM1hWTkU4Z3MrTEV4a3NFQlowK2ZsZk5hN250anJTR0N2YUViZ1V4?=
 =?utf-8?B?MjZvMTQrV25hRkptZWxWblJkSnJ3UGNCMTMyTVByL3hOZFFBcUIvSnM0d3ZI?=
 =?utf-8?B?UTNWTlpxd0V4VWlRMnBlS1FudDRBYm1YZHdEczdwaXI0YmQvUTVSbzdZMEZa?=
 =?utf-8?B?bStZZ1I3TW01MWN4RHczNE5EUjZpdWZLQ21ZTUp0UkhzZEkvSXE1ZEZhYUpR?=
 =?utf-8?B?LzRScEZoNzB0elNINlpIbTlKTzY4bTR2N2E4bU0wWlNBVDdFNE96T3BJQTN6?=
 =?utf-8?B?Z1pObGxBeUpteFdVUFYvSnI5U1JnYVVKVWI4ajdHRDlWWkRuVWN4TWRkVTdC?=
 =?utf-8?B?YzZMQnpOdXZDQjRVcXZxbW56QXR5dEM5UUJ1b1B1d2tEUTgwZFJpOTJnWE03?=
 =?utf-8?B?VmpZZk8zLzZ4Umh5UUdWZXgyZlMyRlFKZTlJcXFzY1l5SWU5S2c5TG4yYW5n?=
 =?utf-8?B?bVdSdHJteEliWUYyK1U2TUxMcXFaTlVOQXVNUGVtY2NxUlVHaWRyQmpXOTU4?=
 =?utf-8?B?ay9uRnEvY2J4cE0rYWxRdVl0TjNPdlA2dUQyeFczcGRYanRXYXgvakwvcXFN?=
 =?utf-8?B?M1JIWHN6K3hGY1Y1N1RrU0E2L0RKUDV1d0ZxU2Q5Z25qbndVNTk3TjlLRmE1?=
 =?utf-8?B?WW00eGVqSjRCeU1sbUlQeFczQkVFSGllMnNWdmpCV1R4ZmpFa2lHN2h1RnJL?=
 =?utf-8?B?ZmRmcitxd0l4QmxqTE9kNDJjQTY4NW5EeG5MQjhQd2lBcmhzOTMzY3RrTVVY?=
 =?utf-8?B?MTFkL3JSNnIwRmJRWEVqVk5kR1l6Q1JjL2dLenZTLzNxcUN6VzloUlNvSFJz?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1592324-0bcd-4799-71d6-08dc483d2c6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:51:15.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DURj8Fg09ec7pySKsy3TcYGSC5PkIbPeCE3W6tcRl6WjikInmB9eMtthiovDvl4LH+i8IHIbp2gsx4UBqx4qOdX8oKxTsVzleegIFUaHELQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com

(+Maciej)

Hi Tony,

(Please add x86/resctrl to Subject prefix of cover letter)

On 3/12/2024 2:42 PM, Tony Luck wrote:
> The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
> that share an L3 cache into two or more sets. This plays havoc with the
> Resource Director Technology (RDT) monitoring features.  Prior to this
> patch Intel has advised that SNC and RDT are incompatible.
> 
> Some of these CPU support an MSR that can partition the RMID counters in
> the same way. This allows monitoring features to be used. With the caveat
> that users must be aware that Linux may migrate tasks more frequently
> between SNC nodes than between "regular" NUMA nodes, so reading counters
> from all SNC nodes may be needed to get a complete picture of activity
> for tasks.
> 
> Cache and memory bandwidth allocation features continue to operate at
> the scope of the L3 cache.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Changes since v15: Link: https://lore.kernel.org/all/20240228112935.8087-tony.luck@intel.com/
> 
> 0) Note that v14 Reviewed/Testing tags have been removed because of the
>    extent of refactoring to catch up with upstream. But nothing
>    fundamental changed, so everything should look familiar.
> 
> 1) Refactor to apply on top of Link: https://lore.kernel.org/all/20240308213846.77075-1-tony.luck@intel.com/
>    [So base commit is either tip x86/cache, or upstream current merge PLUS
>     the two patches in that series]
> 
> 2) Add patch 9 which adds files showing mappings from domains to CPUs
>    Reinette suggested this, James thinks it duplicates information
>    that can be gathered from /sys/devices/system/
>    Discussion here: Link: https://lore.kernel.org/all/ZetcM9GO2PH6SC0j@agluck-desk3/
>    This part is a nice-to-have. I'm fine if just the first eight patches
>    are applied without this while the discussion continues.

I agree to drop patch #9. 

The core support for SNC continue to look good to me (I just had a few nitpicks).

What remains is the user interface that continues to gather opinions [3]. These new
discussions were prompted by user space needing a way to determine if resctrl supports
SNC. This started by using the "size" file but thinking about it more user space could
also look at whether the number of L3 control domains are different from the number
of L3 monitoring domains? I am adding Maciej for his opinion (please also include him
in future versions of this series). 

Apart from the user space requirement to know if SNC is supported by resctrl there
is also the interface with which user space obtains the monitoring data.
James highlighted [1] that the interface used in this series uses existing files to
represent different content, and can thus be considered as "broken". It is not obvious
to me how to "fix" this. Should we continue to explore interfaces like [2] that
attempts to add SNC support into resctrl or should the message continue to be
that SNC "plays havoc with the RDT monitoring features" and users wanting to use
SNC and RDT at the same time are expected to adapt to the peculiar interface ...
or is the preference that after this series "SNC and RDT are compatible" and
thus presented with an intuitive interface?

Reinette

[1] https://lore.kernel.org/lkml/88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com/
[2] https://lore.kernel.org/lkml/SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com/
[3] https://lore.kernel.org/lkml/SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com/







