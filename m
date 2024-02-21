Return-Path: <linux-kernel+bounces-74610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF985D6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BD91C22920
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7513FE48;
	Wed, 21 Feb 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyARpOIl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371C3FB30;
	Wed, 21 Feb 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514679; cv=fail; b=IfHRl9u/mZF/kME6Dc87OxEJbgFpHeQkmyMBeWd+0Si7QxsL68jIvdR0fJRMD6nTm28ZRUnGta9m0m9YbhM5ovGY+6VJtoehspoU6aX6EEO3yyQO1V7JHATGAgT9kzmfdMxwKpIHmgy3kzIQRB/YL746iFUbF8A53q91XKXXK0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514679; c=relaxed/simple;
	bh=UkqcNQQ9VnRlVwGdlIhRjLsDLX+OjTiDfvR22cPTk2k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBXnuDj6GtVCnJz+ab/nQGn5yZf0FXzJLx6tNHOPEbSsFrXzq7k72RMBsInMS7M53hnpRS5rPCRagy/pwOP8bgRkq4bW1d/ceT5YLp4KQQI7SvwxuN3YxYBbv0sym19Q7pjqaHg+tUeJ9TWlvmmEQi6Zfdm1fNE42XNSe7RE0aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyARpOIl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708514678; x=1740050678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UkqcNQQ9VnRlVwGdlIhRjLsDLX+OjTiDfvR22cPTk2k=;
  b=QyARpOIlFJVDPJi8GAleUgk3eGnjOyUoz6qve11i+uw/5MMeyhjy5yrP
   QZpjAU/MKLpmRcKFD2aLaCK96+9vdBZYXQtlEPN3fOR37slNk6FfIVyKi
   LclHfioHzGlGMJK89H4qWOm86XhTs7i/u2ooQ0Z/KxAwgOGSCBg+h6dHj
   ZFG/EwsHZa0MaJS/O6um7tWl+NpAXY5i2T0RL09zhfyeHDEN3Lyf5JXdU
   TtALxIagI7rbbJ74q5JrHYQeHbZ1cjh/wiqtj9O+tmuBA6zARPF726URv
   iEf+cxdonWZSCpGk9sbogKuPEMXkB8VJqbgpZngSYKR5yRNJwQ7Y/jJO6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13789125"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="13789125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9693770"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:24:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:24:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:24:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:24:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRFmQnY1onymFn043q8pjMY2wch6+CoPmmpuwAhgMfl+KRnHmxo76+P79Oz6XNJI3HOgwWQt3bnpQNnb6CduaZC04Y04RFevXTo7WU6MlC8t/xwu9udP6OPVLhuSSMC2w9pOJ+Ve68BlS7wi/kEqL8FnTbZSqcEM8v3gOiLvcIlEwsFx3BcACsL8YbWa3xychufgykOUlEgIMWboG59nqs4eP+fe25RbuIyyM7101t0Cya3tFnglWvZq22OGLoG7La+G6E+ebTqH2BRjBQreKcbvqVZfxZgEWjun2aKSDbTaOLQ0Vjgl/cGGq0+VV5/JI5thppavVUwlcas2ohPIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDldMCS/vnFYFbM5UzgciMtwQNn8gEAQac3/PMm+uz8=;
 b=KCyilFzTJR4RZBxYRP7J3EoatH3yJ+3WjG1MrHcR6Z3zXMDGxLUxQfXxys0LmpMbWWeLYaWajZi1nke3EmHbv0dnMMNvEa/A+YoYSdVcaHmA/JXeFBBzEVNE3AaKBFh3sw4MwrGXkcO5ryAonc4LuGjjKwzC3ezIvXdVTVnEdP8CHpIurf62A9/Dcfh3UIG5OGriOkD7H2SWKwuIzTUXTOfTUHUarPm8A5+6g6w4f0UnGYoid8vc5o+QbHMVPHdh7TrlJO9NQOzUbkgNLgmoqsaqXz5Axwy2BMnt8BACUtz+iJUBRZKwGBjC6WSPlKH4++Lvnl6inZcmF4aBQdAGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 11:24:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 11:24:29 +0000
Message-ID: <a7f9e99b-e2ec-4acf-88d9-5d70de7b7588@intel.com>
Date: Wed, 21 Feb 2024 12:24:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-af: Consider the action set by PF
To: Subbaraya Sundeep <sbhatta@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
	<gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
	<horms@kernel.org>
