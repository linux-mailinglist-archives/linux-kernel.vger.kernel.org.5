Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60F7D6FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjJYOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjJYOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:53:29 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1F12A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698245606;
        bh=me9S70DpiLbb790yThjt8DPX14g2rPC87Y76GX6j2Uw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XAd/nMlBbaHy4E/vK0HRMBeETjYBBrCvqX/9ky+7CHulrbETkoFDwprjNCFdr/Cpm
         8/DMOG7mUCoaH+vjOVoR8r5iOqu1Hx9tzHGWVzrGoe+UvxLvnja1oMwlMdstZc8Nc3
         MvRaTy+rHqkkFx6YY5v0LqR8uzzRAzUj0g5j4TI/XjnAyIq9esXjiuVjhH4N5WOeW/
         fAq8sgTH+Pvgrhxnxb84oAfZR9yRWkMW/qGmWnoQtIbYpLoHoGF7pJcgr1LhSu+nfy
         qZX0A0Iz6XCWh8C7mJ0Gzvpe6BjcVY6Th0tGSbchxr5KpbQ1JjBgcxfpp0zRWo/GK8
         +7WFIgtbZ31KQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SFsPK0WyBz1YyS;
        Wed, 25 Oct 2023 10:53:25 -0400 (EDT)
Message-ID: <48573a20-19d9-4400-a35e-86bf3dc043ad@efficios.com>
Date:   Wed, 25 Oct 2023 10:53:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231025103105.5ec64b89@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25 10:31, Steven Rostedt wrote:
> On Wed, 25 Oct 2023 15:55:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Wed, Oct 25, 2023 at 08:54:34AM -0400, Steven Rostedt wrote:
>>
>>> I didn't want to overload that for something completely different. This is
>>> not a "restartable sequence".
>>
>> Your hack is arguably worse. At least rseq already exists and most
>> threads will already have it set up if you have a recent enough glibc.
> 
> I don't expect that file to be the final solution. I can look at the rseq
> code, but I really hate to overload that. I'm thinking perhaps another
> system call, or what the hell, add another ioctl like feature to prctl()!
> Actually, prctl() may be the proper place for this.
> 

I don't have an informed opinion on whether the proposed heuristic is a 
good idea or not, but it should definitely be implemented as an 
extension to rseq as suggested by Peter. I've even made the whole rseq 
ABI extensible to accommodate those additional use-cases.

In the initial rounds of rseq implementation, I even called rseq "kTLS" 
because I expected it to be extended and eventually become an ABI that 
contains various per-thread fields which are shared between kernel and 
userspace.

So don't let the specific naming of the rseq system call stop you from 
extending it for other purposes when per-thread shared memory between 
kernel and userspace is needed. Setting up various per-thread areas like 
this on thread creation is not free: it requires additional system calls 
on thread creation. It really makes no sense to have more than one.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

