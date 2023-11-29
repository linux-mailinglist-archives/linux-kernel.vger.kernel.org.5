Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853EA7FE0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjK2UQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjK2UQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E9510C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:16:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55CCC433CC;
        Wed, 29 Nov 2023 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701288963;
        bh=eJQhkQLzUwwUMvhzdNW9MAj6eRgcFa4pmRj/Q9yI5aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A58xGnKFd8gNAc7MIbjqM3wnqSqhoDtxaRuCpIVWNjwFgXMRCDGM6O7s/U+F7yyFy
         uFtlTSLv9XqLau5R0N9MPb/ciOx7gW1x9MGpmJazMX1Uc6uKlXrO3RbmCAX5n780PR
         2eUFCyvP5Gzh8aThoQCLxK17xsQ8ddepch5wHQknLNhxoScaDKqgycFUV+18HhEWdO
         ol489AUDXcxReKqC385IxnEAJZYsSKqGMRg0QmBKI3IptwV7XtJAvbsmrYxQkRsmD3
         9y+DxI8Y04LoX9ALLe4ASJVkwTY8rfE0CI5Eap7J80HzqBpHxNXGWkB5u+TQkO4C8p
         IsiMIOv1l6fsQ==
Date:   Wed, 29 Nov 2023 12:16:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 07/13] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231129201601.GA1174@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-8-jerry.shih@sifive.com>
 <20231128040716.GI1463@sol.localdomain>
 <7DFBB20D-B8D4-409B-8562-4C60E67FD279@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DFBB20D-B8D4-409B-8562-4C60E67FD279@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:57:25PM +0800, Jerry Shih wrote:
> On Nov 28, 2023, at 12:07, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Mon, Nov 27, 2023 at 03:06:57PM +0800, Jerry Shih wrote:
> >> +typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
> >> +			     const struct crypto_aes_ctx *key, u8 *iv,
> >> +			     int update_iv);
> > 
> > There's no need for this indirection, because the function pointer can only have
> > one value.
> > 
> > Note also that when Control Flow Integrity is enabled, assembly functions can
> > only be called indirectly when they use SYM_TYPED_FUNC_START.  That's another
> > reason to avoid indirect calls that aren't actually necessary.
> 
> We have two function pointers for encryption and decryption.
> 	static int xts_encrypt(struct skcipher_request *req)
> 	{
> 		return xts_crypt(req, rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt);
> 	}
> 
> 	static int xts_decrypt(struct skcipher_request *req)
> 	{
> 		return xts_crypt(req, rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt);
> 	}
> The enc and dec path could be folded together into `xts_crypt()`, but we will have
> additional branches for enc/decryption path if we don't want to have the indirect calls.
> Use `SYM_TYPED_FUNC_START` in asm might be better.
> 

Right.  Normal branches are still more efficient and straightforward than
indirect calls, though, and they don't need any special considerations for CFI.
So I'd just add a 'bool encrypt' or 'bool decrypt' argument to xts_crypt(), and
make xts_crypt() call the appropriate assembly function based on that.

> > Did you consider writing xts_crypt() the way that arm64 and x86 do it?  The
> > above seems to reinvent sort of the same thing from first principles.  I'm
> > wondering if you should just copy the existing approach for now.  Then there
> > would be no need to add the scatterwalk_next() function, and also the handling
> > of inputs that don't need ciphertext stealing would be a bit more streamlined.
> 
> I will check the arm and x86's implementations.
> But the `scatterwalk_next()` proposed in this series does the same thing as the
> call `scatterwalk_ffwd()` in arm and x86's implementations.
> The scatterwalk_ffwd() iterates from the beginning of scatterlist(O(n)), but the 
> scatterwalk_next() is just iterates from the end point of the last used
> scatterlist(O(1)).

Sure, but your scatterwalk_next() only matters when there are multiple
scatterlist entries and the AES-XTS message length isn't a multiple of the AES
block size.  That's not an important case, so there's little need to
micro-optimize it.  The case that actually matters for AES-XTS is a single-entry
scatterlist containing a whole number of AES blocks.

- Eric
