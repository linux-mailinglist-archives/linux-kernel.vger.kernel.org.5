Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3457DD39C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjJaQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376395AbjJaQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:59:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE383E4;
        Tue, 31 Oct 2023 09:57:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c3aec5f326so891666b.1;
        Tue, 31 Oct 2023 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698771430; x=1699376230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMlWuVq/jABLdy8ESN5sPdDgWWJrTGWoakTiq5xlP+A=;
        b=YJBc3yEXg2bF6pTesqrGygylDyn9GO9WTIscSXX7owqD+WA7e2ZBnhhe/9aUxpjml8
         nxORIDK+Y7ZGLAZQgbRAUDaf2gvxRNJFWtN81G29CymAxdG4S5ghkGf6OIHpG3JAL62J
         dDoEcI/qyz2g3EP1jPwFBGzOoXankWRQcodglt85f68DPu6CIJJrVePuk9lTcLRt42ut
         ERVySZIWrs9QiDqFIx3MPFNyXMgRoY+NnSZA1q/QVuTFSvzKpnaS8ra1VGNKD0eYQtZL
         jeWiDIaoeVV2WZQPX6TwKiZovVk5T/HLwdACvT+kuPec7jQu9h7DtXkz6hRosbLSEffv
         lotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771430; x=1699376230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMlWuVq/jABLdy8ESN5sPdDgWWJrTGWoakTiq5xlP+A=;
        b=j2++LFpHXuUPzpThPNcpaI/aO0Qy+nXclnS01wc+0wQgfIVfjNPQ91KIfGFm7xwOmr
         Af25WSxQa+0a7DIrC0OUVVGGz6W1t4IcEP2ivL/SJ1Yb+JCgec15vMzXrLRdwyT0mP7R
         1P7s6G283T+66IwpbgkCJ8hLwXZ5NJu63jCKAwsUG67pSxH7ouFv0nSjWjh3uMBiRXOp
         pObTB7hV2mIRfNKPltbGtASGoOE9K42eTIH5Ju1HP3aaLA6fcmInbhxaf4yp2wgEbw1e
         eoCPcb1KwSPmigRKR6c+zDgWbtW8P+jyUE4jYkG5EVFoJdPw8AiTtcwFGznzsibPYMKh
         mpxQ==
X-Gm-Message-State: AOJu0YyZ2ahKOBEt/tMVm5rgWoJUWLALCiCUD5qgOz9iTUoysCYWFMLE
        Pweb7kTh5QQvb+zFTantKV6SWDmFQ1E7fbK1mMo=
X-Google-Smtp-Source: AGHT+IHHfxo7pUcbwSVcaPjI/ZiDdXcm3P8ZDlDwdHzVDW0Ix6okLMd/kWyyk8+yHaY4trVQytaeYUl5hiCwPnlBzyM=
X-Received: by 2002:a17:906:7313:b0:9ae:614e:4560 with SMTP id
 di19-20020a170906731300b009ae614e4560mr3222296ejc.29.1698771430245; Tue, 31
 Oct 2023 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
In-Reply-To: <169854904604.132316.12500381416261460174.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Oct 2023 09:56:58 -0700
Message-ID: <CAEf4BzaRCOKL1iYsryLCR0pO8wXHnxGE0=1j6+nYx7m07j7YFg@mail.gmail.com>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check when
 module loads
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 8:10=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Check the number of probe target symbols in the target module when
> the module is loaded. If the probe is not on the unique name symbols
> in the module, it will be rejected at that point.
>
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |  112 ++++++++++++++++++++++++++-----------=
------
>  1 file changed, 68 insertions(+), 44 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e834f149695b..90cf2219adb4 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -670,6 +670,21 @@ static int register_trace_kprobe(struct trace_kprobe=
 *tk)
