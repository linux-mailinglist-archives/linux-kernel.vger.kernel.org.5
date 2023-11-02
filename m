Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD07DF2FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376278AbjKBM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:57:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A30121;
        Thu,  2 Nov 2023 05:57:17 -0700 (PDT)
Received: from pwmachine.localnet (unknown [86.120.35.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4336E20B74C0;
        Thu,  2 Nov 2023 05:57:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4336E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698929836;
        bh=lmXPUyUM/jM/0/57e2UuFckkajSYsjPidz3sTbvACts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK3+MYew1dfqEhbm6caxcWlTBwGqR+jjUFwcWkNPxYbyU3BxLPR1TctUk5nwAdd1p
         WfXNHb6EecnK9VSXI2KXIwEhu4BOjB/9QVHSJm7hsS/aI1HX3OfmcQsO31iJWaMHs5
         JyKhW7g8mWmak42ulD8iq2NrPUjTfWaxFaa0PeQ8=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check when module loads
Date:   Thu, 02 Nov 2023 14:57:12 +0200
Message-ID: <5987802.lOV4Wx5bFT@pwmachine>
In-Reply-To: <20231101081509.605080231a2736b91331cb85@kernel.org>
References: <169854904604.132316.12500381416261460174.stgit@devnote2> <1868732.tdWV9SEqCh@pwmachine> <20231101081509.605080231a2736b91331cb85@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Le mercredi 1 novembre 2023, 01:15:09 EET Masami Hiramatsu a =E9crit :
> Hi,
>=20
> On Tue, 31 Oct 2023 23:24:43 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > @@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const
> > > char
> > > *name, unsigned long unused) return 0;
> > >=20
> > >  }
> > >=20
> > > -static unsigned int number_of_same_symbols(char *func_name)
> > > +static unsigned int number_of_same_symbols(const char *mod, const ch=
ar
> > > *func_name) {
> > >=20
> > >  	struct sym_count_ctx ctx =3D { .count =3D 0, .name =3D func_name };
> > >=20
> > > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> > > +	if (!mod)
> > > +		kallsyms_on_each_match_symbol(count_symbols, func_name,
> >=20
> > &ctx.count);
> >=20
> > > -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> > > +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
> >=20
> > I may be missing something here or reviewing too quickly.
> > Wouldn't this function return count to be 0 if func_name is only part of
> > the module named mod?
>=20
> No, please read below.
>=20
> > Indeed, if the function is not in kernel symbol,
> > kallsyms_on_each_match_symbol() will not loop.
> > And, by giving mod to module_kallsyms_on_each_symbol(), the correspondi=
ng
> > module will be skipped, so count_mob_symbols() would not be called.
> > Hence, we would have 0 as count, which would lead to ENOENT later.
>=20
> Would you mean the case func_name is on the specific module?
> If 'mod' is specified, module_kallsyms_on_each_symbol() only loops on
> symbols in the module names 'mod'.
>=20
> int module_kallsyms_on_each_symbol(const char *modname,
>                                    int (*fn)(void *, const char *, unsign=
ed
> long), void *data)
> {
>         struct module *mod;
>         unsigned int i;
>         int ret =3D 0;
>=20
>         mutex_lock(&module_mutex);
>         list_for_each_entry(mod, &modules, list) {
>                 struct mod_kallsyms *kallsyms;
>=20
>                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>                         continue;
>=20
>                 if (modname && strcmp(modname, mod->name))
>                         continue;
> ...
>=20
> So with above change, 'if mod is not specified, search the symbols in ker=
nel
> and all modules. If mod is sepecified, search the symbol on the specific
> module'.
>=20
> Thus, "if func_name is only part of the module named mod", the
> module_kallsyms_on_each_symbol() will count the 'func_name' in 'mod' modu=
le
> correctly.

Sorry, I looked to quickly and forgot about the return value of strcmp()...

=46rom the code, everything seems OK!
If I have some time, I will test it and potentially come back with a "Teste=
d-
by" tag but without any warranty.

> Thank you,
>=20
>=20
> Thank you,

Best regards.


