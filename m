Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEA7FCC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbjK2Ber (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Beq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:34:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C18F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:34:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D103C433C7;
        Wed, 29 Nov 2023 01:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701221692;
        bh=efexJmwUPSN3UagnOJLevL/NsCUGG+z16mHHGRhUgOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mvHe7j2eTTKmJViyg0l2ofc7p417YsZnLcwujCTqpr1j/DA63JLH4gK/ezm304FSe
         fGJiS3E3FecrcmKOw3pOR9KZcYnLD6yldiFVuzkSwFYBSYDXSZJxIMT4e5Yg0s06ON
         pLN9/M81nHJz/is3gU0YnzNmsmxxfMqkzwvvon897i+WeENbW1uVAKEGrl6GAhr64X
         nHwq683T4U3I0NWrayB1kMok7yULVshFjmhTrfG5AFa4lJmgbxUY8gX9xjOMRGMwYd
         QyYKXU+VmpLKzkBFr+wzhSMlJvYvYTbvOOlPjd7o0o2pI1wJEB4Cb87g9ea1kwilsU
         G4nIh8tNgJfWw==
Message-ID: <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
Date:   Tue, 28 Nov 2023 18:34:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
Content-Language: en-US
To:     Dmitry Safonov <dima@arista.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20231128205749.312759-1-dima@arista.com>
 <20231128205749.312759-6-dima@arista.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231128205749.312759-6-dima@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 1:57 PM, Dmitry Safonov wrote:
> If the connection was established, don't allow adding TCP-AO keys that
> don't match the peer. Currently, there are checks for ip-address
> matching, but L3 index check is missing. Add it to restrict userspace

you say L3 index check is missing - add it. yet ...

> shooting itself somewhere.
> 
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_ao.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bf41be6d4721..2d000e275ce7 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
>  		if (!dev || !l3index)
>  			return -EINVAL;
>  
> +		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
> +			return -EINVAL;

... this is checking socket state.


> +
>  		/* It's still possible to bind after adding keys or even
>  		 * re-bind to a different dev (with CAP_NET_RAW).
>  		 * So, no reason to return error here, rather try to be

