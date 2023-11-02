Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157147DEC71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjKBFnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:43:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE326112;
        Wed,  1 Nov 2023 22:43:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041C9C433C8;
        Thu,  2 Nov 2023 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698903809;
        bh=ptXWBqG/5/N20EjAoLJcSbKkpw8UYizDxZ7qmFczEZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NsUDOcegxMfT3N0PyIitMJFmWqA9uGO2I2KjwtRvGVRyd1yvaBKsxKne2Sb3j6t1x
         XUtHyz2ZrrTUFPOY8E4D08VGM/rw0/JMNKF3PZJ7KXJTQpNXkz7w2QcVlR92d9h/iG
         NwZXHzzw9hdU0exJQ8vqMfuHIzVcmdGa0EN59WblZC1jE3we3uh+TATRUqEfIDI7p2
         zdBuobfnYOOIVb3WPUua8EtmvWNqUEiJ6n7moiiF8oMfApkLJ2mQ3XUzNrgtZpJi2a
         hZtTtzUc748wFeyvg27BlTsBcbd1qeCMZEE6cxKXj1xHkhKj8Ayoz0X48NpSzaBPwj
         3Jsi0k7n0l6wQ==
Date:   Wed, 1 Nov 2023 22:43:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
Message-ID: <20231102054327.GH1498@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025183644.8735-13-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:36:44AM +0800, Jerry Shih wrote:
> +static struct skcipher_alg riscv64_chacha_alg_zvkb[] = { {
> +	.base = {
> +		.cra_name = "chacha20",
> +		.cra_driver_name = "chacha20-riscv64-zvkb",
> +		.cra_priority = 300,
> +		.cra_blocksize = 1,
> +		.cra_ctxsize = sizeof(struct chacha_ctx),
> +		.cra_module = THIS_MODULE,
> +	},
> +	.min_keysize = CHACHA_KEY_SIZE,
> +	.max_keysize = CHACHA_KEY_SIZE,
> +	.ivsize = CHACHA_IV_SIZE,
> +	.chunksize = CHACHA_BLOCK_SIZE,
> +	.walksize = CHACHA_BLOCK_SIZE * 4,
> +	.setkey = chacha20_setkey,
> +	.encrypt = chacha20_encrypt,
> +	.decrypt = chacha20_encrypt,
> +} };
> +
> +static inline bool check_chacha20_ext(void)
> +{
> +	return riscv_isa_extension_available(NULL, ZVKB) &&
> +	       riscv_vector_vlen() >= 128;
> +}
> +
> +static int __init riscv64_chacha_mod_init(void)
> +{
> +	if (check_chacha20_ext())
> +		return crypto_register_skciphers(
> +			riscv64_chacha_alg_zvkb,
> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
> +
> +	return -ENODEV;
> +}
> +
> +static void __exit riscv64_chacha_mod_fini(void)
> +{
> +	if (check_chacha20_ext())
> +		crypto_unregister_skciphers(
> +			riscv64_chacha_alg_zvkb,
> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
> +}

When there's just one algorithm being registered/unregistered,
crypto_register_skcipher() and crypto_unregister_skcipher() can be used.

> +# - RV64I
> +# - RISC-V Vector ('V') with VLEN >= 128
> +# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
> +# - RISC-V Zicclsm(Main memory supports misaligned loads/stores)

How is the presence of the Zicclsm extension guaranteed?

- Eric
