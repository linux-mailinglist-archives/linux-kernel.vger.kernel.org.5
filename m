Return-Path: <linux-kernel+bounces-76975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D734A85FF48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A4F1C23F64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA36155307;
	Thu, 22 Feb 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8o9BRZ5"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415A6214C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622833; cv=none; b=iXzy+9gZ86Noja36Bty/p8/TcCgbWbDggUnX7rznXARUvlMBIeNJSztOl6FcDTyd1qUFQAMs1DjnskoF5r/KxX3p3sopoKVbOw9fp8AELtlCDX0VbkXlJHvoRJxh8JCRmfph2XQv37EN5l7eHSqzm9cimEGGTGHdoL6JltPiyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622833; c=relaxed/simple;
	bh=iYT8R+AgfRokrMm7iGxb37Yxv8iHnkiSi65BqeZrtAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Od+g5A/augh1urs9/QfpTftt9CLMP/iue85acP6azl2aAPncvCaJFS3VjVqGVEfdj7A6YfBwhq7+QaKXOo/JiNYnh28S+ElMe0893mkFvcbyjhABsLvuEU2VE0QlttiQ8NbApBvz3Q9AjB6rqlA0P/DqgrEbCU19E3EGcmZPHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8o9BRZ5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607f94d0b7cso73931237b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622831; x=1709227631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuKAAfod1MzHS/3JdjwE+h9Jo38lBcZP+cEWXxDIKks=;
        b=X8o9BRZ5OKnP3AqIyCwXsVDHweAIBjNxI9uGydD6WF+9tmOrfbJdBoyUf2lSiACQZj
         NmH7zLSlXc9lTo+60fgAKC5+1yoJXr7LtPclXrrEUDQ8BBm1T1pw4GN4uxYlR/iKWzlG
         S7MzHkQ8KpbzpTJAh70rdVwiEYPdBiNsEVrfsl3HA978IvcOGx/aBSHPK/aq2O/7a/zZ
         9OKVumpY3HKI5Sz/AambDcPccJ+wfskewA1GeSeqErpL53sRDmzW2UMvTFRa8r/xFbF5
         cJW6a/OSecr4r7wmW1hyibEK3S5/dSPIhGLUOFmGgG6g3LsWnYGCC+IllgO7MOwc5ycV
         6qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622831; x=1709227631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuKAAfod1MzHS/3JdjwE+h9Jo38lBcZP+cEWXxDIKks=;
        b=QL2GhGqhD9HBLtLjOaSgsKxTuAeYcWkmZgkH0AyxfneacyK4uwMTSFYFF11UKnD0dl
         maWpGELXfB/k0UxXbqo8XTCOTttb6jLfAwotGcte9eku2oEuXY2fov3Y5DptuNlZTfLm
         08bDIZYwheF1g324f8p5OaNqyYsUUwlI0RpJb/jcbBi1k9p2UtzNXzRREDn5elAQcGzh
         +F0phUFyanVzmOfnKRQRhEAHHw5+1FvcxvQEK1BQWpk/84fRmCkNXLhcWNFRW/k4pX8i
         6R/V8rhciBfJfMa9cReIBd/6C1zQIy1QyW1QvqEYTAe8f1aHHSGUyloYXtl2DycNgxZ+
         mxKg==
X-Forwarded-Encrypted: i=1; AJvYcCWYEFwMCy9f71Z+QGxZytso57qhhE+rhMP86Ji8v/IzDzRSmiCUcXyfgBTVWRrer8uVl7f7D8/XT1ggBuuaqBg3Vq9+Eh466VILkcSB
X-Gm-Message-State: AOJu0Yw09xQshTLzKcpwM6v7ZjvClEgxBWkWsGpbfJvsDmNBii3kA8XC
	iZyGwU8rilSNVhTpp6X/k9FSsL34FsU7hZL1f6930E16zKNIuvAGuDBNa7hINkQqHLV4cm4D0xR
	jqCv2LFvzRxLEtDxz+19gVGfliXM=
X-Google-Smtp-Source: AGHT+IHO8x0tadUdaQBRIMWwUXYyEOVeTnOcoN6TwMUV/UtT8moscekER2ZVB4LuPbM93z+Fy+yJhn0cyDA7Zdk1jiY=
X-Received: by 2002:a0d:d984:0:b0:608:b193:5a3e with SMTP id
 b126-20020a0dd984000000b00608b1935a3emr555773ywe.32.1708622831338; Thu, 22
 Feb 2024 09:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-6-vishal.moola@gmail.com> <ZdbFyC6HPr6oKrM-@casper.infradead.org>
In-Reply-To: <ZdbFyC6HPr6oKrM-@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 22 Feb 2024 09:27:00 -0800
Message-ID: <CAOzc2pyt=3UwRt6a8L-wJGAcQFJr_ZNeFEwiGapx9KktuYC+BQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hugetlb: Allow faults to be handled under the VMA lock
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev, 
	Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>, Petr Vorel <pvorel@suse.cz>, 
	ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:55=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 21, 2024 at 03:47:32PM -0800, Vishal Moola (Oracle) wrote:
> > Hugetlb can now safely handle faults under the VMA lock, so allow it to
> > do so.
> >
> > This patch may cause ltp hugemmap10 to "fail". Hugemmap10 tests hugetlb
> > counters, and expects the counters to remain unchanged on failure to
> > handle a fault.
> >
> > In hugetlb_no_page(), vmf_anon_prepare() may bailout with no anon_vma
> > under the VMA lock after allocating a folio for the hugepage. In
> > free_huge_folio(), this folio is completely freed on bailout iff there
> > is a surplus of hugetlb pages. This will remove a folio off the freelis=
t
> > and decrement the number of hugepages while ltp expects these counters
> > to remain unchanged on failure.
> >
> > Originally this could only happen due to OOM failures, but now it may
> > also occur after we allocate a hugetlb folio without a suitable anon_vm=
a
> > under the VMA lock. This should only happen for the first freshly
> > allocated hugepage in this vma.
>
> Hmm, so it's a bug in LTP.  Have you talked to the LTP people about it
> (cc's added)?
>
> Also, did you try moving the anon_vma check befor the folio allocation
> so that you can bail out without disturbing the counters?

Moving the check before folio allocation occurs keeps the folios on the
freelist so the counters remain static as expected.

If we are looking at a shareable vma, hugetlb_no_page() does not need
this check at all, so I left the check where it is. We could definitely pla=
ce
the anon_vma check above allocation, it would just make the code
slightly more complicated - needing another variable (or reassigning
ret in various places) as well as adding another potentially unnecessary
vma flag check.

> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

