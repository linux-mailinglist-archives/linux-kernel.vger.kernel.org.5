Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E275BD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGUEm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGUEm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBC10E5;
        Thu, 20 Jul 2023 21:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A8F61083;
        Fri, 21 Jul 2023 04:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3232C433C7;
        Fri, 21 Jul 2023 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689914574;
        bh=JF0Y6sohRAoq9IsPXejZVN/uvgFs0TOdJTkY2sOlxYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZiCzFUxEeXA8Jo7Yd+wrp9lgbS/8O03w/Oro7QIsGrWKMqPVvIZhKFlYwC3exVar
         waZEgrnmoW63XKKQqe6K7JjsToA1uagznAoH2vchElZYBY35Zxj52bIOl5r3SoVl7F
         0nt265dTsWVfZbUu4sU4pA88AlbfplBQOo1+ec9Vanh+6jxmmqKxaa7sZwWK6ekjNC
         bzxQfc/2LRgNBYqto5plaAqbvFj7+naB/scCkjngytI4GCgb9UkLIZuSemtrRxlJJg
         wTWUmB36BoMzAhWlamAq304/fsVvhr//iEdpp4/fhM5+/7XxPXCIQgTE2YIsz/wq2U
         4Mh6HRoJ5WDbQ==
Date:   Thu, 20 Jul 2023 21:42:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Subject: Re: [PATCH v4 08/12] RISC-V: crypto: add a vector-crypto-accelerated
 SHA256 implementation
Message-ID: <20230721044252.GB847@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-9-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-9-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:37:39PM +0200, Heiko Stuebner wrote:
> diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
> new file mode 100644
> index 000000000000..1c9c88029f60
> --- /dev/null
> +++ b/arch/riscv/crypto/sha256-riscv64-glue.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Linux/riscv64 port of the OpenSSL SHA256 implementation for RISCV64
> + *
> + * Copyright (C) 2022 VRULL GmbH
> + * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <asm/simd.h>
> +#include <asm/vector.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/sha2.h>
> +#include <crypto/sha256_base.h>
> +
> +asmlinkage void sha256_block_data_order_zvbb_zvknha(u32 *digest, const void *data,
> +					unsigned int num_blks);
> +
> +static void __sha256_block_data_order(struct sha256_state *sst, u8 const *src,
> +				      int blocks)
> +{
> +	sha256_block_data_order_zvbb_zvknha(sst->state, src, blocks);
> +}

Having a double-underscored function wrap around a non-underscored one like this
isn't conventional for Linux kernel code.  IIRC some of the other crypto code
happens to do this, but it really is supposed to be the other way around.

I think you should just declare the assembly function to take a 'struct
sha256_state', with a comment mentioning that only the 'u32 state[8]' at the
beginning is actually used.  That's what arch/x86/crypto/sha256_ssse3_glue.c
does, for example.  Then, __sha256_block_data_order() would be unneeded.

> +static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
> +			 unsigned int len)
> +{
> +	if (crypto_simd_usable()) {

crypto_simd_usable() uses may_use_simd() which isn't wired up for RISC-V, so it
gets the default implementation of '!in_interrupt()'.  RISC-V does have
may_use_vector() which looks like right thing.  I think RISC-V needs a header
arch/riscv/include/asm/simd.h which defines may_use_simd() as a wrapper around
may_use_vector().

> +		int ret;
> +
> +		kernel_rvv_begin();
> +		ret = sha256_base_do_update(desc, data, len,
> +					    __sha256_block_data_order);
> +		kernel_rvv_end();
> +		return ret;
> +	} else {
> +		sha256_update(shash_desc_ctx(desc), data, len);
> +		return 0;
> +	}
> +}
> +
> +static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
> +			unsigned int len, u8 *out)
> +{
> +	if (!crypto_simd_usable()) {
> +		sha256_update(shash_desc_ctx(desc), data, len);
> +		sha256_final(shash_desc_ctx(desc), out);
> +		return 0;
> +	}

Keep things consistent please.  riscv64_sha256_update() could use
!crypto_simd_usable() and an early return too.

> +static int __init sha256_mod_init(void)

riscv64_sha256_mod_init()

> +{
> +	/*
> +	 * From the spec:
> +	 * Zvknhb supports SHA-256 and SHA-512. Zvknha supports only SHA-256.
> +	 */
> +	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
> +	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
> +	     riscv_isa_extension_available(NULL, ZVBB) &&
> +	     riscv_vector_vlen() >= 128)
> +
> +		return crypto_register_shash(&sha256_alg);
> +
> +	return 0;
> +}
> +
> +static void __exit sha256_mod_fini(void)

riscv64_sha256_mod_exit()

> +{
> +	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
> +	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
> +	     riscv_isa_extension_available(NULL, ZVBB) &&
> +	     riscv_vector_vlen() >= 128)
> +		crypto_unregister_shash(&sha256_alg);
> +}

If the needed CPU features aren't present, return -ENODEV from the module_init
function instead of 0.  Then, the module_exit function can unconditionally
unregister the algorithm.

- Eric
