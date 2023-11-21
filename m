Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE267F32AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjKUPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:48:02 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C0999
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:47:58 -0800 (PST)
Message-ID: <b3bc868f-bf83-4b86-bcf0-13e99d0b7c7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700581676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVdBdlkIsnH6I2p3E5sm8f7fpOQeckAW/foyxumZ7OY=;
        b=rvCdEZdneqNOUqfvNgM8d99zC5r7Hm7vbnpqQFZJWCW0yCRnq4Mebspr9XdHZ8UY5+giaE
        HTGgWBHAIqQCryqFsD7hJeOB7HWW9cZr4dJMhVVMAI/Lns9q20GyA8hbbwYm4nWX/hWBGk
        0AMg52MLYLOzj2rDPE0PqBd2xWyR3Zk=
Date:   Tue, 21 Nov 2023 23:47:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
 <ZVwIFNdABN1b+qWC@finisterre.sirena.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZVwIFNdABN1b+qWC@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/21 09:29, Mark Brown wrote:
> On Tue, Nov 21, 2023 at 08:58:40AM +0800, Chengming Zhou wrote:
>> On 2023/11/21 02:49, Mark Brown wrote:
>>> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
> 
>>> When we see problems we see RCU stalls while logging in, for example:
> 
>>> [   46.453323] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>> [   46.459361] rcu: 	3-...0: (1 GPs behind) idle=def4/1/0x40000000 softirq=1304/1304 fqs=951
>>> [   46.467669] rcu: 	(detected by 0, t=2103 jiffies, g=1161, q=499 ncpus=4)
>>> [   46.474472] Sending NMI from CPU 0 to CPUs 3:
> 
>> IIUC, here should print the backtrace of CPU 3, right? It looks like CPU 3 is the cause,
>> but we couldn't see what it's doing from the log.
> 
> AIUI yes, but it looks like we've just completely lost the CPU - there's
> more attempts to talk to it visible in the log:
> 
>>> A full log for that run can be seen at:
>>>
>>>    https://validation.linaro.org/scheduler/job/4017095
> 
> but none of them appear to cause CPU 3 to respond.  Note that 32 bit ARM
> is just using a regular IPI rather than something that's actually a NMI
> so this isn't hugely out of the ordinary, I'd guess it's stuck with
> interrupts masked.

Ah yes, there is no NMI on ARM, so CPU 3 maybe running somewhere with
interrupts disabled. I searched the full log, but still haven't a clue.
And there is no any WARNING or BUG related to SLUB in the log.

I wonder how to reproduce it locally with a Qemu VM since I don't have
the ARM machine.

Thanks!
