Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BD7D75E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjJYUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:39:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B08123;
        Wed, 25 Oct 2023 13:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGWOaOeXsUSrEgKMtYqbcFYuTVLNF36I/pK4D0YsEtoLhSRi3qqmq9bixkx6T4mSpiEP2IkClo8tgcW8cepKCUSbLEhkrVhxEYgfA87iYFz6xJMjeWe/tfh0UhYCbipsOo5OqwjBAUFZKTG0nFU0uhYAOjqtcu2FRIPyFibHLqzIkXzRztcWvEL7StvwLXGkROYxR2yRlhSz3gMtGkFCqtAhzPp2OLxgwcmZjG10crC+WDzDvYzHC4F0pyN/dWmGMsjBbAbqivfIk2ywKVjLxxUIjGXYGHWdDzJzy+WrxT0hdkHGg+d+3iBrJ5MnuG874UEhfGwoeTCVyyDO+JSKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVJxebC4wtf6Ib2Zt8BDcx4ZOgRcycWVbg1TawVG0sY=;
 b=VjGhaP8gVSJkfPszHswESdk22DYxstEU6Au82MpHCC2iNlpYpUJpsl2fNbAOB8OIMCRKXgh0IZk5hzzGrSlaVd1hlmtJfRmjTUaTjnFOM6ksD50ZNKBr1phWCYi09df84AR8pNBHMhxycdE5V0A5Yn26uYwC5nuoBef39d20IB038XNEchWB/tTRQfgpP3pYzBB6/BhjpL+BezenuRkkl7d02sXujYhI82X5dzOI2HHtEHaBa6G4WuUJB7p/JtCwYW98GzllzEmAesQYO+PCSsIu4uAdt8F9tddJgXnmQ7qZDri59ErD2rX5zlgmI7jDPujqIeqVr66wPZa9kJGC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJxebC4wtf6Ib2Zt8BDcx4ZOgRcycWVbg1TawVG0sY=;
 b=suuszgjZOcvSyzeH/PA4DOI+PUibKSYjJQWWNgmVL3pN4hd4LdEfO1jdOR2rnVCNQAtAcbJi82VccUMb/H8gWEWx+KsGkO+zV2wynRRMEheoL0XrM7sNkHYQOb/2kbybTplbUBMSfUTs85m2811Y1tq9uABCAYSlkKtXBGPnvkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 20:39:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:39:33 +0000