References: <1708347314-21624-1-git-send-email-sbhatta@marvell.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <1708347314-21624-1-git-send-email-sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 01465829-66e5-4d6e-20b4-08dc32cfab57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3J4gxeZ1H1N7H8T4+cWEqWMM0tQGeNM/X8Df5WZbUGOs9jnNWpItKD1rfu0tBD5aPblJpxIQmMJ08d6Hm0RdtCYW7guZCq4bj/uLep9a3p1fZrA0sf1d2/kA/LtnwCMcxGy1a4PeDy7KohOjnspJ9hWSjusXk9kKAIv3ixSHD1vwxDEigvQXGU7AqKPywnflQe+q7fXwHWHUyvhzXKGs7AC6zf5VOgW6iCbs4WasLylXFg/wzhvf7LckKVOxLJHbexf0MdUmzRu52f/KDx0g0TdO2B2dbJOrejt48+tbj4HCxAuMNbq/sGbip8+CLK0dvvbdb/OXRel0AYT3BmC+fDLmx3ALOjZ4NWkVcZJAb4RXHtfWNXH3MvjMwgX1PVx3ilEkbYOEgdv5BsdErHcQ6AnkrIRO/sji2dNGmG7btdi8UEPhrBhMH0d5ePoEsQitMbfMEe4ty8PlM735ofdSpVCjVv3cuW3IyYP48JfBoO+koP5sB1AWFU4cVOHtvtUyfFPpPuviASWZldYPWFyTN2bS2EOnQLxLIAzEun3GAUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRDUFB5L1ptMkxuTy85bXZGc1pNNG9jUk9QOHRkT00wOXA2YzcvNjRueXRx?=
 =?utf-8?B?cnM5YUphWHZOTjc1Vlk2TWJHMUdWZVBXKzhZVmdHUVpYR2M0b2FqZ3hIUnJC?=
 =?utf-8?B?VW90dTRES1Jvcml3Umd1ZG55MUNFaHV2endneVFncHZ3WHA1ZGtKSnBaRURY?=
 =?utf-8?B?WWtpazRWeUU3VURmYkJWMWdVWGtXc09pTVVTR1IxdE5ST1ZPNkZHbzliSTQ3?=
 =?utf-8?B?R1dmZkdQVGU2YTN3Q3M3K0lOZUFOZGNZMEpsK2lQZE1ac2FJTTdwSG1QeDI2?=
 =?utf-8?B?SFlxdU5abnhnWmFEUFlnOVB5eFBIcTlqMmQzUExyMEU4d0FhYnUvQTJ5SzY0?=
 =?utf-8?B?SkhLdVJuU1lnUGNyZ2pIRlRTR3hPM1VkTkI4aXp2NDBuVytXODFHekVSM1I0?=
 =?utf-8?B?SHpoeEZtMVNOU1BqMXdBazcvdUQ5MUR0K21DRE1pTlcvYjVSY280aFhjQ21v?=
 =?utf-8?B?R3VuUWFnRTM3d2RpblArUGJtcVk4MEkyeFVzM2tUMGdVanJaWlN1ekJ2ME4z?=
 =?utf-8?B?N1VLZVVBc1c2SlZaeEFhM0sxZHRCMElZQk0wazF1K2VFMVN2V0pPN1RVSVdZ?=
 =?utf-8?B?OWdmTmFHSkJTL3hXa1JiZ3loSWpSaU5EZTIyK2JRTFhtQVhuRnFOSFRxd2xB?=
 =?utf-8?B?ZjVaZGdCVjk0d1NqTXc5UFhMU0M3b2xIaHVPbUdLMHF5c1JxU09Qa2xEV1JM?=
 =?utf-8?B?cEMvaGtJb1l4S2FwcU9BcjdWZUtkVXBuSExtbEU1VkxhWkZTSGdNVitxUTgv?=
 =?utf-8?B?eUZoMDBWNjFLRlJJNmpFVFY3TmdIN2NaZnZ2cUpFNkwxdDRUNHBaYzJZeDFt?=
 =?utf-8?B?R3hLS1hjK0YxMXVyc21zeGVwV2tLMmJLVHdPMFVHamFVcU84ajc2ejdRSEpN?=
 =?utf-8?B?NCtjMGtsQzh6ZXEzTHlWYk1LVzRVSnlMNWwyY3JpbW1mRVBRa3EvajZwZnlE?=
 =?utf-8?B?NWJRSkFIcWcza3RzR245UzJtZXpZS01hTjRPNGRpOXZoa0NIRzlvNS9kODhY?=
 =?utf-8?B?bjlKSDFpbVh5a3JqUXFnQkVVVlJhOWxyenJYYzRsL0g5UFNXOUthb1paN1pp?=
 =?utf-8?B?MnE4N2Evb1lBenpnSVhHaVcwWmk1S09HT3VtcHJOcUVnT0NObTlaU2IyK3I0?=
 =?utf-8?B?OUFZMVlrSDIyK0xmMStRZnpLSHpLYnVreDRLenI3OUdZRlNTSmFrb2RMSUJX?=
 =?utf-8?B?K3Q1L1hKSUZEUzNTTlg5dFcvSnVXS0RtN2RJWUJsb3E4amV2QUpXK0UrTk5z?=
 =?utf-8?B?TUUrNkt0eUV3MnZqZXpLcUdPQ2JtdmREbitxbEtGc3puaU0rQ2hCb2p1ZE9Y?=
 =?utf-8?B?SFJRbEljbS9ZWVFONzhDcnJheHZZNnNDdUIvVm5RUzFIOTI5UFlqblFyNktj?=
 =?utf-8?B?ZEI4V0s5b2JqSUJnQ0lFU3o0MVNMVkVJMytFVklqREhyV3g3NE9oZVhUSWJ4?=
 =?utf-8?B?THY1ZGNGV0E0cFRPV3A1dTZsTm94RHovK2YxcFVDV0pvZmVYZEVjSkVGTXBx?=
 =?utf-8?B?TFdRL25ybFhSNUU1LzhCYWRJQzJCVW9KQkZaYXExaUZzYTJHNHd2b29DRnhj?=
 =?utf-8?B?ZEgzNmJNSGhlY0ZYTnU4TVhaOVEreGlhZ2JIbnoxUUYwOFpyYjVCVENGWDQ2?=
 =?utf-8?B?U3BSNGtXNnN3TWxFR2U0eEc0cTc3dE5zNkV3QXBjcnJkWFpxTWQyUjJTQlB4?=
 =?utf-8?B?WjE1bFVNankrUUo4SkYwN0tOaUt3ZDdBVyt5OU9INGpiWnlvUTg4STVwcTdO?=
 =?utf-8?B?MXJnMUhqc0RWNHV4UVJ4WXVFWUFFbGMzSkMxdlYyeHc1N21IOVZHT002NGlm?=
 =?utf-8?B?endPd1pRb0RBMmJsemJxR2FXeEY4Z3d3QnBHWFVIY05KUmM5dEtXUFVha0k5?=
 =?utf-8?B?M3prWkVrYmRuM0E3SGszKzhZRk1uVjBBVkJGNGdSTThnSGUzdUREcldYZCtx?=
 =?utf-8?B?R2NtYk1ZWC81VDAxZGNWejhFRWUzYitYaHVHRS9NTGY3VncvS291RS9vTXVN?=
 =?utf-8?B?eGIvbzNzWnlveWUrclJ4WFZSN1NGL2JrdzF1cGVycFA1YUFaeW8xZ2ZBNXhh?=
 =?utf-8?B?SnZiM3dsRzkvZUk4TjErVDZZZi9yNjRCZWVXOTErd25TUXlCSmh5bUJUOFZJ?=
 =?utf-8?B?SGd5blNMUFJTWUU5aWNCQlc1VUM2U2UwYzlzbXRsdlVBN2U4RHFEU1RqZGY3?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01465829-66e5-4d6e-20b4-08dc32cfab57
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:24:29.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZOpXCTN0XHHcvrK4rLx4Y70kGrISG04eMG8w0GHq6P+mjpB88diI6f+YFkEkNRvv8KmoYFeP02tPp66r9I5m6JoSO0Uh2hdFaFk4vC5Iw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com

