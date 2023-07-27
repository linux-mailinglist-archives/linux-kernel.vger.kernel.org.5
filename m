Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E27644C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjG0EDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjG0EDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:03:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73E2D40
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:03:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7659db6339eso21587885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690430607; x=1691035407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+VbTe6Mob4pAC/pm6erOvbSB+k/JJhQ28OiV0//M8A=;
        b=k+kAPSGz9g+/O/PU+gHlRhiOWXyurJIn8zLIe+/qpvMcuSHDp4QqXHqsj/3YZW7k8C
         fp+aA226yPrBBuaTv7+Y7gYXWD2p+plLwa96DkA2+XFjADvKr24Os+SY0tyYhp9AWyGt
         xSEU7df6RzulfpcB/EkujEior93l93kJ317y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690430607; x=1691035407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+VbTe6Mob4pAC/pm6erOvbSB+k/JJhQ28OiV0//M8A=;
        b=gVylgGAaoHKtddyquU6nxZJAwmjX7+r4IFtRMmLcMS2ulaQ6KJJIy6f5SA4jp42j17
         NwW9+7bHIyQj7hltwDlNRhlYvnAT7vDzMBDXI6VRjVjPKWlEACPR1DocnYTUbYwr62Pe
         PahXVGjoz8pKAn+Zn5Rlzit2HzkDhI8aPNuzyFljyDPkTjyztP14RLUMCKjR6QRjYz92
         cF+Bfsb9A2nxIX/j+KlCjXx/luy5AMRVSdtxc1AssckEnDVSqywZrXvlX49kaOOxVcyk
         SWiZOd9U7jsJg1UyPJIM4Q8RAPESXMdDI+vtSbXBqf2astZpiCHo2mnMkGh++smY2CLz
         Lfuw==
X-Gm-Message-State: ABy/qLZuuVFvsQ07MtVfN8iqxztavwTgTmVn4xMCv4kL/gBh5bceX3ey
        XPj/nAFsGvT42AwGk+OHgAS9IBJRBfrDKq8XEMg=
X-Google-Smtp-Source: APBJJlGqR3VGOfZbk3AX+BYQF0t415g128FZkk3shlgLNDRoM7HM4rUZq8wAX52OvjT70nY3MJVYIg==
X-Received: by 2002:a05:620a:290c:b0:767:e55c:d3ba with SMTP id m12-20020a05620a290c00b00767e55cd3bamr1913878qkp.3.1690430607450;
        Wed, 26 Jul 2023 21:03:27 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a074a00b0076c60b95b87sm136397qki.96.2023.07.26.21.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 21:03:26 -0700 (PDT)
Message-ID: <410cf9c7-a993-4e8f-3279-caba802c6a5c@joelfernandes.org>
Date:   Thu, 27 Jul 2023 00:03:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] rcutorture: Fix stuttering races and other issues
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-2-joel@joelfernandes.org>
 <f6ef4762-6d37-40a4-8272-13b248c46f5b@paulmck-laptop>
 <CAEXW_YTfo8MDcAQk23cw=vxzReZntSXgkUefD+=4yZ+Gb+ZAww@mail.gmail.com>
 <9482525e-fddf-449c-b448-8261cff3395f@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <9482525e-fddf-449c-b448-8261cff3395f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 00:01, Paul E. McKenney wrote:
> On Wed, Jul 26, 2023 at 11:01:40PM -0400, Joel Fernandes wrote:
>> On Wed, Jul 26, 2023 at 4:59 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> On Tue, Jul 25, 2023 at 11:29:06PM +0000, Joel Fernandes (Google) wrote:
>>>> The stuttering code isn't functioning as expected. Ideally, it should
>>>> pause the torture threads for a designated period before resuming. Yet,
>>>> it fails to halt the test for the correct duration. Additionally, a race
>>>> condition exists, potentially causing the stuttering code to pause for
>>>> an extended period if the 'spt' variable is non-zero due to the stutter
>>>> orchestration thread's inadequate CPU time.
>>>>
>>>> Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
>>>> This happens as the stuttering code may run within a softirq due to RCU
>>>> callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
>>>> thus obstructing RCU's progress. This situation triggers a warning
>>>> message in the logs:
>>>>
>>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
>>>>
>>>> This warning suggests that an RCU torture object, although invisible to
>>>> RCU readers, couldn't make it past the pipe array and be freed -- a
>>>> strong indication that there weren't enough grace periods during the
>>>> stutter interval.
>>>>
>>>> To address these issues, this patch sets the "stutter end" time to an
>>>> absolute point in the future set by the main stutter thread. This is
>>>> then used for waiting in stutter_wait(). While the stutter thread still
>>>> defines this absolute time, the waiters' waiting logic doesn't rely on
>>>> the stutter thread receiving sufficient CPU time to halt the stuttering
>>>> as the halting is now self-controlled.
>>>>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>>   kernel/torture.c | 46 +++++++++++++---------------------------------
>>>>   1 file changed, 13 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/kernel/torture.c b/kernel/torture.c
>>>> index 68dba4ecab5c..63f8f2a7d960 100644
>>>> --- a/kernel/torture.c
>>>> +++ b/kernel/torture.c
>>>> @@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
>>>>    * suddenly applied to or removed from the system.
>>>>    */
>>>>   static struct task_struct *stutter_task;
>>>> -static int stutter_pause_test;
>>>> +static ktime_t stutter_till_abs_time;
>>>>   static int stutter;
>>>>   static int stutter_gap;
>>>>
>>>> @@ -729,30 +729,17 @@ static int stutter_gap;
>>>>    */
>>>>   bool stutter_wait(const char *title)
>>>>   {
>>>> -     unsigned int i = 0;
>>>>        bool ret = false;
>>>> -     int spt;
>>>> +     ktime_t now_ns, till_ns;
>>>>
>>>>        cond_resched_tasks_rcu_qs();
>>>> -     spt = READ_ONCE(stutter_pause_test);
>>>> -     for (; spt; spt = READ_ONCE(stutter_pause_test)) {
>>>> -             if (!ret && !rt_task(current)) {
>>>> -                     sched_set_normal(current, MAX_NICE);
>>>> -                     ret = true;
>>>> -             }
>>>> -             if (spt == 1) {
>>>> -                     torture_hrtimeout_jiffies(1, NULL);
>>>> -             } else if (spt == 2) {
>>>> -                     while (READ_ONCE(stutter_pause_test)) {
>>>> -                             if (!(i++ & 0xffff))
>>>> -                                     torture_hrtimeout_us(10, 0, NULL);
>>>> -                             cond_resched();
>>>> -                     }
>>>> -             } else {
>>>> -                     torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
>>>> -             }
>>>> -             torture_shutdown_absorb(title);
>>>> +     now_ns = ktime_get();
>>>> +     till_ns = READ_ONCE(stutter_till_abs_time);
>>>> +     if (till_ns && ktime_before(now_ns, till_ns)) {
>>>> +             torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL);
>>>
>>> This ktime_sub() is roughly cancelled out by a ktime_add_safe() in
>>> __hrtimer_start_range_ns().
>>
>> Yes, functionally it is the same but your suggestion is more robust I think.
>>
>>> Perhaps torture_hrtimeout_ns() needs to
>>> take a mode argument as in the patch at the end of this email, allowing
>>> you to ditch that ktime_sub() in favor of HRTIMER_MODE_ABS.
>>
>> Sure, or we can add a new API and keep the default as relative?
>>
>> Or have 2 APIs:
>> torture_hrtimeout_relative_ns();
>>
>> and:
>> torture_hrtimeout_absolute_ns();
>>
>> That makes it more readable IMHO.
>>
>> Also, do you want me to make both changes (API and usage) in the same
>> patch? Or were you planning to have a separate patch yourself in -dev
>> which I can use? Let me know either way, and then I'll refresh the
>> patch.
> 
> I queued the patch on the -rcu tree's "dev" branch.  It turns out that
> torture_hrtimeout_ns() isn't called very many times, so adding the
> parameter was straightforward.  Plus the compiler might well optimize
> it away anyway.

Ok sounds good, I will make use of it in this patch and send it again after testing.

thanks,

  - Joel


