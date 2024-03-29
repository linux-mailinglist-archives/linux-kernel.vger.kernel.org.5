Return-Path: <linux-kernel+bounces-125250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE108922CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30A828759C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B0135A50;
	Fri, 29 Mar 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3TBjf9t"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AC1C0DD4;
	Fri, 29 Mar 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733652; cv=none; b=jODz7Q8xitZhQ6Cv0X7RXMo/5ZQlW8FPpJIrVqczoXFAGRA8gTV2kwAg0VzNrDZ6dEJX6m5EgcADu+Q2VOGeW4GBds1rZYb80627Rg7KAh/Z70t9sjtG+ZX0LUFpA0MpD/LrHl9Hhqn6DfZgj3WDwV4ANNtmfShgAKYPD2rrqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733652; c=relaxed/simple;
	bh=rN4xf0zDMtuqColP7OEpPk0ebkIGdYWeV18RXmJk0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy7UxQWowrNdxEhCn/0QlbPAMrnvwz4AGnH8yftDuw3JNqtF8TixuoddDxMHX4vQ5Mx/KDqL546GJseNO5gnfilc7w/IjzuN/hLnMJDNJGLEfLPJMy/NmjKd6xlMFGEYl8LQ2U8O4jOMGETp+lyIFU/gx1o+GDlwhOF7k39aUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3TBjf9t; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1652161a12.3;
        Fri, 29 Mar 2024 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711733650; x=1712338450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi+EIdc69+DrsUnuOwvzWKLb4fOZw5VOAVZBoh+Tb9Y=;
        b=B3TBjf9tAAV5oC49ymZ5q0XfqQEXP5kPX+IO+mKO0wDUHb6QY/5gV2uBolrbDv6hQg
         5REEWjmjD5/ZwUlLWEy6vCj+bqwy9EFJFvrxWpmbpupjuU22/gLAe1RzYamt+uDeXbkN
         5SSILfW3S+N4Y9THCYVIHqzTS5O5Wu+W4ujapwl9YFCRGOPuxU519GaT2pYPmQ/gpdYT
         ahLL4uTIGGK68wVksT5Q1x17FNH61g9uKVZQtgnFyhR1FLLkuHTnee/jmeajc41eRNdw
         1EATpfOd1ZWMqoWXsTygdjGZ+BR9H3tLTNUfswVIYKRWVx3uLbIzHXOlnmJjBLS9cqLi
         DbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733650; x=1712338450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi+EIdc69+DrsUnuOwvzWKLb4fOZw5VOAVZBoh+Tb9Y=;
        b=W+WNf0uO3Akpoy3UqRg30Fs1lPjfwK5Oi1vF1FBAIW7h0UP7ZPpIYJPHJOU36fXzgB
         sQM4OhqDl0zYEsIQQNvVQJtgkSAgGCX+r2iI5UPvK7Q2XmDHajOPg9hqBehbcvKLhmco
         74slg/4iNp+DmmcMTr01yPsh1nbkLDpCWj6DQVgsGWrqS6XXbDJYPkv2hJYAm5Sji+Ov
         Q1RWAKi+ByMi4kpH6y2UvFtG7LCFjBdRgFMJm/keAV5Pa3qXxarNVelltDYxDRSq/EN4
         nER1OoB280Sy8au+XpEb5PsR5c+7SuDk04VdSWt5Oe3/5lSPDzmOyYH0cJi9r0OTmlSw
         tskQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESd4Hr7cP87wHR4f4iiupBEX+heB4aefjlNHRO00NpBV8pSmidUkTXJWsl5wY49FI8fQklzGtkg5sCM5clRmtJRgi7gbwi4DAjs7OE52ZFSvC9Q9YPs5/NqQ1NrhrQ3ktVFm3V6HG2PCKpa4oLOWaxDDRZ+Y8tY0cZEAkhlWkHiGoPNH9qznbijx5CG2ZAicoqBH1DziHxVlSlz/MrtxNJIAQz/5Gsw==
X-Gm-Message-State: AOJu0Ywpm/95Qnj/Xhj80EvVDZWEwS6ob77Jgzlia7r5xAjxmUDIkz9v
	oci6sA52geUYXRjVbRYu5HkyrMvZ7zKT2b1YkNaQGKm1KoKVrvkbtzZnxYxLgBeEPxDYF/84mSk
	fAZfmDC8Iq+aX0HXovk8FO/OGMAc=
X-Google-Smtp-Source: AGHT+IFD455eZc5DVwGdagIHFHdn/JrgCPhE7LOCLBgp2sa0HE1dhhzUCjzMRVPdgd69zuEHdTXxc22vk6ihrPYmT2U=
X-Received: by 2002:a17:90a:c10:b0:2a2:2fd:8bd8 with SMTP id
 16-20020a17090a0c1000b002a202fd8bd8mr3007695pjs.15.1711733650501; Fri, 29 Mar
 2024 10:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org> <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org> <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org> <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 10:33:57 -0700
