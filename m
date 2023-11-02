Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C77DECA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjKBF64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjKBF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:58:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901EF133;
        Wed,  1 Nov 2023 22:58:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3A4C433C8;
        Thu,  2 Nov 2023 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904730;
        bh=oUrhkOmCghkLFx1zd+9/LkzSpQOub+y8mn4lj0eMIsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoO7W5dP6rK5/nNsWQFdXanVXH0kpgIwBmFQhcebu/94h+pw+Df88gFyVNHm2/6kt
         HCTKBZ+WN1QLpNa+TEpa8ELkFvYXXy5u8EJC6zSVau1NdLGyxgFMlWZpHm3VBMok0p
         zcN2YsbEjYzTG92e9c7NC85r3m6Yc8MFaDQ0zQBcTWXIgmWnnkXiNYftONEjIVMU0Y
         3wSys/hs8+bKMAgixXJuMsVQAoZyHFG37YJs9tYMKQJhhDUaZR3N7mENY90whleBkm
         Fr7nnqJUTeYlso7zBFSVjz6/0bMj1M6CFYNFugI9M70COlsuq/IGq1/YexkDhNYPqn
         DcLq41GcY+EEw==
Date:   Wed, 1 Nov 2023 22:58:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 10/12] RISC-V: crypto: add Zvksed accelerated SM4
 implementation
Message-ID: <20231102055848.GI1498@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-11-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025183644.8735-11-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:36:42AM +0800, Jerry Shih wrote:
> +struct crypto_alg riscv64_sm4_zvksed_alg = {
> +	.cra_name = "sm4",
> +	.cra_driver_name = "sm4-riscv64-zvkb-zvksed",
> +	.cra_module = THIS_MODULE,
> +	.cra_priority = 300,
> +	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
> +	.cra_blocksize = SM4_BLOCK_SIZE,
> +	.cra_ctxsize = sizeof(struct sm4_ctx),
> +	.cra_cipher = {
> +		.cia_min_keysize = SM4_KEY_SIZE,
> +		.cia_max_keysize = SM4_KEY_SIZE,
> +		.cia_setkey = riscv64_sm4_setkey_zvksed,
> +		.cia_encrypt = riscv64_sm4_encrypt_zvksed,
> +		.cia_decrypt = riscv64_sm4_decrypt_zvksed,
> +	},
> +};

This should be 'static'.

- Eric
