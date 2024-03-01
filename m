Return-Path: <linux-kernel+bounces-87730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227586D849
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363581C2095A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D780B;
	Fri,  1 Mar 2024 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEAjVP/3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0717E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252368; cv=none; b=Poat7WbTKJGR/JH1JHP2rqam+VP5JuP0ijld/59uhlJFEPFjv4b47K+BuvEfE/iGbywf+r/nQGdRswDDt31ZLtwY9tMaCr4BdsPC+qB/jgSEn2u4eyhX/Fmp9fkZxOqqNlTsF5dOmQgsFhDRdVSQqd8v2Mu8nFRWb92YdX/nAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252368; c=relaxed/simple;
	bh=7oaRx7txOLY5lh/ghksCzjvbdA7i/vJfUT0jQTEBt2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5KDdr3PX7wwUV1ysDKpImXsVYGp7whdjnSfjUxZwWr9m4x//GmcIIVni5Au7zeS06N9yfKuSn2bk+2izcf9Q+01aSsh8z/Kv/fAG8t/1nkXfOHgax5pvv+hiuWINY7BRzZtqEeTjNCaiZ2quEvFJRIPYZ9MTGR3F8onfNqE3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEAjVP/3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbe7e51f91so24005ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709252367; x=1709857167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UWpBAgUjQGEcDfT6+E949LPPMhHm1UHzIqySFkY11k=;
        b=NEAjVP/3lxBxNeGI51nhHxu7G41cEIy8va/gHYs61xSjqwHrWSxhthvcLYrWniZrqc
         ATRet53Ni8hZ/O8CZKXaM6yfYFFV+ungVLGxVXn4vRo43uynlS59P+bmQxcxCt86llvl
         kAmQq9OdEyMIS2+++6X7aWvljiWKuOj9bRI+3FPuLcsaN0TSKOrUs90OFU6m09OgqSe/
         wipTBNL6vfrm2iAyYNSt34I4cMPOLxf1Fi7YAyPHXatC7Ibaomtv1daJun9odZSRIpas
         wmj9QXKQCW/ypOiHyKPaROgPbdYiP3uVsZmrhP/MiR2lEHGSS8y0MGfwJzn/4XnqI/7e
         2njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252367; x=1709857167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UWpBAgUjQGEcDfT6+E949LPPMhHm1UHzIqySFkY11k=;
        b=WPqfP5BDJ72yOxlfI9ecGR21HrdLSe+O51/CI5Hs9H4Sh1v1M5fH5ao1iR2UbqFZXz
         XED49d9AhViKFlZhuuUUXERyCr1ddMxuR72HiHNvJFOvi8dbuhCLINKZjWUFWhAT3fnY
         ITSHe+vPqPAG6e8cdJycXhdKDtmQeRvJTO1jf5Vr+Y+6sGXBKxDWEEIJAK9y8LYWSGHF
         ETrgSG+KEan46rhAGirA7LVE1V0Y80O0dubtz/wPtyXLJbga4rS5amkbrmxskKXqMiEg
         frpCL4mZgmKyoKup27LXdnFGS3J6v1BiEQ0uxN9x/ONuG+WemE8SNF5NQwrFxSHgb6rj
         TR5g==
X-Forwarded-Encrypted: i=1; AJvYcCVQBDwtI29Zu4gZYgX/ml0Cfn8yRrTjoCLzqj35LBv4U3JXjdNDU5SYB8ZCkfsbBQTK8UkM+SMkxzlCY9zFiOrwIaxgM+z2Ay/eWN8S
X-Gm-Message-State: AOJu0YxeCLos2M5VRUOdrSL5OsayWaM4/taDtXJ1SgkcH/KSX9ND5zWq
	A60/RfSo87c8OZ+5X19tC/s9+zyzJwenlMzpalEtERZHq17MbAivFaFn8QorI9BwO0v0nSjDE9M
	6MdoST2HsiPtOQ6JjQzgexOtmY6jgEMgBAAZl
X-Google-Smtp-Source: AGHT+IG+krEZg1W4lxxNiq3BuiCY53h8CWBR5bxCp6JLwaMIKWJDGBm2DvjENztc4Nf5wogg1bUBirKz0SR/4ekNyeo=
X-Received: by 2002:a17:902:db0d:b0:1dc:6cf4:5908 with SMTP id
 m13-20020a170902db0d00b001dc6cf45908mr80892plx.6.1709252366428; Thu, 29 Feb
 2024 16:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com> <b60c7731b8a84e01a77fea55c31a77b9@AcuMS.aculab.com>
In-Reply-To: <b60c7731b8a84e01a77fea55c31a77b9@AcuMS.aculab.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 16:19:11 -0800
Message-ID: <CAP-5=fUGTZXQv28+v-t1mhFyWb9BuxRzCD+N4WTU0=hTqv+xLA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: David Laight <David.Laight@aculab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:59=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Ian Rogers
> > Sent: 27 February 2024 07:24
> >
> > On Mon, Feb 26, 2024 at 11:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Move threads out of machine and move thread_rb_node into the C
> > > > file. This hides the implementation of threads from the rest of the
> > > > code allowing for it to be refactored.
> > > >
> > > > Locking discipline is tightened up in this change.
> > >
> > > Doesn't look like a simple code move.  Can we split the locking
> > > change from the move to make the reviewer's life a bit easier? :)
> >
> > Not sure I follow. Take threads_nr as an example.
> >
> > The old code is in machine.c, so:
> > -static size_t machine__threads_nr(const struct machine *machine)
> > -{
> > -       size_t nr =3D 0;
> > -
> > -       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > -               nr +=3D machine->threads[i].nr;
> > -
> > -       return nr;
> > -}
> >
> > The new code is in threads.c:
> > +size_t threads__nr(struct threads *threads)
> > +{
> > +       size_t nr =3D 0;
> > +
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               down_read(&table->lock);
> > +               nr +=3D table->nr;
> > +               up_read(&table->lock);
> > +       }
> > +       return nr;
> > +}
> >
> > So it is a copy paste from one file to the other. The only difference
> > is that the old code failed to take a lock when reading "nr" so the
> > locking is added. I wanted to make sure all the functions in threads.c
> > were properly correct wrt locking, semaphore creation and destruction,
> > etc.  We could have a broken threads.c and fix it in the next change,
> > but given that's a bug it could make bisection more difficult.
> > Ultimately I thought the locking changes were small enough to not
> > warrant being on their own compared to the advantages of having a sane
> > threads abstraction.
>
> The lock is pretty much entirely pointless.
> All it really does is slow the code down.
> The most you could want is:
>         nr +=3D READ_ONCE(table->nr);
> to avoid any hypothetical data tearing.

Completely agreed, but as this is user space code I'm unclear on
thread sanitizer support for READ_ONCE. The code is also only called
in debug statements. The migration to a hashmap in the later patches
means the complexity of taking the lock is more justified, although
we're using libbpf's hashmap that has a size variable.

Thanks,
Ian

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

