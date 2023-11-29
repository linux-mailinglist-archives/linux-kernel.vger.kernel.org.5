Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13077FD7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjK2NNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjK2NNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:13:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB90D7F;
        Wed, 29 Nov 2023 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701263602; x=1732799602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r4AHomz3YRxgcdvEwk6CG3VKaf9nDMI387PB2+3vwro=;
  b=JuAt5x4gL+71Q4ihSDTp/PoEfskEEWJwAVt7ONxUF/yt3MawNzF4XBPz
   g4v8olqOLTqy+SmGzU7xFRoUNrS9ZiNXaPF4ehxB6rHZZ7ah0w2ZKStK/
   YAXX4+Z6wxDt61S+2QB6Kwq4dMOXICnIoJKHOwVN+QAoAnWC9XcjiEvUq
   38EoMDbrL6JHrKSPYo5wjbj4oFCFJHKymcqRA+G/vpL80OpmusN9QBITR
   Z68vqTQevcWHFOjeQyimV2Dpug9FxjGS9e45/13aI+MJqwbEc/1svx/W4
   2Hyi2WBhfre1x/nF5wIXKxBwi/Hq85cbKm0ZsJIHYNWfN8HEKG2MoFfg1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392904097"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="392904097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="17006835"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 05:13:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:13:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:13:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 05:13:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 05:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhRr40W0uP3Cr84es8+lWELFqNCqn1JTr6VBH5w+NbcHzRV2+yEUgBk3USpoUfoplnsjIQBP3JqNbe/14+I06J0IiUIRGNCzBTskCMHSfZ2rYVpXP1aihaszOgA4+r8i5E2midAAucvL7Pzi/4Q+L+BFco85u5N0Fo5S2eEYXNZVzc/voyLfcnFJfqPjUh1gK2LnDPijxtscBzTIqdn11nn3YdmP70Ejfg0XNJhkJM6sKjZ5BzDvQJlhHctazxphB+wbGOZlRYnwDvb+OYXX60Q5k8sIYJWVk8nDdT3qnmVC+DIrwOLj/Sxfp5i2rSQ1OKecDYSChS/eLp40ba58bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRTWaIjtVzk/Ye6bdJ0ZsOnjNTMyFr7Eo2mJhN+1nOE=;
 b=DFDATL62XSWF7zF2TaLD/OVpDJgxjSux/fw2+8PhtgczLTMKCpC/+44n7rPNVY5oEHegJenAwE59IMkJoX+4kAhEZI8NPxQyNdne+YDoqx/lodoGUNCvHbSckyaXPd1+CGRS8kLXd/zSoDKdsgH9Bb2KpJQOgNASUAXuCigL4HzJQzFOnu4knDl7m1TZKyb1ipwfTQGSWqsgaqPreo5kx3/TSC+jD3DIkMcKzE8N9Q+JbrJyzcbfYRgGB/ImCan2PPxAtzXzcKzZIASWM6fSgl5tVErP5aijXaYrThlE2291hw3F92U2rCkx7MkP/ecRXesmpZ7HSKlwB72sJXNmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB4832.namprd11.prod.outlook.com (2603:10b6:a03:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 13:13:14 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:13:14 +0000
Message-ID: <994c4c2e-63c1-40ab-a270-325c8a5f5f39@intel.com>
Date:   Wed, 29 Nov 2023 14:12:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-2-aleksander.lobakin@intel.com>
 <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
 <5e6859d3-d3e7-44c1-acee-2c4ec568615d@intel.com>
 <bd35cf74-698f-e811-43be-af207a88fdc7@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <bd35cf74-698f-e811-43be-af207a88fdc7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddb7a98-186e-4570-3188-08dbf0dcf167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tE6Cor2kuTHLuToEpbCj+8kUB4n3CqFc9gXx+nf1XoGeplMJKcTq1KGGZiTGa4wmgt/wf7eW4uZ2Fn8l4ITVzq1c0EPMqvR/ubj6gqHPAdac6ayrMz8h7Nvpk1WABwr4KUrn1rxCr1rLP0sMIUhRUhCnMe+/D452E5t2zUpJIYYjJCuXmFLYH5ns8N8TcOe+FFQpp5FrRV22PBeq8ZVgdpTb+r72HF0JD7ge47I/guPfe3pE29USXmQK5cEH/5v/6drOZozUtyVfVJiRKnLakoBf6bxgR2j+A8o8GD2lo6V7Tg4NncEDreCe/a16Lb8St9cE/Q0Zz7/m5B354q8HCAIAbaqfnhe5RkS3ALggUdWpFIM2WVYg1nR/ARjyyhuL0lIC6v+qAE/rLkyQo5DApbgeNsjF0QCp9N88iuSzI1a+GjFSOQzTXaAPAFPkVSBlUX8xYa0yRGnaaGCWI8VtVBu+UyBOVB91t8/VDXy/7FvtgmxZSnXCwrrLyqtB65c/RPSv6rV+yQ/QFfh7a/feq6STuYx08p0nsGS7q0gYKHLce4yEt/q0awBT7SstClkUhkq3V1QHgiQh2dbHZe5k61XBVN4ZvLaxDbCx+TBbpo4ZApAjhD7e7Lu0LzRELFXk5F3e9ALEWgyhDM8CAHi6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6666004)(6512007)(6506007)(6486002)(8936002)(53546011)(478600001)(66476007)(316002)(66946007)(66556008)(4326008)(31686004)(6916009)(54906003)(8676002)(86362001)(31696002)(26005)(2616005)(2906002)(83380400001)(36756003)(41300700001)(82960400001)(38100700002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVXY1ZzdUtmUER5TVJFWEpIWGdNVC8vdHB3NWFXTmFnMml0YjdQaTFQajNP?=
 =?utf-8?B?blZVbGV6SXl4RmRJbG9uNk1KMldNNW9BNlBoQXBTSjBqM1VYUSs3UWtpYkZ0?=
 =?utf-8?B?QjhzemZMSFBUcldOM09HZEVkVlk3M0lFYkNrcHc4L1A4TVNuTWpnOFpxZG5S?=
 =?utf-8?B?N1ZZYS9yQi8rc3NqK2g4UUtYZmJZZ2N0OXFGckVOUmhNdGZrWGhzVkMzZlZ4?=
 =?utf-8?B?L3pvR0ttTHM4dlFORXFpSTYvcXZINEJZTzJraXVKdkRua2swUEtlK1d6L2lV?=
 =?utf-8?B?MnlWdUZISEoxSk84aENIU3JFbTJNZk93S0xqQlBKTGJQQm5lcE5LWGRCanYz?=
 =?utf-8?B?NzZBR29kVVkwVnRDZzJIaWg4eWRSRXBDSmhhS1cvTHlLREhGSmdBS29oWURK?=
 =?utf-8?B?c3Iwa2kyTEN3UDhKQTlyZGJUUzZoaGk4NkZzSExxUjRKTklhWkFCbEdYMEhx?=
 =?utf-8?B?UW1EU1hWK0IrTVphUjNOMUs2b0t4S2VDMUNuQm15aUFObUhWUFExMU5CbjNq?=
 =?utf-8?B?QU90SlJqL1AzOU40cVhPZlpsK2t3Zy92ZjY2ZnhSVzg4U1dUdFoya0NzTlRS?=
 =?utf-8?B?WE9vdklMdzV3ckdoMnk5cTQ2blRzOFVCNW9oL1lvT0pVOXA5ejNjT29hR20r?=
 =?utf-8?B?MDF3ekhPdnhvaUtJZ0Rjcm5lUU82Z0gwOHY4QkhjN0RyVElwc0VldVhkZlZm?=
 =?utf-8?B?dkVQRlI4Z3VQUUJxV0l1QVRuMmlyU1R1NnA0QVdlUElzTUJlM2dTTTZWbFJx?=
 =?utf-8?B?NU5iMEs1VnEwTzJEakFtcDJOTEVqVzJGaW42MzNIOTRhelVhZFBRdWdiWDJq?=
 =?utf-8?B?dC90d0RXRm5KbGlWQ2RWV00wVytaOGd1M3pFU1F5OVVLSEZjWmJmS1B3ckNP?=
 =?utf-8?B?azg0ajY3M3p6cHJPRFVXdVJIUVp5Uk9ySHhVcjJQakpYbzY3UURUa0pxc2tH?=
 =?utf-8?B?ZDBNSUR0eXgyYS9lMllON2dyRVg5cEVFWnhtRGhRVnU2ZGZyNGNoeVZxSHdt?=
 =?utf-8?B?ZFdiSmRhazF0UlZMU284MmYrdWg0WnFnM0J6RjB2azNkVjB5Qkt1L1hrWE1M?=
 =?utf-8?B?QTlKTjY3bDN3OVdMTXlDRGJwWHZ5Vkt1WkFXODFZVHNxWnpkNnc0M2c3bno5?=
 =?utf-8?B?bHJqTG1SbVIwYldCV3ZrQnc2dmcrdEVsRFlPSWYzVlpuNVdNN2RTWk5XZEF0?=
 =?utf-8?B?TVhMSXZGNmxydERRcytXZlRCbjAzU0xLUTg2MlRiZjRFVWtUOUNxQUJOa09I?=
 =?utf-8?B?aVpHbE5OZVFNL0hyUzNMVHV3em0vMS9iNnIwdFJFeFJXbnAyMWV2VEFpODBD?=
 =?utf-8?B?b1VQQlFab0EvOW4xNWlpL3EvampQSlErcTlIMjdUWVB6V2t2eDdKaUdpb1hj?=
 =?utf-8?B?YldZYmFLVmRvWlFWU2V5T0pOdGNlc0MrY2NGRXNTSmNLaDVJWVQ2NUlDdjA5?=
 =?utf-8?B?MHpmdHlqenVib0JMWGI0cCtIa1BxZ0lObHNQSWFGb0pIQmJqN2NMK014M2NJ?=
 =?utf-8?B?cmQwREx4QWRTQTUzam5kb2ZpZDdEREFPUWR5bzhOdzdrd3JhaUxlVWx0Rm0x?=
 =?utf-8?B?NHYzQUN0NWtRbFY0dDFya3F5UXl6QmNnMXQxanVjV25OYVRIVkhTamxLNy9D?=
 =?utf-8?B?TFdId2JQcm1Zb3h5bEQvK1g0ZnQ0czBHMEZDaUtwUUdGMGNYbG9RbTdRWXNB?=
 =?utf-8?B?Q3EzQTJERU5hVVNYREdvTGNpTFJWUGwyTEhBN0hkb1VjOXdwd0gzYVJDbkIr?=
 =?utf-8?B?NUdycnladHkrLzd4UUFwR1NTUGlNYmtyWjFRVDM2aUxCalNCaityMFM3bGFR?=
 =?utf-8?B?WG1qUlUyQU5DOVZMaFlULzZUaS9CVjEwZEZIU2U0YTdmNzN3SjF4NGJoNXRD?=
 =?utf-8?B?OXJwRnVveE5tak9heERReGtWZXNiSWVqRTNodkxnODZ3RlRDV2pIZ2FVMUdK?=
 =?utf-8?B?QmxrWnZFOG9pYWV2U3hOY0U5Skk3bTIwdkNnb081bkFRTDh6aWthWmJBN3FL?=
 =?utf-8?B?UFl1ek82WWVnZ0FBb0l6QVhzMUxBUVNZSDU2L0xYVkg4YmFQeER4U2VWU1o0?=
 =?utf-8?B?eGdyZTlnNFhTekw4N1M2WjZ4WmxJWTlQSjQweFlxVEJhcHBsbW8rZEoydW0w?=
 =?utf-8?B?R0U1YWZTUUFEa3VSZ01haHZib1EvcXVheHNJbUdnVFBCWGRsWlZGSHJqalpo?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddb7a98-186e-4570-3188-08dbf0dcf167
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:13:14.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3S+vCtDissSpYxXdl56g76ODMCl69UnOhxJXo5Lcp2QYZ6RjyYNbGpWYRjB5QojtTaaOs5nwbYvRwNlE0XAoJAV4pOkGFCbrlLDpZrtLvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 29 Nov 2023 10:55:00 +0800

> On 2023/11/27 22:08, Alexander Lobakin wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Sat, 25 Nov 2023 20:29:22 +0800
>>
>>> On 2023/11/24 23:47, Alexander Lobakin wrote:
>>>> After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
>>>> into fast and slow") that made &page_pool contain only "hot" params at
>>>> the start, cacheline boundary chops frag API fields group in the middle
>>>> again.
>>>> To not bother with this each time fast params get expanded or shrunk,
>>>> let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
>>>> their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
>>>> the 32-bit architectures and 32-byte alignment for the 64-bit ones,
>>>> excluding unnecessary false-sharing.
>>>>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> ---
>>>>  include/net/page_pool/types.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>>>> index e1bb92c192de..989d07b831fc 100644
>>>> --- a/include/net/page_pool/types.h
>>>> +++ b/include/net/page_pool/types.h
>>>> @@ -127,7 +127,7 @@ struct page_pool {
>>>>  
>>>>  	bool has_init_callback;
>>>
>>> It seems odd to have only a slow field between tow fast
>>> field group, isn't it better to move it to the end of
>>> page_pool or where is more appropriate?
>>
>> 1. There will be more in the subsequent patches.
>> 2. ::has_init_callback happens each new page allocation, it's not slow.
>>    Jakub did put it here for purpose.
>>
>>>
>>>>  
>>>> -	long frag_users;
>>>> +	long frag_users __aligned(4 * sizeof(long));
>>>
>>> If we need that, why not just use '____cacheline_aligned_in_smp'?
>>
>> It can be an overkill. We don't need a full cacheline, but only these
>> fields to stay within one, no matter whether they are in the beginning
>> of it or at the end.
> 
> I am still a little lost here, A comment explaining why using '4' in the
> above would be really helpful here.

The block is: 2 longs (users, frag pointer) and 2 ints (offset, cnt).
On 32-bit architectures, longs == ints, so that this effectively means 4
longs.
On 64-bit architectures, long is 8 bytes and int is 4, so that the value
becomes 2 * 8 + 2 * 4 = 24, but the alignment must be a pow-2. The
closest pow-2 to 24 is 32, which equals to 4 * 8 = 4 longs.
At the end, regardless of the architecture, the desired alignment would
end up as 4 * longs. As I wrote earlier, we could do something like

__aligned(roundup_pow_of_2(2 * sizeof(long) + 2 * sizeof(int)))

but doesn't that seem ugly as hell?

As I replied to Jakub, I'll add a comment in the code (so that you
wouldn't need refer to the Git history / commit message) in the next
version.

Thanks,
Olek
