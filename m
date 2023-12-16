Return-Path: <linux-kernel+bounces-2081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5448815799
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C92865D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB711705;
	Sat, 16 Dec 2023 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzVf57rY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB910A2B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702702722; x=1734238722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6U6DZPAGgBodx7dsMHfAkGrBUpLlrspnJfQMFZ4KnzQ=;
  b=mzVf57rYv0zbrYZOGHjIm333CAeQW45ERdkkwkCSfGbfWdDRqE6VRX90
   Ks515KKxz6e1NUhUGa4pHpuEjKc0skdov+sO7tgzUJJ32nc5f00u8GOsE
   wLO2MiUMA/4hSHCvwrwf0h9ILtysj+BG1iHzEIy12evJildOYorMfTAUL
   XKdpFibAZ4jekChVnVR21dp9aVrkveYKjTJ3fNaooNNhMg+idNtF+HW9k
   TgVSTOkRZJf6QwPucE9Ptu3Ztd93rNPKnG2xTEOmH1Tvm4sAwB0cPVcBr
   xbB96Yg6j2PElijQaPqj9CKdUOHG5uMYAKEgeCQTFqoMQ+61eEuz5ZS5h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2182930"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2182930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 20:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16528037"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 20:58:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 20:58:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 20:58:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 20:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVteFS3yPvZXG3Ic9Ym5pKYVD6f9pkmjtkROC1TkpZE10uh7rUMAFswyJsH4faMT9lzuIcDcBxl1cv35zyr+6d+4Cm7nu9CVW+0vJ3iRnm2zX24JmHpk/hCuCbvXMAbjeT/dkGVBKKJxOOwCu0+jl+yNRuezrUKx3w4emFnMeIh5jqxk8uJ/r2R0KAYQVpP2uee7KKL2r1yysyauxtYnn3gYAraaSIVStcGGDnbZ3bels7k0lDIDXTY08dAFevkv8UhXWYIInYhZzwMQP4KWLehQpmBp8/Yllnx0v1xAPoVDWu8FWMvUJhorhFQN/RaOCM2Nhx0TknxnBJLT9nDLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO7OV2YSyNe/rLiCugH32XXB1HgWTeLAjgPUwkAbizU=;
 b=V29BJATVZzAvZUUeZw2nSKefm46cZWoCNgksnoAZkfSj0OVFbn+k2ZQN2RxO4dzIb4PEW1JX2l8sKOGk1AsABN/nxzJBZdcjaG+g4s2+jhh7JT1amCOX0/zO/kZdIhAc/RJVnt3Nlsul7uX3rVfkmLOIlzsiT21s7UKpln9Duzx7MPCZuMNM4ZQPo87qwzUR9wxbW5lvmcS527HFgsSPTlyPWpRVIhlAmXiUGOz96kz5mWjGQNmhmsOsDzTkjs6CxFeCOxLQJT2Mj55YNmdIzv7ukDnW2MczeIreX67h0ST7Cl3HTpop15Vtc9ckGuoSEkoE3caLn5498Cd+dtb57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 04:58:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Sat, 16 Dec 2023
 04:58:18 +0000
