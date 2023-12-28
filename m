Return-Path: <linux-kernel+bounces-12770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C29E81F9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C43B2233A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112EF50C;
	Thu, 28 Dec 2023 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVmE1+jM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB23883B;
	Thu, 28 Dec 2023 16:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8CCC433C7;
	Thu, 28 Dec 2023 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703779834;
	bh=RSdLfk9wXN3UmWbB+4Xg5vcj5ybypng0lAuXAXAnXew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZVmE1+jMMvEws3muVa7Wz7O+CrtmRIQ17orpjAKcheuw2zxLBWv7jMkHCsHnLVzgp
	 YqZAFhb93nthI/i5zyZhKLTQ+oBNd+3AXX/MyuVo6geIKeQC6ax2+ZMgTe6I3TXRPl
	 hnqBWA3a6tcZMUINOCGLlczYZVfW2KcxTfZMU74WeRtAu2jmsfSCVcQFKSe/56x46j
	 sxjHCAOlITH1aXL5HKJ4hPCgfet/apXQS/d6wDjZhfBE/d+BF+lrsOUasBAq3Hw9wu
	 9SmAbp6XvUWsvjzxr/PGF4KbdSNkv4UhfIEGK6C4jUoWdKtCbt+MagUhztwxAtB01Q
	 ePcd2Gp6uF0MQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203fbbff863so2649840fac.0;
        Thu, 28 Dec 2023 08:10:34 -0800 (PST)
X-Gm-Message-State: AOJu0YxCG7T2JIc9Y4aM7BUZg+HH2tZ7/a1ozb5/FP3qA037i4nXgSuq
	qR1F7f2BudFepRdh24JJLmWi8W5P916hHwuBfjE=
X-Google-Smtp-Source: AGHT+IH5vJ//YaO+5yA7xuIHse7BmcrDMDHPXhAqZDIr8x1KjzSGDjXkgQeay6PlFk71NyB8mF49d2+g7U0uMCi99fw=
X-Received: by 2002:a05:6871:3a2c:b0:1fa:f432:22d with SMTP id
 pu44-20020a0568713a2c00b001faf432022dmr3851410oac.17.1703779833901; Thu, 28
 Dec 2023 08:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org>
In-Reply-To: <20231228054630.3595093-1-tfiga@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Dec 2023 01:09:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
Message-ID: <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> When hidden options are toggled on (using 'z'), the number of options
> on the screen can be overwhelming and may make it hard to distinguish
> between available and hidden ones. Make them easier to distinguish by
> displaying the hidden one as dim (using the A_DIM curses attribute).
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>



Do you think this is useful?

This changes the color only when you select a hidden item.


For unselected items, you cannot distinguish hidden ones,
as A_DIM has no effect to black text.









