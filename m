Return-Path: <linux-kernel+bounces-34127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC4837403
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A4B21163
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E9433BB;
	Mon, 22 Jan 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N958pon2"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782F27715
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955996; cv=none; b=QVJmRzH2nv5pDOt76jFxFP0ozxfJXdcvK1QzErDCdWXghrKQZbFSaHRp7DdHvlWHje241AdMoxRXljupW3tBah4owsD7IYR8Pt5bJuXOtaAAa+/A89TCnD1xkrftD5wSQ+R5pd+m1/k1w7+WiNZGyH3/nOpVwTGEssfp6F9GCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955996; c=relaxed/simple;
	bh=Qp43HjWs5gh7SYsr5bjGImR/GWKtUKGFeU/FebP+27s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOUr/ks7sgfU4GJ0qWc9f2nOz1jm66xUJxEjsCNUEI+GWSHknv2fQxNFTvpDWZP42vL5uA5YtpvkmOp/JuzG8v1J73qtLPLQYtxn5DoU3sN1F1TmUh6fYjLiyBboZqGGgakXmVQlKGuJSARH5H8nEhJ5CrcQyMfUmiS8Y2XGB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N958pon2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso5129935e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705955992; x=1706560792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp43HjWs5gh7SYsr5bjGImR/GWKtUKGFeU/FebP+27s=;
        b=N958pon2vGuDEu7rvfnGdH8jJkTczVCFAjilfSd/yiqjFxo2VLDWBIKisDXvX/Stmb
         F3/X6qB3mPPy+lPgivhltJ8UmV5QAjC/IUtRd0axSuZ/K4PxOFOuGa6nz97A0FGVEmK4
         ARNi1ycjfMEqR+k7YPUbvIBv1BAPGjP6u4Uw6DybxLvXNCAkYs7qxVZ1Lmnu7royjdsF
         JRqnUNAzG+g97Z9mkmTBE5ihslf56E3/QItm5ppL4YpqzmHDSbKJIFvVH8AJfLwxLvzx
         CurBFRN0QHTdDWTNZvhTvFkOIqKFNNKHaJ1OPxzZnKXt6q6Ozc0gbKVQg+Q09oTZ0ldt
         YbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705955992; x=1706560792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp43HjWs5gh7SYsr5bjGImR/GWKtUKGFeU/FebP+27s=;
        b=QWM/0kMaBh+8vSmyyvWIpRwD4MCyxKG91MtBtXWZvcrHyxeDg3p3Gp8U4O0kRm+rQk
         Tu4Lu1tqRvZSB4AioqywtNh8ifwiNdKudswv+PhCUPTarHxPxTR8CKHmRtsc0D+UPw+Q
         kFMKP/kSBg7WSXKwF7b9Sp6vZqafh0dsdurosM/IMkHnPmW59NVKgUbJI1gpDlAYw1kJ
         vNi3W9eTqJQt3SKH4FUBwTpgBcd7OvMiLimAnDQR7Csxrenf223aQ2MPzjgkeWForq+y
         3N7SnD+pow7tnFN3cVoBJ3Jm+OM6kJj+Kb35yVePMHsaFfHaGabZ6wwjuMnmIRY4u6wI
         nMbw==
X-Gm-Message-State: AOJu0Yz1seYAbrcuAag151Zi/ISiTvvB+7PLZEz4+LVzmkIVURSTnreU
	tLdr3Qr3ARpxFH2a+srohZrdBOwSedV4+e3NHKCQDyh2Qo9XmAvtsMv8t42iwdh4CsEWVqEXtol
	BpyN02NRijylfzeyOgMfBoFBAOrQxgosWBWPX
X-Google-Smtp-Source: AGHT+IGSsDHWdLNHJCP6f1D5LB5UE9M7XSsi34GZdGViNkgp8UDOP3/4akTdkpy0x2oX5uGwnP6Xo4jrukX7I3VaM6E=
X-Received: by 2002:a05:6512:1c7:b0:50e:e888:2c3d with SMTP id
 f7-20020a05651201c700b0050ee8882c3dmr2184929lfp.25.1705955992458; Mon, 22 Jan
 2024 12:39:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
In-Reply-To: <20240122201906.GA1567330@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jan 2024 12:39:16 -0800
Message-ID: <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:19=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> > called for all swap entries before zswap_swapoff() is called. This mean=
s
> > that all zswap entries should already be removed from the tree. Simplif=
y
> > zswap_swapoff() by removing the tree cleanup loop, and leaving an
> > assertion in its place.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> That's a great simplification.
>
> Removing the tree->lock made me double take, but at this point the
> swapfile and its cache should be fully dead and I don't see how any of
> the zswap operations that take tree->lock could race at this point.

It took me a while staring at the code to realize this loop is pointless.

However, while I have your attention on the swapoff path, there's a
slightly irrelevant problem that I think might be there, but I am not
sure.

It looks to me like swapoff can race with writeback, and there may be
a chance of UAF for the zswap tree. For example, if zswap_swapoff()
races with shrink_memcg_cb(), I feel like we may free the tree as it
is being used. For example if zswap_swapoff()->kfree(tree) happen
right before shrink_memcg_cb()->list_lru_isolate(l, item).

Please tell me that I am being paranoid and that there is some
protection against zswap writeback racing with swapoff. It feels like
we are very careful with zswap entries refcounting, but not with the
zswap tree itself.

>
> > ---
> > Chengming, Chris, I think this should make the tree split and the xarra=
y
> > conversion patches simpler (especially the former). If others agree,
> > both changes can be rebased on top of this.
>
> The resulting code is definitely simpler, but this patch is not a
> completely trivial cleanup, either. If you put it before Chengming's
> patch and it breaks something, it would be difficult to pull out
> without affecting the tree split.

Are you suggesting I rebase this on top of Chengming's patches? I can
definitely do this, but the patch will be slightly less
straightforward, and if the tree split patches break something it
would be difficult to pull out as well. If you feel like this patch is
more likely to break things, I can rebase.

