Return-Path: <linux-kernel+bounces-27315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E782EDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EB41F24698
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CB1B806;
	Tue, 16 Jan 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBAX5rMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C421B946;
	Tue, 16 Jan 2024 11:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA59C43399;
	Tue, 16 Jan 2024 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705404541;
	bh=b0Tah7LaflX0dHER9EadRPLUHNAqeAPivBwAD7pCYiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBAX5rMCaSHZ14MuV9kOSCNZr/SopoZbzJPwu5Xf7ZlJjVN4cirr6ePVfCWPg+Leu
	 Rma+5C7nNA2N5zRPWftmb0RasVCZD5dJ623pOVBA6yYXjyi/hI2wzpoiYpLRl27ene
	 BBKWBVVCJaNrALsxOdPBC3/fn9v2DARGS7d6e3vZHE3r9E8iHS3fcEMHpWiY91Syh4
	 5HNVqpDbZok3RXdy7o9q1GKH1tnet4JCskO7ymHQpRCdd8Vi/7fylVNrdRTQud0otG
	 6Tbd9hfUghR45b3C5i1IJ0JCEB5buAlfgJXnhBr4ahije4TnAS9QqSfsZmS1aozJ7v
	 96IvlQvEm3vxQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2053f5e97b2so5820241fac.3;
        Tue, 16 Jan 2024 03:29:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yw64cOXw8HNtsRb9V/CVHfN03DFncsuJljcNmf+r2GmwXIhAOUs
	L7JFTe8cQR7KdUEhX+53U7gQ41iEQaL56NMRh1Y=
X-Google-Smtp-Source: AGHT+IGSpo3pF2fS8dSodLhORPWV3R6UPhMWJ/yj8mI6AgDGZceFdbuYRdXgnXjwZ46rBkD3sFcfsAP2DZrHzsWHLo8=
X-Received: by 2002:a05:6871:5b1d:b0:1fb:1a86:8db0 with SMTP id
 op29-20020a0568715b1d00b001fb1a868db0mr10125175oac.8.1705404540871; Tue, 16
 Jan 2024 03:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113001135.7781-1-xtex@envs.net> <20240114081400.12452-1-xtex@envs.net>
 <20240114081400.12452-2-xtex@envs.net>
In-Reply-To: <20240114081400.12452-2-xtex@envs.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 20:28:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATObt70_dp0oFG_kUW6n6tC+jwodWyBMd0TQ3F2oidLQw@mail.gmail.com>
Message-ID: <CAK7LNATObt70_dp0oFG_kUW6n6tC+jwodWyBMd0TQ3F2oidLQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: defconf: use SRCARCH to find merged configs
To: Zhang Bingwu <xtex@envs.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Bingwu <xtexchooser@duck.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 5:14=E2=80=AFPM Zhang Bingwu <xtex@envs.net> wrote:
>
> From: Zhang Bingwu <xtexchooser@duck.com>
>
> For some ARCH values, SRCARCH, which should be used for finding arch/
> subdirectory, is different from ARCH.
>
> Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>



As you can see in "git log scripts/Makefile.defconf",
I was not involved in anything about this file.

I do not see much interest in this patch set, but
Arnd Bergmann might be excited about it.

(You did not accompany with a real use case though)









> ---
>  scripts/Makefile.defconf | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
> index ab271b205..226ea3df3 100644
> --- a/scripts/Makefile.defconf
> +++ b/scripts/Makefile.defconf
> @@ -9,8 +9,8 @@
>  # Input config fragments without '.config' suffix
>  define merge_into_defconfig
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -               -m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
> -               $(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(c=
onfig).config)
> +               -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) =
\
> +               $(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/=
$(config).config)
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>  endef
>
> @@ -23,7 +23,7 @@ endef
>  # Input config fragments without '.config' suffix
>  define merge_into_defconfig_override
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -               -Q -m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) =
\
> -               $(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(c=
onfig).config)
> +               -Q -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(=
1) \
> +               $(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/=
$(config).config)
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>  endef
> --
> 2.43.0
>
>


--
Best Regards
Masahiro Yamada

