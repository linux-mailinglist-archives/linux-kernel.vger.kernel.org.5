Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304C78E4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjHaDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHaDKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:10:02 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 20:09:53 PDT
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 627DBCDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:09:53 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4CA3E110087E00;
        Thu, 31 Aug 2023 11:07:50 +0800 (CST)
Received: from [172.24.140.47] (10.79.64.102) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:07:49 +0800
Message-ID: <528d1719-27cf-5264-5c76-0c279c770c88@didichuxing.com>
Date:   Thu, 31 Aug 2023 11:07:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/fair: Fix burst unit mismatch error for cgroup v2
 cfsb.
Content-Language: en-US
To:     =?UTF-8?B?54mb6Iul6aOe?= <nrf233@gmail.com>, <peterz@infradead.org>
CC:     <coonwel@gmail.com>, <qiang.zhang1211@gmail.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <linux-kernel@vger.kernel.org>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <CALJBpEcTPYFUmkkSKKS5WkFG0ekDHB-ZUeJacTGXZVOjP7yCzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.79.64.102]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/30 17:19, 牛若飞 wrote:
> Cc:  linux-kernel@vger.kernel.org
> 
> 
> NiuRuofei <nrf233@gmail.com> 于2023年8月9日周三 14:27写道：
>>
>> The burstable CFS controller is introduced:
>> Link: https://lore.kernel.org/lkml/20210316044931.39733-2-changhuaixin@linux.alibaba.com/
>>
>> The original patch directly used the 'cpu.max' interface file, and it handles the unit conversion
>> when cpu_period_quota_parse() function called(something like this, *burstp *= NSEC_PER_USEC;), it works fine.
>>
>> However, in the official version,  the single "cpu.max" file was split into 'cpu.max' and 'cpu.max.burst' interface files,
>> and we don't parse 'burst' in cpu_period_quota_parse() function anymore. Instead, we call tg_get_cfs_burst() to get burst value,
>> which return burst_time in microseconds. This could result in a unit mismatch bug.
>>
>> We can easily reproduce this bug using the following steps:
>>          bash:/sys/fs/cgroup/mycgroup$ echo 25000 | sudo tee cpu.max.burst
>>          25000
>>          bash:/sys/fs/cgroup/mycgroup$ echo 50000 100000 | sudo tee cpu.max
>>          50000 100000
>>          bash:/sys/fs/cgroup/mycgroup$ cat cpu.max.burst
>>          25
>>
>> Signed-off-by: NiuRuofei <nrf233@gmail.com>
>> ---
>>   kernel/sched/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c52c2eba7c73..e635598486a9 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -11380,7 +11380,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>>   {
>>          struct task_group *tg = css_tg(of_css(of));
>>          u64 period = tg_get_cfs_period(tg);
>> -       u64 burst = tg_get_cfs_burst(tg);
>> +       u64 burst = tg_get_cfs_burst(tg) * NSEC_PER_USEC;
>>          u64 quota;
>>          int ret;
>>
>> --
>> 2.30.1 (Apple Git-130)
>>
Seems we had a similar fix for this one from Kailun here:
https://lkml.org/lkml/2021/9/10/782
