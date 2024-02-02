Return-Path: <linux-kernel+bounces-50679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72689847C79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C685FB2265D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF0126F18;
	Fri,  2 Feb 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgwG4Fxq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6655FF01
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913864; cv=none; b=KOzomzdfVqwhOJS7TArc0bNrf8OMwugXE9YqOqvZx5SDA7ZZph28JRirECUd9R8yWhzSnA6izR9MHSpgbsvuuaZsxnNRlXleqeMDIezUQmM0WyTailLxHceBaoic/JY28MvSA1DQYzF2GoqbkfWbNXMjORE8xmsNB3u98b+KI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913864; c=relaxed/simple;
	bh=jAaatw/UAMbdWbxWsYH0t0EUUgMT1D8A4PC94zqa3lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8u1XWcnmHUnzw4LE9RkZGXcf+rByWLmRGOwQ35rxkBFFNvHTy+RqC3i1yDwnZx1I5XsTzFcZrrRtDhwrQWBgbmB26r/03soFHUhIr5K/PWm7+uJrctEDhAzOTPWRDjQIynRYTxuXL5BxlXSsu4H5p6+qT5ZdPTLCT4J+5+PUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgwG4Fxq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7beda2e6794so46133539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706913862; x=1707518662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMLY6NdQnT1U9X32xfuv+CMyZtVAhapgA0VssdBsgis=;
        b=NgwG4FxqeKgAg52pHb2fMo1Z9Vk4KFPnTiLTThyUtaAyXgu10Ux9ugfhXhvX1hscMh
         Y0cOyqPoe4K4ctuzroIxyGFhzXUzMFtkesN93k2hWxEDITvrYY6mcgB6McD8CgClyFRL
         tBjcbVyz6gNJ1to78yvQTDbzMFXU6xU/tip4d9I+MC9+8XFQKWW426cwXyYUrQZbohJy
         AFW1AcROecbFGFiNB6kKiRRiGsXJVUT/aB07vDT/28i6EelGGl1qep/WXJk78xwpJp32
         UuyGRw5qrMhMHXizNoVGi/kIXcU1dpW+3i3AKF5KAVUebl7CkDPYnY02MNmRcJHitmac
         3vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913862; x=1707518662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMLY6NdQnT1U9X32xfuv+CMyZtVAhapgA0VssdBsgis=;
        b=ZUnP4+YhRuKhZxOL5bqUBDXdW3EYOUvBFfQ4WKLEIl58NsxA8/Yg0DbDFewlSCO0V0
         Npu7ue6q/MdSTMymkUiHegihmuJOBm1WI8UC7VcKWUuy7h8rcK3gV2LEtg7QVOGKLvFv
         Hy5r6vYwWVzJ1Ig+VzjCS6/FAdTZYwF32YrM0c8Uq0RlaUH34rsfnVUmpHg7X9ipM8zP
         Jr3zokvBqD4uIkIIqxmbm+Lpl8YtEgVuVjGWiXmi/JYv53yaHpbFT+/nG7sHwLBVJNwK
         8TFkg1ptS8Z50zJG8ttc79MkXiV552jKGwhioRLaLLnow9RB4HmgTqyQbX2AaQ+dDzdq
         rqPw==
X-Gm-Message-State: AOJu0YwAepzqzySaazVcDCr8kln+DGwnfBH/cPFLfiF1dQMBihFmv3tE
	LxPFX4vjsZ2jt1C2KO0ZCexGapJXA3OnOrTAbIXHUaeIPsXgosX8dNQfrWOekXn0oDe3l49oqWx
	eFP0DqEsUAUZn8q1sF9Uoz7bw9DE=
X-Google-Smtp-Source: AGHT+IH54dv2c1Flty4eD/sScEZfqMpxLZ6chyRV6g+BFX++dzAEJMKXa73YnYMK5a1fG1HHs3k/dBXMaLLB2dgmljo=
X-Received: by 2002:a05:6602:3f88:b0:7bf:f7d1:ad10 with SMTP id
 fb8-20020a0566023f8800b007bff7d1ad10mr9531iob.4.1706913862350; Fri, 02 Feb
 2024 14:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
 <CAKEwX=MOcmUjtrYOJCwh3unRT7OKdrvtR-FFdSevNf5i7z=Q=A@mail.gmail.com> <CAJD7tkb9q5FQqwUTH3kJtEcWB57Kua_RJ7zmDdq9KXgVegs=XQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb9q5FQqwUTH3kJtEcWB57Kua_RJ7zmDdq9KXgVegs=XQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 14:44:11 -0800
Message-ID: <CAKEwX=P0Mov3Aqazy8eLkC23wxpocVDf5oyQ6gJA1sK-Zv-BMw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:37=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Feb 2, 2024 at 2:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > Since we don't need to leave zswap entry on the zswap tree anymore,
> > > we should remove it from tree once we find it from the tree.
> > >
> > > Then after using it, we can directly free it, no concurrent path
> > > can find it from tree. Only the shrinker can see it from lru list,
> > > which will also double check under tree lock, so no race problem.
> > >
> > > So we don't need refcount in zswap entry anymore and don't need to
> > > take the spinlock for the second time to invalidate it.
> > >
> > > The side effect is that zswap_entry_free() maybe not happen in tree
> > > spinlock, but it's ok since nothing need to be protected by the lock.
> > >
> > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > Oh this is sweet! Fewer things to keep in mind.
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >
> > > ---
> > >  mm/zswap.c | 63 +++++++++++-----------------------------------------=
----------
> > >  1 file changed, 11 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index cbf379abb6c7..cd67f7f6b302 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -193,12 +193,6 @@ struct zswap_pool {
> > >   *
> > >   * rbnode - links the entry into red-black tree for the appropriate =
swap type
> > >   * swpentry - associated swap entry, the offset indexes into the red=
-black tree
> > > - * refcount - the number of outstanding reference to the entry. This=
 is needed
> > > - *            to protect against premature freeing of the entry by c=
ode
> > > - *            concurrent calls to load, invalidate, and writeback.  =
The lock
> > > - *            for the zswap_tree structure that contains the entry m=
ust
> > > - *            be held while changing the refcount.  Since the lock m=
ust
> > > - *            be held, there is no reason to also make refcount atom=
ic.
> > >   * length - the length in bytes of the compressed page data.  Needed=
 during
> > >   *          decompression. For a same value filled page length is 0,=
 and both
> > >   *          pool and lru are invalid and must be ignored.
> > > @@ -211,7 +205,6 @@ struct zswap_pool {
> > >  struct zswap_entry {
> > >         struct rb_node rbnode;
> > >         swp_entry_t swpentry;
> > > -       int refcount;
> >
> > Hah this should even make zswap a bit more space-efficient. IIRC Yosry
> > has some analysis regarding how much less efficient zswap will be
> > every time we add a new field to zswap entry - this should go in the
> > opposite direction :)
>
> Unfortunately in this specific case I think it won't change the size
> of the allocation for struct zswap_entry anyway, but it is a step
> nonetheless :)

Ah, is it because of the field alignment requirement? But yeah, one
day we will remove enough of them :)

