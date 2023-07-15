Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E4754615
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGOBa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGOBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317063A8C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B307761DB4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87869C433C7;
        Sat, 15 Jul 2023 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689384653;
        bh=1EYyqO2hb3tq+k/vBKdVV0wqdHx9vK+YcE5Clt0Cp3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DosxaIy4/UIWIoF0idWd+I1CsjjBAO8G9uAM5/5t5M8Qq/P916mPmz0ltddKycq3n
         qVh5OLC4WRtl4IIS2/ZDY8wHxBj91264sJNrEgbRZLS9yFMsbPqadIaQZwOousaj8E
         o3Ghh5QoXLE4/BkYlyuTacl1j7Ot6Ukr7wu3znVXT8wNtVLvTtnfsPc8JE5r8IuOEZ
         f0kMttZoDfqkXXEXZLW6IK2FWU+3hi4fmfvkjZteFrGQby3ppnWScFcAmXJRVbf4Rw
         H0lbFRqNdqLzBYurI8Pi/0CyN9phdPneC2AEYPY6KhOY1HilPcOLzpTFeJkoDxL3Ai
         mb9+zDvnTz79Q==
Message-ID: <3cab5936-c696-157f-f3a6-eba8b26df32d@kernel.org>
Date:   Fri, 14 Jul 2023 19:30:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Content-Language: en-US
To:     Ivan Babrou <ivan@cloudflare.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Yan Zhai <yan@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230711043453.64095-1-ivan@cloudflare.com>
 <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org>
 <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
 <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
 <CABWYdi010VpHHi6-PLyBB3F_btFggm7XLxstboCRBvBLdoKdmA@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CABWYdi010VpHHi6-PLyBB3F_btFggm7XLxstboCRBvBLdoKdmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 5:38 PM, Ivan Babrou wrote:
> On Fri, Jul 14, 2023 at 8:09 AM David Ahern <dsahern@kernel.org> wrote:
>>> We can start a separate discussion to break it down by category if it
>>> would help. Let me know what kind of information you would like us to
>>> provide to help with that. I assume you're interested in kernel stacks
>>> leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
>>> something else.
>>
>> stack traces would be helpful.
> 
> Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
> 
>>> Even if I was only interested in one specific reason, I would still
>>> have to arm the whole tracepoint and route a ton of skbs I'm not
>>> interested in into my bpf code. This seems like a lot of overhead,
>>> especially if I'm dropping some attack packets.
>>
>> you can add a filter on the tracepoint event to limit what is passed
>> (although I have not tried the filter with an ebpf program - e.g.,
>> reason != NOT_SPECIFIED).
> 
> Absolutely, but isn't there overhead to even do just that for every freed skb?

There is some amount of overhead. If filters can be used with ebpf
programs, then the differential cost is just the cycles for the filter
which in this case is an integer compare. Should be low - maybe Steven
has some data on the overhead?

> 
>>> If you have an ebpf example that would help me extract the destination
>>> port from an skb in kfree_skb, I'd be interested in taking a look and
>>> trying to make it work.
>>
>> This is from 2020 and I forget which kernel version (pre-BTF), but it
>> worked at that time and allowed userspace to summarize drop reasons by
>> various network data (mac, L3 address, n-tuple, etc):
>>
>> https://github.com/dsahern/bpf-progs/blob/master/ksrc/pktdrop.c
> 
> It doesn't seem to extract the L4 metadata (local port specifically),
> which is what I'm after.

This program takes the path of copy headers to userspace and does the
parsing there (there is a netmon program that uses that ebpf program
which shows drops for varying perspectives). You can just as easily do
the parsing in ebpf. Once you have the start of packet data, walk the
protocols of interest -- e.g., see parse_pkt in flow.h.

> 
>>> The need to extract the protocol level information in ebpf is only
>>> making kfree_skb more expensive for the needs of catching rare cases
>>> when we run out of buffer space (UDP) or listen queue (TCP). These two
>>> cases are very common failure scenarios that people are interested in
>>> catching with straightforward tracepoints that can give them the
>>> needed information easily and cheaply.
>>>
>>> I sympathize with the desire to keep the number of tracepoints in
>>> check, but I also feel like UDP buffer drops and TCP listen drops
>>> tracepoints are very much justified to exist.
>>
>> sure, kfree_skb is like the raw_syscall tracepoint - it can be more than
>> what you need for a specific problem, but it is also give you way more
>> than you are thinking about today.
> 
> I really like the comparison to raw_syscall tracepoint. There are two flavors:
> 
> 1. Catch-all: raw_syscalls:sys_enter, which is similar to skb:kfree_skb.
> 2. Specific tracepoints: syscalls:sys_enter_* for every syscall.
> 
> If you are interested in one rare syscall, you wouldn't attach to a
> catch-all firehose and the filter for id in post. Understandably, we
> probably can't have a separate skb:kfree_skb for every reason.

yea, I pushed for the 'reason' design rather than having a tracepoint
per drop location as it is way more scalable. There is a balance and I
believe that is what Kuba is pushing at here.

> However, some of them are more useful than others and I believe that
> tcp listen drops fall into that category.
> 
> We went through a similar exercise with audit subsystem, which in fact
> always arms all syscalls even if you audit one of them:
> 
> * https://lore.kernel.org/audit/20230523181624.19932-1-ivan@cloudflare.com/T/#u
> 
> With pictures, if you're interested:
> 
> * https://mastodon.ivan.computer/@mastodon/110426498281603668
> 
> Nobody audits futex(), but if you audit execve(), all the rules run
> for both. Some rules will run faster, but all of them will run. It's a
> lot of overhead with millions of CPUs, which I'm trying to avoid (the
> planet is hot as it is).
> 
> Ultimately my arguments for a separate tracepoint for tcp listen drops
> are at the bottom of my reply to Jakub:
> 
> * https://lore.kernel.org/netdev/CABWYdi2BGi=iRCfLhmQCqO=1eaQ1WaCG7F9WsJrz-7==ocZidg@mail.gmail.com/

