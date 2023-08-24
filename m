Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497D878718B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjHXObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjHXObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:31:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 874D2193;
        Thu, 24 Aug 2023 07:31:17 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 01DFF2127C82;
        Thu, 24 Aug 2023 07:31:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01DFF2127C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692887477;
        bh=61ICIakGF6sK32UmdQ+e62JH2BHe9zBGVoTWqkCNx3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+MKGEeTjDNJVpbzDr7sNF82lF/Re2GA2IV4jQi7enKyDbV2QovfSKEUUHxyWpMKO
         vqh8agHw7Iga0jWu5wblyjWCR4FG+4qzdQaBesr4fy3JxritHMPV04FAgw92IvV47w
         IL3NnuACLxYFIGHQ89PpQc5X1VXGD41xUKSVG0co=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Thu, 24 Aug 2023 16:31:13 +0200
Message-ID: <12271275.O9o76ZdvQC@pwmachine>
In-Reply-To: <20230824220227.01c367c1d7b6219a79cf2843@kernel.org>
References: <20230824103734.53453-1-flaniel@linux.microsoft.com> <20230824103734.53453-2-flaniel@linux.microsoft.com> <20230824220227.01c367c1d7b6219a79cf2843@kernel.org>
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

Hi.

Le jeudi 24 ao=FBt 2023, 15:02:27 CEST Masami Hiramatsu a =E9crit :
> On Thu, 24 Aug 2023 12:37:34 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Previously to this commit, if func matches several symbols, a kprobe,
> > being
> > either sysfs or PMU, would only be installed for the first matching
> > address. This could lead to some misunderstanding when some BPF code was
> > never called because it was attached to a function which was indeed not
> > call, because the effectively called one has no kprobes.
> >=20
> > So, this commit returns EADDRNOTAVAIL when func matches several symbols.
> > This way, user needs to use addr to remove the ambiguity.
>=20
> Thanks for update the patch. I have some comments there.
>=20
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > Link:
> > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@ke=
rn
> > el.org/ ---
> >=20
> >  kernel/trace/trace_kprobe.c | 42 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >=20
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 23dba01831f7..0c8dd6ba650b 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -705,6 +705,25 @@ static struct notifier_block trace_kprobe_module_n=
b =3D
> > {>=20
> >  	.priority =3D 1	/* Invoked after kprobe module callback */
> > =20
> >  };
> >=20
> > +static int count_symbols(void *data, unsigned long unused)
> > +{
> > +	unsigned int *count =3D data;
> > +
> > +	(*count)++;
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned int func_name_several_symbols(char *func_name)
>=20
> If this returns boolean, please use 'bool' for return type.
> Also, I think 'func_name_is_unique()' is more natural.
>=20

This name sounds better but it means it will check count =3D=3D 1.
I am fine with it, but please see my below comment.

> > +{
> > +	unsigned int count;
> > +
> > +	count =3D 0;
> > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > +
> > +	return count > 1;
> > +}
> > +
> >=20
> >  static int __trace_kprobe_create(int argc, const char *argv[])
> >  {
> > =20
> >  	/*
> >=20
> > @@ -836,6 +855,18 @@ static int __trace_kprobe_create(int argc, const c=
har
> > *argv[])>=20
> >  		}
> >  =09
> >  	}
> >=20
> > +	/*
> > +	 * If user specifies KSYM, we check it does not correspond to several
> > +	 * symbols.
> > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> > +	 * he/she should use ADDR rather than KSYM to remove the ambiguity.
> > +	 */
> > +	if (symbol && func_name_several_symbols(symbol)) {
>=20
> Then, here  will be
>=20
> 	if (symbol && !func_name_is_unique(symbol)) {
>=20

I am fine with the above, but it means if users gives an unknown symbol, we=
=20
will return EADDRNOTAVAIL instead of currently returning ENOENT.
Is it OK?

> > +		ret =3D -EADDRNOTAVAIL;
> > +
> > +		goto error;
> > +	}
> > +
> >=20
> >  	trace_probe_log_set_index(0);
> >  	if (event) {
> >  =09
> >  		ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> >=20
> > @@ -1699,6 +1730,7 @@ static int unregister_kprobe_event(struct
> > trace_kprobe *tk)>=20
> >  }
> > =20
> >  #ifdef CONFIG_PERF_EVENTS
> >=20
> > +
> >=20
> >  /* create a trace_kprobe, but don't add it to global lists */
> >  struct trace_event_call *
> >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> >=20
> > @@ -1709,6 +1741,16 @@ create_local_trace_kprobe(char *func, void *addr,
> > unsigned long offs,>=20
> >  	int ret;
> >  	char *event;
> >=20
> > +	/*
> > +	 * If user specifies func, we check that function name does not
> > +	 * correspond to several symbols.
> > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> > +	 * he/she should use addr and offs rather than func to remove the
> > +	 * ambiguity.
> > +	 */
> > +	if (func && func_name_several_symbols(func))
>=20
> Ditto.
>=20
> Thanks!
>=20
> > +		return ERR_PTR(-EADDRNOTAVAIL);
> > +
> >=20
> >  	/*
> >  =09
> >  	 * local trace_kprobes are not added to dyn_event, so they are never
> >  	 * searched in find_trace_kprobe(). Therefore, there is no concern of

Best regards.


