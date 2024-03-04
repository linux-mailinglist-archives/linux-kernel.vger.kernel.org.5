Return-Path: <linux-kernel+bounces-91394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C33D8710E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFD1C220E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D57C6CE;
	Mon,  4 Mar 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzIVFtgG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2027D3F4;
	Mon,  4 Mar 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593684; cv=fail; b=A+Uy0E3cAOpYnqyCFiARa0XrDsjvlSNms7DvzKzbfeWYvRdgWwxnRF57fgidxire5LX2U1YC1feDVZicj1L5B7Y8khck48wXOAEmvSy9dOOjgVn6FFK7TqaaXNap7n4Aw2q81FSOFpY91l7OhyYw3MWDV5mk1mlBZa9IjdNGnKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593684; c=relaxed/simple;
	bh=loBZPWgHzWGBZ8iRlTxM0OSSvxIKltSNg2wmJLZYcBM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JzntNl+vg3iUKpywz3x7nQKQ1CNKGp4QSUS+4TCeZXwNM/pg/PpYNxQiSdNndnke7UKd4Ue9BFPrBI1ZvGFVEICI3oEg9DJkgLxbY6RDRiNOmTqgTupG48EUJujpkJn6dx/aQQCS8Z6xMmlV9Qu+p5dUUwk23uFjx8F5ETZUgys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzIVFtgG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709593683; x=1741129683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=loBZPWgHzWGBZ8iRlTxM0OSSvxIKltSNg2wmJLZYcBM=;
  b=bzIVFtgGBNWL1aZ2QJ3hx7wPz6XGv8I09S2ZL4rxnqAvaNhjcUfSh0dp
   eBng58tJKIF421YtopNir4CQ5sHBrEr2ystOxSd9ox76ZyjdQofnMWivI
   rh1pJ3WS2dA1D6miJb6oeSEuGk/7XzjH/4WMzwOYOVDaoMoHSwKhvoE2d
   kQj9//b9YHmhY1i40MqJpIKNWtI/Ruxg6sX4vhIYITTGzXK50KjqGJAsu
   ZUQ2ux/upuOCUecs0A2KqA2Vkxw8e8CZpRQ3UXa/MPmfZv9I6G/crBX+b
   kTf7rrzIL/btkKY3hpjqD7Q7PAUCYm7/ZtOwtrY0wuBw1LCASDAFxNHA8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7933485"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7933485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="40029775"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 15:08:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:08:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 15:08:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 15:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu8vY7fbQOZ+bMN1eLWckv8e6vPQzup8MPIToDAWPCkDaaqiXuibjB7wC9+eoT0cra6gIzogmrIgxJgTRZ/8Dp2TN3moIscDs7PzQpbeFS5uWabsOXruFafrfG5igtOYMiyvpirXGPeY3qAkcoBk8q6ZGOFsE5CrVQJgdUD9HqBiShSvgL0gL422/0MaF4RjO3b1juGNLe9VjKpskh1NcVH/AtWksF1+09hSNIznYmEWgk9gEF4LOkUe4L2J0/XrdhY+TUqEVHsG2/7QtIUTMEISLojLILF07tFW6tVkCsoODJL35DGywPJ5lvtzcjlduKVY7zulHtzmnZ6UjjkRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8tgfN1iqvVgCh8h1tlSMwxOQqz0jd7KhJFTgxQOXTg=;
 b=nBZxCMvTR1lR55v1RUxlzQSIgO+Bo2szzTYZVe1ajLHZKvYJwWG0FP9M+GH43WPOraCpeaNH76FiUsAr0CU2vjqJiE+Ln01riWUT/TytaWOUQ26igIBK+7oT8jSMrqCa9FcjCF8rwsgHUQCxSQ2edao/CZzBwK5RKSzKuA4y109hk2K8dwWR2ilVeS6z4S0d4LGn0g/o45CTlnIqAUVjvX/pI3GOxchOBLwr7nJq0WKqTVJL9oGK/PVrIMCqE3/IZ3A6nxn+VY1k7EmNSDME5RVlC6yUR0g2yHr3ShvOxF4nVBPTGBhk2JMq8l95nw+vh2PXsAUD9oT6Sju/n9nhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 23:07:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 23:07:52 +0000
