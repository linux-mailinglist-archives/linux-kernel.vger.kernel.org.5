Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73AB802269
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjLCKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8677ED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:07:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FDC433C9;
        Sun,  3 Dec 2023 10:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701598028;
        bh=7BvagETPLOix4NZJGPMgGHQ00+Cx1wfrbU+gxVCoLqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDtCeCGNBSoHgmBVyojOE5XCsFsYcPSimYxvTVLQcGIfi26IynwxScWRV18soTVDf
         4gruKen6Jy1wg1Yc8KRaNkmBlgpRTv4uOrx/auQYLQPcYgEbP8T6tHMoeGXDhFnhIR
         oj0i/ru6OV4Npd8p1jpbXFIZaZcxGB3sALMHTj9qvShJWgeh+r8uxuxGijOljB2iae
         I347eMlHM9jDVfDxTq+UKjZo6VpFGBa2ryUAKo7jcSEHgicUv21zkcyKX3I4raaxla
         e/SMMGvWBtTt3xzN5MHQGkvpCI0MEabz4p+VN0IbWivwHbrUEcVJUkLh3r24+wpBHU
         uU8bJhp3q85dw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f055438492so1856622fac.3;
        Sun, 03 Dec 2023 02:07:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yxc73hksGiGtbTepeMwgJQ9h36j9NpUWaL26aSSNV1ZoBuOeR7m
        eO1J7s0cwXnOB9B0tGh+F1XJoGiu8xPgkuWfzHo=
X-Google-Smtp-Source: AGHT+IG855tjOaqTZMP1Pg5edsy+rhFVdEjsRk9EBVEmHQDp/MlwNLhtQ28ABzTN/eJV6YNFjLxQ9RvdLzByf+vGIdk=
X-Received: by 2002:a05:6870:56a5:b0:1fb:1373:c889 with SMTP id
 p37-20020a05687056a500b001fb1373c889mr2509798oao.102.1701598027688; Sun, 03
 Dec 2023 02:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20231126071914.932241-1-masahiroy@kernel.org>
In-Reply-To: <20231126071914.932241-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 3 Dec 2023 19:06:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATEJ80O8r-B+ByBykNVhDR2SW9_cBDArhz1W75KNW=z_A@mail.gmail.com>
Message-ID: <CAK7LNATEJ80O8r-B+ByBykNVhDR2SW9_cBDArhz1W75KNW=z_A@mail.gmail.com>
Subject: Re: [PATCH] init: move THIS_MODULE from <linux/export.h> to <linux/init.h>
To:     linux-kbuild@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 4:19=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit f50169324df4 ("module.h: split out the EXPORT_SYMBOL into
> export.h") appropriately separated EXPORT_SYMBOL into <linux/export.h>
> because modules and EXPORT_SYMBOL are orthogonal; modules are symbol
> consumers, while EXPORT_SYMBOL are used by symbol providers, which
> may not be necessarily a module.
>
> However, that commit also relocated THIS_MODULE. As explained in the
> commit description, the intention was to define THIS_MODULE in a
> lightweight header, but I do not believe <linux/export.h> was the
> suitable location because EXPORT_SYMBOL and THIS_MODULE are unrelated.
>
> Move it to another lightweight header, <linux/init.h>. The reason for
> choosing <linux/init.h> is to make <linux/moduleparam.h> self-contained
> without relying on <linux/linkage.h> incorrectly including
> <linux/export.h>.
>
> With this adjustment, the role of <linux/export.h> becomes clearer as
> it only defines EXPORT_SYMBOL.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Applied to kbuild.

I did not get any report from the 0day bot so far,
but I hope it will get a little more compile tests
before getting into linux-next.



>
>  include/linux/export.h | 18 ------------------
>  include/linux/init.h   |  7 +++++++
>  2 files changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 9911508a9604..0bbd02fd351d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -6,15 +6,6 @@
>  #include <linux/linkage.h>
>  #include <linux/stringify.h>
>
> -/*
> - * Export symbols from the kernel to modules.  Forked from module.h
> - * to reduce the amount of pointless cruft we feed to gcc when only
> - * exporting a simple symbol or two.
> - *
> - * Try not to add #includes here.  It slows compilation and makes kernel
> - * hackers place grumpy comments in header files.
> - */
> -
>  /*
>   * This comment block is used by fixdep. Please do not remove.
>   *
> @@ -23,15 +14,6 @@
>   * side effect of the *.o build rule.
>   */
>
> -#ifndef __ASSEMBLY__
> -#ifdef MODULE
> -extern struct module __this_module;
> -#define THIS_MODULE (&__this_module)
> -#else
> -#define THIS_MODULE ((struct module *)0)
> -#endif
> -#endif /* __ASSEMBLY__ */
> -
>  #ifdef CONFIG_64BIT
>  #define __EXPORT_SYMBOL_REF(sym)                       \
>         .balign 8                               ASM_NL  \
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 01b52c9c7526..3fa3f6241350 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -179,6 +179,13 @@ extern void (*late_time_init)(void);
>
>  extern bool initcall_debug;
>
> +#ifdef MODULE
> +extern struct module __this_module;
> +#define THIS_MODULE (&__this_module)
> +#else
> +#define THIS_MODULE ((struct module *)0)
> +#endif
> +
>  #endif
>
>  #ifndef MODULE
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
