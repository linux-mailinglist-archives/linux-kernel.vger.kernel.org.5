Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7807B7ABC6F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjIVXyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIVXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:54:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB441A2;
        Fri, 22 Sep 2023 16:54:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qjpy3-00008b-FL; Sat, 23 Sep 2023 01:53:51 +0200
Date:   Sat, 23 Sep 2023 01:53:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Madhu Koriginja <madhu.koriginja@nxp.com>,
        Frode Nordahl <frode.nordahl@canonical.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS
 handling
Message-ID: <20230922235351.GA22532@breakpoint.cc>
References: <20230922210530.2045146-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilya Maximets <i.maximets@ovn.org> wrote:
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
> 
> That leads to nf_conntrack module being impossible to unload as
> it waits for all the conntrack references to be dropped while
> the packet release is deferred in per-cpu cache indefinitely, if
> not consumed by the application.
> 
> The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
> missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
> check and correctly dropping the conntrack context.  However, the
> issue was introduced to IPv6 code afterwards.  Fixing it the
> same way for IPv6 now.
> 
> Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 policy checks are done")
> Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org/
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/ipv6/tcp_ipv6.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

LGTM, thanks for tracking this down.

Acked-by: Florian Westphal <fw@strlen.de>
