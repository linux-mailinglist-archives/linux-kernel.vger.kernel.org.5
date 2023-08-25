Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91372788B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbjHYOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343784AbjHYOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:16:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB2F5E7B;
        Fri, 25 Aug 2023 07:15:46 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 674A12127C8E;
        Fri, 25 Aug 2023 07:14:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 674A12127C8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692972869;
        bh=IvnlCxT9OzH+XyEs7D1JGVlaY/IFvzfIeDzzNfzltlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXAyBKt8FeloYhXE+bte2WarGugFyn4nFWjVfP/BFtT8yaqoENwU18zQF1SWvcvrV
         LU5+T24W47wvzxUbxWMVOMaAwm2sj2Yj/L1kgin9S04Vbanz5qlMR4Z56lcCQXuaLw
         b9y9yXA2bxvKJ0B5uo0thwAuWtEd0Om5SF7pBBAk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Fri, 25 Aug 2023 16:14:25 +0200
Message-ID: <1862303.tdWV9SEqCh@pwmachine>
In-Reply-To: <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com> <5704161.DvuYhMxLoT@pwmachine> <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-18.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 25 ao=FBt 2023, 15:13:21 CEST Masami Hiramatsu a =E9crit :
> On Fri, 25 Aug 2023 14:34:49 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > Le vendredi 25 ao=FBt 2023, 14:16:49 CEST Masami Hiramatsu a =E9crit :
> > > On Thu, 24 Aug 2023 18:08:59 +0200
> > >=20
> > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > Previously to this commit, if func matches several symbols, a kprob=
e,
> > > > being
> > > > either sysfs or PMU, would only be installed for the first matching
> > > > address. This could lead to some misunderstanding when some BPF code
> > > > was
> > > > never called because it was attached to a function which was indeed
> > > > not
> > > > called, because the effectively called one has no kprobes attached.
> > > >=20
> > > > So, this commit returns EADDRNOTAVAIL when func matches several
> > > > symbols.
> > > > This way, user needs to use address to remove the ambiguity.
> > > >=20
> > > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > Link:
> > > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea74=
2@k
> > > > ern
> > > > el.org/ ---
> > >=20
> > > Ah, this should be fine, but selftest (tools/testing/selftests/ftrace)
> > > fails.
> > >=20
> > >  # tail 60-kprobe_module.tc-log.vsOHnF
> > >=20
> > > ...
> > > + :
> > > + : 'Add an event on a module function without specifying event name'
> > > + :
> > > + echo 'p trace_printk:trace_printk_irq_work'
> > > sh: write error: No such file or directory
> > >=20
> > > Ah, the function on non-exist module should be checked too.
> > >=20
> > > # tail 63-kprobe_syntax_errors.tc-log.mMLwIQ
> > > + + printfwc '%s' -c
> > >=20
> > >  'p '
> > >=20
> > > + pos=3D2
> > > + printf+  '%s'tr 'p ^non_exist_func'
> > >=20
> > >  -d ^
> > >=20
> > > + command=3D'p non_exist_func'
> > > + echo 'Test command: p non_exist_func'
> > > Test command: p non_exist_func
> > > + echo
> > > + grep 'trace_kprobe: error:' -A 3 error_log
> > >=20
> > > Also, this doesn't leave a syntax error message.
> > >=20
> > > So, the below changes are needed.
> >=20
> > Excellent catch! Thank you, I will apply this patch and send v4 right
> > after. Regarding test, do you think I can add a test for the
> > EADDRNOTAVAIL case?
> Hmm, in that case, you need to change something in tracefs/README so that
> we can identify the kernel has different behavior. Or we have to change
> this is a "Fix" for backporting.

Oops, sorry I sent the v4 with a test but as a separated commit, so we can=
=20
just ignore it for the moment.

> > Maybe it should go inside LTP? As this would need having a kernel compi=
led
> > with a name pointing to several symbols?
>=20
> For this tracing feature, I rather like to use
> tools/testing/selftests/ftrace to test it. And it is used on all stable
> kernel, that is why we need to add some change on tracefs/README or
> something.
>=20
> But I would like to wait for Alessandro's work. After his work, in this t=
ime
> we need to probe all the same-name symbols as your original patch does.
> This is because 1:n mapping can happen as Alessandro pointed in
>=20
> https://lore.kernel.org/all/CAPp5cGQsRdB0+KHR1wX2bDDdc5sTzSNPA417PNJb0ypm=
V=3Dy
> S6w@mail.gmail.com/
>=20
> But if his feature is configurable (and maybe so), we need to keep this
> version... We have many options.
>=20
> - this normal kallsyms: the same-name symbols should not be used.
> - enhanced kallsyms (if 1:n symbol has the same suffix): the same name
> symbols should be probed at once.
> - enhanced kallsyms (if 1:n symbol has different suffix): the same-name
> symbol must not exist.

I understand!
In future case, we could still have a test and change its behavior (i.e.=20
potentially skipping it) when KALLSYMS_ALIAS is set.

> > Also, should some man pages somewhere be updated to reflect the case
> > kprobe can return EADDRNOTAVAIL?
>=20
> No, it is a tracefs interface and we don't have man pages yet.

I was more thinking to the PMU counterpart as it is created through=20
perf_event_open()?

