Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25CC7E127F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjKEH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFAC6;
        Sun,  5 Nov 2023 00:56:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567B9C433C9;
        Sun,  5 Nov 2023 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699170995;
        bh=NO/6VdsZWes1wh0lm2MDJmpIOUg5lGll4DVhzAMddw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iydKVa66n3x+i4cKBtqK7tlzbvc9FWDknuBvmYjrV725HFdFBwLym4O0pUEwfKeoa
         eQWl2FF6cJ7Nihjpe0Yp2IfEkbjQctJG/mn1TNw6HFcSrShNhG7EmR8rRNGSFRc5AY
         hxIpWOHJE2DWwoUA2nYlXUXojeebu3IBrmuIrFm1aOKpvnD8jg8nNINZO9YmfqdG1o
         vDzaCzdQUYGuiR7wZA9ZPOnHsZMlAv/y3uk41nH5R2ty/84Kxtdp3WzYGQ9BQLMQS7
         09t07kj7h4OZBbUXNr8YqFUl+J1IEsktj4uWmzbRfer7Q2LRSaghwthfHzZ0screD5
         o7sjvjVcF7fVw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-586beb5e6a7so1972841eaf.1;
        Sun, 05 Nov 2023 00:56:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YymA60Nug0TQb8Z6TWDhDhViaujL2/zzpNsiIZN52y6WbR/tWFg
        H/xrW4duAxFd13A0ozpxpE+ba4jC3oQvfUOUoww=
X-Google-Smtp-Source: AGHT+IG++9w87RY1dHHpcvCO4X5pGEIM/ClsT6lUOhVDmldwQaBW6YTc58HDJV1lCRaLItSzC8q0pPjFcajMmPtMook=
X-Received: by 2002:a05:6870:80ce:b0:1ef:b5e9:a4ef with SMTP id
 r14-20020a05687080ce00b001efb5e9a4efmr24255511oab.55.1699170994705; Sun, 05
 Nov 2023 00:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231104222715.3967791-1-yoann.congal@smile.fr>
In-Reply-To: <20231104222715.3967791-1-yoann.congal@smile.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Nov 2023 16:55:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com>
Message-ID: <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com>
Subject: Re: [PATCH v5] kconfig: avoid an infinite loop in oldconfig/syncconfig
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Brandon Maier <brandon.maier@collins.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 7:27=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> Exit on error when asking for value and reading stdin returns an error
> (mainly if it has reached EOF or is closed).
>
> This infinite loop happens in particular for hex/int configs without an
> explicit default value.
>
> Previously, this case would loop:
> * oldconfig prompts for the value but stdin has reached EOF
> * It gets the global default value : an empty string
> * This is not a valid hex/int value so it prompts again, hence the
>   infinite loop.
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
> CC: Brandon Maier <brandon.maier@collins.com>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Applied to linux-kbuild.
Thanks.


> ---
> v4->v5:
>  * Switched to Masahiro Yamada's suggested code.
> v3->v4:
>  * Added Brandon Maier's "Tested-by". Thanks!
> v2->v3:
>  * Simplify the patch by fusing comments of :
>    * Masahiro Yamada : Exit as soon as reading stdin hits an error
>    * Randy Dunlap : Display the name of the currently read symbol
> v1->v2:
>  * Improve coding style
>  * Put more info in the commit message
> ---
>  scripts/kconfig/conf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 33d19e419908..62de1fbaff97 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -76,8 +76,10 @@ static void strip(char *str)
>  /* Helper function to facilitate fgets() by Jean Sacren. */
>  static void xfgets(char *str, int size, FILE *in)
>  {
> -       if (!fgets(str, size, in))
> +       if (!fgets(str, size, in)) {
>                 fprintf(stderr, "\nError in reading or end of file.\n");
> +               exit(1);
> +       }
>
>         if (!tty_stdio)
>                 printf("%s", str);
> --
> 2.30.2
>


--=20
Best Regards
Masahiro Yamada
