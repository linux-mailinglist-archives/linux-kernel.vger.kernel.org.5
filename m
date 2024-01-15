Return-Path: <linux-kernel+bounces-25590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370CC82D317
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE16CB20CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E831FAA;
	Mon, 15 Jan 2024 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV+rTRep"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0C15D2;
	Mon, 15 Jan 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705285336; x=1736821336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SARjb8Su8F8iEtUVYRU0TtNH8VSMjDI13MW1+oT9hCA=;
  b=SV+rTRepNy/xlIMAzr4X2LHPwQ4trj77xnDH/JUbJEZuTU2x38J80BUS
   xebxnqOEmbi/lDRZh0d/bWYtGmW7ZW473YMNC+bwtjzxAb6Rp0MjyH1X0
   7zcIGrW5c86cFHzTIU7pr+//5ewhsAR10EXrrWTjehQ/4ohXZ+8hUDNR9
   CZI1tRfq8CqKnwkx9st9ovQWIDi5y5fpm6kFi5gjyX3nOtOEcKJ8XS6iR
   bYFch8EuibTCPTU7NsbQYUYHLSlw9MDDRoToJn7Ct07HrXeczoo2m2lDU
   NI0mfQshpYlyP8e/GPrJfBkfPJnFrlU8kv0t2AQBOfSQkOyDCmc6W3RHQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="389965467"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="389965467"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 18:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114797111"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="1114797111"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2024 18:22:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Jan 2024 18:22:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Jan 2024 18:22:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Jan 2024 18:22:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Jan 2024 18:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prs7d5Pdx7sUl4fdCHxv4eRpjMa4HmUVlMEByveOiq8rUoB4n7TndnMH5vFKJYuaqbtNyd4wUeLZfWvKfaw1UKGbNokFT/289I3pn0yKoJHGH8LkjvdjxlEACW5NYNqB5Yo9mpJSUfIvRCIWU3iCkH0NV2I/kbCAVcvxNrfnj3CpeeMjGom/JSn+IRsnf7PcaFB8Np4UvhlZ18kNq6xo9D6NX0wSmec5jZJLqkHUWyZakQG70MywwABbNBg362VnMh5xYRYuNvADsd9EetET1Jz7hdY2K8kzQPR5Nnuwb/fC4caZCdHf9efUc5rix3lL1hCM0CwLJ3Rmj9zzl+yhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtqo56+dm9BvPqLDuJKROcGE4v0MQL5KGtdIdVRx+IA=;
 b=lTT6l3LEjEHTFtXGCOpS9XMb3NORMNTMs4xl5NMxxTUL6fGmhmXNT5cG9pbBaxMkChCDi/oY5E0scRoxsBrVqUBKSXV/acKBfc6JciYSyc/4h9/ArWhMrhaQDTU+K3NAzo/JDEvkQn0CwpSx6Nf19ZXeuSrwPIdACj/jOBu3LqmPDl88/3BLcmFykr2bdhP+25mv9KBzfCpT0vec+s7HLLM5FsAyjBJh1hW+NH6+89/SVXVA9bKf7ChpqrY+HZBjLwW6kemYL6Td7xRQX7Cg/NV1nh9BN/n40iRD0m7bIgXBdke2eHo9jVckzwf/CbSH/u9SANUN9Kk95a928v7Rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 02:22:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7181.015; Mon, 15 Jan 2024
 02:22:11 +0000
Message-ID: <388ff39f-c4d5-4d71-8c5e-2a3d242d8bf1@intel.com>
Date: Mon, 15 Jan 2024 10:22:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [connector] c46bfba133:
 stress-ng.netlink-proc.ops_per_sec -97.2% regression
To: =?UTF-8?B?546L54+C55CmIEtlcWkgV2FuZyBXYW5n?=
	<wangkeqiwang@didiglobal.com>, kernel test robot <oliver.sang@intel.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ying.huang@intel.com"
	<ying.huang@intel.com>, "feng.tang@intel.com" <feng.tang@intel.com>
