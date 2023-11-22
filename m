Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8481E7F3B56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjKVBcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjKVBcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:32:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76030DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:32:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986FBC433C8;
        Wed, 22 Nov 2023 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700616732;
        bh=bm2hc6HT2WoAs5lqntk0P/geqlIujjMacD9zqFmU6zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+oEnfydqCQHukpHD415uJw6zLd4ltiB/0o5AEVdE2OaAaItk4smuVw9AvNBXVXxQ
         jK25tuFtjUmGF5101V7+MFPf0juQxLbF1hZleJHVnSJhNubWO1W0TB38gNGIE922lI
         JwVIuVwtptrIgX+gxtMwwz9ufc87izVGDW+hYQt7eO1rxh97JXEGNNcZnOQfKP5ffs
         vUpGkia7APJFkH3MDQUrxKKjPV0i5w53IJ4jHQqUomSRgWvHUelFIWFajNZo032+12
         LwGA5svWtSqmdRq3cqaGIP/LpJeSoBmyrfXrKbTZoV6ITOuVXzfwXDk4yTP8q9889o
         ggJyqziI8AeNQ==
Date:   Tue, 21 Nov 2023 17:32:10 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/12] RISC-V: crypto: add Zvknhb accelerated SHA384/512
 implementations
Message-ID: <20231122013210.GH2172@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-10-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025183644.8735-10-jerry.shih@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:36:41AM +0800, Jerry Shih wrote:
> +static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
> +				 unsigned int len)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Make sure struct sha256_state begins directly with the SHA256
> +	 * 256-bit internal state, as this is what the asm function expect.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);

There's a copy-paste error here; all the 256 above should be 512.

> +static struct shash_alg sha512_alg[] = {
> +	{
> +		.digestsize = SHA512_DIGEST_SIZE,
> +		.init = sha512_base_init,
> +		.update = riscv64_sha512_update,
> +		.final = riscv64_sha512_final,
> +		.finup = riscv64_sha512_finup,
> +		.descsize = sizeof(struct sha512_state),
> +		.base.cra_name = "sha512",
> +		.base.cra_driver_name = "sha512-riscv64-zvkb-zvknhb",
> +		.base.cra_priority = 150,
> +		.base.cra_blocksize = SHA512_BLOCK_SIZE,
> +		.base.cra_module = THIS_MODULE,
> +	},
> +	{
> +		.digestsize = SHA384_DIGEST_SIZE,
> +		.init = sha384_base_init,
> +		.update = riscv64_sha512_update,
> +		.final = riscv64_sha512_final,
> +		.finup = riscv64_sha512_finup,
> +		.descsize = sizeof(struct sha512_state),
> +		.base.cra_name = "sha384",
> +		.base.cra_driver_name = "sha384-riscv64-zvkb-zvknhb",
> +		.base.cra_priority = 150,
> +		.base.cra_blocksize = SHA384_BLOCK_SIZE,
> +		.base.cra_module = THIS_MODULE,
> +	}
> +};

*_algs instead of *_alg when there's more than one, please.
I.e., sha512_alg => sha512_algs here.

- Eric
