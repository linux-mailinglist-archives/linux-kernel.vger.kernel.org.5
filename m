Return-Path: <linux-kernel+bounces-54076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060684AA62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AD7B24171
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247C4F21E;
	Mon,  5 Feb 2024 23:16:41 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BD4F218
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175001; cv=none; b=hgLiRH2Lp/+LcKwfvMCXwiYohvPaX2l/cEMYtVX2W5sFD76xXM3eWx5MNOkzNht43tSJqxn/aFHoNueyebixhlrVS9wdr7g+f2o9v/8DK/2b/elx1o2rd33V2gtMPOL9ue9UDSgLrnoJt4gFyielGZvWIlrxrQp/9WFmyWsc7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175001; c=relaxed/simple;
	bh=jP85jDq0cvSnI7nRh3hM2aCRJietCWqaBA3nArkBg9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEl3v5Un/NXdtW+o5Xs/wU4dEDtPWyoZjhzYOcdPLTv1ssaRefwbuZvwOYZHsPtwduJK+U4zHVfY2QT0FwtkJTU1PCyKUBv6KceVWFmp4SStxG/6Wp2cReHT+Nmxj0cWiL2JToZFdqa/itbGK2MGB+7BTYKrkk7La6nxNlnbOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so3736840b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174999; x=1707779799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfrCIsKTIDPuf1kBbgefVyKBKKRwJ43oiLoQQpXfJFE=;
        b=MHyC1J3MaYNxKVu1kET8bpdscJAb/UvwC8A/k/rOQLyZLF3fJoWKfcLgl79NVaSLC4
         ak2F4T1JeS++K9dN/x/xkZhxySRbXHsU9LrNw/rAqOyUztMiw4WsFpcRcY3cbHKuEaZ5
         zHbE2opzFAnGDC8IRn9kWvUUAoAuXz4nvqYFDiL6pXv8z07z+a+7Ts1Hpqh+Uj34L5BE
         fjefLyGyxkrImfG/6/Ke5/VJAhRpoE8LzeA8SVaOPbLJQY0YIbhSt2FDQv2t3kYj8Zjh
         BRaSZaIOw3vRURrb6yrGrr719joA+hUoXIigOH6LOavtbkfHWwJRVuQv8Ex8JlNX6JQI
         9oVA==
X-Gm-Message-State: AOJu0YxNg3mRDCZSZ4wsn8sizAInl8blLbsvLQFVBrRHEMTbirTC/S8j
	aUoHaph1Y86UKQj7BS9KbBQ47ebEveJV6ds4yqn6SqM+eLmxPpBR4zl3DSch7Dch0jbnVKN3bq4
	vlXlMWBICtAZRqtT8ee8mJTW/edQ=
X-Google-Smtp-Source: AGHT+IFTgAk00CrpLtrYEJF0594xcxOZMd7AGVtdAb1xCLOhCxSN2bgglIdrGN+ZmIy793033sUWwnJYSfz49xseULs=
X-Received: by 2002:a05:6a00:4595:b0:6df:eb95:2c78 with SMTP id
 it21-20020a056a00459500b006dfeb952c78mr1032057pfb.10.1707174999043; Mon, 05
 Feb 2024 15:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zb1EBzpBn4s-mIa8@x1> <CAM9d7ch6tvwMgdOg=1hZqE23bQUKDtYOdyJ16kkyt+6uY4q7pw@mail.gmail.com>
In-Reply-To: <CAM9d7ch6tvwMgdOg=1hZqE23bQUKDtYOdyJ16kkyt+6uY4q7pw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 15:16:25 -0800
Message-ID: <CAM9d7cgPAuY=R2FTOc8ffZpe_O9iaosZ7FNHvpB-aCk9pj1N4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf augmented_raw_syscalls.bpf: Move 'struct
 timespec64' to vmlinux.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Feb 2, 2024 at 11:35=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > If we instead decide to generate vmlinux.h from BTF info, it will be
> > there:
> >
> >   $ pahole timespec64
> >   struct timespec64 {
> >         time64_t                   tv_sec;               /*     0     8=
 */
> >         long int                   tv_nsec;              /*     8     8=
 */
> >
> >         /* size: 16, cachelines: 1, members: 2 */
> >         /* last cacheline: 16 bytes */
> >   };
> >
> >   $
> >
> > pahole manages to find it from /sys/kernel/btf/vmlinux, that is
> > generated from the kernel types.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Hmm.. but it makes it fail to build with GEN_VMLINUX_H=3D1.

Thanks,
Namhyung


  CLANG   linux/tools/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
In file included from util/bpf_skel/augmented_raw_syscalls.bpf.c:10:
linux/tools/include/uapi/linux/bpf.h:55:2: error: redefinition of
enumerator 'BPF_REG_0'
        BPF_REG_0 =3D 0,
        ^
linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:46833:2: note:
previous definition is here
        BPF_REG_0 =3D 0,
        ^

