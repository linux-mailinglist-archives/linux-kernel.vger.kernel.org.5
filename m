Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C07BC040
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjJFUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJFUW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:22:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB15C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:22:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af5fcb5e37so1687317b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623777; x=1697228577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=SQAOm7mxJwp8A70M7SmHvhOVbjNCbVpWxfmgyc8x8MGl2URWXQYazZH/vDNR3cBh0Y
         jB9zlJi4doGVus4mdCPj/vA4YyEsrhC4fzLf7ylNa/e0HXTRhyd2DfqkZ8jnwEsqwXHJ
         QlEhlu4jObvUqBwnIkAaguUJRH3jRx3UmaQL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623777; x=1697228577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=dCEyoRT/m7H+nPb9L+nAtKCeHT6wsl3luQBGoOVo2k2D8o91ZBBc8rJ+GmRj3NZ51U
         OorvGDwx/Khtgni/SUfpnO0lKan5R/ATbL59mYISzoLdKT5jKkyUqkfMncygO0N1/aCv
         NarZoKJ4Uuo+c85mNT2v+XqV7ML69GUo9i8Ll4TW1DA8rw1RRZuRE2PZtpkwXOrW5p4W
         Y0usUOEAmgeU4uetsdNa7vhZ5VZrivlD52ShgreYxt2fRmFtjh3adYruK0lYJK41e6D5
         hVcdBceM0IyZ+pYFIFx6d8tszK1DxXS49O3aelmiQvYgAIxZDra15oS78DZ5XO8UQ+kv
         uAbQ==
X-Gm-Message-State: AOJu0YywQ+cbYf01Ir4AbyZHFw8e43iBvu2qfrH+7YiQJQ3y/LgjG1+/
        6G38dnZ6UB9K82pnXBQDrFEDsg==
X-Google-Smtp-Source: AGHT+IFJgYFdXQLoiEQmx+lFHyuC0qUrDFQKLIKGfw/wrLmvAN6GJdpM5ZD/9ihDG8TtTiEFnZjYhg==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id o17-20020a056358969100b0016487420525mr1346056rwa.17.1696623777190;
        Fri, 06 Oct 2023 13:22:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b00273744e6eccsm4271576pjk.12.2023.10.06.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:22:56 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:22:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <202310061321.E7247C52B@keescook>
References: <20230922175050.work.819-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.

Friendly ping. Mark, can you pick this up please?

Thanks!

-Kees

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Martin Povišer" <povik+lin@cutebit.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: asahi@lists.linux.dev
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  sound/soc/apple/mca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
> index ce77934f3eef..99e547ef95e6 100644
> --- a/sound/soc/apple/mca.c
> +++ b/sound/soc/apple/mca.c
> @@ -161,7 +161,7 @@ struct mca_data {
>  	struct mutex port_mutex;
>  
>  	int nclusters;
> -	struct mca_cluster clusters[];
> +	struct mca_cluster clusters[] __counted_by(nclusters);
>  };
>  
>  static void mca_modify(struct mca_cluster *cl, int regoffset, u32 mask, u32 val)
> -- 
> 2.34.1
> 

-- 
Kees Cook
