Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C606772E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHGT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5F10F3;
        Mon,  7 Aug 2023 12:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7E56219A;
        Mon,  7 Aug 2023 19:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132A2C433C7;
        Mon,  7 Aug 2023 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691436367;
        bh=BdPikiB2yFG2j+Q4YJS6iU22Pe6ayh97qATiunEsT/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6WQdIfq43rcHJDtZMb47ooOPWTpix7vbSIBviGTTJHzf/Fv0PLmN/JNqgpsW4bUM
         eXHNwVZin1hK+oX6X5lxWWhm6O1rpIDppu33lc85pihQrIMwi5EZ2+3jZkglZbrsWg
         OP4wruFErQKKvHZZok/cE/JBJNm+TvUCFB4NyGYugDjJIFizmWL/rwb0wTNFB+83tQ
         oSggTuegjewmK9giwEIu2DPakffoJpVFyYp9PSVOzcBNeqJrw4XEStQ0m8IipzRrKk
         tzWtgocEuEfLRIQ9CwO/t/viECFKMXzKPwKq+PCTUYyblxxQaDATD6Eij9yb30kJNc
         Bi0na/GpySNFQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56cca35d8c3so2537758eaf.3;
        Mon, 07 Aug 2023 12:26:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5HRpK8NLp8qYPKEr255h6Uw/lJ8iqFBsXmFFJzGgE7lhADUXW
        mll6Xn02DCKxGh+BqzLLtQ2xl3uXxndAHefni6k=
X-Google-Smtp-Source: AGHT+IG4tKCJfSN28dcJqVvvvKXy/z6zCOH21EGl2MgdGxVIwpVKg6q6U8brXCc4bg5efPJRcrTfZkA2G6a8Bb4SsGQ=
X-Received: by 2002:a05:6870:9a16:b0:1b0:2686:5b23 with SMTP id
 fo22-20020a0568709a1600b001b026865b23mr8902270oab.51.1691436366226; Mon, 07
 Aug 2023 12:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230805095709.6717-1-yoann.congal@smile.fr>
In-Reply-To: <20230805095709.6717-1-yoann.congal@smile.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 04:25:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8a=8n9r7kQrLTPpKwqXG1d1sd0WjJ8PQhOXHXxnSyNQ@mail.gmail.com>
Message-ID: <CAK7LNAS8a=8n9r7kQrLTPpKwqXG1d1sd0WjJ8PQhOXHXxnSyNQ@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: avoid an infinite loop in oldconfig/syncconfig
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 6:57=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> Exit on error when asking for value that has an invalid default value
> and stdin has reached EOF. This happens in particular for hex/int
> configs without an explicit default value.
>
> Previously, this case would loop:
> * oldconfig prompts for the value but stdin has reached EOF
> * It gets the global default value : an empty string
> * This is not a valid hex/int value so it prompts again, hence the infini=
te loop.
>
> This case happens with a configuration like this (a hex config without a
> valid default value):
>   config TEST_KCONFIG
>        hex "Test KConfig"
>        # default 0x0
>
> And using:
>   make oldconfig < /dev/null
>
> This was discovered when working on Yocto bug[0] on a downstream
> kconfig user (U-boot)
>
> [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14136
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> v1->v2:
>  * Improve coding style
>  * Put more info in the commit message
>
>  scripts/kconfig/conf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 7cf63261d951c..8f32cbbce4805 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -377,8 +377,16 @@ static int conf_string(struct menu *menu)
>                         line[strlen(line)-1] =3D 0;
>                         def =3D line;
>                 }
> -               if (def && sym_set_string_value(sym, def))
> +               if (def && sym_set_string_value(sym, def)) {
>                         return 0;
> +               } else {
> +                       if (feof(stdin) && !sym_string_valid(sym, sym_get=
_string_value(sym))) {
> +                               fprintf(stderr,
> +                                       "Symbol %s has invalid default va=
lue and stdin reached EOF\n",
> +                                       sym->name);
> +                               exit(1);
> +                       }
> +               }
>         }
>  }
>
> --
> 2.30.2
>


It is strange (and consistent) to bail out
only for particular types.


I would change the code simply as follows:



--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -76,8 +76,10 @@ static void strip(char *str)
 /* Helper function to facilitate fgets() by Jean Sacren. */
 static void xfgets(char *str, int size, FILE *in)
 {
-       if (!fgets(str, size, in))
+       if (!fgets(str, size, in)) {
                fprintf(stderr, "\nError in reading or end of file.\n");
+               exit(1);
+       }

        if (!tty_stdio)
                printf("%s", str);






yes "" | make config

will succeed.



make config < /dev/null

will fail.





People expecting the closed stdin to succeed
may start complaining, but I believe
they must fix their wrong scripts.


--=20
Best Regards
Masahiro Yamada
