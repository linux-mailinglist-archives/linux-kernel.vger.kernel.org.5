Return-Path: <linux-kernel+bounces-132178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424C8990F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129ED1F229BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B313C3D6;
	Thu,  4 Apr 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm/EsJ30"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A613473D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268168; cv=none; b=lrAJzAFGi382DlAKJavHq6RfqVxFow7aX+nrnCZSL3gmGrOkv5gEijPm+5rwK2DFo7LGGeiXpyWeq/5l7DVaPMtesWQxBSDCISQ8VjVKAZwhxEcQ3b+ARbo3fwDyzQKqBJRltiugVXckrwxU9OXQFAMAe+DS1Lfqkb1EO3T/AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268168; c=relaxed/simple;
	bh=q44r8YNnwBBzcVeMvOuZdTWviDpJk8KZC7XRWs+Uvvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZybQ9TWTzslGNkydaLsxqlH2s4LgmJ/CDZCRXtEQl0tJkTiXTvItc81sqNpmWfAAllBjv1l7O1Lq/ExfWI+idIo7os1A7IQgM8zDXUSc5ER7FZaIdwsHTIRQcBwBJwkEvXYjNYCyl4NwhpnyzoRR/PQE7r5uh+UhAy3A3Cdx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm/EsJ30; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c5d9383118so656581b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712268166; x=1712872966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q44r8YNnwBBzcVeMvOuZdTWviDpJk8KZC7XRWs+Uvvo=;
        b=Dm/EsJ30J3Lc8B5tFpDJFHL9FopEP+eSza3Z9DrK0Li22TARNuyYhTFspj5yJQhZRJ
         S+ttnxF+PCCvtaxK1Q2Cmmo9aC71Soglf8O7V5vVQlgHQNbo6s+4F/XspYWKXR4YrkUl
         8AN2g0pQMahXvIZV7gSiAGoABWuT8Y2/SNImmQB90cp2w69Ht0PoFlSJP5tLR8qH5dsL
         VEtjK7KWi6wQyjWh1sTGKHnTVTU1vbI64QSNtrj5XqdldcnEQiyi+BcIXYK+39v47LwM
         SX1+XRgOS7RXfileCcIMMvhp0p1RlC4ZcfvimFbHufMDo2XCKDTbgX90cY0owe7BZu2T
         FSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268166; x=1712872966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q44r8YNnwBBzcVeMvOuZdTWviDpJk8KZC7XRWs+Uvvo=;
        b=pCVVDguBwG489ITzFJ2IGSgzRfJ2p1hARCUqeRv1Q2A3QNheugSxEB65D63R9ZDMmO
         3iggKOTz0S/YiIX+zGHtSV+68XVLxQrYjRBqBcwKmOr/NjjjP/XBwmB/emeQu8WjXyLL
         iLrL7OjF2Ju0ZAN/DgAR8rjENkJIJiWJRPoUp1WGUC4PFcBckFvfxhJZ5bt1HqUeAmr4
         huCggYrCsH6OZvgfGih2NtlQ20O4iOiWyX2PsW/lTcsaq3zSJNXaHjjlr7W2kxBe/HaJ
         CJ8D4pGwZOQi04U47/OXhGFX0nDhi8TPK7aDL3C6OBZpUatOLTlfsSQ3qlee1Ps3Q9S6
         0b6w==
X-Forwarded-Encrypted: i=1; AJvYcCWutTuoNUTEb/tJOsv2H6yDnpni2qOCgHOMIy4IEVT9J7n5t4NtIm2DRFf14COz6mtn1qM04A482my7NH1jWvRDXRVHMU2/Kr+Z9chs
X-Gm-Message-State: AOJu0YzeT5y1yF1X7h96/PMmoGngmv+YfTlpxZZXSTI7A7VRl1eRg8tW
	GhVgAOhUi7r0ElRscY7SjLCjAGnmx0IalwnHh0qr9rRV/Pngt9su5jmPHwboZtWdUeqfSHAMQah
	7XjfCpevIr3BzeiFHZz4B91HKigftjtLDFOh3OTF6z485+4+PpQ==
X-Google-Smtp-Source: AGHT+IEjJYsFfUC6UHXPnJ7kUCMnskRfiGpUt22qAed2sk/omt+vEb3Hpy6oxbJiGfjW55DOs4/dXz1SruMUHW4e7Ic=
X-Received: by 2002:a05:6808:23d5:b0:3c3:e03a:d7 with SMTP id
 bq21-20020a05680823d500b003c3e03a00d7mr4175624oib.11.1712268165643; Thu, 04
 Apr 2024 15:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404162515.527802-2-fvdl@google.com>
 <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com> <Zg8TJ3CERBAdJRTd@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Zg8TJ3CERBAdJRTd@P9FQF9L96D.corp.robot.car>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 15:02:34 -0700
Message-ID: <CAPTztWbQ1kLw9H9FZW-qiELQpMjSwUx9Vwjg2j+bXdMt-P63Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, muchun.song@linux.dev, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rushing is never good, of course, but see my reply to David - while
smaller hugetlb page sizes than HUGETLB_PAGE_ORDER exist, that's not
the issue in that particular code path.

The only restriction for backports is, I think, that the two patches
need to go together.

I have backported them to 6.6 (which was just a clean apply), and
5.10, which doesn't have hugetlb page demotion, so it actually can
pass the full 1G as order_per_bit. That works fine if you also apply
the CMA align check fix, but would fail otherwise.

- Frank

On Thu, Apr 4, 2024 at 1:52=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
dev> wrote:
>
> On Thu, Apr 04, 2024 at 10:13:21PM +0200, David Hildenbrand wrote:
> > On 04.04.24 18:25, Frank van der Linden wrote:
> > > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > > cma_declare_contiguous_nid (the alignment, computed using the
> > > page order, is correctly passed in).
> > >
> > > This causes a bit in the cma allocation bitmap to always represent
> > > a 4k page, making the bitmaps potentially very large, and slower.
> > >
> > > So, correctly pass in the order instead.
> > >
> > > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugep=
ages using cma")
> >
> > It might be subopimal, but do we call it a "BUG" that needs "fixing". I
> > know, controversial :)
>
> We probably should not rush with a stable backporting, especially given y=
our
> next comment on page sizes on arm.