Message-ID: <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
Date:   Wed, 25 Oct 2023 15:39:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
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
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZTluypa9bCWv4k2n@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM8PR12MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 755c12e7-92f7-45d5-f952-08dbd59a7f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opkiXKsXUTJmrqGuL6K0tS2JlI0CYq9Y0mxIXtyCkTembkJJlnVr8yHb2HLgPoLSauY5VoPSdWKN0c4vn1B2rr+px+lma/3SAqwCmxY6kWmhyODLvddYS9kVzDKnRrYLIK5JOfAx6OWsSDNTT+Qku3kx90/PAfOdleuJDmDTDJy6hoAQ5fglYvw43n751QFbMNWXS5leZlwNHoGNXMTsahYZv+5Y95qlB1jku+utoi9QrTDmmRGQJxeKXD+Y1gwni1b1RcDcTg8SIEc1ourQV/mOEadjzNNtc7PPciWOY1KOSFqnpkuEhDs5hsrxAoy2LtPfsy6ZVEUaxssJlX9+TV27q6m9nxqbH4dpUdVYEqa4fJUuVZSYe6SnJo2IIjz1A5kNgEhbC9G8HorULQRLp5S7r69XWQadGu9c36Sxn1gQOM1e5tqSvwgj6Qa0EQ3LKvlg8Pl0zA76ERiCRP8a9RP8k4UWPQ551Axh47R7ToII+08pue5isJHibbE2baPQPRhBv6X9EX8iQTJSU1g9rlOMly+VioyUfMc+s4INUSHt0c7DN1EX+afB6NtRj6ibBmXMeXVMhzUNJK1lIPB92eIDa/G8MYZBNNV+v3jfqR1dZw02+wLdIwWwWpeRs2dQ5XNMNrzSz8aiJMi2EjzMig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(86362001)(38100700002)(31696002)(2906002)(54906003)(316002)(66556008)(66946007)(66476007)(110136005)(6486002)(2616005)(6506007)(966005)(3450700001)(6512007)(83380400001)(53546011)(4326008)(8676002)(7416002)(5660300002)(36756003)(41300700001)(8936002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG44bFhTM2xGZ0lkeU9uNllMWmM4NW5NaUlJZlhob0tFM001Sk8vNHRhdFlL?=
 =?utf-8?B?OXYydVplQ2pOcUhvWjIrL3VCREY4Q2w3VExDYXlOTlNUYm9qZ0JoaUkxbGNq?=
 =?utf-8?B?cFJWeGtMeElzcDI4QXdGUkF5b1JoUk01K0VobWgwMDdscytnMnN0N3dSaS9N?=
 =?utf-8?B?eXgyaWpJc3FPRVdsTHExVkJJR2hFdHJHMWd6YXdVRkRjMFZEQUozRFVONGxz?=
 =?utf-8?B?QldaOGJ6Z0FhWWFQdnA1S3JndGJKUktNbjQrT3djRGx2bW9XdllGYUF3Z0dI?=
 =?utf-8?B?WnpsQWxKMndadzJSV0RlMFZqaTNjZ2VibXp1elM2RnRpbGVUSmhjei9PNUFy?=
 =?utf-8?B?Sk1rNVpWMHU0RmJYdkVERlJRRndIcWxadGtpVnRFdWp4bnJ2cWdIVmVmang5?=
 =?utf-8?B?YVkxM3pQdmQ3REhkcS9Ka3lEbU54RW1FK2NKVE5BTlhZSEZyL09MRmt2VllY?=
 =?utf-8?B?bHhDRW5XMjZ3b2JrUjB4em02K0tLa2lpWS8xMlpJNHQ0ZDNENHNMdHplSlZj?=
 =?utf-8?B?cEJZcldlYlhONWltazFNRUpXb05YRFhoSTQ3Wll4Rys4aGg2WGxpVEpMcFdp?=
 =?utf-8?B?UTVOSllXQ09NWU1lNGovbVRldm1jTkJ0bGFmQnVLUWRGanVjWm5CcTY3YXFR?=
 =?utf-8?B?ZXIyUlNML09qcEJtb1ArYWplekxqc0FiSDlINFUwaWVkckl3c1kxWGI4a01k?=
 =?utf-8?B?MStoRXkrZGcwb3B5bVhYdzBlT21lQkpJRmZHK3ZpSXZpdDdQdlBCVnM5UGJi?=
 =?utf-8?B?SGxkZlJNdnkyVEhHK0N1Rm1JNWJLdXR4NXBRTDk2aXNMTm5KOXRmaUpDMm5M?=
 =?utf-8?B?UGtRR01lblVtcHhmYlFtemFqOTc1STRoeFBXaUwxaDNzUjZ4SDJBUFJLN2dS?=
 =?utf-8?B?ajZabzV2TElRa2kyeHpnVzNrOFdETmJkU2VMZHAzVGU2MmRSMkJ0bXBxVXNZ?=
 =?utf-8?B?MTVBcVZvWDdURGVoZEpMQmhMWUs0OHNMLzZhMUtlZ3hSaTdPSk5TamJ5NjU5?=
 =?utf-8?B?OWxVZUVXNURzQW9weHI5R0hkTE5rcnM5bTlYOG9OWm9xN1Mxc0F6bVd0KytW?=
 =?utf-8?B?MmgxYUhWdG54YW55b2ROZ2hONE9hTkZMOUhGNTVFK2N1MGEzWEJtTTNhNytX?=
 =?utf-8?B?eDVieTBHNjB2eEZLdTZTMEtSU2NxdktWUFBoZVdtSWFGRElwNnNkSzRQdzVI?=
 =?utf-8?B?dEY3S0k1TDd0TzFVTjU4ZGgvNUtMeHdZNUwwRVJYWEZyUC9HUlpXbUtVeFp4?=
 =?utf-8?B?VDdubDY2K1dCL2lFK2RyRUpuKzZqMEdnVk91aFdNTHovMHFwS3dnejRHbU8r?=
 =?utf-8?B?UmlwUW5Vdm43Q2hmL3I4UzY5YnU2c0sxckpyNENmYWhaVGVTS2hqQlhiNHVB?=
 =?utf-8?B?RVhCMmhNdEthNU5sUzE3a1NuVThZWU95YXhCQS9kQXlkYVh0ZDcxVlRSSFR5?=
 =?utf-8?B?c3ZRTlZ6MGVaV2RPanpIQlFhMURLMXRMMXZtaFRkaUJtTXZ5SnV2MWhuU3I4?=
 =?utf-8?B?Y2hjZGZ1TUQ5SmpXaS9ZLzkwaVdtV21HTjFmQTFpL2YvYTNJN3ZQbVhRYnlx?=
 =?utf-8?B?MHVyQWd1WmZmbFdyYWJueStrd3M5aEY2NWxLYXo1b3l1ajFyZVlmd0YxdXpr?=
 =?utf-8?B?TnhBQ1BGcHUxZG1EZCsyR2hHc0JWLzd6SktDaTF1aE1zQkNRRUxEYlI5N1dJ?=
 =?utf-8?B?TFVXNk9WTWk3eW9PZVVmTGU4YTJyOG8xYm1DTnJvUldYUmZlczRXN3hFRmIv?=
 =?utf-8?B?dW9BVEtlUXNNK3B3MmtDR0ZyNmgvL1ZCdG02OEJ4SURzQkthUE5QSTZaT1Yv?=
 =?utf-8?B?K0d3blBIdEx0Tmc2VnpTemtwRUdZS1FPS3U4N0p3R1FQZ0ExSGU1aENWa3J1?=
 =?utf-8?B?a096a214amNJcDJwdmdHeGoyd2J1dTdiSVZrdW1EeENnUVFEZXhvVVl5bnJp?=
 =?utf-8?B?MnRNaXFlZnpHZU5oai91ZVFpZTJra3RrYkQxQ0F4ZExyUUxDKytyN2p3S2dk?=
 =?utf-8?B?Qm9JODVraDZMUTVnbGptbUI3N3VIay9WOFdjRzNSU1NYSUxlbVVZQ1cxZGtm?=
 =?utf-8?B?MzBNZVBheU04UnFydGdYWVAzdUxxWE9sUEhRSzhVejNxN2MxU2VscC8xR0tl?=
 =?utf-8?Q?tWEU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755c12e7-92f7-45d5-f952-08dbd59a7f13
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:39:33.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTBoI8K1dPthjASNKzozKpqPQ3oiTYpJb8mi3l1p2IgEnOW0ETh2TsxrvhQA62QS
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

Hi Tony,

On 10/25/23 14:38, Tony Luck wrote:
> On Wed, Oct 25, 2023 at 02:46:53PM +0200, Peter Newman wrote:
>> Hi Tony,
>>
>> On Tue, Oct 24, 2023 at 8:16 PM Tony Luck <tony.luck@intel.com> wrote:
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -418,6 +418,14 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>>>         return 0;
>>>  }
>>>
>>> +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int rmid)
>>> +{
>>> +       if (is_mbm_local_enabled())
>>> +               return &dom_mbm->mbm_local[rmid];
>>> +
>>> +       return &dom_mbm->mbm_total[rmid];
>>> +}
>>
>> That looks very similar to the get_mbm_state() function I added to
>> this same file recently:
>>
>> https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.com
>>
>> I think the name you picked is misleadingly general. "local if
>> available, otherwise total" seems to be a choice specific to the mbps
>> controller. I think these functions should be reconciled a little
>> better.
>>
> 
> Peter (and Babu, who made the same point about get_mbm_state().
> 
> Do you want to see your function extended to do the "pick an MBM event?"
> 
> I could add a s/w defined "event" to the enum resctrl_event_id and
> extend get_mbm_state() like this:
> 
> 
> static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> 				       enum resctrl_event_id evtid)
> {
> 	switch (evtid) {
> 	case QOS_L3_MBM_TOTAL_EVENT_ID:
> 		return &d->mbm_total[rmid];
> 	case QOS_L3_MBM_LOCAL_EVENT_ID:
> 		return &d->mbm_local[rmid];
> +	case QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID:
> +		if (is_mbm_local_enabled())
> +			return &d->mbm_local[rmid];
> +		if (is_mbm_total_enabled())
> +			return &d->mbm_total[rmid];
> +		fallthrough;
> 	default:
> 		return NULL;
> 	}
> }
> 
> Is this the direction you are thinking of?

