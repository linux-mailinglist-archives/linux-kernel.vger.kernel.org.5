Return-Path: <linux-kernel+bounces-53834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8D84A717
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EC91C2552D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCD62169;
	Mon,  5 Feb 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAHxywl0"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CB6167D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162211; cv=none; b=hkxl1cQjziADfCd+TRyL8lnd/7u3+m3E6LzjfaXxXPF7DxgdlxBvtLP0BqEBT0c2OhHkeW+YFfBNC8QfnNunxejmBaJ0hszw8xuKD3BFPwQcBSmeCqQMdp3k6eRvFWSG3uYyWAtKG5Sybh+HTSu5wsSzJ0hsuCnTy0ZDu0rDres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162211; c=relaxed/simple;
	bh=SEs89W3ZsiN5nh28B4MK5ZXClVSnTgcTsrh9yzKO/2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmugQY9p1V8/qUQvEv2eiyC5/wr1pH1EtF99Iv3YsFWHKZDia2l+lbvJNPX9RefoDwLPiOkPTApTg3E6UN+dZ/NBXDmPpsZdqMFmYMJEfz5hnX33dnvpozYdkgUn/WEpIepb8EOit6tEQXWM8c5Go6iX6r2sAxI6KQ/OGjdYMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAHxywl0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so3272560a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707162209; x=1707767009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEs89W3ZsiN5nh28B4MK5ZXClVSnTgcTsrh9yzKO/2k=;
        b=TAHxywl0QwtmsV+d1ifjBH5tn9HETIxmmRrvucWbRI8ZDYJBCcooSwSc05ISTaxoil
         EqCxw3NA9PFLN7sMct4efqVqvOfBQEDwkhSMZjMlnAHeghFyjVPF82gElLaUho+6sqji
         wnRFg1KMirFonSZAaX6nhtYPDDxAtHKUaAACUZFHSYfad/Fcu1R1zQ0GH0JjatlMRHtL
         VVukjN+tvQnfT8158wlfZmhcIsTZBgbBAmo61IBt1B7LUOTcNZy2P8ad4GKFgdDaSrW3
         RRfNSrO6sy7mobkOm95/5JcDOeBf/Ld5PLlE2Rkqdo0oWxlD+2+cNwV8Tl6g8PPKob2B
         6KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162209; x=1707767009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEs89W3ZsiN5nh28B4MK5ZXClVSnTgcTsrh9yzKO/2k=;
        b=BGXiQWJmiOY/Teqqoj1lG5Df/lY+tzPIkJB8cn7yruw8VAdgQ5ngY919ZPCYm5ldto
         O3COjlH86RORXPYO3BevEsVOBJsWKdOIunrEpZAZG2syb2qcnLvunnQ1xB03eb24cL1+
         bNf5QpSyH2XIsp3Ux90BNQbZYH/Z7A7j5Sl1I6aeR0UhrZaQgzNraYSPPDdw7vI+Ec+L
         gyF03uL6ot1zeUjh1tA/n7OnQHiwIGo4pgeAW3RTNoKPxoFAYuNZ3n4h6a6aEzFE9ouQ
         emrQfJwr7YHMVeZS7puzs89ub6FsymCebhj4YPMsxZFxTECndi5cjEiduJD9KpBJn0YP
         A7tA==
X-Gm-Message-State: AOJu0YwD1m61DTmccwIrwRu63YaLmaJf4FFrkHNEvVEpizf61z9ConWj
	fACvUdywmOigT3zs5aKkCPeOmClpUC26eFpmv++vgv4fRr+tQ1KmLQFtnTWkUX5WvPr8ifx1ZAl
	QI8kJvUMEaeI4/BFjx7aI4IS+UbUpbAuu
X-Google-Smtp-Source: AGHT+IE2hze5OaigTBbfAKMDuXNERMjICOmh5WNvtTWDsGUFoYob0bu1EEBGPnXNLn25Ldzg0WyxbYZ6TQnZcvEpU2w=
X-Received: by 2002:a17:90a:e2c5:b0:296:40c1:d7dc with SMTP id
 fr5-20020a17090ae2c500b0029640c1d7dcmr251247pjb.19.1707162209499; Mon, 05 Feb
 2024 11:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka> <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com> <ZcCuHmCh7a8fU6_3@tiehlicka>
In-Reply-To: <ZcCuHmCh7a8fU6_3@tiehlicka>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 5 Feb 2024 11:43:17 -0800
Message-ID: <CAHbLzkrkbbm-AqXuk0oFf4DD4CJeVqwtsgXq-RwuSDDUoMc+4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 02-02-24 09:42:27, Yang Shi wrote:
> > But if the partial range is MADV_FREE, khugepaged won't skip them.
> > This is what your second test case does.
> >
> > Secondly, I think it depends on the semantics of MADV_FREE,
> > particularly how to treat the redirtied pages. TBH I'm always confused
> > by the semantics. For example, the page contained "abcd", then it was
> > MADV_FREE'ed, then it was written again with "1234" after "abcd". So
> > the user should expect to see "abcd1234" or "00001234".
>
> Correct. You cannot assume the content of the first page as it could
> have been reclaimed at any time.
>
> > I'm supposed it should be "abcd1234" since MADV_FREE pages are still
> > valid and available, if I'm wrong please feel free to correct me. If
> > so we should always copy MADV_FREE pages in khugepaged regardless of
> > whether it is redirtied or not otherwise it may incur data corruption.
> > If we don't copy, then the follow up redirty after collapse to the
> > hugepage may return "00001234", right?
>
> Right. As pointed above this is a valid outcome if the page has been
> dropped. User has means to tell that from /proc/vmstat though. Not in a
> great precision but I think it would be really surprising to not see any
> pglazyfreed yet the content is gone. I think it would be legit to call
> it a bug. One could argue the bug would be in the accounting rather than
> the khugepaged implementation because madvised pages could be dropped at
> any time. But I think it makes more sense to copy the existing content.

Yeah, as long as khugepaged sees the MADV_FREE pages, it means they
have "NOT" been dropped yet. It may be dropped later if memory
pressure occurs, but anyway khugepaged wins the race and khugepaged
can't assume the pages will be dropped before they get redirtied. So
copying the content does make sense.

> --
> Michal Hocko
> SUSE Labs

