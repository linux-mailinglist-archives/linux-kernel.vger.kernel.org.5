Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AC7D75ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjJYUm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjJYUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:42:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CD123;
        Wed, 25 Oct 2023 13:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYtNs/2Cck2gYewnxHUAcUY7g9nFgngh3S7BemzlAHG5vwLJlS6rOEyaN19hT1ol5xkaG1KR1lolZnlXLPd0CD3Iev41GU0UcdSz6vePU0DDvLKrZdKtPIEPY/mC817K8rZvg3L0QMQmrnLeFE6N4kkCxYz3kkQ+jsqCDSdo59j/YH7nSXbr7W9cpk/W0YbuDs+TPNyfKRJUW9kFEAIzgLPWrq8RpLeIOE4NC/9gqmANUa587jtGh5zqxUvIqiz29jdkUneL5LudVe9NvYt1nsLzHHK6GBAYJBU9vsaQFXX9v8PV6UpmK5YgtX6jIQzv8uen1ozjKWZ2A5BMbUvtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YILTbS42DMF22QwNHQ5YQZ2PWRT6CsbtAgXt1ij1GM=;
 b=nPQxLvOuOuD5SwuSPoqO0NvNJzyfwa4qaA7rtHBjfSIt/MV1WNRfhMcH7k17EPVakGJGCPmfOUQEp+R+AP1FAwsBt34xLEnie/9seUWt6Yoyyl4rQRh+yKebHXRUv1t75yuIzQUpd+kGhkqVrPAb/pRR1WWpCtUMQ/oEbciR56QFwXUsLX5dDt3vPMGKAE53m7sG7nzvYfqv+2PDF/k2FlcV+ilhWKzKpkFr7Yk3xtPpiCuNWXC7+J/B8TGrR40flMF7ByYb7IwdNLlxkb1DhZxXpcdTbjKW1wajcUaC0PM0/965U5vAk1BEt4RZqi0VkEf1OOmzsPXzFTIyTm0Dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YILTbS42DMF22QwNHQ5YQZ2PWRT6CsbtAgXt1ij1GM=;
 b=sf9zz50M6zvEY7bM1pF0KYk8ZC4+mCzRlZFyP+lexGPyxUK1Zh4AXSCryoR2D9pAmZ2BwEMbZ6eEuZLluokkQqvmxsHKj53579BBLMkK64rElqv+U0+CQWYKEaJn7E9HAGWquhwIa76jCo1YrKhUh2BXOfXXV6ytB1XmhVzFaDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 20:42:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:42:17 +0000
Message-ID: <b8ea0a74-347d-475f-a36d-8944ced16951@amd.com>
Date:   Wed, 25 Oct 2023 15:42:14 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
To:     Tony Luck <tony.luck@intel.com>,
        Peter Newman <peternewman@google.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
