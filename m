Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683F7DE9DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjKBBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKBBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06774E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 18:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DC4C433C8;
        Thu,  2 Nov 2023 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698887245;
        bh=bt/lkt4dy1gi54m725q76c9DzTFRJyTNf0BQmwj5u4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHlHp2PMIvBUDVHR661JJDncqlkJTtIwaAU336jsUHR4qVZk+FTMK9am4VpDUDLiK
         18jdtk9x2GnYkK5wzz1V+/2ybMp7JfaUBU6sWRRrAGdnPFs1lFUWqvruiuwlqQM3EO
         M5gzBv4HlODQWcBpk7gEq171ZPxY4R1d6EVYWJd4GqnBSng+/k0b+3YDBkhFnrvkkP
         5ddGTgjfl93NJ9qXbIBgnAPMqKLCxAd39WXvugA4Dn9XBwSKio++tmfoQ2F3W8meJA
         3x1Lx+hCwzpMYYwP9YopRfhBfYWg9yxOcK0DvqfPfGSZZy/HLNMpi+KPIKxdLSGrRn
         F1ZcXRtYYjROA==
Date:   Wed, 1 Nov 2023 18:07:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, fruggeri@arista.com,
        noureddine@arista.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <20231102010723.GA406542@dev-arch.thelio-3990X>
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
 <mhng-df0ad8f4-f79c-427c-9798-8682fca4f516@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-df0ad8f4-f79c-427c-9798-8682fca4f516@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 05:41:10PM -0700, Palmer Dabbelt wrote:
> On Tue, 31 Oct 2023 13:23:35 PDT (-0700), nathan@kernel.org wrote:
> > Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
> > 
> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
> >     663 |         }
> >         |         ^
> >   1 error generated.
> > 
> > On earlier releases (such as clang-11, the current minimum supported
> > version for building the kernel) that do not support C23, this was a
> > hard error unconditionally:
> > 
> >   net/ipv4/tcp_output.c:663:2: error: expected statement
> >           }
> >           ^
> >   1 error generated.
> > 
> > Add a semicolon after the label to create an empty statement, which
> > resolves the warning or error for all compilers.
> > 
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> > Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  net/ipv4/tcp_output.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index f558c054cf6e..6064895daece 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> >  			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
> >  			ptr++;
> >  		}
> > -out_ao:
> > +out_ao:;
> >  #endif
> >  	}
> >  	if (unlikely(opts->mss)) {
> > 
> > ---
> > base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
> > change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498
> > 
> > Best regards,
> 
> This gives me a
> 
> linux/net/ipv4/tcp_output.c:663:2: error: expected statement
>        }
> 
> on GCC for me.

What GCC version?

I cannot reproduce that error with my patch applied. I tested mainline
at commit deefd5024f07 ("Merge tag 'vfio-v6.7-rc1' of
https://github.com/awilliam/linux-vfio") using GCC 6 from kernel.org and
I can reproduce a similar failure with ARCH=x86_64 allyesconfig:

  net/ipv4/tcp_output.c: In function 'tcp_options_write':
  net/ipv4/tcp_output.c:661:1: error: label at end of compound statement
   out_ao:
   ^~~~~~

With this change applied, the error disappears for GCC 6 and GCC 13
continues to build without error. I can try the other supported versions
later, I just did an older and newer one for a quick test.

> So I think something like
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f558c054cf6e..ca09763acaa8 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -659,6 +659,11 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> 			ptr++;
> 		}
> out_ao:
> +	/*
> +	 * Labels at the end of compound statements are a C23 feature, so
> +	 * introduce a block to avoid a warning/error on strict toolchains.
> +	 */
> +	{}
> #endif
> 	}
> 	if (unlikely(opts->mss)) {
> 
> should do it (though it's still build testing...)

I am not opposed to this once we understand what versions are affected
by this so that we have some timeline of removing this workaround.

Cheers,
Nathan
