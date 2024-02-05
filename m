Return-Path: <linux-kernel+bounces-53825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B184A704
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930D9B26E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF55F853;
	Mon,  5 Feb 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rrgu2Q9x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E375F561
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161773; cv=fail; b=LedUuvoL4nNShZ+PD2Fgd2Yw1RF+gVDr1K8+gMtYMfulk7S5fHJc27qClPfxkrKKjbTpu0Gse0b3MFYYfjFns0T69UzQlYmbgWXMU7Iv9Xjfu8Fsf8xw3OpjUMlZ7srq9DE1OxqrZBuatvKtc4zprWEZ+y8c/hqySmR2ShPfZQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161773; c=relaxed/simple;
	bh=laFYIejDqAet4jcNaMbLXfEEnXU+vzm5v80qYvu6+H0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8hXXI4PVtSpB+Uw3ewjrnZ7qFyNcuueqhXAsQgq+fTJJcVqb0a8nSE0DdNiCu7ciHesV+6RIFHDz7TPEZDDGku9fxW+APw+sGeH103iz1n7NU9uxcyUc+OfOPSRsNcExPpwaR5ERHwFdSEKF2tAAZcGSQei6u1W8tRHHs01R00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rrgu2Q9x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707161771; x=1738697771;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=laFYIejDqAet4jcNaMbLXfEEnXU+vzm5v80qYvu6+H0=;
  b=Rrgu2Q9x3axVg6j6/EICd2rNoc6p78hR+RGM1pACZBlwSbXWJYFQah9R
   iiZIbzVYy1xkiTWMh3dD4bLl1X/rikmRjLNZ4+HstPT4HkTJb/vFAGn2/
   T50/H0Qnz6+OMJfYVkM49niB0D/zbCFItohBMIV1+MeQQuvEcLZGWj5mj
   LOx+A6EcixoE3/MorzpdwezDKHQc3pMJmyzcA2Xf7/hur+5knvuxfDcEU
   0rI05IQFfTO5/lStWqVAJ3knq+kXL/9f6cpHzDhverMzHUEe1AeieiYqf
   nvUOHYcczlBgrjjY+9K53qngf5jYKdjJXfeakzAkkRmq89cWOvEz7Amo/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="23071926"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="23071926"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5555324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 11:36:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:36:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 11:36:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:36:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmMN3NoJCnzS2sAp1z20CRaq3Bl8NFONStGdcbCzt9skAZQmnzLYaDjL27KTsdQ9bFMXrD3kwANY1n+X2Lbpm0G2mE34rRRzP8Q/6ckIuARt7y724i7Kx1yzzg5INMilRblK8rsQT3P5w836/GikepC//hzntK7JX2N0tCG8Yv0TVxafUeLj5NYFbNm0Cw/H6J/AeKV/myDMRqJ8zbmSi0GXdEW9/7FuXBJngLnRbdvARLOJ3xQkWoHkWmdP6gbjdsx5Y+nKkrY2Ipja17RYobSRLjbyX4DoU27hfs3CAKhaABdZ+Scjh9unM1ZWnSFp5ZKgUFFP0nGNfkDWCBgi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw45NhELFwazpu1JYpr57cjALiibbqwVeM7O5xhbMpA=;
 b=Be2AbO+3M2sMwZQFNnqPssP+N3x6/3PuxOiKsFDCs3uXkfDzv8ymKA2YOpH7L9Svp1A3PHXUhiONyp5vOThlxwku/nNAJWHpa5yjyOyU2EU2T28vfPn20XhIBMt9KaE7MCDId0W81xBx2ptjmyc0stg6q6D66D3cMtZdXate3xyQi2ObIZQN88LhTPss/x/1lFFCVPaags6Vm5efKmcQM5giXiM9LBXWH6JRP/IpHsWup4fNwuEekXOMRl6FJHAt060LpL/iO54fS0k2AOYsJSAmzPj0zxLQwhHN7HJ1uNA2PJ/Bu9UrS6nyFbn0WaK+b9ovHaUtRBoSEP8z1y0SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 19:36:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:36:02 +0000
Message-ID: <255118a7-73e6-4b7c-b3b4-c93eaa7cbdd9@intel.com>
Date: Mon, 5 Feb 2024 11:36:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Add tracepoint for llc_occupancy tracking
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<james.morse@arm.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240126130213.159339-1-haifeng.xu@shopee.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240126130213.159339-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 115b65f7-ea5e-46a3-f396-08dc2681afe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDI7w7z1st/wqb3iYI/mLTp4cg0cpKlyM4SHZdalx05kkx+p9xFkN8+PobzjnOZ6AHAjI8kLm9tYVkodisZvtXSpWOcdA9zQs+kvzeWLlHoBW6N19UaQot6X6tkICQTmGIDJ1TLLbGPikzZdFfbBw2/qHD9ymRfGk1uxyDDp/0Gny94c5PMdhdVptoLmDP3S+Kr1belsbl3WPhLKYoFfUxVYX5czJnhHH6YhAY3bl9NanwzfDv4zz+EGilJVPVxjFuQDPCuJ6VT5bEnp3PY/c1wCZfCQMA7+WqviZLPqUzhk15VrgDltJnwpG9UpPxWR181TD4y5tiFgH8BSF/k1vIEjEi+JDCJ1C93aJL4I32hHPjzUccA1/4Ax3yhe+GlZUTx63hXFWphewG1c1UmEnRfrCwRldFylkp1PIJTggoZV1BHus+sGu1ajrIDGjt2qh6khtxWjroQqCRhM96cmquNi16Myfh8CkUMWShPuiMhNuref1JRxlU7IXw0IVmaXoe+w9StnqAyVDlpDlQsaMc7ZH8kGH8PCR4k8snN8cFkqcn9WIsII8OlqQ0tZcb2R8+zAmtKVcxLUIzXon+Uk0Ja4WgJ09R6WQMSgK6gtcw+FwMWPco9n2JWMuy/1mIuqWg9ZbBObGcQItT3DjZasTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(2906002)(31686004)(41300700001)(5660300002)(31696002)(83380400001)(26005)(86362001)(2616005)(6512007)(6506007)(36756003)(6916009)(53546011)(478600001)(6486002)(316002)(66556008)(66946007)(38100700002)(82960400001)(66476007)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9zZ1lWSmljVG02OXA3N09ZUUJ1T0dOQUd6OFNnOFFGZlpKWWpONXJmNXhI?=
 =?utf-8?B?U3RMVGpNT3h0TktGZVVEUnBNQmRXTmVyU0F1LzErVjFEOThkakk1UWJtQzJi?=
 =?utf-8?B?c29PTHdiY0E2TVoxRFFLQ1BrZ3A2NGZadENYZGhPRWo1cWoyQWxxZms2dGZa?=
 =?utf-8?B?b3V5U0NvQWJwMWhFL2dnMDg4NG13eVNpS1BKR0pFamV6dXE0TWplRVhnMVd6?=
 =?utf-8?B?Y2I0YUZoMjE0TUc1SmM3djlyMGd0OEJLR01LblNMUDhPV25veWZkbGRueFZY?=
 =?utf-8?B?Z1ZUODhSbHBHZkdkR2I3b0w1SllWVHdQUndPU09NbjVqdHFNSjZiNWhNSTBJ?=
 =?utf-8?B?THg0NnNwQ3pVRTdORlN5QkMvamVZQTdrMkh6Nlg5aHdLdHppZXFJNGtxZTJk?=
 =?utf-8?B?V0ZXRldQUnNwT1dlL256WENpVm1TY2dEOTZsRHM5REJtU0VydzAvWUlJam10?=
 =?utf-8?B?SFNaVllwSXphbEVRKzlWM0ZXelJwVUpzZnc4a3BuNlg0emgyTWRtV3NKWlZU?=
 =?utf-8?B?NkQwQnFWVjRPb3FiTFZ5U2dpV0RreDkzbWJ6MWlodkM1b3R2em5wKy9IODI2?=
 =?utf-8?B?b0xmRmtkNjlBUHJHZHZlZXFHVTUzV2hzWmJrZ29VUU5WS2VBbm9neEVyRTQ1?=
 =?utf-8?B?RjUya09nc2hoQUxESEYwdHBDeUNVSUhOS1EreFJpVWxwS0hFcklONFpWLzM0?=
 =?utf-8?B?eDNRam1tSmdXa0J6cXRSYWQ4VDVYT1dKY0ZKeFBkdmE3SzhLZmErditQRXBH?=
 =?utf-8?B?YXlYWjcwb00wWGhPZXBKQ1hDSVR6NnEzUm55WE9Ub294MjRMSWUxbC9JMklO?=
 =?utf-8?B?cGtpQkhlQ2lYNm8zWHJHUUExVjUvT3VwKzFSeDdWMHM4bUdJelZWUzVTMEJi?=
 =?utf-8?B?VXd4dFUzQnhFVkh0NzA3YW00VFdjMkdaL0haNFFxdmZ5NGIxMmNXSEN1ak9t?=
 =?utf-8?B?SEZhRWU5UXdoRTlyYU1RaVYxbUM3VWtUTlpFUVFzak4yOWtBVnAwT083Mmpt?=
 =?utf-8?B?dGx3NmxISm9JUStVQUhlOG1WMWp5QnhtZmhOQjdFUzBpQ1ZENEpFNmVha0xE?=
 =?utf-8?B?b2ZSSnBaLzVTY0JId3pWSitIWVpKY0xxOVVENWc2UmN1ZEVNQTNvc0IyWjhG?=
 =?utf-8?B?VzI3a3dwSVhVUC9BUFR0WG9TU3FXN0tWc083TEt3VHg0WDlFM2R5UDhzUC9S?=
 =?utf-8?B?amtVd2hKOWJBRmxlRUNQKyt2LzFUMDc2N0FDSDdqL3d5dTF4emwzOUtCWDQy?=
 =?utf-8?B?NW8zWnhYemVTYmdHeTFMdjZVc1NmYlZLTlpwM0FtV3pMN1c5VjN3eFZoUWVU?=
 =?utf-8?B?akNBeEUwQXMxQnJkeUFWWnptMVRBMGFLVVlLVDdUSjNwTDZRODRyUHBTNDdj?=
 =?utf-8?B?VjZwVG15M0I1d0RyMy9SWlVxc1RtYXN1WVFueW9qRTRlL3V3dWdrcW1vOHNX?=
 =?utf-8?B?ZjhEby8yRDhuUzQzNklwY1BLdW5WU1BweGJvcUZGNlNLMnRIY3orUElDZ2R0?=
 =?utf-8?B?ZDlPVHNUYVg3VldkZXA1eGtwaFkzWjl2eE8rVVUrTHd2TjZ1bVI5YjI0MEtI?=
 =?utf-8?B?ZUtZbWo0UVlBWm05VzlWVi94K0FIODNRYjhPNWtkNDV6TjAzL29Zck45ZXhE?=
 =?utf-8?B?ZXJ4d3djRjNCYmpzSnhna3g1azFwMlNJdVpvNmZENVRyV2cxUW9FcnRqc2gy?=
 =?utf-8?B?TlA2bnRTUzJpTWhGRzJBNVJvUHI1dXdQSnBuaksraXRJNWlXalFJbTQvSUVr?=
 =?utf-8?B?US9uKzJ0VDNHRnpqdG13dnVkQ0dHOFFWU1hhMU5PMEtkS0UvTVZTaThCRFAw?=
 =?utf-8?B?Q05KYXVJMnR1QzBQaTF1dVFCZW1ZRUZYK1U5eUZsSXEyMGtqbEM3Mno3bWpt?=
 =?utf-8?B?ZGxwT3hLdnl3RXpJTGF3d2FRUHMyM1pGSVJBdld6TFpnV3RmWWZoMWxxay91?=
 =?utf-8?B?TmJYUkRhUVBKeUEwbTRpM2k0M3UwR0dKWkJoRnhCcXdyL1czcHcrTkxJZEdC?=
 =?utf-8?B?ZlRyWWxKUXB3Si9nOFRtSkNSYUplZVhqbUtsSGtqZzVpU2xvb0xVZDZLeXZH?=
 =?utf-8?B?ZGNIU08rVmZUWjJUZGNZVkZnYnNibk45NFBETDdJNmNvaGRtM0xpMEVveWxJ?=
 =?utf-8?B?TVkwZ3VSQUd1bWx4VjRxQUxqbVZ4a3VJVVFVdElUWmtTOElPaFUxdmcrdzdD?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 115b65f7-ea5e-46a3-f396-08dc2681afe4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:36:02.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fpAYaTcRbKlONjFWmQvTN76bIGLI0X4ZZCbqe11aBONqa3SEoeKBayy+SabKZ/j+MRjzl4PtQfLh5AK+TewcSjQzhrozkTkvLZxfY63pzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com

