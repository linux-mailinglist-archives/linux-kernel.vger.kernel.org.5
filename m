Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC487CCD71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJQUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjJQUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:04:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE7F1980;
        Tue, 17 Oct 2023 13:02:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qsqGV-0002eP-Ib; Tue, 17 Oct 2023 22:02:07 +0200
Date:   Tue, 17 Oct 2023 22:02:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
Message-ID: <20231017200207.GA5770@breakpoint.cc>
References: <ZS1/qtr0dZJ35VII@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1/qtr0dZJ35VII@debian.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zhai <yan@cloudflare.com> wrote:
> Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> processing. It mirrors __ip_finish_output logic now. Add an extra check
> in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> sending PTB packets for MTU < 1280").
 

> -	if ((skb->len > mtu && !skb_is_gso(skb)) ||
> -	    dst_allfrag(skb_dst(skb)) ||

My preference is to first remove dst_allfrag, i.e. do this in
a separate change.
