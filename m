Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD87B7334
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjJCVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjJCVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:19:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98AAB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367962; x=1727903962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wYmghnREyGADBnCdXV7hnwtpJ2FWCyybKB5jYjpDIvo=;
  b=b9HiIIfFor7VqmjKD21YTCAq35zqa/YlAQUFS0W7hEcMrmZjEGAQd8DY
   PlcxBKG2B6yzQCCjefeThtpUm6VV+UbaCNog+FpfoogYnSzPCaOCKmG1T
   ARXl3hPX7Le7KKgSXv1pSV7BvP/6dwOE9q7oCEhQ0wSAlgzpYXNc4+O16
   3u0277C+5aK2+kR1Hyqyj5qF02NP8NI/lJ5kumjBU0FqCNFlgVdSRrM9U
   Y097TDKWausEn2TYTcDRQUCCmo3OM3Vxp6DXUK9fYaOO1tqQrKtXrWmIV
   MTOm/ghL9mvFhO1bnrGzXx0LcFs5JHe9DF4VgaxY9W5gUZdSPKjFXvxAx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577381"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841505336"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="841505336"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:19:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:19:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu2H0KfQyZBGclL9WFGRCTcUwlIZBbaCehAAqIAzoqBvdSb60raUi8foblvUkpg99ZzNKZ1uDPKGeX0TD97je7iZHmRyFAGbz+PjzOMACefS89bAfkBJoLnyrhXsGdpo+nawFUNkKQuv/NQPdpAhEkO/xG7gTxmYuKEHuhm3XvQ2zm9G5PQlM+9ie1b0ofW7NFeTbDMI1NKQIsBGZW9qDixgT+L4aBmPhqzqhtJrX8NwFT5omZebfpeiHs50T/rBxXT7esYyDjVCs0FtcnHjSc740QNqS2JvJzFKZAZOX/9848WCJYoogQWctVU6iikoFl7cwm7fva8kRkpbzF70mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czFlKaJWpElfDWQRT1SChGKDm510UO+FmylBUZwA8fQ=;
 b=Rw9rcTx71ApGbVwNjytneD9GcwtQeQwv64h5ZGs623hBnUkGgGra6VxoRG906q4vKSArpswP3QI6VtIdwWkls3Vzg0ElY/CZ6MaGKNmKfBcLOO+z+v3fbs0PLYQtR/A06sddufOhJjuVHS2kt03XSqEg9aW2jsD2tlFiL3OZtIBWtdTzu7fiZrmu0JtWyT/RnROyu60+MS+kP7/FjY3jVGmiMmkzQGR5H1vzLHJVtWdzMvpxQAUCO3kpOraf7eKtude1vk5mNLik/PnQOC21k3PeiBpSeQNEIs5SA/JAkEisKuX7wPhO+jjYHNLOYKunz7W1C5zmZMhHsHKe7bYNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:19:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:19:12 +0000
