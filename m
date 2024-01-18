Return-Path: <linux-kernel+bounces-30234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDED831BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41331C23BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D71E521;
	Thu, 18 Jan 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOwCPkuY"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93A1E489
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589964; cv=none; b=X3RJISgeytNEI4nLYstsFUquyRHipnwwxSuSXp5qoPrrD0n73p1/twFjNxLkLckoGyM96DpNNzwo0AQZL8ViLvW/m4IqasdshsQoxiy1hFPOxDKqCkT6cJPSy6R3k//7nY5NAKzyRpsDyWTT90msHzB4NcGBbHExc8qQtzhRHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589964; c=relaxed/simple;
	bh=k6rGCGj38YEdXpsi6au5FMf/nUAYKbTHYROQ02xUMEc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BlyW+EY33cqzkg/vWM+cSul+dIjodHn7zHzdmrekGLleKNNkCf4PvQOI+5nh3YcPL7640SVevouAdClpmbrverlgCV6fQaJKVNuaRJLvCxOST/sLXr1FD1+ADYff+m8WJy9nK1j2SLjtqomEy6kuJ6znncnUqN6NnzxS29lABEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOwCPkuY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-559f5db8f58so7260a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705589961; x=1706194761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6rGCGj38YEdXpsi6au5FMf/nUAYKbTHYROQ02xUMEc=;
        b=pOwCPkuYtkropmmqOxnSV2JIx+OYjzToHs5L6Vq4gj0ghiEwtzHYUanCNXUtukj0+J
         llT8rRPK01tHo9NdnuGcWZin+XdhDxVONUsjqWMjpFf5X/fhCduwGh6ili2D3LpzbnXp
         zKNuvkzeqeJNJVu99CteRxkD3pGGLI8HnooAGfUq1im6uPkLEp+I31Ysz2MWL9RxCWiQ
         XIn4s54o+obKbo0yiIZQJwE8nGRgA/HuooUS22rvjz/s5klg4fwXmckAd5vJoJMreJlH
         EvouKoJpCLsSlxt433QYWUwXQD5jUJxcs8N8ztLd79XBVw/aeucu1XvYLOfrEdX/rRIh
         3VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589961; x=1706194761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6rGCGj38YEdXpsi6au5FMf/nUAYKbTHYROQ02xUMEc=;
        b=hI6okOMVRQUiaOAwKX5RMuXlorYxXGrT65+Q89dhySN5G7ujQmotLc0r1/fWKeAguD
         WEA0sYome8Iuvs8rG779YUTGouRuLA/ZxjP3VBZ6ag6H5AM+PZQ1fx1q/ebR5peUf3LS
         s5SOBJKriNEsKXyKXL9nurnKXcix56g6/yS4ris2QL8qHaKjlZCzyu1njaMfIg7FpdOq
         6A2NpMbuYDJib+L2YKh59fHvNStPb0xpldCyu1hmV9/+6kr+HlzhN563Bfyt918zSZAJ
         866RXu7IrCx9ouqHM8TfPVtYpFSYEAG4R0Bq7xKUdqkykfYFxa/KOxjIki6WViKtV4lt
         ksNw==
X-Gm-Message-State: AOJu0YxE1ELF56U+Pt5Uob/2r3fe48ftT2G34U2BRmoXpUGTW87X1t/0
	FnBsuvF6WyYt8JxDJ+vQajz1mPseNJJvxbJqvX+M4JZPoO8xl6Mx4K+oDER3vm9naKjU8ke5MYl
	xB6X9COYFjkI7NyeaSMONdAmDIV6PBlGWVKGl
X-Google-Smtp-Source: AGHT+IHtQJZIhYWo20RfWorkKjfr5BHeQ+VsCtRIUwXOCTZ4aOM7H6cuXBtOcWoP3jUZY8xgehvROMlmzSA3U90VP98=
X-Received: by 2002:a05:6402:1d91:b0:558:7f0f:aa70 with SMTP id
 dk17-20020a0564021d9100b005587f0faa70mr92826edb.5.1705589961035; Thu, 18 Jan
 2024 06:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <Zakq-54DFdPu0c2U@tiehlicka>
In-Reply-To: <Zakq-54DFdPu0c2U@tiehlicka>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Thu, 18 Jan 2024 06:58:42 -0800
Message-ID: <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> Dang, forgot to cc linux-api...
>
> On Thu 18-01-24 14:40:19, Michal Hocko wrote:
> > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > [...]
> >
> > before we discuss the semantic, let's focus on the usecase.
> >
> > > Use Cases
> > >
> > > An immediate user of this new functionality is the Go runtime heap al=
locator
> > > that manages memory in hugepage-sized chunks. In the past, whether it=
 was a
> > > newly allocated chunk through mmap() or a reused chunk released by
> > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memor=
y with
> > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)=
[3]
> > > respectively. However, both approaches resulted in performance issues=
; for
> > > both scenarios, there could be entries into direct reclaim and/or com=
paction,
> > > leading to unpredictable stalls[4]. Now, the allocator can confidentl=
y use
> > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of h=
uge pages.

Aside: The thought was a MADV_F_COLLAPSE_LIGHT _flag_; so it'd be
process_madvise(..., MADV_COLLAPSE, MADV_F_COLLAPSE_LIGHT)

> > IIUC the primary reason is the cost of the huge page allocation which
> > can be really high if the memory is heavily fragmented and it is called
> > synchronously from the process directly, correct? Can that be worked
> > around by process_madvise and performing the operation from a different
> > context? Are there any other reasons to have a different mode?
> >
> > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > e.g. non blocking one to make sure that the caller doesn't really block
> > on resource contention (be it locks or memory availability) because tha=
t
> > matches our non-blocking interface in other areas but having a LIGHT
> > operation sounds really vague and the exact semantic would be
> > implementation specific and might change over time. Non-blocking has a
> > clear semantic but it is not really clear whether that is what you
> > really need/want.

IIUC, usecase from Go is unbounded latency due to sync compaction in a
context where the latency is unacceptable. Working w/ them to
understand how things can be improved -- it's possible the changes can
occur entirely on their side, w/o any additional kernel support.

The non-blocking case awkwardly sits between MADV_COLLAPSE today, and
khugepaged; esp when common case is that the allocation can probably
be satisfied in fast path.

The suggestion for something like "LIGHT" was intentionally vague
because it could allow for other optimizations / changes down the
line, as you point out. I think that might be a win, vs tying to a
specific optimization (e.g. like a MADV_F_COLLAPSE_NODEFRAG). But I
could be alone on that front, given the design of
/sys/kernel/mm/transparent_hugepage.

But circling back, I agree w/ you that the first order of business is to
iron out a real usecase. As of right now, it's not clear something
like this is required or helpful.

Thanks,
Zach




> > > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec5640=
4faca29a82689c77
> > > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa73337409961=
81268b60a3a
> > > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3b=
e4b3a9bd2af
> > > [4] https://github.com/golang/go/issues/63334
> > >
> > > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gm=
ail.com/
> > --
> > Michal Hocko
> > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs

