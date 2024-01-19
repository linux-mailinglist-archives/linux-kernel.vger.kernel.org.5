Return-Path: <linux-kernel+bounces-30690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8A3832319
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6821C22588
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067381362;
	Fri, 19 Jan 2024 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkgSH5yE"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4C10E4;
	Fri, 19 Jan 2024 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628805; cv=none; b=PA8Bx9h8F6dJauuFhNCq47q18Qi8AvO3uTMb+RZhe2YHYl+GvCVj1oczqpnoIWaR1ifN6zkFGbIz/Zd8f79b3I45ICbnIxoJeN7Z0LYjekJTMD8DUK9EmgZmDZXQBxIjQEN2ox44ZwRwoQeQsig3NUiLpZ/Gx1dXdWfftYNH2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628805; c=relaxed/simple;
	bh=AueCKfkK92AxG/6IJd7YrY+xmTeP8e01vZBo030LmM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNC4VOAw1Wx9i0b2nv05boCsWLs9DnvmKx/SY8z81GuXHrYNkf9MKUkJT+OVgre2po1yx3bKivzfRKhtQtPWyfi85GjXVbkc4PsY0nBPCYhsCg+ur/R4tcUXNU9xDUedKvMwftTTAWNJUtpdCrI/cnFf+ZwgVCuiao3sDFGnXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkgSH5yE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc2308fe275so305807276.1;
        Thu, 18 Jan 2024 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705628802; x=1706233602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AueCKfkK92AxG/6IJd7YrY+xmTeP8e01vZBo030LmM8=;
        b=dkgSH5yEgIV6JpG2oIt8UX0/G4OIv0SXYdpizvGHtAvtDj2/tfryrhH7qGvjiOl991
         BBphPpgWM/xqESJvy62XroOJml+wLY1hkvboyL9o0w8woU8SR17uBnXpvRuV+lmhdpfd
         uYMeb5CaX3l9omjUe/M1aB+ht8sdE/zoLRxd8bGqzagyHdPOMByKAJi/cVBEGVqgA3LP
         6F2Wjx3XTGFf7xwK2mF+5I7awaVe1hco2U4FRlcUF46gQU3SeDWCz3AVqBKHcaAi68iK
         hnHb2G5xodSrdrDehqYE4tEHZ/agVM0f56Ow5L3xXL4DtxwM9wvjVK5MeNETKaI8sU0p
         83rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628802; x=1706233602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AueCKfkK92AxG/6IJd7YrY+xmTeP8e01vZBo030LmM8=;
        b=wXdjprGAQTNThokt5sz2FAgqb0szUqGWtjfDpde6wF/zm4TVPkXSdYjSVFzOH1qYdz
         omO0KR+lcLEd6x/O0TGfnASWZX/T0g6QkWgPez/hCPsv6U995DKNDF3Gf+ESV7UrKSOY
         dK+C3sTBsVqBYLFAkdO2qYjyWMwkL3rkC6wLbSu23wWSR5j1wZM6QzMNDBGAU/EbCvwo
         icjZ7fb5fjwCvQXfYJ9lvHRdAUmjV1akxrmSeiiVvflvGZs88g/yZntXZq7SLvGF6Y9z
         95sFfG53D1RHckOXZPs+dhWRb99gjURVqHu/21lXLFUiMIWqj1hjnTmuOYDocYCPY3xo
         TznQ==
X-Gm-Message-State: AOJu0YwjX6kLstNDAfEys0XKmYubhSt/i5zgOv6L1Eq/WXV2UgwtEsEz
	G5Kq0oUvDN+L/CTVIXyNPD8UhK1b+Pe5ubR74t4L4INW1J6c3Usm6ka84Y1GsvcWB6qVM+LKKnj
	xoT6C+zHIqRY/kQHV1rO+4jdbI9w=
X-Google-Smtp-Source: AGHT+IG8H/gwTuHimb/wtOeta/7zcplF6H/nP9A9ZRsXDnkTs2vERVUIyr7VvrS0nX9v6FcSiEemCKNfYILJ6WWk9ts=
X-Received: by 2002:a05:6902:1b0d:b0:dc2:1c77:436c with SMTP id
 eh13-20020a0569021b0d00b00dc21c77436cmr1627083ybb.97.1705628802569; Thu, 18
 Jan 2024 17:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <Zakq-54DFdPu0c2U@tiehlicka> <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
In-Reply-To: <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 09:46:31 +0800
Message-ID: <CAK1f24kUUrVBzAHjiC8-v3s_33P6dO8UFRL1FVzR_8C=NJn0aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:59=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> =
wrote:
>
> On Thu, Jan 18, 2024 at 5:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > Dang, forgot to cc linux-api...
> >
> > On Thu 18-01-24 14:40:19, Michal Hocko wrote:
> > > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > > [...]
> > >
> > > before we discuss the semantic, let's focus on the usecase.
> > >
> > > > Use Cases
> > > >
> > > > An immediate user of this new functionality is the Go runtime heap =
allocator
> > > > that manages memory in hugepage-sized chunks. In the past, whether =
it was a
> > > > newly allocated chunk through mmap() or a reused chunk released by
> > > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back mem=
ory with
> > > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPS=
E)[3]
> > > > respectively. However, both approaches resulted in performance issu=
es; for
> > > > both scenarios, there could be entries into direct reclaim and/or c=
ompaction,
> > > > leading to unpredictable stalls[4]. Now, the allocator can confiden=
tly use
> > > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of=
 huge pages.
>
> Aside: The thought was a MADV_F_COLLAPSE_LIGHT _flag_; so it'd be
> process_madvise(..., MADV_COLLAPSE, MADV_F_COLLAPSE_LIGHT)

I apologize for the misunderstanding. I will provide the correct implementa=
tion
in version 3.

BR,
Lance

>
> > > IIUC the primary reason is the cost of the huge page allocation which
> > > can be really high if the memory is heavily fragmented and it is call=
ed
> > > synchronously from the process directly, correct? Can that be worked
> > > around by process_madvise and performing the operation from a differe=
nt
> > > context? Are there any other reasons to have a different mode?
> > >
> > > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > > e.g. non blocking one to make sure that the caller doesn't really blo=
ck
> > > on resource contention (be it locks or memory availability) because t=
hat
> > > matches our non-blocking interface in other areas but having a LIGHT
> > > operation sounds really vague and the exact semantic would be
> > > implementation specific and might change over time. Non-blocking has =
a
> > > clear semantic but it is not really clear whether that is what you
> > > really need/want.
>
> IIUC, usecase from Go is unbounded latency due to sync compaction in a
> context where the latency is unacceptable. Working w/ them to
> understand how things can be improved -- it's possible the changes can
> occur entirely on their side, w/o any additional kernel support.
>
> The non-blocking case awkwardly sits between MADV_COLLAPSE today, and
> khugepaged; esp when common case is that the allocation can probably
> be satisfied in fast path.
>
> The suggestion for something like "LIGHT" was intentionally vague
> because it could allow for other optimizations / changes down the
> line, as you point out. I think that might be a win, vs tying to a
> specific optimization (e.g. like a MADV_F_COLLAPSE_NODEFRAG). But I
> could be alone on that front, given the design of
> /sys/kernel/mm/transparent_hugepage.
>
> But circling back, I agree w/ you that the first order of business is to
> iron out a real usecase. As of right now, it's not clear something
> like this is required or helpful.
>
> Thanks,
> Zach
>
>
>
>
> > > > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56=
404faca29a82689c77
> > > > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa733374099=
6181268b60a3a
> > > > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca=
3be4b3a9bd2af
> > > > [4] https://github.com/golang/go/issues/63334
> > > >
> > > > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@=
gmail.com/
> > > --
> > > Michal Hocko
> > > SUSE Labs
> >
> > --
> > Michal Hocko
> > SUSE Labs