No. I was not thinking bit different.

You need these changes in only two functions, mbm_bw_count and
update_mba_bw. You decide which event you want to use based on availability,

Something like this. I updated mbm_bw_count.

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0ad23475fe16..302993e4fbc3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -436,8 +436,16 @@ static int __mon_event_count(u32 rmid, struct
rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-       struct mbm_state *m = &rr->d->mbm_local[rmid];
        u64 cur_bw, bytes, cur_bytes;
+       struct mbm_state *m;
+       int evtid;
+
+       if (is_mbm_local_enabled())
+               evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+       else
+               evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
+
+       m = get_mbm_state(rr->d, rmid, evtid);

        cur_bytes = rr->val;
        bytes = cur_bytes - m->prev_bw_bytes;


Will this work?

Thanks
Babu


> 
> Callers then look like:
> 
> static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> {
> 	struct mbm_state *m = get_mbm_state(rr->d, rmid, QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID);
> 	u64 cur_bw, bytes, cur_bytes;
> 
> similar for the other three places where this is needed.
> 
> Any suggestions on how "QOS_L3_MBM_LOCAL_OR_TOTAL_EVENT_ID" could be
> abbreviated, or just have some different, but descriptive, name?
> 
> -Tony

-- 
Thanks
Babu Moger