Message-ID: <0072e1fe-7c4e-4bd2-a1d9-24c2161d14d6@intel.com>
Date: Fri, 15 Dec 2023 20:58:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/24] x86/resctrl: Access per-rmid structures by index
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-7-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215174343.13872-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: ca665e8a-5202-46fe-a80e-08dbfdf39e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xh/oruXy6zoPztYJNTQI3upX52cPnl8yybt0WOxDZCPYy86EVRGDudN5feu+wozsoN6NGfaGpBBS45GTy3qUlD4WY1M1sol03XLGbF0YbjegqAhEVCHpFiXG9PDhU0Q9vxIk+F10qpFWk+R4TE4X+QxDBt2OOrM4maxxs6AxSZ798sGqrUc4tqKppk2R64Nyg+Xbzk3leplI/f1yyEr7l4F47RO2IjiS/gwJm/lehIATXYDskYBcFk60ZKSzt2OwYSeHKKxapXnS0tMoA2Ng3iR7JGQ9qRZ70VPiP8OMkxvtvaRC/eTmTke6b3bDRYrqYGyISziz1pv0FkKdmHpUyMytP3YI5sqanEOAzKqp4M9HqHImt6WcJJXvaPr80yByf49h7CY/R1YGw5vOV8LLrywrfY51j3SiFhrZg/5WF7W50XtQZVd/2+40IYhQkiinVfCOyJ/6JvpdSAsHh/WYvlHF531YduIBVar4nAJX5mqmP5Vv0LdV1N/f2D2IEBpfrw+QhIeypP2gnpaNCtGFC49RrV6dpDbUEk5gRDZ/AHaaq9kMPwkNuGE8ItToUB5xObnnT2JGmNkeBzZJBlhoX+HXCqpKh4tjNi9R8MftZI3ZRLGZD2mkILKAnFGmiYb9r68Pac9k/j1/GE3kBm/CXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(82960400001)(86362001)(31696002)(41300700001)(38100700002)(6486002)(8936002)(8676002)(4326008)(66946007)(66556008)(2616005)(66476007)(316002)(54906003)(36756003)(7416002)(2906002)(26005)(5660300002)(6506007)(44832011)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01mMnBLbzRSdFVaMmY5RTA1eld6NFg1d1A0ZW1GNWV6VGpRTGI2MndEWmJo?=
 =?utf-8?B?YllsREFubTdmSVFiOVVFWFp5SHF5T0lrR0t2MUp2K3MzZzRTcXA0dG9VL2xq?=
 =?utf-8?B?b01QR29JdmlzdTBJRnFWTnRZV3hmcU5qeWdWanRZV3NVUVlpSnpjVWlWZTFp?=
 =?utf-8?B?KzNUN3hrK3FvejJEbjB4a2o2OXAxN1lidEVFN0VjU3lXYzZHSFB1WjFyTjV5?=
 =?utf-8?B?RDh6S1l6dytEQkxXSVFiQjNRWmNLejNCdWRlT0c0UFl5UXN1b2tXYm1CQjFM?=
 =?utf-8?B?RmZsRkIvbi9VMTNYT21HYmNGZlVWMStnSVBpKzdydFJzM2hFWEVxMmhYZ3lJ?=
 =?utf-8?B?R3NXZU9lTWtpZWVZbFEraXZ0ZjVBSER0Y2JDQXRMK3ZLY1pocEQ0TFJCMWRO?=
 =?utf-8?B?a3FFTDdsSHNRTml0aU1JZVBPNDlLSVZLV0pXTjlEWHk1R013R3dZQ1NpSFRm?=
 =?utf-8?B?NTd5K0dlRjdZTlJ4ZjE2QmJ4ckxwUzBpUzYvU1NtcS9ad3AvVXNlU0p0NXBR?=
 =?utf-8?B?U2RuN004TTF3c2d5N1pvUEZyaWgwN0c2cjhzYXpkTmVlZjFtUWZVTVZ2VVNT?=
 =?utf-8?B?L0xnSFU5cGN6VzM5M0hMcnpobHRFVXlxakNraDA3VnI2ajhTM05pWHNhOXZi?=
 =?utf-8?B?SFk4Slg2L1AvakhkcEtHQVd5eERFd0dLdGR5Uk9OV3lkZjBVano1Qi9BUFdt?=
 =?utf-8?B?YmIwQjVLVk52Mlhxb1BTWk5NZVNocEhOMktoU0liMzcrMEtYUWxpVkpyMGFu?=
 =?utf-8?B?UG5NUGpaeTYwbDA3OXBEZWc2ZW9pMVhrSFdiZjZ1TkpVcFlOZCt1N2hYMElu?=
 =?utf-8?B?R291YU1LUTZXRkJ3TUZtNnFpeFEzMzVWQjZqdkZxZ1dIUXRWS2N0dSt6cTZD?=
 =?utf-8?B?R1VJU3gyNUZTekVkSXRyS3VIYVRZVGE4aUtRWWt0RDBMVy9FdnN0dW00MFJt?=
 =?utf-8?B?RTlXaWpKd3VyRkx3TXZEZUJxWjV4V2RnOVVBeWNSM1Z3Q2M5NjhyZHNOa3pX?=
 =?utf-8?B?eFNKSEZ3ZVRHNHdjSjJ4U3N4QVNWL3JVeUR1RVJUS0xMejhyYzUzRFFJYXZH?=
 =?utf-8?B?OUl0dmx0N2E1Y09jLzhaZXVvYkM3SFlEWFVlMmxkb0oySndwakl3anhDeCtx?=
 =?utf-8?B?Tjd0TnV3bFZueGkxak1WR0lYcHBOSU5tUmFRajc2QURTQktpZHg1OWpaS09Q?=
 =?utf-8?B?czRVS0c0ZW81RXg5Q0VvOUNQZFFrQjlzQ0U1WHlJZmYxcVFRL2haTWF6d0dW?=
 =?utf-8?B?c1E0TG1NNDZGOUtPSVVsL3ZOdUlGQUhFT1RHRkZlWnBvVVliY1RramtvRG9t?=
 =?utf-8?B?K3d3bFlkblVqWW1raWlpU3pjZnZPOXQ0a1gxYWRVZWZWRk1NV1RuTjZHaDRH?=
 =?utf-8?B?Y0g0bVkvVXNOd1VPN3hadUlxNzlDUnJENzZrMUdyQWJVRkorTDF4Z3FJVzcy?=
 =?utf-8?B?c2tFSE9PblUrQlZwNTB0cGpQQmZ5ajFrVHlSRzNxeEg0THpzc2tZQTUxaHE5?=
 =?utf-8?B?aSsyWUlMbm4xUTIxWmcycW4vbERjblp2d1ZWa1lWVTZvQzV1UnJ5VHE0bzRa?=
 =?utf-8?B?bXhRcEl6aFZBUmJzUkVBcjNQbWlobkE1NVVndyt5TzlhK21nWkZRS25SaUxU?=
 =?utf-8?B?ZDFETGtVcm5NRHc2ZnpOLzMyeFplZHZGNDgvNkZYSFVSbkJTTHkwZW9xeXdD?=
 =?utf-8?B?ZWJha1cyQlc5QzAzYUZMeEIrczN0NXYzZ0FjbXFKcDFOaWU4RnVVcVdFSDRV?=
 =?utf-8?B?YmlhMHNqVU9FTDU4WDVRNnNlZ1loYzZ2eDZzZFNDQ1dpQkh4RWlJM0tHZ0FE?=
 =?utf-8?B?Q0FKeDM4QThwaGMxVlMxTm1NMEowdCtSbWc2WUtoZ2JiM0k0ZWdYaGx2M1FD?=
 =?utf-8?B?VUQyQUdMTG0yOGM5Nmxody9YVDBYVTZPaGpGMXEzZnBoTE1jVTQ0TWQ5YVgv?=
 =?utf-8?B?ZWpyYUVlRzdicmtOeURreWVFaUhTZEp6T1FJbnp4TGtSSG1mVEgrVkV6cHZz?=
 =?utf-8?B?OWF1bk00aklsNUl5b21id29UUDFXUDZibm5XVTZrZzZlTzN4QW12R1Q2NXky?=
 =?utf-8?B?MXlqUlowdU5xUWpvQXBSblZ3MlRPcXVxVnBYNjZUYkx5VlI0NmdaVXAxTUJF?=
 =?utf-8?B?NmozeXExWlphMEMrU0xhSHpMRFp2SWRsaXFGNS9BRHBvd1loTmgzN1hydkZ1?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca665e8a-5202-46fe-a80e-08dbfdf39e66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 04:58:18.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl0rlxiEQurMTIdnejGbyxOyWSXmZdKaVQHKDuspwaXqvcnpo2NexkglA39897eHY/aWUGw4u/WGIvIPiqZc+GjUsQrb+IF4zBJK67SNp2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

Hi James,

On 12/15/2023 9:43 AM, James Morse wrote:
> x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
> used to lookup the control policy, the RMID is used for monitoring. For
> x86 these are independent numbers.
> Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
> used to lookup the control policy. The PMG in contrast is a small number
> of bits that are used to subdivide PARTID when monitoring. The
> cache-occupancy monitors require the PARTID to be specified when
> monitoring.
> 
> This means MPAM's PMG field is not unique. There are multiple PMG-0, one
> per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
> cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
> need to be sized by the number of unique entries for this resource.
> 
> Treat the combined CLOSID and RMID as an index, and provide architecture
> helpers to pack and unpack an index. This makes the MPAM values unique.
> The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
> are domain mbm_local[] and mbm_total[].
> 
> x86 can ignore the CLOSID field when packing and unpacking an index, and
> report as many indexes as RMID.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

