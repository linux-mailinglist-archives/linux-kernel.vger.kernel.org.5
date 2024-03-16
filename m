Return-Path: <linux-kernel+bounces-105120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E587D957
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756371C20DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7D101CA;
	Sat, 16 Mar 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2/4BXcI"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18346D27D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710579205; cv=none; b=qVZxfxKtAzAxhoxdXQFl+T6qohnUqd7zBX0UkHBb/RxYVvg4j8ZP8pYCns7Th6C7ECIu/D978Gxe9YjWAXQFxG6Mi/+y28qNbMq3j/+vtIpktW2PY4/ZImer5GtW/xrS5XbQovgNl5ZnRMK2uUyIV3f+fzjHv5zvkbrozsJlzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710579205; c=relaxed/simple;
	bh=wHUTHNc07PezMVLkkhjoRQypSZ8VsGyAff7iodAz+kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgVTSF1jnhjQUJjkxOjEPpvpbSelbGxb23WAvvU9zbQ8WxtQgdgn7iSK0Ob+s439cieea1ctf9L26sqAYIFULjjFLA2xmCXQjvmafSotjSDrctLL4XQL1RWtrSi23ouH9hoITSZApbXi1yuR0nDFyNVEYq7P4YUfk+PxpxJ1nSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2/4BXcI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51381021af1so4075922e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710579201; x=1711184001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8eSkWTfP59vnIUbclyKhpYHVhfdow8/oolocAIg65U=;
        b=H2/4BXcIkxx5Rkl+Jdd+NzwC9/v2FBicbT11ubzww63C62ypBwBg/raL6y2cJHC053
         9WV9oLLQoXethJ+M+zvnjtiMO8Cdo6yJ0wZWoFDxqaFn7kMGbKxXnK6G7hzeDLfZtXxf
         HDBazV96QehCbOOo4GXfiG18Esyskr/noC4MUOnEM5qymigZaH1H58TTEqYMk17blWXj
         YaLdkpHuqjVjp6WZvXCw/ub64QM55olLGlvzhGH6DWNlv9QQ997FcslE4qyZiFuLFH/y
         kFUqQIh8uhGhzqUuU4bXsTpvsLYBW/eRmQYVqz1237ELDU+3ag8yDpmcvjsSSIzQ7Hkn
         az3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710579201; x=1711184001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8eSkWTfP59vnIUbclyKhpYHVhfdow8/oolocAIg65U=;
        b=A3X2OVaKzSyLqiMpymBaNfeGptDWQKG7zbg64aA/BylIbzD6k309+yK1z5VHf7m1Be
         nzvoiicsKO2pr0Kv0en2bbllDj51pYbJ/2/u1T963gu+Q+ZyTuQS2N39T4jl+hEdhz4H
         d52q9+UfoS6j0nwtdBrzQB4+kT1D4N4nJLheu2cB5QJy0D4aBRhQwd9LvO8IbW0FCxWY
         QFI4eZuelQq4Ms5aK7AD+diAhzanICtwus4YVA2Wfznz5A/1fZSvsLQYqkPKZSHUv3wJ
         kbZG3QewOaSojbA8+UabB9isoSh8BWvQsXTIdRZ8eHDBP579R9YoXcvwhYSTw1vxMLzR
         JTGg==
X-Forwarded-Encrypted: i=1; AJvYcCV+fvaKvhKO8T3W60wwDvfKjz5QqMvNZJMy4ixdCEBUkjEysV6zx/TYO/RQwBwmrYFxgj2dlcvjNm3EP/iSWCW+CblzyV0IlOb6Pg0A
X-Gm-Message-State: AOJu0YzhOfM/DEaUS64mbMq5ojHuu6C1MUiGrQ8NSZd2FwTMJM5o+cn0
	gr0SFwlMTtzzPNaKkHvzgN048ukhVqyr1+z9VzjHX6SA27Hfh9JAr4Kp47QVCYeS/CEqv4D2cPH
	CIfXitTq2SAWLWTBEqFlrhtyVTAzqJmP5jEY=
X-Google-Smtp-Source: AGHT+IGjvXruDfnotjhsLbmyjGJkGYH/q4daVVKkdvgNPDY3yAK2fMQwJbjJuZXPxjKfT6O7HgnRuiv+HdaPJAi0SNA=
X-Received: by 2002:ac2:5617:0:b0:513:d20a:daf5 with SMTP id
 v23-20020ac25617000000b00513d20adaf5mr943872lfd.49.1710579201047; Sat, 16 Mar
 2024 01:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com> <ZfRDJTrFJq3KSbIB@casper.infradead.org>
In-Reply-To: <ZfRDJTrFJq3KSbIB@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sat, 16 Mar 2024 16:53:09 +0800
Message-ID: <CAGWkznGiVrqMs9fX2WGG9QsfTm72ffFj-cWXSUo3azrgeBOgAg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 8:46=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 14, 2024 at 04:39:21PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Panic[1] reported which is caused by lruvec->list break. Fix the race
> > between folio_isolate_lru and release_pages.
> >
> > race condition:
> > release_pages could meet a non-refered folio which escaped from being
> > deleted from LRU but add to another list_head
>
> I don't think the bug is in folio_isolate_lru() but rather in its
> caller.
>
>  * Context:
>  *
>  * (1) Must be called with an elevated refcount on the folio. This is a
>  *     fundamental difference from isolate_lru_folios() (which is called
>  *     without a stable reference).
>
> So when release_pages() runs, it must not see a refcount decremented to
> zero, because the caller of folio_isolate_lru() is supposed to hold one.
>
> Your stack trace is for the thread which is calling release_pages(), not
> the one calling folio_isolate_lru(), so I can't help you debug further.
Thanks for the comments.  According to my understanding,
folio_put_testzero does the decrement before test which makes it
possible to have release_pages see refcnt equal zero and proceed
further(folio_get in folio_isolate_lru has not run yet).

   #0 folio_isolate_lru          #1 release_pages
BUG_ON(!folio_refcnt)
                                         if (folio_put_testzero())
   folio_get(folio)
   if (folio_test_clear_lru())

