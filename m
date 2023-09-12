Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B579C845
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjILHhC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjILHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:37:01 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F31B9;
        Tue, 12 Sep 2023 00:36:57 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so4600745276.1;
        Tue, 12 Sep 2023 00:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504216; x=1695109016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQkTxWFhHruinciBZiWA46A9JASfXDRadwS/Z78n1r8=;
        b=M+QXlgtQa9r2KzEDMBvEKcOldkQRyayuMvrEe20asybBnbdpLo9ab8fDx+f0xRVvpq
         EFxupFV5JHlnIsTO0DSca8z/Eri2oGuwths6YSX2CP+EIcoJsY03Nk0YVYga8uTq7cs8
         /y+rI2rjgYKjDc/4/Kprv8yAkJkRkL069DItzsaY1D3sSoSqAqmbkm+oGFrqx55AgesJ
         AYpWkPZsrsWDek6/0BedCIsc96WQGiL5uU3W9DUdQJOLOQhOoZHWA3GLXM5ekaaRQkv7
         n49+f2czAtKC8rOPeeCXX96T8G7AOPWzYzH3rkq0/5tn2RW6jXsSXvGeADo/yFJruagg
         uGyA==
X-Gm-Message-State: AOJu0Yw3/op7i1ACE/A2opVSOOKkuFbBff0hlTIgtZmDD78JbQBPVXJW
        9u9aoOIkvyG5y56zWMb0CtRD+z5jCznQ3w==
X-Google-Smtp-Source: AGHT+IGDyNlNPBpvd2TSHtsj7QQ/kz/IeFnM7ukX/0JRnvicBzoDqu4JpjqywBnS9dC1vAw4TzJzJg==
X-Received: by 2002:a25:ad04:0:b0:d54:b34c:1c7b with SMTP id y4-20020a25ad04000000b00d54b34c1c7bmr9734564ybi.59.1694504216329;
        Tue, 12 Sep 2023 00:36:56 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v13-20020a25ab8d000000b00d7360e0b240sm2088530ybi.31.2023.09.12.00.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:36:55 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso4596637276.2;
        Tue, 12 Sep 2023 00:36:55 -0700 (PDT)
X-Received: by 2002:a25:2d08:0:b0:d7a:d018:5a37 with SMTP id
 t8-20020a252d08000000b00d7ad0185a37mr11515001ybt.39.1694504214921; Tue, 12
 Sep 2023 00:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
In-Reply-To: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 09:36:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
Message-ID: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
To:     Justin Stitt <justinstitt@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Thanks for your patch!

On Mon, Sep 11, 2023 at 7:53 PM Justin Stitt <justinstitt@google.com> wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>
> `gate_buf` should always be NUL-terminated and does not require
> NUL-padding. It is used as a string arg inside an argv array given to

Can you please explain why it does not require NUL-padding?
It looks like this buffer is passed eventually to a user space
application, thus possibly leaking uninitialized stack data.

> `run_helper()`. Due to this, let's use `strscpy` as it guarantees
> NUL-terminated on the destination buffer preventing potential buffer
> overreads [2].
>
> This exact invocation was changed from `strcpy` to `strncpy` in commit
> 7879b1d94badb ("um,ethertap: use strncpy") back in 2015. Let's continue
> hardening our `str*cpy` apis and use the newer and safer `strscpy`!
>
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
> index 9483021d86dd..3363851a4ae8 100644
> --- a/arch/um/os-Linux/drivers/ethertap_user.c
> +++ b/arch/um/os-Linux/drivers/ethertap_user.c
> @@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
>         sprintf(data_fd_buf, "%d", data_remote);
>         sprintf(version_buf, "%d", UML_NET_VERSION);
>         if (gate != NULL) {
> -               strncpy(gate_buf, gate, 15);
> +               strscpy(gate_buf, gate, sizeof(gate_buf));
>                 args = setup_args;
>         }
>         else args = nosetup_args;
>
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-859160d13f59

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