> ---
>  scripts/kconfig/lxdialog/dialog.h  |  3 +++
>  scripts/kconfig/lxdialog/menubox.c | 11 +++++++----
>  scripts/kconfig/lxdialog/util.c    | 10 ++++++++++
>  scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog=
/dialog.h
> index a501abf9fa31..d2ebdc6e2e28 100644
> --- a/scripts/kconfig/lxdialog/dialog.h
> +++ b/scripts/kconfig/lxdialog/dialog.h
> @@ -128,6 +128,7 @@ void item_add_str(const char *fmt, ...);
>  void item_set_tag(char tag);
>  void item_set_data(void *p);
>  void item_set_selected(int val);
> +void item_set_hidden(int val);
>  int item_activate_selected(void);
>  void *item_data(void);
>  char item_tag(void);
> @@ -139,6 +140,7 @@ struct dialog_item {
>         char tag;
>         void *data;     /* pointer to menu item - used by menubox+checkli=
st */
>         int selected;   /* Set to 1 by dialog_*() function if selected. *=
/
> +       int hidden;     /* Set to 1 if hidden. */
>  };
>
>  /* list of lialog_items */
> @@ -157,6 +159,7 @@ int item_n(void);
>  const char *item_str(void);
>  int item_is_selected(void);
>  int item_is_tag(char tag);
> +int item_is_hidden(void);
>  #define item_foreach() \
>         for (item_cur =3D item_head ? item_head: item_cur; \
>              item_cur && (item_cur !=3D &item_nil); item_cur =3D item_cur=
->next)
> diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialo=
g/menubox.c
> index 0e333284e947..2cf1f24f67b6 100644
> --- a/scripts/kconfig/lxdialog/menubox.c
> +++ b/scripts/kconfig/lxdialog/menubox.c
> @@ -51,9 +51,9 @@ static int menu_width, item_x;
>   * Print menu item
>   */
>  static void do_print_item(WINDOW * win, const char *item, int line_y,
> -                         int selected, int hotkey)
> +                         int selected, int hotkey, int hidden)
>  {
> -       int j;
> +       int j, attrs;
>         char *menu_item =3D malloc(menu_width + 1);
>
>         strncpy(menu_item, item, menu_width - item_x);
> @@ -64,7 +64,10 @@ static void do_print_item(WINDOW * win, const char *it=
em, int line_y,
>         wattrset(win, dlg.menubox.atr);
>         wmove(win, line_y, 0);
>         wclrtoeol(win);
> -       wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
> +       attrs =3D selected ? dlg.item_selected.atr : dlg.item.atr;
> +       if (hidden)
> +               attrs |=3D A_DIM;
> +       wattrset(win, attrs);
>         mvwaddstr(win, line_y, item_x, menu_item);
>         if (hotkey) {
>                 wattrset(win, selected ? dlg.tag_key_selected.atr
> @@ -81,7 +84,7 @@ static void do_print_item(WINDOW * win, const char *ite=
m, int line_y,
>  #define print_item(index, choice, selected)                            \
>  do {                                                                   \
>         item_set(index);                                                \
> -       do_print_item(menu, item_str(), choice, selected, !item_is_tag(':=
')); \
> +       do_print_item(menu, item_str(), choice, selected, !item_is_tag(':=
'), item_is_hidden()); \
>  } while (0)
>
>  /*
> diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/u=
til.c
> index 3f78fb265136..58d6ee96f7ec 100644
> --- a/scripts/kconfig/lxdialog/util.c
> +++ b/scripts/kconfig/lxdialog/util.c
> @@ -635,6 +635,11 @@ void item_set_selected(int val)
>         item_cur->node.selected =3D val;
>  }
>
> +void item_set_hidden(int val)
> +{
> +       item_cur->node.hidden =3D val;
> +}
> +
>  int item_activate_selected(void)
>  {
>         item_foreach()
> @@ -698,3 +703,8 @@ int item_is_tag(char tag)
>  {
>         return (item_cur->node.tag =3D=3D tag);
>  }
> +
> +int item_is_hidden(void)
> +{
> +       return (item_cur->node.hidden !=3D 0);
> +}
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index eccc87a441e7..090121a1e5b6 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -539,6 +539,8 @@ static void build_conf(struct menu *menu)
>                                                   menu_is_empty(menu) ? "=
----" : "--->");
>                                 item_set_tag('m');
>                                 item_set_data(menu);
> +                               if (!visible)
> +                                       item_set_hidden(TRUE);
>                                 if (single_menu_mode && menu->data)
>                                         goto conf_childs;
>                                 return;
> @@ -548,6 +550,8 @@ static void build_conf(struct menu *menu)
>                                         item_make("   %*c*** %s ***", ind=
ent + 1, ' ', prompt);
>                                         item_set_tag(':');
>                                         item_set_data(menu);
> +                                       if (!visible)
> +                                               item_set_hidden(TRUE);
>                                 }
>                                 break;
>                         default:
> @@ -556,6 +560,8 @@ static void build_conf(struct menu *menu)
>                                         item_make("---%*c%s", indent + 1,=
 ' ', prompt);
>                                         item_set_tag(':');
>                                         item_set_data(menu);
> +                                       if (!visible)
> +                                               item_set_hidden(TRUE);
>                                 }
>                         }
>                 } else
> @@ -591,10 +597,14 @@ static void build_conf(struct menu *menu)
>                         }
>                         item_set_tag('t');
>                         item_set_data(menu);
> +                       if (!visible)
> +                               item_set_hidden(TRUE);
>                 } else {
>                         item_make("   ");
>                         item_set_tag(def_menu ? 't' : ':');
>                         item_set_data(menu);
> +                       if (!visible)
> +                               item_set_hidden(TRUE);
>                 }
>
>                 item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(me=
nu));
> @@ -615,6 +625,8 @@ static void build_conf(struct menu *menu)
>                         item_make("---%*c%s", indent + 1, ' ', menu_get_p=
rompt(menu));
>                         item_set_tag(':');
>                         item_set_data(menu);
> +                       if (!visible)
> +                               item_set_hidden(TRUE);
>                         goto conf_childs;
>                 }
>                 child_count++;
> @@ -632,6 +644,8 @@ static void build_conf(struct menu *menu)
>                                         item_make("-%c-", val =3D=3D no ?=
 ' ' : '*');
>                                 item_set_tag('t');
>                                 item_set_data(menu);
> +                               if (!visible)
> +                                       item_set_hidden(TRUE);
>                                 break;
>                         case S_TRISTATE:
>                                 switch (val) {
> @@ -648,6 +662,8 @@ static void build_conf(struct menu *menu)
>                                         item_make("-%c-", ch);
>                                 item_set_tag('t');
>                                 item_set_data(menu);
> +                               if (!visible)
> +                                       item_set_hidden(TRUE);
>                                 break;
>                         default:
>                                 tmp =3D 2 + strlen(sym_get_string_value(s=
ym)); /* () =3D 2 */
> @@ -660,6 +676,8 @@ static void build_conf(struct menu *menu)
>                                              "" : " (NEW)");
>                                 item_set_tag('s');
>                                 item_set_data(menu);
> +                               if (!visible)
> +                                       item_set_hidden(TRUE);
>                                 goto conf_childs;
>                         }
>                 }
> --
> 2.43.0.472.g3155946c3a-goog
>
>


--=20
Best Regards
Masahiro Yamada

