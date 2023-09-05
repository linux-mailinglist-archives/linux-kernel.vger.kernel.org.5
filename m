Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBC792BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbjIERFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354806AbjIEOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:33:33 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D5189;
        Tue,  5 Sep 2023 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693924408;
        bh=ordSnKWniOg5QofBVlOHY0C9oBsPdwAbutimcBxg4Vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sy44lC1YUpbTcAElhCYrv5wU2ma1r7qN3+ezGOT0whislGxf2y3MWE0kmDtf3LO2l
         2SuwcV98oPi6xOlm7KTVUv3eS0/peDetcuxM78QpdAefCxWT5tgjquKd7DHthuiKCj
         M/rvSOhyvXMfeg5KqCuzslNvd1BGttviJzIR810vLNXZpu5jKrYPqjZOHcoo+ArG3/
         UxppeoxJ1MW7lvof+fYTx+XOkUM8QJFsv8oMezkpH9c8RfcEH6JhofL144YgdY8eJb
         yGBWQAfYPOkqX6KXuheD9V6ErmbtPuyKejKlgXR76h6tA+xeEYHFUqjdl0G/k3ViWH
         Q1lNw36+6Hf1w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rg7KN0lVLz1NXg;
        Tue,  5 Sep 2023 10:33:28 -0400 (EDT)
Message-ID: <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
Date:   Tue, 5 Sep 2023 10:34:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] The value may overflow
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>
Cc:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
 <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
 <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 10:15, David Laight wrote:
> ...
>> That would instead be more than 512-16=496 CPUs, correct?  496 CPUs would
>> only require a 31-bit shift, which should be OK, but 497 would require
>> a 32-bit shift, which would result in sign extension.  If it turns out
>> that sign extension is OK, then we should get in trouble at 513 CPUs,
>> which would result in a 33-bit shift (and is that even defined in C?).
> 
> Not quite right :-)
> 
> (1 << 31) is int and negative, that gets sign extended before
> being converted to 'unsigned long' - so has the top 33 bits set.
> 
> (1 << 32) is undefined, the current x86 cpu ignore the high
> shift bits so it is (1 << 0).

Yes, I was about to reply the same thing. A shift of 31 is buggy,
because shifting 1 << 31 raises the sign bit, which sets the top 33
bits when cast to unsigned long. A shift of 1 << 32 is undefined,
with for instance x86 choosing to ignore the top bit.

But in order to have a 1 << 31 shift from this expression:

                 sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);

I *think* we need the group to have 32 cpus or more (indexed within
the group from grplo to grplo + 31 (both inclusive)).

So as soon as we have one group with 32 cpus, the problem should show
up. With FANOUT_LEAF=16, we can have 15 groups of 31 cpus and 1
group of 32 cpus, for:

   15*31 + 32 = 497 cpus.

AFAIU, this would be the minimum value for smp_processor_id()+1 which
triggers this issue.

Thanks,

Mathieu

> 
> If the mask is being used to optimise a search the code might
> just happen to work!
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

