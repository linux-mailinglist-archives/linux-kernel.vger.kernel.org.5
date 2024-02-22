Return-Path: <linux-kernel+bounces-77492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C811886064B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C201C224E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4018AED;
	Thu, 22 Feb 2024 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe+sIpGc"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173017BC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643773; cv=none; b=o6DXwJ2P99ByaDA8SDYMkcbHp65n6jaQ5+U9mkGIpFXUTIyF4fniXtXD3x0I1QAci6IQtwI0VD7fObzH8/otyrJ0OJpys8N4lctI0c+p8fnLCSMiYPmn9bW3I6/ZhasgS+0OF7e+VeUrAWElmq9hKUY5aGLgBD9awLMufN2HPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643773; c=relaxed/simple;
	bh=DZJ0uqU/+Xaa2u2HTrrUfow93KUsenowq6a4U63I5C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiknDGp9e4ArN/uENDb1QEnwJZgNYoP9IQbPHLRyFxyYWKwHAN/C3sq2zJ6zwSS7UrkNzbSJ5cBltquBBSn85dXwgu+Wd/FzoNx+t5s3cqxYtQmpHDgD9G8GK5BFRk6qdsHF2/+3iACwZMNLr7rOikcpEGd3QyMlAkkr11Uk9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe+sIpGc; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so110920241.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708643771; x=1709248571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JtTdXxCGCTnvQvSWv3Y1gG67yDkcySzLqqUm/qFAtw=;
        b=Fe+sIpGcero6Yve7/xIcwKFQESnXmSRGzRTYy1hPH4ftiNyCLus6oF9JBErAFrbYrp
         poTs3JR6M8rwTMhwRndB3CdBEdG/X9ziZ5awFa23LL+qzvTXcvNBrDj0NDTAOaKli4br
         NcP8JvxS6bOZflyc6l/CHO1TiddKiFO4FUMKOLspwmn2XLsXJ0HlI6nq/McwXN/+EDLL
         OeWi/1bLC6jGM5pyTm+aXwF2ahTog57BPns0vyjSxo7aKmgNjznbATvP92Y2KVfaL6X8
         UCRF9or8F+zYY290288LBxaydJscZbEVm6pDkXZQolmOV5YJR+ylW2qOjhNWHXLPsXiV
         LsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708643771; x=1709248571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JtTdXxCGCTnvQvSWv3Y1gG67yDkcySzLqqUm/qFAtw=;
        b=bNWZBPDyTjwPQdiO+p7lHQUS/PMQ/Tbg+s9R7VTNHzcKMOwMmOEr303x2i4LoeE9oF
         WPtcwL/chDPunQBvi3xDi/ZL28Un1grqtNzrtMCrvXpFqNExKZQZ3bbb+8AanuZfe95r
         fzMCNalrRgN5IHmfSo99r5rruLtDTESjIdJB23EzsMGE99IQw3F8KXH5hyYj2Sjh9OHR
         gSVadqT52hrSdxwaDcTyR1Nuv+4KoskY7OzJ67zZnNtLbgh+FnS1145vlLgPX4hceCQM
         IYUY72PmyZqeo0E1I6OQ0ifr6NmexsGhAEzuVjIsJuGC79qQH8klNZ9YfEy3z1afJN6X
         X56Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCg+fHEy38mfiX3B/XgtUfqjPmhlHsLaI9yzxLiDPncvnBmyp6UzIx7p9j3NysIq26xfIp9mRuvE+27PNR+qdAiYrk1WggPG6+aSHU
X-Gm-Message-State: AOJu0YwYS3nO+SM2hZRlmwKsL5AUWfKyQ3aODoi+MkBRPXZ+NGE+A/Ab
	lC0VF7P/GrP2RVVL0Mi8dODWj+TP5cqwqUf6tEq5cnU9KbIxWNaY6laOYcWe9bgKihqfSbIPgat
	xHdwzsyBztCmKp7QfcKo8R/HlSqY=
X-Google-Smtp-Source: AGHT+IET7SLCpXUutFO5wTAkeaY0stX0a7qnERj2kTvzSDmplXe26G+bcAoizsf7zicRW4KaVVWyD+L2cHQaJkIgIeU=
X-Received: by 2002:a67:c992:0:b0:470:472a:89a1 with SMTP id
 y18-20020a67c992000000b00470472a89a1mr384850vsk.30.1708643770735; Thu, 22 Feb
 2024 15:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102184633.748113-1-urezki@gmail.com> <ZdcHXFMq0cwmVKfM@pc636>
In-Reply-To: <ZdcHXFMq0cwmVKfM@pc636>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 22 Feb 2024 23:15:59 +0000
Message-ID: <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>, 
	kirill.shutemov@linux.intel.com, Vishal Moola <vishal.moola@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Baoquan He <bhe@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Dave Chinner <david@fromorbit.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 22, 2024 at 8:35=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello, Folk!
>
>[...]
> pagetable_alloc - gets increased as soon as a higher pressure is applied =
by
> increasing number of workers. Running same number of jobs on a next run
> does not increase it and stays on same level as on previous.
>
> /**
>  * pagetable_alloc - Allocate pagetables
>  * @gfp:    GFP flags
>  * @order:  desired pagetable order
>  *
>  * pagetable_alloc allocates memory for page tables as well as a page tab=
le
>  * descriptor to describe that memory.
>  *
>  * Return: The ptdesc describing the allocated page tables.
>  */
> static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int orde=
r)
> {
>         struct page *page =3D alloc_pages(gfp | __GFP_COMP, order);
>
>         return page_ptdesc(page);
> }
>
> Could you please comment on it? Or do you have any thought? Is it expecte=
d?
> Is a page-table ever shrink?

It's my understanding that the vunmap_range helpers don't actively
free page tables, they just clear PTEs. munmap does free them in
mmap.c:free_pgtables, maybe something could be worked up for vmalloc
too.
I would not be surprised if the memory increase you're seeing is more
or less correlated to the maximum vmalloc footprint throughout the
whole test.

--=20
Pedro

