Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F176A14B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGaTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGaTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:31:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AEC19A2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so2025437e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=g3DHojZdzR4AtFnafLgXcdiYZhs/PUZV9eFNZwj2qDJmppmTMxtgdctVcFk+XYdSuS
         39bdNJZN0ISfpf9OF29Z1NG1w9zDF+12g/Jy+AmtYLP6t2W/nrETrFfc5sCh9LEB9O2W
         fWSPBg1/18olsNfxyLiexST/xgjfElDpEJEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=YRwwax2bojrvveJJz96ctll6kD9cVT4WBld9qMpTET9KfV9ZVAn3Vysx6gW4GY5DXy
         KvuYsKkpnQL/4Y9XqaW91PefB8QV101DKWe6ar/GKYibb0gSomZN+eU4YQ/rd1JLnvWO
         KSU4lOpvBk/aEC9DifBm4YYWYFohxniRY8HRxWSNJFktSPW7n9CpTIMfr73IKPK7u0Vf
         rksZDXCIvwiPtgkFAd7EKYmyKqsQN/GSBDniO0CouG0H2GgzpRRXMWAEbUqcClfLyI+C
         xOhjTibVRGLtAUZS0pd+1+HATqNmqgaIO9IBSzoV/TKnX1WOTzMmOtq20AJkmpuDlCNc
         U5gA==
X-Gm-Message-State: ABy/qLZvCQxxAvSkYN706kJAM0r5+J3+9HGUqdts3eYf4MPVnwMvcGXk
        2bpE7UCr5CWrtBUWogoB+SSePuEkIvvgSU4lGDLLVi37
X-Google-Smtp-Source: APBJJlF3+xPYoUhqjg/oipQBZDpDBT479KikQQ1tpgmt6hV5Pf6BC1+Y+A2+y+svb0+bLo7w5+XDsw==
X-Received: by 2002:a19:6703:0:b0:4fd:fabf:b923 with SMTP id b3-20020a196703000000b004fdfabfb923mr550682lfc.14.1690831874468;
        Mon, 31 Jul 2023 12:31:14 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25a19000000b004fe061269edsm2183608lfn.249.2023.07.31.12.31.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so2025391e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
X-Received: by 2002:ac2:5931:0:b0:4fb:92df:a27b with SMTP id
 v17-20020ac25931000000b004fb92dfa27bmr523833lfi.39.1690831873036; Mon, 31 Jul
 2023 12:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
In-Reply-To: <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:30:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:18, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> > Is there some way to just see "this is a fTPM"?
>
> How many fTPM implementations are there?  We're talking like less than 5
> right?  Maybe just check against a static list when
> calling tpm_add_hwrng().

Sounds sane. But I was hoping for some direct way to just query "are
you a firmware SMI hook, or real hardware".

It would be lovely to avoid the list, because maybe AMD does - or in
the past have done - discrete TPM hardware?  So it might not be as
easy as just checking against the manufacturer..

That said, maybe it really doesn't matter. I'm perfectly fine with
just the "check for AMD as a manufacturer" too.

In fact, I'd be perfectly happy with not using the TPM for run-time
randomness at all, and purely doing it for the bootup entropy, which
is where I feel it matters a lot m ore.

> I've had some discussions today with a variety of people on this problem
> and there is no advantage to get RNG through the fTPM over RDRAND.

Ack.

And that's true even if you _trust_ the fTPM.

That said, I see no real downside to using the TPM (whether firmware
or discrete) to just add to the boot-time "we'll gather entropy for
our random number generator from any source".

So it's purely the runtime randomness where I feel that the upside
just isn't there, and the downsides are real.

                  Linus
