Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6F7B26E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjI1UyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjI1UyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:54:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479D19C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695934449; x=1727470449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CWQpb3nag/XXkDzGT3Qv+I3GHwFaEcKGpNDCVPtLmJ8=;
  b=Q7Mefe7vJJq37sK1+cGBdCIfnXFC9fB9r58sbm3ilgoIQRcrO/8k7XvD
   PSfTQbPxVP7s5sIgDLfoPXNLv8F9a0nYy5Am7/1xEFyh9a8uuyQlT4e/p
   3Ssghe72+yYIapVkvDpY3Wnhx1agZmjR3AxSmSXZNXs3MuzqPJyx2BI5K
   mnEgbmCnInX5qLggpEBHDWVcuqBL0Bkyu8Pe3fRyWzgad+okR9RVSXF21
   zvAcc1WjVJLfWwHdhyZC5CNlLiporiL6dndYK8seZV+pGpkxF2WEEFgVq
   jvv0dUqgwMk1TL9QjwB6UrDRPGmxN+qAhTT15Z5PO46/3HV+UNNqBFBOl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="381061826"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="381061826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923387885"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="923387885"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 13:47:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 13:47:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 13:47:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 13:47:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 13:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaOZhgRdZO6AWgdiG+/RjU8xpROEzRKO+eth7LigHpSgyiQ65ds+t0LLOqi9XyQhB1ZYuET/qvhDZ59AY2jsTsv73wRg6Qka8wDE8Qk5gq9WxyWZdLReqtiFWQp2fgSZeGgvWQhd42zSDuPnMkYYlfTAp4Yf06gcw3UT5vYQaQHN3RB/4VKFdRA95oWBTk40d6JMMqf9Go/wfVE6TNj9yjPC1v6oUejJiDs8biQmFWSBaCoKLx0e5bn4bYZatzcjd8b/BdtBBo4jvUKRSbcVvrwvPKavnbe4BMXzhpZCO5NuJlwY91griAxUks9wQMbT9uzY9SdSPEzpnq+dQPODkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSre/qjYZ6ewLMQ3EEly3sQ9V6dBLM+Xi51EKNKrwpA=;
 b=IKqPzisdsGx2ieOuBlFQiVLyIcEfiytzAX/EzhMvq+W6EBemSuKEdEQodVAqWqpIWjDvuMY2u4OZcCM2y1zLwPmyPFqn/qA41klhexpyFx5ATlqz8IaW9nvFVK1ErZLopsVdAFINvmKK5t1G104OLL8QNQArqYkg6+RIj8+VRW1D03vqvDxxUdbQgPMaFFj6mjIZjl2PqFQwUVYh+NqbpRs9fcl6jOuuEeQxqMRLRYNO2/zdRASRLd5KEHe8XwOuO5fxUC7UDm9S++RdyR4c457CR84GlS4Txz47ZHWv3EKkFfHfhDKJBsFaYppam3nm6Vb6biB3v+H2gK7+UI/qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 20:47:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 20:47:33 +0000
