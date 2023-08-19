Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F28781BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHTAaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHTA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6647172;
        Sat, 19 Aug 2023 16:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26D960C55;
        Sat, 19 Aug 2023 23:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217E1C433C9;
        Sat, 19 Aug 2023 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692486102;
        bh=S54+u/z7ER5THaF+Z5rBF/mSUnUV7SUQxnsu1w7JQL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gb/FV3kBW65P0lj4W3Q7QcrPeCCO0Zw+FRS8EHNqXqIK4Iq8ByIm3GqO+zE72wz56
         MtyWPqqG2MP2SMLUKVIQA88BCtBh4OLYbc6oBIOZgxA0x91jaMzgmCvlzhWoATr+O1
         6cheqQjhaCZEK/PAbARWf6DjaHtfXRm0DhIlm99hAC7zE15D2WYM8dNyp3rnMwDk44
         OJYCb7cDJ6Oj99wU+yn5dVW7K+Im6DfEba2BuK/xM0RA0vs1KERy3yH/itYJUYc1l6
         TC1hAvZjVHEZpsSScEyWrJ9P/rjQ0Wwci+4WwU0zMovwVYy94e3B6MMAyWeedNOzhe
         m0Mr1EYS3wPAA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-570b371b776so480306eaf.3;
        Sat, 19 Aug 2023 16:01:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxl/F0w6CUI8HMgmbbBIYaqjZwsW7YJdjQrD16UAzfp0Gs3aHv4
        37Fff38UwQcVJQ7rLSvJeRihOTldfnt6As9Ie7I=
X-Google-Smtp-Source: AGHT+IF2XByXya0Q5LzeK4VqkKhDpqKvM61w9DGzE2SQA+u3vYDzLfPHVmi/0C1yLufyX78Wuugv9uYgvSH3w4djSYU=
X-Received: by 2002:a4a:3947:0:b0:56d:c55b:4792 with SMTP id
 x7-20020a4a3947000000b0056dc55b4792mr3204636oog.6.1692486101338; Sat, 19 Aug
 2023 16:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
In-Reply-To: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 08:01:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
Message-ID: <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add dependency warning print about invalid
 values in verbose mode
To:     sunying@nj.iscas.ac.cn
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siyuan Guo <zy21df106@buaa.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 9:32=E2=80=AFAM <sunying@nj.iscas.ac.cn> wrote:
>
> From: Ying Sun <sunying@nj.iscas.ac.cn>
>
> Add warning about the configuration option's invalid value in verbose mod=
e,
>  including error causes, mismatch dependency, old and new values,
>  to help users correct them.
>
> Detailed error messages are printed only when the environment variable
>  is set like "KCONFIG_VERBOSE=3D1".
> By default, the current behavior is not changed.
>
> Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
> Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>


This patch is much bigger than I had expected.

I did not go through all the lines, but
I think the behavior should be improved.



[1] A downgrade from 'y' to 'm' should be warned.


You only check (sym->dir_dep.tri =3D=3D no && sym->def[S_DEF_USER].tri !=3D=
 no)

but (sym->dir_dep.tri =3D=3D mod && sym->def[S_DEF_USER].tri =3D=3D yes)
will cause =3Dy to be downgraded to =3Dm.
This must be warned.




[2] A new CONFIG option should not be warned.

$ make defconfig

Add the following two lines to a Kconfig file.

config THIS_IS_A_NEW_OPTION
       def_bool y


$ make KCONFIG_VERBOSE=3D1 oldconfig

ERROR : THIS_IS_A_NEW_OPTION[n =3D> y] value is invalid
 due to it has default value
#
# configuration written to .config
#




This is totally harmless.
I do not understand why it is warned.





BTW, your patch subject says
"add dependency warning", but your actually code prints "ERROR".

Also, check the coding style.