On 2/19/24 13:55, Subbaraya Sundeep wrote:
> AF reserves MCAM entries for each PF, VF present in the
> system and populates the entry with DMAC and action with
> default RSS so that basic packet I/O works. Since PF/VF is
> not aware of the RSS action installed by AF, AF only fixup
> the actions of the rules installed by PF/VF with corresponding
> default RSS action. This worked well for rules installed by
> PF/VF for features like RX VLAN offload and DMAC filters but
> rules involving action like drop/forward to queue are also
> getting modified by AF. Hence fix it by setting the default
> RSS action only if requested by PF/VF.
> 
> Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index e5d6156..516adb5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -415,6 +415,10 @@ static void npc_fixup_vf_rule(struct rvu *rvu, struct npc_mcam *mcam,
>   			return;
>   	}
>   
> +	/* AF modifies given action iff PF/VF has requested for it */
> +	if ((entry->action & 0xFULL) != NIX_RX_ACTION_DEFAULT)

this is a magic constant, even if nice sounding one
and it's equal to NIX_RX_ACTION_DEFAULT BTW, but it's incidental
(perhaps you should have two defines, one for mask, and one for action)

> +		return;
> +
>   	/* copy VF default entry action to the VF mcam entry */
>   	rx_action = npc_get_default_entry_action(rvu, mcam, blkaddr,
>   						 target_func);

Otherwise the patch makes sense

