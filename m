Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7958752FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjGNDOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjGNDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E445D2D69
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79DFA61BD4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66436C433C8;
        Fri, 14 Jul 2023 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689304468;
        bh=G0wOFd16i2t4/e9fIRlP6CAsoeA68X4NI5FK14YAD8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNu7xBxCf9Vsw1SJPsfLP5h3K0zgfNky+Dl7SEL6cbFiCwahG6nG1vxDbnk0Nh9wz
         aEgChbG8fFTbUExxLEkqZWsiwlwwpQnMQ9BJTt5yG3M2nUsie0dlAv6HXNYN2X+XN9
         I+KlTryRVt5+ax5h0fZMbqjJKuj13cIKJwYl3wbVorIyXoX/e8cAcelGTOt6wBFhj8
         roTRejPe0FoC2+fakAWhpLP+IFCYq+NikUIJwkPUzBPQcqL0JTXOqoFnjSwYMfkR6W
         +6KKvoc3M9o/ZQsZ2vGOZgMx7j5DKeNJ/FVS7axS1Smc08k5/P0hjFCDEj56uWHlpq
         VoOHF4atR0jdw==
Date:   Thu, 13 Jul 2023 20:14:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230713201427.2c50fc7b@kernel.org>
In-Reply-To: <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
        <20230711193612.22c9bc04@kernel.org>
        <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
        <20230712104210.3b86b779@kernel.org>
        <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 16:17:31 -0700 Ivan Babrou wrote:
> On Wed, Jul 12, 2023 at 10:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote: =20
> > >   The issue with kfree_skb is not that it fires too frequently (not in
> > > the 6.x kernel now). Rather, it is unable to locate the socket info
> > > when a SYN is dropped due to the accept queue being full. The sk is
> > > stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> > > tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> > > socket lookup are used). A tracepoint with sk information will be more
> > > useful to monitor accurately which service/socket is involved. =20
> >
> > No doubt that kfree_skb isn't going to solve all our needs, but I'd
> > really like you to clean up the unnecessary callers on your systems
> > first, before adding further tracepoints. That way we'll have a clear
> > picture of which points can be solved by kfree_skb and where we need
> > further work. =20
>=20
> The existing UDP tracepoint was there for 12 years and it's a part of
> what kernel exposes to userspace, so I don't think it's fair to remove
> this and break its consumers. I think "do not break userspace" applies
> here. The proposed TCP tracepoint mostly mirrors it, so I think it's
> fair to have it.
>=20
> I don't know why kfree_skb is called so much. I also don't agree with
> Yan that it's not actually too much, because it's a lot (especially
> compared with near zero for my proposed tracepoint). I can easily see
> 300-500k calls per second into it:
>=20
> $ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
> #           time             counts unit events
>      1.000520165             10,108      skb:kfree_skb
>      2.010494526             11,178      skb:kfree_skb
>      3.075503743             10,770      skb:kfree_skb
>      4.122814843             11,334      skb:kfree_skb
>      5.128518432             12,020      skb:kfree_skb
>      6.176504094             11,117      skb:kfree_skb
>      7.201504214             12,753      skb:kfree_skb
>      8.229523643             10,566      skb:kfree_skb
>      9.326499044            365,239      skb:kfree_skb
>     10.002106098            313,105      skb:kfree_skb
> $ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
> #           time             counts unit events
>      1.000767744             52,240      skb:kfree_skb
>      2.069762695            508,310      skb:kfree_skb
>      3.102763492            417,895      skb:kfree_skb
>      4.142757608            385,981      skb:kfree_skb
>      5.190759795            430,154      skb:kfree_skb
>      6.243765384            405,707      skb:kfree_skb
>      7.290818228            362,934      skb:kfree_skb
>      8.297764298            336,702      skb:kfree_skb
>      9.314287243            353,039      skb:kfree_skb
>     10.002288423            251,414      skb:kfree_skb
>=20
> Most of it is NOT_SPECIFIED (1s data from one CPU during a spike):
>=20
> $ perf script | sed 's/.*skbaddr=3D//' | awk '{ print $NF }' | sort |
> uniq -c | sort -n | tail
>       1 TCP_CLOSE
>       2 NO_SOCKET
>       4 TCP_INVALID_SEQUENCE
>       4 TCP_RESET
>      13 TCP_OLD_DATA
>      14 NETFILTER_DROP
>    4594 NOT_SPECIFIED
>=20
> We can start a separate discussion to break it down by category if it
> would help. Let me know what kind of information you would like us to
> provide to help with that. I assume you're interested in kernel stacks
> leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
> something else.

Just the stacks.

> Even if I was only interested in one specific reason, I would still
> have to arm the whole tracepoint and route a ton of skbs I'm not
> interested in into my bpf code. This seems like a lot of overhead,
> especially if I'm dropping some attack packets.

That's what I meant with my drop vs exception comment. We already have
two tracepoints on the skb free path (free and consume), adding another
shouldn't rise too many eyebrows.

> Perhaps a lot of extra NOT_SPECIFIED stuff can be fixed and removed
> from kfree_skb. It's not something I can personally do as it requires
> much deeper network code understanding than I possess. For TCP we'll
> also have to add some extra reasons for kfree_skb, because currently
> it's all NOT_SPECIFIED (no reason set in the accept path):
>=20
> * https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_input.c#L=
6499
> * https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_ipv4.c#L1=
749
>=20
> For UDP we already have SKB_DROP_REASON_SOCKET_RCVBUFF, so I tried my
> best to implement what I wanted based on that. It's not very
> approachable, as you'd have to extract the destination port yourself
> from the raw skb. As Yan said, for TCP people often rely on skb->sk,
> which is just not present when the incoming SYN is dropped. I failed
> to find a good example of extracting a destination port that I could
> replicate. So far I have just a per-reason breakdown working:
>=20
> * https://github.com/cloudflare/ebpf_exporter/pull/233
>=20
> If you have an ebpf example that would help me extract the destination
> port from an skb in kfree_skb, I'd be interested in taking a look and
> trying to make it work.
>=20
> The need to extract the protocol level information in ebpf is only
> making kfree_skb more expensive for the needs of catching rare cases
> when we run out of buffer space (UDP) or listen queue (TCP). These two
> cases are very common failure scenarios that people are interested in
> catching with straightforward tracepoints that can give them the
> needed information easily and cheaply.
>=20
> I sympathize with the desire to keep the number of tracepoints in
> check, but I also feel like UDP buffer drops and TCP listen drops
> tracepoints are very much justified to exist.

I'm not completely opposed to the tracepoints where needed. It's more=20
of trying to make sure we do due diligence on the existing solutions.
Or maybe not even due diligence as much as pay off some technical debt.