> Thank you,
>=20
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index 8ab46a2a446d..1e57bc896952 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -855,7 +855,7 @@ static int __trace_kprobe_create(int argc, const
> > > char
> > > *argv[]) }
> > >=20
> > >  	}
> > >=20
> > > -	if (symbol) {
> > > +	if (symbol && !strchr(symbol, ':')) {
> > >=20
> > >  		unsigned int count;
> > >  	=09
> > >  		count =3D number_of_same_symbols(symbol);
> > >=20
> > > @@ -864,6 +864,7 @@ static int __trace_kprobe_create(int argc, const
> > > char
> > > *argv[]) * Users should use ADDR to remove the ambiguity of
> > >=20
> > >  			 * using KSYM only.
> > >  			 */
> > >=20
> > > +			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> > >=20
> > >  			ret =3D -EADDRNOTAVAIL;
> > >  		=09
> > >  			goto error;
> > >=20
> > > @@ -872,6 +873,7 @@ static int __trace_kprobe_create(int argc, const
> > > char
> > > *argv[]) * We can return ENOENT earlier than when register the
> > >=20
> > >  			 * kprobe.
> > >  			 */
> > >=20
> > > +			trace_probe_log_err(0, BAD_PROBE_ADDR);
> > >=20
> > >  			ret =3D -ENOENT;
> > >  		=09
> > >  			goto error;
> > >=20
> > > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > > index 7f929482e8d4..a4f478448eef 100644
> > > --- a/kernel/trace/trace_probe.h
> > > +++ b/kernel/trace/trace_probe.h
> > > @@ -450,6 +450,7 @@ extern int traceprobe_define_arg_fields(struct
> > > trace_event_call *event_call, C(BAD_MAXACT,		"Invalid maxactive
> > > number"),		\
> > >=20
> > >  	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
> > >  	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
> > >=20
> > > +	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
> > >=20
> > >  	C(BAD_RETPROBE,		"Retprobe address must be an function
> >=20
> > entry"), \
> >=20
> > >  	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
> > >  	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
> > >=20
> > > Thank you,
> > >=20
> > > >  kernel/trace/trace_kprobe.c | 61
> > > >  +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 61 insertions(+)
> > > >=20
> > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprob=
e.c
> > > > index 23dba01831f7..2f393739e8cf 100644
> > > > --- a/kernel/trace/trace_kprobe.c
> > > > +++ b/kernel/trace/trace_kprobe.c
> > > > @@ -705,6 +705,25 @@ static struct notifier_block
> > > > trace_kprobe_module_nb =3D
> > > > {>
> > > >=20
> > > >  	.priority =3D 1	/* Invoked after kprobe module callback */
> > > > =20
> > > >  };
> > > >=20
> > > > +static int count_symbols(void *data, unsigned long unused)
> > > > +{
> > > > +	unsigned int *count =3D data;
> > > > +
> > > > +	(*count)++;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static unsigned int number_of_same_symbols(char *func_name)
> > > > +{
> > > > +	unsigned int count;
> > > > +
> > > > +	count =3D 0;
> > > > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > >=20
> > > >  static int __trace_kprobe_create(int argc, const char *argv[])
> > > >  {
> > > > =20
> > > >  	/*
> > > >=20
> > > > @@ -836,6 +855,29 @@ static int __trace_kprobe_create(int argc, con=
st
> > > > char
> > > > *argv[])>
> > > >=20
> > > >  		}
> > > >  =09
> > > >  	}
> > > >=20
> > > > +	if (symbol) {
> > > > +		unsigned int count;
> > > > +
> > > > +		count =3D number_of_same_symbols(symbol);
> > > > +		if (count > 1) {
> > > > +			/*
> > > > +			 * Users should use ADDR to remove the ambiguity of
> > > > +			 * using KSYM only.
> > > > +			 */
> > > >=20
> > > >=20
> > > >=20
> > > > +			ret =3D -EADDRNOTAVAIL;
> > > > +
> > > > +			goto error;
> > > > +		} else if (count =3D=3D 0) {
> > > > +			/*
> > > > +			 * We can return ENOENT earlier than when register the
> > > > +			 * kprobe.
> > > > +			 */
> > > > +			ret =3D -ENOENT;
> > > > +
> > > > +			goto error;
> > > > +		}
> > > > +	}
> > > > +
> > > >=20
> > > >  	trace_probe_log_set_index(0);
> > > >  	if (event) {
> > > >  =09
> > > >  		ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> > > >=20
> > > > @@ -1699,6 +1741,7 @@ static int unregister_kprobe_event(struct
> > > > trace_kprobe *tk)>
> > > >=20
> > > >  }
> > > > =20
> > > >  #ifdef CONFIG_PERF_EVENTS
> > > >=20
> > > > +
> > > >=20
> > > >  /* create a trace_kprobe, but don't add it to global lists */
> > > >  struct trace_event_call *
> > > >  create_local_trace_kprobe(char *func, void *addr, unsigned long of=
fs,
> > > >=20
> > > > @@ -1709,6 +1752,24 @@ create_local_trace_kprobe(char *func, void
> > > > *addr,
> > > > unsigned long offs,>
> > > >=20
> > > >  	int ret;
> > > >  	char *event;
> > > >=20
> > > > +	if (func) {
> > > > +		unsigned int count;
> > > > +
> > > > +		count =3D number_of_same_symbols(func);
> > > > +		if (count > 1)
> > > > +			/*
> > > > +			 * Users should use addr to remove the ambiguity of
> > > > +			 * using func only.
> > > > +			 */
> > > > +			return ERR_PTR(-EADDRNOTAVAIL);
> > > > +		else if (count =3D=3D 0)
> > > > +			/*
> > > > +			 * We can return ENOENT earlier than when register the
> > > > +			 * kprobe.
> > > > +			 */
> > > > +			return ERR_PTR(-ENOENT);
> > > > +	}
> > > > +
> > > >=20
> > > >  	/*
> > > >  =09
> > > >  	 * local trace_kprobes are not added to dyn_event, so they are ne=
ver
> > > >  	 * searched in find_trace_kprobe(). Therefore, there is no concern
> > > >  	 of
> >=20
> > Best regards.


