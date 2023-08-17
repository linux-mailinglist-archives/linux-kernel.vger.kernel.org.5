Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB377F49E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350090AbjHQK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350128AbjHQK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:59:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D98A2D71;
        Thu, 17 Aug 2023 03:59:34 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5CC8211F7AC;
        Thu, 17 Aug 2023 03:59:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5CC8211F7AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692269973;
        bh=XYAu3PU0hi09EaHGm5pCzY46YMbfZd395y09qNxIEvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN28jNKE3EtpWKwxq79YlaKJFwZb5oytxI4UqTL4SC3P6xqERzh1MQgWUGc8GKxHs
         ZdRfTr91iSaJj73Skw6dfS2DWt1S8dwaHS7HYmhr0TpcvVHFjU6oMz2Dx41/6O2Mac
         H34LKf08GokPuOHi/C53XN+zDePKTExnh6UXkhEk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date:   Thu, 17 Aug 2023 12:59:30 +0200
Message-ID: <4852847.31r3eYUQgx@pwmachine>
In-Reply-To: <20230816144213.0f24cc62@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <20230816163517.112518-2-flaniel@linux.microsoft.com> <20230816144213.0f24cc62@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 16 ao=FBt 2023, 20:42:13 CEST Steven Rostedt a =E9crit :
> On Wed, 16 Aug 2023 18:35:17 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > When using sysfs, it is possible to create kprobe for several kernel
> > functions sharing the same name, but of course with different addresses,
> > by writing their addresses in kprobe_events file.
>=20
> So this only happens if you write in the address?

=46rom my understanding yes, but I will double check just in case.

> > When using PMU, if only the symbol name is given, the event will be
> > created for the first address which matches the symbol, as returned by
> > kallsyms_lookup_name().
> > The idea here is to search all kernel functions which match this symbol
> > and
> > create a trace_kprobe for each of them.
> > All these trace_kprobes are linked together by sharing the same
> > trace_probe.
> So this makes the PMU version enable all by name, so there's still a
> disconnect between how sysfs works and how PMU does.
>=20
> Why can't you just pass in the address like sysfs does?

To get the addresses from /proc/kallsyms, you need to either have CAP_SYSLO=
G=20
or even CAP_SYS_ADMIN.
But to call perf_event_open(), you only need CAP_PERFMON.
This way, by giving only the name you can trace function with less privileg=
es=20
(i.e. without CAP_SYS_ADMIN).
Please correct me if I am wrong as I am not an expert in knowing the minima=
l=20
set of capabilities you need to trace.

> -- Steve
>=20
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > ---
> >=20
> >  kernel/trace/trace_kprobe.c | 86 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >=20
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 1b3fa7b854aa..08580f1466c7 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(struct
> > trace_kprobe *tk)>=20
> >  }
> > =20
> >  #ifdef CONFIG_PERF_EVENTS
> >=20
> > +
> > +struct address_array {
> > +	unsigned long *addrs;
> > +	size_t size;
> > +};
> > +
> > +static int add_addr(void *data, unsigned long addr)
> > +{
> > +	struct address_array *array =3D data;
> > +	unsigned long *p;
> > +
> > +	array->size++;
> > +	p =3D krealloc(array->addrs,
> > +				sizeof(*array->addrs) * array->size,
> > +				GFP_KERNEL);
> > +	if (!p) {
> > +		kfree(array->addrs);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	array->addrs =3D p;
> > +	array->addrs[array->size - 1] =3D addr;
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >  /* create a trace_kprobe, but don't add it to global lists */
> >  struct trace_event_call *
> >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > =20
> >  			  bool is_return)
> > =20
> >  {
> > =20
> >  	enum probe_print_type ptype;
> >=20
> > +	struct address_array array;
> >=20
> >  	struct trace_kprobe *tk;
> >=20
> > +	unsigned long func_addr;
> > +	unsigned int i;
> >=20
> >  	int ret;
> >  	char *event;
> >=20
> > @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, void *addr,
> > unsigned long offs,>=20
> >  	if (ret < 0)
> >  =09
> >  		goto error;
> >=20
> > +	array.addrs =3D NULL;
> > +	array.size =3D 0;
> > +	ret =3D kallsyms_on_each_match_symbol(add_addr, func, &array);
> > +	if (ret)
> > +		goto error_free;
> > +
> > +	if (array.size =3D=3D 1)
> > +		goto end;
> > +
> > +	/*
> > +	 * Below loop allocates a trace_kprobe for each function with the same
> > +	 * name in kernel source code.
> > +	 * All this differente trace_kprobes will be linked together through
> > +	 * append_trace_kprobe().
> > +	 * NOTE append_trace_kprobe() is called in register_trace_kprobe()=20
which
> > +	 * is called when a kprobe is added through sysfs.
> > +	 */
> > +	func_addr =3D kallsyms_lookup_name(func);
> > +	for (i =3D 0; i < array.size; i++) {
> > +		struct trace_kprobe *tk_same_name;
> > +		unsigned long address;
> > +
> > +		address =3D array.addrs[i];
> > +		/* Skip the function address as we already registered it. */
> > +		if (address =3D=3D func_addr)
> > +			continue;
> > +
> > +		/*
> > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > +		 * this to NULL to allocate this kprobe on the given address.
> > +		 */
> > +		tk_same_name =3D alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > +						  (void *)address, NULL, offs,
> > +						  0 /* maxactive */,
> > +						  0 /* nargs */, is_return);
> > +
> > +		if (IS_ERR(tk_same_name)) {
> > +			ret =3D -ENOMEM;
> > +			goto error_free;
> > +		}
> > +
> > +		init_trace_event_call(tk_same_name);
> > +
> > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > +			ret =3D -ENOMEM;
> > +			goto error_free;
> > +		}
> > +
> > +		ret =3D append_trace_kprobe(tk_same_name, tk);
> > +		if (ret)
> > +			goto error_free;
> > +	}
> > +
> > +end:
> > +	kfree(array.addrs);
> >=20
> >  	return trace_probe_event_call(&tk->tp);
> >=20
> > +error_free:
> > +	kfree(array.addrs);
> >=20
> >  error:
> >  	free_trace_kprobe(tk);
> >  	return ERR_PTR(ret);