Message-ID: <CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonthan Haslam <jonathan.haslam@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 5:18=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel=
org> wrote:
> >
> > On Wed, 27 Mar 2024 17:06:01 +0000
> > Jonthan Haslam <jonathan.haslam@gmail.com> wrote:
> >
> > > > > Masami,
> > > > >
> > > > > Given the discussion around per-cpu rw semaphore and need for
> > > > > (internal) batched attachment API for uprobes, do you think you c=
an
> > > > > apply this patch as is for now? We can then gain initial improvem=
ents
> > > > > in scalability that are also easy to backport, and Jonathan will =
work
> > > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > > suggested by Ingo.
> > > >
> > > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > > I would like to wait for the next version.
> > >
> > > My initial tests show a nice improvement on the over RW spinlocks but
> > > significant regression in acquiring a write lock. I've got a few days
> > > vacation over Easter but I'll aim to get some more formalised results=
 out
> > > to the thread toward the end of next week.
> >
> > As far as the write lock is only on the cold path, I think you can choo=
se
> > per-cpu RW semaphore. Since it does not do busy wait, the total system
> > performance impact will be small.
>
> No, Masami, unfortunately it's not as simple. In BPF we have BPF
> multi-uprobe, which can be used to attach to thousands of user
> functions. It currently creates one uprobe at a time, as we don't
> really have a batched API. If each such uprobe registration will now
> take a (relatively) long time, when multiplied by number of attach-to
> user functions, it will be a horrible regression in terms of
> attachment/detachment performance.
>
> So when we switch to per-CPU rw semaphore, we'll need to provide an
> internal batch uprobe attach/detach API to make sure that attaching to
> multiple uprobes is still fast.
>
> Which is why I was asking to land this patch as is, as it relieves the
> scalability pains in production and is easy to backport to old
> kernels. And then we can work on batched APIs and switch to per-CPU rw
> semaphore.
>
> So I hope you can reconsider and accept improvements in this patch,
> while Jonathan will keep working on even better final solution.
> Thanks!
>
> > I look forward to your formalized results :)
> >

BTW, as part of BPF selftests, we have a multi-attach test for uprobes
and USDTs, reporting attach/detach timings:
$ sudo ./test_progs -v -t uprobe_multi_test/bench
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
test_bench_attach_uprobe: attached in   0.120s
test_bench_attach_uprobe: detached in   0.092s
#400/5   uprobe_multi_test/bench_uprobe:OK
test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
test_bench_attach_usdt:PASS:usdt_count 0 nsec
test_bench_attach_usdt: attached in   0.124s
test_bench_attach_usdt: detached in   0.064s
#400/6   uprobe_multi_test/bench_usdt:OK
#400     uprobe_multi_test:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
Successfully unloaded bpf_testmod.ko.

So it should be easy for Jonathan to validate his changes with this.

> > Thank you,
> >
> > >
> > > Jon.
> > >
> > > >
> > > > Thank you,
> > > >
> > > > >
> > > > > >
> > > > > > BTW, how did you measure the overhead? I think spinlock overhea=
d
> > > > > > will depend on how much lock contention happens.
> > > > > >
> > > > > > Thank you,
> > > > > >
> > > > > > >
> > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > >
> > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > > ---
> > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.=
c
> > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree =3D RB_R=
OOT;
> > > > > > >   */
> > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > > >
> > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rb=
tree access */
> > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rb=
tree access */
> > > > > > >
> > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct =
inode *inode, loff_t offset)
> > > > > > >  {
> > > > > > >       struct uprobe *uprobe;
> > > > > > >
> > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > >       uprobe =3D __find_uprobe(inode, offset);
> > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > >
> > > > > > >       return uprobe;
> > > > > > >  }
> > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struc=
t uprobe *uprobe)
> > > > > > >  {
> > > > > > >       struct uprobe *u;
> > > > > > >
> > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > >       u =3D __insert_uprobe(uprobe);
> > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > >
> > > > > > >       return u;
> > > > > > >  }
> > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *=
uprobe)
> > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > >               return;
> > > > > > >
> > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_activ=
e() */
> > > > > > >       put_uprobe(uprobe);
> > > > > > >  }
> > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct ino=
de *inode,
> > > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > > >       max =3D min + (end - start) - 1;
> > > > > > >
> > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > > >       if (n) {
> > > > > > >               for (t =3D n; t; t =3D rb_prev(t)) {
> > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct ino=
de *inode,
> > > > > > >                       get_uprobe(u);
> > > > > > >               }
> > > > > > >       }
> > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > >  }
> > > > > > >
> > > > > > >  /* @vma contains reference counter, not the probed instructi=
on. */
> > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *=
vma, unsigned long start, unsigned long e
> > > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > > >       max =3D min + (end - start) - 1;
> > > > > > >
> > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > >
> > > > > > >       return !!n;
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

