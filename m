Return-Path: <linux-kernel+bounces-149124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFE8A8C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4782A28276C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227372C861;
	Wed, 17 Apr 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGz1CYIV"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB081E895
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382461; cv=none; b=U/TCUKqNI+EPDxqTXaTHo7ZHAzyNnEodtNP5kL545V2hffjm9y2rrreYJgn6d9GI/nTx0EPmRbyhJkc2lFYRLv88FDh8EnDH4EF5BTGg81l3TkfQBsPNHbe9kssssLRVFzUIAYpALaPMfQX6UqbNa4CCR9IEIKXF1hFxgSWeDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382461; c=relaxed/simple;
	bh=0LwcQE74ewyrLEKr9qBB4PpxyrOcuzBZ+DsOu847dE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWALEma10ONM+eWmn8TKRBOb1efgAlDw2yfGt0ifcrkCkmz0PhGWWqAi3VVdxI6yFtyFLvDik0PGRm4qQuYyCGltSABDfEHfUlmhjOe0ql92mCF5e7ls870D6vAJNs+NmKt/uSq40RMx/9XHQ0ReUjDMG5fHabUhnwM/73o3hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGz1CYIV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so146a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713382457; x=1713987257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fyl6TqOQKc7y6AuWZSULZsHIQoiSS+3/2ZOsE3/WMtU=;
        b=OGz1CYIVBJ7Yid+XCiNzg/JS7CkywMy/vUxd27Uma5XD8ocezRYNhVWnLbbRclhQld
         kcV56jEIPe0jeUGyK9HO3p/dUqzTt00MrAMF98oidr3M0HSO2HGhsstXN6CAdaXtQzGQ
         SJSVJQMtG0wwWo5NtYnn+8IfwsIBI5mPmh3AydE7WpAB4Nila3KSELEX37E41C6yRpzC
         Cmss9vcSJRJ27OQ4EUng/UbpU5wp0M1vxdFnk3iWQgxTKQA1vGFdnNBChuilNt38vwLM
         lc5ff8bxkEjeS/mZRyJwpRzkYfQJ/c0FiWT3xZggyGqwcmBC7PuFnBAfkUyeGggjZiVX
         +n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713382457; x=1713987257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyl6TqOQKc7y6AuWZSULZsHIQoiSS+3/2ZOsE3/WMtU=;
        b=DQeGKJytyiE+YxWPZk/ZiBQZGmkCpcwQax3TdfcJRjb1k6xosOZ+ItycPYdig/gVMG
         MRScRmRwX1ED6qTO2z+vCPp/uDommOxDrkst0xX9B4ZdswaLmmy4fPhodpppsfHqrbO3
         Szn8xNC48NlolpKC0IRGQ5TaaBdug9ETQPoEiEvCgzncK8LR2fgWUk7bZAI+/vzghU6S
         RrbpVqpGHQxHzaPIKFupQtJCUOzSr7alqGEjRbJimS6VCPzCmMe1WdeNxmXdkj4EltXB
         PgqJD78n/2y8n8lhthijcierm5kb8aQPBuOuHlEYOTBAZtvi+pyUEN9OmRw/qnP9ldf9
         5q5g==
X-Forwarded-Encrypted: i=1; AJvYcCUNWOToZgPn9IhMAj3kgrE8mijNoaUtXDao0UO9knXG8fw0xhdMG/9+S5wP4jHmaFXDCwXjVA0JemgSQmeCoZei6q3Drf4Ut/OPqxIu
X-Gm-Message-State: AOJu0YxhgoK6gdPmMEKevqEJbW+qr4ENOw43aQz8kFvInB4qUHPC8Li1
	HhFtmo0hscs1fqiItTUvxfoK43nKVr/ZhnUzHkTU0kf/u6K57gaBynBXuStxM7+4s3FC48cSByd
	Xiy20XMItSO3CBl7Q04z0b68Dg47T4I1D2+S/
X-Google-Smtp-Source: AGHT+IF3BxF61WJZfffzn5eL5CSWhQKAZF34LWBLquyLGLML0FvYcr/UD2V+jp/gbT9bVgfJHdkvmNN7KBf/Xf/oMBk=
X-Received: by 2002:a05:6402:12d2:b0:571:b3fa:bf81 with SMTP id
 k18-20020a05640212d200b00571b3fabf81mr29493edx.2.1713382456805; Wed, 17 Apr
 2024 12:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118181954.1415197-1-zokeefe@google.com> <20240417111001.fa2eg5gp6t2wiwco@quack3>