Message-ID: <58c936af-b338-4951-97d4-4af9185babd4@intel.com>
Date: Mon, 4 Mar 2024 15:07:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] x86/resctrl: Simplify call convention for MSR
 update functions
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-2-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240228193717.8170-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f778cb7-f4e0-443a-9460-08dc3c9feb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbilV+yL8Yd/cnsNn1DyUBUdGUh/dQ5GbbInKZv+J5J24qqZq9AUC6+/QbDvZaDsm5DsDyimtrlGMHSyQJ34H8Tf7SuMQBbbqUo1edwublpA0yRCOVB2BZ6MxFxeE78S55lYQxcT2u8h4CSUG3k6yFU+24KvJayFJNX05J5bfdLSGBcrbqMVKoA0VwT1cgQN3664eQ7mpt355z6IENOqPeM9VzJXABQE1568p7eqPbgXHcprjjfAx0rNppRbaNU9DN0cUdJslDAlZQn1tPiTMkQqXY63exwkk9TS8IQLg+0nYblrNGaxxzH4J9pzcpJKXX6QeEA1KmNIj/XD5TQ59D9rtoyruBCk67b3LhHqs+U25H5ukbzwDNAPcWngEoixgHyCZD1g7lrUj03Yr6d5Tu3EARd10PsgiU8BBxIlO281Bl1Y5mfJwunc3gruC7NxRz+nYOxEfKmE/c3cc7eIYPrmunkt3gif2vg5xnuirW6EET9Juy2gDk+9BM5sDbcrYdcuPwOgKJ5ACenjHwcY8/Wsvlj2r8S+3VctjpvNOYIMAnfFFoUEge+lP+i0Uo5JRSKUw15hthe/mcVDXjcBfdjoMAksjnTVbGWAVMGsYaMQFGb1L8Jw0XQX8U7sJgrqud4Aph6ag+fCRZc2arcRqlTqSN7NCygee0B85HK/G9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVY2MjFZY2lJd1JSVElzNHhrZm5weWZxcytNRWJ6Z29ieTR1ZUpEM0VJT0xE?=
 =?utf-8?B?TFlKd0FtaUFqTk9hUXVpcG84d2w5RmxKZU5HQ2c3V0lzZUNIUzdwMnNFejJU?=
 =?utf-8?B?eUlvZm9FRE5BcFA0WmJyeHlnekpSeXR1TlFrblRlSzVFcExEK2FDTitDYWRN?=
 =?utf-8?B?ZGl4bDhHMjdSdkJRekpBVDhNVG5FMSsxbkl2NW85Y2U2L0grVFdCbkdnT29P?=
 =?utf-8?B?UVdFWlhQWlc3RzhMMytnTXlheTNEaDFONzdzK2tYQkVNdkx2dHVuQXBmZmlJ?=
 =?utf-8?B?NHRXTnhGZkNkTWlFNGQ4V0xvcTFSY3lOUmlxQ2ZtV3NtaU1BNjFkSFVPTTJU?=
 =?utf-8?B?ME5iUDFHVVJCZjkvdVZHalNCUzdsNU51K1doUW5CazFZMTltTWRKd3FNV3Yz?=
 =?utf-8?B?NFBqM1FNb25sdE90d25yK2RRZXIyUk5aeTFGUm4zTkdxS1JlbHpXZzJJeksv?=
 =?utf-8?B?YUtRTnlHR2FMdTNIYzRzcXJhamtLdVFDSDJiWnB1NmNhM1R6SzFTL1YwQnhJ?=
 =?utf-8?B?UnErdkN5MkRNZm9NUXhxK3ZJMnNPRHNSMFYybTVzcm5JZFpUS3pKUjVaM2Zv?=
 =?utf-8?B?WVFuVzBndTBvTjZtS2pXSzhTaWJJNU9ZNC9FRFlWdkMxNE5sckpnV2VDb2hz?=
 =?utf-8?B?L2VxT2t3T2c0R29nV2p1czRLTjRRLzd0ajk2M3FtQnJkbE84VVQ2VHFzUWVm?=
 =?utf-8?B?bzZvdTJ0M2Q0TDJVUGp0VG5WSHorTDBJai9vRTJGUGN4NzB1RUhHejNJY1lo?=
 =?utf-8?B?ZG1ORkwyVldxdGtjeHI4RkNkd0ZNMUZONDM2NDZPbzFBZlVyMXhUUEYzb2k4?=
 =?utf-8?B?ckg5eU5aSG9VSWJiV21ncXlrUU43eEJEOHdYK0JpQ3JzVWt0Ym1lZjh3T0NM?=
 =?utf-8?B?NWtmT2VXWXhvMDdna3FoUVZ1azMrUWZoVXhIS0tIRm41V0hhSHdRVnZDYlNU?=
 =?utf-8?B?bitSSEt3UGNzNTNpbnM3U3oya0c3dzNKMXR6a3RmYUo3VUdqT0xYcGhWaXlS?=
 =?utf-8?B?Vk5ka1pIMGVIZENBakI2Y0J2c09kK3Zxa0RuSXJmdUV0VHlrZ05VUHlvNG1U?=
 =?utf-8?B?Wk9LWkk2R2E5d2VjQUJUejdRMkhOTEIrTFhSRjdXTEFhL0JvZTBpUkxUYXdZ?=
 =?utf-8?B?eldVWEZRempkRlExcmlsaDJSbStjRXBXL01HNGFrc3N1dXZDUUpvcG1kN2RJ?=
 =?utf-8?B?eHhPNmc1RzNwaDlZZkUwcjZJQlc1b0xnY0xEakJ1dHVoVnorY1IzMDh3QTNX?=
 =?utf-8?B?dWFoWXkrTldLRzBZeFUrdEIxMGQzVHB5UDNxR2crT1JWdHBJQkVLZzJyRWsv?=
 =?utf-8?B?bi9mN1kvcU9QNGk3c2ZvSFJBNDNYOHhOUjdmU0k0bm5IYklFUjY5SHptV2Qy?=
 =?utf-8?B?VmpId3FFcXArSHJtVE9aOTlHeUR3U0thTEpMb2FhWnNtb3Qrb0c2MktrZmp5?=
 =?utf-8?B?ZWtzQU5LaXRzTktuOGZhTWNVWVVUZkJ0cVo5OHBCYWc0MzZFRlVRcjNmWlA3?=
 =?utf-8?B?Nmc0NEZYL2FVUVFKN2dTRVRzdkR2TlVoVU5HTnNpYVRzZm5MR0VPazhQcUR2?=
 =?utf-8?B?MTRhK09HTGpJL0dEMElVTmJBV1Q2MUl6QUlHeVRsdEtHNUdwWHpKSElZTFFx?=
 =?utf-8?B?UUJoZW9nZ08vMDhyQ3ljLzR3akx1aU1LeW5KYW9leHN2b0p0Tm5uaFhlTExO?=
 =?utf-8?B?WGFSZmJ6SnNScVNoT2M1YktLbXNYM1k2ZFkvY0FnWXhlSUl3eHlwdTFKRWlk?=
 =?utf-8?B?QU1kejVieWdERkNoQU4yTHpGVDB4Zkx6ZDZDRWtuU2d5QUF4ZFh4eWp4QWJ2?=
 =?utf-8?B?Vk5odEVRS0hqYk4yQ1RJcFBjbHl2d1Q2Vk0wVHZYNkpINUxRMmw5d3E1WjRh?=
 =?utf-8?B?c0pYd043Z0orM3p1Yko4bENBeDc4NzkxemhyWlhYQlN4YmZuRm5xSG90VjFK?=
 =?utf-8?B?NVMrM1Brcll0bWlEYkFiQTJlTzFhV2twM1BhSDBPQlNtc0RNem5Vblg1blBZ?=
 =?utf-8?B?dXo3S0F0UzVqbnE4dGg0YVVNSzJxS2QwaFgyYXU4V0VqckdNZGI0Sis3ODFO?=
 =?utf-8?B?c2xtbCtQSkhlYXcvT3F3NkxJaS9VVTNrb1U3MVRQNVpKODdUT25PQTliemYv?=
 =?utf-8?B?UFZFQmtVRUdKOHNPT09JZm1kb21Cb0NtdGsyT2J0akZBNys3QUVrRUd4UWdq?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f778cb7-f4e0-443a-9460-08dc3c9feb73
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:07:52.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owMEv+QLMwdZZSLNXx7XigTeeTXLi/Qsb7FPi2qn6mLM0NJMdffSERZfOpAQrGX3i/FyTnSWKd4nW4zUNasmcDNZtGeWHn6OFKxNroifyOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

Hi Tony,

On 2/28/2024 11:36 AM, Tony Luck wrote:
> The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
> and mba_wrmsr_amd() all take three arguments:
> 
>   (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
> 
> struct msr_param contains pointers to both struct rdt_resource and struct
> rdt_domain, thus only struct msr_param is necessary.
> 
> Pass struct msr_param as a single parameter. Clean up formatting and
> fix some fir tree declaration ordering.
> 
> No functional change.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

