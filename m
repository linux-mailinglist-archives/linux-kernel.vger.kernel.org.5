Return-Path: <linux-kernel+bounces-160583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18588B3F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B23D1F2461F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6DAD58;
	Fri, 26 Apr 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFeQZ0Mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06566FA8;
	Fri, 26 Apr 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157406; cv=none; b=fpSwZ8pMQPPw7sHuM4/X5URTKlCw66WjO9MZQsfwyJ6muHCdCQTnocVTRA9gK59cKmQ25ACWNu5BDC3sn8iUt8AtAG+LBbrP0l/CB0Aq7c1Nw2kj9xpfJoPLDcGt3ZGrNiTUk2Zm8BjGbjA5Qh7RFy0HRp/+P6uvjasYjamtBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157406; c=relaxed/simple;
	bh=WBxXctJ/CCUk/yx/HFQvVJU9n3QU9xoVPU+TXKN90Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4iWd5jPRhdzAHl1VXOHWn+pLqfsXoVPlox5fFeIEBA+u+xUJ2PfuIc3IyXvxL4ZegkRHCD4d1sw/7IEC/xOjeqmjceOv9EmortGDJpgaugHNj3PE/sCXdENVeIVcdmoDrzRG9xjbL4Lbdfv6BpiNDwmM702Dm1KNcwWeDWHEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFeQZ0Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F50DC113CD;
	Fri, 26 Apr 2024 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714157406;
	bh=WBxXctJ/CCUk/yx/HFQvVJU9n3QU9xoVPU+TXKN90Lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFeQZ0MzcXfKPLf9cQ+mSo+FVEZ9pu+zMImGs0HZO+ZhjOdydOgca0fbahdbbzW9w
	 oYQgsrYTBP2vyz9wfENyZJEMtwQByFWNDPnDTgdqPLc/EJ09O/TqMKYfE4AzBCmPam
	 p5dNRD+oQvdHzGrf7OMgNmB4vsWtTiF25Vs7w4NRsBONBt9wpR1OuyAt2LX3o1kn/1
	 KEQ5YkslfZ9ghotpYLxb8dSink5WyPDcdcNgK6I/7jFaiw1DEDEHrfRO1C3CUrCXAc
	 qcMK55/QGqFWdGMxWWtCNqR6g/Z8MQ6LgdqxVnzjqSjLs1aHHzJVZibgBAf5jOy4pP
	 8fQyeEnbzK/+w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so24491011fa.2;
        Fri, 26 Apr 2024 11:50:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXO/BXqIcw1iF9EL5kLQ0b1lDMaiw1+59WrnRm3wqJjAuwj89rMS3kt9N46/us26dkdMJDcR6nPXBovHvsDnyyZbGzHIFAe2wgcp62r
X-Gm-Message-State: AOJu0YxX7aR9lCr2JymzCk0Rc1P1oVugPAPsZ5AdXGQh1Lvw6TDox+PX
	RlhemHZxiaxpwby8HLFRSZOq1NgoQ1+RGLA/R/glmkkCoSoYQ01b0zk/5+PzwJfvqmQBt3XcADQ
	DXwXW563KtpIMVfWUV+TKoVt1XkY=
X-Google-Smtp-Source: AGHT+IEfCqgVFjBqbPwI4bRDLMfJCnJd2Sl6BBOm0pcT8+r0ETmHn/IUimtNLO/IXUsnA6tjCxLS8d4g6s/CXbHmXWA=
X-Received: by 2002:a05:6512:20ca:b0:51b:455a:d649 with SMTP id
 u10-20020a05651220ca00b0051b455ad649mr1832117lfr.38.1714157404788; Fri, 26
 Apr 2024 11:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418101903.11314-1-sunying@isrc.iscas.ac.cn>
In-Reply-To: <20240418101903.11314-1-sunying@isrc.iscas.ac.cn>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Apr 2024 03:49:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvhUOV-kzVLkT=S=CLBJT8wbirkD1v9C7J=Gg4EBecUQ@mail.gmail.com>
Message-ID: <CAK7LNATvhUOV-kzVLkT=S=CLBJT8wbirkD1v9C7J=Gg4EBecUQ@mail.gmail.com>
Subject: Re: [PATCHv4 next] kconfig: add dependency warning print about
 invalid values while KBUILD_EXTRA_WARN=c
To: sunying@isrc.iscas.ac.cn
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengpeng@iscas.ac.cn, zy21df106@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 7:19=E2=80=AFPM <sunying@isrc.iscas.ac.cn> wrote:
>
> From: Ying Sun <sunying@isrc.iscas.ac.cn>
>
> The patch enhances kernel error messages, fixes problems with
>  the previous version of v3,


Unneeded information.
You do not need to advertise your previous wrong patch.

The patch submission history should be
described below the '---' marker.



> and has been thoroughly tested.

