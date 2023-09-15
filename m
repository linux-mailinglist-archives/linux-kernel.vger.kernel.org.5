Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A27A24DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjIORdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjIORc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:32:59 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B63A9B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:30:31 -0700 (PDT)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4E3DA10000654;
        Fri, 15 Sep 2023 17:30:19 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1694799018.928000
X-TM-MAIL-UUID: 7ddbd9d0-b388-431d-b9b3-da70cc436c24
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E2DF810000E5B;
        Fri, 15 Sep 2023 17:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snw741xZDcm9Tr2BECNX0+SWBgGoW5XxnXjMV9J0EHEvx4jKQDALve0bHY6t53argHCWpI+Gwaed3ePGq9uvcovoDYN+zw4nEFeHnMLP2Kg4NbIKj7kHiE0bjLmgMbNqWnkJLnS+eop3ghuW4Xdmxsbky+Lp2LXlVOQ/MPG9BbvVImIESNwZs2skTIe8H3xh+3wFUM8y5m6gPpMCGQHaECplhFOMhpcd9NS1Lp6McNNx2k+HzeJAJNjGgeOtmnKgSHZZpC4nSOohPJvL2keNX8eP9rFiXrAFBBiHOO8Y0vNqFEsorAurg5WWzSvm4zgltb4DBU5Qu1xn+vz0QghF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7qiAJx4uZTbn9woyvCf99p2s3rjZBxo0ObGqAcmp2g=;
 b=BhhdYt+IvU9giBZz5aA/zOYGPDbnxpw/wkCcYypb6RlKTaraK0Xll2Z+jxu+9YBI0jdxBokiLDgIQf51npPnTjV+HcPowch5Dr4tchMFxgP+by2cFIRwFvsRf+3QVvu7c7PnCDxgi4mGTR9GH1RogYpwPF48iipAJiaj6AuHiqjPUYVzOlAR7RtuIk1RF8tupskaMs90HFHI5oaIdE/2lpdA7GvP50kVBiaD3JVw68oY+kkDiZFdbacNvIT8VdXcoMh/veLzMgmUpxHq3Pm8t36hAJTdZb/zqwgoNKz2bMNF5dJLNkKUg+fCrsyyXzKY4/qbwVDQEB9gl6kaAPgS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <36b2f11b-9dfd-b721-c97e-478eabceb4cf@opensynergy.com>
Date:   Fri, 15 Sep 2023 19:30:16 +0200
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
 <20230818012014.212155-3-peter.hilber@opensynergy.com> <87a5tn1kp6.ffs@tglx>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v2 2/6] timekeeping: Fix cross-timestamp interpolation
 corner case decision
