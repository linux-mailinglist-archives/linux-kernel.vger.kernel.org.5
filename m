Return-Path: <linux-kernel+bounces-160987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4428B4576
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BE91C2111F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED147F6B;
	Sat, 27 Apr 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtJisH5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC743AA2;
	Sat, 27 Apr 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714212394; cv=none; b=pWpUMxHgDRxCErWyDMLAkY0SvDxxqBRT3iXUr2vF9Ve2QbRgYXRj14iRgqJ6Z7G+KQjn/qmMSz0wYy0leXmeMGPWtT+np8ploX7V2R3SuEJWVMoS24C26bTRBbZOEvgrxpKOr5lnIRTnKJjlyS8N7q3Wq64oXJ4XHQUNiCn3L24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714212394; c=relaxed/simple;
	bh=kzKzmjQSLyELOaHx8ENTHOHGtQTuBunSZrFLuoJyHnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5zO2Qd6y+HtNv0zNGQsfVzOoXJ8cDXBJdzZmCwwkvV8XWhT7gCF/NmBaTnCcGJH2pvYejKJ01IKOhKav2Bn8EOKv+ffOcH8Q/0Yq7dAeo2GF86VcJ+rGqxKNeBhzpjFwf2bB5bH2HcnR0rIoY0lpTqJJonk+iFfTd42Usgec5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtJisH5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E0C113CE;
	Sat, 27 Apr 2024 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714212393;
	bh=kzKzmjQSLyELOaHx8ENTHOHGtQTuBunSZrFLuoJyHnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PtJisH5hVT8OixjBLoL3Gj2RTySvlPbE+VhgeSp8BMrqVG9Z9WbLLW/UczmYXn/eE
	 ZUxxa70OH/APzPbWTcuKAcJuLc3+8d/075bDbLp+CiFhCWPcHN6/zJvU1O9R/zTPUg
	 dZnbkATSm51eG0YoNjQE5L+k6OIkKTSDbJBkv/nz1zXpCnrKvVOlmQ3yPRtBSrvzXi
	 FSLmmyWvbRxBWaDwlvpB+FMZePoDcE4IcXDgA6ufefukkgau66P/7pfDFkH4/2vWMZ
	 FuJxt88NDnUCIrhmCd+La/Fcdggix0jPdEdlVUgvfU3tgdafrPyXcnshlJwwa/76d9
	 49Yw/L+sxs2MQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5196c755e82so3598105e87.0;
        Sat, 27 Apr 2024 03:06:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx453+NsF9OwL6GBGZxcxyr0YkS20QEfm9MeCZsZg5vI9sV4se7
	cHszCJoW20egU77qQK4VqBIwgBxGaYPW5Y/Jr5dEshMzHIZ9V6ganHFjylvhoK0DAuvm+jpsU5S
	pAzlwuFp5T0rbFgw66z14DcARJKs=
X-Google-Smtp-Source: AGHT+IFdQ28uQbTB6Mc/kxguimi9mBy216cOyH+bAt0M6kVKM0KywH9Z71+q4/py0eGtqPwufppjCr3lVkKW/HuRb0w=
X-Received: by 2002:a19:2d09:0:b0:513:1a9c:ae77 with SMTP id
 k9-20020a192d09000000b005131a9cae77mr2922235lfj.52.1714212392447; Sat, 27 Apr
 2024 03:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427091638.2722050-1-masahiroy@kernel.org>
