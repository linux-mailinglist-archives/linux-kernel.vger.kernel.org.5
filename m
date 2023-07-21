Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD975C9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGUOYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGUOYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69072359A;
        Fri, 21 Jul 2023 07:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C63CE61CD9;
        Fri, 21 Jul 2023 14:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEBEC43397;
        Fri, 21 Jul 2023 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949433;
        bh=5wGTb0drngr+Lzxv45DNkN6bYmApLSYYtgrk0pW7lkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fP3jpEn90tqFuB+suABWmOg8xE9Fr2vs92rBw9sjkmEkSX5LxGPAw0VABNgwvBseU
         aNeLsaOL0j96OQc1MVNO5vW1ZHr2f6Bz+n8o2Du3EaFcQqAc26E0FPo+h1JRhp4GbZ
         8Fd92e71MSXlwZYE43VWJD7p8zwgZVCZrnb9b+cj2NYdwyguQ7bl33sx1c7fQHmZnM
         zUpPt7/Dl+8jmWOHVNdHA+EXdvyi0G9BbG3K/AyzRK7pOcQSeuUadXPxmIl3xFpCNY
         DpphF7DthInWtK+EuXxEDC5Gkfns1jkeITvzfJPIubY4OyWaDXWtp5Bm98MkhOHL/q
         aQ73K8zHZzceg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a4062577c0so1989511b6e.0;
        Fri, 21 Jul 2023 07:23:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLYLxYp23h4BRmPRg0VouND3aWydKIOO4buXNmVxJGehGpHUP4bg
        3yCjZneeVO6KP5H29ufVZNv9bjE9sdDD3PTR8Bo=
X-Google-Smtp-Source: APBJJlHuD7qjQP5P8W7jgjwerNr7egFlBZQzzLp4UrYP8ot2cXJV0C5GpmgUm0g+J8owwW7uod6gXEHxuvI+aCg2S/w=
X-Received: by 2002:a05:6808:2191:b0:3a1:bced:9e83 with SMTP id
 be17-20020a056808219100b003a1bced9e83mr2400757oib.5.1689949432197; Fri, 21
 Jul 2023 07:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711153743.1970625-1-heiko@sntech.de> <20230711153743.1970625-11-heiko@sntech.de>
 <20230721054036.GD847@sol.localdomain> <CAMj1kXFqs9v1Ao1RQRXiccKEMhXpy9O=Ng8TQ--vdOkTz5Yc5Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFqs9v1Ao1RQRXiccKEMhXpy9O=Ng8TQ--vdOkTz5Yc5Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Jul 2023 16:23:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHWZH=pmp2oMYfgWDgDyThb0vmey-L4qYdcZDRZvWxJWw@mail.gmail.com>
Message-ID: <CAMj1kXHWZH=pmp2oMYfgWDgDyThb0vmey-L4qYdcZDRZvWxJWw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] RISC-V: crypto: add Zvkned accelerated AES
 encryption implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 13:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 21 Jul 2023 at 07:40, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jul 11, 2023 at 05:37:41PM +0200, Heiko Stuebner wrote:
> ...
> > > +static int riscv64_aes_setkey_zvkned(struct crypto_tfm *tfm, const u8 *key,
> > > +                      unsigned int keylen)
> > > +{
> > > +     struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
> > > +     int ret;
> > > +
> > > +     ctx->keylen = keylen;
> > > +
> > > +     if (keylen == 16 || keylen == 32) {
> > > +             kernel_rvv_begin();
> > > +             ret = rv64i_zvkned_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
> > > +             if (ret != 1) {
> > > +                     kernel_rvv_end();
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             ret = rv64i_zvkned_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
>
> The asm suggests that the encryption and decryption key schedules are
> the same, and the decryption algorithm does not implement the
> Equivalent Inverse Cipher, but simply iterates over they key schedule
> in reverse order. This makes much more sense for instruction based
> AES, so it doesn't surprise me but it does mean you can just drop this
> part, and pass enc_key everywhere.
>
> > > +             kernel_rvv_end();
> > > +             if (ret != 1)
> > > +                     return -EINVAL;
> > > +     }
> > > +
> > > +     ret = crypto_cipher_setkey(ctx->fallback, key, keylen);
> > > +
> > > +     return ret ? -EINVAL : 0;
> > > +}
> >
> > It's a bit annoying that RISC-V doesn't support AES-192, though also not
> > particularly surprising, seeing as AES-192 is almost never used.  (Intel's Key
> > Locker, for example, is another recent CPU feature that doesn't support
> > AES-192.)  IMO the issue here is really with the kernel crypto API -- it should
> > treat AES-128, AES-192, and AES-256 as separate algorithms so that
> > implementations aren't forced to support all three key sizes...
> >
>
> Why is this a fundamental limitation? AES-192 uses the same AES block
> size and round structure, the only difference is the number of rounds
> and how the round keys are calculated.
>
> Creating the key schedule should never be performance critical, so if
> the lack of AES-192 support is due to a limitation in the key schedule
> generation instructions, I'd suggest to avoid those if possible and
> just use the generic library code to derive the key schedule. If that
> works, I'm pretty sure AES-192 support is just a matter of
> implementing a 12-round variant modeled after the existing 10/14 round
> ones.

This seems to work:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=riscv-crypto

Feel free to incorporate/squash any of those changes into your series.
