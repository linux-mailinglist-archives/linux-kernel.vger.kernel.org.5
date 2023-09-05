Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6AC7931C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbjIEWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIEWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:01:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBDE6;
        Tue,  5 Sep 2023 15:01:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qde6u-0002RP-0z; Wed, 06 Sep 2023 00:01:24 +0200
Date:   Wed, 6 Sep 2023 00:01:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lucas Leong <wmliang@infosec.exchange>, stable@kernel.org
Subject: Re: [PATH nf v3] netfilter/osf: avoid OOB read
Message-ID: <20230905220124.GD28379@breakpoint.cc>
References: <20230901135021.30252-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901135021.30252-1-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wander Lairson Costa <wander@redhat.com> wrote:
> The opt_num field is controlled by user mode and is not currently
> validated inside the kernel. An attacker can take advantage of this to
> trigger an OOB read and potentially leak information.
> 
> Also add validation to genre, subtype and version fields.

I was about to apply this but your patch misses the Signed-off-by line.

> Reproducer:
> 
> void install_filter_for_leak()
> {

Please remove this for v4, it only clutters the changelog.

> KASAN report:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in nf_osf_match_one+0xbed/0xd10 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:88
> Read of size 2 at addr ffff88804bc64272 by task poc/6431
> 
> CPU: 1 PID: 6431 Comm: poc Not tainted 6.0.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack linux-6.0-rc4/lib/dump_stack.c:88
>  dump_stack_lvl+0xcd/0x134 linux-6.0-rc4/lib/dump_stack.c:106
>  print_address_description linux-6.0-rc4/mm/kasan/report.c:317
>  print_report.cold+0x2ba/0x6e9 linux-6.0-rc4/mm/kasan/report.c:433
>  kasan_report+0xb1/0x1e0 linux-6.0-rc4/mm/kasan/report.c:495
>  nf_osf_match_one+0xbed/0xd10 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:88
>  nf_osf_find+0x186/0x2f0 linux-6.0-rc4/net/netfilter/nfnetlink_osf.c:281
>  nft_osf_eval+0x37f/0x590 linux-6.0-rc4/net/netfilter/nft_osf.c:47
>  expr_call_ops_eval linux-6.0-rc4/net/netfilter/nf_tables_core.c:214
>  nft_do_chain+0x2b0/0x1490 linux-6.0-rc4/net/netfilter/nf_tables_core.c:264
>  nft_do_chain_ipv4+0x17c/0x1f0 linux-6.0-rc4/net/netfilter/nft_chain_filter.c:23
>  nf_hook_entry_hookfn linux-6.0-rc4/./include/linux/netfilter.h:142
>  nf_hook_slow+0xc5/0x1f0 linux-6.0-rc4/net/netfilter/core.c:620

You can keep the KASAN splat but please trim it down, anything below
here
doesn't add much value and neither does print_address_description etc.
above.

>  ffff88804bc64300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> ---

git-am chopped everything below off, so

> 
> Fixes: f9324952088f ("netfilter: nfnetlink_osf: extract nfnetlink_subsystem code from xt_osf.c")
> Reported-by: Lucas Leong <wmliang@infosec.exchange>
> Cc: stable@kernel.org
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

The above wasn't there when I looked at 'git log'.

I will fix this up locally, no need to resend,
but please keep this in mind next time.

Thanks!
