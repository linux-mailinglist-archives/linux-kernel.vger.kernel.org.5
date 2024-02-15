Return-Path: <linux-kernel+bounces-67411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A2856B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671BC1F2671E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC61C1369A8;
	Thu, 15 Feb 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miJoH9Bz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BC13699A;
	Thu, 15 Feb 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018298; cv=fail; b=XIVJhqq3XeO96DcK2iJzbaRU0xdN4q9UB0a9+13mt/CvVN070LvHA+8vRaiBTUxGZJUAOOvk6Hl6aSOYheA3QhdBfOwhaIByzmxMcyvlvWBEuYWP84r/rYEDdWNTNs5lwCIszi2Og31oZdlLBkalprMNzlj13dv4SanquM8ViJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018298; c=relaxed/simple;
	bh=B0GKF4/TsMlKD8uhgnqOTVrRRZfvlR2R5C60nI3Ax3U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dp+mu67K/PZstA9vF3SeQaIIxXTZQx2EU+QGUVggbBEXzojC7MORwKzH31l1R/z7UUveTiyQVwOoh1hZmxJT5VOuR4HovVA2+H9rh6SAP5z8JM+VM/SOVlKDWehe4bJQxlgvPF8Hktxfd6AX5MO7ZDZrVYaWX4Krsxot3bdxMb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miJoH9Bz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708018297; x=1739554297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B0GKF4/TsMlKD8uhgnqOTVrRRZfvlR2R5C60nI3Ax3U=;
  b=miJoH9BzKzX5FDJvAbzG+AVT1VXdMDkTQLjwlUyHR7V6qY1DZE/Ym4TN
   ya1U08Wzmz0NJo0UWrWxh2Z+hUcNxTvZxgF5IHRkqjWloRLn8d1P9Qljs
   lVnkwS8A56Lf4l+Kw6BYox2ieqF4nuBQYKzbUGTyrY0SHSbZJesSt2CkD
   DgOM9aoFyj3BvCpuiljLEUE8pM0mLqcHfoVX+BMln0n3QleLOzg/rXCW4
   8aqcmnbA31SWmoi7zrQUndpJT0MqZk3tJHXCyrR9DW20Psmd3kydBwQcK
   LQxICpJ/Z3SY33J3Ju6L5Wr7nIzRqzTRJHViaFdih+wslotNUID3Y3YHC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2261165"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2261165"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="26751199"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 09:31:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:31:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 09:31:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 09:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZE9g0dkNxXcHDDjRZM8hRJemQQ6Ttlr7ynHtfk4l59ZNSGGKDDQvTkMZ4eKAH4IxulQloKciJ/x9jSi0KXNGFmHafBgoviTihZLHcdH12hW2JKULcFPv5UP5n1NpOSM8t/XfmhVh15oOTpWeXgn190qIsvFBmzERWikqGax5gQEIAUaavgqZXIoZ2dOkRiUQRnsOuauyXXEEg+fzp56fpOeJqPY8YZo5YPlFyPcVFxQfUrr2NbmLiSijBdzYBEK+djEVZaruOgu3WIwV0dT1OB8mXefoEbZvR3ggdfGnDDRqCaAV27AjbiyxfG5+E+jUgs2/kT142XBdbSjkK/vzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=indF4ax8QfuumrmsXnF40xYuRydYyeF2gd4E8/SPnf4=;
 b=MwHo8bnUiP+9oMOEM6FAiI9a23xZLX+vJT5aiWIcBOd231hLTi90QvzQmVbzUG1Xha8x/wgRpjSq3GHBBBYsFWF6/06ODaqgG3OTwWNlqVW3bztkdnaPOaZuEboUQYH/qQJRLz/Qu0EVekuZmjU3HbmsdTw16RN/3HWs4vdOKW5WVNxfCf9coPS1/XD91dUv9TVFyPS2M2AujcNLdXFZXhyWAd9bYHx+VCuWaP53MKrc4LHWWiq/E3n6DyuJH3U4L+q+EJtOyq/6wl3Ss5Yru3hsnMpHi8MFma+ntQQFyV2VgewH/sQIv1N7WwvC2iAIYFYToDvrBUxE3AZsTgmK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5362.namprd11.prod.outlook.com (2603:10b6:610:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Thu, 15 Feb
 2024 17:31:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:31:23 +0000
Message-ID: <ff53b219-201d-4544-ab37-014286c299ae@intel.com>
Date: Thu, 15 Feb 2024 09:31:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac: fix initializer element is not
 constant error
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, <linux-kernel@vger.kernel.org>
CC: <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240212154319.907447-1-shiftee@posteo.net>
 <44c29a45-86fa-4e41-b4b5-e69187f0712e@intel.com>
 <867da21e-7f30-4caf-9f78-260d426e4186@posteo.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <867da21e-7f30-4caf-9f78-260d426e4186@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: 964a4f6d-07b7-4b5e-1781-08dc2e4bee5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scHkQGDUxh3aKodRyyomMqGSYssf/xnIQLQKigJVsGDoV7wWvnSrh8sH19SGFoV5JNoO2T3n58ztSytTVtELjJ5A9uAnH/Uha9vZ0vF7KV3hDsT0bn+TC8VLp4fiYy48aoeQemnTa54Y5WwbkLi8LS7bfqwE5QBW9KpMTAlil3JSvAfn/Z1vF2ydFZPU9+MQPAOwVrnHq9ohhoQO1kkCs+GORdx8bMT6SQ6kCWuIGk1emDC6udO1d+5U4CpRReF7lHaZbVcX2ODCB3gnBwD6wJnV7VaxFiuhANdmdBZQfbxzpxDwVm9Pest1sIvqhMvGVC5rbp5YhiOZE0zSzvxFyJSLRChCPJyVgIVjJMqW+DSzYJucBKIP9wz+zsRJbB8JyE5eqSvHXRxCxpAy3KDdU4mffKfckyjzNi4rCSGy+GjzehQI7OvyC4WrhfvxJCtIxJJL+GpFYglEf7oXV/vx6hrrOT7yQiFtcS5qWa+e2pVhj7Ri63AZ/O3MwERHAU0e/xt+A+I2OVKxQ3Lii4MVA7Ns6WeZzDE5uemBo6IO8lu1HJE3I12JJLNjs5sV3e9/FjgQOW+XEbgffZBZFqmDHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(26005)(2616005)(31686004)(8936002)(4326008)(8676002)(7416002)(2906002)(66946007)(66556008)(66476007)(5660300002)(478600001)(6512007)(6506007)(316002)(6486002)(53546011)(966005)(86362001)(31696002)(83380400001)(82960400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNCQjNpMldSVFdwdVAvWG5qUURYYUFuSVZmY0VjUXNLQUUrd2dKN09nZjlK?=
 =?utf-8?B?MkMyTnRPd1VFS2dqaW1MN0FKbmh6QTVSRkxGcmxqQ3o1dlFWMDc0eTRVN05v?=
 =?utf-8?B?bEFLS0xsRlRjblQrMkE5MnFuRk8za0ZvRys2NVlET1BFb3I5K09lOEZPd2lC?=
 =?utf-8?B?Kzc5YnBabzJObncvcU00NVJFanJQQXgyWnNsc3dYek1wbjd0WWJJb0RjZ2E3?=
 =?utf-8?B?ODRJNjFySGlhS3ZOYmNFd1ZMSUZyMnhUeXVaRDNud0puQUhBUDVoVms1QUlz?=
 =?utf-8?B?d3hOM3VXcDNXT0FvblMvVDA5TkFTcDYzK0duVTlKSkhiOCtOR1VVVEVKcTdO?=
 =?utf-8?B?R0pmU1pSU2NXL1VtNE93ZXVSTlRoY2JUd2c2RmVpTzVsQkFkS2dvN1NvTDJ2?=
 =?utf-8?B?bHJhSnZXcWJ5YVlLMktrKy8xM0orZnBsZ1RqZWlwVDdoQnE1M0FsSDZVM3pZ?=
 =?utf-8?B?U1Vhd1BMaGg0OVRRWTdpTVczV1BSUFJQdVcxNXhGdWx2dFN4TE1PUTN2Uy9W?=
 =?utf-8?B?QmozTnRtQllqenZKTkMxTHBWSWtySktKQzkxeWtjSkxYZFZsM0RIRGEvK255?=
 =?utf-8?B?b3ZMMjlpQ1pJUGlrUUhId2MvYnF3RG9hTzNvcW5GVmN0NFpZM1d6OGU5a2gz?=
 =?utf-8?B?YXBhSEx3U01oa0N3UmNsR0ZRQkZiUmY0TkZINERGZnZiVGZ5RGxUNTA5eHZE?=
 =?utf-8?B?dmUwUm54bzA0R09BT09SVHpWalc0WkdPM0s5WVd0b1pvNDgvTHpaejZyRFow?=
 =?utf-8?B?b0pGak9ISVMydTNUbkQxdW5mQ0RHRVdzbVJ6eGNiRjdoZHRvVmtpekZoazVq?=
 =?utf-8?B?UEkwcm4zZUF1WFhDeURaRGs1aExieEpRZ0dIcVBJK1JoMWtsK2FRTHQvMzFa?=
 =?utf-8?B?OWc2dE0waUZYUVFKbmZoZEM5V2lURDYwWXRPSXp3ekVReWlaaDhXdFBsVlMy?=
 =?utf-8?B?ZjR2aGcreDZjUkdjYVVFalFJem52ZE4wWEtRL1hyTTV0VjErMzJVV0IxWW9P?=
 =?utf-8?B?STNLeGNJSnE2MGwyRENoZW5EMStCMFJ4OWprNXJMNVR5Nk9jYlRrZWJ2dCtB?=
 =?utf-8?B?NW05QkZiY2ZyNU14NmdsSXJiUmpyN2RGTjhvTlRlZnR6aU5GaU9pajlUNVNo?=
 =?utf-8?B?MkxqK3BvS2xLY1ZaUFVIZUNqVVBXOTdXOEptd1liUHhFckNxYTVyUENWL0h2?=
 =?utf-8?B?aWtuQ0ZsYlR6bGpsZkhCdzlkTzA0bkhwVytvdk9rNnFrZG1jdlhFSWRmNE9G?=
 =?utf-8?B?YjhpZHhWaUdMcHJScTBISmNramhnQXcrSW1WZFIzNU9pelVGV2NNYUorcWNS?=
 =?utf-8?B?T3N4TlgvNTd1QUtLZEppd01nU3N0SW5TejlwVkpBU2ZLVUI4dE5KM1FnQmQ3?=
 =?utf-8?B?cE4weUVVN3h3QlVMLzNkWnZqWlpLSmJvSnhsN3JXM252YnJ3SE1LaXY1TmlT?=
 =?utf-8?B?SFloV3R4amR3L0x2emgvb05tZzlrVGZBSFpPWWVJVzN4a3hvRG1ZWGpidWVs?=
 =?utf-8?B?MTlZbiswcTFJQmJ2RDdZQXFFNnYrYW9ITzFieHNqVmRzQUYzdVE1ci91TjZZ?=
 =?utf-8?B?aG9obkVRZXErSlJKeTRCL1NmaGhab1did2FWZFgrWlRCOHUydnh4WDNtQzNo?=
 =?utf-8?B?VEUycmE2a2NkQll3TnNCYlhaSUYwRHd0ZHVVVVEzZG9sYTVpRXhBNDZWUjds?=
 =?utf-8?B?b1pEamlGbkNQM0s3dlh1N2lyZ3g2T3pPU0YzcUN3eWtsVkltQVc4czBCU0hu?=
 =?utf-8?B?TVpoOVhrclo2aTZDY01SWFdqV3o2UjVKcXc5eXovWk80aGE5THljZGF4Zm5H?=
 =?utf-8?B?czhNUTFEdDlZOVl4V2ZOVkEvS2hHdnRDZWluL1Z5QVpUOS9jMU9PSFNlT2ZJ?=
 =?utf-8?B?djB1SWl2SExBK2R6bjFzb1dDK3krQS9nOHZWb2ZUNGpHdHY3UkI0YSt1NE9U?=
 =?utf-8?B?RkRYaW5iRHlPMEdzMS9pb0oyOTYzdHR6dUEzMnA3emcyZXovZVZwc0xQWlhO?=
 =?utf-8?B?cHh6dkljVDd5Qjc4SG5QNGVRc1gwMkROYUd3SzI5UU1RVTBTMUl4QysrL05j?=
 =?utf-8?B?ZVdNMlVCZEtSNmhNblJLT1lZcTBZREtpWWJoRG5VbDV1anZGd0VOdVVTeU1E?=
 =?utf-8?B?KzFCSjNVZEN6a0dOV1JFMjZMOG1MaDR6TmdCRi9rVjBtWTVCSmpaYUhlUEZ4?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 964a4f6d-07b7-4b5e-1781-08dc2e4bee5e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:31:23.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWLrpM6ZLtnVSb4xAHmGxdMc5OjYOZZECTFM6muerc8N/5N9n70pKtMoTaksOaenyGPB60ksoPz8kj2AR4CDgqTSuJbUAhwhAy9uNp54XYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5362
X-OriginatorOrg: intel.com



On 2/14/2024 2:07 PM, Mark O'Donovan wrote:
> On 14/02/2024 20:31, Jacob Keller wrote:
>>
>>
>> On 2/12/2024 7:43 AM, Mark O'Donovan wrote:
>>> GCC prior to 8.x gives an "initializer element is not constant"
>>> error for the uses of dpp_tx_err in dwxgmac3_dma_dpp_errors.
>>> Newer compilers accept either version.
>>>
>>> More info here:
>>> https://lore.kernel.org/all/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org
>>>
>>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>>> ---
>>
>> I'm not sure whether the Linux kernel project has an explicit cutoff for
>> what versions of GCC (or other compilers) are supported. GCC 8 was first
>> released in 2018.
>>
>> The fix provided here is fairly straight forward, and while I do think
>> the benefit of using builtin types vs using the macros is nice, I don't
>> see that as a strong enough reason to hold up supporting the older compiler.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>>>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>> index 323c57f03c93..c02c035b81c0 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>> @@ -830,8 +830,8 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>>>   	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>>>   };
>>>   
>>> -static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
>>> -static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
>>> +#define dpp_rx_err "Read Rx Descriptor Parity checker Error"
>>> +#define dpp_tx_err "Read Tx Descriptor Parity checker Error"
>>>   static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
>>>   	{ true, "TDPES0", dpp_tx_err },
>>>   	{ true, "TDPES1", dpp_tx_err },
>>>
>>> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> 
> Thanks Jacob.
> 
> The minimum versions for compilers and other tools are documented here:
> https://www.kernel.org/doc/html/latest/process/changes.html
> 
> I am using a SLES 15 server to build, the first version of which came out in 2017.
> 
> Mark

Thanks for pointing this out, I failed to find it with grep. Useful to
have this as a reference.

