Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49AA754573
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGNXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGNXiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:38:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECB3A92
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:38:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-314172bac25so2553618f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689377931; x=1691969931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBT3rUjJGAxYbppKiA656uXoRrGlh1XdLp4eh9nDCrQ=;
        b=p2J7w1ajpOdvwrAGvge0quNYmL6gv7jREgk3lB+pZPHG8ZNS/mdOZ80VZXHKw3CVR3
         tNLxlc1PxlmwAQSpmcMhF1laQQZL8/quot+4wRhUysKnqpDGqM/QPeUIvhj6rWzttEwj
         OBviYO6vvg7P6SS6qBZc3j2mh77sZTstHPKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689377931; x=1691969931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBT3rUjJGAxYbppKiA656uXoRrGlh1XdLp4eh9nDCrQ=;
        b=FnypPc1yulfTzLHWqI45St2cfXkGmxFXG4JWmbiPh2UL8nk80AWEVYp8MvZ4Musu2b
         G92q/TbxGGWSk05TPTFDraKaeIohorFPdTFsj5kzwhMCg9Shg/NDpNZv0LcU8RnnR80O
         c6iQaDHBI7G396VLb4/NSa1JLnh7thCHAF3lCFj1wiAPEqLhhM860dfu0bWwCHds7Ox3
         eMGmTC5EBlNbZ5RI38Z+yLW3TAJZ8CbE4zmjkO7oadqFVtn/ApbsOAT1mI64tg7Pa9DR
         EpwsEdvgh0AyYNvQjzQFoYLYLvAPPqUMumyhT8Sa356MWwdhZenSbNlsWJeRyxdMG5rw
         e2mg==
X-Gm-Message-State: ABy/qLYD46D7xry5TBYiwnmHcW/BEC+SXclaI3kq+4uEs4SYLB+YBMTL
        vaPjz/1Ek4piVxZ6d8k9Zf3X2BR7LJE/EfNYpy5M0A==
X-Google-Smtp-Source: APBJJlFI8UT7ttHWMWTChD+OoeAiz8TeEiUAizhofk5qBde1N/nlsvJ0HFW4KXpG76GQ43uNhHOFDgHRwjioOZyHVSY=
X-Received: by 2002:a5d:5505:0:b0:313:f98a:1fd3 with SMTP id
 b5-20020a5d5505000000b00313f98a1fd3mr5794979wrv.27.1689377931105; Fri, 14 Jul
 2023 16:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org> <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
 <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
In-Reply-To: <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jul 2023 16:38:40 -0700
Message-ID: <CABWYdi010VpHHi6-PLyBB3F_btFggm7XLxstboCRBvBLdoKdmA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To:     David Ahern <dsahern@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Yan Zhai <yan@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:09=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
> > We can start a separate discussion to break it down by category if it
> > would help. Let me know what kind of information you would like us to
> > provide to help with that. I assume you're interested in kernel stacks
> > leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
> > something else.
>
> stack traces would be helpful.

Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-=
xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/

> > Even if I was only interested in one specific reason, I would still
> > have to arm the whole tracepoint and route a ton of skbs I'm not
> > interested in into my bpf code. This seems like a lot of overhead,
> > especially if I'm dropping some attack packets.
>
> you can add a filter on the tracepoint event to limit what is passed
> (although I have not tried the filter with an ebpf program - e.g.,
> reason !=3D NOT_SPECIFIED).

Absolutely, but isn't there overhead to even do just that for every freed s=
kb?

> > If you have an ebpf example that would help me extract the destination
> > port from an skb in kfree_skb, I'd be interested in taking a look and
> > trying to make it work.
>
> This is from 2020 and I forget which kernel version (pre-BTF), but it
> worked at that time and allowed userspace to summarize drop reasons by
> various network data (mac, L3 address, n-tuple, etc):
>
> https://github.com/dsahern/bpf-progs/blob/master/ksrc/pktdrop.c

It doesn't seem to extract the L4 metadata (local port specifically),
which is what I'm after.

> > The need to extract the protocol level information in ebpf is only
> > making kfree_skb more expensive for the needs of catching rare cases
> > when we run out of buffer space (UDP) or listen queue (TCP). These two
> > cases are very common failure scenarios that people are interested in
> > catching with straightforward tracepoints that can give them the
> > needed information easily and cheaply.
> >
> > I sympathize with the desire to keep the number of tracepoints in
> > check, but I also feel like UDP buffer drops and TCP listen drops
> > tracepoints are very much justified to exist.
>
> sure, kfree_skb is like the raw_syscall tracepoint - it can be more than
> what you need for a specific problem, but it is also give you way more
> than you are thinking about today.

I really like the comparison to raw_syscall tracepoint. There are two flavo=
rs:

1. Catch-all: raw_syscalls:sys_enter, which is similar to skb:kfree_skb.
2. Specific tracepoints: syscalls:sys_enter_* for every syscall.

If you are interested in one rare syscall, you wouldn't attach to a
catch-all firehose and the filter for id in post. Understandably, we
probably can't have a separate skb:kfree_skb for every reason.
However, some of them are more useful than others and I believe that
tcp listen drops fall into that category.

We went through a similar exercise with audit subsystem, which in fact
always arms all syscalls even if you audit one of them:

* https://lore.kernel.org/audit/20230523181624.19932-1-ivan@cloudflare.com/=
T/#u

With pictures, if you're interested:

* https://mastodon.ivan.computer/@mastodon/110426498281603668

Nobody audits futex(), but if you audit execve(), all the rules run
for both. Some rules will run faster, but all of them will run. It's a
lot of overhead with millions of CPUs, which I'm trying to avoid (the
planet is hot as it is).

Ultimately my arguments for a separate tracepoint for tcp listen drops
are at the bottom of my reply to Jakub:

* https://lore.kernel.org/netdev/CABWYdi2BGi=3DiRCfLhmQCqO=3D1eaQ1WaCG7F9Ws=
Jrz-7=3D=3DocZidg@mail.gmail.com/