Message-ID: <45ac8c02-5188-9599-ad5a-380197ce7251@intel.com>
Date:   Tue, 3 Oct 2023 14:19:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 16/24] x86/resctrl: Make resctrl_mounted checks
 explicit
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-17-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a1e7cd-6cbd-4e2a-bfbb-08dbc45663a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2i/OOmB7QAoweleCeQuVTIy+x3D+Uh1Dzyb33V7eowERK4v5qRMtMnLvLZqvd5E88mnAsebXgoWanGb+eodB0neXcR3sJdwB0pFLRB7jtgrn1WA8yfgT4R/9IN5LpkfbDviGhJnGKdEIJb9W5j0hve9NXLFU5R1W41EPALCxD0+Pp3t/ukpMlF87F+8V43wjor1dKo4C0bDTwfhsCz4DDJ0tr9n7l94mDsbGydkmq8ZI0LJQPRFbJ4CUrvoxcV+cWcE+PIrSJSxy2B0TwrKSnOnrhag12o/fLDQlb6aTZtP4lqlHct000rFP/mSwk9rcuLdyYKFwiyXtgYoVGdza64WJllWi0ySnO22L8G8QP7d0eGCryU01UEzkShmlpa7sPco8PO3ryUX5GQo3X1uacmO759SEwRA2reFZL3vhWjWidtz86Typv/x/sicoH787ALqZM8ldmPCmD9By/r8PBV0MBiqQs9LbT1X1BWemBnyEn4kh1lCPR8cnBQgka7zKq98avkLJjN6a7s/UKyeGahRgoZi8RdhKdsWWFjlxadoFLfeah8Xv4iWBLgDptAqPh8ullNDqzKWH87VjCL6TkFT56EVWja4BTkXMfB6m72DxVJgDpSkhNPMUb0ChAdKU8QFXEiSdUX+6LE/9PJc2bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(82960400001)(2906002)(7416002)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(86362001)(38100700002)(31696002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJqU3BzczRkSTI4NUVaVmUvOGhVSW03QjJLbWwrMjBSVkpWSWJrRmRjVjI3?=
 =?utf-8?B?enVQdXlsTnQya0I0RlFhKytMTVlVM3BXVWZ0Wm5lMnN0cE5pTndDWi9OTHlU?=
 =?utf-8?B?Nkx0Y1puNUxZRDBIUXhNb0thL0NNSXdMcG84NUpsLzh6bm5pWUJqSmJQSk5u?=
 =?utf-8?B?V2pOTkpQYW5ZR0NXUXRPVUN3ZHAwbG9sVUFhM2d1a3JraVpXWmFaL0J5OHBO?=
 =?utf-8?B?OTBNVGsvRzBLakVFR0QxblpNc2RrZEdBV2duZGwzSUt2UVdVTUFnMXZ2TnBn?=
 =?utf-8?B?SnpZa1c5RkxtdHJaR2doWXpzVFN4UUZDV1I5cnVXRWF3a0g1eWVKeFN0aTlY?=
 =?utf-8?B?YVBoWFY3bzFoNWFUTlAzRGRpYkY0c09hSzA5R1FqQ3I1Q1ZjNndTUXlWSTJV?=
 =?utf-8?B?ek5RQmZsamF2aHNXdmE4cGlNZEREUkE0WGpSR2c4d0o3S0lWOFp3cC9McTl0?=
 =?utf-8?B?Um9nK1Nwdmpmd2JoM0FMcXFhcERsaTNqZytmZUNwblRnVFBhd1k1UGp4UWdx?=
 =?utf-8?B?dkk4UVlJbmVhbDRpUkt1aDRVeXo0cVA0dThOZHNNbXQvb290Z0NNTHUwaTdC?=
 =?utf-8?B?RkVGZDlacUh3N040bkRaaDJOVVNaUUhySFZOZmx4Qk0wRGczRWRYNC8rVDJj?=
 =?utf-8?B?SnJlWWdNOFBudGhTTWpPVmRSbVBLMXUrV0xPNzJlUXcxY1BTdVg4emZtR3By?=
 =?utf-8?B?NS9WUG1weEcxUmdITVZybDN0WjQwbUVSUG9ZOTR6Uk5TaWtUVHBaUjhaMkZR?=
 =?utf-8?B?Y1lQSUMwMXUvYjNwQ1FjaDVZSDVjeUlRNWRJRVJ1dElBY0NweTMvUnRWUU5I?=
 =?utf-8?B?VGp6SnR4UEhNMGFHaUxrenh0N1M3Um9kVmMxbGtESzBKT0ViaUw2ckxEOUM2?=
 =?utf-8?B?WXVzS2dLckhIOURnL2twei91RENsOUhmREo2UlZoU1luTkRPSS9IZWd1WVcy?=
 =?utf-8?B?YUxlRm5ONVo0c2V3eHYzMHJ6dXNzQUhTYThjbFlrSGh5K3R1RnpSU1grQnN2?=
 =?utf-8?B?MVloTEltL09UMndQN2k1T0RIeGdUb05nNFJ1S3JqZVRuaGZOQloxbkZjTXJY?=
 =?utf-8?B?ckhqSVRZZDhZVXo0Sy9GUFgyNElsR05Wb3JxTVg4OXV6NklrT3NOMDhiSnBm?=
 =?utf-8?B?TFdRNm1DVGdGcHlld29IK2lUVWNvVWUrUVkvZWlqKzE2dUdIaS90c2Q5bFpM?=
 =?utf-8?B?M2F0Qms4VUlDMGV4NzRqellNZWVpWHRJVFhySXlGQXFsSmpHRy9IUWM3cEdN?=
 =?utf-8?B?ejM1ajk5SUJxMnkrQ2kwc3FSZ3RPTkF4TmpiL3JuOGxrVmZiNVBuU2pWVmtO?=
 =?utf-8?B?elMzd0tGSGYrNXlKWnhQanhiQkJJOVRzeFFCY3A1K0M1c2w0Zkozam9ncGNT?=
 =?utf-8?B?cFpkTURqbjlwMzc4UWhqU01NcllxVVNUNll1OXBwUmhFM3FCUjgwdnRzbXcr?=
 =?utf-8?B?eDF6dVNTUFFSQzlFWjlPUFhMZlhVcXpvUWwyTDhlc0VDUVV0ZDdvTEttS2sw?=
 =?utf-8?B?by9YK0psSUN2MGF6eUdaU2VGQVEwTVFYVHVnQnJXMmw2TkZUY295N1VXSkhk?=
 =?utf-8?B?REFQY0NCYUtONWVjQmk0aXZ6eVBqTUdrbTdpcFh4WVRzZXdGU3V1K1hURjhU?=
 =?utf-8?B?T0h5Z3FoaHdrbG5zOTdodFhoc1BmcUlVaUZremp2NjY0SWl5d1BSZFNNTzdE?=
 =?utf-8?B?ejk2emhjZHVZbGRhcit0a25maSsvVzhLMlB0TlJLUFk0QU5pSXd3RUsvSjVm?=
 =?utf-8?B?QjB5eUk3akZsdG9wTmpFdzUxL2xBb2RpOHM2U2RralFtY0l4Nms3T0Y0UkN0?=
 =?utf-8?B?QUZUaDN4QXl2TFZhQ2ZuQ3VFM0hPd0dkTFlTNEZtQ0UvUVlQUWYxVkRUYkpW?=
 =?utf-8?B?aytuc3N5b2RvV2lQMXVNQ3Z0eEF1SlVjY1RRZ2xaczFVQ2NHQThpNkx4cDRC?=
 =?utf-8?B?ZWRiRTRING1kMlFnSWFIZFlwNG5mMFZtYWo2cXJFL0wxQ3Jzb01wRmtZbUdR?=
 =?utf-8?B?T3RQWEZ4K1Fyclo4UmhUa1ArQ1k1eW13dXBFU3h3ZmZNK2ZIUS83c1dKZno1?=
 =?utf-8?B?ZDY2RkVTZ2ZHOGkvL2h4bGlFaWhVQ28zUlZBUGZpV2ZOajF4eGJxMjVjYVlw?=
 =?utf-8?B?NHlqaEw0cHlpNGI3THBLdmE0SC95bkF3VjdhNVBKaHhaSmtTYWl3UWJvRFVu?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a1e7cd-6cbd-4e2a-bfbb-08dbc45663a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:19:12.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGFENaWPR1D06FRDvGOUly1bY3SDYrzQvX6v6oJhBuE7bMqQLoPMv182GKoXsgOOX5dhRo5CtC74SBei+COzl+0v1bwm9wk2k4CRDQc8YY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> The rdt_enable_key is switched when resctrl is mounted, and used to
> prevent a second mount of the filesystem. It also enables the
> architecture's context switch code.
> 
> This requires another architecture to have the same set of static-keys,
> as resctrl depends on them too. The existing users of these static-keys
> are implicitly also checking if the filesystem is mounted.
> 
> Make the resctrl_mounted checks explicit: resctrl can keep track of
> whether it has been mounted once. This doesn't need to be combined with
> whether the arch code is context switching the CLOSID.
> 
> rdt_mon_enable_key is never used just to test that resctrl is mounted,
> but does also have this implication. Add a resctrl_mounted to all uses
> of rdt_mon_enable_key. This will allow rdt_mon_enable_key to be swapped
> with a helper in a subsequent patch.
> 
> This will allow the static-key changing to be moved behind resctrl_arch_
> calls.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
