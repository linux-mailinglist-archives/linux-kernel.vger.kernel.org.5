Return-Path: <linux-kernel+bounces-132066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC290898F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5891C21B75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A4134721;
	Thu,  4 Apr 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Q79dMu"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E712AAEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260710; cv=none; b=i42ZhOV89mqzhXfw7bjKrVYz3JA/JNL/ZVfhKm2IoKGXp4fZ3+JCMg3NlWDCL4JQ9B98MQN2Sp/6Wr/bzdqqWqejZcgdial5yB92WJpRmz6AMxkMI3PVe2HRBqnGTdYz6ufeVjVQhXapVeNNVOz7XJFqlxF0kZnkusUvmQybciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260710; c=relaxed/simple;
	bh=XWU7zUAgGR2mLofQ4vsMgcxDoAMMOXmFQ1cxnI7/ctc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLIA35+25pVa7P7EXzjXYvocrQDJ6/ebUgPNQITGeUQqlL6zVqhgqKS/ClujoS9LD+D+1o348+vtiLZj3Qrt9sr1TvjuMaaFeDD1wcF8ZKxn9vrW/TD8yl7NTuVDYEr49CxPlkjtF4KhWHm/KHV20P5dlwM+syNWUg02LIF/7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Q79dMu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1094251276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712260708; x=1712865508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF8Wk/bDbVdtjdnPC2cq8IfcTJuriUyNYfXhq+LTLmY=;
        b=P5Q79dMudep33lLpZ/fopprCOKCW7cb5gT6mzx9HkC23ZO1tM3tv3C02Ma6VSr28hY
         hNv3KJWqTA/Pi0SaKm6shSIeJteX/D+QAqB198HUqtEDcrVJ0A5hxh66fhsT55G3laDb
         13qgK3AXQQF6LoYYosYlJi2MDSdyq81C1b7tf4HPhV1T6HTSIfJTXbwrbZbzndJQzn/i
         s2pqdC6AOXYWxtECBZJ+DhELyfj3oFgM8+BVueABnu3DGDmHJVwuhvGv15VL/THG8wcd
         Phcee3aSYQu07PK2DTubswqfwXMlLuQNwhBlpYAYHhcWR4CxA0/1LPq2DaDh5b54a/p7
         BMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712260708; x=1712865508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF8Wk/bDbVdtjdnPC2cq8IfcTJuriUyNYfXhq+LTLmY=;
        b=pks4qFNzxksBS/rjhpE6tG1IKmoCon1Qu2qn0YfDvxnssHLii+1Neh6nVLghEu1HKM
         /J5LaBu6evE/UtcZbBkmRkKolL2+8QEoeXVsr3jzoC6i/igHtcRxD8+ZIjJjtrJjtqZF
         UT9CgYKgKwC2g9KnoQ1RFAVv/AoRF7g2PnVWVbP366OZk5hYv0Y3SmPOfdkNZgyKiq+/
         gwlTy01dIGM9ETJEEFYb9IqTrPgAYik7SkTu8ez2vJxROzdujMHAOdyoCCuSmhJtVspH
         //yZf1JY1vhISTh4wj/uQXPNWRGvcjBZBgEtMDTcwau/yQCoITh0pkhqa/VQcDRcXSvD
         sp3w==
X-Forwarded-Encrypted: i=1; AJvYcCV479F1muVRfhqPCn2UOA8XmAyiTFoRg7vAafeK9jMi/UN+Evwq3xLb0+zpQ+3parxTmJ/2iliXlPx6/V2iidCstU0qZnKpnoScZP0k
X-Gm-Message-State: AOJu0YzENlgdvXJLgpd5oO8/G4Tt8KtL6FfZGapFSAzlTIIyII2neun4
	ySpEIE5Ux+bK3+koT8pRiYrUTV4kg4X6ApZTpHCbOwmf8e4d6Vr6Gg9Xu/5tQjpzJAJnObpipu4
	IMeJVnHdftnlktOehpNhPczm2gqk=
X-Google-Smtp-Source: AGHT+IFsA+6EV6N8rjDFyIqOC0X0Xqyy4CqN7MNHYXALp0/wE7JP2k0qUiaIy/+bSPzQHJE6TqEbdqSmhHs/n49sr2c=
X-Received: by 2002:a25:bbc1:0:b0:dcc:623e:1b5d with SMTP id
 c1-20020a25bbc1000000b00dcc623e1b5dmr376005ybk.31.1712260708201; Thu, 04 Apr
 2024 12:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-3-vishal.moola@gmail.com> <Zg6iG8cxpopXuFCo@localhost.localdomain>
In-Reply-To: <Zg6iG8cxpopXuFCo@localhost.localdomain>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 4 Apr 2024 12:58:17 -0700
Message-ID: <CAOzc2pyOusTc2xj2qF9MN8YeZp0dcbsrtPr96QhmJOJ+hX+CLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct vm_fault
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:49=E2=80=AFAM Oscar Salvador <osalvador@suse.de> w=
rote:
>
> On Mon, Apr 01, 2024 at 01:26:50PM -0700, Vishal Moola (Oracle) wrote:
> > hugetlb_no_page() can use the struct vm_fault passed in from
> > hugetlb_fault(). This alleviates the stack by consolidating 7
> > variables into a single struct.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/hugetlb.c | 59 ++++++++++++++++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 360b82374a89..aca2f11b4138 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6189,9 +6189,7 @@ static bool hugetlb_pte_stable(struct hstate *h, =
struct mm_struct *mm,
> >
> >  static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                       struct vm_area_struct *vma,
> > -                     struct address_space *mapping, pgoff_t idx,
> > -                     unsigned long address, pte_t *ptep,
> > -                     pte_t old_pte, unsigned int flags,
> > +                     struct address_space *mapping,
>
> AFAICS all this can be self-contained in vm_fault struct.
> vmf->vma->mm and vmf->vma.
> I mean, if we want to convert this interface, why not going all the way?
>
> Looks a bit odd some fields yes while some others remain.
>
> Or am I missing something?

Mainly just minimizing code churn, we would either unnecessarily
change multiple lines using vma or have to declare the variables
again anyways (or have extra churn I didn't like).

