Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EB78129D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379384AbjHRSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379371AbjHRSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:12:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557752D70;
        Fri, 18 Aug 2023 11:12:15 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA5A0211F7DD;
        Fri, 18 Aug 2023 11:12:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA5A0211F7DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692382334;
        bh=dgir1jw2peYmuEFv+pMhIkA5g8UguFAY1UNWtSH2v/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh7/DvRq0VHt9C4xEWzrKn4SmxDij2c3jzd46lw68vZ8apz5N6zUDXWN+1q3yM1wq
         GTwcbqg97IdnETJgDrOZ6SHsUJgQ9ZDY+wARvjE5GyP18OhTjoBPBoTOknEyt+DnNZ
         Gr6QFwewSdRDJUO0T04hA1G7Bn0lTcMv1PSIA/r0=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date:   Fri, 18 Aug 2023 20:12:11 +0200
Message-ID: <5702263.DvuYhMxLoT@pwmachine>
In-Reply-To: <20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <2154216.irdbgypaU6@pwmachine> <20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le vendredi 18 ao=FBt 2023, 15:05:37 CEST Masami Hiramatsu a =E9crit :
> On Thu, 17 Aug 2023 13:06:20 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > Le jeudi 17 ao=FBt 2023, 09:50:57 CEST Masami Hiramatsu a =E9crit :
> > > Hi,
> > >=20
> > > On Wed, 16 Aug 2023 18:35:17 +0200
> > >=20
> > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > When using sysfs, it is possible to create kprobe for several kernel
> > > > functions sharing the same name, but of course with different
> > > > addresses,
> > > > by writing their addresses in kprobe_events file.
> > > >=20
> > > > When using PMU, if only the symbol name is given, the event will be
> > > > created for the first address which matches the symbol, as returned=
 by
> > > > kallsyms_lookup_name().
> > >=20
> > > Do you mean probing the same name symbols? Yes, it is intended behavi=
or,
> > > since it is not always true that the same name function has the same
> > > prototype (it is mostly true but is not ensured), it is better to lea=
ve
> > > user to decide which one is what you want to probe.
> >=20
> > This is what I meant.
> > I also share your mind regarding leaving the users deciding which one t=
hey
> > want to probe but in my case (which I agree is a bit a corner one) it
> > leaded me to misunderstanding as the PMU kprobe was only added to the
> > first ntfs_file_write_iter() which is not the one for ntfs3.
>=20
> Hmm, OK. I think in that case (multiple same-name symbols exist) the defa=
ult
> behavior is rejecting with error message. And optionally, it will probe a=
ll
> or them like your patch.

I am not sure to understand.
Can you please precise the default behavior of which software component?

> > > Have you used 'perf probe' tool? It tries to find the appropriate
> > > function
> > > by line number and creates the probe by 'text+OFFSET' style, not by
> > > symbol.
> > > I think this is the correct way to do that, because user will not know
> > > which 'address' of the symbol is what the user want.
> >=20
> > 'perf probe' perfectly does the trick, as it would find all the kernel
> > addresses which correspond to the symbol name and create as many probes=
 as
> > corresponding symbols [1]:
> > root@vm-amd64:~# perf probe --add ntfs_file_write_iter
>=20
> If you can specify the (last part of) file path as below,
>=20
> perf probe --add ntfs_file_write_iter@ntfs3/file.c
>=20
> Then it will choose correct one. :)

Nice! TIL thank you! perf is really powerful!

> > Added new events:
> >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> >=20
> > You can now use it in all perf tools, such as:
> >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> >=20
> > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > p:probe/ntfs_file_write_iter _text+5088544
> > p:probe/ntfs_file_write_iter _text+5278560
> >=20
> > > Thought?
> >=20
> > This contribution is basically here to sort of mimic what perf does but
> > with PMU kprobes, as this is not possible to write in a sysfs file with
> > this type of probe.
>=20
> OK, I see it is for BPF only. Maybe BPF program can filter correct one
> to access the argument etc.

I am not sure I understand, can you please precise?
The eBPF program will be run when the kprobe will be triggered, so if the=20
kprobe is armed for the function (e.g. old ntfs_file_write_iter()), the eBP=
=46=20
program will never be called.