In-Reply-To: <20240417111001.fa2eg5gp6t2wiwco@quack3>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Wed, 17 Apr 2024 12:33:39 -0700
Message-ID: <CAAa6QmSOum_0ZhyUq1ppguLp0jpEs0u1U843GkF==xMwaMGV4A@mail.gmail.com>
Subject: Re: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Maxim Patlasov <MPatlasov@parallels.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-01-24 10:19:53, Zach O'Keefe wrote:
> > (struct dirty_throttle_control *)->thresh is an unsigned long, but is
> > passed as the u32 divisor argument to div_u64().  On architectures wher=
e
> > unsigned long is 64 bytes, the argument will be implicitly truncated.
> >
> > Use div64_u64() instead of div_u64() so that the value used in the "is
> > this a safe division" check is the same as the divisor.
> >
> > Also, remove redundant cast of the numerator to u64, as that should
> > happen implicitly.
> >
> > This would be difficult to exploit in memcg domain, given the
> > ratio-based arithmetic domain_drity_limits() uses, but is much easier i=
n
> > global writeback domain with a BDI_CAP_STRICTLIMIT-backing device, usin=
g
> > e.g. vm.dirty_bytes=3D(1<<32)*PAGE_SIZE so that dtc->thresh =3D=3D (1<<=
32)
> >
> > Fixes: f6789593d5ce ("mm/page-writeback.c: fix divide by zero in bdi_di=
rty_limits()")
> > Cc: Maxim Patlasov <MPatlasov@parallels.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
>
> I've come across this change today and it is broken in several ways:

Thanks for picking up on this, Jan.

> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index cd4e4ae77c40a..02147b61712bc 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dirty_t=
hrottle_control *dtc)
> >        */
> >       dtc->wb_thresh =3D __wb_calc_thresh(dtc);
> >       dtc->wb_bg_thresh =3D dtc->thresh ?
> > -             div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh=
) : 0;
> > +             div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) :=
 0;
>
> Firstly, the removed (u64) cast from the multiplication will introduce a
> multiplication overflow on 32-bit archs if wb_thresh * bg_thresh >=3D 1<<=
32
> (which is actually common - the default settings with 4GB of RAM will
> trigger this). [..]

True, and embarrassing given I was looking at this code with a 32-bit
focus. Well spotted.

> [..] Secondly, the div64_u64() is unnecessarily expensive on
> 32-bit archs. We have div64_ul() in case we want to be safe & cheap.

A last-minute change vs just casting the initial "dtc->thresh ?"
check. It did look expensive, but figured its existence implied it
should be used. I must have missed div64_ul().

> Thirdly, if thresholds are larger than 1<<32 pages, then dirty balancing =
is
> going to blow up in many other spectacular ways - consider only the
> multiplication on this line - it will not necessarily fit into u64 anymor=
e.
> The whole dirty limiting code is interspersed with assumptions that limit=
s
> are actually within u32 and we do our calculations in unsigned longs to
> avoid worrying about overflows (with occasional typing to u64 to make it
> more interesting because people expected those entities to overflow 32 bi=
ts
> even on 32-bit archs). Which is lame I agree but so far people don't seem
> to be setting limits to 16TB or more. And I'm not really worried about
> security here since this is global-root-only tunable and that has much
> better ways to DoS the system.
>
> So overall I'm all for cleaning up this code but in a sensible way please=
.
> E.g. for these overflow issues at least do it one function at a time so
> that we can sensibly review it.
>
> Andrew, can you please revert this patch until we have a better fix? So f=
ar
> it does more harm than good... Thanks!

Shall we just roll-forward with a suitable fix? I think all the
original code actually "needed" was to cast the ternary predicate,
like:

---8<---
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fba324e1a010..ca1bfc0c9bdd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1637,8 +1637,8 @@ static inline void wb_dirty_limits(struct
dirty_throttle_control *dtc)
         *   at some rate <=3D (write_bw / 2) for bringing down wb_dirty.
         */
        dtc->wb_thresh =3D __wb_calc_thresh(dtc);
-       dtc->wb_bg_thresh =3D dtc->thresh ?
-               div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0=
;
+       dtc->wb_bg_thresh =3D (u32)dtc->thresh ?
+               div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) =
: 0;

        /*
         * In order to avoid the stacked BDI deadlock we need
---8<---

Thanks, and apologize for the inconvenience

Zach

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