>         return ret;
>  }
>
> +static int validate_module_probe_symbol(const char *modname, const char =
*symbol);
> +
> +static int register_module_trace_kprobe(struct module *mod, struct trace=
_kprobe *tk)
> +{
> +       const char *p;
> +       int ret =3D 0;
> +
> +       p =3D strchr(trace_kprobe_symbol(tk), ':');
> +       if (p)
> +               ret =3D validate_module_probe_symbol(module_name(mod), p+=
+);
> +       if (!ret)
> +               ret =3D register_trace_kprobe(tk);
> +       return ret;
> +}
> +
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>                                        unsigned long val, void *data)
> @@ -688,7 +703,7 @@ static int trace_kprobe_module_callback(struct notifi=
er_block *nb,
>                 if (trace_kprobe_within_module(tk, mod)) {
>                         /* Don't need to check busy - this should have go=
ne. */
>                         __unregister_trace_kprobe(tk);
> -                       ret =3D __register_trace_kprobe(tk);
> +                       ret =3D register_module_trace_kprobe(mod, tk);
>                         if (ret)
>                                 pr_warn("Failed to re-register probe %s o=
n %s: %d\n",
>                                         trace_probe_name(&tk->tp),
> @@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const char=
 *name, unsigned long unused)
>         return 0;
>  }
>
> -static unsigned int number_of_same_symbols(char *func_name)
> +static unsigned int number_of_same_symbols(const char *mod, const char *=
func_name)
>  {
>         struct sym_count_ctx ctx =3D { .count =3D 0, .name =3D func_name =
};
>
> -       kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.coun=
t);
> +       if (!mod)
> +               kallsyms_on_each_match_symbol(count_symbols, func_name, &=
ctx.count);
>
> -       module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> +       module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>
>         return ctx.count;
>  }
>
> +static int validate_module_probe_symbol(const char *modname, const char =
*symbol)
> +{
> +       unsigned int count =3D number_of_same_symbols(modname, symbol);
> +
> +       if (count > 1) {
> +               /*
> +                * Users should use ADDR to remove the ambiguity of
> +                * using KSYM only.
> +                */
> +               return -EADDRNOTAVAIL;
> +       } else if (count =3D=3D 0) {
> +               /*
> +                * We can return ENOENT earlier than when register the
> +                * kprobe.
> +                */
> +               return -ENOENT;
> +       }
> +       return 0;
> +}
> +
> +static int validate_probe_symbol(char *symbol)
> +{
> +       char *mod =3D NULL, *p;
> +       int ret;
> +
> +       p =3D strchr(symbol, ':');
> +       if (p) {
> +               mod =3D symbol;
> +               symbol =3D p + 1;
> +               *p =3D '\0';
> +       }
> +       ret =3D validate_module_probe_symbol(mod, symbol);
> +       if (p)
> +               *p =3D ':';
> +       return ret;
> +}
> +
>  static int __trace_kprobe_create(int argc, const char *argv[])
>  {
>         /*
> @@ -859,6 +912,14 @@ static int __trace_kprobe_create(int argc, const cha=
r *argv[])
>                         trace_probe_log_err(0, BAD_PROBE_ADDR);
>                         goto parse_error;
>                 }
> +               ret =3D validate_probe_symbol(symbol);
> +               if (ret) {
> +                       if (ret =3D=3D -EADDRNOTAVAIL)
> +                               trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> +                       else
> +                               trace_probe_log_err(0, BAD_PROBE_ADDR);
> +                       goto parse_error;
> +               }
>                 if (is_return)
>                         ctx.flags |=3D TPARG_FL_RETURN;
>                 ret =3D kprobe_on_func_entry(NULL, symbol, offset);
> @@ -871,31 +932,6 @@ static int __trace_kprobe_create(int argc, const cha=
r *argv[])
>                 }
>         }
>
> -       if (symbol && !strchr(symbol, ':')) {
> -               unsigned int count;
> -
> -               count =3D number_of_same_symbols(symbol);
> -               if (count > 1) {
> -                       /*
> -                        * Users should use ADDR to remove the ambiguity =
of
> -                        * using KSYM only.
> -                        */
> -                       trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> -                       ret =3D -EADDRNOTAVAIL;
> -
> -                       goto error;
> -               } else if (count =3D=3D 0) {
> -                       /*
> -                        * We can return ENOENT earlier than when registe=
r the
> -                        * kprobe.
> -                        */
> -                       trace_probe_log_err(0, BAD_PROBE_ADDR);
> -                       ret =3D -ENOENT;
> -
> -                       goto error;
> -               }
> -       }
> -
>         trace_probe_log_set_index(0);
>         if (event) {
>                 ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1767,21 +1803,9 @@ create_local_trace_kprobe(char *func, void *addr, =
unsigned long offs,
>         char *event;
>
>         if (func) {
> -               unsigned int count;
> -
> -               count =3D number_of_same_symbols(func);
> -               if (count > 1)
> -                       /*
> -                        * Users should use addr to remove the ambiguity =
of
> -                        * using func only.
> -                        */
> -                       return ERR_PTR(-EADDRNOTAVAIL);
> -               else if (count =3D=3D 0)
> -                       /*
> -                        * We can return ENOENT earlier than when registe=
r the
> -                        * kprobe.
> -                        */
> -                       return ERR_PTR(-ENOENT);
> +               ret =3D validate_probe_symbol(func);
> +               if (ret)
> +                       return ERR_PTR(ret);
>         }
>
>         /*
>