Hi Haifeng,

Thank you for proposing this feature. I think it is a useful addition.
I tried it out after removing a monitor group and it was insightful
to be able to see how the cache occupancy of a removed group
shrinks over time.

On 1/26/2024 5:02 AM, Haifeng Xu wrote:
> If llc_occupany is enabled, the rmid may not be freed immediately unless

(llc_occupany -> llc_occupancy ... one more instance below)

Please use caps (RMID) for acronym.

> its llc_occupany is less than the resctrl_rmid_realloc_threshold.

I think it will help to highlight that this is related to monitor group
removal.

> 
> In our production environment, those unused rmids get stuck in the limbo
> list forever because their llc_occupancy are larger than the threshold.
> After turning it up, we can successfully free unused rmids and create
> new monitor groups. In order to acquire the llc_occupancy of rmids in
> each rdt domain, we use perf tool to track and filter the log manually.

Could you please elaborate how you "use perf tool to track and
filter the log manually"?

> 
> It's not efficient enough. Therefore, we can add a new tracepoint that

"It's not efficient enough." is a vague statement. How was efficiency measured?
and what is "enough"?

Please do not impersonate code ("we can add a new ...") and stick to the 
imperative tone. Please see the "Changelog" section in 
Documentation/process/maintainer-tip.rst for more details.


