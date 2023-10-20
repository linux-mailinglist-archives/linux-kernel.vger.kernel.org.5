Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090077D132C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377792AbjJTPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:53:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48950D7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:53:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939BBC433C8;
        Fri, 20 Oct 2023 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817229;
        bh=ow2qZjxXy+ExHb0uBtwQDVUdBzUxQ+bVCPkMYGwP4wo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sXK0+x1HbHx8xuwenAfeT5VRFSF0H1ems9MrSMoYJ8eMd68A9Bf4aFc2OOz944whC
         xVVB7npSSPzXGJoNqGGCsgjOXVb20Q5tKgn9B6Hiuh4koqnutaVsUpD8NPGVjdu4C3
         xy8Okd2yPNEGS06qF3yjgr3W3H2zZXeut+nBKBstuTAWHQ5h1a+6+kRk3euT1cNIT4
         VLrk39+enM1r7NrLa5ZW8jvWBjKSAI+gfK2dLx2bc+NUToKvrI+y+Z/onomZzv8J2a
         z+hBKGxiX0J7Wzb2GBRI7XFZSMsuaCnWnoNRU7q++r9HMnu45fljjIL+r0eQxLGJ7o
         P3eaAV6WPiUVQ==
Message-ID: <e569b2a1-8766-793a-a0c5-f901ef146198@kernel.org>
Date:   Fri, 20 Oct 2023 09:53:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/5] ipv6: add new arguments to
 udp_tunnel6_dst_lookup()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-4-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-4-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> We want to make the function more generic so that it can be used by
> other UDP tunnel implementations such as geneve and vxlan. To do that,
> add the following arguments:
> 
>  - source and destination UDP port;
>  - ifindex of the output interface, needed by vxlan;
>  - the tos, because in some cases it is not taken from struct
>    ip_tunnel_info (for example, when it's inherited from the inner
>    packet);
>  - the dst cache, because not all tunnel types (e.g. vxlan) want to
>    use the one from struct ip_tunnel_info.
> 
> With these parameters, the function no longer needs the full struct
> ip_tunnel_info as argument and we can pass only the relevant part of
> it (struct ip_tunnel_key).
> 
> This is similar to what already done for IPv4 in commit 72fc68c6356b
> ("ipv4: add new arguments to udp_tunnel_dst_lookup()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 10 +++++++---
>  include/net/udp_tunnel.h  |  7 ++++---
>  net/ipv6/ip6_udp_tunnel.c | 33 ++++++++++++++++++---------------
>  3 files changed, 29 insertions(+), 21 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


