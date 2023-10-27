Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9F7D9DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjJ0QVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjJ0QVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:21:33 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC4E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698423690;
        bh=lOWi4pJD6G0h7Mj6JlAEbBV8qizhV3ghKNdKygMobMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FbJSdFoXVenOxim/YeM2HG06pI+mUnUVXH2r06D/DCS/CZJDyYN/WIGBrgJNM4kkn
         9UxR/fVKWCSuKmCPrjl0GRpNksgWXkByI0hLDSasQgt6UHEWvPNb3C8NAYVwQiVIy3
         9EHzxzc5Q05KeV3LIWqMGWDdQMsB9U2o5o685csvDD1+2f38WOEampGqJ16WzoZ8rn
         s0PvoLCxkaWnsSbludVIRQg0wqBAkYXsOO7sACzZNP8MFztwRrsyqKkUTEtw5dVx2s
         EYiGcorpFzlK+0Ge2CvMegTUYG7rBCiI8hgauzkUNJ20vCnC0zCDbCINRnrnPb43dm
         TbdjaTtZG/3ig==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SH7G207zVz1ZXZ;
        Fri, 27 Oct 2023 12:21:30 -0400 (EDT)
Message-ID: <0b88d73c-c1c0-4ed8-9e63-b54698fbc039@efficios.com>
Date:   Fri, 27 Oct 2023 12:21:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <20231025235413.597287e1@gandalf.local.home>
 <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
 <20231026071413.4ed47b0e@gandalf.local.home>
 <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
 <20231026152022.668ca0f3@gandalf.local.home>
 <20231026173527.2ad215cc@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231026173527.2ad215cc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 17:35, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 15:20:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Anyway, I changed the code to use:
>>
>> static inline unsigned clrbit(volatile unsigned *ptr)
>> {
>> 	unsigned ret;
>>
>> 	asm volatile("andb %b1,%0"
>> 		     : "+m" (*(volatile char *)ptr)
>> 		     : "iq" (0x2)
>> 		     : "memory");
>>
>> 	ret = *ptr;
>> 	*ptr = 0;
>>
>> 	return ret;
>> }
> 
> Mathieu also told me that glibc's rseq has some extra padding at the end,
> that happens to be big enough to hold this feature. That means you can run
> the code without adding:
> 
>    GLIBC_TUNABLES=glibc.pthread.rseq=0
> 
> Attached is the updated test program.

I think you'll want to modify the semantic of your "cr_flags" field so
it supports nested locks as well. You can change this cr_flags for a
nesting counter. The "yield" bit could be one of the bits of that
counter (e.g. lowest bit).

Therefore extend() become add 0x2, and unextend() become a sub 0x2, and
you can check the lowest bit for yield hint.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

