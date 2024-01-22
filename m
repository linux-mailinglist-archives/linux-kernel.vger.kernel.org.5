Return-Path: <linux-kernel+bounces-33829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476E5836F16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70B9287605
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4181664B3;
	Mon, 22 Jan 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJyzJqgN"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC40664AD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944888; cv=fail; b=r9kcluI//upp8zZFElzGLRSFxWUvY/ern2b1s4qrWtyFryhnyTMe/ceWOffXK2DBTCM97J8JKyCSO6tsDYajDLelQYnuYOEU1jj0lj4Ze8AhcCc9t5ffya9pQu+UjwyMIR2Xly5wQo/oQX8fpTM2g7/J1USW2u8BPTpOaG3CPko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944888; c=relaxed/simple;
	bh=8Dwq0c0A1wNUukEZV6KDkMzT77SpoKhVI3DEqFuMTzo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/0RromjITawtqKeRpJxssJh2sVsZpKFbr4H3Xo/mZ9bQL7hwAnefWnjlZcFleXE4spS+lxuF3voDiPy2HOwp19hwLp7AAX/wU26w3AgarXxoXd1AB6NOwRYM+WUU+DqVdP0wPCPuuo5BBmGanNf+VEpomU++IO/6RYICw4qEaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJyzJqgN; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944887; x=1737480887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Dwq0c0A1wNUukEZV6KDkMzT77SpoKhVI3DEqFuMTzo=;
  b=fJyzJqgNujnnCweruLcg+qc1KxX9SS/lKkF8GCqGeEcrf3jzEzjU4i79
   Gfp4FNBAJyIHG6/YAL7N/w5oYcwBvRw/QbuLnGRT0psh7vEhf/jwyF3zK
   YnPR2XaFwco4cmiraXpKWL73t6YgrandigS1K9TctOyXyqXMj3dvC++7s
   PRmq+sA/w8zjIcneCpbJ/Jwc3i9+xrVHmOxswSiYyAg88ilGWm38atvBM
   N4QqDLpHlRMupQit7y5PtuBGZCK2FwOyQBjffO+dXdzMQGFBZTABqOP9w
   fh0ofMcvVYcW/8P9exMENTxMOtXAJa7la0oktyhh2u1dvVyHh+6inGC1+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391699843"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="391699843"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="785750652"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="785750652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 09:34:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 09:34:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 09:34:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 09:34:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO/ZpzR8D0nt2XAkMghbHZiorNDwU7EEvm7YZHCwkPNGWA04AzCN0iN/lySs3eRhm1LcfKorubY49iKHC/tFugRMQzSX8VIUnjUyVxdSCXBMuxVGocnruYGvsb+IH42Mk8UBJFfHU3lVBsNrlUf9hPiwdgokavuXcOVGlyLFaGd9Jft1PuX9QIl7BYiez/kQHK9j3qmgsFq+ZH4hp5ewY+kP2JoAvw0B0MjapqKTVx9yqEZl2DBJsglj0ZmYqZMmx4hG1oT5vsVxNoHV9JI3M6zcDsF3ORvR0XGw//1bJECzn+ypNq5v9qe/7pSzVWA3QmXigLxcsRvMNfjbPOvO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTSRbnd2YPb7FkXf/0E+Oxpd6n+ExpFNWY4Dohloric=;
 b=N2Vc0jw0CFgMIYku04Ch+ZVeYz4g799u2khHzFfegx/JsWgPAPsTlDAYriqiYvcM/13lgaoszNHkmG0jpo7hU/nq+fiC5VZ+0C8rqKLwnT7OYHpnTOs44dojZFNFok6K9qsCSSSVSxld8s8ItwHwten5xlUBFcev4dlA4WjvN80e7pUWg9LyJbtvveuQ9A3ICaOQ5wbh5ca13hqvK5IUV96pLeyUCUG4NWSwQ6XW0UNiazfjWvFhCb2KkhKEqQv8UNZahfmzuBA/tBQildL6fZy/QGXvdSiNd3CAAz9P7HU99CvcY8KjHwRcYmbvfo1L3MOimRWEUGvRUe1ImTbjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 17:34:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 17:34:42 +0000
