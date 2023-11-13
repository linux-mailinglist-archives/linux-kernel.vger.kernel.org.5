Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BC7EA3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjKMTcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:32:33 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC31D46;
        Mon, 13 Nov 2023 11:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECUxM66+di8NwwOAwaT4tsNvdJyALqJkPbZc3mnKLwI5T4P5AJ932RtsM0RijkV8TiKougnrXBySidLRxQhFSw5nN3W9LtXEHYhyA0gp0WfryDsfk4MY6ogHYsYs3S56Na326WtvmdJj0h2jBCDIQGuGk/LRg3k7+VdfVltps9vPkgny4CLFOkB44kgycEDbjVarqGWZRn4cvhidI6q5o0ROJQU3LKef3njgQtA7cLiGLOQvK1WhM2jaH60BzyVx3byjFDa+VAUdjaXl18W6NQ4DkbwdkOKXkeDQn3hCjHi1cMMaINmBTsAXSMz17nbSI3olOQZt0T3w+zlNsnqSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrK3y5vocn+GKpRrmRyGf32MppcE7+P0tYoyUt0Ndvs=;
 b=WRe1msSkEgJevRa+drsHI+MgzSL1IM6lEFnZIyNJ6/P5EnWdQtDAul1vRnP89xNS+K2N4Xm8q/v8HzsCiVd76fOSIPeDbRIBkvbSfsRBqawOEYSOk7UHxWtiGl0m1NpudqkOK6r6GQQvmuPTVFiZ+4cIe/j4s56B+FSALeAB8lg56OJQVdqH4iWZUYd2H9ByLZBSmh4I3gIESm927MKclv/8wzrW6XqcyxwFtUOFHFjfhe/QZQ3/amzfbtRT7Za20IpwGqq4W4HCtmop66n/sZr0b/JouR9xGC3/cbG+DaKdRw5/7lI6FuDWhNPgq9eI6t6BNP+uE/C+R/xBWEQAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrK3y5vocn+GKpRrmRyGf32MppcE7+P0tYoyUt0Ndvs=;
 b=UqWM5qO/Zv1BZsFDLEGf/d6kBzVdP1q9cTEWGz/zlGLoFxP2MFmHT53jhzhCNfygcZeHIxFoo2zje0BO+vSeSDQ4/lEmQLLhhkCJUnB6/JlF2Tuzm0DB0s9aT6uaouKKyEGuiIRnxjmMHMZ+S1/RFI2FF3Ssr89nHfkb+nGzuKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 19:32:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.026; Mon, 13 Nov 2023
 19:32:23 +0000
