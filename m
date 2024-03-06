Return-Path: <linux-kernel+bounces-94270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D240873C54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541C5288306
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD71361D4;
	Wed,  6 Mar 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTclJAI5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765D33999;
	Wed,  6 Mar 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742794; cv=fail; b=LwbWZnwdL+hoecWvlMtIMfhJcu8N73nrttpm7/0wfFTqP36lEM5uoCWcqguJbApj7ErNUq+FHW2oOm1uc4/nrQA2kF9FtEBdTiCZs1Fpuvrn0CZz7F5byEC8ol9wXdmdLAXd86SJk8Wi86L3NoUlcSH8jucdYbP7XiZRCsNS/Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742794; c=relaxed/simple;
	bh=8fgPbt53fAZvEfJEE9jHocwnsLE+sCihg6l2QS+mp0I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UlvWA18L8PycRh7xw/xWfDfW75WmFtlUnoA9NQ6VtGgER5gaubfsn+DrBQlU0N2oEm7qB3a1vLLUc4N5oaXOtW7oQSKQUctoMzy/qfHSXEj6LXhTAFgSy1n7Gw+5+d+Q4LvSXbx1AX2d7kMx0Vj4qBX16GouAB0m4aXKkj7DviE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTclJAI5; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709742792; x=1741278792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8fgPbt53fAZvEfJEE9jHocwnsLE+sCihg6l2QS+mp0I=;
  b=BTclJAI511ZXcmf7Ys7VZJOKWA/0DzJ3/bSJD+nS8AucX2TfZO1oGVRM
   hZKjUhiBR+bI4Z0O1QC27YPPyAnu1/0ezH7L36/skw872WTg24dBfTJ/A
   c5zIFWDrY+6vmrPiBApd+xHb86H5FY9tKLaEVZjTIHhnh9xhw2PbuuZB+
   XD167zxUVJ+FgdogFVTGMlPLXf9zIMnndCAag8hagzQ/AChD0g9FM0+X3
   ZFg7ktk0zv/cQ7WAsUiIluhcNdzph0U3H1FZLA+gYYEDdSwRUTUO+eqcw
   a2kG/vYp0QshHoQPw87P1o/GxLJWlJ6ak2xXbtUJZKwqA8+QrMe8EWAde
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8127026"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="8127026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9687097"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 08:33:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 08:33:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 08:33:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 08:33:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 08:33:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9AEtCeYVgxcvDDP03zQzDwO9fvmmE/GH6qiALm7WHtTaJHzok0+KLDaouqnjHDAD2FWYvWE5Ye5Rh5JFK22UpuAYtXHffG+4sCELw/Pk3P+QgfLZb4bgslDdc8FhOFE9wMUVbScCVlcE0/IOK2kSShA+Vr8qGgKJl+rlQUTlrqXfe7MGtcZmzno7En+XD8Qs+KlEulwTUUGzHGFA/+Krnn3sXDzpcy0QQLdWL+BmkEw6tVN4Gnibj2J3LkUKef/VnZwc0xKo3qsAhS2DozWKhDwq0A1bHnLGk+FEfIezUrhmW3XDwAUkMfYU/V2jk9J2R+dD5MXkxS/ywRT1rNsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYuUCCyCCK17B4BbXmosFgfIR/oEj0s3+o50VtzJRgU=;
 b=YjnXBcFJXnYNU7RBe9m4SSwhdmgb2B5waZXQgkRQSN0rFRg4sW+tGgh5BJz3dY0g2mHy5aCvmZxSCc/SgkTNKYnDcvx6t0FvnLrqa0LQW0/xQDLb75hGwKX93zP+7MrvPZZBnDqeMJXscIVNmkbFM4yIL4zsQ61L79mbGD+rdziGSR+yd9ZDOvoLnpc0BParTWqKr8r79vQ/cxhLE+yD8o0XqbLMU3GxIPRmTyf+xlvzycggOwoGeHv0D3VfVADO37gt/I1NGt1Hy8qSbbEj5W5DeqFJdi++J77Vmp7HTxlBOMaS7DAc2ZbMuT8Yr3feBs/WzMqbhqDq+7A7fuWccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 16:33:05 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:33:05 +0000
