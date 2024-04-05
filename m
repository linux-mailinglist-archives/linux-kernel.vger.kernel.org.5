Return-Path: <linux-kernel+bounces-133663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD789A715
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7ED2832F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D075175559;
	Fri,  5 Apr 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4wCSADs"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732B1E87C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355021; cv=none; b=GzHQWq1mC0xZGlFtQRdI6uI+PMWU8HIH87Pv62V5LWwlbtIWyx1WLPvThqKl0Nd5qwJztluu58/A7U+3opcC/aZ8UXfB0gIvWwc4DQViLFaYoCAd0bZuql3fCS0+XkH1lq++Y/FAYyn7SCfiptmWyjp3ttaMMdtKbCuC8DPwR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355021; c=relaxed/simple;
	bh=vuTLdDyuJIsA0mUvXwtAZorouX5Y3SqaNdRMyruQWPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQPxpYKGHioLnQ/FvISm9JAK7gLE7ltkvQxM8iV5wkjMzpkfdANtC4lZmrBcjWY7agQJiJNrlo4w+zP1/7LqJB/kaJmOAjMRBe53ZiUK9PnaVAKPuj1xUA7y+sdoN8AqhQ4uaio4xqDG9lxxYlTI4G6Aat7sPh82pbGC89BUtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4wCSADs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-432d55b0fa9so53841cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712355019; x=1712959819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuTLdDyuJIsA0mUvXwtAZorouX5Y3SqaNdRMyruQWPQ=;
        b=R4wCSADsTUH/75F3rR+yuv3vIWHR4K276BKUfawkWXOHqIwQshSGwinrBSYoqjbFyL
         0sC/rQ6LRLlil6aD9VsquExp2uQ3I/q2znKHFnEzDXgqT492z8/lqR/+krd2y2wTaTVs
         nyMsrAxwZK6M7WswlB8u/80VWeTtVLs/ZJVa+MaR5IdmXAoaHWN5ZobLSDzr/hRdSCRa
         hVK80k6N/m7Jc+dut3NNdE2mZglpERy5BZzhCEP6IFJ8OHrTfQboANkDuyFxA0M/UugP
         l3MEm8CNK7XRYKJzsvHvM7mGI3Cy3QY1c7uNNT98Jpakje42UIorhjUIUJkNXuT5w4cT
         jXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712355019; x=1712959819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuTLdDyuJIsA0mUvXwtAZorouX5Y3SqaNdRMyruQWPQ=;
        b=ODCR/Gk/CL7tC7LFNF7RuFT8FE2+pkbDLG/Vvw0+wVF4TH93X//sulUU6SxgWYJVG3
         h1vo6zOjU2T1pSsmZbSUHqB9QMhCgOO24dZ38pwXfEBe9SMvqZ5znPazGelBgK/RQX0f
         HYXBmZvuJbKkfVWeN3Sv+vOp7W3rIcev6PMsau8isVvTJD1etS6nCF4DE1vnTkBZmtQS
         +zeemLREk8zOyamebdUBn1CyjG8HyZzNuGMhDkjhQab5tvX35gv72Bpj8qg8GHiLIyfa
         F6oOuvtjm4wjW0kC6SrueUx8LQzszEai3sggkA6erOB3kRuIRxJWrPy2Qu6ALTQdhy/Q
         xV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQm7Is3ByNO+SanT7cBNCrcgH8iZFWopzk1qGvWDeWKYuBuCPkGnJf1/TtubykDLHhDApf+32dhAVGH3M2xH4aO0TyIaiUg6t77N6
X-Gm-Message-State: AOJu0YxXZ8+xrFwVIzYpri5+N5mtoTDPqFg0QzfxC6ib9VTRP0ownAt3
	dCLEbJ/cmdepuAUVJO2TvCPnVCv5WyuHJwvz2x5vhW73bitWitN1aFoD9WobpmXScj8tco8BB+T
	6pY4Z8EEk7pEs+quHeYAqwG9CvKz2ljraeefk
X-Google-Smtp-Source: AGHT+IHrI0hnnlCotusGdYlD9m/OSL+LlZsYDysYD26ZYUGUpFJllz9nT4pbGMp0W92aAEELhj5fi2ttx67qMchAWA0=
X-Received: by 2002:a05:622a:1dcc:b0:432:fea5:e3b4 with SMTP id
 bn12-20020a05622a1dcc00b00432fea5e3b4mr29765qtb.3.1712355019018; Fri, 05 Apr
 2024 15:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-4-peternewman@google.com> <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
In-Reply-To: <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 5 Apr 2024 15:10:07 -0700
Message-ID: <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Apr 4, 2024 at 4:11=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 3/25/2024 10:27 AM, Peter Newman wrote:
> > Moving a monitoring group to a different parent control assumes that th=
e
> > monitors will not be impacted. This is not the case on MPAM where the
> > PMG is an extension of the PARTID.
> >
> > Detect this situation by requiring the change in CLOSID not to affect
> > the result of resctrl_arch_rmid_idx_encode(), otherwise return
> > -EOPNOTSUPP.
> >
>
> Thanks for catching this. This seems out of place in this series. It soun=
ds
> more like an independent fix that should go in separately.

I asserted in a comment in a patch later in the series that the
mongroup parent pointer never changes on MPAM, then decided to follow
up on whether it was actually true, so it's only here because this
series depends on it. I'll post it again separately with the fix you
requested below.

Thanks!
-Peter

