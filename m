Return-Path: <linux-kernel+bounces-109352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBE8817EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8CC1F21F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08168565A;
	Wed, 20 Mar 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqQWYs5c"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EA6A02A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963157; cv=none; b=O6eJ0bYLrCz2sj5rL5Y7HoT9SeXMUGppxJgm2ON739gpaMD8GTEmuFuNMjQVHn9nDZ7iLibrGMpWuTN7H4YiF0hlphI0WgTL2XAdPPdZJz/lUwOmn7tSkhhVCzvQ8AkMotgO2PpgGQrRVx4d75XImigAyVtaJMoEMDfy5o2e3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963157; c=relaxed/simple;
	bh=zU6HfdEt0n6J7E0KRf9O2/4bM68psIyCtb53kHS3Ps4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1l4jRuRmmubz2WdxsXLvJBWpQ4DA4cZABG8S6E/73OYxah+0eU+rZg5gaHtQhsrlckb+P37xITuYaIJ8FhyyKUhuI30LM4/I+1GJvEijghInONeC8CDENCh5/SZXYZh+v4u2J2nO+4YNjSVTLWKwUzGCxGcjxr7fZIw9YvzYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqQWYs5c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61100c749afso2707627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710963155; x=1711567955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU6HfdEt0n6J7E0KRf9O2/4bM68psIyCtb53kHS3Ps4=;
        b=RqQWYs5czrKpr4st+xGkUhbxB37jRwL/T8GVxRmVj96Nt2hmim1u9FrSUJ6w3E3l0P
         wCH3sTYg/hvGfGQhLAd9rINpjyeO7pqGIFd/q8pHU+ojPKF8beIq3oWMs9Ipx5JAv29J
         j3IqtUdfwekYAyMR3HSWExGMMCD5i9TqAk0NmTedIZwiE3b+HKfuwrLfJKeiqUtRfCu3
         qTDD34R9+29k0MUOyUg12sDr1nXBSO1JJegBKGReulw5VP/YReJ5YiQ0l97QCDL65hFc
         PhkimOPY/66hoHQXzgHK0qtJuqHhAoBhjpcGuLyS0Vz8ZcVmKIkOq/NY9jWJYp/TaHU9
         cNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963155; x=1711567955;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zU6HfdEt0n6J7E0KRf9O2/4bM68psIyCtb53kHS3Ps4=;
        b=kFEZFnjeLNLYz+nXT2tLeZfRWHdpj7iN07I38KYp71o3b03lavOsPeb2gzBZieENI2
         wtgKQe8kW4Tkeeao6ug40TNrbtMH/5P/QAfLfm9Tc56M5EGlTuL4GD3We1022orDrsTS
         zBIFK4ph0qpl/Bq1VaSNxnrgToNDTt3qSHUK1aJzXBx2lFnrdk3BfkfsrEIjzgMTrEPR
         piIwVEqeqdOW/S7m0nZERwVYe/hlZLKX9WepbNpXoYJBh7xjVnGLJlljms32GmvIPBIa
         w98jW1wb0pQfRE9Xad+WXcVMHSwVrsoXVn5/hsmM+QjeVLEDCPAaSC4qxEgL+y5GxxWf
         LiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79nWrzUK7MJkL1BSgbR7ntY22LDpgYIYGO0HQLo5qN57dJBsOqdHhy8AkTas+NTTDHvNL5b7C9fHPLGU7YZqGexyYIbZeDMVlfQoG
X-Gm-Message-State: AOJu0YzMxwbjZ4KpWOms59lXpj6G2jEFbaEaUTmDzPyX/nKQlVhrlPN0
	g9q819ViCoXc2Ysu2XzltpEMuHygQjnAWVEGbGSnXhUZl0yDbjsVg0kuOPeqqGNKIxHCZJlTj30
	gmfRG6f6qNZWgWouEdQ==
X-Google-Smtp-Source: AGHT+IHe0JLeXDle0EC2yBifL9imMy9PxVYfZirzbgToNKkjp+aG6E6OD+MSxTTdsJT8QB/n17787kHK9ZX0Fh6o
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:a0c1:0:b0:609:f088:cf9c with SMTP
 id x184-20020a81a0c1000000b00609f088cf9cmr4267979ywg.1.1710963155237; Wed, 20
 Mar 2024 12:32:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:32:33 +0000
In-Reply-To: <CAKEwX=ODDeetg_iv2kcds_DziJ5og2F6STsLSXE85qufYET=eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com>
 <20240320095053.GA294822@cmpxchg.org> <CAKEwX=ODDeetg_iv2kcds_DziJ5og2F6STsLSXE85qufYET=eg@mail.gmail.com>
Message-ID: <Zfs50cdvcOpvnd8F@google.com>
Subject: Re: [PATCH 1/2] mm: zswap: increase shrinking protection for zswap
 swapins only
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 07:48:13AM -0700, Nhat Pham wrote:
> On Wed, Mar 20, 2024 at 2:51=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Wed, Mar 20, 2024 at 02:08:22AM +0000, Yosry Ahmed wrote:
> > > Currently, the number of protected zswap entries corresponding to an
> > > lruvec are incremented every time we swapin a page.
> >
> > Correct. This is the primary signal that the shrinker is being too
> > aggressive in moving entries to disk and should slow down...?
>=20
> Yup. Currently, there are two scenarios in which we increase zswap
> protection area:
>=20
> 1. zswap lru movement - for instance, if a page for some reasons is
> rotated in the LRU. When this happens, we increment the protection
> size, so that the page at the tail end of the protected area does not
> lose its protection because of (potentially) spurious LRU churnings.

I don't think we update the protected area during rotations anymore,
only when a new entry is added to the LRU (with potential decay).

> 2. swapin - when this happens, it is a signal that the shrinker is
> being too... enthusiastic in its reclaiming action. We should be more
> conservative, hence the increase in protection.
>=20
> I think there's some confusion around this, because we use the
> same-ish mechanism for two different events. Maybe I should have put
> yet another fat comment at the callsites of zswap_folio_swapin() too
> :)

I think it makes sense. The confusion was mostly around the
interpretation of finding a page on disk. I was focused on pages that
skip zswap, but the main intention was for pages that were written back,
as I explained in my response to Johannes.

>=20
> >
> > > This happens regardless of whether or not the page originated in
> > > zswap. Hence, swapins from disk will lead to increasing protection
> > > on potentially stale zswap entries. Furthermore, the increased
>=20
> Hmmm my original thinking was that, had we protected the swapped-in
> page back when it was still in zswap, we would have prevented this IO.
> And since the pages in zswap are (at least conceptually) "warmer" than
> the swapped in page, it is appropriate to increase the zswap
> protection.
>=20
> In fact, I was toying with the idea to max out the protection on
> swap-in to temporarily cease all zswap shrinking, but that is perhaps
> overkill :)

This would be problematic for pages that skip zswap IIUC, we'd want more
shrinking in this case.

>=20
> > > shrinking protection can lead to more pages skipping zswap and going
>=20
> I think this can only happen when the protection is so strong that the
> zswap pool is full, right?

Yeah that's what I had in mind.=20

>=20
> In practice I have never seen this happen though. Did you observe it?
> We have a fairly aggressive lru-size-based protection decaying as
> well, so that should not happen...

No this was all code inspection as I mentioned :)

>=20
> Also technically the protection only applies to the dynamic shrinker -
> the capacity-driven shrinking is not affected (although it's not very
> effective - perhaps we can rework this?)

That logic is flawed anyway imo due to the acceptance threshold. We
should really get rid of that as we discussed before.