References: <E0375D03-BC1E-4F78-8D44-83F4E98307BC@didiglobal.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <E0375D03-BC1E-4F78-8D44-83F4E98307BC@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0edc8a-6852-4f9b-e31a-08dc1570c77d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjiC/yOvTa1B3qhhBN6XupXb9x+5gsDShZPkcZoANPjTtd+CXaSJyEikbwLXjaz8FDbC02HXfV0zsvBGmUD9vf7NIDGsMV8MlbcslBOv+tr1hbPoBtmxEWwGUhCqDu6/A7HEm3gBoO7QvKRfkKDRu3aiygkrGX7vo2FaZD1hBLYYxUMKIfdrBL4ROAxQPAgNYJuf0skAf+DooAffYZJYQbMOR0gTCOx6VRpWRFPGclwLRiNAS+Tqe0l6iYpBkl3kyeu/2aebJkH+eeabtVLBfKphgpLFsWvXDImnI1graaocWl5xpGblzAweH2JT85lWaFIhNZPx3S3Xh98WpZEVSEYP2I0TZD3sXnXTtvMcEAlk7YrTZ8KGUuATMM4k1FoUBoRTrEXXFxFSUsmOiwSjudAOw/dkAIEfL0ANZEIrSe1WbSPu3N2KwvBeYIgQT3S5SyksU0gspBrLAdbDwxY8zfocfIkYhHS4zlyvoCvPWRy2XVDM++ER3sosJbMV+D5XtCtE02hcdaCp3egyOHOSHfrbqphQIzXoIjuSF7IBhhd28X7orWLuzPo00JvfMABNnp809zLBVBYI0Rwctrp5Y51RTKrM1OjBAYfVr6d+mTYx/uLxvda4lf7Hc51sU+bAHaoB4Z/uKRihm9g7i3clpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(82960400001)(2616005)(26005)(83380400001)(36756003)(38100700002)(31696002)(31686004)(107886003)(6512007)(6506007)(6666004)(66946007)(66556008)(66476007)(110136005)(53546011)(6636002)(316002)(54906003)(2906002)(5660300002)(8676002)(8936002)(4326008)(478600001)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akl4LzFyNk5KZmVVSTR4cWdyN1NkdnhsUlhLdUNkaUZncmxaTStoSFk3MVVI?=
 =?utf-8?B?MzZLZlVPNDhTQWRoYjkwNktUVXBTcUdURDlFYVJGNXNKVExZejVIU083YmdT?=
 =?utf-8?B?dXRHVi9lVStkRGs0K1Z4Sm1DWi9iYkRyT3YzQnYrYmlCYnpBclhWcjdWazQx?=
 =?utf-8?B?T3lXUmEzbXlKQmJicXlZeVJwd2ZmdEdXeDhOdFFucUxjamNRMW5ZaVI1bjVn?=
 =?utf-8?B?eUplbGRqbTl5VHUvc2tLRktnUjVzcThtUHRPYkdVdGtUcE1OZ0JYSDdiVGN4?=
 =?utf-8?B?aGdKQkZWdGlhSkt2UjlVTTNJZ0FSQzFTY2hlQTgrR0NhTjJIZHMzc3d1Nlh3?=
 =?utf-8?B?OEJuSU8yVHgyNE9iQUZzaHVwcXVpMjhoRlk0amNWNFZKaVZaSFF2Yk5GVXJF?=
 =?utf-8?B?NmlydTJIN1VkYVV4dG9aaVgxWkNOemhOLzE3T3NWU0hNR29ETUhheXN1UlNJ?=
 =?utf-8?B?MitMNW5wbnZGT0gzNmUxWEhrazJCWkgzZEhFMnNCM2dTYVArZXZjbXhNbm83?=
 =?utf-8?B?UUd6M2tOZ0d0TUdBMEREcXM3Y1RoQXV6YWc1NEtFNTJqMm9EcVUxSDc5ME5J?=
 =?utf-8?B?TGFKZW00a2dmNTZKelVWalA2WDVTc0F6VHZ6WThCdEprREV3T2lnNUpCTzUy?=
 =?utf-8?B?azBkNExTNWpaTURHWkFqMHpYN2Z0bXIyV1hLYVhWWkhEVHVsVGJQSlJ0T0hr?=
 =?utf-8?B?aVo5TTFQWkZ5SHJsWE95YWxlSXJlRWd1L1RIRTZ1UU14bzhYRG9RaUdoVTla?=
 =?utf-8?B?eEYvY2x6aWFXVE1qcXRkR1ZuY1FyeTBmMXJuUDI2RHhPaWlHSTFoSHJXQWRa?=
 =?utf-8?B?U2QvOXN1SFR4c1Nmd1p1TlpuSSttekJmRXNPK1ZnQTJZMERPZlFWT25YMDNR?=
 =?utf-8?B?THpoOEhFQjNCMHlLTUE1ZmcrVHVnZUpseXdDaGc5K1VqeGhsekxMcHBXT1N5?=
 =?utf-8?B?T1NQZWRjdHVOblBnc2Vyd3FIRGFGSXM1YXVqQkpSVnljTlphTEh4OUViVTVT?=
 =?utf-8?B?SmdVbGt1VzBaK004Wi9zeVpqWXlXT05TLzNQT1hBQmNGZ3gvdUVNdFFtSkNp?=
 =?utf-8?B?YUZKeWh2WnRRWmtSZXhaVEN1d1Z0clh2VDZDNjVFY0ExNXlXTEtnblhudFJ4?=
 =?utf-8?B?SktzQ0txK09lQ0lXa2JvcVJXWEZneGJkd2J1a1dTQ3QwY0ZySTExZFNEMGpX?=
 =?utf-8?B?aXMrSWJNeDVpMmpGYVZSZVA3RlI4dXJWMXhjMHBZa2pRL2lFLzQ2bTVXanFR?=
 =?utf-8?B?ZDdkYThuRzhLM2x0MUpuY3E5TTVMVEg1RSszZ0tRZTM3SE1NaWdTL1ZHRlI3?=
 =?utf-8?B?S3FySSswMXk4akd0ZWVwQ3I0L3I4VGxpUHBuTHd0T0FYVVNtQmNNdDBFUDJV?=
 =?utf-8?B?cWdLNlNKZXpEbVNIRmNvQm1FR2dxaFNJR3dmbFU1SWpxL2MveWdodnRJL2h1?=
 =?utf-8?B?QlBLbng1MzZsczUxdWRvRnhXa215R25UNEt0emxOMHJRZGYwTnRFaVFQRktQ?=
 =?utf-8?B?d1oraCtrcWVJaHlCZzlEZkExVmkvRHQ1Vlg5bWRyNEJjWVVFazdsVWR6NVVl?=
 =?utf-8?B?N0RNcjdZTnF5Zm5wMC9CcTFVSTQ4SFlmZXBaN0RNTmpjV1crbVdZbG1uYkFN?=
 =?utf-8?B?ZWYxSzlaelZDdW5wQTQyUjZ1bzF0Qjc3VU1TOXlnT3NUVTVFb0hEQ3dWUjgx?=
 =?utf-8?B?NitVVS9DSlNkSFlIZHFsZXorbzc4TnRubjJ6VHQyREh0cEdmTDkxZTJIS0c4?=
 =?utf-8?B?bVNjaWxJNSttZW5MWkdPeU9sVXVZaGlobkZNS3VJS0VwOHJrZWZEbitITktK?=
 =?utf-8?B?NlF0L1lTeFdaak1zbWJoQURKSHdVVGZ4Vnpsb2F0ckIrQVFIa083OVBCc1V6?=
 =?utf-8?B?S0RMVnR0V3JZRFJFREJNNmFuTUl2d2RxRzlwekpFcVQydFFWN2N5T1JQL3l4?=
 =?utf-8?B?OTlvYjR3YUM5elpmTnEvdjlEcy9KOEZCM3VLUzBta214TmtyanZsWTYrL0ZQ?=
 =?utf-8?B?Q2VMcCsrN0V6MVg0bVJVN1p4RmxMc21mZk5sb1hqVCtqNVhyWlZRSllWcUh1?=
 =?utf-8?B?VHhqcnJiejBWMmhRTWxpV3Vyc2x2aTVlYzRzUDYyL0FpekQxUDhSV1FHWDlo?=
 =?utf-8?B?SHdCQzJxUDJQZDYwWnRmTHU0ek5vWldrQ0Z6cjNad29mcjMvc0dqcjRESVhH?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0edc8a-6852-4f9b-e31a-08dc1570c77d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 02:22:11.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkGEMrIfgWFrb1IjHblhTu/T1C7cvO1BsEYTf5K2EeXQRi92+EE42i5xXHTdbTxrtTbLoJ0pBb6B3Mpm+y5emQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com



