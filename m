Return-Path: <linux-kernel+bounces-47257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B75844B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A721C22295
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3F39FDE;
	Wed, 31 Jan 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFeOD1hi"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372D39FE3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739991; cv=none; b=X7I7i6CCwjzHKFNEZ0Uu+mzD0BIje4M8IppWS7nyP8uSOTeVqtZmdedj9dDNTuknpi/OMy8yyVX6YsizpXHZAqZvfM0YHFZtGirFs4XSvzVTVdnwPYOOyUQit2yKTUWj2bh06l3A9qopzGj6pBc1nBo4QBKRVRi77hL3YrrqxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739991; c=relaxed/simple;
	bh=W4OPzC1JOWGcvsLB4icVR3gE8PnQTydJXAkzVWnDCns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFifjOKqaHjVtaN6z0Na6795KdeUdT7DS6QcMJDqKwtMcpoLe5hTf8EiC0u1N+DYYkjMFIlvV9+Uv3Pl0lHJ5iFG1lacezocHxETSdbb1i6YOrIPuB2HXFFjJkyzmasEu9+Qu3TfQlgLyZocHx48Z8AVaL2W6jgxKRm/dtPIU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFeOD1hi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so23381266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706739987; x=1707344787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLGry6/gJQiRQ8s+Sj8i6LZCaBtXqoMXObhLul/4bNg=;
        b=EFeOD1hicaG564X56sNCiaYVBncpvrXA8pbqXhBJSGa7MKVPNjsrWLqHBiSBiru6cl
         seuW0ocPZQwSKU5e0xaFOGSFDGAnKE86GbRzLJSpaWZbLUco1etcLxMgiA9X44mVl+3N
         AvCFVvop8vuDfdzvqdmvCWy1vwr9ZXPMUnO48m8r5YAhrqplc2JoKjeKMGfBdQCOK7LH
         S9xlcH5ARILHwV1OOyiF4+kekQ6exYQ7FCFgXPftBJyccUT3YWgvveR1EfM3KE+MeEZH
         1PXUdKN+pPT2oHZ2Go259zeWCIRsb+pWgplFLFXNzQ47MsxzE9670Yt03QWyjKQeiHvB
         QRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706739987; x=1707344787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLGry6/gJQiRQ8s+Sj8i6LZCaBtXqoMXObhLul/4bNg=;
        b=lbQntwgmFDiyrUGTRvrr+3URNNK9byxxeVsMxUuTi6OQJicK5EbM2wuJcyYRk87cVj
         h6CfPv7v+zdXcSSi1bfP6oO80RbWUcgJyp8Ak4aQEWaSc72Y4qdEXtMUp1x/iaLHirx9
         snhsRQgdU27LKbUymKchdrDrLO3Mjp9LfqJxmMN5Q63zM1RXFpgs/iEP2bbSqEEc3/Fu
         tGNM8CIPFFZcAOChsKM3i0GWuHRaBXiCodrvnnk1oDH1GL6rSyAxoZDQnuttbJZWB483
         cS8wMEqautvaQx21iPiVdvBiVStTG++rxxkHKCwQJVJHqYxRIhgDEUhE72KdjYuWiN2H
         /35A==
X-Gm-Message-State: AOJu0Yz6H4OV+rMlrMpdCqBuSK57KPgTMZwsYrh4t72A5pBTCpKlkMJX
	AE3ly+p9akg+6PRBsQm7U6N/m6eKtMjsaoVyjjqU0u+sYIRnTQuVMRSsrQD++ViT3CXeSK5FTOQ
	9hFQ+/c2ORX5wPxRqlu5/S4ISSEJGQmYbDY02
X-Google-Smtp-Source: AGHT+IEJVJZcVTNvfJM16SNzGeZFJQ8xXiKJbC3a4/PPRI1c1OuaspDS2KYudUsKOvBIpBN2hN/Xi8mSrTGHw2y3cKA=
X-Received: by 2002:a17:906:118b:b0:a31:8f88:8c8f with SMTP id
 n11-20020a170906118b00b00a318f888c8fmr1806967eja.11.1706739987422; Wed, 31
 Jan 2024 14:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131172027.10f64405@gandalf.local.home>
In-Reply-To: <20240131172027.10f64405@gandalf.local.home>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 31 Jan 2024 14:25:49 -0800
Message-ID: <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 2:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> I was looking into moving eventfs_inode into a slab, and after cutting an=
d
> pasting the tracefs allocator:
>
>         tracefs_inode_cachep =3D kmem_cache_create("tracefs_inode_cache",
>                                                  sizeof(struct tracefs_in=
ode),
>                                                  0, (SLAB_RECLAIM_ACCOUNT=
|
>                                                      SLAB_MEM_SPREAD|
>                                                      SLAB_ACCOUNT),
>                                                  init_once);
>
> I figured I should know what those slab flags mean. I also looked at what
> others in fs use for their slabs. The above is rather common (which I
> probably just copied from another file system), but I wanted to know what
> they are for.
>
> When I got to SLAB_MEM_SPREAD, I found that it's a common flag and there'=
s
> a lot of caches that just set that and nothing else.
>
> But I couldn't find how it was used.
>
> Then I found this commit:
>
>  16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h")
>
> Which I think removed the only use case of SLAB_MEM_SPREAD.
>
>  $ git grep SLAB_MEM_SPREAD mm
> mm/slab.h:                            SLAB_MEM_SPREAD | \
>
> That's all I find in the mm directory.
>
> Is it obsolete now? Can we delete it? Maybe there's other SLAB_* flags th=
at
> are no longer used. I don't know, I haven't audited them.

Perhaps cpuset_do_slab_mem_spread() as well.

