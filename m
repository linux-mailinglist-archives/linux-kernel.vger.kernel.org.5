Return-Path: <linux-kernel+bounces-12771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D148081F9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D01C219B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A1F508;
	Thu, 28 Dec 2023 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddNeO62y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41201F9C2;
	Thu, 28 Dec 2023 16:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FF7C433C7;
	Thu, 28 Dec 2023 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703779894;
	bh=nnd1opf9wwwaHv9hFWrSsn8RSzN3NL7jhKBJ7PrftXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ddNeO62ybaBpFNoOjz3K+uJZohWA0sgqulib+7CrGvYRytyTC/op8ts7vqYgioTSV
	 hdtP/HmHR4hejvEhY8fwZW9LcwYGaQ6f8wN0Lfml/roR60cqq9Rl9aWekkHqD/NbrU
	 aKRdJzwfVCMKsbF3ViEgaJX1TE1z7pDZbPmnwCmwPRg5nztHBHzQ1jdDjRqXR+gdCN
	 +R04njt0b9VYsUOqcgE4YYlmV+RYUTNgtxilk/01Ie+9mIemqlI7Op/BvZzV5PIvtV
	 72Ri/SBJvMFQU7bLXD75UINNvGtEoIN3q5gyBSVsVZwZKlDWHCTUMz9DezO5U4sAnD
	 Szkf1dv7GM1FQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc07ce2a30so727529a34.0;
        Thu, 28 Dec 2023 08:11:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2fPOT9nEfgl7AnNO/HsPyznWcQJnUni99K0xCUFD/1VMIK+DL
	7Wq/+SVGNquGPkWYwf9jX+vKwDTKKAuwx2Py5c8=
X-Google-Smtp-Source: AGHT+IFpQPoaCFoiP3xamYcVlaZnjD0yftzX87pucNojhXMz5LhYYevEbcYq5Ddt4qTOlEBDvZ66FICp60vasHoduC0=
X-Received: by 2002:a05:6871:546:b0:204:2d89:21de with SMTP id
 t6-20020a056871054600b002042d8921demr9492889oal.15.1703779893965; Thu, 28 Dec
 2023 08:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228070941.3611649-1-tfiga@chromium.org>
In-Reply-To: <20231228070941.3611649-1-tfiga@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Dec 2023 01:10:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
Message-ID: <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add a build target for checking current config
 for issues
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 4:09=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> The new target is called 'checkconfig' and currently is basically an
> alias for `listnewconfig` with KCONFIG_WARN_UNKNOWN_SYMBOLS set to true.
> It can be used to validate if the current config is directly compatible
> with the current kernel version or needs some manual adjustment.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>


I rejected a new target in the past.

https://lore.kernel.org/all/20230817012007.131868-1-senozhatsky@chromium.or=
g/T/#m55c37e3091158f8cb008d9e0b5c6bf3f5ead225a



Instead, you can run

  KCONFIG_WARN_UNKNOWN_SYMBOLS=3D1 make listnewconfig

or

  make W=3Dc listnewconfig









> ---
>  scripts/kconfig/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 4eee155121a8..501cb9b76414 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -81,6 +81,9 @@ PHONY +=3D savedefconfig defconfig
>  savedefconfig: $(obj)/conf
>         $(Q)$< $(silent) --$@=3Ddefconfig $(Kconfig)
>
> +checkconfig: $(obj)/conf
> +       $(Q)KCONFIG_WARN_UNKNOWN_SYMBOLS=3Dtrue $< --listnewconfig $(Kcon=
fig)
> +
>  defconfig: $(obj)/conf
>  ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)=
),)
>         @$(kecho) "*** Default configuration is based on '$(KBUILD_DEFCON=
FIG)'"
> @@ -144,6 +147,7 @@ help:
>         @echo  '                    default value without prompting'
>         @echo  '  tinyconfig      - Configure the tiniest possible kernel=
'
>         @echo  '  testconfig      - Run Kconfig unit tests (requires pyth=
on3 and pytest)'
> +       @echo  '  checkconfig     - Check current config for unrecognized=
 and new symbols'
>         @echo  ''
>         @echo  'Configuration topic targets:'
>         @$(foreach f, $(all-config-fragments), \
> --
> 2.43.0.472.g3155946c3a-goog
>


--
Best Regards

Masahiro Yamada

