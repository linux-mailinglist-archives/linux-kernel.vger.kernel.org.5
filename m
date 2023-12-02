Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACF6801DF3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 18:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjLBRQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 12:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 12:16:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB68124
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 09:16:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF781C433C9;
        Sat,  2 Dec 2023 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701537377;
        bh=53gQ5QPBeQ1+h1gAjauNWXZ/KuI17gL+1YoqsW1KWKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN6ES8a4zqtEydvdGod1EVRG1C3ScEKJp/IsOzbHWP0SBqotp79X9MMxrYd7gC6fg
         Fd9Vc6vdRLKd7mSwB7BCIJISaTlD9i3ExUF4QUCLuVDh39jnFN2aZmarB9MybBydWK
         2FLLUZskyd+DSceIs2VdcX1cUIs6Io4ts4GVOpXMR6VmvIypBCl4pwMdrP6Jznp6pJ
         k2lW2Mqt+o9CtAwG/JZUQtoVYQ53CCjtUDKMoclNfaanASzuWYgJdq1eWcspdm7pdT
         BFAJl2KldMZfzxekSW6JEIaGZzdzbEZi6RFdQmn+IMyzI4xoAOYubgdHvI7kF8jART
         1NXT0Q4YFHjsA==
Date:   Sat, 2 Dec 2023 17:16:12 +0000
From:   Simon Horman <horms@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Message-ID: <20231202171612.GC50400@kernel.org>
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129165721.337302-7-dima@arista.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:57:20PM +0000, Dmitry Safonov wrote:
> RFC 5925 (6.2):
> > TCP-AO emulates a 64-bit sequence number space by inferring when to
> > increment the high-order 32-bit portion (the SNE) based on
> > transitions in the low-order portion (the TCP sequence number).
> 
> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> Unfortunately, reading two 4-bytes pointers can't be performed
> atomically (without synchronization).
> 
> In order to avoid locks on TCP fastpath, let's just double-account for
> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
> 
> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

...

> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..b8ef25d4b632 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -121,8 +121,8 @@ struct tcp_ao_info {
>  	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
>  	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
>  	 */
> -	u32			snd_sne;
> -	u32			rcv_sne;
> +	u64			snd_sne;
> +	u64			rcv_sne;
>  	refcount_t		refcnt;		/* Protects twsk destruction */
>  	struct rcu_head		rcu;
>  };

Hi Dmitry,

In tcp_ao.c:tcp_ao_connect_init() there is a local
variable:

        struct tcp_ao_info *ao_info;

And the following assignment occurs:

                ao_info->snd_sne = htonl(tp->write_seq);

Is this still correct in light of the change of the type of snd_sne?

Flagged by Sparse.

...