In-Reply-To: <20240427091638.2722050-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Apr 2024 19:05:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR+PaeaNvWsMWe9BgJdr1-J5kiUJE21U+wfUTnQFaW46g@mail.gmail.com>
Message-ID: <CAK7LNAR+PaeaNvWsMWe9BgJdr1-J5kiUJE21U+wfUTnQFaW46g@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove SYMBOL_NO_WRITE flag
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 6:16=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> This flag is set to symbols that are not intended to be written
> to the .config file.
>
> Since commit b75b0a819af9 ("kconfig: change defconfig_list option to
> environment variable"), SYMBOL_NO_WRITE is only set to choices.
>
> Therefore, (sym->flags & SYMBOL_NO_WRITE) is equivalent to
> sym_is_choice(sym). This flags is no longer necessary.


"This flags" -> "This flag"


>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/confdata.c | 4 ++--
>  scripts/kconfig/expr.h     | 1 -
>  scripts/kconfig/gconf.c    | 2 --
>  scripts/kconfig/parser.y   | 2 +-
>  scripts/kconfig/symbol.c   | 3 +--
>  5 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index bcce87658998..5caec434e6f4 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -502,7 +502,7 @@ int conf_read(const char *name)
>
>         for_all_symbols(sym) {
>                 sym_calc_value(sym);
> -               if (sym_is_choice(sym) || (sym->flags & SYMBOL_NO_WRITE))
> +               if (sym_is_choice(sym))
>                         continue;
>                 if (sym_has_value(sym) && (sym->flags & SYMBOL_WRITE)) {
>                         /* check that calculated value agrees with saved =
value */
> @@ -1007,7 +1007,7 @@ static int conf_touch_deps(void)
>
>         for_all_symbols(sym) {
>                 sym_calc_value(sym);
> -               if ((sym->flags & SYMBOL_NO_WRITE) || !sym->name)
> +               if (sym_is_choice(sym))
>                         continue;
>                 if (sym->flags & SYMBOL_WRITE) {
>                         if (sym->flags & SYMBOL_DEF_AUTO) {
> diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
> index f646a98de006..d965e427753e 100644
> --- a/scripts/kconfig/expr.h
> +++ b/scripts/kconfig/expr.h
> @@ -135,7 +135,6 @@ struct symbol {
>  #define SYMBOL_WRITE      0x0200  /* write symbol to file (KCONFIG_CONFI=
G) */
>  #define SYMBOL_CHANGED    0x0400  /* ? */
>  #define SYMBOL_WRITTEN    0x0800  /* track info to avoid double-write to=
 .config */
> -#define SYMBOL_NO_WRITE   0x1000  /* Symbol for internal use only; it wi=
ll not be written */
>  #define SYMBOL_CHECKED    0x2000  /* used during dependency checking */
>  #define SYMBOL_WARNED     0x8000  /* warning has been issued */
>
> diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
> index 13e2449ac83f..67a27c497c40 100644
> --- a/scripts/kconfig/gconf.c
> +++ b/scripts/kconfig/gconf.c
> @@ -91,8 +91,6 @@ static const char *dbg_sym_flags(int val)
>                 strcat(buf, "write/");
>         if (val & SYMBOL_CHANGED)
>                 strcat(buf, "changed/");
> -       if (val & SYMBOL_NO_WRITE)
> -               strcat(buf, "no_write/");
>
>         buf[strlen(buf) - 1] =3D '\0';
>
> diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
> index 69dc0c098acb..613fa8c9c2d0 100644
> --- a/scripts/kconfig/parser.y
> +++ b/scripts/kconfig/parser.y
> @@ -222,7 +222,7 @@ config_option: T_MODULES T_EOL
>  choice: T_CHOICE T_EOL
>  {
>         struct symbol *sym =3D sym_lookup(NULL, 0);
> -       sym->flags |=3D SYMBOL_NO_WRITE;
> +
>         menu_add_entry(sym);
>         menu_add_expr(P_CHOICE, NULL, NULL);
>         printd(DEBUG_PARSE, "%s:%d:choice\n", cur_filename, cur_lineno);
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 8b34992ba5ed..b909c64f3bac 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -466,10 +466,9 @@ void sym_calc_value(struct symbol *sym)
>                         if (sym->flags & SYMBOL_CHANGED)
>                                 sym_set_changed(choice_sym);
>                 }
> -       }
>
> -       if (sym->flags & SYMBOL_NO_WRITE)
>                 sym->flags &=3D ~SYMBOL_WRITE;
> +       }
>
>         if (sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES)
>                 set_all_choice_values(sym);
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