In-Reply-To: <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM8PR12MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b6c932-c3bc-4591-98b8-08dbd59ae092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trH7R06IDqyiIFn4N/IiqCgWIlGIwTOcv7B8lKRBqZwl2EzX9b1RNYasl3PhmvtUcb3n48deJDvSXIfNBf3b3LfX6oDEpCUA+skBVEjTt7kAT2r16NM1u8+mlpBWEe9l/jT1E4c++pqbD42gTDmyE9bKVL7Ks3dY5S3C15Suzz0sKzxmcNenlQ8teaGl5XfG//1Bb81DP6jMiAkk2R4GE8UDeK8APjlQdr5Hkz/UhR7N0xejoSW3nBByjeDO3jZL33xqzr6+zChqaxgUiGe3P9qQ2SSAvFeDNUtj7G53UxMGHcyR85mS4oCvLam2ZnTg/vMQAWBiLIpZ95UQvEZ6YjZoz1L/E54dU+EfpN14otDW4YydX0d8RIYU5tFPCHjgj4mdZ/l1GIH46vyyn4IyL+X7TO7mOifEp+sVqJReNiTihsAKhqKQYQckqRYlZZCdJ8mccjexOQPd1EBAgRYSC55jjG/bejszWECnIhOuhkGAJUJd2mI2vqV4Dclyq5L2qPkEB+t0iXrt2dGPkDQPe+PeQvLqmtNHnIOcBlhVe8Xdsy1BEb4sAL+XjnRL/ypo4GpZZ73yTMKA15xJFl/YdjfuLURLdtiunTXByVOTAimTOzk7ktsZfGguvvREJ0dPUoOf+K4OhTzxewPAsTiOrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(86362001)(38100700002)(31696002)(2906002)(54906003)(316002)(66556008)(66946007)(66476007)(110136005)(6486002)(2616005)(6506007)(6666004)(966005)(3450700001)(6512007)(83380400001)(53546011)(4326008)(8676002)(7416002)(5660300002)(36756003)(41300700001)(8936002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzA3RFJPWHlWN0hhRFhEOGdvNmFGNHp6elZ6eVc4Q2ZQTFNBeFY3TFJQeElG?=
 =?utf-8?B?S2NSMUJnOUIyM0Jrc0tXVnFkbVF5YUtTeEpzYVJOYkUyUEU3MVAxdUxrVlox?=
 =?utf-8?B?WEx0MWh2eXVHYWptYVZRQ0ErdXFxdEhub2dnWjcxRE9mZWhEV3QrZmVqNGVZ?=
 =?utf-8?B?ak9JM2VWMllzaDF3ZENRTDFOMEM0TFFPNUZxUjFTcVhwdDlzSGl0dlUrbHV0?=
 =?utf-8?B?dm4wTGIvcEx1Tkk2Nnl0YWVUa2tVaWdMWkVMWW5TWllZRFdZbmlkWEpuQllV?=
 =?utf-8?B?SVhJdHpFZFZVb0YzM2Nkd08xZ3NvSTZ6ZDBDUHBnaTI2OW5ybDlwTXZPNDVQ?=
 =?utf-8?B?elREc21lYTlZTmdITjlFWDBiTFN3aUtZbVBZSGNZczgwMW5Sb0ZlK29TWHFQ?=
 =?utf-8?B?NEI5MUlKV0x6VkZCVURoUllzTjBIdDgwR3NET050Z2Q0U0toWUhXQXdoeDdu?=
 =?utf-8?B?alErL0ZxVzhvZDhFYzY3S1V4Ri9wWFFkUmxqMlpvRms0R3NuSTZCeXdvUmV4?=
 =?utf-8?B?N1VoZ01WbktxZ1p5YnlmbnA3UlZ3c1ltdW9GZGI5WXByL0QrQWdQZXU1WXdo?=
 =?utf-8?B?MXovRGF4SEZGeUNvalcwbWRHNmtQeUdKNThIY3BMMzM4emQ3c2lnNjlEUEhD?=
 =?utf-8?B?YXZTY3pIUFlUaGZjSG8vUzhna3NxTVhoM3lwWk5oTUo2c0Z1MXM4M2JnckFD?=
 =?utf-8?B?dENBb0RDNE90SGlKbEpnTTJ3b0Q1TUZoMW1QZWpXQmFPaFZQdVRQTnMrL0Jp?=
 =?utf-8?B?TndoZFc3ZzN4WkY3b29XU09uSG1lb290TzZDWi9aVk45Zk8rQ0pUQ2lzdm1Y?=
 =?utf-8?B?TGxLNzVEMERaVEFhWDhabTBrQ3lNUnBlN0NaNVpVSkIrc012T3M0Z3F1RGRI?=
 =?utf-8?B?emRHRmQzc0h4elVTVC9OU0YxRWI5R1dHeWlST2d4V2x5Ulp3UTAyMGEyYlkz?=
 =?utf-8?B?RXA2Y2wvaVhEOWR4WE5iU0lRUEc2c2x5YVpIU3RlM0FYbm0rTDJvWGR4RjRN?=
 =?utf-8?B?bitqL0FHUU9JbXV0NHhNMU9XOHB6VzJFdWtkYndUUjhVTGtPZ25Wc3NGK3hO?=
 =?utf-8?B?VXhUQnZvRUJFV0RIaWVqbng5T1JnVDBQM3VEM3JFSG5tTXhGN3pWRGFyVWVv?=
 =?utf-8?B?OXA3ZnlCVm40MlRXQ1k1aXcwR3VWYnpsUjRqS3F4KzlUd3V3cUNuSFpMbWJK?=
 =?utf-8?B?Q3N0cThheGUwYUhSSmlZT1B0UDRMRGlCUDhKcmtYZE9HdnhZRVJhTGt1ZW5K?=
 =?utf-8?B?N1IxTkYyK2YvQWxrOW8xcW0xSXE3d29xQzlJdU1uaE0xdTFIcnVGeGgvemNu?=
 =?utf-8?B?Y1l3Mjg4Sk1YRGRiNk4zYXhRd01WWjNCWTV3bmhCRUw5dnowbEwwc29iQnlG?=
 =?utf-8?B?ZkVHajJ6eDlxVjZoKzNDZnZGZXM5eTEzU2piamc2YmZIem5oRGg5N1VEL2xV?=
 =?utf-8?B?eHUzcklYWjdmOFc0WWNWRmtvYWU0eDJDM0ovL3JRYnZuSHREMnBuZXh1Q1Vo?=
 =?utf-8?B?TVA5bHROWjI0aFcwT1F4RG9DcnpXRERCQ3J2OGNSNWVoQytBcm5DalFCYjBM?=
 =?utf-8?B?bnVPL21sRE1BcHZwVENpZ253djlHdCtHTFdROWh2L2dabnJkbW9XN3hBcnor?=
 =?utf-8?B?VXJmRTNFWHFBR0tXejVzQzdPMERtQThkdDZ2NVNNV0FWWmNMMmdjTWNTaVZD?=
 =?utf-8?B?aWxmYjl4SlM0dGxhRFBBUlZXWVlzSGtocS81OHZvMnBCY0RxeFV0cTNvZjhr?=
 =?utf-8?B?dWZubVdpNnREWGt2c2FZZXRSWno0VnVmbzJPRVBueVQxVFY3TmRwZnFmTi9E?=
 =?utf-8?B?b3lhZzlQV3I4ai92YmNuTXZQNkduZzBNWThrM1BuTDFSZWFaSEpha2dyOFBB?=
 =?utf-8?B?NmpOejZueE83NkdlUkJ0dWdBNCtZanl5UE9aVGM5V1JLREV3eHJlRGtpZGMx?=
 =?utf-8?B?RUdsdkdiU3BoTEl5eHd1OGUwYjVlM0E5YzNvaXpjR3R0eUdjSGJUdFFaM0ZZ?=
 =?utf-8?B?QjdaY2lGRDJoUE44SUlMREFSdHA1TmtVWXhpbEgvOG9hVkVYM3hYRE12cVJH?=
 =?utf-8?B?UDhEOHlYT1NORjJsVEpJNVhZcldwVU5tMzRrLzRRNkNNTGg5cGNmdzFzNThB?=
 =?utf-8?Q?YPnY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b6c932-c3bc-4591-98b8-08dbd59ae092
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:42:17.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DeTSZYgru7Z8hHcHBiRBYqwycbSBdUX1y8j5KpC1QoTqSsg0r9PIGv+xF5pP7Iv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 10/25/23 15:39, Moger, Babu wrote:
> Hi Tony,
> 
> On 10/25/23 14:38, Tony Luck wrote:
>> On Wed, Oct 25, 2023 at 02:46:53PM +0200, Peter Newman wrote:
>>> Hi Tony,
>>>
>>> On Tue, Oct 24, 2023 at 8:16 PM Tony Luck <tony.luck@intel.com> wrote:
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -418,6 +418,14 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int rmid)
>>>> +{
>>>> +       if (is_mbm_local_enabled())
>>>> +               return &dom_mbm->mbm_local[rmid];
>>>> +
>>>> +       return &dom_mbm->mbm_total[rmid];
>>>> +}
>>>
>>> That looks very similar to the get_mbm_state() function I added to
>>> this same file recently:
>>>
>>> https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.com
>>>
>>> I think the name you picked is misleadingly general. "local if
>>> available, otherwise total" seems to be a choice specific to the mbps
>>> controller. I think these functions should be reconciled a little
>>> better.
>>>
>>
>> Peter (and Babu, who made the same point about get_mbm_state().
>>
>> Do you want to see your function extended to do the "pick an MBM event?"
>>
>> I could add a s/w defined "event" to the enum resctrl_event_id and
>> extend get_mbm_state() like this:
>>
>>
>> static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
>> 				       enum resctrl_event_id evtid)
>> {
>> 	switch (evtid) {
>> 	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> 		return &d->mbm_total[rmid];
>> 	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> 		return &d->mbm_local[rmid];
>> +	case QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID:
>> +		if (is_mbm_local_enabled())
>> +			return &d->mbm_local[rmid];
>> +		if (is_mbm_total_enabled())
>> +			return &d->mbm_total[rmid];
>> +		fallthrough;
>> 	default:
>> 		return NULL;
>> 	}
>> }
>>
>> Is this the direction you are thinking of?
> 
> No. I was not thinking bit different.

