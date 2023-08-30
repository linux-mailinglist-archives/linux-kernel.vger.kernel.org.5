Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83178DF17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjH3TIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbjH3LoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:44:11 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2543F1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:44:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 99CBC60177;
        Wed, 30 Aug 2023 13:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693395843; bh=tEdH1idTYBbHaHmPL3gnS486jO30KAsWxS0zmHdrN0A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FyoJGKJ98vdSLyMjbWGqlJo4Sei/CTW2K7E1I4n8MneRzZWZaejnuhVYHd4ai5Nf4
         Lo5t+rZ30+GBkWPZxe5G2AilVl7vqeWhO1BVpa0lyBZa9LwKLcQ7XjGNqg76KW6+LI
         MhHTnBo6J2lAftRyaPoXRLlOrNtpd0TPZzWox9oQsIdPMRGR8n0KgFXAv+UqaCJZHK
         Um98QnPPANf3NGEZrv0C3iNUMoeQEqF8YpQR1JZi2LeQBa3llHA7Vcnv2AKUk1hQcP
         levF8P//WDxAiXsYDO4IHTwg3AK7dV1CilVnIUiQuMCpHCnnkXvQx4Qq3W9JQTboGk
         uXabybBcfJQuA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Am_AuITKUZps; Wed, 30 Aug 2023 13:44:00 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 22CA060173;
        Wed, 30 Aug 2023 13:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693395840; bh=tEdH1idTYBbHaHmPL3gnS486jO30KAsWxS0zmHdrN0A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SeNisTkOyy3GlhutJ3fqlMq8IByeHD1bRuJ9C81CbagGMDLccOSpyOePAWzqWvi6E
         6FOe+IitTIs/6zypyQIbL9iyeqHw2zd5D/IJXoNk3QwJhWHCN7E2phI65I745cUUoM
         9eHZ87sHVuMAT1hEMM6jJ55/cWGxGytn8uMlfU818OhKun/eroO/lkrJDmhk30/xRX
         1bd1ccsyLzxVeYn+v6jl/W8OdKa7pYAks1N8d5Cj4l9woZqYFn0wsgBD7lPrM3jEKk
         N9VHxD90Beoe2WMRo1o/FyDfIxYo2keA20sn28uDLAwJ1MNmt9nv2YyNz9vAktPDfF
         lxs4kSf8rjm9Q==
Message-ID: <5f60813c-c52b-5c08-27c7-490b7d28c598@alu.unizg.hr>
Date:   Wed, 30 Aug 2023 13:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZO5DR771Khv1d5gR@casper.infradead.org>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZO5DR771Khv1d5gR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mr. Matthew,

On 8/29/23 21:13, Matthew Wilcox wrote:
> On Mon, Aug 28, 2023 at 11:14:23PM +0200, Mirsad Todorovac wrote:
>> In the vanilla torvalds tree 6.5 kernel on the Ubuntu 22.04 system, KCSAN found another data race:
> 
> KCSAN is wrong.

Thank you for evaluating this bug report to such a detail.

Well, I ain't giving up on KCSAN anyway, because it found some real life data races.

To express it more graphically, it is very unpleasant when the other core changes the data
from underneath you or it magically and unexpectedly changes in the course of some work ...

:-(

>> [   34.102069] write (marked) to 0xffffef9a44978bc0 of 8 bytes by interrupt on cpu 28:
>> [   34.108569] mpage_read_end_io (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/bitops.h:55 /home/marvin/linux/kernel/linux_torvalds/./include/asm-generic/bitops/instrumented-atomic.h:29 /home/marvin/linux/kernel/linux_torvalds/./include/linux/page-flags.h:739 /home/marvin/linux/kernel/linux_torvalds/fs/mpage.c:55)
> 
>          bio_for_each_folio_all(fi, bio) {
>                  if (err)
>                          folio_set_error(fi.folio);
>                  else
>                          folio_mark_uptodate(fi.folio);
>                  folio_unlock(fi.folio);
>          }

> It's noting the write to folio->flags in folio_mark_uptodate().  You can
> see it's locked.  Also, the folio is under I/O.

Yes, from folio_unlock(fi.folio), it appears that somewhere it was locked. But finding
where it was locked is beyond my understanding ATM.

I see folio_put() in other places, but it seems to increase refcount only, I did not where
it is locked, but this is probably just me ...

>> [   34.115221] read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
>> [   34.121702] folio_batch_move_lru (/home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1814 /home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1824 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1636 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1659 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:216)
> 
> Here, it's noting the read to folio->flags that's part of page_to_nid().
> 
>> [   34.121713] folio_batch_add_and_move (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:235)
>> [   34.121724] folio_add_lru (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/preempt.h:95 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:518)
>> [   34.121735] folio_add_lru_vma (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:538)
>> [   34.121746] do_anonymous_page (/home/marvin/linux/kernel/linux_torvalds/mm/memory.c:4146)
> 
> Here we can see the page is freshly allocated.
> 
> So KCSAN has three things wrong here.  One is that the write to
> folio_mark_uptodate() is setting a bit, that is nowhere near the bits
> that are used for the node ID.  It can't know that; it doesn't track
> writes at that granularity.
> 
> The second thing is that the node bits in folio->flags are immutable.
> They're set at boot (or memory hotplug).  There is never a race risk when
> reading them.  Presumably there needs to be some kind of annotation to
> tell KCSAN that this is always safe.
> 
> The third thing is that these two accesses cannot race.  The write is
> to a folio which is under I/O, so cannot be freed.  The read is to a
> folio which has just been allocated, so cannot be under I/O.  This is
> some kind of failure of KCSAN.

Based on your insight, I will assume that the bug report is resolved.

Thank you again for your time.

Best regards,
Mirsad Todorovac

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
