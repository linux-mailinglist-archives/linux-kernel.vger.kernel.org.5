Return-Path: <linux-kernel+bounces-39483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE283D1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FC6B249C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D7EBE;
	Fri, 26 Jan 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV8roOhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAB387
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231395; cv=none; b=fH+zRVcuDv6J6HRrJHwufIm47aTTF/eSAYmUx4mpA6lxfhPQh7NVNH77hYY8dhfHqorWf6O+v/PjnT5/wfeO0j4zShYYd5o3CmdV1HtEkQ4UkLNimm6DvPKKKHXnBh50Fk5+VxhmruABZqAEp5OfTr/EiYWAEzKJ3w4rNzXbpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231395; c=relaxed/simple;
	bh=+9liw3MIg51z1w1+FLNp7TW4WBhCye0p1bQDb5wxCAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ3xiAovJe8s/YA8pqm8ji5Op7OB5pUQo2oRR/Qz7zFX7D29pzUsSPvUXrdI5tlhTqLiAOlAq4Z4zLNIbxvGLGY+tzCZY0pWo3n+mBMQLw2abzN1PJj3yv73r7RPiJfQeXE81FXCyGTURfTC0G0tz4+0HPgwYFxkMn1L0ZD93/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV8roOhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61011C43399
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706231395;
	bh=+9liw3MIg51z1w1+FLNp7TW4WBhCye0p1bQDb5wxCAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nV8roOhEKCzd0klA0IZP9b6yC8z0UOgjK1pql6YB7FfazfpFKMzc+ZEjD3UQA9YxN
	 wvXAGypAVDyL/NPt9gnkhtW5OFTB323fmBOXep+mU/wo0ZHonXyivYrGJcvFFuTqV7
	 asGB7elZGV9f+v1WXmlnpJ57JWSX5WMN5a+vSlwStQFtFHsrwt8KCd2FWWr13SRgbj
	 +7jQd6pWuGFqkx/WAQ9uJS9veNfxvM+XvmWBwlMbROJekzxbomxb4jNO2QlN6k176r
	 FJZQKBmr3LVrikdVF9j2YsyGXy0rFTl3QyL138Q9xMBWNladqC5YJwniwRs73wxaiP
	 pcNLKEJrO7bIw==
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746ce7d13so25035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:09:55 -0800 (PST)
X-Gm-Message-State: AOJu0YyNVww6/2hDrYRjVRg+Xl3MhRJGCVb0J3tTGjjibyEv3uhrhjne
	BEIXQbBj3L5xQ/cOoCUjvXnuA9EGSRyk1BV11zE1bbaCrKqxZwgFEkpoM6g9EQs3OWdnutpdT9P
	DizbbLky2lUH+2Kl1OjiPxmG3wZRvijaSHB9X
X-Google-Smtp-Source: AGHT+IFPjHIoFHpS6lUwKN2Ik89SZ4wdLjZNpBhW99q6IwgqhzpQ9EhayIgGH+gohje52GYr1BlFthvuU1QxnMZhlTk=
X-Received: by 2002:a17:903:1108:b0:1d4:d5bb:5d7c with SMTP id
 n8-20020a170903110800b001d4d5bb5d7cmr695292plh.110.1706231394824; Thu, 25 Jan
 2024 17:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com>
 <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com>
 <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com>
 <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
 <CAJD7tkaG5epZkp4N4wOmbAp-mKV60rR63kppSfKtZPsu2vTDdg@mail.gmail.com>
 <CAF8kJuOFbRYZiFmtrAAqh7KBxWNaYtK10e7Ych4VxDKOocRKEQ@mail.gmail.com> <CAJD7tkYFX98TZGiiBwXRtiJM_zEphzLq-vNXNyrzun8gTRLuGw@mail.gmail.com>
In-Reply-To: <CAJD7tkYFX98TZGiiBwXRtiJM_zEphzLq-vNXNyrzun8gTRLuGw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jan 2024 17:09:43 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN25avTEgNTXdoz7N9eRuNTCdtGLA_kCuKB=_TRYT48cA@mail.gmail.com>
Message-ID: <CAF8kJuN25avTEgNTXdoz7N9eRuNTCdtGLA_kCuKB=_TRYT48cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Thu, Jan 25, 2024 at 2:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> > > problem is that after the entry is isolated from the zswap LRU, we
> > > need to grab the tree lock to make sure it's still there and get a
> > > ref, and just trying to lock the tree may be a UAF if we race with
> > > swapoff.
> >
> > I feel it is very wrong to have the tree freed while having
> > outstanding entry allocationed from the tree pending.
> > I would want to avoid that situation if possible.
>
> This should be the case with Chengming's solution.

Thanks for confirming. Looking forward to Chenming's patch.

Chris

