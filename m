Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97D7805DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357031AbjHRG1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356640AbjHRG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:27:20 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559910C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:27:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D775060174;
        Fri, 18 Aug 2023 08:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692340036; bh=KZnh1TUgzc6FU/OETdRAOXAFpI9Bp93dnkQOkq4c7Yk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vVAju0UBu/Y7jMhw+hJQB8cFtokMsJWhFbEvUmdOTftiO7FsD+IMHqSGTRMKqL10z
         PrA9Oq0mJENXDRFCGgJWJ8kj62LIl7Awk/sEO7w6cY9DDplz+KK3a8uPrEz/JPA2kz
         EGFc1O4fZ2m0Qz+5pZ5+woYPe2+ctSpFbK6ztLNseCGgyz/I+Y5YZl0V3F7SVPx0Xe
         Lay66+NHHwh1WjHql9GSX1GyX2a3gDpszBR/7+tZKiATfzjfnnhgNj/6bPzo0FO80X
         Jg5vcxVlVDVgNVhxLsMN8jt4TTkurs611XBJMyPX4eo5MSlmqwsGWjb/+kSTCVrQdo
         ZxIfa2XjAhn2A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TGKncdVa1Awz; Fri, 18 Aug 2023 08:27:13 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6C7396015E;
        Fri, 18 Aug 2023 08:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692340033; bh=KZnh1TUgzc6FU/OETdRAOXAFpI9Bp93dnkQOkq4c7Yk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wSixZreVug0KJwkadcP5jJo8YE0C14Eep1/wiMJWMGdu2y5kPwYgxP7G2OF8bOqRq
         0ltgYoARGPknzlb2COxTHptiCBrcVons60DjuM/z3IQLtP3BvRE4DPY0sErixjp755
         0NkHial84NESKqAm0xKeh4+XQqXP/lDtBgEB2jAEotIvOLE50BhF5psNP/XnW7VaPC
         h0IF2f/qyTHNjp6yOEkMA7bKkcTNvWY1TxPprjsgIDchXnOwoqULGP/Of7MAoiWEkm
         bep7gkkulzEhMzthcf7ez+uKZ5qHSM67XtqPRPlmM8WbdVksvPVn+zDXvoYRUE3mMD
         ARcR30AlPRJTA==
Message-ID: <7db66067-8255-8b82-3f7d-273ba53e250c@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 08:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in process_one_work / process_one_work
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
 <ZN6YVG114AZv9Yp8@slm.duckdns.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZN6YVG114AZv9Yp8@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/23 23:59, Tejun Heo wrote:
> On Thu, Aug 17, 2023 at 09:24:28PM +0200, Mirsad Todorovac wrote:
>> Hi,
>>
>> This is your friendly bug reporter.
>>
>> The environment is vanilla torvalds tree kernel on Ubuntu 22.04 LTS and on a Ryzen 7950X
>> assembled box.
>>
>> The kernel reports G taint "properietary module loaded", but I know of no module since
>> the boot state when the status was "Not tainted".
>>
>> Please find the complete dmesg output (or what's left in the ring buffer) and lshw output
>> attached.
>>
>> Here is the dmesg output excerpt:
>>
>> [ 6849.221584] ==================================================================
>> [ 6849.221607] BUG: KCSAN: data-race in process_one_work / process_one_work
>>
>> [ 6849.221635] write to 0xffff9b7440151398 of 8 bytes by task 6364 on cpu 7:
>> [ 6849.221647]  process_one_work+0x504/0x930
>> [ 6849.221660]  worker_thread+0x311/0x7e0
>> [ 6849.221673]  kthread+0x18b/0x1d0
>> [ 6849.221683]  ret_from_fork+0x43/0x70
>> [ 6849.221695]  ret_from_fork_asm+0x1b/0x30
>>
>> [ 6849.221712] read to 0xffff9b7440151398 of 8 bytes by task 5586 on cpu 28:
>> [ 6849.221724]  process_one_work+0x4e8/0x930
>> [ 6849.221737]  worker_thread+0x519/0x7e0
>> [ 6849.221749]  kthread+0x18b/0x1d0
>> [ 6849.221759]  ret_from_fork+0x43/0x70
>> [ 6849.221770]  ret_from_fork_asm+0x1b/0x30
>>
>> [ 6849.221786] value changed: 0x00000000000154d0 -> 0x00000000000154d1
>>
>> [ 6849.221802] Reported by Kernel Concurrency Sanitizer on:
>> [ 6849.221811] CPU: 28 PID: 5586 Comm: kworker/u64:0 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
>> [ 6849.221825] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 6849.221833] Workqueue: events_unbound wq_barrier_func
>> [ 6849.221846] ==================================================================
> 
> That looks like the PENDING bit. The setting is atomic. Maybe there's a raw
> read? Can you map the addresses to lines?
> 
> Thanks.

