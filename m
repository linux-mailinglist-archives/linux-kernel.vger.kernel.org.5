Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F27FC50F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjK1UMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346011AbjK1UM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:12:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A01BE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:12:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BBC433C7;
        Tue, 28 Nov 2023 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701202351;
        bh=MhX9PEGZOUPQ3Y/dHE9lpPPcT4wCLCEPYr8D6D5VCtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2oSykRN0FvNVERNHm6/mDH1mmOkc0Q49tLDgd40gyaDip6gEW7TAl9Jl/MxHObYA
         mdl/hcepl0h4CXURQz3Tn8VcDCpPQ0NXOnPu68SuNYjvg/HQgzZ8g4KrNzM5TZPDbJ
         vDC1pzxUpGiHmYxfU45duhcvVDLjsmwei0St+4UE1NUI6IMhUgdA8mzeRXuH+mLU4q
         a9yc1zaSWu/cJYpBKDvcaynYd9nSzkV4ILJkE9pokYSgNviVD9rofuNx9vfvhXXoO0
         vs/iR/aqK59xYP/4AVrqBmBlKYcCuz41pVbRh1aFxjKBpXasnU4aR8ZDjcQrf4mS9b
         /NZ1g23uTLU3w==
Date:   Tue, 28 Nov 2023 12:12:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jerry Shih <jerry.shih@sifive.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, ardb@kernel.org, heiko@sntech.de,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
Message-ID: <20231128201228.GE1148@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
 <20231128-await-tipper-2094715466f2@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-await-tipper-2094715466f2@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:54:49PM +0000, Conor Dooley wrote:
> > +static inline bool check_aes_ext(void)
> > +{
> > +	return riscv_isa_extension_available(NULL, ZVKNED) &&
> > +	       riscv_vector_vlen() >= 128;
> > +}
> 
> I'm not keen on this construct, where you are checking vlen greater than
> 128 and the presence of Zvkned without checking for the presence of V
> itself. Can you use "has_vector()" in any places where you depend on the
> presence of vector please?

Shouldn't both of those things imply vector support already?

> Also, there are potentially a lot of places in this drivers where you
> can replace "riscv_isa_extension_available()" with
> "riscv_has_extension_likely()". The latter is optimised with
> alternatives, so in places that are going to be evaluated frequently it
> may be beneficial for you.

These extension checks are only executed in module_init functions, so they're
not performance critical.

- Eric
