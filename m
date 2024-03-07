Return-Path: <linux-kernel+bounces-94966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32023874754
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA07C2850ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9451BDE1;
	Thu,  7 Mar 2024 04:20:30 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562A25767;
	Thu,  7 Mar 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785229; cv=none; b=eXr1YBg/6CaXUr7BIrhgh00q9YOJp2pJUz889yMNTyXZxIJYIpZMLZ9BYMdEdMvEAasa0fCG9AI1sCkRX4ln29igYd/+QbLQLHxzwZV//w1n99yNfcC5BgAw0mVyBuqjTRaYCBpw4t4pjiw6ryEw0gMo5RMPpSD6+xys+DjvFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785229; c=relaxed/simple;
	bh=53JxyFKU3XAtE0lZPMuBF9A7iLQtuV0Q4p9eES+00j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvMTcyOjV8aWIidHIIvM+XzuiI9e3aFGhVp9b+0qhCtFQprQzIvUtXfLeyXfxmYaFOQSFDEqZWkj3c7xqv43TuD0xcCgWIax9yQmBXVbsBbF6mtWymzdUgbYdat+OIzCPP/9meLKLYbOcCCaJeMqcick0HhQX5dJ5VghngL0eMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so258772a91.2;
        Wed, 06 Mar 2024 20:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709785227; x=1710390027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+lcNCz0f80j0accvsGVgfR5v7RKJSfcCBpAdb7j5m0=;
        b=EbJMVmC20/3fqzFy5NtcjvZKQCUtoAJ6sHekLFIOSxr5MlVg3DoTHpgolA6pyMybk1
         s1UFJ/BEkeZ6jsSZ3f6LYPXx1YHvMsSeS/ryQNzdsreAZ0RWbZvkn6jrGc50JAL+0uh6
         iJIdPmImF0pTe41NUgbfW10WiH8kjy0F20cRlFoh6+njhPOp7Bt7rHfXSGHPxvUGBLFe
         4MJeG8i3Q62HnLKIA3BUt8YuESFrCjmlND77MR5Te60DiheUYeh9A4goe8UX2tFg1HAL
         hMaErqBuIFXVF5xQ089bzapjTUYZ9HAsun1xeM5iArNtjE07EzKL/wdRZVazcJfYEa7e
         HmGw==
X-Forwarded-Encrypted: i=1; AJvYcCW/YyaASI3TRCVf1PRIqbCsWY2la6AEwc0huSJ9EfI74Gy76JBF5fbAtRknjdux7hEYfViZmfZXIRV5EvDDyaqWD/TZcH7oGm86+4OIwmJ+kKTV+63IJTkn70twFJClUEuEFLyxXoAjxMIeuzNgDg==
X-Gm-Message-State: AOJu0YxnhL/7iIC7eDzWXDRE8fF0KkU5pOgiJDManE++Q/3oH3mCOKk6
	ocl51Joo9pgNzr0wRU2TleCU5L9HT53CmTAfKBivmoljS7IBCg9994gYE8tiLeNQ/IeW+k6OFJF
	cSsW3g6Rw7unsf5ZUN3YAlBmrM24=
X-Google-Smtp-Source: AGHT+IEJg/55esdoBBZ22UKlhPO5qyU5+AYFJ3a8FNzE2CU7mhAqtk9JrvYiIHJKnmMOglrVSM9M17uRpV+9QzJcIPQ=
X-Received: by 2002:a17:90a:53e2:b0:29b:7244:c4eb with SMTP id
 y89-20020a17090a53e200b0029b7244c4ebmr4288131pjh.42.1709785227553; Wed, 06
 Mar 2024 20:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304230815.1440583-1-namhyung@kernel.org> <ZejshUg8XiQz5YGa@x1>
In-Reply-To: <ZejshUg8XiQz5YGa@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 6 Mar 2024 20:20:15 -0800
Message-ID: <CAM9d7cjfH7e5wiM9Zwfn_oCqL1tUvy1=c3RUuO=zvgTJVrU6oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol histogram
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:22=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Mar 04, 2024 at 03:08:11PM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > This is another series of memory optimization in perf annotate.
> >
> > v2 changes:
> >  * fix a bug when offset is bigger than 16 bits
> >
> >
> > When perf annotate (or perf report/top with TUI) processes samples, it
> > needs to save the sample period (overhead) at instruction level.  For
> > now, it allocates an array to do that for the whole symbol when it
> > hits any new symbol.  This comes with a lot of waste since samples can
> > be very few and instructions span to multiple bytes.
> >
> > For example, when a sample hits symbol 'foo' that has size of 100 and
> > that's the only sample falls into the symbol.  Then it needs to
> > allocate a symbol histogram (sym_hist) and the its size would be
> >
> >   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
> >
> > But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> > get worse if the symbol size is bigger (and it doesn't have many
> > samples in different places).  Also note that it needs a separate
> > histogram for each event.
> >
> > Let's split the sym_hist_entry and have it in a hash table so that it
> > can allocate only necessary entries.
> >
> > No functional change intended.
> >
> > Thanks,
> > Namhyung
>
> No difference before/after on that 'perf annotate --stdio2' for all
> binaries in a perf record of building perf using the default binutils
> objdump disassembler, etc.
>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Great, thanks for testing.

Namhyung

