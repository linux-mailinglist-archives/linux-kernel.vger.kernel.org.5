Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C741077E106
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbjHPMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbjHPMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B42112
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F9C609FF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F2CC433C7;
        Wed, 16 Aug 2023 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692187401;
        bh=JZBhRJ852Cf42i6bqJCHNHsh4gGjICNxRBlUT5z4QLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzkgzl6TyVoaezGH66hU7AyLY9HsEZRhPd5MGlezFUNKjSvydx9mpc2l6CdglZ321
         ZrBA5fHfWhPEiBbeSuwH1KOwgA9vhbRGS9Y8AfY2urZ97TKNSg1qU8gO1DZayte/MZ
         vx5KTBw+btXwDTMPuHxR0Yn/fe2KZ6eBei6Bc1uzaoj0qVkQUokYoapTLwE+4e8+EH
         J/jIEdmaAcsUizsMFEibRhCp6AzsKBIxgo0+oe2sJRna0nVMFxBM2TEwa1PnQXbC0v
         B/EcjrUztd0SoH9ytHzBcWSeIpa41xE8HCK8z6CL9icAMhbNhEEO6ekY0jXrUMpBQ5
         tWohHYfYinbyA==
Date:   Wed, 16 Aug 2023 14:03:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v10 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Message-ID: <ZNy7A17n3BrMuh1b@vergenet.net>
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-10-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815191455.1872316-10-dima@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:14:38PM +0100, Dmitry Safonov wrote:

...

> @@ -1183,6 +1216,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
>  			READ_ONCE(sk->sk_priority),
>  			READ_ONCE(tcp_rsk(req)->txhash));
> +			NULL, NULL, 0, 0);

Hi Dmitry,

This seems to add a syntax error.

...
