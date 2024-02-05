Return-Path: <linux-kernel+bounces-53915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08E84A7FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D4F1F2B827
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB61339AF;
	Mon,  5 Feb 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqYM02P9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2351339A4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164833; cv=none; b=meD3/Ri7p1Bm5vdJ+Xn9i2w55qdTc2tVGHjniA5WV58EfPgBdgAPhmOjjvq7ZQwGKGvHKk0FOVg5Rw00/+fL+R0Hlms5snGXNPva1T8bhcUuDBzOPB78IkeAu2ULZmwjFwWn6RBnDXphIvUDY46+v61nKCqRbZriGjiEOw1i9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164833; c=relaxed/simple;
	bh=0XjG1RQUVjgj2DA3G0T2Y3UPfKUu84AOrDd8UoQyLxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3FtDH6siPtD+DqWQqwxCNZfTLNXUrp3T9uJPGgOdSuT5o9PEUjF6IRhdcdmYb1J0G+xW5F+B55qlsQ/neRcvWaPpbI6unDBpr6gdC3eLIaif1NFS90kPZGJxb2sWFPvN9y/uw2CJh8YiGL036kPLg6/BVYF0E5IYKV/+qcME/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqYM02P9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so496a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707164830; x=1707769630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XjG1RQUVjgj2DA3G0T2Y3UPfKUu84AOrDd8UoQyLxo=;
        b=JqYM02P9QaRe0naNwHrG9DejC2Hepul2p+MmI/jmR3BHsNAuT4lxFovv0IioZhYiiT
         GcEtVUxuCVx3FpY7+IknvBAS1qd4WNqYBMK+rUmwCMWR26rvdeLFq70Rm3g71T1Ee4Oz
         qM0uNfUQot0ED+eFST/I69qfkKH2Da2/PVgZtHwC+bF65lhkWG0f684bdMRxSjpcGFim
         hofNMJVWVqxrKoS99y/HtRNe00brVVTNsNW+tSQeVDn96pajavbBjyoAxgqOjkpvebae
         E/ufDPgSOKZz84bQCIsMxgeoHNbLfaePQppnemTlfZoPW1h0CnXCn3U1nSSNxUlo+/B0
         fLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707164830; x=1707769630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XjG1RQUVjgj2DA3G0T2Y3UPfKUu84AOrDd8UoQyLxo=;
        b=v5yjeHY7To5ZbQ4S96yx9TQVaypP2RFfueFHGA8veYYyLMXsiKWOuJ30F3CB7HH5B8
         KcoR2EFvPoR6++m/hGs/g1uTPp1sPARaOev5WBNn7gayL/BDXqLAo7Ou9+Kt0pduAL4d
         v+mxUvUiljoU3Gjkj0+kwUP7zzSuQXrdARd5SuVXg2wsShS+Yj1n+UJ/oZWNyeGhhq/n
         kBwDsERm3PQK/DSj2SKZF3xatSwAGKajUZp4eBl8RidGn9c2SN0sjwPFmKYRMYdqGyLW
         avplN0T+7uOk+301w8UAJg85Em96uE9XPEhuQDVz0Lc0vS1zcQGyEvXgITkDiK590q4C
         K75A==
X-Gm-Message-State: AOJu0Yw+/WWVV+eMNQdcUxz3No9rDAXXbirPWXkItPoOmMFkHUIqu1Ef
	C7SjpZfS4BiOLqXztuSIXVFekvwKtaawEQ38OSNKLIM72JyQ/ELo3So967EfrdWHRdSG0Yj8EEB
	Cbmi8yuA1k0HaK2s3398G8w19abtIhQrVYabc
X-Google-Smtp-Source: AGHT+IGEau1j9sSQ9IGKaPyso8HXCatnAanFJ2rT2oGvMA9YeX4CA5AWVPmOfYKVQcL9LvIw1fhAU/vg8ybXYlhsfPs=
X-Received: by 2002:a50:a6d2:0:b0:55f:8a86:e694 with SMTP id
 f18-20020a50a6d2000000b0055f8a86e694mr6040edc.3.1707164829753; Mon, 05 Feb
 2024 12:27:09 -0800 (PST)
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
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
 <ZcCuHmCh7a8fU6_3@tiehlicka> <CAHbLzkrkbbm-AqXuk0oFf4DD4CJeVqwtsgXq-RwuSDDUoMc+4A@mail.gmail.com>
In-Reply-To: <CAHbLzkrkbbm-AqXuk0oFf4DD4CJeVqwtsgXq-RwuSDDUoMc+4A@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Mon, 5 Feb 2024 12:26:31 -0800
Message-ID: <CAAa6QmRjqob=HQ1K4c+vP5iydM_VA-wd5NcoDLVuX=13NwedSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:43=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Mon, Feb 5, 2024 at 1:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
> >
> > On Fri 02-02-24 09:42:27, Yang Shi wrote:
> > > But if the partial range is MADV_FREE, khugepaged won't skip them.
> > > This is what your second test case does.
> > >
> > > Secondly, I think it depends on the semantics of MADV_FREE,
> > > particularly how to treat the redirtied pages. TBH I'm always confuse=
d
> > > by the semantics. For example, the page contained "abcd", then it was
> > > MADV_FREE'ed, then it was written again with "1234" after "abcd". So
> > > the user should expect to see "abcd1234" or "00001234".
> >
> > Correct. You cannot assume the content of the first page as it could
> > have been reclaimed at any time.
> >
> > > I'm supposed it should be "abcd1234" since MADV_FREE pages are still
> > > valid and available, if I'm wrong please feel free to correct me. If
> > > so we should always copy MADV_FREE pages in khugepaged regardless of
> > > whether it is redirtied or not otherwise it may incur data corruption=
.
> > > If we don't copy, then the follow up redirty after collapse to the
> > > hugepage may return "00001234", right?
> >
> > Right. As pointed above this is a valid outcome if the page has been
> > dropped. User has means to tell that from /proc/vmstat though. Not in a
> > great precision but I think it would be really surprising to not see an=
y
> > pglazyfreed yet the content is gone. I think it would be legit to call
> > it a bug. One could argue the bug would be in the accounting rather tha=
n
> > the khugepaged implementation because madvised pages could be dropped a=
t
> > any time. But I think it makes more sense to copy the existing content.

+1. I agree that the content should be dropped iff pglazyfreed is
incremented. Of course, we could do that here, but I don't think there
is a good reason to, and we should just copy the contents.

> Yeah, as long as khugepaged sees the MADV_FREE pages, it means they
> have "NOT" been dropped yet. It may be dropped later if memory
> pressure occurs, but anyway khugepaged wins the race and khugepaged
> can't assume the pages will be dropped before they get redirtied. So
> copying the content does make sense.

Per Lance, I kinda get that this "undermines" MADV_FREE, insofar that,
from the user's perspective, that memory which was intended as a
buffer against OOM kill scenarios, is no longer there to reclaim trivially.=
 I
don't have a real world example where this is an issue, however. Also,
not copying the contents doesn't change that fact.

The proper alternative, if you want to make the "undermining"
argument, is for khugepaged to stay away from hugepage regions with
any MADV_FREE pages. I think it's fair to assume MADV_FREE'd memory is
likely cold memory, and therefore not a good hugepage target anyways.
However, it'd be unfortunate if there were a couple MADV_FREE pages in
the middle of an otherwise hot / highly-utilized hugepage region that
would prevent it from being pmd-mapped via khugepaged. But.. this is
exactly-ish what you get when hugepage-ware system/runtime allocators
split THPs to free up internal caches.

Best,
Zach


> > --
> > Michal Hocko
> > SUSE Labs

