Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FF7E343B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjKGDhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjKGDg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:36:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024A10C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:36:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E5C433C8;
        Tue,  7 Nov 2023 03:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699328216;
        bh=59DDA5/X+gHR+FD5lsDMEoEPfq9TmWUwF/QRhzLwqpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+3VVanlFVCYp6RM8U+gyTEsXBho0Ya5epT6rMWvCFFDbxH+NPUZOLCqxafKTziIc
         j4v5S+arn3Kcbgp62tk9+EAMhp5WJ0mGKJmJspg+ILijVSHPYP52v6Z42XbUHoND/O
         acSFgiL2cp2z6dvGXkNZg8Mf59as3C68VccaxwOulBM9pw6Z78Gb8jJSsVm/rksHTg
         hSWp1fW2Xih+m41jDsvLnF3SfATDy2kTl9N9udWF62OszZw0yyBQOgaqKoTwQAIUuP
         2zqIybdk8JHAkITSys6am7JNgV+0zQ3dGki33rne2JW6780WrsZ9GVYdl2IU0/Mi/G
         yo2Vc1wKwNlEw==
Date:   Mon, 6 Nov 2023 19:36:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ahash - Set using_shash for cloned ahash wrapper
 over shash
Message-ID: <20231107033654.GA938@sol.localdomain>
References: <20231107023717.820093-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107023717.820093-1-dima@arista.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:37:17AM +0000, Dmitry Safonov wrote:
> The cloned child of ahash that uses shash under the hood should use
> shash helpers (like crypto_shash_setkey()).
> 
> The following panic may be observed on TCP-AO selftests:
> 
> > ==================================================================
> > BUG: KASAN: wild-memory-access in crypto_mod_get+0x1b/0x60
> > Write of size 4 at addr 5d5be0ff5c415e14 by task connect_ipv4/1397
> >
> > CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G        W          6.6.0+ #47
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x46/0x70
> >  kasan_report+0xc3/0xf0
> >  kasan_check_range+0xec/0x190
> >  crypto_mod_get+0x1b/0x60
> >  crypto_spawn_alg+0x53/0x140
> >  crypto_spawn_tfm2+0x13/0x60
> >  hmac_init_tfm+0x25/0x60
> >  crypto_ahash_setkey+0x8b/0x100
> >  tcp_ao_add_cmd+0xe7a/0x1120
> >  do_tcp_setsockopt+0x5ed/0x12a0
> >  do_sock_setsockopt+0x82/0x100
> >  __sys_setsockopt+0xe9/0x160
> >  __x64_sys_setsockopt+0x60/0x70
> >  do_syscall_64+0x3c/0xe0
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > ==================================================================
> > general protection fault, probably for non-canonical address 0x5d5be0ff5c415e14: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G    B   W          6.6.0+ #47
> > Call Trace:
> >  <TASK>
> >  ? die_addr+0x3c/0xa0
> >  ? exc_general_protection+0x144/0x210
> >  ? asm_exc_general_protection+0x22/0x30
> >  ? add_taint+0x26/0x90
> >  ? crypto_mod_get+0x20/0x60
> >  ? crypto_mod_get+0x1b/0x60
> >  ? ahash_def_finup_done1+0x58/0x80
> >  crypto_spawn_alg+0x53/0x140
> >  crypto_spawn_tfm2+0x13/0x60
> >  hmac_init_tfm+0x25/0x60
> >  crypto_ahash_setkey+0x8b/0x100
> >  tcp_ao_add_cmd+0xe7a/0x1120
> >  do_tcp_setsockopt+0x5ed/0x12a0
> >  do_sock_setsockopt+0x82/0x100
> >  __sys_setsockopt+0xe9/0x160
> >  __x64_sys_setsockopt+0x60/0x70
> >  do_syscall_64+0x3c/0xe0
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> >  </TASK>
> > RIP: 0010:crypto_mod_get+0x20/0x60
> 
> Make sure that the child/clone has using_shash set when parent is
> an shash user.
> 
> Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Francesco Ruggeri <fruggeri05@gmail.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Salam Noureddine <noureddine@arista.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  crypto/ahash.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/ahash.c b/crypto/ahash.c
> index deee55f939dc..80c3e5354711 100644
> --- a/crypto/ahash.c
> +++ b/crypto/ahash.c
> @@ -651,6 +651,7 @@ struct crypto_ahash *crypto_clone_ahash(struct crypto_ahash *hash)
>  			err = PTR_ERR(shash);
>  			goto out_free_nhash;
>  		}
> +		nhash->using_shash = true;
>  		*nctx = shash;
>  		return nhash;
>  	}
> 
> base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff

Thanks:

Reviewed-by: Eric Biggers <ebiggers@google.com>

Note that this bug would have been prevented if crypto_clone_*() were covered by
the crypto self-tests.

- Eric