Message-ID: <5773af21-9241-3cc6-28c3-a756c3d876e3@intel.com>
Date: Wed, 6 Mar 2024 08:33:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next] Add Jeff Kirsher to .get_maintainer.ignore
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<jesse.brandeburg@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240306154703.1392919-1-kuba@kernel.org>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240306154703.1392919-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3cd5b5-501f-4e78-c7f4-08dc3dfb195b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB208fpMN/hQ9lMD4AQpz7og7rRVftNEZqM8O9jqgDgH4wN5itrx5ukAX4g+F4LSP1l1j/35JsQrQ38/wV2ndjvW699wigdGroNPWD6Wj2leaNWY/koAcbOZNj+5fQgN5EYSVHt28SSJqqfxTxv0ADLpZekyjFRi+i6BAJAILUEuJjzBG+YWXBqpPAI7XQS70vyE8u83kCFDPimvMFeuhSHmGCPb8xTTmKrXA/zq4vRAXnyyXYuRaN0ImTrtmlcdljZBmWq10UaYrXENkGgl+1aHQd8OyMb2Owq1tPxY6zgi0YaGxFeO55ysGifVcbx7Tzyp8TaXN86pvxmePmaOM3j4G5Uy3eiq3oWZntYTZHba9p0lxLUOTdghPyAXYFH5iCewBPLlRtP2J0GHZooe2AQ9hFqJA7P4EEkgcddqhUWgy50bfROpdO/FUduk1T1JxBnb8GYXBLcur5Giyyd7h63aFbmuRvpJJt6h5FNXjqSKR0GdhPjw2uWlZqtyywV9rMIHdoBfPdvtcasp1j8S2N1J25tbhCghHFrO6UltCL9aqxkew8waYiHkwn6tWgV2WkSujCaA8NhZuJkv7GgXAFxPM6LmWI/a8D6GhwbFs4op8UAqMreU64PWYp3LUOB0AlxQN9LBFDyIxHw91o8lfVdvs7aAN4WovpuTwbp634BYoac4nDFQh49TF2n92rsR9i3pUFTtCHuePmyuf58MGUJIkLKYtCHgyzaoC282pOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FTZXd4ODkybStoVGVDbGJiaEVUR1Bud1hxaXIvVU1uaWU0UzEyaGFXTGpD?=
 =?utf-8?B?dE1WOS9BVENyQnh6eWx3R0UyWjFxVHZpL2ZxL1NJT3RIeXQzMnlSQzVpc1pn?=
 =?utf-8?B?WTJOMnFUQ3kvazBSM05wcVJoUUJMeVc2SHY2NmdXelZtQm5GODhyMDR6SEV6?=
 =?utf-8?B?Yk16RkFBeVRGU0poZkF2SWZ0SlArSWtYS25ya2dpbi9TRUJwV3YrT2ZnR1Vj?=
 =?utf-8?B?cytjc2VYNDN0bHMxNGdMeUg3MkhwbmxWck13RUdpdE51bDV3SmxSM0RsWXQv?=
 =?utf-8?B?MjdZMWNVSVNjeDJmMVYwUmZPZ05TK25CZmlrMWhLV0U1a0h2ZlVuVEhodlo3?=
 =?utf-8?B?N1lRY3g2aWxhMW4yS1JQa25ScUIrdHdiUFRRVXBVRFJ4VjZkNnlnQ1dhYTNk?=
 =?utf-8?B?QlNLUkRnUlRSbTk3MzJNdnR5R0RFNXFNYnJoYTlmclgzaHpiWnVqcTdwZGNn?=
 =?utf-8?B?UEdTSS9tWWMwa2tlSVkvLzJHTHIyNmFQUjZNbjgxUS9uOERTYXFLTlZNb0pM?=
 =?utf-8?B?dFZVeW1MQ2EvZ1lRckhqdERNd1pURWUzQnpWaHZWMHZjMXIrcEc2THZoMlR2?=
 =?utf-8?B?Y2IxNkE3Q0dSZDN4RUQ3RUZUWW03SGJWNGxLb2VxNXVOYjIwdDdsb01OWHA3?=
 =?utf-8?B?RVFid0tQNlgwL1ZQalozM0Rmc3dUMnpsT2d0L3NISmc4dFNKbm1uV3gwQXp5?=
 =?utf-8?B?My9PdldVZjl5ZDc3eTNuK29veUZTa3ZWKyszS0EwU2lsMElGRjVzZit0WW95?=
 =?utf-8?B?VGp2Z1hLb2JscDdMdzhpcmpMMmNxN2JMaXFobVc4bnBjemRjMVc0Ui8ycFNm?=
 =?utf-8?B?ZVErK2VJRXBQSTQ2WHo3MU5YdmhSRmwwNmd2TTl1bFc3SEtjeWQwMWxHTElT?=
 =?utf-8?B?cWlIZmwzTjdTYnYzQmEvMlcvMHcrRlQ3TVRFL3B2TzYyaFZwUmRTR3laUUFB?=
 =?utf-8?B?ZURDY1d6Rzd0OE84RkdVL1J5blp2UzBJL0pSQkphREx3dTdoZ3lvcjU2djdJ?=
 =?utf-8?B?RDJBcHZKUjFWSjUzWityQ3J0dVBSNkJNRkczTERuOG5NZjlGZVZpZFRUVCtN?=
 =?utf-8?B?by9ub0dFQjZlWTdORGRJOWZMdDZnNkdWdTVDWTI0bnROVGZhQk43TGVrSjVo?=
 =?utf-8?B?TGp0ZkJLZ3JrWFVxdWRkRGJpTnQ5b3BVajlLd29SRDhWNWZLTGg0ZnU5cW1o?=
 =?utf-8?B?UzQ1aW1xUGdwS09vRWlnQnBoK2FMSjVkdzZuT2dSNHQyREVZYjF0YTZXRXhq?=
 =?utf-8?B?Wm1lSGtLU25CdjIrdVgrU01Pak1YZjFwdEdzU2l4VjF4N21qTHo1Nzk3MGts?=
 =?utf-8?B?YUZ2Q1I1bHFUUWE3QlExVVF3M2JBcm5FdkJQazZndmtIUXAwRWV6Y3orbGZM?=
 =?utf-8?B?VFJKTjlJNk5aMCsvWHJhNktiUWEycXIrb0ZtZG9wdEJ1cHljcnorZEhZREo3?=
 =?utf-8?B?TkNhc3M0V0UvSXJnT3BETXo2cldtMGx2UTZVbDZBanZRajRHVlRMdDNjcXFV?=
 =?utf-8?B?Wm9MYndXNVc4YjVkVXZpcnJCaWhHb0JqT2UrRTBkNFpNbURLNTl3YjYxbCt2?=
 =?utf-8?B?Szh6QlhodlZnZDlBNFJLMXYyMlp1aEdTU25TcGhBUXNINlhrS0pZalQ5S0ln?=
 =?utf-8?B?MkVVeXNXaVNnK013aEFzQ1I3SE5NdjBqRml2Yml3YlZ2MUZZQ1c5UTgwNXJa?=
 =?utf-8?B?N1o5UlhJS2RidFU3VUR5M1pxOUk0cFdvNFRudmRqRVV0T2ZvUkFZY3V0bmFO?=
 =?utf-8?B?RGlhdkNJaGM0WkdsL1dQYzRqNjI1bjdWSTN4UitnM0F0SVE2bkJ4aW8vSTFz?=
 =?utf-8?B?Mi9lNTl5MlllY1I3YXhaNDd3d01waWlKN2FzdkNERWtUazhRKzkwOElXMmVw?=
 =?utf-8?B?Z3g4V3ZzQlhINFVzYTluc0c2dldOa3p4SDN6eGtZUG5pVHJaakhEeEZIM3hq?=
 =?utf-8?B?UE9weFB2ZWFXd3F2MGU5cGRqcGlTNWh0c21DU0VSSFA0eW11b0lWZWpDeWN6?=
 =?utf-8?B?Vm9HZzdVa0ZKN2JXTUtZVGx0cVd2Um9pci80NHZpRWZ3dXZEdmtpdXZoeDJV?=
 =?utf-8?B?ZnBuOFhrS2hDTVpMVGlzOUNXaHRJNWZKUVFvbkZrZk5QVzRBQXZWdUNYUGgy?=
 =?utf-8?B?VDJzQ2t3Q2lPcGdVTS9BclBuRW0vdWdCUUk0ZFMveEhkSzgweUcvbVpxWElz?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3cd5b5-501f-4e78-c7f4-08dc3dfb195b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:33:05.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLbqbIu5UVfaCmS4uoLlIl1ML+pjbbbOu1tNvS7sqBmJoqYuVC3iMhRyi0zuBgAAaDQrFKgXEYFqvmQ26RIHTXOZOTMF62AJOd3aoISvPkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com



On 3/6/2024 7:47 AM, Jakub Kicinski wrote:
> Jeff was retired as the Intel driver maintainer in
> commit 6667df916fce ("MAINTAINERS: Update MAINTAINERS for
> Intel ethernet drivers"), and his address bounces.
> But he has signed-off a lot of patches over the years
> so get_maintainer insists on CCing him.
> 
> We haven't heard from him since he left Intel, so remapping
> the address via mailmap is also pointless. Add to ignored
> addresses.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>

> ---
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> CC: linux-kernel@vger.kernel.org
> ---
>   .get_maintainer.ignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index c298bab3d320..7d1b30aae874 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -1,4 +1,5 @@
>   Alan Cox <alan@lxorguk.ukuu.org.uk>
>   Alan Cox <root@hraefn.swansea.linux.org.uk>
>   Christoph Hellwig <hch@lst.de>
> +Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>   Marc Gonzalez <marc.w.gonzalez@free.fr>

