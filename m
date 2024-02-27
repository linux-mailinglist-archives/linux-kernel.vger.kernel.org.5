Return-Path: <linux-kernel+bounces-83886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA32869FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72D1C28BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453314AD08;
	Tue, 27 Feb 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7j13T3W"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1914A4C5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060514; cv=none; b=cmLDOzv4TvwkVH5o5HGTdl2kC1lf9SZIve0nJzU/mb2ga4lo6+gj87Pa4sYEWHJpBXLr706RzOj97M3VS2Ds6cU45+wfWogAfncIewuVfw9mpuc0dnaY03p8MTRAHPapiEtniZZlV/T+Q2DvUIrRT9kmOFDrnbHknJsgfHgWpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060514; c=relaxed/simple;
	bh=Rx+0X1wSqJUpMVKZm9J8XVb9jpuLH2CRv1pKzGbSCkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSQTrbJ139lKeAIFAsehHqcWiUBQmwJ6vUirhgy6tmHnbeN/+jkZSt7FypsP3lccBKZGCdtuCS72TSVQeLLBk+32QYza//nVyuPfm+opJn5hUIqRur8ofRFTRjb2bc3itE/ZkwQsACNM+R14B0PyEnfihfhNmIi6+YE+1bJ2yyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7j13T3W; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4cb26623d8dso770111e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060511; x=1709665311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfFFXzSpX0Mc4KzxGc+Bs2TXLtROHHndagwLfCtpLgk=;
        b=C7j13T3Wbu4FlEkB4/5mku1lnEEnpzd6yzGlZJrRC7zMdim+Pa2WUu0LQJCjwjnR6L
         UC7scjjBG6lc5drVFkZVE+Sn2YnBn6ZY6OQ7MFFSB51YywaY4JcoFQWdw83X8rmd911E
         RnC1/S9dNxiolRevVlm4Jl+3aH2tuxFqFSDWgAUFGBKnkxaHVUkuDj+vUoL+ikzztjQN
         HrXbQwAWw4Qx1NmsuK8GmEL48tTmwfFs4i8yJ6dyCJNipYlCnIyI80eV0bbQe6tUTtL0
         VbyFIWorBEY18ROcZlNLg10c9Mj85xdDj505q2tN+WEwu1wjN5QwrTvFM1JgJO4W+ElL
         8htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060511; x=1709665311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfFFXzSpX0Mc4KzxGc+Bs2TXLtROHHndagwLfCtpLgk=;
        b=RkXQ+9f1Ihfy6BylFcKHKL5FNjedC/GgrzZWHDx0BSYvr/5oeWaOUl8jbskfg5MomR
         4MskcD+YeZtP+Q6ldU87nxB1rP7skOV3GXKpp9eAKCiPQE4ZsqFH6WBulELJnxKk4+MI
         +eSqlBW0+ZWTPzZq2bcclR2qOCnKw2CmadXtiqp7Rbfb/2r7SThQyQDgFAmQfoqr0J1U
         PQMRCoHNUkMQGXezLGL2wKAaAz/wwYWpRSnrOrURYgdoKBoYSQuQCqT5vcBPU5R9h41m
         hedWFFx5vbcENz1VyPursAZpjQ5ca8YD9NK8Q7DVEflbqACSMHYrX224acEc+zLhZOT1
         UJPA==
X-Forwarded-Encrypted: i=1; AJvYcCUpcktEuUTMM0fykADYXPxgN25evVlUD8+9pfzxUdkHMHTw0e0RjJ9QsuKnGyVUTJoa2SuzVF3t31IYMaRFb4b4SLMY/3vFKKcPicf0
X-Gm-Message-State: AOJu0YzGF2BaxOozvNV6SDohwHlTUB/8bmJO4NOKM1L1v9XQW7/jtuci
	OABBdwm34gJiPgo4uhB1ECU1/r4jUGvSYZMYreIbcF6pGhT6PrwzsfiCT62Xv779R/XUAwKT66y
	abYSRn+64209H38M6imW/k8nYozc2skYhXBoxjA==
X-Google-Smtp-Source: AGHT+IEeakGXngQCMim18TnOJiecyRkKHreCK/SntmFGZkjnj7s5owwh/pYnzNyyAQ8cB8qjcq7plWYQixSZBYqlppY=
X-Received: by 2002:a1f:6681:0:b0:4d3:384e:937c with SMTP id
 a123-20020a1f6681000000b004d3384e937cmr610147vkc.8.1709060511570; Tue, 27 Feb
 2024 11:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <Zd4HEjS6vpIvwfR9@infradead.org>
In-Reply-To: <Zd4HEjS6vpIvwfR9@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 08:01:40 +1300
Message-ID: <CAGsJ_4xTtLzUKSY7EzEK0Ho61mWH35kHkidBRpjLd+_3_yOaUQ@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:00=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Feb 27, 2024 at 03:40:50PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > madvise and some others might need folio_pte_batch to check if a range
> > of PTEs are completely mapped to a large folio with contiguous physcial
> > addresses. Let's export it for others to use.
>
> It doesn't look exported to me in the patch (and that's a good thing!).
>
> But even for making it non-static you probably want to include that in
> the series actually making use of it.

at least two parallel jobs[1][2] (maybe more ) need it right now.
Getting this one pulled in early
will help build a common base for them and avoid duplicates&conflicts in th=
em.

[1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.c=
om/
[2] https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmail=
com/
>
> > +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> > +             pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> > +             bool *any_writable);
>
> no need for the extern here.

Yes. this has been moved to internal.h as "static inline" in v2:
https://lore.kernel.org/linux-mm/20240227104201.337988-1-21cnbao@gmail.com/

Thanks
Barry

