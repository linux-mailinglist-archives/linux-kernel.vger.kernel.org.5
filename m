Return-Path: <linux-kernel+bounces-122959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08960890058
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B6C1C24036
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1A80BEC;
	Thu, 28 Mar 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn8+648q"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD039FC5;
	Thu, 28 Mar 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632912; cv=none; b=F3uBZB2Dy8TcB+e7Hit9PlId/2VFkN1oj+6UDfeQChLO4tRPIe+O1bbRSRdPOMtzwDDVrcT7sOt8ON9+B5O7ArUbqe3sWdtcHUaMHo7HWS/c42oUzoNwWXkIq/CyYrYVv1/Pdn/cLqwFDJLXZXjYTc3VUwxruaLTk+WhZT91DHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632912; c=relaxed/simple;
	bh=gPlyhI5KaHAlebKciw6gQDR4Gt5cdCPS7Ok+oAgfY7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALuyNLVytqrKp6pbUJKV3l56gu+bGQiIsdUHJwmEV+ThbSKZ/k3XXbg8/GgsubQIXw0fOkLvIOmLCx8aNWIfmnGwzfqwS7CaNr8Nb8TXWCGE1V6/3SDsMeTuvOc8cUhaikUMT/H8DHTP19ARqiKMrpzI0XLalYmA9QL78v/3+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn8+648q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso724219a91.2;
        Thu, 28 Mar 2024 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711632910; x=1712237710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7gWMquWMEP5WUZVZfuRWZzoKAl90pc70ak+JLNTWME=;
        b=kn8+648qNy5CJ9Yb/AxC78upcKaqIClepIQGPzoCFenQWagSHD8r2Uu+sQBVYcpEmA
         ChJO5eZLrVWlDt/s67oNpkudb6ZO3FMu/BG4Py74Mr3/b5JCTkHznevB3Kt0IFA2HoU3
         +LXpNhMCGVkCPUDIkyFqRmTLz1/vRvhIRzGR8gYRD+6TF5Dqp8MJ5eqk9929ayXytDaw
         ntaxnOXM1asWWMmVApPBIBxtKBnuz4ivnk1sTPyZ1Xu+WgiCZUzpkt2+2iekR4Q+n5hs
         SxRrE2jNJQvQ/5nIAZBUmsrR+zeoa6Jhq8nJEdhTS98B+2m+PJMZPSnmfXf3neZA0BOz
         VLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711632910; x=1712237710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7gWMquWMEP5WUZVZfuRWZzoKAl90pc70ak+JLNTWME=;
        b=AJ2SI8RLVtYxHh22BDMubLCV+V0GsQQvRvCGxSEegv3X4jbtn86knIQ869wDCZVXAG
         ZfvetsJzdKmrpGICoPESHWWCiPtD16Ug/RDRYJk498q5HdIHmplz0DYSkBiGDd4wKCvL
         JvahnCPysM2J/I4FZCl8LUMBfXOQyp+fXb/f/R7/vLvmVbbx2PxLLTIbU7O/a03z+V16
         KuU3CQaljHz8vICyMRo7o9jGjZfPf02U6SH7f+anLXj3LHqAFix9enZGfJHiVxJHnPHw
         brAkiQTztmGMs6b2qDhdfsJZB/eBTPjQtF9FaENTnXwDAmoUvl0snagIogwlwRf8FXcS
         fjzw==
X-Forwarded-Encrypted: i=1; AJvYcCWUxrZHh2KTZ4DTDgCBzw6uJOx+JT43izhhctr6Dbl1yX7FUVrdwVhdvvkSohK6WQx3F820zzz/+Hf2lz2zoA766V2n1Dk/CDrHBiGTVUYH4w+nFM9mMAzDVBB81w9pMw9R
X-Gm-Message-State: AOJu0YwX5TOGy7946d3vv7yZeYJw+UPSkL7FZI/6FGLAHdzidUMVsKlX
	T5+g66fPsqBcGxEiXfaFk67x9RDvUtojhQ8hEQLm0oq0NF4bkZE3HbNaFvST2GYofYwbON7QKgX
	eCySHovJV+aUpemq2LTiUpuZu3DI=
X-Google-Smtp-Source: AGHT+IHp6ph7RmGK2HoK5ixxWEfUD8LTfTMfPXktCyofWyZcfhnme0K/1L41evxrtPMR3kwDYQzoGVom44XATQStoec=
X-Received: by 2002:a17:90a:4a09:b0:29f:eeae:e6bf with SMTP id
 e9-20020a17090a4a0900b0029feeaee6bfmr2603996pjh.38.1711632910131; Thu, 28 Mar
 2024 06:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319224206.1612000-1-andrii@kernel.org> <ZgVSxPJ4Yi/UPgjb@gmail.com>
In-Reply-To: <ZgVSxPJ4Yi/UPgjb@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Mar 2024 06:34:57 -0700
Message-ID: <CAEf4BzZkn2atLmN35tviXBu1EggRRg3Yqh2pHAnd6xe7V5xkUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] perf, amd: support capturing LBR from software events
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:21=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> > from inside BPF program at pretty much any arbitrary point. This is
> > extremely useful capability that allows to figure out otherwise
> > hard-to-debug problems, because LBR is now available based on some
> > application-defined conditions, not just hardware-supported events.
> >
> > retsnoop ([1]) is one such tool that takes a huge advantage of this
> > functionality and has proved to be an extremely useful tool in
> > practice.
> >
> > Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> > necessary wiring inside the kernel is not yet setup. This patch seeks t=
o
> > rectify this and follows a similar approach to the original patch [0]
> > for Intel CPUs.
> >
> > Given LBR can be set up to capture any indirect jumps, it's critical to
> > minimize indirect jumps on the way to requesting LBR from BPF program,
> > so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> > conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> > from BPF subsystem (through perf_snapshot_branch_stack static call).
> >
> > Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> > point, there is no reason to artificially limit this feature to samplin=
g
> > events. So corresponding check is removed. AFAIU, there is no
> > correctness implications of doing this (and it was possible to bypass
> > this check by just setting perf_event's sample_period to 1 anyways, so
> > it doesn't guard all that much).
> >
> > This was tested on AMD Bergamo CPU and worked well when utilized from
> > the aforementioned retsnoop tool.
> >
> >   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubravi=
ng@fb.com/
> >   [1] https://github.com/anakryiko/retsnoop
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
> >  arch/x86/events/amd/lbr.c    | 11 +----------
> >  arch/x86/events/perf_event.h | 11 +++++++++++
> >  3 files changed, 40 insertions(+), 11 deletions(-)
>
> Please do not queue these up in the BPF tree, all similar changes to
> perf code should go through the perf tree.
>

Absolutely, I rebased on top of tip's perf/core branch and sent it as
v2. Thanks!

> Thanks,
>
>         Ingo