Sadly not: I had to rebuild the kernel with debug on, so I am attempting to catch the issue again.

Are you interested in any of these:

# sudo dmesg --color=always | grep KCSAN | grep -v acpi | less -R
[  101.395134] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
[  133.628459] BUG: KCSAN: data-race in vprintk_emit+0x343/0x400
[  154.742056] BUG: KCSAN: data-race in rcu_implicit_dynticks_qs / rcu_sched_clock_irq
[  171.626135] BUG: KCSAN: data-race in rcu_implicit_dynticks_qs / rcu_sched_clock_irq
[  209.239022] BUG: KCSAN: data-race in vprintk_emit+0x343/0x400
[  227.654170] BUG: KCSAN: data-race in rcu_implicit_dynticks_qs / rcu_sched_clock_irq
[  240.411681] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  244.273756] BUG: KCSAN: data-race in mas_wr_bnode / mtree_range_walk
[  259.304431] BUG: KCSAN: data-race in mas_wr_bnode / mtree_range_walk
[  261.572037] BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake
[  261.639803] BUG: KCSAN: data-race in mas_spanning_rebalance.isra.0 / mtree_range_walk
[  261.792478] BUG: KCSAN: data-race in mas_wr_bnode / mtree_range_walk
[  262.690859] BUG: KCSAN: data-race in mas_wr_bnode / mtree_range_walk
[  262.866290] BUG: KCSAN: data-race in __mod_lruvec_page_state / shmem_get_folio_gfp
[  262.873251] BUG: KCSAN: data-race in shmem_add_to_page_cache / shmem_recalc_inode
[  262.878189] BUG: KCSAN: data-race in _find_next_and_bit+0x43/0x120
[  268.948899] BUG: KCSAN: data-race in do_epoll_ctl / ep_poll_callback
[  268.990769] BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake
[  269.231597] BUG: KCSAN: data-race in mas_wr_node_store / mtree_range_walk
[  271.133684] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  271.329759] BUG: KCSAN: data-race in mas_wr_node_store / mtree_range_walk
[  273.815884] BUG: KCSAN: data-race in cgroup_freezer_migrate_task / handle_mm_fault
[  274.821427] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  275.007630] BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake
[  275.129286] BUG: KCSAN: data-race in _find_next_and_bit+0x43/0x120
[  275.602701] BUG: KCSAN: data-race in __mod_lruvec_page_state / folio_wait_bit_common
[  275.605323] BUG: KCSAN: data-race in __mod_lruvec_page_state / shmem_get_folio_gfp
[  275.634562] BUG: KCSAN: data-race in shmem_add_to_page_cache / shmem_recalc_inode
[  276.397103] BUG: KCSAN: data-race in do_epoll_ctl / ep_poll_callback
[  279.557086] BUG: KCSAN: data-race in _find_next_and_bit+0x43/0x120
[  282.374662] BUG: KCSAN: data-race in mas_descend_adopt / mtree_range_walk
[  282.640776] BUG: KCSAN: data-race in mas_spanning_rebalance.isra.0 / mtree_range_walk
[  285.180973] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  289.606686] BUG: KCSAN: data-race in kernfs_refresh_inode / kernfs_refresh_inode
[  289.619587] BUG: KCSAN: data-race in kernfs_refresh_inode / kernfs_refresh_inode
[  289.625210] BUG: KCSAN: data-race in generic_fillattr / kernfs_refresh_inode
[  290.000921] BUG: KCSAN: data-race in kernfs_refresh_inode / kernfs_refresh_inode
[  297.491913] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  303.411512] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
[  317.191778] BUG: KCSAN: data-race in __read_end_io / folio_batch_move_lru
[  321.395561] BUG: KCSAN: data-race in n_tty_poll / n_tty_receive_buf_common
[  321.938843] BUG: KCSAN: data-race in n_tty_poll / n_tty_receive_buf_common
[  325.702280] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_idle_stop_tick
[  326.930194] BUG: KCSAN: data-race in tick_sched_do_timer / tick_sched_do_timer
[  327.230053] BUG: KCSAN: data-race in tick_nohz_next_event+0xe7/0x1e0
[  329.501788] BUG: KCSAN: data-race in _find_next_and_bit+0x43/0x120
[  359.973752] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event
#

However, I naively set CONFIG_LOG_BUF_SHIFT to 22 and it rolled over, so the ring buffer
ran out of space ...

I will get them the next time ...

Best regards,
Mirsad Todorovac
