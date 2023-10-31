Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23247DD7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjJaVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:24:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E5A2C9;
        Tue, 31 Oct 2023 14:24:48 -0700 (PDT)
Received: from pwmachine.localnet (unknown [86.120.35.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 967FF20B74C0;
        Tue, 31 Oct 2023 14:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 967FF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698787488;
        bh=gG03rAe2FtyOPSAhpM5tzKBrh+LgC3p1zjFdoR03kFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB6thDyYrlTR6s3BCVIiVO31AOQwvOg7TTnZ4LbOKxrx9ePGCt+8BN8Wvki2cgnnO
         0mASnUa0k3Xkze6Jz+KcjZ1rKFVqzxvOz5k0e1Jq9KWJVk2XmCCUVexwtGpeaVSP0m
         p7Hx2BXAcitv8DqnyjwardxkXGFxFLMDlyJaARpE=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check when module loads
Date:   Tue, 31 Oct 2023 23:24:43 +0200
Message-ID: <1868732.tdWV9SEqCh@pwmachine>
In-Reply-To: <169854904604.132316.12500381416261460174.stgit@devnote2>
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


Le dimanche 29 octobre 2023, 05:10:46 EET Masami Hiramatsu (Google) a =E9cr=
it :
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Check the number of probe target symbols in the target module when
> the module is loaded. If the probe is not on the unique name symbols
> in the module, it will be rejected at that point.
>=20
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,

I am wondering about symbols which are only part of one specific module.
I wrote a comment about it below, please let me know what you think about i=
t.

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |  112
> ++++++++++++++++++++++++++----------------- 1 file changed, 68
> insertions(+), 44 deletions(-)
>=20
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e834f149695b..90cf2219adb4 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -670,6 +670,21 @@ static int register_trace_kprobe(struct trace_kprobe
> *tk) return ret;
>  }
>=20
> +static int validate_module_probe_symbol(const char *modname, const char
> *symbol); +
> +static int register_module_trace_kprobe(struct module *mod, struct
> trace_kprobe *tk) +{
> +	const char *p;
> +	int ret =3D 0;
> +
> +	p =3D strchr(trace_kprobe_symbol(tk), ':');
> +	if (p)
> +		ret =3D validate_module_probe_symbol(module_name(mod), p++);
> +	if (!ret)
> +		ret =3D register_trace_kprobe(tk);
> +	return ret;
> +}
> +
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -688,7 +703,7 @@ static int trace_kprobe_module_callback(struct
> notifier_block *nb, if (trace_kprobe_within_module(tk, mod)) {
>  			/* Don't need to check busy - this should have gone. */
>  			__unregister_trace_kprobe(tk);
> -			ret =3D __register_trace_kprobe(tk);
> +			ret =3D register_module_trace_kprobe(mod, tk);
>  			if (ret)
>  				pr_warn("Failed to re-register probe %s on %s:=20
%d\n",
>  					trace_probe_name(&tk->tp),
> @@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const char
> *name, unsigned long unused) return 0;
>  }
>=20
> -static unsigned int number_of_same_symbols(char *func_name)
> +static unsigned int number_of_same_symbols(const char *mod, const char
> *func_name) {
>  	struct sym_count_ctx ctx =3D { .count =3D 0, .name =3D func_name };
>=20
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> +	if (!mod)
> +		kallsyms_on_each_match_symbol(count_symbols, func_name,=20
&ctx.count);
>=20
> -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);

I may be missing something here or reviewing too quickly.
Wouldn't this function return count to be 0 if func_name is only part of th=
e=20
module named mod?
Indeed, if the function is not in kernel symbol,=20
kallsyms_on_each_match_symbol() will not loop.
And, by giving mod to module_kallsyms_on_each_symbol(), the corresponding=20
module will be skipped, so count_mob_symbols() would not be called.
Hence, we would have 0 as count, which would lead to ENOENT later.

>  	return ctx.count;
>  }
>=20
> +static int validate_module_probe_symbol(const char *modname, const char
> *symbol) +{
> +	unsigned int count =3D number_of_same_symbols(modname, symbol);
> +
> +	if (count > 1) {
> +		/*
> +		 * Users should use ADDR to remove the ambiguity of
> +		 * using KSYM only.
> +		 */
> +		return -EADDRNOTAVAIL;
> +	} else if (count =3D=3D 0) {
> +		/*
> +		 * We can return ENOENT earlier than when register the
> +		 * kprobe.
> +		 */
> +		return -ENOENT;
> +	}
> +	return 0;
> +}
> +
> +static int validate_probe_symbol(char *symbol)
> +{
> +	char *mod =3D NULL, *p;
> +	int ret;
> +
> +	p =3D strchr(symbol, ':');
> +	if (p) {
> +		mod =3D symbol;
> +		symbol =3D p + 1;
> +		*p =3D '\0';
> +	}
> +	ret =3D validate_module_probe_symbol(mod, symbol);
> +	if (p)
> +		*p =3D ':';
> +	return ret;
> +}
> +
>  static int __trace_kprobe_create(int argc, const char *argv[])
>  {
>  	/*
> @@ -859,6 +912,14 @@ static int __trace_kprobe_create(int argc, const char
> *argv[]) trace_probe_log_err(0, BAD_PROBE_ADDR);
>  			goto parse_error;
>  		}
> +		ret =3D validate_probe_symbol(symbol);
> +		if (ret) {
> +			if (ret =3D=3D -EADDRNOTAVAIL)
> +				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> +			else
> +				trace_probe_log_err(0, BAD_PROBE_ADDR);
> +			goto parse_error;
> +		}
>  		if (is_return)
>  			ctx.flags |=3D TPARG_FL_RETURN;
>  		ret =3D kprobe_on_func_entry(NULL, symbol, offset);
> @@ -871,31 +932,6 @@ static int __trace_kprobe_create(int argc, const char
> *argv[]) }
>  	}
>=20
> -	if (symbol && !strchr(symbol, ':')) {
> -		unsigned int count;
> -
> -		count =3D number_of_same_symbols(symbol);
> -		if (count > 1) {
> -			/*
> -			 * Users should use ADDR to remove the ambiguity of
> -			 * using KSYM only.
> -			 */
> -			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> -			ret =3D -EADDRNOTAVAIL;
> -
> -			goto error;
> -		} else if (count =3D=3D 0) {
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			trace_probe_log_err(0, BAD_PROBE_ADDR);
> -			ret =3D -ENOENT;
> -
> -			goto error;
> -		}
> -	}
> -
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1767,21 +1803,9 @@ create_local_trace_kprobe(char *func, void *addr,
> unsigned long offs, char *event;
>=20
>  	if (func) {
> -		unsigned int count;
> -
> -		count =3D number_of_same_symbols(func);
> -		if (count > 1)
> -			/*
> -			 * Users should use addr to remove the ambiguity of
> -			 * using func only.
> -			 */
> -			return ERR_PTR(-EADDRNOTAVAIL);
> -		else if (count =3D=3D 0)
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			return ERR_PTR(-ENOENT);
> +		ret =3D validate_probe_symbol(func);
> +		if (ret)
> +			return ERR_PTR(ret);
>  	}
>=20
>  	/*

Best regards.


