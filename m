Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7168013AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbjLATrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379522AbjLATrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:47:21 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D8E128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1701460043;
        bh=foA2StCe+zumNr+evTpB9NCVEmf//UE2RjTnry8IR+4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jCrDZGli1l5kneFcuBCFiY8Kp4yd5dwcjj58G2BMpPRCIyZjuI8BnCb60vAztvp8t
         AmqtBuvSuvrDDtdIyrQaFf+hEktGnGsw9PXT4lM7ZnPBoK8rRnRVjsdBCzLPqDLM1p
         X8/ecRsigTZNAPoRH+wtOBQ/C3c+SDvdxGgcf1nkdc16fk1ahW2nhh8p/SLzYcqoxr
         5KuhUXaOrnlpcNWnF2XiM865kKm1jRCBzAPtyhzz3SJclCvNNhlTlXvIKsZNBzili5
         YyiiE2eWXOGbVSxE8nEcz44mTVzo8rz4v6Q/pCMPpjPoRqjoi5STEm6qwN0mgdg7GK
         qzDIHJ4xIffww==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Shk9R4FQjz1fB5;
        Fri,  1 Dec 2023 14:47:23 -0500 (EST)
Message-ID: <462218f5-ff1a-4051-ad22-f9de633696e3@efficios.com>
Date:   Fri, 1 Dec 2023 14:47:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Summary of discussion following LPC2023 sframe talk
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a79d1bc3-1aca-4169-a963-b7c9279aa7fd@efficios.com>
 <20231115154912.GC8262@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231115154912.GC8262@noisy.programming.kicks-ass.net>
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

On 2023-11-15 10:49, Peter Zijlstra wrote:
> On Wed, Nov 15, 2023 at 10:09:16AM -0500, Mathieu Desnoyers wrote:
[...]
> 
>>    - When we have a good understanding of the JIT requirements in terms
>>      of frame description content, the other element that would need to
>>      be solved is how to allow JITs to emit frame data in a data structure
>>      that can expand. We may need something like a reserved memory area, with
>>      a counter of the number of elements which is used to synchronize communication
>>      between the JITs (producer) and kernel (consumer).
> 
> Again, huh?! Expand? Typical JIT has the normal epoch like approach to
> text generation, have N>1 text windows, JIT into one until full, once
> full, copy all still active crap into second window, induce grace period
> and wipe first window, rince-repeat.
> 
> Just have a sframe thing per window and expand the definition of 'full'
> to be either text of sframe window is full and everything should just
> work, no?

Is the generated text reachable (for execution) before the end of the
window during which it was created, or is there some kind of epoch delay
between text generation and the moment where it becomes reachable ?

If there is a delay between code generation and the moment where it
becomes reachable (e.g. a whole epoch), then I understand your point
that we could consider the whole jitted text window as belonging to a
single sframe section and register it in one go to the kernel. The
overhead of the system call would be amortized over the epoch duration.

However, if JITs are allowed to incrementally add text to the current
window and make it immediately reachable, then we need to have some
way to synchronize appending "sframe functions" into a memory mapping
that do not require issuing a system call every time a new function
is jitted.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