Message-ID: <3ccfc85d-f8ec-4230-ae4b-c231ff39bb98@amd.com>
Date:   Mon, 13 Nov 2023 13:32:20 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare to split rdt_domain
 structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-3-tony.luck@intel.com>
 <678ea7e8-e4e5-4848-b77c-a94a1d326f5b@amd.com>
 <ZVJwVs5ayxKzC5pX@agluck-desk3>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZVJwVs5ayxKzC5pX@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:806:22::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a0f7d5-2b84-45b5-01fd-08dbe47f428d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yb5IGUyE2PRy/9AXzX3xC4h3t+cNd+upZpGb3bgcbKzPES/mTAQ4x7RmK+UiE2/y+QiTM+LL90bA5QX7MwwYlIu6Kcpa35h+P/GYhuylL/moYWJckuSw8lAVQScECnWsVcVNep941r/xKQcz8QUF+DncHdggPXbReOJ6tTANE4IrP1VwzobNh0gDuspvPwCf2PUmKBdkXdfNr0DFS2dHdYcLQZVS2PXj5WOyy4k+EAosYjd3KkKEp84TNqbCvCgGe88BLGwjUHMeutGe07eRAfvIh5ccQJ4aNZVy5L5kXlP09m28foHuQ3ubL1f1XHVvFmL95pOyYpZbWvSnR5DL1Kq/5JffeAA/ychbRiuA7KUkBKmSxMfvKr/nfszeAr4qKP5KarzZpNTnAum0WKCb8AIPo1oH1MoTw4S96N+2AM1xBy0z6XJJrq2NnK0ApMb++fCn9q328HNPCAzEIDgY2MsqndfRJ4UHcXLfWDxCXO0hC68bwer5lGJ3SxMNYHMvNYBQzhF6bUvsCVw+qjPSOMu4btqZI10eZm0GysMqGL8axQDDVkY3KdwCN4fq97Vhh/Xu4PBNKFFIs0XMdGAKfFQ6g3Osgzu12Hp5Aiyn40TtbVWxgld8rKn2l8pzm8b1aPIXP7U7190L/u2dSKs2Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(31686004)(2906002)(3450700001)(6506007)(66556008)(7416002)(83380400001)(5660300002)(36756003)(8676002)(8936002)(4326008)(66476007)(316002)(66946007)(966005)(6486002)(86362001)(31696002)(53546011)(478600001)(6512007)(54906003)(26005)(2616005)(6916009)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXF4aHNDdWdQVzdFS1lXYnpSZEZKc1JlMTJ3YkMzNWFqTitmdjhjZjBLWFMy?=
 =?utf-8?B?VGg5ci9EV1ZVYjIwaFF4dFNOWSswbjBpM0RPTVlwWEhTbWxhRkRVcXUrdzd0?=
 =?utf-8?B?a0FWemhFcTZZcDNieVhBVEkzVXlCODhSRVlBUDZGekQ1Ty9YZzVwb2srMU5v?=
 =?utf-8?B?ZnZKSTNpak9XRktYaHlLeFplNUc1K3VXQWFZaEo0U3RaQkJaV2FtelhDYVpq?=
 =?utf-8?B?aDRmRFZaZzFCT1ozWHZmSnMxTU45NXlIa1MwWGwyS2htdjNWMWJ1dTh4S09G?=
 =?utf-8?B?czdhNmtZWGx6cXBIQlkrRDdNYnJDc3RHd0RuY00veG1ZbG10WGlzRENJRStC?=
 =?utf-8?B?dWNTQ25LWHNjWjRiTzNrTDdhclU5NWRUTUVWOUJ2ZDNZUGRSWDdJbGhGckto?=
 =?utf-8?B?VEROM1Fodzh4VmNOODBJOHpTajR3WGxTSVJwb3I3SkFTNzM4STBtclpoN1lR?=
 =?utf-8?B?dTVibTF3WE9vRjNuTXg3NFlMeGcxc2V5ZnkraGt4MFZYWnpjSUMzZU9wODIz?=
 =?utf-8?B?MFpHbWhrRU5JZkFHL1RJRGU0aE1KalJMT1l5TVNCTWYvUkQ5ODVaOHo1K1Q0?=
 =?utf-8?B?NGIzQ3FiQXZTM2FtVHVFQi84S0lOeE1BZU9JUnliVUxxeXZqVVBSM2c0Rlpw?=
 =?utf-8?B?cER4bEFCY0FRcml3VEFTVzE4M2hkUVVhejNJdkRUWHdoMmp4WW5qc0lZWUo3?=
 =?utf-8?B?Y0JLTTdNaGIxNEVRdTB5VjNzYmc2RTl3b25oM2VFUGxKOWtJeG50dHRIR0lO?=
 =?utf-8?B?bEJWd3ZzREpOc3U4cXl6U2ZZZHoxQlpxd0F4Tml0SEtZam45VDMvNUR5Tm5K?=
 =?utf-8?B?SWpHVGk3bEllbmtlOXhaUVFuNm9NZUIvcVE2R3h1bktPZDgyNFpFYndyR2Nl?=
 =?utf-8?B?MXppZ0lWayswcnAwc0pSYmhjeU9XWGx0bEtOWmtMSzA3elQyU2Z1T05qRVJX?=
 =?utf-8?B?ajMxVndrSjU5ZTk5RjYvL2lIL1FwYWtLaGQyOThMVHh6cFptUXEyNXQyTC9t?=
 =?utf-8?B?SXVhS2RWdm5HSVpVeXd5azk2anVWMm9SQWYzU1hEUk9lSHlSNTZMWXl5bW5x?=
 =?utf-8?B?NFl5dXRtd291dFVDblFQVEd1TWFHTkZudDUvRDBibjVoUGZodUFRWDRsbkg0?=
 =?utf-8?B?UGNyd2xJZjZ3OW0xMlM4aXFlQ1d6bTRXL3NFclQ1Z1BhNDRKN1EwdTJGYXFV?=
 =?utf-8?B?YTJla2Z1TE5FYkZqSzQ2ZVJQbEh1YjI4YnRQU1VBYWpDei9ydXV2ZFNFY0hV?=
 =?utf-8?B?TWdNRXB5dm1UOVJtZEx1Z3Ywb2hoaWJwVE04Ymh5L2wvZ0xuUzFlc0k5TC9N?=
 =?utf-8?B?dkgzODJmOEpBZUFKWEhsdFozTnZvemFBeFBpVk81NHorNUJzS0FQMGFTNTd4?=
 =?utf-8?B?VURlSHpFcVpwc1BvYzZJZWVnUHpkdHAyRGlLQ0FsWVM2WVIrVkowTWFuL0pt?=
 =?utf-8?B?KzhFNjlzZ1FhYk1pU2xqTDliakNDdFdhTHQyTkNHNC85dURmeDBvVlE0dTBQ?=
 =?utf-8?B?bHpadFFhWXVrZFNkbWNNMmdkcVJ2cWZwb2c3aDZsU1FkNnlIVnprNG5MSnhG?=
 =?utf-8?B?bTJZcGV3ZmU2VDNEL2ozaWEwV21aVUM2d25oQnVnbW1MMGRGenNRYkFQZlVF?=
 =?utf-8?B?eE1EdWg2a3pheWpGSThPUHR4TGRMV0xCWStzbXUzcHYrZE92YnRZYTFEc0th?=
 =?utf-8?B?OHZzMmJPUWxFSGFodHV5MDBTdXBRc1ZDVHU5SUh5NFpxK25sNlFRVzMweWRM?=
 =?utf-8?B?ZWpISUc0S0RMbjRMOEdMUWFNSXNaN29OT1dVSnFSM1NRUHNXVDhoLzZiQ2pM?=
 =?utf-8?B?RnV3dDJ1Zjh2aHU0L3VxY0hkUDBFYTk5TzdObEhNMFRaOUZMbkJkZ3dveVRq?=
 =?utf-8?B?VTh2enZsN3dlVUxUd2phNDdDdXQxcU96ZWVrNitOS1dHblFyanJWRmV5K0J2?=
 =?utf-8?B?clppT2NYOWgvOEw2czNsdnMyRjFGOGIycWxWeVNmclJDUUNlQ3Z5TTRQT0Vk?=
 =?utf-8?B?VVYzL1BsUFRCL2szOGJHbmN4S0hpRk9JVlpzbGFHVDk0RWZDVVA4S0ZQdnhG?=
 =?utf-8?B?cFVFc2tFZnJqODRKOFhCQUN1NUR4OC93c0IwdS9BWFQra0llWDdFbEQ5bUxM?=
 =?utf-8?Q?uYVU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a0f7d5-2b84-45b5-01fd-08dbe47f428d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 19:32:23.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfBtVI2limAslqzPOOvTZ/CcxZmYl3fPgiKNN34oiNAijGH/t7zigRX+V1DswHI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 12:52, Tony Luck wrote:
