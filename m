Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824417E71A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjKISl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbjKISl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:41:56 -0500
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA592D44
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:41:54 -0800 (PST)
Message-ID: <9ac86e10-e8b7-4eee-a8c4-c58397c1606a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699555311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFMuoyltFtVxWVJxaFtiCDqbh02J2DqjKLDbbrCUOx4=;
        b=UBbIrZ2+2/udeRkulku++eQwdC/IT1SBZX6N44sHyXJMUdl7nlx0uX3us3v7B6hmKNsQJz
        lsfKksKyrZr38BjI/fEf/+mdms1o84VAipZHk6kwFal3ndX2swNhvHidAQsUsd1RxawB7w
        3amgXwyTtg78WkcMuTH8IG6CqXuVGjw=
Date:   Thu, 9 Nov 2023 10:41:43 -0800
MIME-Version: 1.0
Subject: Re: [GIT PULL v2] Networking for 6.7
Content-Language: en-GB
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hou Tao <houtao1@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20231028011741.2400327-1-kuba@kernel.org>
 <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name>
 <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>
 <20231109161406.lol2mjhr47dhd42q@box.shutemov.name>
 <11e2e744-4bc7-45b1-aaca-298b5e4ee281@linux.dev>
 <CAADnVQJtc6JJZMXuZ0M5_0A3=N-TJuYO2vMofJmK6KLhWrBAPg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJtc6JJZMXuZ0M5_0A3=N-TJuYO2vMofJmK6KLhWrBAPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/23 10:18 AM, Alexei Starovoitov wrote:
> On Thu, Nov 9, 2023 at 10:09 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/9/23 8:14 AM, Kirill A. Shutemov wrote:
>>> On Thu, Nov 09, 2023 at 08:01:39AM -0800, Alexei Starovoitov wrote:
>>>> On Thu, Nov 9, 2023 at 7:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>>>> On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
>>>>>>         bpf: Add support for non-fix-size percpu mem allocation
>>>>> Recent changes in BPF increased per-CPU memory consumption a lot.
>>>>>
>>>>> On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 MB
>>>>> to 969 MB, or 8.7x.
>>>>>
>>>>> I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
>>>>> non-fix-size percpu mem allocation"), which part of the pull request.
>>>> Hmm. This is unexpected. Thank you for reporting.
>>>>
>>>> How did you measure this 111 MB vs 969 MB ?
>>>> Pls share the steps to reproduce.
>>> Boot VMM with 288 (qemu-system-x86_64 -smp 288) and check Percpu: field of
>>> /proc/meminfo.
>> I did some experiments with my VM. My VM currently supports up to 255 cpus,
>> so I tried 4/32/252 number of cpus. For a particular number of cpus, two
>> experiments are done:
>>     (1). bpf-percpu-mem-prefill
>>     (2). no-bpf-percpu-mem-prefill
>>
>> For 4 cpu:
>>      bpf-percpu-mem-prefill:
>>        Percpu:             2000 kB
>>      no-bpf-percpu-mem-prefill:
>>        Percpu:             1808 kB
>>
>>      bpf-percpu-mem-prefill percpu cost: (2000 - 1808)/4 KB = 48KB
>>
>> For 32 cpus:
>>      bpf-percpu-mem-prefill:
>>        Percpu:            25344 kB
>>      no-bpf-percpu-mem-prefill:
>>        Percpu:            14464 kB
>>
>>      bpf-percpu-mem-prefill percpu cost: (25344 - 14464)/4 KB = 340KB
>>
>> For 252 cpus:
>>      bpf-percpu-mem-prefill:
>>        Percpu:           230912 kB
>>      no-bpf-percpu-mem-prefill:
>>        Percpu:            57856 kB
>>
>>      bpf-percpu-mem-prefill percpu cost: (230912 - 57856)/4 KB = 686KB
>>
>> I am not able to reproduce the dramatic number from 111 MB to 969 MB.
>> My number with 252 cpus is from ~58MB to ~231MB.
> Even 231MB is way too much. We shouldn't be allocating that much.
> Let's switch to on-demand allocation. Only when bpf progs that
> user per-cpu are loaded.
Sounds good. Will craft a patch for this.
