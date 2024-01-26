Return-Path: <linux-kernel+bounces-40385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F183DF55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF39D1F28EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7931DFC6;
	Fri, 26 Jan 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0yMszEb"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E51D545
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288268; cv=none; b=t248LLPorn0I/4Qs3phubGZCdUo5p31ixYQhH+ouDkAiClOnMopwY5hEdT1m3UmPtp5eKwQoW5kjrBEjgsYBCKwhRog+mXzXyyxMJ2IgNR43Lv9p6zVmAgrw06DZrVOBOydQb4F9nE2FHcZYGuVVmjg06824XNFn8VUzUpZSalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288268; c=relaxed/simple;
	bh=EvCafv1sut8qM6qKIK1YMxvl8RZrjtMxUcDY4rmzS2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqxeR0+BZNbAZoG4Zc9ibNGVYn51exQ0MYfZpG9pSeFwGgEMtvirbduA3p826tMK1x16ZZhn6FmJP5kAggSHQ6TTaBQivwPI+AnZ88ZrgqSJaut784OZWFtCDr4PHVtotscgH/I3dD4utebn7iFx2aHJbeI81aW5q65WlzFHNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0yMszEb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-602cf45bfe9so5697677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706288265; x=1706893065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8wQho2kzTpQJAHRtDOw4DoWvclzdYhTLnZmTHKhh5A=;
        b=v0yMszEbJCHLJWo3nmkZ1zNDPvRKTPxKSyvT7TmUADU+AoAV+WFHx6M7RePN6wSi2C
         E+Jotprv4T+YxcYtMCbcbQDAVetgApjWzW0Pv1hkYHcaLB7QWTvIdPcvKznGI8RHh2VK
         sATXpx8tHKY7TvTiAOO79jLMynanjZY6wJdLxBrMIQZKcJoC/E8IfOA+gdrPIijwKDJ0
         i8H0q4Perd822+tlSPYS9s6HpIFDq9AtRGjysomhlM8N7Dlx8qekZUOwvyLASHdkfskr
         nggaIGGH3yX0n8y4/JA9FM0bCkuNhRRCwJ68yk+7EWi6t0Piux/fztfKLOM/rPlxC0Ym
         VklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706288265; x=1706893065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8wQho2kzTpQJAHRtDOw4DoWvclzdYhTLnZmTHKhh5A=;
        b=qEKdDoLVovGouOYvFwr9heWKnXBO+AAAFkh9R4cNLf/8LD3Dr0fso9jHWKleL1Q2MS
         HUvolvOYWBbtzPwBmisqj+TJftS5Ly97KVVnoVRwJpAPzm/UGKYXgIuC1x4Y3KxRWSLa
         Auv2QOps9m9Ix/181rUMiAU90tlnceRojZkV0ICSM0Y4KBIdOr40epl3gTBSdOhogeVI
         l5QiQnEs9e/+i5pJbMYj7MfpMyI+22O2TrMEBsUTQtFH0ybnzpqXBQSMxoLSQrul0qyS
         eSAsJK3jVExyTRxBHGQQmBgXkrp2YOoZjYuQn9V5h38nimfIz3rUqxpkbtfW+WBRu5Ub
         4aVQ==
X-Gm-Message-State: AOJu0Yzuv2AZbH/KIr79pOM3G7DgdrEF6A6s43Yd5oRgJMaC6xxQ/ZWg
	SA/ORe1YRZDvzLOHoEVivf0YO8JRXb2bMRzGSuQSE+wZQQNWF/pXR9pO4xnBm+OL3T5/kryX0HI
	k23epb+zYdFJTamJK8e5lkF011arTUlXveGMq
X-Google-Smtp-Source: AGHT+IFBQn83Na5+mL0dqae0d/D6DCw5UhICy2RXG0Bh6kX+ltPjDdP9mgjcyhsfiQPdKSR3E1zClmHAvp3oOHgc0mk=
X-Received: by 2002:a05:6902:1003:b0:dc6:48fc:65e4 with SMTP id
 w3-20020a056902100300b00dc648fc65e4mr125320ybt.40.1706288265435; Fri, 26 Jan
 2024 08:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124173134.1165747-1-glider@google.com> <20240125173448.e866d84cda146145cbc67c93@linux-foundation.org>
In-Reply-To: <20240125173448.e866d84cda146145cbc67c93@linux-foundation.org>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 26 Jan 2024 17:57:04 +0100
Message-ID: <CAG_fn=VBPy9vYTUvdW5Bp9MHF3F2kAhqBKeEg6GHXk0_MG-fiw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kmsan: remove runtime checks from kmsan_unpoison_memory()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:34=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 24 Jan 2024 18:31:34 +0100 Alexander Potapenko <glider@google.com=
> wrote:
>
> > Similarly to what's been done in commit ff444efbbb9be ("kmsan: allow
>
> I make that 85716a80c16d.
>
> > using __msan_instrument_asm_store() inside runtime"), it should be safe
> > to call kmsan_unpoison_memory() from within the runtime, as it does not
> > allocate memory or take locks. Remove the redundant runtime checks.
> >
> > This should fix false positives seen with CONFIG_DEBUG_LIST=3Dy when
> > the non-instrumented lib/stackdepot.c failed to unpoison the memory
> > chunks later checked by the instrumented lib/list_debug.c
> >
> > Also replace the implementation of kmsan_unpoison_entry_regs() with
> > a call to kmsan_unpoison_memory().
> >
>
> "false positives" sound unpleasant.  Should this fix be backported into
> earlier kernels?  And can we identify a suitable Fixes: target?
>

Surprisingly, I haven't seen these false reports before, but the bug
has been there since KMSAN's early downstream days (at the time we
might have needed to have those checks).
So it should probably be:

Fixes: f80be4571b19b9 ("kmsan: add KMSAN runtime core")

