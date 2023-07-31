Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95676A4A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGaXNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGaXNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048E1725
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UmOsWiQH33Fcpa0BSqtGcOcgpj2P8GZU38k/bj86GNw=; b=I9JPYeSdt4/20eDjAZyR4mxIJu
        ywdwIquR0x9qZj9TH5/Gs5IUT7H13O+2BK+BLNH2YkemGkICcQ8PboNhMg87jRr9keKyA8eYc2kuW
        /s4EK2Yl6+r8RIR2ANRwCOUcl9Cj7gk8uQbIOi8ccRuJf6J3i4EyIPLI5xZYGzVw++GdCjp5hFdSc
        UfN7VyOH5+9QWXnyKZudi7GkEsSVI0sMoSM49f2nQG0OzqjSK+H1YyMSi4VGcY0tApga4NNyaWu7w
        tyELj+RltudgKldZWWuuvOoYllZfQfmH1DPegwmVYn2Ck41AzP3qV9xu2ybUX0jjbWqFdxP+WfEWe
        KEa/g5XQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQc58-00HYJC-2c;
        Mon, 31 Jul 2023 23:13:42 +0000
Message-ID: <fd7ef41e-097a-9b76-585a-18d14edff9e8@infradead.org>
Date:   Mon, 31 Jul 2023 16:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PSI: select KERNFS as needed
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20230731030740.12411-1-rdunlap@infradead.org>
 <CAJuCfpGQzpWptS0WBBzw8XesPFb5MeG5UVLFDce72wfXNA1joQ@mail.gmail.com>
 <CAJuCfpGQbyD7qPHSTE1o7srTv=sP8ZZTA0F9U1owNO7OEP_M1g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJuCfpGQbyD7qPHSTE1o7srTv=sP8ZZTA0F9U1owNO7OEP_M1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 11:17, Suren Baghdasaryan wrote:
> On Mon, Jul 31, 2023 at 11:14 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Sun, Jul 30, 2023 at 8:07 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> Users of KERNFS should select it to enforce its being built, so
>>> do this to prevent a build error.
>>>
>>> In file included from ../kernel/sched/build_utility.c:97:
>>> ../kernel/sched/psi.c: In function 'psi_trigger_poll':
>>> ../kernel/sched/psi.c:1479:17: error: implicit declaration of function 'kernfs_generic_poll' [-Werror=implicit-function-declaration]
>>>  1479 |                 kernfs_generic_poll(t->of, wait);
>>>
>>> Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI trigger polling")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
> 
> shouldn't this include:
> Closes: https://lore.kernel.org/oe-kbuild-all/202307310732.r65EQFY0-lkp@intel.com/
> ?
> 

That's the same URL as the Link: below.
The difference(s) in Closes: and Link: are not clear to me,
other than Closes: is newer.

>>> Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>
>> Acked-by: Suren Baghdasaryan <surenb@google.com>
>>
>> Thanks!
>>
>>
>>> ---
>>>  init/Kconfig |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff -- a/init/Kconfig b/init/Kconfig
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
>>>
>>>  config PSI
>>>         bool "Pressure stall information tracking"
>>> +       select KERNFS
>>>         help
>>>           Collect metrics that indicate how overcommitted the CPU, memory,
>>>           and IO capacity are in the system.

-- 
~Randy
