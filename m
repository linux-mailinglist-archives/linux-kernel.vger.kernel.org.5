Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECF7CE674
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjJRS32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJRS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:29:25 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB4118;
        Wed, 18 Oct 2023 11:29:23 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so8508082276.0;
        Wed, 18 Oct 2023 11:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653762; x=1698258562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHdbAm9LJTdw2SIGrMx1plxM0RiwW0DhdkjBzJkwfFA=;
        b=PlC7PNhuqTgaY+5ZYrAXt7rwFQA/4CjUDKLzGfGYfrfIy2z9aJDA8l7KEhAdP7e84W
         z0GsBMukfKapg1NxO27fH1zfSE842z7lu/iTV0Ft7/7ZJASV2Dw/BaJJR3/xWFHR9WJs
         hEQsRXPTsQAUA0WiPkNoEIomJbxP8fS5m5Cnpa6vDDVbjikiBraBeP+85mOHuWgIV5ry
         dh6+UfnFamw7BV4sNyQKUnSYc4dOe51cepKHKrc7kx0lKyNXKZEIUmyTTHrOg6U8z7oL
         T2xaZe34YITFVBFBpqNzaouIBoBPYubHxiyNtzXxPC8iUOKDIn0U/uc9+HvP78X8J/tC
         WkpA==
X-Gm-Message-State: AOJu0Yz7bA6boUC/HSkm320mcCIp4bTZJoL2UwC8Vf92YyQyHF+ZGXXa
        vxq5YjL1No9AI8atO6wG9R4oMQd4bLIAjQ==
X-Google-Smtp-Source: AGHT+IEykxip7+YerGSaTPoJDCfm3UCymuhPaFoKYFOY9ppICjYvn36xr9EVrEH6ARZVeaNCahg64w==
X-Received: by 2002:a25:9f8a:0:b0:d9a:c218:817c with SMTP id u10-20020a259f8a000000b00d9ac218817cmr164190ybq.4.1697653762541;
        Wed, 18 Oct 2023 11:29:22 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id v1-20020a258481000000b00d9a577d8434sm1456016ybk.53.2023.10.18.11.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:29:21 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7db1f864bso85298737b3.3;
        Wed, 18 Oct 2023 11:29:21 -0700 (PDT)
X-Received: by 2002:a0d:df44:0:b0:59b:ec85:54ee with SMTP id
 i65-20020a0ddf44000000b0059bec8554eemr81300ywe.39.1697653760779; Wed, 18 Oct
 2023 11:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231018182412.80291-1-hamza.mahfooz@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 20:29:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
Message-ID: <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Li Hua <hucool.lihua@huawei.com>,
        Alexander Potapenko <glider@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rae Moar <rmoar@google.com>, rust-for-linux@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hamza,

On Wed, Oct 18, 2023 at 8:24 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
> With every release of LLVM, both of these sanitizers eat up more and
> more of the stack. So, set FRAME_WARN to 0 if either of them is enabled
> for a given build.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Thanks for your patch!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -429,11 +429,10 @@ endif # DEBUG_INFO
>  config FRAME_WARN
>         int "Warn for stack frames larger than"
>         range 0 8192
> -       default 0 if KMSAN
> +       default 0 if KASAN || KCSAN || KMSAN

Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootable?
Stack overflows do cause crashes.

>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>         default 2048 if PARISC
>         default 1536 if (!64BIT && XTENSA)
> -       default 1280 if KASAN && !64BIT
>         default 1024 if !64BIT
>         default 2048 if 64BIT
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
