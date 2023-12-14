Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B958125BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjLNDFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjLNDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:05:29 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2909109;
        Wed, 13 Dec 2023 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702523131;
        bh=LrxU6sQ+dsyjQREDT4BqariJas1wB0ELeUtGmLjt5hk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oUm9ZVrJjcgL8ANF1i/wuYUqFY9lGp0W9fEF+9BL7i68tUgB4WB35mDspLiNR77ze
         0sSzjP1Off+usSCenz/w3y9zm6QPrwJFWseeHFDRTmTp1TizwYU1fuRe5iKdksR0g/
         exuSnIzu9cp9Ehjoq2gKuAMCVP7ko/4xjB7l42sz3VvUE/l/WOhlfVDKVmhZNOREJ7
         QNe2U8Df5bwkxoEHVVAdqy2tARarPCr68bq1gaMute0JzlzDy/GoCu5sN0KJA1QTrw
         lbKxMFN/HSqor5XL14SexTrP7RdasHf9Y/flN4sbR8crJAgWtJLcfwlTksMj+fNErl
         mqLbcxwwJDKiw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SrHKR27VRzGcN;
        Wed, 13 Dec 2023 22:05:31 -0500 (EST)
Message-ID: <c36473f6-6633-498c-897e-6513513bea2e@efficios.com>
Date:   Wed, 13 Dec 2023 22:05:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231213211126.24f8c1dd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-13 21:11, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Each event has a 27 bit timestamp delta that is used to hold the delta
> from the last event. If the time between events is greater than 2^27, then
> a timestamp is added that holds a 59 bit absolute timestamp.
> 
> Until a389d86f7fd09 ("ring-buffer: Have nested events still record running
> time stamp"), if an interrupt interrupted an event in progress, all the
> events delta would be zero to not deal with the races that need to be
> handled. The commit a389d86f7fd09 changed that to handle the races giving
> all events, even those that preempt other events, still have an accurate
> timestamp.
> 
> To handle those races requires performing 64-bit cmpxchg on the
> timestamps. But doing 64-bit cmpxchg on 32-bit architectures is considered
> very slow. To try to deal with this the timestamp logic was broken into
> two and then three 32-bit cmpxchgs, with the thought that two (or three)
> 32-bit cmpxchgs are still faster than a single 64-bit cmpxchg on 32-bit
> architectures.
> 
> Part of the problem with this is that I didn't have any 32-bit
> architectures to test on. After hitting several subtle bugs in this code,
> an effort was made to try and see if three 32-bit cmpxchgs are indeed
> faster than a single 64-bit. After a few people brushed off the dust of
> their old 32-bit machines, tests were done, and even though 32-bit cmpxchg
> was faster than a single 64-bit, it was in the order of 50% at best, not
> 300%.

I literally had to dust off my old Eee PC for this :)

> 
> This means that this complex code is not only complex but also not even
> faster than just using 64-bit cmpxchg.
> 
> Nuke it!
> 

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> @@ -3720,6 +3517,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>   	struct rb_event_info info;
>   	int nr_loops = 0;
>   	int add_ts_default;
> +	static int once;

(as you spotted, should be removed)

Thanks,

Mathieu

>   
>   	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
>   	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

