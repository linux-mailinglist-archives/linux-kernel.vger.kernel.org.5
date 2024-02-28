Return-Path: <linux-kernel+bounces-84318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBF86A4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53CB1C2542F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C521FDA;
	Wed, 28 Feb 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtnjBG4u"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F784A32
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083235; cv=none; b=J2eiuqZgYWq0wroHfrWE1D1hNkNrI46t3lo4XwJIEmtM694fbvZm25SN2c3zxt6ZTa+Iozs6QSQLWphXlv1vVSd6JTkYdKCtHExDLtQgBkqJ7J+N3obSP18zU+vpUndIGS7yluXTrXO4YyU+8G5VoUCGIVZiwTsd4XfZKi4s83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083235; c=relaxed/simple;
	bh=f8TZMnSkvdvr8lU7/b4OziAB9m4g7TVwlFVIH7WadGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URBFRppQcy3WWRzcgmzM36xYDxeG694BoK8U1FK2C/SHH8Q2w5XvLdGoQ+ykI1yxciuWArIXNCAyGFcbzdXBDFvo9rjdY/UYKHtguWpwSp0WtWVqMUpH6PUyOkbyptMPkD/Cev63kySWMvCo7ncWvjeOdWGSLzy4rK1/V1Gzx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtnjBG4u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc744f54d0so92815ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709083233; x=1709688033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdT0x3HibO/pzSmdrgIYWiv8FmuIQF8zXY+TeseC7sM=;
        b=GtnjBG4ued0/3Wglc80zQFw7gd9rH4lN4TWnRIzyjBJFQgPy/PL5H+zyz4aWoQkES9
         iu5PewLUB+eGkhqMCuiJstyqj7bW0M7fNuUuBRRW5M+tkcm4elfKNeOX37CMTtpsBn53
         3VL/JGFX8CNMvfVKupyl7luFYtn4hF7j1U3aksxS5ALU3tr2hLF5ergj8hWcL7gcoPLe
         QYv7/TWICuu6XeWN+IJglD2rJSl83D6rs5mhUZcbav2PB3brDnw2/SK/VOb35zFx6GFX
         PNcqTNSrM668Mm8aQgIBf0uw0ESlitttZ8JhUUgJul2H4IM2Fbw1GABmYzf3NwwyCJc2
         wKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083233; x=1709688033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdT0x3HibO/pzSmdrgIYWiv8FmuIQF8zXY+TeseC7sM=;
        b=jeXoUtoZ0hSzIXP88sCL9e7BQ0RR0BBqyPuVtkxZORuBsyDCpsCC+jvl24I/QHURwk
         L0AgDhjsunBAPllAfGS/hhijXtCH9hLz2QBx6GOXhWYFPoOM/89Vmtm7IWKzCwUJIqhT
         nixwPMrWfKh1A8SZ4Jh3S/LzzCupgQRB3X6OxrK3dvAEs5F5EknSs+figID1WW9DkPTe
         lAITS0/lGS6IivVp/iMGckmxYTXJafnwbw+/bRDZm7/RAfy6B89j/lWEyzInotoGoNUq
         AIAWih28uyQ0/yvyjY/f9NUBKQ3NKmbR3V5TO3VpY93u/JfFrzSj99QIZ1sQPYeNTnOc
         KJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVCDbuxkVcAYHcetvFuVEF/LauTdan7Ft8PJyQgMRMrKiKWZGJcHyzw+wEHngNAri1SyhtK6aBaWMHmE0gJAOpTFxfLYJpY748Sj/91
X-Gm-Message-State: AOJu0YwcqUV1Wl39PKd1vms4zS5JUIkwhisTweFJokgEiNiA0gI/AcHp
	SsS1zyobgxxNrzhZnaQs6pG6hLnSlvb3MNIxHlKS8Yy6B/RYVTAv6SmU0mUr8RqNlqvwbKMooSC
	NneLwbDFd/wcAArahWR/smC/DBH1Dj/Kvoj9z
X-Google-Smtp-Source: AGHT+IExJXBPQ3GF+J+ug86UWIg39ZhcnQ8sj9sPYlXuoBEeaVUgwPP/10AdRfGAu/tgNqj+8duppB4y7xFFMF15R7E=
X-Received: by 2002:a17:902:fa08:b0:1dc:8fac:929b with SMTP id
 la8-20020a170902fa0800b001dc8fac929bmr9738plb.15.1709083232928; Tue, 27 Feb
 2024 17:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org>
In-Reply-To: <20240228005230.287113-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 17:20:21 -0800
Message-ID: <CAP-5=fUK-P-4n46DjjGt48z_sivJ+HawsFP3e_C-mx5dW9JP8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Improve memory usage for symbol histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is another series of memory optimization in perf annotate.
>
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
>
> For example, when a sample hits symbol 'foo' that has size of 100 and
> that's the only sample falls into the symbol.  Then it needs to
> allocate a symbol histogram (sym_hist) and the its size would be
>
>   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
>
> But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> get worse if the symbol size is bigger (and it doesn't have many
> samples in different places).  Also note that it needs separate
> histogram for each event.
>
> Let's split the sym_hist_entry and have it in a hash table so that it
> can allocate only necessary entries.
>
> No functional change intended.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf annotate: Add a hashmap for symbol histogram
>   perf annotate: Calculate instruction overhead using hashmap
>   perf annotate: Remove sym_hist.addr[] array
>   perf annotate: Add comments in the data structures

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/ui/gtk/annotate.c |  14 ++++-
>  tools/perf/util/annotate.c   | 114 ++++++++++++++++++++++-------------
>  tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
>  3 files changed, 158 insertions(+), 56 deletions(-)
>
> --
> 2.44.0.rc1.240.g4c46232300-goog
>

