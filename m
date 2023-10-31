Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535D57DD6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJaUOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjJaUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:14:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C9F4;
        Tue, 31 Oct 2023 13:14:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D12C433C7;
        Tue, 31 Oct 2023 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698783259;
        bh=YduzvvmkmCkh7XYeNNev2rvRk7Q+I6SxwFxUFz9VHnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=td53QjSZeq2Du0lMC4bD+vMC4aWlfLC6V0Q7LWNOqXlaz2rTQNiFyJBLjpmpSENEP
         lvws2KtMyn0A53iMkYIQ2qVzbyxMzHmMHXt5+xvSNSDqjA3mNAhW3tTPCXX5laQDj7
         5gEeamGoTjWEIzsQNKPr8douaj0yQdLVMp+kCC3hXHhWbub+UPGXyjKNCicJV7s8x0
         Y3KHPV0Y3IvkwHqHkCaeWIJgGkTSscfIx6Y77pA9McZwK+ZT2LQrK12x7PXeRon0iI
         Y+cRRPMo2jAIJznQndQ5b9BUTsm2nFI2IskQR9RZarDym0db04q2Vqr/kEgTX66QQe
         Y4H7zM1YqwUug==
Date:   Tue, 31 Oct 2023 13:14:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20231031131418.52af79d0@kernel.org>
In-Reply-To: <20231031045157.GA12981@sol.localdomain>
References: <20231030155809.6b47288c@canb.auug.org.au>
        <20231030160953.28f2df61@canb.auug.org.au>
        <ZT896a2j3hUI1NF+@gondor.apana.org.au>
        <20231030150243.0e66ba73@kernel.org>
        <20231031045157.GA12981@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 21:51:57 -0700 Eric Biggers wrote:
> On Mon, Oct 30, 2023 at 03:02:43PM -0700, Jakub Kicinski wrote:
> > On Mon, 30 Oct 2023 13:23:53 +0800 Herbert Xu wrote:  
> > > If we simply apply this patch to the netdev tree then everything
> > > should work at the next merge window.  But perhaps you could change
> > > the patch description to say something like remove the obsolete
> > > crypto_hash_alignmask.  It's not important though.  
> > 
> > I'm happy to massage the commit message and apply the fix to net.
> > But is it actually 100% correct to do that? IOW is calling
> > crypto_ahash_alignmask() already not necessary in net-next or does
> > it only become unnecessary after some prep work in crypto-next?
> > 
> > We can tell Linus to squash this fix into the merge of either
> > crypto-next or net-next, I'm pretty sure he'd be okay with that..  
> 
> It's safe to fold the patch into net-next.  It actually looks like a bug to be
> using the alignmask in the way that net/ipv4/tcp_ao.c is using it.  You don't
> want to be erroring out just because the algorithm declared an alignmask.

Thanks Eric! Applied as commit f2fbb9081123 ("net: tcp: remove call to
obsolete crypto_ahash_alignmask()") to net-next. I'll respin our PR
after some sanity checking.