Unneeded.
It is quite normal for a patch submitter
to test their patch before submission.




>  We believe it will improve the clarity and usefulness
>  of kconfig error messages, which will help developers better diagnose an=
d
>  resolve configuration issues.



"We believe" is unneeded.








>
> ----- v3 -> v4:
> 1. Fixed the dependency logic print error, distinguishing
>  between unsatisfied dependencies and forced enable
>  errors (related to the select keyword).
> 2. Add export KCONFIG_WARN_CHANGED_INPUT=3D1 to scripts/kconfig/Makefile,
>  which can be enabled by setting KBUILD_EXTRA_WARN to -c.
>
> Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
> Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
> ---
>  scripts/kconfig/Makefile   |  1 +
>  scripts/kconfig/confdata.c | 60 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index ea1bf3b3dbde..b755246fe057 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -29,6 +29,7 @@ KCONFIG_DEFCONFIG_LIST +=3D arch/$(SRCARCH)/configs/$(K=
BUILD_DEFCONFIG)
>
>  ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
>  export KCONFIG_WARN_UNKNOWN_SYMBOLS=3D1
> +export KCONFIG_WARN_CHANGED_INPUT=3D1
>  endif
>
>  ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 0e35c4819cf1..91c63bd1cedd 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -176,6 +176,41 @@ static void conf_warning(const char *fmt, ...)
>         conf_warnings++;
>  }
>
> +static void conf_warn_unmet_rev(struct symbol *sym)
> +{
> +       struct gstr gs =3D str_new();
> +
> +       str_printf(&gs,
> +               "WARNING: unmet reverse dependencies detected for %s\n",
> +               sym->name);


This message is wrong.

Kconfig changed the value so it meets the reverse dependency.

It should warn that the value has been changed.



> +
> +       expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
> +                               " Selected by [y]:\n");
> +       expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
> +                               " Selected by [m]:\n");
> +
> +       fputs(str_get(&gs), stderr);
> +       str_free(&gs);
> +}
> +
> +static void conf_warn_dep_error(struct symbol *sym)
> +{
> +       struct gstr gs =3D str_new();
> +
> +       str_printf(&gs,
> +               "WARNING: unmet direct dependencies detected for %s\n",
> +               sym->name);



Same here.

Kconfig changed the value so it meets the direct dependency.






> +
> +       str_printf(&gs,
> +               " Depends on [%c]: ",
> +               sym->dir_dep.tri =3D=3D mod ? 'm' : 'n');
> +       expr_gstr_print(sym->dir_dep.expr, &gs);
> +
> +       str_printf(&gs, "\n");
> +       fputs(str_get(&gs), stderr);
> +       str_free(&gs);
> +}
> +
>  static void conf_default_message_callback(const char *s)
>  {
>         printf("#\n# ");
> @@ -522,6 +557,31 @@ int conf_read(const char *name)
>                         continue;
>                 conf_unsaved++;
>                 /* maybe print value in verbose mode... */
> +               if (getenv("KCONFIG_WARN_CHANGED_INPUT")) {
> +                       if (sym->prop) {



Why did you check sym->prop here?





> +                               switch (sym->type) {
> +                               case S_BOOLEAN:
> +                               case S_TRISTATE:
> +                                       if (sym->def[S_DEF_USER].tri !=3D=
 sym_get_tristate_value(sym)) {
> +                                               if (sym->rev_dep.tri < sy=
m->def[S_DEF_USER].tri &&
> +                                                       sym->dir_dep.tri =
< sym->def[S_DEF_USER].tri)
> +                                                               conf_warn=
_dep_error(sym);
> +                                               if (sym->rev_dep.tri > sy=
m->def[S_DEF_USER].tri &&
> +                                                       sym->dir_dep.tri =
>=3D sym->def[S_DEF_USER].tri)
> +                                                               conf_warn=
_unmet_rev(sym);


This is clumsy.

conf_warn_dep_error() and conf_warn_unmet_rev()
do not happen at the same time.


if (sym->def[S_DEF_USER].tri !=3D sym_get_tristate_value(sym)) {
        if (sym->rev_dep.tri > sym->def[S_DEF_USER].tri)
                conf_warn_unmet_rev(sym);
        else if (sym->dir_dep.tri < sym->def[S_DEF_USER].tri)
                conf_warn_dep_error(sym);
}


is much simpler.















> +                                       }
> +                                       break;
> +                               case S_INT:
> +                               case S_HEX:
> +                               case S_STRING:
> +                                       if (sym->dir_dep.tri =3D=3D no &&=
 sym_has_value(sym))
> +                                               conf_warn_dep_error(sym);
> +                                       break;
> +                               default:
> +                                       break;
> +                               }
> +                       }
> +               }
>         }
>
>         for_all_symbols(sym) {
> --
> 2.43.0
>
>


--=20
Best Regards
Masahiro Yamada