On 1/13/2024 4:56 PM, 王珂琦 Keqi Wang Wang wrote:
> Hi Fengwei
> 	Sorry, reply so late.
No problem.

> 	I don't think this will cause a drastic drop in stress-ng netlink-proc performance. Because after returning -ESRCH, proc_event_num_listeners is cleared and the send_msg function will not be called.
> However, there is a problem with judging clearing based on whether the return value is -ESRCH. Because netlink_broadcast will return -ESRCH in this case. Can you try the following patch to solve your problem?
Yes. This patch can make the regression of stress-ng.netlink-proc gone.


Regards
Yin, Fengwei

> 
>  From 6e6c36aed156bbb185f54d0c0fef2f6683df3288 Mon Sep 17 00:00:00 2001
> From: wangkeqi <wangkeqiwang@didiglobal.com>
> Date: Sat, 23 Dec 2023 13:21:17 +0800
> Subject: [PATCH] connector: Fix proc_event_num_listeners count not cleared
> 
> When we register a cn_proc listening event, the proc_event_num_listener
> variable will be incremented by one, but if PROC_CN_MCAST_IGNORE is
> not called, the count will not decrease.
> This will cause the proc_*_connector function to take the wrong path.
> It will reappear when the forkstat tool exits via ctrl + c.
> We solve this problem by determining whether
> there are still listeners to clear proc_event_num_listener.
> 
> Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
> ---
>   drivers/connector/cn_proc.c   | 5 ++++-
>   drivers/connector/connector.c | 6 ++++++
>   include/linux/connector.h     | 1 +
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 44b19e696..b09f74ed3 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -108,8 +108,11 @@ static inline void send_msg(struct cn_msg *msg)
>   		filter_data[1] = 0;
>   	}
> 
> -	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +	if (netlink_has_listeners(get_cdev_nls(), CN_IDX_PROC))
> +		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>   			     cn_filter, (void *)filter_data);
> +	else
> +		atomic_set(&proc_event_num_listeners, 0);
> 
>   	local_unlock(&local_event.lock);
>   }
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 7f7b94f61..ced2655c6 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -120,6 +120,12 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
>   }
>   EXPORT_SYMBOL_GPL(cn_netlink_send_mult);
> 
> +struct sock *get_cdev_nls(void)
> +{
> +	return cdev.nls;
> +}
> +EXPORT_SYMBOL_GPL(get_cdev_nls);
> +
>   /* same as cn_netlink_send_mult except msg->len is used for len */
>   int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
>   	gfp_t gfp_mask)
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index cec2d99ae..c601eb99b 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -126,6 +126,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
>    * If there are no listeners for given group %-ESRCH can be returned.
>    */
>   int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
> +struct sock *get_cdev_nls(void);
> 
>   int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
>   			  const struct cb_id *id,
> --
> 2.27.0
> 
> ﻿在 2024/1/12 19:28，“Yin, Fengwei”<fengwei.yin@intel.com <mailto:fengwei.yin@intel.com>> 写入:
> 
> 
> 
> 
> 
> 
> On 1/11/2024 11:19 PM, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> we reviewed this report and Fengwei (Cced) pointed out it could be the patch
>> breaks functionality, then causes stress-ng netlink-proc performance drops
>> dramatically.
>>
> Just FYI. Here is what I observed when running
> stress-ng.netlink-proc testing:
> 
> 
> Whatever with/without the patch, cn_netlink_send_mult() returns
> -ESRCH in most case.
> 
> 
> The following is what the cn_netlink_send_mult() returns when
> stress-ng.netlink-proc is running:
> 
> 
> ...
> 213801 213801 stress-ng-3 cn_netlink_send_mult -3
> 213801 213801 stress-ng-spawn cn_netlink_send_mult -3
> 213801 213801 stress-ng-spawn cn_netlink_send_mult -3
> 213801 213801 stress-ng-wait cn_netlink_send_mult -3
> 213802 213802 stress-ng-4 cn_netlink_send_mult -3
> 213802 213802 stress-ng-spawn cn_netlink_send_mult -3
> 213802 213802 stress-ng-spawn cn_netlink_send_mult -3
> 213802 213802 stress-ng-wait cn_netlink_send_mult -3
> 213803 213803 stress-ng-5 cn_netlink_send_mult -3
> 213803 213803 stress-ng-dead cn_netlink_send_mult -3
> 213803 213803 stress-ng-dead cn_netlink_send_mult -3
> 213802 213802 stress-ng-wait cn_netlink_send_mult -3
> 213801 213801 stress-ng-wait cn_netlink_send_mult -3
> 213800 213800 stress-ng-wait cn_netlink_send_mult -3
> 213799 213799 stress-ng-wait cn_netlink_send_mult -3
> 213798 213798 stress-ng-wait cn_netlink_send_mult -3
> 154697 154697 stress-ng cn_netlink_send_mult -3
> ...
> 
> 
> 
> 
> Looks like it's not accurate to reset proc_event_num_listeners
> according to cn_netlink_send_mult() return value -3.
> 
> 
> 
> 
> Regards
> Yin, Fengwei
> 
> 
> 

