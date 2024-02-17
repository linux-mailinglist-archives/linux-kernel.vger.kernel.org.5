Return-Path: <linux-kernel+bounces-70115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A55859392
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5711428375A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C98002D;
	Sat, 17 Feb 2024 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa8sVmJB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE36D1AC
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708211716; cv=none; b=dhwlBEDI0eL/5a8eMKeM/zkM1nK2UMgvvRd0S/Z1cBU1ko/SJx3lSDpxA4SdAIPyflLScdxkSBlZGeTYZtZQVL3gtr9MV+eGwKCLgIclLbiD0/69t4+VZWU+DrcqpiSzsQm5wVRwWIXOXTSF+r/r5awii3YDFw8wlZq1NZhcn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708211716; c=relaxed/simple;
	bh=NLPW/g6W/p0zXhNLx5jc+mTvewtUjS2JPEu4Nb74JIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkxP5hwBy/zMsk52QNbS44PGyvNzaoKaCKquTfr1Oiq5eGUereUVfDxb8WPLjr8ADZpv0HkVmUYqF/1EPumeWlH9aT1p8xd8tawMgFrWIO3aJ0r5VVUmmdyZMqBuSL+yFVbTDUH2ds0FKQMuelc3h3dEObF2VyR09PIl1OhG1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa8sVmJB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51147d0abd1so3528812e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708211713; x=1708816513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJvonYTzCl7xp2PkiG/jmRrw2+4vNhq8HjWyw9v0bD0=;
        b=Wa8sVmJBjuajbwUqpHo2GZwev5oVjsR8AKkQmscnv1+kesBTEdLowLAjRX1393N22F
         F+RYuzvoQef2xEce8FlNl90YCx6e5mPptox/nDSqjUOay31f6OMqACGJbXq7jN9nsqo4
         xDaE5pgIKVVNUfifdOmDsgcK95UKTZuVHWTppR+ifbE+QlyEpFBSwB2bfRulm7NVaSsh
         1MMnsZJlXQKYfO0vEQ8JIIYqqCghVVlYu7Plr1UC65uKex2HX2zEnWINoMvMixNQDE9j
         n+g6s5D+ZweGZVX5lJme+7X4Wqjp213OdQG5xVSfOkXc6iA+T5bRoTxSIUAvYoIxvsyy
         aSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708211713; x=1708816513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJvonYTzCl7xp2PkiG/jmRrw2+4vNhq8HjWyw9v0bD0=;
        b=Wt8Yu+jmd5LsSdJobIVajLWYTwoGhjv0aaUJjLInwuAbHbBbBnTqKVexkw+PioHQq0
         gLrD9P8vjiXevqYFddi0XD+YrA0j71BzfNm8ixKB1lD/X+5As71xsK/flHAQLnkBsztd
         n/jhsb7/WO/NvOOqAH+2xCt8GYrXVhdHeaz9ooh1/uT0Pe+kWuNCBfTfGBv2ZHSs3iDR
         Fp2/TWhz4/igsenxwSe2y+xhF1HEFSfiPVKJYGfWOL9SKgAYISHjn1IA51RnGIxHTxOs
         Sq7QyCWO0RyklDTTYZqaYRT+CPAFJV8BuGJB9MItg3iohVxvCWVc/Q+0TCkIrtRJ/0V1
         G1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVkUu/RU6BNp6BArR46gNkXH/wpUoWduzfneOkZuk+0eRWxITEFACXahYwNfrkMFSJO1+qVqWnojuGUowmBawgkAaQ3inwXcfFJbt7N
X-Gm-Message-State: AOJu0YwoqqyRO/v9ufVzyscrb0yiktZKhWOThJEZZHJsTjRq+DXg5syc
	N5ytO0JFfSUUK55tHxZW6WZFoMbJjFCIdhsyPC7erfiL3W49/+tDxGbQvhUd0Z/Vv7IyDoLkibQ
	+qUFCQdXzKEDqNYc/wIVbKjNdPWn0vWGUYMsM
X-Google-Smtp-Source: AGHT+IHpwwwxmZeH8i63HKX9Y9eDBXBqmFtWnPfRe4unf/ap00AxwwGeRckJWtJzJckk4sKjPna8wKb0Sjv41t0PLBQ=
X-Received: by 2002:a05:6512:104f:b0:512:b03c:426 with SMTP id
 c15-20020a056512104f00b00512b03c0426mr698lfb.30.1708211712560; Sat, 17 Feb
 2024 15:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217053642.79558-1-21cnbao@gmail.com> <ZdB0-fnlSyGgH2cQ@google.com>
 <CAGsJ_4xo9Z4zxgDUZAzbCZ83Y1QYXZxRKbTNU_4xDP0+eP0V=w@mail.gmail.com>
In-Reply-To: <CAGsJ_4xo9Z4zxgDUZAzbCZ83Y1QYXZxRKbTNU_4xDP0+eP0V=w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 17 Feb 2024 15:14:34 -0800
Message-ID: <CAJD7tkbHrMzi0z0SzQJj32cDrx4tyH5=_o41GM6JGf9DjahkYg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, senozhatsky@chromium.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 2:19=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Feb 17, 2024 at 4:57=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Sat, Feb 17, 2024 at 06:36:42PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > We used to rely on the returned -ENOSPC of zpool_malloc() to increase
> > > reject_compress_poor. But the code wouldn't get to there after commit
> > > 744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
> > > new code will goto out immediately after the special compression case
> > > happens. So there might be no longer a chance to execute zpool_malloc
> > > now. We are incorrectly increasing zswap_reject_compress_fail instead=
.
> > > Thus, we need to fix the counters handling right after compressions
> > > return ENOSPC. This patch also centralizes the counters handling for
> > > all of compress_poor, compress_fail and alloc_fail.
> > >
> > > Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
> > > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > > Cc: Nhat Pham <nphamcs@gmail.com>
> > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  -v2:
> > >  * correct the fixes target according to Yosry, Chengming, Nhat's
> > >    comments;
> > >  * centralize the counters handling according to Yosry's comment
> >
> > Yet Yosry is not CC'd :P
>
> terribly sorry. I thought you were in my git send-email list ... but you
> were not...

No problem, I caught it on linux-mm anyway :)

>
> >
> > The patch LGTM, but it won't apply on top of mm-unstable given the
> > amount of zswap refactoring there. I would rebase on top of mm-unstable
> > if I were you (and if you did, add mm-unstable in the subject prefix).
>
> This patch has a "fixes" tag, so I assume it should be also in 6.8?

Hmm that's up to Andrew. This fixes debug counters so it's not
critical. On the other hand, it will conflict with the cleanup series
in his tree and he'll have to rebase and fix the conflicts (which
aren't a lot, but could still be annoying). Personally I think this
can wait till v6.9, but if Andrew doesn't have a problem taking it for
v6.8 that's fine too.