I meant, I was thinking bit different.

> 
> You need these changes in only two functions, mbm_bw_count and
> update_mba_bw. You decide which event you want to use based on availability,
> 
> Something like this. I updated mbm_bw_count.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 0ad23475fe16..302993e4fbc3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -436,8 +436,16 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>  {
> -       struct mbm_state *m = &rr->d->mbm_local[rmid];
>         u64 cur_bw, bytes, cur_bytes;
> +       struct mbm_state *m;
> +       int evtid;
> +
> +       if (is_mbm_local_enabled())
> +               evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
> +       else
> +               evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
> +
> +       m = get_mbm_state(rr->d, rmid, evtid);
> 
>         cur_bytes = rr->val;
>         bytes = cur_bytes - m->prev_bw_bytes;
> 
> 
> Will this work?
> 
> Thanks
> Babu
> 
> 
>>
>> Callers then look like:
>>
>> static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>> {
>> 	struct mbm_state *m = get_mbm_state(rr->d, rmid, QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID);
>> 	u64 cur_bw, bytes, cur_bytes;
>>
>> similar for the other three places where this is needed.
>>
>> Any suggestions on how "QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID" could be
>> abbreviated, or just have some different, but descriptive, name?
>>
>> -Tony
> 

-- 
Thanks
Babu Moger
