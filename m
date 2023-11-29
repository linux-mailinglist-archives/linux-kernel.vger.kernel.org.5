Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A07FE204
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjK2Vcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2Vcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:32:47 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87AD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1701293563;
        bh=LSXDfD/sqdOhTH1XnVwusiwpVp5vzDTVZfVELkC2Sro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wxKmwBxa+iiwRH/2QL9Bi98Jbog1A+86OCXxAJLa1nxR/LfGy9TbXtWBoCS1ddW62
         rnb4WxDR43OEllPusZdHQ43CzNDfNnotQJWc6KO+d5XZyUfa4sf7x1MpDm18X/LxGN
         Kc/ZZQH0j4WNohI7FNq2mtwCViaXU+FWRn37NVsBEQvF8L4vmMbMz3mQ025DMXdx+C
         ASlQUkZippwkzAcdLfXTVjp1kiALG8FtZBE3KNK3zaMSz5447XsZFZSyaUmLLwI5Lv
         lCDSXHnZ+Qbcqb6D2G8t4tSyAJqkP+ZxTOS05YdwEXuZaO89eIGiTr1IKuZrTNDNck
         DXgqEBsQrk00w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SgXbv2vBJz1dpY;
        Wed, 29 Nov 2023 16:32:43 -0500 (EST)
Message-ID: <041c83e6-1ca5-4953-bcec-03571135165d@efficios.com>
Date:   Wed, 29 Nov 2023 16:32:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com> <ZWYDtB/otYvTMZWd@andrea>
 <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com> <ZWeDF0eHyOc/b9UJ@andrea>
 <53aac2ac-46ae-46b8-9fdf-34527b79a63b@efficios.com> <ZWesWCRAPV3rZlx9@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZWesWCRAPV3rZlx9@andrea>
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

On 2023-11-29 16:25, Andrea Parri wrote:
>>> As regards the Fixes: tag, I guess it boils down to what we want or we
>>> need to take for commit "riscv: Support membarrier private cmd".  :-)
>>
>> I'm not seeing this commit in the Linux master branch, am I missing
>> something ?
> 
> I don't think you're missing something: I was wondering "what/where is
> this commit"?  Sorry for the confusion.
> 
> 
>>> FWIW, a quick git-log search confirmed that MEMBARRIER has been around
>>> for quite some time in the RISC-V world (though I'm not familiar with
>>> any of its mainstream uses): commit 1464d00b27b2 says (at least) since
>>> 93917ad50972 ("RISC-V: Add support for restartable sequence").  I am
>>> currently inclined to pick the latter commit (and check it w/ Palmer),
>>> but other suggestions are welcome.
>>
>> Supporting membarrier private expedited is not optional since Linux 4.14:
>>
>> see kernel/sched/core.c:
>>
>>                  membarrier_switch_mm(rq, prev->active_mm, next->mm);
>>                  /*
>>                   * sys_membarrier() requires an smp_mb() between setting
>>                   * rq->curr / membarrier_switch_mm() and returning to userspace.
>>                   *
>>                   * The below provides this either through switch_mm(), or in
>>                   * case 'prev->active_mm == next->mm' through
>>                   * finish_task_switch()'s mmdrop().
>>                   */
>>                  switch_mm_irqs_off(prev->active_mm, next->mm, next);
>>
>> Failure to provide the required barrier is a bug in the architecture's
>> switch_mm implementation when CONFIG_MEMBARRIER=y.
>>
>> We should probably introduce a new
>> Documentation/features/sched/membarrier/arch-support.txt
>> to clarify this requirement.
>>
>> Userspace code such as liburcu [1] heavily relies on membarrier private
>> expedited (when available) to speed up RCU read-side critical sections.
>> Various DNS servers, including BIND 9, use liburcu.
> 
> Thanks for the information.
> 
> So I should probably stick to 93917ad50972, which apparently selected
> CONFIG_MEMBARRIER on RISC-V, for the Fixes: tag in question.

I think it goes further than that, because you can explicitly
CONFIG_MEMBARRIER=y, see init/Kconfig:

config MEMBARRIER
         bool "Enable membarrier() system call" if EXPERT
         default y
         help
           Enable the membarrier() system call that allows issuing memory
           barriers across all running threads, which can be used to distribute
           the cost of user-space memory barriers asymmetrically by transforming
           pairs of memory barriers into pairs consisting of membarrier() and a
           compiler barrier.

           If unsure, say Y.

Before 1464d00b27b2, riscv just happened to set it to =n in the defconfig.

I suspect the initial port of riscv merged after v4.14 was already broken.

> I'll look into adding the membarrier feature you mention (as a final/
> follow-up patch), unless you or someone else want to take care of it.

I'll be happy to review it :)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

