Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD87874EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbjHXQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbjHXQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:10:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35FD41995;
        Thu, 24 Aug 2023 09:10:03 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3FD92127C69;
        Thu, 24 Aug 2023 09:10:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3FD92127C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692893402;
        bh=Olop74Ds2RRFnMuhvLh1fh38MEe0raHrxEM8ELUBzcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ8CUZ67oSQkysa52iR2no0FMbicRah2q+hauCQibUuhABkuiHNWZIDjVfpQ2Hd1a
         Qhhcwj64S5nFdOdVr22XsqfA3J7cdB0sq1sWL0sL1DST8UIsI/jFodgYk8eDuW6X7N
         h5SSVMUyAzeMEQhPmeDhmKea4sWHEy6qPk+XDcvQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Thu, 24 Aug 2023 18:09:59 +0200
Message-ID: <13333844.uLZWGnKmhe@pwmachine>
In-Reply-To: <20230824234721.1b481cd5d0b8bbc43a24d9a6@kernel.org>
References: <20230824103734.53453-1-flaniel@linux.microsoft.com> <12271275.O9o76ZdvQC@pwmachine> <20230824234721.1b481cd5d0b8bbc43a24d9a6@kernel.org>
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

Le jeudi 24 ao=FBt 2023, 16:47:21 CEST Masami Hiramatsu a =E9crit :
> On Thu, 24 Aug 2023 16:31:13 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > Le jeudi 24 ao=FBt 2023, 15:02:27 CEST Masami Hiramatsu a =E9crit :
> > > On Thu, 24 Aug 2023 12:37:34 +0200
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
> > > > call, because the effectively called one has no kprobes.
> > > >=20
> > > > So, this commit returns EADDRNOTAVAIL when func matches several
> > > > symbols.
> > > > This way, user needs to use addr to remove the ambiguity.
> > >=20
> > > Thanks for update the patch. I have some comments there.
> > >=20
> > > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > Link:
> > > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea74=
2@k
> > > > ern
> > > > el.org/ ---
> > > >=20
> > > >  kernel/trace/trace_kprobe.c | 42
> > > >  +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > >=20
> > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprob=
e.c
> > > > index 23dba01831f7..0c8dd6ba650b 100644
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
> > > > +static unsigned int func_name_several_symbols(char *func_name)
> > >=20
> > > If this returns boolean, please use 'bool' for return type.
> > > Also, I think 'func_name_is_unique()' is more natural.
> >=20
> > This name sounds better but it means it will check count =3D=3D 1.
> > I am fine with it, but please see my below comment.
> >=20
> > > > +{
> > > > +	unsigned int count;
> > > > +
> > > > +	count =3D 0;
> > > > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > > > +
> > > > +	return count > 1;
> > > > +}
> > > > +
> > > >=20
> > > >  static int __trace_kprobe_create(int argc, const char *argv[])
> > > >  {
> > > > =20
> > > >  	/*
> > > >=20
> > > > @@ -836,6 +855,18 @@ static int __trace_kprobe_create(int argc, con=
st
> > > > char
> > > > *argv[])>
> > > >=20
> > > >  		}
> > > >  =09
> > > >  	}
> > > >=20
> > > > +	/*
> > > > +	 * If user specifies KSYM, we check it does not correspond to
> > > > several
> > > > +	 * symbols.
> > > > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the u=
ser
> > > > +	 * he/she should use ADDR rather than KSYM to remove the ambiguit=
y.
> > > > +	 */
> > > > +	if (symbol && func_name_several_symbols(symbol)) {
> > >=20
> > > Then, here  will be
> > >=20
> > > 	if (symbol && !func_name_is_unique(symbol)) {
> >=20
> > I am fine with the above, but it means if users gives an unknown symbol,
> > we
> > will return EADDRNOTAVAIL instead of currently returning ENOENT.
> > Is it OK?
>=20
> Ah, good catch! Hm, then what about 'int number_of_same_symbols()' ?
>=20
>=20
> if (symbol) {
> 	num =3D number_of_same_symbols(symbol);
> 	if (num > 1)
> 		return -EADDRNOTAVAIL;
> 	else if (num =3D=3D 0)
> 		return -ENOENT;
> }

Done in the v3 :D!

> Thank you,
>=20
> > > > +		ret =3D -EADDRNOTAVAIL;
> > > > +
> > > > +		goto error;
> > > > +	}
> > > > +
> > > >=20
> > > >  	trace_probe_log_set_index(0);
> > > >  	if (event) {
> > > >  =09
> > > >  		ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> > > >=20
> > > > @@ -1699,6 +1730,7 @@ static int unregister_kprobe_event(struct
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
> > > > @@ -1709,6 +1741,16 @@ create_local_trace_kprobe(char *func, void
> > > > *addr,
> > > > unsigned long offs,>
> > > >=20
> > > >  	int ret;
> > > >  	char *event;
> > > >=20
> > > > +	/*
> > > > +	 * If user specifies func, we check that function name does not
> > > > +	 * correspond to several symbols.
> > > > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the u=
ser
> > > > +	 * he/she should use addr and offs rather than func to remove the
> > > > +	 * ambiguity.
> > > > +	 */
> > > > +	if (func && func_name_several_symbols(func))
> > >=20
> > > Ditto.
> > >=20
> > > Thanks!
> > >=20
> > > > +		return ERR_PTR(-EADDRNOTAVAIL);
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