> shows the llc_occupancy of busy rmids when scanning the limbo list. It
> can help us to adjust the resctrl_rmid_realloc_threshold to a reasonable
> value.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  arch/x86/kernel/cpu/resctrl/Makefile        |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c       |  5 ++++
>  arch/x86/kernel/cpu/resctrl/monitor_event.h | 30 +++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_event.h
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
> index 4a06c37b9cf1..0d3031850d26 100644
> --- a/arch/x86/kernel/cpu/resctrl/Makefile
> +++ b/arch/x86/kernel/cpu/resctrl/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
>  obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
> +CFLAGS_monitor.o = -I$(src)
>  CFLAGS_pseudo_lock.o = -I$(src)

From what I understand only one of the c files should define CREATE_TRACE_POINTS
and it is that c file that should have its CFLAGS modified.

I do not think it is necessary to preemptively fragment the resctrl tracing by creating
a separate header file for the monitor tracepoints. This is something that may be
needed as part of current re-design but I think it best to have a simple start that
places all tracepoints in the same header file.

I would thus like to propose that this work starts by renaming pseudo_lock_event.h
to a more generic (trace.h?) that will contain all the tracepoints. pseudo-lock.c
is the file that define's CREATE_TRACE_POINTS so it should remain as the only
one with its CFLAGS modified. monitor.c should be able to just include "trace.h"
(after "trace.h" is updated with the new tracepoint) without needing to define
CREATE_TRACE_POINTS.


> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..a6f94fcae174 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -24,6 +24,10 @@
>  
>  #include "internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include "monitor_event.h"
> +#undef CREATE_TRACE_POINTS
> +
>  struct rmid_entry {
>  	u32				rmid;
>  	int				busy;
> @@ -302,6 +306,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  			}
>  		}
>  		crmid = nrmid + 1;
> +		trace_rmid_llc_occupancy(nrmid, d->id, val);
>  	}
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_event.h b/arch/x86/kernel/cpu/resctrl/monitor_event.h
> new file mode 100644
> index 000000000000..91265a2dd2c9
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/resctrl/monitor_event.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM resctrl
> +
> +#if !defined(_TRACE_MONITOR_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MONITOR_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rmid_llc_occupancy,
> +	    TP_PROTO(u32 rmid, int id, u64 occupancy),
> +	    TP_ARGS(rmid, id, occupancy),
> +	    TP_STRUCT__entry(__field(u32, rmid)
> +			     __field(int, id)
> +			     __field(u64, occupancy)),
> +	    TP_fast_assign(__entry->rmid = rmid;
> +			   __entry->id = id;
> +			   __entry->occupancy = occupancy;),
> +	    TP_printk("rmid=%u domain=%d occupancy=%llu",
> +		      __entry->rmid, __entry->id, __entry->occupancy)
> +	   );
> +

Naming is always complicated but I would like to make two proposals with
motivation:
a) Please prefix this event with "mon_" as the first member of a new
   "monitor" category of resctrl tracepoints. Users can then interact
   with monitor tracepoints with convenience of "mon*". Later we could
   perhaps add a new "alloc*" category.
b) Please replace all "rmid" exposure to user space with a more generic
   "mon_hw_id", or if "mon" is clear, just "hw_id". For reference you
   can search for "mon_hw_id" in Documentation/arch/x86/resctrl.rst.
   This is needed because resctrl is in the process of being able to
   be an interface for Arm's MPAM and "rmid" is an x86 specific term.

Considering this, what do you think of something like:
tracepoint name: mon_llc_occupancy_limbo
print: "mon_hw_id=%u domain=%d llc_occupancy=%llu"

> +#endif /* _TRACE_MONITOR_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE monitor_event
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

Thank you.

Reinette

