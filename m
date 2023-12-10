Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA980BC97
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjLJSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:44:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280FDF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:44:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA761C43391;
        Sun, 10 Dec 2023 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702233861;
        bh=9SODrnF5mnSkO6mjlA/PnjTFQYLuo6SeN7rFnxhsZrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Icrh23fSCnU25t5zjraKFxz0GFZldNjGdSgApNqZiV7tIVx2PTB436CWxUMlr0IlV
         gVJH7LCThW6zZZhE1f7XttM316utHvEBWXX6cUIj+xrCe36gJwyLoxGgCUzpk3M04/
         pGLJmkcQxXVHZtnJIZP02XoRUKPPJu5BA+0p6bog0/qLcxyuWsj2DxNNEmfN8Tb4Fh
         oLKVIUCEJmXlrdbJBbUqiLv7g52wiB9DNEck9W3TyWuR+c63eYgD9h2JBDjM1wu0D/
         lCD/4nr7b9ykOCEpS0wO9NmeyZXk+tMxKhXdyq8f16LiRQ+X/P+Zg+igEPWRLMjcsO
         FvVkBcO3swKvA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso2494364fac.1;
        Sun, 10 Dec 2023 10:44:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yybw5QVTtM5j2ImDIbQC8ireAOEFjufxWlzrSdAqLvYVAqFgxGY
        iIxy0Ku4pLymR258OeMCZcYbWWdbE7E0TzfgBD0=
X-Google-Smtp-Source: AGHT+IGoxr0Vkbt2EDm1QXzSTyrftWtsLudktB5EsV7+IDJ4suxs/p20O0KYPX4vxXIcWOUv++6Xq7dVVbcRX9ZAC38=
X-Received: by 2002:a05:6870:c1cc:b0:1fb:75a:6d2b with SMTP id
 i12-20020a056870c1cc00b001fb075a6d2bmr4139539oad.82.1702233861235; Sun, 10
 Dec 2023 10:44:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
In-Reply-To: <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 11 Dec 2023 03:43:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
Message-ID: <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] depmod: Handle installing modules under a
 different directory
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 7, 2023 at 4:48=E2=80=AFAM Michal Suchanek <msuchanek@suse.de> =
wrote:
>
> Some distributions aim at shipping all files in /usr.
>
> The path under which kernel modules are installed is hardcoded to /lib
> which conflicts with this goal.
>
> When kmod provides kmod.pc, use it to determine the correct module
> installation path.
>
> With kmod that does not provide the config /lib/modules is used as
> before.
>
> While pkg-config does not return an error when a variable does not exist
> the kmod configure script puts some effort into ensuring that
> module_directory is non-empty. With that empty module_directory from
> pkg-config can be used to detect absence of the variable.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v6:
>  - use ?=3D instead of :=3D to make it easier to override the value


"KERNEL_MODULE_DIRECTORY=3D/local/usr/lib/modules make modules_install"
will override the install destination, but
depmod will not be not aware of it.

How to avoid the depmod error?














>  - use shorter expression for determining the module directory assuming
>    it's non-empty
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 511b5616aa41..84f32bd563d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1081,7 +1081,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/dtbs/=
$(KERNELRELEASE)
>  # makefile but the argument can be passed to make if needed.
>  #
>
> -MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_DIRECTORY ?=3D $(or $(shell pkg-config --variable=
=3Dmodule_directory kmod 2>/dev/null),/lib/modules)
> +
> +MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE=
)
>  export MODLIB
>
>  PHONY +=3D prepare0
> --
> 2.42.0
>
>


--
Best Regards
Masahiro Yamada
