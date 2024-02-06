Return-Path: <linux-kernel+bounces-55734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590584C0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92158286898
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3061CABD;
	Tue,  6 Feb 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY2jbs2a"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8961CD1E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262574; cv=none; b=mOIzESsbigcfXOwQ68r/hCsN0463q8tpZizGj6dWvmAhKEn937UE7NoQwmY2i855YR5XqLOBwfubpZ9uMHzX+bo/BGFnKe6hdCKkDYrB7gUI/61TYon2nq//+Gqty6ZOgXdk9Bm8mpUL7cwCMltDevZxobbqjEYaPVzHBh4oKdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262574; c=relaxed/simple;
	bh=bT8iSDQ7VIIkJ0SalPInfLv65CJM5qhL0227zSPb0uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTcB4qUJyAnsAQvy8N+OhvdGycGMzw8pZGw8QR3p9bZPlv7mnW5wPT2tml0oCoLmq7zydjSId37olNKN1NwgE6vXeTQlysto7DXk8BSvildDVCkosgpM9nE4TQNXGl+TWUTJKkCzxl/lVWqDCTVCgKCBF0iu1+F+OyPSCPzeMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY2jbs2a; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93b982761so98905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707262572; x=1707867372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xi1hqRLQYsZ7IksfZ2m5n0Ha2D4yNJBsDeETYfat3Y=;
        b=xY2jbs2awvqTI+zdITKVPR3nf/vmnNUtySSS9btOdLoqnNKM3d1fQBVDcAnNDRKhnz
         r5549pmIACd2nT8vimA1KTLW6iPC2FDGz8QCE744rVCDDc4EbhZfnjipjOp4AMF67IoQ
         ymgMUpcsp17e4rj+qYPE6ZHI26EnG3Ld1xceSPiFoxISkSSaTygRlcVClV0cliTHvmOk
         1u/dkrRTGow/kq5s0WJsJ3wwsf9hYwIWHgs9/NKWBaR0ck+dYNoHtUiyQ+Hjf0dNoAXm
         GVvKPMAhh/jM8YxrsXD948YWP+Fpkd7ONKoopq94+GyW75VwoO7RiVdiN8+9Rd7vLWXF
         6oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262572; x=1707867372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xi1hqRLQYsZ7IksfZ2m5n0Ha2D4yNJBsDeETYfat3Y=;
        b=WO5PZYyJCxcU6REg6OWS1R1H1HKqWuCaFz6GZnuAQmkI36bM04RjFReuCxP2n2OEcf
         R6YCMQtQMQGZBr75QUsVGQbWwm8FFklXKFKGxCp/ZFRQoFZbB/+ouiZltIVaBLy8he4g
         0jvIwl/VcMjDhqyeeiQeSNe+YBQOItz9KiaVjHELLRy6wj3us7JlGB7khHI6W5T4IGu3
         Pv+FF7DX8MZger3dm3Nm7aCqF8/30Hez/ZXeA62QVnZbE65dAEMhexWKSw95kfRh0Cfp
         pKZ8jt9oHpRF6b9nqaKKqDxaekBuDsSnchh9qEz6x3Xwkbm8dZARZLEMfxXe458RC0P0
         dS6A==
X-Gm-Message-State: AOJu0YxZiGErzpG3rau+a9s3S8riyDr5AW81BA4sYgD3tNfdzix5OW/h
	Bg5BGPXaaSn7Ucvn29LQG9tFMlgQdnDGvOE2dscutAd8Xvwc4ZyVTxdpFY1XJ0L0MYZ+fn0oLuK
	U8Gw96zAm/x59WHwMY0UgP6q8f+u394cFsvZw
X-Google-Smtp-Source: AGHT+IHUaiRg0gv0A4PhdoXFVOz9ohKuZkpJ/MI21N+l3SsCRsghs2NzEr8ElhMb20dBHkuxfNLL5As+po3JgE65Kfg=
X-Received: by 2002:a17:902:db06:b0:1d8:d225:699d with SMTP id
 m6-20020a170902db0600b001d8d225699dmr1428plx.16.1707262571902; Tue, 06 Feb
 2024 15:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-10-namhyung@kernel.org>
 <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com> <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
In-Reply-To: <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 15:36:00 -0800
Message-ID: <CAP-5=fVPfSBGi1DrNkv3Moug_HyPZdEyab6X6sDyg=1-F2NAWw@mail.gmail.com>
Subject: Re: [PATCH 09/14] perf annotate-data: Handle call instructions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Feb 2, 2024 at 7:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > When updating instruction states, the call instruction should play a
> > > role since it can change the register states.  For simplicity, mark s=
ome
> > > registers as scratch registers (should be arch-dependent), and
> > > invalidate them all after a function call.
> >
> > nit: Volatile or caller-save would be a more conventional name than scr=
atch.
>
> 'volatile' is a keyword and 'caller_saved' seems somewhat verbose.
> Maybe 'temporary'?

Sgtm, perhaps temp for brevity and the documentation to call them caller sa=
ve?

Thanks,
Ian

> Thanks,
> Namhyung

