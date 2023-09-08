Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20C798860
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbjIHOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbjIHOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429361BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694182465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+DYgz2fEBcb91Gsj/4qYbUxpyYa2G9Hg9hw8gwWLn4=;
        b=Lv2+Hx4lsec2dtRFkTR+GouWAjTjGQBVW/NUWN4BQ4S5CEpQxtRIFyJIEGj0kbBJGTXC5K
        8J15DEsfLubZj6t57y5apx59/i5Yl4oRapB7IzPsljPB3jP9gdVAhs0srtPo8/D75xpYNv
        BBwn3MUiatgsrmC69xjSWZ9NQSgRWwg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-bKG7W9IcN5OsSiWG_n-Qxg-1; Fri, 08 Sep 2023 10:14:23 -0400
X-MC-Unique: bKG7W9IcN5OsSiWG_n-Qxg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502a52cae6bso184683e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182462; x=1694787262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+DYgz2fEBcb91Gsj/4qYbUxpyYa2G9Hg9hw8gwWLn4=;
        b=ViZA41ROJAitCGgu6A9StYeW3LO3LIx/9kJVU6AXHhFcLnAcbJbSfkUKZJ00Cdo1wE
         VciVLcgbzXgiunJSmZ00d4yULGx8J/CPCCEVGqXTX8mHuAcujm56H1ArXyOA2GHFPq5d
         YYX97dy8H2NWhJwCaFajL1/xUBQ08LtLZ7u9wg4eRDYw6fokpr5oMtrLOMIRGeglAFMU
         catyJXMZkEHXXrWAirOBKNOC+ATk3RjluOFjVwUj3iN311c9OdsGnpdaQRFVHCgAZ8tF
         L9HRduH/MmXxCwJTf7H6tmxTCkqLXFBExCp7F5HSYA9jFoMS3Yd2VjdA7sTs28tBbTID
         Pk0Q==
X-Gm-Message-State: AOJu0YwGo0vGXx6Wo6/7VETb9iMmS0jSdsIo3nrZyCZMsMpckhvXDmQd
        eiERb5O2i7s1Q97bOwkzkxKpK5snhArRqFhD32zXKtQiqTJuMRx0IAPVxqfn93lkS/mG5iOtpxr
        XSHbdRN19khNkLPVQ3PhJRYqk
X-Received: by 2002:a19:3858:0:b0:500:9ee2:15f with SMTP id d24-20020a193858000000b005009ee2015fmr1738149lfj.46.1694182462576;
        Fri, 08 Sep 2023 07:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGaqckdgqkXxd5kLJGuKthu1vETthp1cKOh7mjzksIcU0n/q495aEBR6XYOkFNCrr0wGgHMA==
X-Received: by 2002:a19:3858:0:b0:500:9ee2:15f with SMTP id d24-20020a193858000000b005009ee2015fmr1738130lfj.46.1694182462219;
        Fri, 08 Sep 2023 07:14:22 -0700 (PDT)
Received: from [192.168.0.224] (host-82-53-135-115.retail.telecomitalia.it. [82.53.135.115])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b009a2235ed496sm1111489ejb.141.2023.09.08.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 07:14:21 -0700 (PDT)
Message-ID: <4e85dee9-b078-dfb2-1d07-4ee57493d126@redhat.com>
Date:   Fri, 8 Sep 2023 16:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
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
 <20230906200848.GA35105@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230906200848.GA35105@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 22:08, Peter Zijlstra wrote:
> On Wed, Sep 06, 2023 at 10:04:06PM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:
>>
>>>> So one thing we could do is have update_curr_fair() decrement
>>>> fair_server's runtime and yield the period then it hits 0 (and capping
>>>> it at 0, not allowing it to go negative or so).
>>>>
>>>> That way you only force the situation when FAIR hasn't had it's allotted
>>>> time this perio, and only for as much as to make up for the time it
>>>> lacks.
>>>
>>> We can also decrease the runtime to a negative number while in
>>> defer/throttle state, and let the while in replenish_dl_entity() to
>>> replenish with the += runtime;
>>
>> Yes, but my point was that fair_server gives a lower bound of runtime
>> per period, more -- if available -- is fine.
>>
>> If we allow negative runtime, you'll affect future periods, and that is
>> not desired in this case.
>>
>> Or am I still confused?
> 
> That is, let update_curr_fair() decrement fair_server runtime
> *unconditionally* -- even if the task was not selected through the
> server.

Ah, I see! but then we would have to also consider the period, and control a
period... without SCHED_DEADLINE watching us...

I was considering only the "waiting for the 0-lag time to start running (after
being armed)"

If there is no need for the server to be armed... do nothing :-) If it is armed,
reduce the amount of time the fair server could get.

> Specifically, if the fair task is selected normally due to lack of
> deadline tasks, that runtime *still* counts towards the fair-server and
> have the server yield the period when zero.
> 
> This means that fair_server is only effective IFF 'normal' execution
> doesn't match the fair_server.runtime execution.

I see! I *think* it will cause more overhead than doing nothing unless there
is something that can cause starvation. But I need to think more.

-- Daniel