>=20
> Thank you,
>=20
> > > Thank you,
> > >=20
> > > > The idea here is to search all kernel functions which match this
> > > > symbol
> > > > and
> > > > create a trace_kprobe for each of them.
> > > > All these trace_kprobes are linked together by sharing the same
> > > > trace_probe.
> > > >=20
> > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > ---
> > > >=20
> > > >  kernel/trace/trace_kprobe.c | 86
> > > >  +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 86 insertions(+)
> > > >=20
> > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprob=
e.c
> > > > index 1b3fa7b854aa..08580f1466c7 100644
> > > > --- a/kernel/trace/trace_kprobe.c
> > > > +++ b/kernel/trace/trace_kprobe.c
> > > > @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(struct
> > > > trace_kprobe *tk)>
> > > >=20
> > > >  }
> > > > =20
> > > >  #ifdef CONFIG_PERF_EVENTS
> > > >=20
> > > > +
> > > > +struct address_array {
> > > > +	unsigned long *addrs;
> > > > +	size_t size;
> > > > +};
> > > > +
> > > > +static int add_addr(void *data, unsigned long addr)
> > > > +{
> > > > +	struct address_array *array =3D data;
> > > > +	unsigned long *p;
> > > > +
> > > > +	array->size++;
> > > > +	p =3D krealloc(array->addrs,
> > > > +				sizeof(*array->addrs) * array->size,
> > > > +				GFP_KERNEL);
> > > > +	if (!p) {
> > > > +		kfree(array->addrs);
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	array->addrs =3D p;
> > > > +	array->addrs[array->size - 1] =3D addr;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >=20
> > > >  /* create a trace_kprobe, but don't add it to global lists */
> > > >  struct trace_event_call *
> > > >  create_local_trace_kprobe(char *func, void *addr, unsigned long of=
fs,
> > > > =20
> > > >  			  bool is_return)
> > > > =20
> > > >  {
> > > > =20
> > > >  	enum probe_print_type ptype;
> > > >=20
> > > > +	struct address_array array;
> > > >=20
> > > >  	struct trace_kprobe *tk;
> > > >=20
> > > > +	unsigned long func_addr;
> > > > +	unsigned int i;
> > > >=20
> > > >  	int ret;
> > > >  	char *event;
> > > >=20
> > > > @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, void
> > > > *addr,
> > > > unsigned long offs,>
> > > >=20
> > > >  	if (ret < 0)
> > > >  =09
> > > >  		goto error;
> > > >=20
> > > > +	array.addrs =3D NULL;
> > > > +	array.size =3D 0;
> > > > +	ret =3D kallsyms_on_each_match_symbol(add_addr, func, &array);
> > > > +	if (ret)
> > > > +		goto error_free;
> > > > +
> > > > +	if (array.size =3D=3D 1)
> > > > +		goto end;
> > > > +
> > > > +	/*
> > > > +	 * Below loop allocates a trace_kprobe for each function with the
> > > > same
> > > > +	 * name in kernel source code.
> > > > +	 * All this differente trace_kprobes will be linked together thro=
ugh
> > > > +	 * append_trace_kprobe().
> > > > +	 * NOTE append_trace_kprobe() is called in register_trace_kprobe()
> >=20
> > which
> >=20
> > > > +	 * is called when a kprobe is added through sysfs.
> > > > +	 */
> > > > +	func_addr =3D kallsyms_lookup_name(func);
> > > > +	for (i =3D 0; i < array.size; i++) {
> > > > +		struct trace_kprobe *tk_same_name;
> > > > +		unsigned long address;
> > > > +
> > > > +		address =3D array.addrs[i];
> > > > +		/* Skip the function address as we already registered it. */
> > > > +		if (address =3D=3D func_addr)
> > > > +			continue;
> > > > +
> > > > +		/*
> > > > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > > > +		 * this to NULL to allocate this kprobe on the given address.
> > > > +		 */
> > > > +		tk_same_name =3D alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > +						  (void *)address, NULL, offs,
> > > > +						  0 /* maxactive */,
> > > > +						  0 /* nargs */, is_return);
> > > > +
> > > > +		if (IS_ERR(tk_same_name)) {
> > > > +			ret =3D -ENOMEM;
> > > > +			goto error_free;
> > > > +		}
> > > > +
> > > > +		init_trace_event_call(tk_same_name);
> > > > +
> > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > > > +			ret =3D -ENOMEM;
> > > > +			goto error_free;
> > > > +		}
> > > > +
> > > > +		ret =3D append_trace_kprobe(tk_same_name, tk);
> > > > +		if (ret)
> > > > +			goto error_free;
> > > > +	}
> > > > +
> > > > +end:
> > > > +	kfree(array.addrs);
> > > >=20
> > > >  	return trace_probe_event_call(&tk->tp);
> > > >=20
> > > > +error_free:
> > > > +	kfree(array.addrs);
> > > >=20
> > > >  error:
> > > >  	free_trace_kprobe(tk);
> > > >  	return ERR_PTR(ret);
> >=20
> > ---
> > [1]: https://github.com/torvalds/linux/blob/
> > 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-event.c#=
L29
> > 89- L2993




