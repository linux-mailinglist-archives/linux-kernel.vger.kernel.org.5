Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010A3755C62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGQHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C5F0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F82560F79
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A763C433C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689577566;
        bh=3YLD3BsG7+2BO+Oev/NAb7pEjim2De5t1WFLv9RTA44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nrEQK7fi3R4GzM5GHZI8YXS7G5FO1CCPpvmFEqSqOz8kQFWaXNvyOlYTEccjoemGG
         ammI5MWhoMapAt8lksC86E7yeNzhBm7U6bheeUEyv5C9/xp8JXXu10mopUHaWKO/nv
         cyX9nhQJ6FIu7QbDx0boDtDA773RpUj2o6+N8xYPaLtdyjPGTzqK6XgpmSzjJt3ShQ
         Oz66gDJnqPIdRV5VMRKwdvQAW0giEqaguiBvZRGS+HRY5q3a4o2fHQSqbx0PRc21Im
         4pUOkcURTMMBQpTFDLQTJu1jdeZLFb+hwxaIEndeJF4nDauZcWrP44jefBVT2Q64Dg
         UmyOnQFWGc3Jw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so5954569a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:06:06 -0700 (PDT)
X-Gm-Message-State: ABy/qLZeNseY0OKTa9O9G+1hmzTUJy4W+nUj8UbVLsFDNBkUTn2fJ0L1
        URX3HNHwFfV58HQ8Yf6iuvlf1np5kS/Bb24S/Hg=
X-Google-Smtp-Source: APBJJlG5LKwPyz5qfh4I31r5cP/uFn3PkgEOKigeITITs9bLV0/hTJLSWT1UgkScu8NqHpduwoMXAmqfIumAK1DOV18=
X-Received: by 2002:a50:ec87:0:b0:51d:98d1:5337 with SMTP id
 e7-20020a50ec87000000b0051d98d15337mr10408759edr.37.1689577564764; Mon, 17
 Jul 2023 00:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB259720FF3C1683A75881EF02D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB259720FF3C1683A75881EF02D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Jul 2023 15:05:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6dn9iRxaGGoD+=7YHiDEmt_Be4_v8d1oY7+dmhrJBUMw@mail.gmail.com>
Message-ID: <CAAhV-H6dn9iRxaGGoD+=7YHiDEmt_Be4_v8d1oY7+dmhrJBUMw@mail.gmail.com>
Subject: Re: [PATCH v4] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
To:     Dong Zhihong <donmor3000@hotmail.com>
Cc:     kernel@xen0n.name, ardb@kernel.org, tangyouling@loongson.cn,
        zhoubinbin@loongson.cn, yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 2:51=E2=80=AFPM Dong Zhihong <donmor3000@hotmail.co=
m> wrote:
>
> Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and
> CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
> There's already code handling CONFIG_CMDLINE_FORCE, which replaces
> `boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd b=
e
> similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER=
,
> so some code is added after OF_FLATTREE part to handle them.
>
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>
> v4 -> v3: Make CONFIG_CMDLINE appended to the end of command line (Huacai=
);
>         Removed unnecessary #ifdef since CONFIG_CMDLINE is always a strin=
g on
>         LoongArch
>         Reworded comments
>         Reworded the subject of commit message (Huacai)
> v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao=
)
> v2 -> v1: Reworded the commit message so it's more imperative (Markus);
>         Added `goto out` to FDT part (Huacai)
>
>  arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 78a00359bde3..a98f33553acf 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -332,9 +332,26 @@ static void __init bootcmdline_init(char **cmdline_p=
)
>                         strlcat(boot_command_line, " ", COMMAND_LINE_SIZE=
);
>
>                 strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
> +               goto out;
>         }
>  #endif
>
> +       /*
> +        * Append built-in command to the retrieved one if
> +        * CONFIG_CMDLINE_EXTEND is enabled.
> +        */
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
Don't need to check CONFIG_CMDLINE[0], this simplifies the conditions.

> +               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +               goto out;
Remove this line and in the next line using the old method
(IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0]) is
better.

Huacai
> +       }
> +
> +       /*
> +        * Use built-in command line if nothing is retrieved from boot lo=
ader.
> +        */
> +       if (!boot_command_line[0])
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +
>  out:
>         *cmdline_p =3D boot_command_line;
>  }
> --
> 2.25.1
>