In-Reply-To: <87a5tn1kp6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::13) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BE1P281MB2292:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bd5651-0a60-4467-b063-08dbb6116dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6Aj/vuYx3GHGVCfONSe205anxwvQVatCXXL7plzdfu1KCCN5ASpold0oAr/IjdmL+RcSxD0zGPl3YJeWqTR/7Td/QYTn+7lN/wox5BS+6pyT9+Q9sUxWvIIn5xpP30y/aq6N5SdBCaUE6SIdo/eJ04qw0VqaUxCg1Or3jdmdn5OGyrdrpi5dbhtp6C3sZfixVvQMUu9Gjdg2RC16ZYIHQ+JYhG6bSD6BSGiDM/UHTXoN59bpIJCDgWfFv0WVPg4al3MDHc/UMre+yrwHqMBIaSmG5/ygggeD3WAwYnOyjhlfcDdVYZTtGGmu8UsxTnziYNeRWGIw04uGeHgQHEz7le6A5LYvKPuiyHERP12nOAPV0OZdZeX4es0IxE++oUlT+g0AU7bIisxAwZ2mDlbWLP7JP4emSQ44rerWFd2ZzGXfZ2NlNrQNfbp3nzQSbnaA3ux8aEBY8PIr3wQjFB8h4+uPTnlVOFD15Ilqjjg1Ns7Us1KpGwvVAgto61OOiQUpcCgHqJO5nYJSHrkRXwspdcDJjDJY4gyaq9cYJDGkQRT8FJSkk8n6N7/c0VmDRW5L0ciFZs0Z6Q3Qgn1GaROiHnxRSawbfw1ULpjQsYIVKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39840400004)(366004)(346002)(136003)(1800799009)(451199024)(186009)(83380400001)(54906003)(66476007)(2616005)(316002)(66556008)(66946007)(42186006)(4326008)(8676002)(44832011)(5660300002)(41300700001)(53546011)(2906002)(478600001)(8936002)(31696002)(86362001)(36756003)(38100700002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFwQ01mR2t3ZHNaSm9tTnJyT0M5cjUvdTQvVzY0cDZBdTgzNHdmOUhlVG8r?=
 =?utf-8?B?QlR3RTJwaTdXSWZZWXN2ZnFUcEdGSWdKOEorTWRqQmZ2NmNuSnd5cldsVXJ5?=
 =?utf-8?B?aHNxSGF5T2VqQktFY3Z0VEgvL1B3NmhHNzVKemVJejUwSmEzR1pGOHBDMFo2?=
 =?utf-8?B?Skd2bSt1OWhhSnhmeGVrd1kvTEdWcmZWWXhZWGxiK1VGc1VpblFlTGxhVGQ1?=
 =?utf-8?B?ZTVVcEJPS3NVdUQxKzdkb0dTMnp0aDFCbEJhekEvWGtZdWRhRmt0WTFmU3Fp?=
 =?utf-8?B?bHRXRVRwbENkMXhTMEFDY05MYVRiWTdzR3pMOVR5bjl5c1poQzlPa3JpemVn?=
 =?utf-8?B?SlN0OFRCU2wzYmFuNmk3MzRoZTlDSHZJb1pXOTJnLzVhbnNwcVo3a1ZGcTFR?=
 =?utf-8?B?Um1odUkzWEl5dzhPQzJMU25PUHZUY1EwZ1ZkYThLNXAwV2pVZW1pMDdPNS9U?=
 =?utf-8?B?RWNGVGJHZjVxRlVLdU4rUkhOc1dvcllIY3BpMGZsTGxETTErUzRlV1gzcHhp?=
 =?utf-8?B?UGVZUGFRQ205UHpJTC9hNElVUU5vaSs5L254eW10T2hOTVY5L0pXUkp4bGdx?=
 =?utf-8?B?bEFnM1hvMVd5bHlrR3YvTi82M3U1SGUzTlp1QklxMFlLclcrWklUWEM3eEd6?=
 =?utf-8?B?TEpOYVVMalQvYnJNM3Zpa0REanVCd1k5OWVjR2lsajBwRTV4eS9mQ1BDWWwx?=
 =?utf-8?B?YlFMbHM0aUJQTVgwdUZEaEtWU1U4OGJ3TTNyeTJUMHNldEFFcjF0MGdGcWc5?=
 =?utf-8?B?U2l1RU5jMDFHeHdIVVE0MmJrdEpPYXZSdmwxa1ZIM1YwYkNOeWk3VGMwZmxs?=
 =?utf-8?B?VWdUK3dueThrZ1JiRlYvMkJzOWVBU1lLUVhES2dvZmtMVE1VY3dKUGh5R3Jr?=
 =?utf-8?B?U0plS25QQ2FKMkc4MHdUQWVDbDJJcml4OTFvL3hDVVpHcG42RXUwYkdRUmo1?=
 =?utf-8?B?T3J4R3J0Vk1TZUp2RWxUTURHZXRNZGJ2aE1SeW1KRU9vWk5EZno5ckVnYlMy?=
 =?utf-8?B?QVdHUFpvT2poYXF3R3l4Z2tWYUNGYmpjR09CQXJ5WHhlcGRMeldDNDR2YWtp?=
 =?utf-8?B?TnV3K2hISGNxMkZEZ2t4bmwrN3FFbXFHbG9oeFVPVUdMV25IRkRtTk1wRW90?=
 =?utf-8?B?dlE5bE5DaVFsZ0RGK2JVQ3QvSTBqZUlrK09BTDZGeGc0Zm4xaWE4VFJ0R1Jx?=
 =?utf-8?B?VjJLZUtucXZkZVM3MVZHQTZVQnJhUmpOT1VaVUNZQk1zNDNkM2xRTlRpbVZk?=
 =?utf-8?B?TjNFY05hNkUydit2TVRLQ3F6VW5ORWFQY0xNSE1Gb1VCMGZIY2wwWHk4S1pw?=
 =?utf-8?B?MHFYem82aUcrVnZJeFo5Mmo0ZnE3MjcvM3RNc0NHRFRGQ2p2eVg1V1dLLyth?=
 =?utf-8?B?M1lRTE00WlB3UlpnVk1qN1J4U01URHNRVVdxRXBoYVcxUVNMK25OUk9oT0tB?=
 =?utf-8?B?K3d6eXE4dXU3LzlVTXA3cVJiN0k3Q0NaMVhRak1SSEhneHVaUHhxNXdFRXBl?=
 =?utf-8?B?Q1FaZzFTc3NsVlRmZmZ3Yk5PNkUvcU1QVklaNFQ3SVlSUDZ6azZwMXVGQlJX?=
 =?utf-8?B?cnJITFRkUG4yL0J5YjBEbDEwc2ZSSFBvTGt3cUd6cmk3M0hlSVI2ZXdHUGt2?=
 =?utf-8?B?bk1IWkxuTk1uZkU3SWdtVE0zTWxuM0I2OE9GU3dNdW1ITXJ3dWlLTVdBMVhR?=
 =?utf-8?B?a0RzMWQyd0dlbnZ5OEpEKzFQVXB2WDNxOHBmNWw2NjZWOHhuRFdIY1RGMld3?=
 =?utf-8?B?VkRXaE9FNmVVYzQwd1IxTi9ZK1N2aWhHcUZIZ2JKUHhsMWJ5M2pwZWFlQUFG?=
 =?utf-8?B?QldGZTF0Y3NhNDh5YzZoYVRaUHZ1bTNyQkIvZkhGV1ZYWTMvOTFkNnVmMDR2?=
 =?utf-8?B?cWVvVmtwWCtPbFR6dis1WVhxcDRqOUIrMnhnUHp1cHh4ZXVIK1lEUy8xYjVY?=
 =?utf-8?B?dk5hbjNpazlVYVJYcFEwbWROY2VhNzJlSGNmTm5KQXFEcVFIbS9pZ2NZTXlD?=
 =?utf-8?B?ak8yekVMY3hDcWFkT2hRU3MrY1FhWUZTODhPQ0g5TkZHRUdHTFBEWFkrZmU5?=
 =?utf-8?B?UUVlOXFSWk9iRUJzNDc4STdyWlpuVXB0RVQvbFBNK0ZLWko4RkROQ2NrSm1Z?=
 =?utf-8?B?aEJyM3ArdmRDUXJOeEhER01pOWtIbUpPRERqM0FFZ2ttZEZEM3N1MVZmcEJy?=
 =?utf-8?Q?LB5igyJ+yWMyXidyVernAaeb+zGL/T0ZoESdDNEANGXr?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bd5651-0a60-4467-b063-08dbb6116dc9
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:30:17.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WORwtXUW9aCfmKfSwkLQes+CVRqLFaLQJ4of725o3MZfJx+10/l9io7O35v4G44t0H7yCgkvSycM/RYcF7PL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2292
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27878.001
X-TMASE-Result: 10--6.482500-4.000000
X-TMASE-MatchedRID: scwq2vQP8OFTzAVQ78TKJRhvdi92BBAuXpSxZKDDzFi3UJJ8+n/4RTIR
        2VnA+/9lZhdrEMuWLSQhnQ6SSuhiIrlZ/fcRx4s/c6MQph12+/oqq8hD1DGRIMDy2KKuKumVsyv
        UEJT1URpz4h/9HLxRrVYXGW9qXMB4YI3Esr2biKRsBBK+dj8AxQeATH6uEs3iiRaF/ACs3APmXT
        SOXJi+xAZdg/cHePvV6xA0Ava73nAPm15xyht8lcTvQx6Ny2Cr+sMesHlgpMtcUAhFIiIQonGDu
        y8y1qkuxPxoEwz2UDszM0VUCTmL+/hJ+9xRUwjveCByiysJZEziiwBbodMsfg==
X-TMASE-XGENCLOUD: 90e24a2d-0d41-4f25-a48d-0b9a907ea161-0-0-200-0
X-TM-Deliver-Signature: 08B19EBC10FF97801A35DEDDCDDF2126
X-TM-Addin-Auth: lYHLHBMCLdLXYszMexeZGNTachRpmPYuAemelUfH74GQ96Oz68LGDQXS5mm
        37LbHk+2QerhzxPNZwn6k0gDXvGvLCwpiGO8d35NuqtTHPmu7ZsjG6yCxPUxi8DL5beT+92UZG1
        twYW98T+E6jOOUsW3ZYrEpG4pRbLVDT1X7im13s/ukRnbAks31rNQxSCQUnLLCWc5wSqt/RDvW4
        +a/+XbJauhEhUgoXYCa4qssNj8rvzvlg1+MCADSh1D9gL4ILO0WpYf+kDcF/FjXEXHxQ2YoDoaM
        Az68Xs4976JI2Zs=.KDbAoIh8ZTjjHxftcanJIAW9Y+SINzXHOdleYyUwCttdGTIY92Szhpd+bG
        Mcif4y4ACWMDiHBNo3W8uTvYmw9It++WXaHovhuxXXwe3N+oOZ0EmJ04PMFAvT/ThBGc36Osyng
        Jtd9qXl+AuV2K/l5kA7kXwDoRvNC0lpBHVmjNR6hkhS8r2N5sRkEn1dDosTnjm6VDqzrL3MeeQ7
        MwkQOuAzrre82cc6lk83ftbnW1q56MuyvwrBGTReK+PywQUsdQ47oc2TM+/cUvwOWeAi3Sby+Kw
        ZISaYjuR9KRm29TeXBvFztiNqExuMWtP6elEWJ+A2bHOJvopuaEhsu6RAQA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1694799019;
        bh=yBsJwTvFWkf/gbDP326v1xJ6kUrNzPMTg8mdlhBsS70=; l=1630;
        h=Date:To:From;
        b=dtOL82r2o6NGDWH4Y+7KtxC2zbuG2S6Y7cSadQzYc7PzYW7np9yfV2rFqM72EFOHF
         3sSnqv/z1y3PKmoFA1GxFvpAV9CTzfleyQof/rjG7XSLHSTGiczxi3IFATPrTZE6MG
         h0ZjATnHOH2A580DHT+APi/awNtKyBQGdMI/2o1dQt0axt0SW5mIE74RXCugsYbPb+
         W1izYcOkALqaNHj6CCvf3OHICTUK4+N8BjGZdMgxzZIbddN5oFGvvunWBharP9ZRth
         rFGDkB55xnZopXdfV7NwAGOZcKdK4n5jSo+h70Ermj0CWny/huhbdTsXbwTTvMwWAa
         PIN6VCNwljnAw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.23 18:10, Thomas Gleixner wrote:
> On Fri, Aug 18 2023 at 03:20, Peter Hilber wrote:
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1247,7 +1247,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
>>  		 */
>>  		now = tk_clock_read(&tk->tkr_mono);
>>  		interval_start = tk->tkr_mono.cycle_last;
>> -		if (!cycle_between(interval_start, cycles, now)) {
>> +		if (!cycle_between(interval_start, cycles, now) &&
>> +		    cycles != interval_start) {
>>  			clock_was_set_seq = tk->clock_was_set_seq;
>>  			cs_was_changed_seq = tk->cs_was_changed_seq;
>>  			cycles = interval_start;
> 
> So the explanation in the changelog makes some sense, but this code
> without any further explanation just makes my brain explode.
> 
> This whole thing screams for a change to cycle_between() so it becomes:
> 
>      timestamp_in_interval(start, end, ts)
> 
> and make start inclusive and not exclusive, no?

I tried like this in v1 (having 'end' inclusive as well), but didn't like
the effect at the second usage site.

> 
> That's actually correct for both usage sites because for interpolation
> the logic is the same. history_begin->cycles is a valid timestamp, no?

AFAIU, with the timestamp_in_interval() change, history_begin->cycles would
become a valid timestamp. To me it looks like
adjust_historical_crosststamp() should then work unmodified for now. But
one would have to be careful with the additional corner case in the future.

So, document the current one-line change, or switch to
timestamp_in_interval()?

Thanks for the review!

Peter
