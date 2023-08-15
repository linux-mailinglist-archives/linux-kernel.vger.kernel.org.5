Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25CC77C91C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjHOIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjHOIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFE172A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0CDE6185C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FBBC433C8;
        Tue, 15 Aug 2023 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692086761;
        bh=MBjm+i9oi2ovjJMqGomAYUboVzAwAtJyrjcdgX8noeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZWSfEB167QEpWQhBRCSB/0mt7Mx57zwzwAS1gjcDe7zXNzq1dO8d6V419dvV8dIp
         E7EyMkdi7QDHs7jWoD/TlVe5eHOVNd9tttE1Czn7m2K6IAedfY+oa/7gOSf0d+MCNi
         07WXZd6/pKzqeRmAwtu6+KBXiG/pQOMFeoHJdF1N5RrQwJRdGyp6IfxkiGMzZMsPvE
         vEoRcIduM2Y8koNlu7K3xvBcRAd4XlOkrKRUZus0YY3wsKlc5+Qi/m06QEyJApm/I0
         arjNyZU5wy7ploc4kHMMRt5ZPxoe9O5SWRdp0F55aLtCQVAFkPgqJCH+9EP4ra/YSq
         Gy/mJ8qPiCLpA==
Date:   Tue, 15 Aug 2023 11:05:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Florian Westphal <fw@strlen.de>,
        Dong Chenchen <dongchenchen2@huawei.com>,
        steffen.klassert@secunet.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815080557.GK22185@unreal>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
 <20230815060454.GA2833@breakpoint.cc>
 <20230815073033.GJ22185@unreal>
 <ZNsukMSQmzmXpgbS@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNsukMSQmzmXpgbS@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 03:51:44PM +0800, Herbert Xu wrote:
> On Tue, Aug 15, 2023 at 10:30:33AM +0300, Leon Romanovsky wrote:
> >
> > But policy has, and we are not interested in validity of it as first
> > check in if (...) will be true for policy->walk.dead.
> > 
> > So it is safe to call to dir = xfrm_policy_id2dir(policy->index) even
> > for dead policy.
> 
> If you dereference policy->index on a walker object it will read memory
> before the start of the walker object.  That could do anything, perhaps
> even triggering a page fault.

Where do you see walker object? xfrm_policy_id2dir() is called on policy
object, which is defined as "struct xfrm_policy".

Thanks

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
