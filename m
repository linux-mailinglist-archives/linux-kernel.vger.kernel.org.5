Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21271793FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbjIFO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjIFO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABF173D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694012297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jNip9bj5C1c9YzBGwzUrMni4LHnovwwr70rjCNb7jA=;
        b=BrLMiD1BMxFJyJLMLGu6sx3FJMM+Trtf2/5MUaAW0y7VwkUNFuCbjV2NDK5P+4pS0y/qcE
        heajdfhHOEIXDw1LPabFqPuzPyWxhwsFJouKsk2JxfbZlNfEYbM3NXIZNeFnp/7Ovml8gp
        Yarj/ranAy/VaDRjoE4JTE8jcFleMA4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-yOk5TZL8PXWC4C_zOtMi9Q-1; Wed, 06 Sep 2023 10:58:15 -0400
X-MC-Unique: yOk5TZL8PXWC4C_zOtMi9Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52a0f6f7a3bso1579392a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012295; x=1694617095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jNip9bj5C1c9YzBGwzUrMni4LHnovwwr70rjCNb7jA=;
        b=lJRrDBSfg9KttApNto7gCeLFCE0zWQcN7yTmZ6GZ8SSUZ+Jz84foAAMsJQO3cXTHO5
         8Z6DKzixB9n697+3kKBcFtb0Q/tXqY2EH3lv0Wav/nIPcuf+VOBUciXT+vsrLBLJF0ra
         i15DhlFhKhf/IjGufGO/djQecymTaJ3/l/Ma1YB/dgSdRA1bwI6TCN69TuMzj4KAtnif
         qrU4R4Ske66W40hC9ilKsVEjeF/fy3oaciX34Mv2OxWZs9VRpu4kiApJtccEsu06pWo7
         kqZ8ZPD9CuDxDYxRhvtKEANQgsFSpI6+oVgvGWHrPDQBlTvMpPNxJB8fL5Iz8o1O6SLr
         8X4A==
X-Gm-Message-State: AOJu0YyhV6jgcxMGOCdcjYTBnRnXC5ViK8UTXvM3mw0FDQZhFs3FdNHL
        ahXlD8Rgkb/kLCKL2z7fJDGIgD3PuX9jTaCBEXyt8/Vt2jBDHWlQ0yLLckYNVf3dr5yaHpNVJH9
        509KMNhlCCcZZ4UdmHIm9eUSG
X-Received: by 2002:aa7:dcd2:0:b0:522:3149:159b with SMTP id w18-20020aa7dcd2000000b005223149159bmr3256825edu.2.1694012294755;
        Wed, 06 Sep 2023 07:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQuj0pidhA7A3e0m34YtborrgxgbzPqYeW1OZpjHsKHSicrqVKVddRDP3vLjt6zPY9jjf9RQ==
X-Received: by 2002:aa7:dcd2:0:b0:522:3149:159b with SMTP id w18-20020aa7dcd2000000b005223149159bmr3256797edu.2.1694012294384;
        Wed, 06 Sep 2023 07:58:14 -0700 (PDT)
