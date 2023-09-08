Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4379883C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbjIHOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIHOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81B1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694181584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MemuIqeZQqqKC1XNtSvvn0B7xWADTH4/rC2lAmzD2Ks=;
        b=GGYqkUJiA1Bc/c5YHYiQMVV9YjQuT1fjxdptke35tSrn8Ka4rgO4oPzjpwiM2hcV3ynaUt
        JDfL8kNCMO5nBWIXL0bFe4xX79erP2GSk83uBn2bPTk+FBQfuXjZMm49GfxYoKU+DnQCZ2
        Q1e4/8Fk6U9ccfaewE+dujZ9gH2ranU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-S_7z9SJCOOiBwndqJFVB8A-1; Fri, 08 Sep 2023 09:59:43 -0400
X-MC-Unique: S_7z9SJCOOiBwndqJFVB8A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52c6f3886e3so1533304a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694181582; x=1694786382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MemuIqeZQqqKC1XNtSvvn0B7xWADTH4/rC2lAmzD2Ks=;
        b=Zv0y6/haxL4njvuUiLFYS+KL831+gVhpVw3aCPTuQfOuC1mqgi5gkE6QC3jA9Ii1/Y
         plazVjPF6Rt+foTTPhbhmL+TsNmDJnKbZ+o+B4BjC8ERqU1Yfx9n0VS0oGu7RB9gUQct
         ArqJ/dFyWHfsFYn6rnAdPCrMMrd8p5pZGvTO9RlIu7so3hY/PE+qPNIghaLMv4B0fAu6
         nrJy7O885qd8qXjqqwdt4U9Fd4XUap1T/5PdKDvmQ+g1g/CiFEdRCMdVNvIPd+t37VKg
         E1xxKXsdXOML398mlUP7m+qplTDXx0ft+JSFdnyGVAT9LOoLULiUvD3XGezTqM+cqHIN
         EUWA==
X-Gm-Message-State: AOJu0YwtKlicpHtjSuyFOttExdcjd1gMJb4Qs094ImiSwfDkdQ8LqmjV
        sHhbEk8uZV61B178W0eunwtFTH273mqr6mHZntaZUN73Q7NI4XcNEaQNN8O9Bwy/OQQu5ZJlGrN
        7IKmRBFbuS9RSrJ/TJS3axQqj
X-Received: by 2002:a17:906:8251:b0:9a5:eedb:ee2e with SMTP id f17-20020a170906825100b009a5eedbee2emr1928870ejx.19.1694181582471;
        Fri, 08 Sep 2023 06:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6BZQFdwaJzDd65kf+GYtqsaIHDCuVXAZznAx+FIKm0HIAG/w9QWEePYX1sQqYAB0dkJmKyw==
X-Received: by 2002:a17:906:8251:b0:9a5:eedb:ee2e with SMTP id f17-20020a170906825100b009a5eedbee2emr1928860ejx.19.1694181582170;
        Fri, 08 Sep 2023 06:59:42 -0700 (PDT)
Received: from [192.168.0.224] (host-82-53-135-115.retail.telecomitalia.it. [82.53.135.115])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906354200b0097404f4a124sm1083637eja.2.2023.09.08.06.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 06:59:41 -0700 (PDT)
Message-ID: <0255f3a0-d7fc-16d1-4664-05cb93ba1934@redhat.com>
Date:   Fri, 8 Sep 2023 15:59:40 +0200
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
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
 <20230906200406.GF28278@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230906200406.GF28278@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 22:04, Peter Zijlstra wrote:
> On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:
> 
>>> So one thing we could do is have update_curr_fair() decrement
>>> fair_server's runtime and yield the period then it hits 0 (and capping
>>> it at 0, not allowing it to go negative or so).
>>>
>>> That way you only force the situation when FAIR hasn't had it's allotted
>>> time this perio, and only for as much as to make up for the time it
>>> lacks.
>>
>> We can also decrease the runtime to a negative number while in
>> defer/throttle state, and let the while in replenish_dl_entity() to
>> replenish with the += runtime;

Repying in the sequence...but mostly to try to understand/explain my point (we might even
be in agreement, but touching different parts of the code).

> Yes, but my point was that fair_server gives a lower bound of runtime
> per period, more -- if available -- is fine.

I am targeting that as well, and it works for the case in which we have only RT
tasks causing starvation.

If we have other DL tasks, we cannot force the fair server to run till
completion because it would add a U=1 to the system. Like, if we have a
50ms server runtime... BOOM, we will miss lots of regular DL tasks deadline with
1 ms period. I do not think it is worth to break deadline to give fair server
time immediately. So, the fair server is scheduled as a periodic DL task.

After the initial defer state, the DL server will get the runtime/period
even with the CPU load of DL tasks. But:

	- We do not have such high load of DL tasks as well
	- If one cares about it more, they can reduce the runtime/period
	  granularity to mitigate the defer time
	- If one do not care about RT tasks, just disable the defer mechanism

So I think we are well covered, without having to break the basis of CBS+EDF assumptions
(like that task will not add a higher load than U).


> If we allow negative runtime, you'll affect future periods, and that is
> not desired in this case.

I think that I need to clarify this. I was thinking on this case:

	- Fair server deffered
	- If the server gets some time to run while waiting for the 0-lax
	  we decrease the runtime...
	- When the defer starts, the replenish will happen, and will +=
	  runtime, giving it the correct proportional time left for the
	  period the timer was armed. So it is not the next period, it is
	  the delayed period.

So I think we are thinking the same thing... just with a shift.

> 
> Or am I still confused?
> 

You are not alone... there are many states and I fear that I might be focusing
on a different state.

-- Daniel