Message-ID: <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
Date: Mon, 22 Jan 2024 09:34:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, <x86@kernel.org>
CC: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>, Xiaochen Shen <xiaochen.shen@intel.com>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240118214213.59596-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e71317-aaa9-498d-da25-08dc1b706a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZpKiJfqWZWl4K3lkkNJs7e38N6kSyvCV0yE1Sm0sN15KV9ogNS7bqxdbnz+CuaWnB1kL9tWZmz+VM6+LPDuIMSV6r/VRPEBJEjWfkLEaccMiHmoZYr9aKXgAgUyhKYMWMNtYpN/PZjNAQYjs7s35oCjQlcgBHTDCAVcpZc61I9kVVWMufQYff+bd3aee6DvRSGnVo5lEmzX2fBk8gT7rHK4kj647w2sY9FoZp6yvNLlnvvG0i81MAo/8f6gnLpUYKNXXyOxIq07w1g1lvBFKQLMffMKbj4HbSg4ezGOcCOhwCpXu38fLsONRHKzHsehPkqv0kYFJYeCRuyWlc1Q2ES0sbsk14+tLMlz+FJhn8TB4TB6tM4F1trZuGW+HLofui7AnKSfWGocpDbsGJclG0NiNj4zDp27/O0tJ046fduQ9IiSjdVTbLBCl0pDZgERnTeEjWkIqQJgv/LOSlqfTZdw2P8PNCHEab9PkuJTAKKxQMXkmgEVd5eSHSkfFtUe0rkFrXCKu1t2eq0FrwP6mTd+RwqANa6Ysp1u3Bz6bl232M89dx/Q1waSXxg5PslDj5WNCkG6dbRDkrf484Utuo8EoegVMPDjtIG2WpEdqDoQvPM+M82iZbYS7WysLAiEcmeZRc3ekhZ44mtoJsPHXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(5660300002)(6512007)(26005)(83380400001)(82960400001)(31686004)(2616005)(478600001)(6486002)(6666004)(31696002)(53546011)(4744005)(6506007)(86362001)(41300700001)(66946007)(66556008)(54906003)(66476007)(110136005)(44832011)(316002)(36756003)(2906002)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJncTR5SUZlcWh4eUp5elJlYUk3eTI0Q2ZRL3M1K1dXY2wzZmIvK2wyN0xR?=
 =?utf-8?B?NEZWVHgrR1VhMzBNZlo3cHE5V081MFYwTEI2azEzYkpEWVFETzJEQ3A5T1dE?=
 =?utf-8?B?WWJGcDJrNFlrdXYwT2h5U2g1V3E3NEs0TEhueVNtc01WNVd1ek5XQkJXV051?=
 =?utf-8?B?TklVMStZek9VNHhPTEJ4Tnc3MjRvQzFOekRRWHcyMmpCZ3BVOXc4cE53QklJ?=
 =?utf-8?B?V2J0alNySmNtemd2OVRCd3d5ZCtETVNNRGhoTUdJVkpWdzZtcE9FeWR3Z0JF?=
 =?utf-8?B?cjhQbFdrYkFZZFZzVytSay9xd01qb0V4Z200ZGthdGtkQTZid2J1TFB6anJ0?=
 =?utf-8?B?UnI0SXFYNXlkVzRMYzRsWGFTU2RHVlpNMC9xejFFWGVBRkRmNnQ4ZUJIZTYx?=
 =?utf-8?B?MGVNbDdqd3EyM3VIb3NNaGt6dUY0amZIbVRReGwrZXVvS1YxUnpiVEF3eGFk?=
 =?utf-8?B?cUI3Wi9YKzBPTkJ0QW9iR2lTaURXUEVFZkZHTFNsbzlxeGlwZmdwWU5qQXlN?=
 =?utf-8?B?N1hucEtXcVlkbk8wVG1yQmVvbGV2aFp3b3pEaU5tT3I0VG1QbFk2RjNxbUhV?=
 =?utf-8?B?ckIxS2lCbng3MmZVZVlyZDZjV0k3V1V6TE9FNUdLTTVwd3FLZHI2K0Q2S0pL?=
 =?utf-8?B?Rkh3dVIrYm9oTm5lZmRQbjRhOVlld21KTEluQzlPSjZqalZldWlIV2Y0NlJq?=
 =?utf-8?B?T2lXSHlOWmFJb210UnY0UFFKblpFa1hURXBXSVJRQXNnSVorZVcxaE05ZXhk?=
 =?utf-8?B?TmxvWDdyeG14NThaVTQxalRvUWtEcGJsTTIyaHNRVVQ5MlFZN1RVQ3M0cVVR?=
 =?utf-8?B?YXZqNFhVTmNIMFNxZG1uMUxsRUNUWW1YM0pmTU43VnFWNHhLS3hOY1lkbTNG?=
 =?utf-8?B?VlJCZ3d1Q3FiZmxYTTFFNytVOUtVV3JpQ3pOdUphandMMFlOUzY0SXlFM1Yv?=
 =?utf-8?B?TmVUUTdCUTAyMmczdDQ3Wkd2ZzRCWTF4MXM0WkdVNlJ0c2taKzE1NEtsMkVC?=
 =?utf-8?B?Wml4UDlFRTY1amwyeUgva2FGSTIwdm9oYXlDRjkzdXJMd0lOYS81aEd2eis2?=
 =?utf-8?B?K0Y2ZHlyOEZ3QkYvTjk0d3Jaam9rUFc2RmVWbTR3S1RVeFlJSjIySjVhRjhV?=
 =?utf-8?B?d2FhV3ZMVm5UYjFLa2dzMFUxQVlicWY5TWFHd0k3c2lxWklJa2U4M3g0SktB?=
 =?utf-8?B?Z3JoeGF0MTdMcnhXdzBCNWZldEFCVmI2V1ZzdWEvakp5QXF4TFJYZjcrVjdD?=
 =?utf-8?B?amkzVVlMcUEwZFR6WGNUbm1XT09XbTZYa3dSaG9yUVNlaVhpZTZvbWJqek0r?=
 =?utf-8?B?dytoSUdkdHRBZklYZTc2Ujh3OXlxMi9yem56SHNQcVFnTTBvdnhrQUg0dldV?=
 =?utf-8?B?bm1rLzNqcXFxSVNPcld3eDR5bjZ5eldXbFMvVDNMSmlLTUpkeEZneWNzcWRj?=
 =?utf-8?B?aGFhN0lwNGczMEo2bm5OVitvT3RJMWdCVmlhTjJobzVtaXZ5NDlDSFpINjVa?=
 =?utf-8?B?MkloTDluVFhjL1FwZmV5d3hNamdGeGs2eDVXeVZ4T0ZyYlhUdzAwc0RuRTlI?=
 =?utf-8?B?dVY4cHRUM1VSQ2RaK3pYbG5mbGJRNTZsZCtlYU9oT3VFSGRZU1Z3MUhRNUU4?=
 =?utf-8?B?aVJCdGFVRy9DVVVLQ3dLWGhCUXVCL1JOSmRaZUlZYnFDVFVwODdYaHUydFVJ?=
 =?utf-8?B?cTdPRkdYQ1E1cGxZam5Vc240Y3EyUnZCZ2ZMVUdYRHNXY082RWFGK3c5eDhZ?=
 =?utf-8?B?RVdDU3hpVlBMa3VuVlJhelExSFdJYUtmTVJ1N0ZvYVFzUDh3bjhYbnFveWMw?=
 =?utf-8?B?S1RZTEl2SzZVRW5rUmxTSE9ZUGFXWmx4MDJsQkpGVEZOYzhva3l6cEVDU3h1?=
 =?utf-8?B?MzErYmh6TEd2N2Z4ajdDejZCeUlEbVBNeHJjZnRzNDRBaTRzUElWUmJ4cmdS?=
 =?utf-8?B?eEZpUmM1ZnlUSmF6VE1WVVc2T3JBWWJ5NUVoTHpkeEhoQnZDVUVEaTk5aFN3?=
 =?utf-8?B?eis1eUlWUVkwd1NXVnJWVVR3eGFaRTRraTBWUDlTVmV0WDF6MTVKN3NzQnlB?=
 =?utf-8?B?ZTVlZU9TckN1bzk2dDhlSTl1Z1FIYVVwcktTbEtmWTl2RWJnN2NCRlBOV25U?=
 =?utf-8?B?OW91UVl4NWdrTlk4RlI3WkdFWHFoT2ppN0oyS09ZSENNL1ZxTFpIb0JMS3g0?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e71317-aaa9-498d-da25-08dc1b706a8f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:34:41.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BggR4vHev7KqvFEpd/3kEUiwk4WwKIugy+pf0azHBir8tcfmQ3p79fb3gZKDTkzRTNweV2btHcYspiFi4Uv5QSvIZVVnT6twTI0eLuLt2m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com

Hi Tony,

On 1/18/2024 1:42 PM, Tony Luck wrote:

> @@ -520,7 +517,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  {
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
> -	u32 cur_bw, delta_bw, user_bw;
> +	u32 cur_bw, user_bw;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
>  	struct list_head *head;

I am sorry Tony, this reverse-fir breakage slipped through. I only noticed it after
trying to see how best to present all the pending work to x86 maintainers. Could
you please send a fixup with this addressed? After that I am planning to propose its
inclusion among all the other pending resctrl fixes followed by the SNC work. The SNC
work will need a rebase starting with this snippet, unless you see an easier way forward?

Reinette