> On Mon, Nov 13, 2023 at 12:08:19PM -0600, Moger, Babu wrote:
>> Hi Tony,
>>
>> Sorry for the late review. The patches look good for the most part. But we
>> can simplify a little more. Please see my comments below.
>>
>>
>> On 11/9/23 17:09, Tony Luck wrote:
>>> The rdt_domain structure is used for both control and monitor features.
>>> It is about to be split into separate structures for these two usages
>>> because the scope for control and monitoring features for a resource
>>> will be different for future resources.
>>>
>>> To allow for common code that scans a list of domains looking for a
>>> specific domain id, move all the common fields ("list", "id", "cpu_mask")
>>> into their own structure within the rdt_domain structure.
>>>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>>  include/linux/resctrl.h                   | 16 ++++--
>>>  arch/x86/kernel/cpu/resctrl/core.c        | 26 +++++-----
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 22 ++++-----
>>>  arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++--
>>>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 14 +++---
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 60 +++++++++++------------
>>>  6 files changed, 78 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 7d4eb7df611d..c4067150a6b7 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -53,10 +53,20 @@ struct resctrl_staged_config {
>>>  };
>>>  
>>>  /**
>>> - * struct rdt_domain - group of CPUs sharing a resctrl resource
>>> + * struct rdt_domain_hdr - common header for different domain types
>>>   * @list:		all instances of this resource
>>>   * @id:			unique id for this instance
>>>   * @cpu_mask:		which CPUs share this resource
>>> + */
>>> +struct rdt_domain_hdr {
>>> +	struct list_head		list;
>>> +	int				id;
>>> +	struct cpumask			cpu_mask;
>>> +};
>>
>> I like the idea of separating the domains, one for control and another for
>> monitor. I have some comments on how it can be done to simplify the code.
>> Adding the hdr adds a little complexity to the code.
>>
>> How about converting the current rdt_domain to explicitly to rdt_mon_domain?
>>
>> Something like this.
>>
>> struct rdt_mon_domain {
>>         struct list_head                list;
>>         int                             id;
>>         struct cpumask                  cpu_mask;
>>         unsigned long                   *rmid_busy_llc;
>>         struct mbm_state                *mbm_total;
>>         struct mbm_state                *mbm_local;
>>         struct delayed_work             mbm_over;
>>         struct delayed_work             cqm_limbo;
>>         int                             mbm_work_cpu;
>>         int                             cqm_work_cpu;
>> };
>>
>>
>> Then introduce rdt_ctrl_domain to which separates into two doamins.
>>
>> struct rdt_ctrl_domain {
>>         struct list_head                list;
>>         int                             id;
>>         struct cpumask                  cpu_mask;
>>         struct pseudo_lock_region       *plr;
>>         struct resctrl_staged_config    staged_config[CDP_NUM_TYPES];
>>         u32                             *mbps_val;
>> };
>>
>> I feel this will be easy to understand and makes the code simpler. Changes
>> will be minimal.
> 
> Babu,
> 
> I went in this direction because of rdt_find_domain() which is used
> to search either of the "ctrl" or "mon" lists. So it needs to be sure
> that the "list" and "id" fields are at identical offsets in both the
> rdt_ctrl_domain and rdt_mon_domain structures. Best way to guarantee[1]
> that is to create the "hdr" entry (which later acquired the cpu_mask
> field as a common element after a comment from Reinette).
> 
> One way to avoid this would be to essentially duplicate
> rdt_find_domain() into rdt_find_ctrl_domain() and rdt_find_mon_domain()

It could been solved by passing a flag(0 or mon and 1 for ctrl) as we know
where this is being called.

> ... but I fear the function is just big enough to get complaints
> that the two copies should somehow be merged.

Ok. That is fine. Lets go with current implementation. Thanks for showing
the discussion.

> 
> -Tony
> 
> [1] In v5 I tried using a comment in each to say they must be the same,
> but Reinette didn't like comments within declarations:
> https://lore.kernel.org/all/5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com/

-- 
Thanks
Babu Moger
