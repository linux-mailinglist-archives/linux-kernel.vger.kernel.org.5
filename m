Return-Path: <linux-kernel+bounces-87904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9986DAE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B75287889
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE155026C;
	Fri,  1 Mar 2024 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvJqmOA+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F7405FE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269382; cv=none; b=JCgIFWgX9u7FrmZunO0CnFIAIPY73QlkOWfsSzc8cbUlopLLhxYSu6KnPcgELifXD41Fm0xAZ1TNDp9NfOyh0ZAULTB/S7JUqQpSVN9wyYDRBJxzgVIitSucxMzth9VNrqe0SDmk4iD2eyiJG+Z/JxJAjPZnGgdkUsXKWKkzoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269382; c=relaxed/simple;
	bh=yUvFzWM+HJXyLOAC7y66wSXyf4xTtJ7HUVaTx3YpCFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h62zgL2pZpbfgqimtSE8P8jRkfHo15N6pwT6xCtgyYyWa73Sgoaa+SbBThKO9AuDN1i5QY9xm0poSaLN3C7b1vyX2XkRZzQpTYSds17WCMG4huJ6wv0w9xfb8NIcyU019QBdjv9MQcdUN5xrc1t/1/9DvnqhGEDNeypUydyErEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvJqmOA+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcd07252d9so55525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709269380; x=1709874180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJCI+26zIfGoqoxPqGF/3KXwVzFCjuGI+FsZrZUdpyE=;
        b=jvJqmOA+NjvShZqj4OFXPcoaR4NljMuAzZRJI4qU1skcDbPuJasJEM6dNfUb5qVFu5
         kBGkiFEGgN2DW3Odc9EkoQ5VzhWnWRLZZ8BatjqzBFA7kSnf2VN8SzJ7PJTvn7hbZDuI
         pnXBDTVUH0Tvh4CaY0LlfMPJwasvLl0O9fk1LTxgfXNBm2wguZwx0I1O8NtERe90Blk+
         v7Lc+8yx0I2zP/hBEEpsORkHVdEVMRO2/LGmtb0JlorgZlpD8gQf/omxDSszEM5Q918k
         nwFUrCOMdRKoNeXSu2Y0hm+PCVCuQMFsb+uG3LWWtx8rgXUFQvDOgvCjR98CrfRBjbx/
         O+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709269380; x=1709874180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJCI+26zIfGoqoxPqGF/3KXwVzFCjuGI+FsZrZUdpyE=;
        b=r5IUZBImP4R0PBsaoIkFaf5w8rEnifD1VcPxUT4D309uHBeB47BATBu4pxDC/a3hgl
         f8KiKnVslhAgHJcT3u8Ov9ek2Z7zmfMS4EM5/5LFkYVGiHmOGU+VCBXu1E6tQumV59wm
         Q5qlNueOcPXUqEtqE5WogLgU5eXNdheG39BQSE5vc7SCBDyRu1fCgFnlDCJ8mO79TyOG
         2HcLnNiCHOnfGuMaXBtLk6tHlW2107b9hLH4UevbbCRhHMqNwHBH4wdYR8f65W/9lkKm
         tXqB2dtV1Cg4ptjrnNm/yar7ekzeXtdwo33EyDQoC6RrCxXbf8g1CY3lHTGq3mWRkpC7
         j/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH0mYeJ1xsRbRWAw66SBHX+o5w8xFDjtJINyoA7Ajz27apABIHOr9DRcJrmE05bQo2IxBx3OqirVVSqKmqkxHVYkjn8KtakE2wUiOo
X-Gm-Message-State: AOJu0Yw+zA2zfqBAKgQjMJyW/ZXZrx9OpUNQbY6YCf8NRvQWZt6pw0RL
	5BEM78g7dzUhn4Xi1OIORxXafIZvk4RGmxwRTY9ROuWYj0+i1ngzhqzsG6N1yjJb1LB+4Q+nM1g
	pbktJLyqU3b/iO71u8tbp2tjYaK9l4hMhCUAf
X-Google-Smtp-Source: AGHT+IGFzadOowQIy/Sa/Ec/9HPST0VW1lGI8Jdl7GpPOSJ1uOTsiucmWmZG0Hnnb7JHLQowSSUfftsvaCzY+Bw+fQc=
X-Received: by 2002:a17:902:ced0:b0:1dc:c779:5537 with SMTP id
 d16-20020a170902ced000b001dcc7795537mr122788plg.4.1709269380271; Thu, 29 Feb
 2024 21:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com> <20240229063253.561838-5-irogers@google.com>
 <CAM9d7cj9CgxmvSMLvDa=RM8zPRJpRbKqMkU7_B68HwEX7qo=hg@mail.gmail.com>
In-Reply-To: <CAM9d7cj9CgxmvSMLvDa=RM8zPRJpRbKqMkU7_B68HwEX7qo=hg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 21:02:45 -0800
Message-ID: <CAP-5=fWpnrLAo3yB6SAxDHjzWNMYcAPdq0RHgs_C11Y5dY6ZeQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] perf machine: Move machine's threads into its own abstraction
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 28, 2024 at 10:33=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Move thread_rb_node into the machine.c file. This hides the
> > implementation of threads from the rest of the code allowing for it to
> > be refactored.
> >
> > Locking discipline is tightened up in this change. As the lock is now
> > encapsulated in threads, the findnew function requires holding it (as
> > it already did in machine). Rather than do conditionals with locks
> > based on whether the thread should be created (which could potentially
> > be error prone with a read lock match with a write unlock), have a
> > separate threads__find that won't create the thread and only holds the
> > read lock. This effectively duplicates the findnew logic, with the
> > existing findnew logic only operating under a write lock assuming
> > creation is necessary as a previous find failed. The creation may
> > still fail with the write lock due to another thread. The duplication
> > is removed in a later next patch that delegates the implementation to
> > hashtable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks for doing this!  A nit below..
>
> > ---
> [SNIP]
> > @@ -3228,27 +3258,31 @@ int thread__resolve_callchain(struct thread *th=
read,
> >         return ret;
> >  }
> >
> > -int machine__for_each_thread(struct machine *machine,
> > -                            int (*fn)(struct thread *thread, void *p),
> > -                            void *priv)
> > +int threads__for_each_thread(struct threads *threads,
> > +                            int (*fn)(struct thread *thread, void *dat=
a),
> > +                            void *data)
> >  {
> > -       struct threads *threads;
> > -       struct rb_node *nd;
> > -       int rc =3D 0;
> > -       int i;
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +               struct rb_node *nd;
> >
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               threads =3D &machine->threads[i];
> > -               for (nd =3D rb_first_cached(&threads->entries); nd;
> > -                    nd =3D rb_next(nd)) {
> > +               for (nd =3D rb_first_cached(&table->entries); nd; nd =
=3D rb_next(nd)) {
> >                         struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > +                       int rc =3D fn(trb->thread, data);
> >
> > -                       rc =3D fn(trb->thread, priv);
> >                         if (rc !=3D 0)
> >                                 return rc;
> >                 }
> >         }
> > -       return rc;
> > +       return 0;
>
> Don't we need locking in this function?

I thought there was a deadlock, but I was either mistaken or now it is
resolved. I'll add in the read lock as you say.

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> > +
> > +}
> > +
> > +int machine__for_each_thread(struct machine *machine,
> > +                            int (*fn)(struct thread *thread, void *p),
> > +                            void *priv)
> > +{
> > +       return threads__for_each_thread(&machine->threads, fn, priv);
> >  }
> >

