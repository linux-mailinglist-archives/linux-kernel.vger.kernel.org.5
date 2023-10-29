Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626CB7DAC60
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ2MRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 08:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJ2MQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 08:16:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D9BF;
        Sun, 29 Oct 2023 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GiwSQA1MEgbGgyq4T6GAbLNQiLBl/gGNQhi2kVQa80I=; b=39befQj3i+pcJMQrF0ILvxffit
        D3iEoBgq1jvN4DfaeRGXuwGcLmVbNnwbzCCkR3TNhfxiryoLb1RIDK98VVYrpc4AR3WTsdknVynoV
        TQG4uD9kXx+qnv/0poIv/3euA5q7cjLG052wF9mLUtDXI6gaxPUUm2rULKvWbRX7r7aIZP5SWhFiB
        3IfJ+HtPiF2sS2Jvn0ggQVky3RicUBi2d8vxkA5luz4AJexE0V/B9OjADLa/pHSfoQt8Z2Hqdoq6S
        J7m0MgScfHDDH6MrG1S/yOcIoJZbkz6coAkF0V0VzQRZVtK4N/GX5kGW626tyU5UpepZdPJ6361Dh
        geo1ii5w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qx4in-001j7D-1t;
        Sun, 29 Oct 2023 12:16:49 +0000
Message-ID: <2e507e97-8ac6-43a2-a290-e0e80af0d044@infradead.org>
Date:   Sun, 29 Oct 2023 05:16:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: sleep: Expose last succeeded resumed timestamp in
 sysfs
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        suleiman@google.com, briannorris@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <169849758243.1357961.4105003693126485611.stgit@mhiramat.roam.corp.google.com>
 <d6f016fe-963b-40ba-9146-de69e4fe0052@infradead.org>
 <20231029115449.8c942b131312c2464eda6970@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231029115449.8c942b131312c2464eda6970@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 10/28/23 19:54, Masami Hiramatsu (Google) wrote:
> On Sat, 28 Oct 2023 09:48:36 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
>>
>> On 10/28/23 05:53, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>>
>>> Expose last succeeded resumed timestamp as last_success_resume_time
>>> attribute of suspend_stats in sysfs. This timestamp is recorded in
>>> CLOCK_MONOTONIC. So user can find the actual resumed time and
>>> measure the elapsed time from the time when the kernel finished
>>> the resume to the user-space action (e.g. display the UI).
>>
>> Can you go into the use-case a bit more, please?
>> You have said "what", but not "why".
>> What do you (or google) plan to do with this?

and what about this part of my questions? ^^^^^^^^^


>>
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>  Changes in v3:
>>>   - Add (unsigned long long) casting for %llu.
>>>   - Add a line after last_success_resume_time_show().
>>>  Changes in v2:
>>>   - Use %llu instead of %lu for printing u64 value.
>>>   - Remove unneeded indent spaces from the last_success_resume_time
>>>     line in the debugfs suspend_stat file.
>>> ---
>>>  Documentation/ABI/testing/sysfs-power |   10 ++++++++++
>>>  include/linux/suspend.h               |    2 ++
>>>  kernel/power/main.c                   |   15 +++++++++++++++
>>>  kernel/power/suspend.c                |    1 +
>>>  4 files changed, 28 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>>> index a3942b1036e2..63659765dee1 100644
>>> --- a/Documentation/ABI/testing/sysfs-power
>>> +++ b/Documentation/ABI/testing/sysfs-power
>>> @@ -442,6 +442,16 @@ Description:
>>>  		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
>>>  		This number is measured in microseconds.
>>>  
>>> +What:		/sys/power/suspend_stats/last_success_resume_time
>>> +Date:		Oct 2023
>>> +Contact:	Masami Hiramatsu <mhiramat@kernel.org>
>>> +Description:
>>> +		The /sys/power/suspend_stats/last_success_resume_time file
>>> +		contains the timestamp of when the kernel successfully
>>> +		resumed from suspend/hibernate.
>>> +		This floating number is measured in seconds by monotonic
>>
>> What does "floating" mean here?  Not floating point...
> 
> Oops, it should be "floating point number".
> 
> Thank you!
> 
>>
>>
>>> +		clock.
>>> +
>>>  What:		/sys/power/sync_on_suspend
>>>  Date:		October 2019
>>>  Contact:	Jonas Meurer <jonas@freesources.org>
>>
>> [snip]
>>
>> Thanks.
>> -- 
>> ~Randy
> 
> 

-- 
~Randy
