Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9297D7737
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJYV4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjJYV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:56:36 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF799D4E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698270993;
        bh=TA9xzrgkBA6toYmpTWXm43xTIGzbqE9vmGlGdMiPvJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EKXfRoSmYTkR+fQlQEuCgyBcvnIUpPLODi9TvWmy9AczK1+e7NAfKkS8otA4kSRcR
         fJE6CY7NvzF9Xbi8N3DIKAHkkOmllTJ3U0zQ2ChmRrEyXStg/adLZTwclyMeLERggI
         SVnFxmh2VklAV4J0/UHfSidLb9+7OLwZd1uaydCtDwxe3HbSVanqp6S75TmhBsvN55
         NEiKeGmzTYYNdl/n/Af8C2xslG2byNxG8VtGH5sAirPUOy+mdQ1s1WsnYGFTXB0Ekv
         vo8Cu1GflDhkoXYIJYo8x0gIwuzZTTUQWnztaSun1tThE69AZXpDNO4hmacWWe8tXW
         yzTAwnjK/QGVg==
Received: from [IPV6:2606:6d00:100:4000:582e:ab84:d98b:7516] (unknown [IPv6:2606:6d00:100:4000:582e:ab84:d98b:7516])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SG2nY4dJxz1Z4N;
        Wed, 25 Oct 2023 17:56:33 -0400 (EDT)
Message-ID: <dc5c0574-e7e9-4538-9cd1-528fc0a3e355@efficios.com>
Date:   Wed, 25 Oct 2023 17:56:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
 <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
 <20231025162435.ibhdktcshhzltr3r@f>
 <20231025131731.48461873@gandalf.local.home>
 <0d95385f-1be1-4dcf-93cb-8c5df3bc9d0c@efficios.com>
 <20231025151951.5f1a9ab1@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231025151951.5f1a9ab1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25 15:19, Steven Rostedt wrote:
> On Wed, 25 Oct 2023 14:49:44 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>
>>> No, I wouldn't say it's the same as priority inheritance, which is to help
>>> with determinism and not performance. PI adds overhead but removes
>>> unbounded latency. On average, a non PI mutex is faster than PI mutex, but
>>> can suffer from unbounded priority inversion.
>>
>> AFAIU, this is because PI mutex as implemented by sys futex only boosts the
>> priority of the lock owner. In my proposal here the owner would be able to
>> borrow scheduler slices from the waiters as well.
> 
> I would be worried that that could cause even more scheduling disruption.
> Now we are taking time slices from other CPUs to run the current one?
> 

AFAIU, as we look at the time slices of the waiting tasks, those have meaning
in the context of the runqueue they are currently attached to. We first consume
time slices from tasks sharing the same runqueue as the owner task. Else, I
guess we'd need to migrate the owner task to the runqueue where the time slice
is available so we can use it (but only if migration of the owner task is
allowed to that target cpu).

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

