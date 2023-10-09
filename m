Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDC7BD53F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjJIIbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjJIIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:31:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F9A3;
        Mon,  9 Oct 2023 01:31:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8368C433C9;
        Mon,  9 Oct 2023 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696840299;
        bh=k+U5O8rSw/WBFMKyCVGOfUbLEx6tf3XN/L5MZF6Uqa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=guH2wMSMUCza3wYp4jOLA4YfzvWfYqkGW81raiiNvQHQOOEV4YZXjnvxFarx6CHKG
         SCkKgmu4jAhc5Pefo7U7YVY4WrYLt4k412V1VX5x8ezqj8LeZ8p7ws1oOHgAE8uRUG
         zEia8CD6OGSiQJSFXr7i1OWWN/bVENARFtqkvrm5E51Q/FVvWQ1uvKXbMwOWhFCFMl
         N4IzEYECZV6gD3WoOPuyljoD07eSh1WYrsIpqW+aCKqYwAt8vfV18XhKiLpMi/YKxv
         GyyKWECp96fexe8ZEQf8DhUmo2mRldh1JSo8MP7X4dQQRrKMBWVvxX3l3SCNQr9fU7
         u28yDYbpsWBnw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3af64a4c97eso2415831b6e.2;
        Mon, 09 Oct 2023 01:31:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqJ2qETXzalIgEi5VNjb2GZDnpYW6+jiC1YKj0Wm6dRCN4J7w8
        HbJ5zT44pKa86miee5r7XyWVPTeNGM6XLX1o2n0=
X-Google-Smtp-Source: AGHT+IFRkq0Z5e5o/4ftogKUePolTKBpPtT85HqjlKijj4ZEXvwYnMDnF92iO4aDuyOtNzU+UBT5uxn3uoWUnAkBHAM=
X-Received: by 2002:a05:6870:8a0b:b0:1bf:5b4:4a51 with SMTP id
 p11-20020a0568708a0b00b001bf05b44a51mr13909865oaq.58.1696840299192; Mon, 09
 Oct 2023 01:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231005150728.3429-1-msuchanek@suse.de>
In-Reply-To: <20231005150728.3429-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Oct 2023 17:31:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
Message-ID: <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default MODLIB
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Oct 6, 2023 at 12:49=E2=80=AFAM Michal Suchanek <msuchanek@suse.de>=
 wrote:
>
> The default MODLIB value is composed of two variables and the hardcoded
> string '/lib/modules/'.
>
> MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>
> Defining this middle part as a variable was rejected on the basis that
> users can pass the whole MODLIB to make, such as


In other words, do you want to say

"If defining this middle part as a variable had been accepted,
this patch would have been unneeded." ?


I do not think so.


If your original patch were accepted, how would this patch look like?

kernel.spec needs to know the module directory somehow.


Would you add the following in scripts/package/mkspec ?

%define MODLIB $(pkg-config --print-variables kmod 2>/dev/null | grep
'^module_directory$' >/dev/null && pkg-config
--variable=3Dmodule_directory kmod || echo /lib/modules)








>
> make 'MODLIB=3D$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
>
> However, this middle part of MODLIB is independently hardcoded by
> rpm-pkg, and when the user alters MODLIB this is not reflected when
> building the package.
>
> Given that $(INSTALL_MOD_PATH) is overridden during the rpm package build
> it is likely going to be empty. Then MODLIB can be passed to the rpm
> package, and used in place of the whole
> /usr/lib/modules/$(KERNELRELEASE) part.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  scripts/package/kernel.spec | 8 ++++----
>  scripts/package/mkspec      | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..15f49c5077db 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/b=
oot/vmlinuz-%{KERNELRELEA
>  %{make} %{makeflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_install
>  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
>  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KER=
NELRELEASE}/build
> +ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND=3D'${srctree}/script=
s/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE=
}'
>  %endif
> @@ -98,8 +98,8 @@ fi
>
>  %files
>  %defattr (-, root, root)
> -/lib/modules/%{KERNELRELEASE}
> -%exclude /lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}
> +%exclude %{MODLIB}/build
>  /boot/*
>
>  %files headers
> @@ -110,5 +110,5 @@ fi
>  %files devel
>  %defattr (-, root, root)
>  /usr/src/kernels/%{KERNELRELEASE}
> -/lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}/build
>  %endif
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index d41608efb747..d41b2e5304ac 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -18,6 +18,7 @@ fi
>  cat<<EOF
>  %define ARCH ${ARCH}
>  %define KERNELRELEASE ${KERNELRELEASE}
> +%define MODLIB ${MODLIB}
>  %define pkg_release $("${srctree}/init/build-version")
>  EOF
>
> --
> 2.42.0
>


--
Best Regards
Masahiro Yamada
