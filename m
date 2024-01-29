Return-Path: <linux-kernel+bounces-42121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6183FCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA851283057
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F711718;
	Mon, 29 Jan 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUElTykJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3BFC02
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498724; cv=none; b=FTs1644YTWTroWJos16SavqVsCcSQgVVAEGRDRO92Q+O/rfzq+XpWXo3WnweEK/QtbXGJs1c/ytYeNb0aBqlh6KlC0SE0IedPosVJA169MZ2gwGcZZgCtjax0/6Agf+wGvjxFID7TMa/3AZi7mJkUc4Zku8NJtU0SaoRiLowGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498724; c=relaxed/simple;
	bh=IScpMroxh2pczHI5A0NNatcLDAXs5qdNngeznddEdd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaU8HjVSoOKAvRvvyx2lUU0PPFms7Tam9hkZ9U4ItyBno7IU2TvGU0gJGCe5rx3T/FPJumluUZ3EyJA/B78jTv1WC8IpvtS0pZWT8qCvBSkNcuJwBg8HNaP5x/+XxWZVj8sRnniRKD/mSfHOtZMjVFVkGvW7FjgLsDLUSJ0oqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUElTykJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C31C433F1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706498723;
	bh=IScpMroxh2pczHI5A0NNatcLDAXs5qdNngeznddEdd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YUElTykJFQHY+VK4+A+vYB3ivUaqsXLWW++gXr/K6I5Xb2J1qGqeBgrtg7jFyENcg
	 SHT0+WeH45jENJYumrg5D+VempeYzdlIGLVkU6H1pH3qTQ2V7zeLNuGNWvXnXPk9lK
	 K7ironnh2qYeu/iDqMKqKvBXrWVG/66XAUZ7VTXaN5KashA+RMcf1pytJADaNKDoXp
	 vIJXFe/QloyriACuYwbf3QhYpAIEuywRDLKWx9drF182SKZ9wnJEBETN82CFTR9AMg
	 ISr3Q5S9EgEpEeLgiUHDwSuZagFZUT9E4aK8sjHIX9OocTtDniNoKTjHYIMV5kr/Gn
	 c6V/xFpKkL7jQ==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7baa8097064so131431139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:25:23 -0800 (PST)
X-Gm-Message-State: AOJu0YzMLoeHRnEx0sGWB6Ry7YolvsGGMHu0xqww6Dw285KHCU36/no1
	RIdJfISQDaoNh6Ss5ZxBec8p9cnbEu9jtFFBlBcSVbLF7mzRUoyfMy/3IyaGQyMxDc65Nto+tzO
	fC3gYw9BlaD3oxdMSK+QhRqfynpX6dyULUrCv
X-Google-Smtp-Source: AGHT+IGtYbKMNNgQjBaHOXB4uyMODmE+elXcjicRL0S/jZ9dyU5k7KkGwxwsOWjE6C9u3VNNmAYcLvuUF+3yBkDF8s4=
X-Received: by 2002:a92:a305:0:b0:361:923e:ec48 with SMTP id
 a5-20020a92a305000000b00361923eec48mr5038339ili.8.1706498723104; Sun, 28 Jan
 2024 19:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com> <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
 <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 28 Jan 2024 19:25:11 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com>
Message-ID: <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, ryan.roberts@arm.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Barry,

On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> >
> >
> > I have on my todo list to move all that !anon handling out of
> > folio_add_anon_rmap_ptes(), and instead make swapin code call add
> > folio_add_new_anon_rmap(), where we'll have to pass an exclusive flag
> > then (-> whole new folio exclusive).
> >
> > That's the cleaner approach.
> >
>
> one tricky thing is that sometimes it is hard to know who is the first
> one to add rmap and thus should
> call folio_add_new_anon_rmap.
> especially when we want to support swapin_readahead(), the one who
> allocated large filio might not
> be that one who firstly does rmap.

I think Barry has a point. Two tasks might race to swap in the folio
then race to perform the rmap.
folio_add_new_anon_rmap() should only call a folio that is absolutely
"new", not shared. The sharing in swap cache disqualifies that
condition.

> is it an acceptable way to do the below in do_swap_page?
> if (!folio_test_anon(folio))
>       folio_add_new_anon_rmap()
> else
>       folio_add_anon_rmap_ptes()

I am curious to know the answer as well.

BTW, that test might have a race as well. By the time the task got
!anon result, this result might get changed by another task. We need
to make sure in the caller context this race can't happen. Otherwise
we can't do the above safely.

Chris.