> ---
>  scripts/kconfig/confdata.c | 121 +++++++++++++++++++++++++++++++++++--
>  scripts/kconfig/lkc.h      |   3 +
>  scripts/kconfig/symbol.c   |  82 +++++++++++++++++++++++--
>  3 files changed, 195 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 992575f1e976..fa2ae6f63352 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -154,6 +154,7 @@ static void conf_message(const char *fmt, ...)
>
>  static const char *conf_filename;
>  static int conf_lineno, conf_warnings;
> +const char *verbose;
>
>  static void conf_warning(const char *fmt, ...)
>  {
> @@ -226,7 +227,7 @@ static const char *conf_get_rustccfg_name(void)
>  static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, =
char *p)
>  {
>         char *p2;
> -
> +       static const char * const type[] =3D {"unknown", "bool", "tristat=
e", "int", "hex", "string"};
>         switch (sym->type) {
>         case S_TRISTATE:
>                 if (p[0] =3D=3D 'm') {
> @@ -246,9 +247,14 @@ static int conf_set_sym_val(struct symbol *sym, int =
def, int def_flags, char *p)
>                         sym->flags |=3D def_flags;
>                         break;
>                 }
> -               if (def !=3D S_DEF_AUTO)
> -                       conf_warning("symbol value '%s' invalid for %s",
> +               if (def !=3D S_DEF_AUTO) {
> +                       if (verbose)
> +                               conf_warning("symbol value '%s' invalid f=
or %s\n due to its type is %s",
> +                                    p, sym->name, type[sym->type]);
> +                       else
> +                               conf_warning("symbol value '%s' invalid f=
or %s",
>                                      p, sym->name);
> +               }
>                 return 1;
>         case S_STRING:
>                 /* No escaping for S_DEF_AUTO (include/config/auto.conf) =
*/
> @@ -274,9 +280,14 @@ static int conf_set_sym_val(struct symbol *sym, int =
def, int def_flags, char *p)
>                         sym->def[def].val =3D xstrdup(p);
>                         sym->flags |=3D def_flags;
>                 } else {
> -                       if (def !=3D S_DEF_AUTO)
> -                               conf_warning("symbol value '%s' invalid f=
or %s",
> -                                            p, sym->name);
> +                       if (def !=3D S_DEF_AUTO) {
> +                               if (verbose)
> +                                       conf_warning("symbol value '%s' i=
nvalid for %s\n due to its type is %s",
> +                                               p, sym->name, type[sym->t=
ype]);
> +                               else
> +                                       conf_warning("symbol value '%s' i=
nvalid for %s",
> +                                               p, sym->name);
> +                       }
>                         return 1;
>                 }
>                 break;
> @@ -528,6 +539,7 @@ int conf_read(const char *name)
>         int conf_unsaved =3D 0;
>         int i;
>
> +       verbose =3D getenv("KCONFIG_VERBOSE");
>         conf_set_changed(false);
>
>         if (conf_read_simple(name, S_DEF_USER)) {
> @@ -559,6 +571,103 @@ int conf_read(const char *name)
>                         continue;
>                 conf_unsaved++;
>                 /* maybe print value in verbose mode... */
> +               if (verbose) {
> +                       if (sym_is_choice_value(sym)) {
> +                               struct property *prop =3D sym_get_choice_=
prop(sym);
> +                               struct symbol *defsym =3D prop_get_symbol=
(prop)->curr.val;
> +
> +                               if (defsym && defsym !=3D sym) {
> +                                       struct gstr gs =3D str_new();
> +
> +                                       str_printf(&gs,
> +                                               "\nERROR : %s[%c =3D> %c]=
 value is invalid\n",
> +                                               sym->name,
> +                                               tristate2char[sym->def[S_=
DEF_USER].tri],
> +                                               tristate2char[sym->curr.t=
ri]);
> +                                       str_printf(&gs,
> +                                               " due to its not the choi=
ce default symbol\n");
> +                                       str_printf(&gs,
> +                                               " the default symbol is %=
s\n",
> +                                               defsym->name);
> +                                       fputs(str_get(&gs), stderr);
> +                               }
> +                       } else {
> +                               switch (sym->type) {
> +                               case S_BOOLEAN:
> +                               case S_TRISTATE:
> +                                       if (sym->dir_dep.tri =3D=3D no &&
> +                                               sym->def[S_DEF_USER].tri =
!=3D no) {
> +                                               struct gstr gs =3D str_ne=
w();
> +
> +                                               str_printf(&gs,
> +                                                       "\nERROR: unmet d=
irect dependencies detected for %s[%c =3D> %c]\n",
> +                                                       sym->name,
> +                                                       tristate2char[sym=
->def[S_DEF_USER].tri],
> +                                                       tristate2char[sym=
->curr.tri]);
> +                                               str_printf(&gs,
> +                                                       "  Depends on [%c=
]: ",
> +                                                       sym->dir_dep.tri =
=3D=3D mod ? 'm' : 'n');
> +                                               expr_gstr_print(sym->dir_=
dep.expr, &gs);
> +                                               str_printf(&gs, "\n");
> +                                               fputs(str_get(&gs), stder=
r);
> +                                       } else if (sym->rev_dep.tri !=3D =
no) {
> +                                               struct gstr gs =3D str_ne=
w();
> +
> +                                               str_printf(&gs,
> +                                                       "\nERROR : %s[%c =
=3D> %c] value is invalid\n",
> +                                                       sym->name,
> +                                                       tristate2char[sym=
->def[S_DEF_USER].tri],
> +                                                       tristate2char[sym=
->curr.tri]);
> +                                               str_printf(&gs,
> +                                                       " due to its invi=
sible and it is selected\n");
> +                                               expr_gstr_print_revdep(sy=
m->rev_dep.expr, &gs, yes,
> +                                                                       "=
  Selected by [y]:\n");
> +                                               expr_gstr_print_revdep(sy=
m->rev_dep.expr, &gs, mod,
> +                                                                       "=
  Selected by [m]:\n");
> +                                               fputs(str_get(&gs), stder=
r);
> +                                       } else {
> +                                               sym_validate_default(sym)=
;
> +                                       }
> +                                       break;
> +                               case S_INT:
> +                               case S_HEX:
> +                                       if (sym->dir_dep.tri =3D=3D no &&
> +                                       strcmp((char *)(sym->def[S_DEF_US=
ER].val), "") !=3D 0) {
> +                                               struct gstr gs =3D str_ne=
w();
> +
> +                                               str_printf(&gs,
> +                                                       "\nERROR: unmet d=
irect dependencies detected for %s\n",
> +                                                       sym->name);
> +                                               str_printf(&gs,
> +                                                       "  Depends on [%c=
]: ",
> +                                                       sym->dir_dep.tri =
=3D=3D mod ? 'm' : 'n');
> +                                               expr_gstr_print(sym->dir_=
dep.expr, &gs);
> +                                               str_printf(&gs, "\n");
> +                                               fputs(str_get(&gs), stder=
r);
> +                                       } else {
> +                                               sym_validate_default(sym)=
;
> +                                       }
> +                                       break;
> +                               case S_STRING:
> +                                       if (sym->dir_dep.tri =3D=3D no &&
> +                                       strcmp((char *)(sym->def[S_DEF_US=
ER].val), "") !=3D 0) {
> +                                               struct gstr gs =3D str_ne=
w();
> +
> +                                               str_printf(&gs,
> +                                                       "\nERROR: unmet d=
irect dependencies detected for %s\n",
> +                                                       sym->name);
> +                                               str_printf(&gs,
> +                                                       "  Depends on [%c=
]: ",
> +                                                       sym->dir_dep.tri =
=3D=3D mod ? 'm' : 'n');
> +                                               expr_gstr_print(sym->dir_=
dep.expr, &gs);
> +                                               str_printf(&gs, "\n");
> +                                               fputs(str_get(&gs), stder=
r);
> +                                       }
> +                               default:
> +                                       break;
> +                               }
> +                       }
> +               }
>         }
>
>         for_all_symbols(i, sym) {
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index 471a59acecec..820a47fb4968 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -38,6 +38,8 @@ void zconf_initscan(const char *name);
>  void zconf_nextfile(const char *name);
>  int zconf_lineno(void);
>  const char *zconf_curname(void);
> +extern const char *verbose;
> +static const char tristate2char[3] =3D {'n', 'm', 'y'};
>
>  /* confdata.c */
>  const char *conf_get_configname(void);
> @@ -112,6 +114,7 @@ struct property *sym_get_range_prop(struct symbol *sy=
m);
>  const char *sym_get_string_default(struct symbol *sym);
>  struct symbol *sym_check_deps(struct symbol *sym);
>  struct symbol *prop_get_symbol(struct property *prop);
> +void sym_validate_default(struct symbol *sym);
>
>  static inline tristate sym_get_tristate_value(struct symbol *sym)
>  {
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 0572330bf8a7..8b11d6ea1d30 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -91,6 +91,53 @@ static struct property *sym_get_default_prop(struct sy=
mbol *sym)
>         return NULL;
>  }
>
> +void sym_validate_default(struct symbol *sym)
> +{
> +       if (sym->visible =3D=3D no) {
> +               struct gstr gs =3D str_new();
> +               const char *value =3D sym_get_string_default(sym);
> +
> +               switch (sym->type) {
> +               case S_BOOLEAN:
> +               case S_TRISTATE:
> +                       if (strcmp(value, "n") !=3D 0) {
> +                               str_printf(&gs,
> +                                       "\nERROR : %s[%c =3D> %c] value i=
s invalid\n due to it has default value\n",
> +                                       sym->name,
> +                                       tristate2char[sym->def[S_DEF_USER=
].tri],
> +                                       tristate2char[sym->curr.tri]);
> +                       } else if (sym->implied.tri !=3D no) {
> +                               str_printf(&gs,
> +                                       "\nERROR : %s[%c =3D> %c] value i=
s invalid\n due to its invisible and has imply value\n",
> +                                       sym->name,
> +                                       tristate2char[sym->def[S_DEF_USER=
].tri],
> +                                       tristate2char[sym->curr.tri]);
> +                               str_printf(&gs,
> +                                       " Imply : ");
> +                               expr_gstr_print(sym->implied.expr, &gs);
> +                               str_printf(&gs, "\n");
> +                       }
> +                       break;
> +               case S_STRING:
> +               case S_INT:
> +               case S_HEX:
> +                       if (strcmp(value, "") !=3D 0) {
> +                               str_printf(&gs,
> +                                       "\nERROR : %s[%s =3D> %s] value i=
s invalid\n",
> +                                       sym->name,
> +                                       (char *)(sym->def[S_DEF_USER].val=
),
> +                                       (char *)(sym->curr.val));
> +                               str_printf(&gs,
> +                                       " due to it has default value\n")=
;
> +                       }
> +                       break;
> +               default:
> +                       break;
> +               }
> +               fputs(str_get(&gs), stderr);
> +       }
> +}
> +
>  struct property *sym_get_range_prop(struct symbol *sym)
>  {
>         struct property *prop;
> @@ -600,7 +647,8 @@ bool sym_string_valid(struct symbol *sym, const char =
*str)
>  bool sym_string_within_range(struct symbol *sym, const char *str)
>  {
>         struct property *prop;
> -       long long val;
> +       long long val, left, right;
> +       struct gstr gs =3D str_new();
>
>         switch (sym->type) {
>         case S_STRING:
> @@ -612,8 +660,20 @@ bool sym_string_within_range(struct symbol *sym, con=
st char *str)
>                 if (!prop)
>                         return true;
>                 val =3D strtoll(str, NULL, 10);
> -               return val >=3D sym_get_range_val(prop->expr->left.sym, 1=
0) &&
> -                      val <=3D sym_get_range_val(prop->expr->right.sym, =
10);
> +               left =3D sym_get_range_val(prop->expr->left.sym, 10);
> +               right =3D sym_get_range_val(prop->expr->right.sym, 10);
> +               if (val >=3D left && val <=3D right)
> +                       return true;
> +               if (verbose) {
> +                       str_printf(&gs,
> +                               "\nERROR: unmet range detected for %s\n",
> +                               sym->name);
> +                       str_printf(&gs,
> +                               " symbol value is %lld, the range is (%ll=
d %lld)\n",
> +                               val, left, right);
> +                       fputs(str_get(&gs), stderr);
> +               }
> +               return false;
>         case S_HEX:
>                 if (!sym_string_valid(sym, str))
>                         return false;
> @@ -621,8 +681,20 @@ bool sym_string_within_range(struct symbol *sym, con=
st char *str)
>                 if (!prop)
>                         return true;
>                 val =3D strtoll(str, NULL, 16);
> -               return val >=3D sym_get_range_val(prop->expr->left.sym, 1=
6) &&
> -                      val <=3D sym_get_range_val(prop->expr->right.sym, =
16);
> +               left =3D sym_get_range_val(prop->expr->left.sym, 16);
> +               right =3D sym_get_range_val(prop->expr->right.sym, 16);
> +               if (val >=3D left && val <=3D right)
> +                       return true;
> +               if (verbose) {
> +                       str_printf(&gs,
> +                               "\nERROR: unmet range detected for %s\n",
> +                               sym->name);
> +                       str_printf(&gs,
> +                               " symbol value is 0x%llx, the range is (0=
x%llx 0x%llx)\n",
> +                               val, left, right);
> +                       fputs(str_get(&gs), stderr);
> +               }
> +               return false;
>         case S_BOOLEAN:
>         case S_TRISTATE:
>                 switch (str[0]) {
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
