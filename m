Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D476BC7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHAS3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHAS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672426A6;
        Tue,  1 Aug 2023 11:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A893E61652;
        Tue,  1 Aug 2023 18:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA47C433C9;
        Tue,  1 Aug 2023 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690914528;
        bh=vgVYV9KtDNmY3fINh0LBn3d28Rjju1adTv5BCcegXgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7KpXyC7YsVn4bCy0g6OarEl0e/GJMlhFwf7pcfPe89AY/qHstW2sdi145peCS7ZO
         QwfiOyIc8FlBse+4LSJwgChDPTreeGOhjqemo+LRydMLqiMzcqfRaKnMJ6vExlKCKD
         JO0+p4kMKk5D0QSxF9BtLJanLaBsMjHW/94jQO5fgacPFvO1trl4cSD7+JsCdwjb2M
         OLwINtfc49eCX+sLR+SeVKwuKNnRp8ZLSBW3DE3E8hqfLT5knjk11BSV1NK/tS4FuN
         BLiyGW6TQr7pl83T+doEE9qlir/58n0S9DTAW6IDmvcVrHWTs+pN78THJJv49X0npb
         q/JWwN6P9HzoA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 21:28:42 +0300
Message-Id: <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Daniil Stas" <daniil.stas@posteo.net>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
X-Mailer: aerc 0.14.0
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
In-Reply-To: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 31, 2023 at 10:05 PM EEST, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 03:53, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > I quickly carved up a patch (attached), which is only compile tested
> > because I do not have any AMD hardware at hand.
>
> Is there some way to just see "this is a fTPM"?
>
> Because honestly, even if AMD is the one that has had stuttering
> issues, the bigger argument is that there is simply no _point_ in
> supporting randomness from a firmware source.
>
> There is no way anybody should believe that a firmware TPM generates
> better randomness than we do natively.
>
> And there are many reasons to _not_ believe it. The AMD problem is
> just the most user-visible one.
>
> Now, I'm not saying that a fTPM needs to be disabled in general - but
> I really feel like we should just do
>
>  static int tpm_add_hwrng(struct tpm_chip *chip)
>  {
>         if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>                 return 0;
>         // If it's not hardware, don't treat it as such
>         if (tpm_is_fTPM(chip))
>                 return 0;
>         [...]
>
> and be done with it.
>
> But hey, if we have no way to see that whole "this is firmware
> emulation", then just blocking AMD might be the only way.
>
>                Linus

I would disable it inside tpm_crb driver, which is the driver used
for fTPM's: they are identified by MSFT0101 ACPI identifier.

I think the right scope is still AMD because we don't have such
regressions with Intel fTPM.

I.e. I would move the helper I created inside tpm_crb driver, and
a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
sets before calling tpm_chip_register().

Finally, tpm_add_hwrng() needs the following invariant:

	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
		return 0;

How does this sound? I can refine this quickly from my first trial.

BR, Jarkko
