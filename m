Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24CA7FB0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjK1EMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1EMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:12:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7748E198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:12:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027DC433C8;
        Tue, 28 Nov 2023 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701144757;
        bh=8sgnTlTTe9L/d3q6KejWDFP12I9AsyGGo8/4VhNtpCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEWumhAEPzcP6ei2al6jYGIp3TiLr1CvuhBdMYtBFRd4npdj1hflBmoIui2KHuHiX
         rjCsWTYe/2Jf401q1YWW5Y9W3zJPFvHEB9Df4EdJqKUhUKQaPLg4mIu6mHj/1RH2Iw
         8pfKefIpVE+XyPCSE4GrYI2IudRAyPwoIkZhhSZM1h5F70Lwzdt1t333/2Z+mm6Pap
         HvrzKTSaaq9xkeRFrqC8+MW8TvOghwdacuvgAlkCG6NbwTI8fiE2fQ/x6RT4cLdVLj
         qdGAFrpVTW07QHGRmBOKB7Ml2unZzzZAV6K8crtdLfy/OsO+A6RjUXQjOvq38CFjRu
         HbbiG9Z+p8KJg==
Date:   Mon, 27 Nov 2023 20:12:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 09/13] RISC-V: crypto: add Zvknha/b accelerated
 SHA224/256 implementations
Message-ID: <20231128041235.GJ1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-10-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-10-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:59PM +0800, Jerry Shih wrote:
> +/*
> + * sha256 using zvkb and zvknha/b vector crypto extension
> + *
> + * This asm function will just take the first 256-bit as the sha256 state from
> + * the pointer to `struct sha256_state`.
> + */
> +asmlinkage void
> +sha256_block_data_order_zvkb_zvknha_or_zvknhb(struct sha256_state *digest,
> +					      const u8 *data, int num_blks);

The SHA-2 and SM3 assembly functions are potentially being called using indirect
calls, depending on whether the compiler optimizes out the indirect call that
exists in the code or not.  These assembly functions also are not defined using
SYM_TYPED_FUNC_START.  This is not compatible with Control Flow Integrity
(CONFIG_CFI_CLANG); these indirect calls might generate CFI failures.

I recommend using wrapper functions to avoid this issue, like what is done in
arch/arm64/crypto/sha2-ce-glue.c.

- Eric
