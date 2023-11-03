Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C447E040C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377652AbjKCNyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:54:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124DB7;
        Fri,  3 Nov 2023 06:54:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51247C433C8;
        Fri,  3 Nov 2023 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699019655;
        bh=0DrGIEuc8DuRW/qdldr4ZRCrpYEyWsuudVO69m+wDSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VYVFcCtmyNbRYk9Rnl9YHTe3Re+A4PMEw1GmtlVryAy5+AKq6RCYYsKPNDSBQDbJI
         OiKth7Zj9H6sKykuMz4iXUOIG338O5cn60GkMlfyv5e1hTBR4H0ungXrv01DuXZdPh
         t0y4WoFaO3Y1qxiN1Sk0lLdUot868m4XgbPrj2hYVKgfErXJUyFzsNTsvK0wZxciUX
         Y/gm8IUFUqY7A5iqbf0mR6t1lgV8vQF5nHJaHq0J2WcXQjViUnOeUd2AvcckxlLAny
         4UgFnbsmAIanQviu5z1sSnKdwl8w1vH2sMc/Je9hARiMN22Gwjn/eql29AywAPLlQP
         cBR5U2bcFj07g==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ce2c5b2154so1224570a34.3;
        Fri, 03 Nov 2023 06:54:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz54a4MM8udBepc2qmIcD4iTWOoeJfleNwLxSIApVA1+h9FHSPX
        RHBmd7dljrXga4pmlAewJtgTZoX3+G2xDP2kkVk=
X-Google-Smtp-Source: AGHT+IEMMMTZTSolnE0bkToCkGoq31vCtq1uaBVbXZyI7uS17JLgXUmvO5AejF+HBZX4OEy1OdZH+TNAQ8ORf0wxIRo=
X-Received: by 2002:a05:6871:5385:b0:1ea:478c:a26b with SMTP id
 hy5-20020a056871538500b001ea478ca26bmr30846048oac.9.1699019654718; Fri, 03
 Nov 2023 06:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231031111647.111093-1-yoann.congal@smile.fr>
In-Reply-To: <20231031111647.111093-1-yoann.congal@smile.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 3 Nov 2023 22:53:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATaX5S1MwmJ4EGd7YGf3pJ0tEUABcJX6stSxHUsB0ca6w@mail.gmail.com>
Message-ID: <CAK7LNATaX5S1MwmJ4EGd7YGf3pJ0tEUABcJX6stSxHUsB0ca6w@mail.gmail.com>
Subject: Re: [PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Brandon Maier <brandon.maier@collins.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:17=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
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
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Tested-by: Brandon Maier <brandon.maier@collins.com>
> ---
> v3->v4:
>  * Added Brandon Maier's "Tested-by". Thanks!
> v2->v3:
>  * Simplify the patch by fusing comments of :
>    * Masahiro Yamada : Exit as soon as reading stdin hits an error
>    * Randy Dunlap : Display the name of the currently read symbol
> v1->v2:
>  * Improve coding style
>  * Put more info in the commit message
>
>  scripts/kconfig/conf.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 33d19e419908..68f0c649a805 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -74,13 +74,17 @@ static void strip(char *str)
>  }
>
>  /* Helper function to facilitate fgets() by Jean Sacren. */
> -static void xfgets(char *str, int size, FILE *in)
> +static int xfgets(char *str, int size, FILE *in)
>  {
> +       int ret =3D 0;
> +
>         if (!fgets(str, size, in))
> -               fprintf(stderr, "\nError in reading or end of file.\n");
> +               ret =3D -1;
>
>         if (!tty_stdio)
>                 printf("%s", str);
> +
> +       return ret;
>  }



This is not what I suggested.


I suggested much simpler code:

https://lore.kernel.org/linux-kbuild/CAK7LNAS8a=3D8n9r7kQrLTPpKwqXG1d1sd0Wj=
J8PQhOXHXxnSyNQ@mail.gmail.com/


It is easy to know the symbol name that is causing the issue;
it was shown in the prompt just before the failure.



Also, please note that the 'x' prefix is often used
for functions that do not require error check.
(e.g. xmalloc)









>
>  static void set_randconfig_seed(void)
> @@ -339,7 +343,10 @@ static int conf_askvalue(struct symbol *sym, const c=
har *def)
>                 /* fall through */
>         default:
>                 fflush(stdout);
> -               xfgets(line, sizeof(line), stdin);
> +               if (xfgets(line, sizeof(line), stdin) !=3D 0) {
> +                       fprintf(stderr, "Error while reading value of sym=
bol \"%s\"\n", sym->name);
> +                       exit(1);
> +               }
>                 break;
>         }
>
> @@ -521,7 +528,11 @@ static int conf_choice(struct menu *menu)
>                         /* fall through */
>                 case oldaskconfig:
>                         fflush(stdout);
> -                       xfgets(line, sizeof(line), stdin);
> +                       if (xfgets(line, sizeof(line), stdin) !=3D 0) {
> +                               fprintf(stderr, "Error while reading valu=
e of symbol \"%s\"\n",
> +                                               sym->name);
> +                               exit(1);
> +                       }
>                         strip(line);
>                         if (line[0] =3D=3D '?') {
>                                 print_help(menu);
> --
> 2.30.2
>


--=20
Best Regards
Masahiro Yamada
