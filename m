Return-Path: <linux-kernel+bounces-48741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B8846087
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6482289947
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA06A8526D;
	Thu,  1 Feb 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRsY/jEk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0585261
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814037; cv=none; b=YRZ7022aVCab+aT4LAeHuSSs6oOBxwVpvo/Kl4q+A27okHShv85Lg0xgVXs9qS1mVK9Nk2+Nkbvy2Xcub2a7w239otlFIjRy/Kqtru0St+se3prtivYMFLcNSZZIEzxfJRKoqwCv5MOW7snh8vV+58z4A+/FrwQyQjo0vRuediQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814037; c=relaxed/simple;
	bh=yyMgNu6jZcLxIKxkJraUC5nFtbsHkXOOtwpOQ0PUt3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q11h149ztzt5nLNHeK0sNHyBRHA1qd2RzX0m8KjZoz3zkbf465Kqvl7vPZ/cXgt+fqiM3x8xClM2NbXCHoiPROP+Xia500aqUZskTSIYPVUvPPNLFbFn7dc4EXYr+WWMDfenN4uloa7S6UuDOHoNGloD7uY1lCK4aHxNfcPyA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRsY/jEk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da202aa138so819033b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814032; x=1707418832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldL7NnvRL1dUELtbjGeSbUg5ttfmGMhXHk7grOQiZw4=;
        b=GRsY/jEkqZPsJXJTWh34obw1ntS0UxEfSXkGfv02B3H5oeBQe3fkfNjgNZCPG3TdA8
         0Vwc9VdYZIGg3tL+Uj0DFgbxhsTdU/R9/wvHqJ1brlTrKjxV2s0N2mxk8MQ5ZMNDnZak
         NY54a/oWri9keuvbdR70+x+uTvLOznP1Elg2KAJGF2K5F+N7n4SnlU2xB72KnybYS4/X
         9hIrZ5nkH8LeYKUe1cjj20LV6e9Gwwz8F9e1fjUDA552oxhobD9NmJr1qdnzL9Y6p/6U
         uvTUiAdU9tuYPYplUuhB3yGCdBQQKhkFFluBrxng/s2hTtk4P3e5dCV/0KJ2pCzmPL/X
         gReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814032; x=1707418832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldL7NnvRL1dUELtbjGeSbUg5ttfmGMhXHk7grOQiZw4=;
        b=bDPkZm52EQYRcpu79HLM2RucjtrzVhSK+COpMsHevIVw5JF17ylVZC5Sddeaw5MzFP
         djudky5GjX+o34CPDaAjK+3MtFgNHKTd2r8ShhoIi2UeLABSm0po1CPLZl5hpVW8BZR/
         FYAR8ZNpzHMmDwvwsVFXOEuP4Vs7IJ32IFpw7lcrdVSLWCaAhNqQ/USJr+1Q0EyduLMq
         sWcghddW1KrSR1OKYh91diU5MkmOjNkZy5VgSoSEB381E32k7EvcwqaekP7YAR97DfT1
         42g6f++OjNW2hzKy1IGhdb5vo1E7aLM8bqtde9YuYuMRU6KZGQSe+UHL5I0/YgVj837L
         0kMw==
X-Gm-Message-State: AOJu0YzZ9GDgTOmxJ8ADEZeBEYqrQM0UQTDNjS/v8yUKABgLWajcOclA
	BVeqCmlDksT3jFe5jxPByxI8oYNLPHXuJIVqiaZgai6MK4Ipp5hfnMRvBA7hUmFVzQpXiVttfi/
	9FmVP0wq5v0Tr490exz6ed+Bcsc8=
X-Google-Smtp-Source: AGHT+IGD0X6vKZw3kNaW5Y93wmq0JswuLZXxv/uYUgu2Iax/mInH2CrsbszM6h4nlV7LBT29P89W1jBZe80fy/YX5fY=
X-Received: by 2002:aa7:8485:0:b0:6dd:808e:7a74 with SMTP id
 u5-20020aa78485000000b006dd808e7a74mr19527pfn.25.1706814032407; Thu, 01 Feb
 2024 11:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065943.2803551-1-shy828301@gmail.com> <20231221065943.2803551-2-shy828301@gmail.com>
 <878r46ym4b.fsf@oldenburg.str.redhat.com> <CAHbLzkq1ah6y-dCgA0rFePNn3FsE8ebuSNd+jaS8sO51a=X9Yw@mail.gmail.com>
 <87frycryfq.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87frycryfq.fsf@oldenburg.str.redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 1 Feb 2024 11:00:19 -0800
Message-ID: <CAHbLzkqY1=nh0NqpLV+Az+rvT5oE=NhYZT=hOevZhs12T1V=dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
To: Florian Weimer <fweimer@redhat.com>
Cc: oliver.sang@intel.com, riel@surriel.com, fengwei.yin@intel.com, 
	willy@infradead.org, cl@linux.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:34=E2=80=AFAM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * Yang Shi:
>
> > On Tue, Jan 30, 2024 at 11:53=E2=80=AFPM Florian Weimer <fweimer@redhat=
com> wrote:
> >>
> >> * Yang Shi:
> >>
> >> > From: Yang Shi <yang@os.amperecomputing.com>
> >> >
> >> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> >> > boundaries") incured regression for stress-ng pthread benchmark [1].
> >> > It is because THP get allocated to pthread's stack area much more po=
ssible
> >> > than before.  Pthread's stack area is allocated by mmap without VM_G=
ROWSDOWN
> >> > or VM_GROWSUP flag, so kernel can't tell whether it is a stack area =
or not.
> >> >
> >> > The MAP_STACK flag is used to mark the stack area, but it is a no-op=
 on
> >> > Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocatin=
g
> >> > THP for such stack area.
> >>
> >> Doesn't this introduce a regression in the other direction, where
> >> workloads expect to use a hugepage TLB entry for the stack?
> >
> > Maybe, it is theoretically possible. But AFAICT, the real life
> > workloads performance usually gets hurt if THP is used for stack.
> > Willy has an example:
> >
> > https://lore.kernel.org/linux-mm/ZYPDwCcAjX+r+g6s@casper.infradead.org/=
#t
> >
> > And avoiding THP on stack is not new, VM_GROWSDOWN | VM_GROWSUP areas
> > have been applied before, this patch just extends this to MAP_STACK.
>
> If it's *always* beneficial then we should help it along in glibc as
> well.  We've started to offer a tunable in response to this observation
> (also paper over in OpenJDK):
>
>   Make thread stacks not use huge pages
>   <https://bugs.openjdk.org/browse/JDK-8303215>
>
> But this is specifically about RSS usage, and not directly about
> reducing TLB misses etc.

Thanks for the data point. Out of curiosity, what mmap flags are used
by JVM to indicate a stack? MAP_STACK? If so it should get
VM_NOHUGEPAGE due to this patch (of course, on older kernel
MADV_NOHUGEPAGE must be called by JVM).

Letting others, for example, glibc, call MADV_NOHUGEPAGE explicitly on
stack area is fine too, but it may take some time to get there...

>
> Thanks,
> Florian
>

