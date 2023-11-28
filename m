Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1157FB0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjK1EZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjK1EY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:24:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8B1A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:25:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF1C433C8;
        Tue, 28 Nov 2023 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701145505;
        bh=393VLQEt4vyW6mXZn3SVeUaSptJZ9Z0HCv/6wrn7U2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgG2OmKRc5L3umGA0uU9/vhqiiWipuXcQGdSaRnR+puCrVVUEC51wtFrssi0XAK9W
         1bRAhEun1WNkQ9xm5nTJ15vVcrcE1e5qh9blYfTrGiIeScvg5jU6TuNUjnv63Zx1Uv
         rncPG5OqHI3hvL1nT+mJGiMpH79zyAl7PSgjPX3qBzVEKXBksyk0jYPOnaKObP7gwF
         oPeauCSQYZqFW27/49jwsSwjqgvhnpRd+vPDCjHHW12QkU3zJF+fFSkSCkpbRYZUR0
         aAjx54Ryy27Fmniq9u9DBrDyUFTa7R+Dpv72zMv/0XnbR/zZCJuUGBtu53m5LaR8/W
         pYHN2UlnN+/dA==
Date:   Mon, 27 Nov 2023 20:25:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 13/13] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
Message-ID: <20231128042503.GL1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-14-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-14-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:07:03PM +0800, Jerry Shih wrote:
> +config CRYPTO_CHACHA20_RISCV64

Can you call this kconfig option just CRYPTO_CHACHA_RISCV64?  I.e. drop the
"20".  The ChaCha family of ciphers includes more than just ChaCha20.

The other architectures do use "CHACHA20" in their equivalent option, even when
they implement XChaCha12 too.  But that's for historical reasons -- we didn't
want to break anything by renaming the kconfig options.  For a new option we
should use the more general name from the beginning, even if initially only
ChaCha20 is implemented (which is fine).

> +static int chacha20_encrypt(struct skcipher_request *req)

riscv64_chacha_crypt(), please.  chacha20_encrypt() is dangerously close to
being the same name as chacha20_crypt() which already exists in crypto/chacha.h.

> +static inline bool check_chacha20_ext(void)
> +{
> +	return riscv_isa_extension_available(NULL, ZVKB) &&
> +	       riscv_vector_vlen() >= 128;
> +}

Just to double check: your intent is to simply require VLEN >= 128 for all the
RISC-V vector crypto code, even when some might work with a shorter VLEN?  I
don't see anything in chacha-riscv64-zvkb.pl that assumes VLEN >= 128, for
example.  I think it would even work with VLEN == 32.

I think requiring VLEN >= 128 anyway makes sense so that we don't have to worry
about validating the code with shorter VLEN.  And "application processors" are
supposed to have VLEN >= 128.  But I just wanted to make sure this is what you
intended too.

- Eric
