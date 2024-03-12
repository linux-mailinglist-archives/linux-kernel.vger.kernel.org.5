Return-Path: <linux-kernel+bounces-100635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E48879B05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4889B22F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2988139577;
	Tue, 12 Mar 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hItb5obg"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37C1386D8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267092; cv=none; b=eLyq2L2Ena34UcsoZezvCqVXJnV+Ae4LgK5rt+1QqsVCWAu7Kbv169+706awg4HDMIGBVt5q9896seTjIpO2DR1OcljskV3MxlSixVeDf9KzymQiq82p3q61R4MvzMgv3DTtYXQ0Nzko8zyrAs85ByMWbS1sabi0EGfw2HmZzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267092; c=relaxed/simple;
	bh=ClDlP3smAv1X4jMWrBHkgaTmWKeGG4uG9hpj1wGBbXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNlsRi0yUkJsD2+nEj6p8z1uGrFbLwVT7l+kZcYVS4mIwzfcuPBLDK8ZBbZ9ZQuStZ2YWcU4oPYBc2Uo+wZtl2XfeHrFGwCao2L3aXfV7rcw4BEXF+q2xQFzlyoLIJZhPuTLFCfMV8pFs0voyfh4GdNUpA37v9CRE/3GMrf07tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hItb5obg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2991e8c12so1054291fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710267087; x=1710871887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClDlP3smAv1X4jMWrBHkgaTmWKeGG4uG9hpj1wGBbXo=;
        b=hItb5obg0VcyQtwThuLHjvNy+3Qft/s7DjsTuhN+7I4+XGIXdqilTf6J1pv9fp6ykd
         lDf4Zj87TaX/e+/Tx+N8zhlL86g6bykkdK6EWoixAf/96Wul6Df5V6tthBWfrroVPvba
         jeexNo7nkb3shA4wcU542qtmnSz+9LVrBQa3rg0p+tivMOV/mHRnKAhyp11mh0hbpbRe
         cVkLg3us5oY7/vgegnk941a7ma2W+9bIH9vl+sfTmp3MwKfwqVvEAQDZ63g8RB9KrNs1
         X6uJ4tKeBPiX/KIvOUe1XFROoc5mtneXkTFznyUpXBJQjFXxPavoKV0k1BFUQqJ45bJ8
         02Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710267087; x=1710871887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClDlP3smAv1X4jMWrBHkgaTmWKeGG4uG9hpj1wGBbXo=;
        b=JCIt4HHfOZgsD8oRK+aNl6szUR9ekv6NErO0i9aMpdszTY4zRoAXzHF2Cd3Yq94PKb
         8PqUoyskRHJ3YkAZHq7KrgF43arAodnPiSipWFZOMsGkQ0mPGA1z95s4++DebIqqXqG1
         OAIuym4vh/JUq+TInMp8pTWe61U9oI1rT12YiS9ZVhPUNwVcJ8WXFQU18Z1EKpMC9Ktc
         /gj4rnYRhv/1AUpPSOtZxigQ2/Swk47oGmiTjrljEuGS2rBAf3hh3Edzb8yp0rWdjFys
         A8nMT6XufU7LzTpJv6ij0QyTyb+iLDXrV7YUy2kgeR1GsO2fGCFm7B2iROAYXkzttEeo
         pErA==
X-Forwarded-Encrypted: i=1; AJvYcCUwjwChuKSlHeSHJaUTfHBq3Rp/E30h4tbHY9gP2bIKzKvL86zrs9W8WmKI2X+VPOJSCLd2V1QKojFmqM6DM8iqDyjSTEow2RUTGxhP
X-Gm-Message-State: AOJu0Yziql1bjTS3zGbvxgUxkDBHD1taYgNVLV3BUV9CrD9K7Y3HpTdN
	j/jwffr6Fou/xYumkDUi371yswlTm6mkq6CB4VwwcZVTU2oDnOTDOpwFw6ElK7/4Re7x+wQZM35
	rUcN98NrRTvopU32E5efOHUv5KOCAyZOzD+pT1A==
X-Google-Smtp-Source: AGHT+IG5phwWtKzG7Qn8SCd38fKlm0T82meI6dpteEwueBcej3WDzgs7PvhaHkNK5lcZJgN4BCTdYivMSrjkWh/EdOQ=
X-Received: by 2002:a05:651c:324:b0:2d2:31a8:cb1a with SMTP id
 b4-20020a05651c032400b002d231a8cb1amr113200ljp.13.1710267087555; Tue, 12 Mar
 2024 11:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
 <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com> <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
 <37ed1ddd-f1d0-4582-b6c5-2f4091dc8335@redhat.com>
In-Reply-To: <37ed1ddd-f1d0-4582-b6c5-2f4091dc8335@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 12 Mar 2024 19:11:16 +0100
Message-ID: <CAKPOu+_EwyQEEVV9ULEkncp3727eLGvqD5aswpkG5CtaZ=oJBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:33=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> Just curious: why? Usually build time, do you have some numbers?

(This has been discussed so often and I thought having smaller header
dependencies was already established as general consensus among kernel
devs, and everybody agreed that mm.h and kernel.h are a big mess that
needs cleanup.)

Why: Correctness, less namespace pollution, and the least important
aspect is reduced build times. However, the gains by this patch set
are very small; each optimization gains very little.

Some time ago, I posted a much larger patch set with a few numbers:
https://lore.kernel.org/lkml/20240131145008.1345531-1-max.kellermann@ionos.=
com/
- the speedup was measurable, but not amazing, because even after that
patch set, everybody still includes everything, and much more cleanup
is needed to make a bigger difference. Once the big knots like
kernel.h and mm.h are broken up, we will have better results. And as I
said: build times are nice, but the lesser advantage.

Anyway, this first patch set was so extremely large that nobody was
able to review it. So this patch contains just the parts that deal
with mm.h; later, when this patch set is merged, I can continue with
other headers. (I already have a branch that splits kernel.h and I'll
submit it eventually, after the mm.h cleanup.)

> I'm not against splitting out stuff. But one function per header is a
> bit excessive IMHO.

One function per header is certainly not my goal and I agree it's
excessive; but folio_next() in its own header made sense, just in this
special case, because it allowed removing the mm.h dependency from
bio.h. Removing this dependency was the goal, and folio_next.h was the
solution for this particular problem.

> Ideally, we'd have some MM guideline that we'll be
> able to follow in the future. So we don't need "personal taste".

Agree. But lacking such a guideline, all I can do is make suggestions
and submit patches for review, trying to follow what seemed to be
consensus in previous cleanups and what had previously been merged.

> For example, if I were to write a folio_prev(), should I put it in
> include/linux/mm/folio_prev.h ? Likely we'd put it into folio_next.h,
> but then the name doesn't make any sense.

True. But since no folio_prev() function exists, the only name that
made sense for this header was folio_next.h. If folio_prev() gets
added, I'd say put it in that header, but rename it to, let's say,
"folio_iterator.h". But right now, with just this one function (and
nothing else like it that could be added here), I decided to suggest
naming it "folio_next.h". If you think "folio_iterator.h" or something
else is better, I'll rename and resubmit; names don't matter so much
to me; the general idea of cleaning up the headers is what's
important.

> The point I am trying to make: if there was a single folio_ops.h, it
> would be clearer where it would go.

Maybe, but IMO this wouldn't be a good place to add folio_next(),
because folio_next() doesn't "operate" on a folio, but on a folio
pointer (or "iterator"). Again, names don't matter to me -
ideas/concepts matter. I'm only explaining why I decided to submit my
patches that way, but I'll change them any way you people want.

Max

