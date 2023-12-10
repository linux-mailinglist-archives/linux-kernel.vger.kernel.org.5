Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1B80BC65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjLJR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:28:31 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC165E1;
        Sun, 10 Dec 2023 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702229313;
        bh=1sxAue1XcnwrHliRU3dD99r4/Lzb8pcdMONvaCHfTVU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GjReLuVpP94+KS1Vlcj4pqXgnF6dqhh8iYWfUa2wjhB2OOxtkqk82gnqkvWCC/UBo
         IwPIXQ6jmvu/FlBQu16pMPlI9KmRkhUArIxzoI2Lf9ySWQ5c+DC+alg9yU08ATabag
         li/PamLxlee3uBuXw0D74XYht4TKLx1xbrKFU1wH55xATBfusm/dhUaAEIdSxOCoqW
         kZ0Hg1R/+lwKYLT7WxHTCJ76Jf963yzjjRYRRl0UDuzEMNiOK95VJnVSgbprscbJcA
         GQuFWxgQiVa0J80sC24xbepSKAp7uWSU5ByFb2UbJbjOnazfQwwlQiboea7es0uzCK
         mk0Pp5s7PFK0Q==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SpBg555pvzG4T;
        Sun, 10 Dec 2023 12:28:33 -0500 (EST)
Message-ID: <c5c39d2a-a841-4a27-b072-7b190e6838cb@efficios.com>
Date:   Sun, 10 Dec 2023 12:28:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Allow for max buffer data size trace_marker
 writes
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231209175003.63db40ab@gandalf.local.home>
 <2683467e-cadb-4bb8-8c50-87ef052edacb@efficios.com>
 <20231210103009.29010d00@gandalf.local.home>
 <a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
 <20231210113829.780c7097@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231210113829.780c7097@gandalf.local.home>
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

On 2023-12-10 11:38, Steven Rostedt wrote:
> On Sun, 10 Dec 2023 11:07:22 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> It just allows more to be written in one go.
>>>
>>> I don't see why the tests need to cover this or detect this change.
>>
>> If the purpose of this change is to ensure that the entire
>> trace marker payload is shown within a single event, then
>> there should be a test which exercises this, and which
>> validates that the end result is that the entire payload
>> is indeed shown within a single event record.
> 
> No, the purpose of the change is not to do that, because there can always
> be a bigger trace marker write than a single event can hold. This is the
> way it has always worked. This is an optimization or "enhancement". The 1KB
> restriction was actually because of a previous implementation years ago
> (before selftests even existed) that wrote into a temp buffer before
> copying into the ring buffer. But since we now can copy directly into the
> ring buffer, there's no reason not to use the maximum that the ring buffer
> can accept.

My point is that the difference between the new "enhanced" behavior
and the previous behavior is not tested for.

> 
>>
>> Otherwise there is no permanent validation that this change
>> indeed does what it is intended to do, so it can regress
>> at any time without any test noticing it.
> 
> What regress? The amount of a trace_marker write that can make it into a
> the buffer in one go? Now, I agree that we should have a test to make sure
> that all of the trace marker write gets into the buffer.

Yes. This is pretty much my point.


> But it's always
> been allowed to break up that write however it wanted to.

And the enhanced behavior extends the amount of data that can get
written into a single sub-buffer, and this is not tested.

> 
> Note, because different architectures have different page sizes, how much
> that can make it in one go is architecture dependent. So you can have a
> "regression" by simply running your application on a different architecture.

Which is why in the following patches you have expressing the subbuffer
size as bytes rather than pages is important at the ABI level. It
facilitates portability of tests, and decreases documentation / user
burden.

> Again, it's not a requirement, it's just an enhancement.

How does this have anything to do with dispensing from testing the
new behavior ? If the new behavior has a bug that causes it to
silently truncate the trace marker payloads, how do you catch it
with the current tests ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