Received: from [192.168.0.224] (host-82-53-135-115.retail.telecomitalia.it. [82.53.135.115])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c387000000b0052a19a75372sm8456687edq.90.2023.09.06.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 07:58:13 -0700 (PDT)
Message-ID: <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
Date:   Wed, 6 Sep 2023 16:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230906082952.GB38741@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 10:29, Peter Zijlstra wrote:
> On Tue, Sep 05, 2023 at 05:24:40PM +0200, Daniel Bristot de Oliveira wrote:
>> On 9/5/23 15:42, Peter Zijlstra wrote:
>>> On Thu, Aug 31, 2023 at 10:28:57PM +0200, Daniel Bristot de Oliveira wrote:
>>>> +void dl_server_start(struct sched_dl_entity *dl_se, int defer)
>>>>  {
>>>> +	if (dl_se->server_state != DL_SERVER_STOPPED) {
>>>> +		WARN_ON_ONCE(!(on_dl_rq(dl_se) || dl_se->dl_throttled));
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (defer) {
>>>> +		/*
>>>> +		 * Postpone the replenishment to the (next period - the execution time)
> 
> perhaps explicitly mention zero-laxity here, then we all know what is
> meant, no?

Last time I used that word it caused more problems than helped :-) But I will
add it and specify that is "for this task".

>>>> +		 *
>>>> +		 * With this in place, we have two cases:
>>>> +		 *
>>>> +		 * On the absence of DL tasks:
>>>> +		 *	The server will start at the replenishment time, getting
>>>> +		 *	its runtime before now + period. This is the expected
>>>> +		 *	throttling behavior.
>>>> +		 *
>>>> +		 * In the presense of DL tasks:
>>>> +		 *	The server will be replenished, and then it will be
>>>> +		 *	schedule according to EDF, not breaking SCHED_DEADLINE.
>>>> +		 *
>>>> +		 *	In the first cycle the server will be postponed at most
>>>> +		 *	at period + period - runtime at most. But then the
>>>> +		 *	server will receive its runtime/period.
>>>> +		 *
>>>> +		 *	The server will, however, run on top of any RT task, which
>>>> +		 *	is the expected throttling behavior.
>>>> +		 */
>>>> +		dl_se->deadline = rq_clock(dl_se->rq) + dl_se->dl_period - dl_se->dl_runtime;
>>>
>>> I was confused by this, but this is an instance of
>>> replenish_dl_new_period(), where we explicitly do not preserve the
>>> period.
>>
>> yeah, it is two operations in one (so not straight forward). It sets
>> the period as the now - runtime, so..
> 
> Right. I'll just attribute it to me being generally confused about
> everything after holidays ;-)
> 
> The thing that tripped me was that the use of rq_clock() breaks
> periodicy, except of course you want/need that when you start a new
> activation.

that rq_clock() is only used at the time in which we start the deferred
server. If the throttling condition stays one, the server will act as a
regular periodic DL task...

> 
>>>> +		/* Zero the runtime */
>>>> +		dl_se->runtime = 0;
>>>> +		/* throttle the server */
>>>> +		dl_se->dl_throttled = 1;
>>
>> as the server is throttled, it will set the replenishing timer for now - runtime + period because
>> of the deadline.
> 
> Yeah, it's a wee hack to move it to the zero-laxity point. I was
> considering if it makes sense to push that down and make it available
> for all DL tasks, but I'm not sure..

It might be useful in the future, like when DL dominates all other schedulers, so
we can have a way to schedule a deferred work, like kworkers... :-) But it might be
too early for that..

>>> I'm thinking this is wrong -- ISTR there definite benefits to explicit
>>> slack time scheduling, meaning the server should also run while DL tasks
>>> are on.
>>
>> I can add the check to enable it also in the presence of DL tasks, we just need
>> to have consider that the dl server is a dl task as well when disabling.
> 
> Why not keep what was there, always run the thing when there's FAIR
> tasks around? Or do you see severe overhead from running it with only
> FAIR tasks on?

Assuming that most of the cases people only have fair tasks, which is probably
true in the regular kernel... (like, no threaded IRQs).

>> It is a benefit because it will fix the case in which a CPU full of DL tasks
>> (possible with global).
>>
>> Additionally, running the server when there are only fair tasks
>>> is mostly harmless, right? So why this change?
>>
>> Rhe problem is that we never know when a RT one will arrive :-/
>>
>> E.g., only fair tasks, server enabled. All fine :-) Then an RT arrives, and gets
>> postponed by the server... RT people complaining (for those thinking on adding
>> a server for RT, we will have a similar problem as we have with throttling today +
>> DL has no fixed priority).
> 
> Well, the thing is, the moment you run DL tasks on that machine those RT
> tasks will get delayed *anyway*. RT people need to stop pretending FIFO
> is the highest class.
> 
> But yeah, I can see why they might get upset if the time is then used to
> run FAIR tasks while their RT task gets to wait.

right

>> We will still face the same problem with defferable server, and the example is the same,
>> just with a shift in the RT arrival. e.g., only fair task for (server period - runtime),
>> then the server gets enabled, and a 1us after the RT arrives and gets postponed... again.
>>
>> So the need to enable it only after the dispatch of a kind of RT (or DL to be added)
>> tasks that can cause starvation.
>>
>> We could simplify it by enabling only on RT/DL arrival but... if there is nothing to
>> starve... it is not needed anyways so less overhead avoiding the enqueue...
> 
> So one thing we could do is have update_curr_fair() decrement
> fair_server's runtime and yield the period then it hits 0 (and capping
> it at 0, not allowing it to go negative or so).
> 
> That way you only force the situation when FAIR hasn't had it's allotted
> time this perio, and only for as much as to make up for the time it
> lacks.

We can also decrease the runtime to a negative number while in defer/throttle state, and let
the while in replenish_dl_entity() to replenish with the += runtime;

here:
--- %< ---
        /*
         * We keep moving the deadline away until we get some
         * available runtime for the entity. This ensures correct
         * handling of situations where the runtime overrun is
         * arbitrary large.
         */
        while (dl_se->runtime <= 0) {
                dl_se->deadline += pi_of(dl_se)->dl_period;
                dl_se->runtime += pi_of(dl_se)->dl_runtime;
        }

--- >% ---

it is already done... no?

> 
>>>
>>> One of the benefits was -- IIRC, that we no longer need to subtract some
>>> random margin from the reservation limit, but there were more I think.
>>>
>>
>> We can simplify things because we can start ignoring the rt throttling limit when
>> there is no need to throttle... like on grub (but, only after we remove the rt
>> throttling).
>>
>> Thoughts?
> 
> The moment the fair server is there (these patches) you should also kill
> the throttling. It doesn't make sense to have both.
> 

