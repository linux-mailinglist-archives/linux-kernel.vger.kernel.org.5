Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD676A4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGaX2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGaX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:28:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02801194
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:28:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so791110966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=ZekSgBZkAavLHGGah0w31PCLHlAqS/S9ypHQf2oGzr6j+sNI2t9uQ/p9xkhUBiSnXM
         WgV/J3qKPl0g/CG0GqD/ITJtAYWXtykxHf6PJhd6gKD4vdcSQC0yFuOrPFUoIv2P1NXP
         wU7sML2VwwbarztWTEem8URdK5+0BOJKp7y0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=jL1EC705i9VFLKXIbBTUZ9DrB2ADxh5LQFXta4R7ZARvqBws1qhAuo0K/ezPz0zwXJ
         5m5/PURhMlh0WufJxqr+805mlwVcHNxGvIWQJCMM+mYpMlfbOuIegjZ9Qkr0mURfEfxj
         NBHt2Fxlit/JunIs7i1eZa/JGSS6Wxj8GZ5JUSmK2+bkfre0+TwWvAqA6DGVUWRYkjY9
         S3Lv7XpVqck9tGQW03jEjkjBp5H0IkHCMuQSRIl9gy8k2Yj2rHNmXlCKeaboFgUajcoD
         DDUaYzf6sL5UqRkUQREGPnJ849J8nbZ/GaiSFdacyMhGMnAlARPaNJpcS2olBiozJY0H
         5fzQ==
X-Gm-Message-State: ABy/qLYkstFTY1ZSS7hnjRoCEZY3Mcdzn2cdTuT30WNBJ3ADBzWBYBuc
        R8ygQgMSgMXaQkTdqR9e2/hBK/WV8OUvViK1XI1cQzK1
X-Google-Smtp-Source: APBJJlFkUY3MPB4JE8eYQ4mbXfixatIUl6d964+dUGuOr2ufCo0CyFJMrKMssOMe3InZTyDnziCRFw==
X-Received: by 2002:a17:907:2be2:b0:993:fba5:cdf1 with SMTP id gv34-20020a1709072be200b00993fba5cdf1mr880668ejc.22.1690846112324;
        Mon, 31 Jul 2023 16:28:32 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906564500b00992e4d8cc89sm6814238ejr.57.2023.07.31.16.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso32350345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
X-Received: by 2002:adf:f9cf:0:b0:316:ff0e:81b6 with SMTP id
 w15-20020adff9cf000000b00316ff0e81b6mr941858wrr.32.1690846110462; Mon, 31 Jul
 2023 16:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com> <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
In-Reply-To: <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 16:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux@dominikbrodowski.net, Jarkko Sakkinen <jarkko@kernel.org>,
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

On Mon, 31 Jul 2023 at 14:57, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> Are you thinking then to unregister the tpm hwrng "sometime" after boot?

No, I was more thinking that instead of registering it as a randomness
source, you'd just do a one-time

    tpm_get_random(..);
    add_hwgenerator_randomness(..);

and leave it at that.

Even if there is some stutter due to some crazy firmware
implementation for reading the random data, at boot time nobody will
notice it.

           Linus