Message-ID: <e72b4ba4-762c-e3da-60f1-eee4f99c87cf@intel.com>
Date:   Thu, 28 Sep 2023 13:47:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/4] x86/resctrl: Add sparse_masks file in info
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <3b7f8c61f0f443e303bc9c5075566b89ffdebe7f.1695371055.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3b7f8c61f0f443e303bc9c5075566b89ffdebe7f.1695371055.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:303:6a::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e002e1-54ca-4101-e533-08dbc064239a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EArBnKvT4Yi+YyHAgEgoipyeS/ka1vSkMT7EG6OgKZEMM41JAyoIun/kHWIBO0WyKR5WyeiZepSKwp70Exii+fPJZgHHkDSW7IYl0J2Jt/js1qKQf7jBfBYTvhkPT9TNJdylasxIY0gGin52MeCW6As2xCL8DApOODRvssqKY2uHbmPuyUj4Uayw+U12yc8Em5bP4V9rB7qnLom8qbZwfN2J1043KB261JrWuLDjkEc+Yh4QpzNkAHRFxNSaX9wJDWILQU6tiwX1nwoyEUV79YOv8tOCPPCsrAILazUnL6RFnNVtzVvzCj1zrS2+d1oqJ4pUYkfzw1s9m3q+pc9xLCrq//utQ1ZAlKfqFNIREDvkDMjJzKgLKCzUq81qcpYyWI+hvaMPnT3dFW0oAJ7//Y3wFOL9cmhi+OZPCuqOohr2nM4taBbSaOUSviqdYtq3N3YMUupg91LHpcJjct2B7PW3jMdnYBYUMnk7RD05DHx6qSBf36bRObcnJUBrcO9ka9CnMdVkRbaqe9t/+t6y99vaQrvssZd/mceKHK4aAI2nCK/34fXkZH4DOBfYjwe4LILgTrLZLPqP5TEs8Ebh+E63WTE/IzR1wiRqbEB1+GkubE4Z5ZiOXcBtsETvqkov2C/2V+1vT/dudPYpQ+khcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(6512007)(6506007)(38100700002)(2616005)(110136005)(66556008)(66476007)(31696002)(86362001)(478600001)(53546011)(6486002)(26005)(82960400001)(66946007)(4744005)(5660300002)(36756003)(44832011)(41300700001)(316002)(4326008)(8676002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NjTUVLaU42L3UyWDNtVzdHaWYycVR0dXBjTGs4Q0s1WjRkRXpuYkRETElQ?=
 =?utf-8?B?eU5UaWxvZG5iazlFMXBvNWpFWHR1LzJLRnJxZmd0NEdsQmhGeDRDRmRyd1BW?=
 =?utf-8?B?TklEdTBQYW9HQ1piRjJRUmYwTHlOWEhWckIyVFpMUVk2WkxDVXl0UUNNcFhv?=
 =?utf-8?B?bGVhY2R0UG12bmdkaHNwRitpVGMrSlVySDFNUFpxWnNIQmFQcVkwZHZzTTRI?=
 =?utf-8?B?Y05tVUxNaTB1WTY2L0w0RjltaFgwa2pRRU5IRE9KYzRPSHJUdWJHRmdUdU1J?=
 =?utf-8?B?SHJTYkViWFROWjBDb1VScHVYL3JMNm5NeXArKzQ3UXc0cVQ2cldidTFaVjBM?=
 =?utf-8?B?NW00eEwwODBzdm9iOUVmV3d4SzN1RUZNMDJ4YVJ4UlZ2ZzRwK0U2eDRnNHNZ?=
 =?utf-8?B?TS9WQnJyZmVnbXc4TUttU0N2S2NMV2t4cGpyOUlJOGZSVmlQeHBscUgzRnJB?=
 =?utf-8?B?VytWTTR2WUpycHZVdkdxTmZFcFI4ZHBlU05WN2txSTVNYWJ6ZVM1SFVFdXJ4?=
 =?utf-8?B?dWFDRFp4NGdlakpIWTh6cnJiMkJqWGszSmNxZ0Jia0EvUGR2NjNCWXY5KzAv?=
 =?utf-8?B?NWlCRzFPRWRxcHJrbUhFWjV4VVlOSndDdDdyLytRb1lUMVJubWJqL2dhbjh3?=
 =?utf-8?B?WHAxOFdPN0RtaldmYVdHSndyWXE4dEJnYkRxOXN0UXBhVHNUWmFXckt1M2dX?=
 =?utf-8?B?b3F0anhGN0xXRTI1SmVkcWdxSjN5Z0Zzb0F2L0dRVUMvLzN1REh1QlFvOGdG?=
 =?utf-8?B?WGR0S2c1MDMzZkRQUW1EWmgxUitsTUhNUWtZQm1jV1lSR1J2OVFCU2xHeGwr?=
 =?utf-8?B?T1FiV1FsWDMvZUc1YWNQSWJaZTJwL3ZtZUs1SnorTk9nNGZ5SVF5NkJNVE8v?=
 =?utf-8?B?OHJnaXVzNVd6ZjBYZWNPUWkrU3RWWTczd3hETFlvY0xpNjBybFVWUmtIWFkz?=
 =?utf-8?B?VzM5YzhmK2tCRVlVZ2E0ZnpUaWdoT0FoRTluQmhoYnJrV2MrZGV3VTc3OW1z?=
 =?utf-8?B?QVp3UWZDa0lBUmYxc1JnV2xIcVpTYVNyY0pzOVhMeForOGhpSUorVU8rcExV?=
 =?utf-8?B?Q0o5TlFWOW1nSXcrZStXZTJmbHg2RFo3c2NTeVVBbTF5ZFE5dmIzcDlLbkEy?=
 =?utf-8?B?WjQ1cG9jMDlnTEtzejlSZHFPSnBRODkrVFhtUzlQSFBSNnJhdmltL3JIQXZh?=
 =?utf-8?B?dmFDOFVzZy9qcTVYN3RRU05aRXFNMjJEMjhLMkwyeXhJeHBtdWNrSTAvaFky?=
 =?utf-8?B?dDJlQzZKbkFHNnk3L0hubUJETllRRklIMWxwN2NOU0pRZmpRQTNQbUVlVi9w?=
 =?utf-8?B?RGJrRk9Nc3gzQkhkSGZxSkxaeDVxb0s4NXkyWE1aeEhhM21scHNlamxXVUlC?=
 =?utf-8?B?akJnQ1NkeFNHTFJRcHBIM2FWOTdnMjZmOXo5MDJWTUNad3hSL1BPZXFVa0kr?=
 =?utf-8?B?aHpNb3ZlSC8wenpJVzRuOFNVc1RKcUpnbHZjc3Znc21SdUpoc3BDUFIyTnlV?=
 =?utf-8?B?dVhRb1IvaHZJU1UxMmZXYi9CMlg2MWl0bGdHTHM5OTlEUUs0THhlTndJcnVY?=
 =?utf-8?B?Q1pRR21qWVpmWGZjTkZpd1ZySW9GYXFsSGZ1d3pRazJaUjNnOXFaK2l1S1F5?=
 =?utf-8?B?ZWVyTDFmaEVSZnJ3bUVYRDdObzFIcnBQT1VVWDU3QTUwL09PQ2lHZmxWR3hs?=
 =?utf-8?B?eitLVlFyRDdtOGpPSU1qZmFCU1NvejhsZmpUcFhHUTY1TjcwM2lBMU9Fc1Nt?=
 =?utf-8?B?WXgxY1dvS0VCQ2wwQ0lnLzlsYURvNG1UU0dMYk9nS3BWdlBjSEtCYzd0QjdU?=
 =?utf-8?B?YnV5QTlZdW1WMmpwZm5lRytHSG9sNld1YWtoZVFmbmZHcG9MNE1pN01DN1Zo?=
 =?utf-8?B?SzkyQ0paa0wzQmIxeHVDbFJVZkMxbXp6Nk5ZekdydTZlSXdqYmRIOVk2MjR0?=
 =?utf-8?B?V1FIOGhuU2NaWHY0ZVdMaFVVZkFkdTBoQmhINFBKN2hRNVNlMlFKakxRd1RM?=
 =?utf-8?B?aFI0ZXUrQlFQdXY4aVNOWlI3ZUIwZGJLUXV4UGk2c3pORjZYdExIbGtCcUVq?=
 =?utf-8?B?WVcxeWVJWjBYWXNhZmpEdWFCVHlRRVZNQ3JuN1RLdk05UElpTE5DWW51ZDZk?=
 =?utf-8?B?UGUxL0QwdTlBQ0t6dmc5T29zVTRUWFRKbGxsdmF5dk5keGpBQnhNcUgxSlJK?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e002e1-54ca-4101-e533-08dbc064239a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:47:33.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IcNfbkQ4i5GgellwmQioRiZN5pa1KjbAAD5HsqZVRr7b7DybeL0Xe05XCXU6Wn1eYtRBc0snNmv+cxU85XbnKel4VKzVbuddEnYc/UTMvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 9/22/2023 1:48 AM, Maciej Wieczor-Retman wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Add the interface in resctrl FS to show if sparse cache allocations

Should this maybe be "cache allocation"?

> bit masks are supported on the platform. Reading the file returns
> either a "1" if non-contiguous 1s are supported and "0" otherwise.
> The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
> {resource} can be either "L2" or "L3".
> 

Reinette
