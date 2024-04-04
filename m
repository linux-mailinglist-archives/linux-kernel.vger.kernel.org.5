Return-Path: <linux-kernel+bounces-132113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF4898FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AB31C2281B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CF13AA27;
	Thu,  4 Apr 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIfBnDv9"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07813849C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263740; cv=none; b=Skmz21W7aoWMIBXL0P80M2W4mj1zaE+rcZyS62tXqkIs4Sidd61/SknAorj6JaSyAuQwlLPeRFksZ0O1ppLnnWLbzdaO0M4n5Tntrsc1lc3U18Lglg78BZU7WTm93hS8PSLhVslrZjuE2waVZ1X2SxdMOffyJ9vWH6RRo0d2pFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263740; c=relaxed/simple;
	bh=33fiqYC3OnT4lVMpQCQzjICTjtiNA2U7R+bnXyZ0lIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoqFgSK/hvteoN3UowGqZhAM74SXqDR0KOi3SRBs932wt3OXAe2sxCayvl0zzQvU8BOlMPAGH9O7ODR9Z3BiaLbpYoEjRbLbKGTnU1SlxpYuPe1EEKc576I8UkcgVuaO1iPiB2UAHNfYEFL5+tcuENb+/xsybu1aZlFEKg8TaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIfBnDv9; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-479d3ee92d2so263416137.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712263737; x=1712868537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33fiqYC3OnT4lVMpQCQzjICTjtiNA2U7R+bnXyZ0lIc=;
        b=BIfBnDv9GAGnsFabELc5cdOmaasYDTLi+6MYEo3ENdRDFAbjNbAfu828W9gadO8J2E
         EI9Ic2Tv4yAvEHajeqr80ykT4FhWMRLzaCQ8Vmc293K2j6yzgI4kpQjK9QANa0XrPkio
         iDhPv7jUDmRKk5Asv1bEdx8pN/ZlG3vPq8XTvY5ZkSOxTjO1dS8Ylgy7q46U7djo7mqW
         HGk3fRIl8KbauRSOPbe1XCdeltAu6CPftC2RoZX+OLFbE3Tg8oFZjnjnoUHWp/92/XjM
         scGVQ3IO4eMe2+I7scJDT+Ns7vhGYxIkSUxfDa6u+iz1ryw5bbyrZoNEO7LyRVUBNaaP
         g/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263737; x=1712868537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33fiqYC3OnT4lVMpQCQzjICTjtiNA2U7R+bnXyZ0lIc=;
        b=iwhEo5eH+vukzKixvej1n3GPs3/OLIhkWergipq5R5w//kBqMi4OO/4kBysGfk001m
         JytH6fi+UMvab7w9YtRdv+ftRXUTZgZzsw/f6wXnQrYIPEzf35RU68C/lHdkD+/+yOe7
         O11ZAsdAVZgZ8dEDmLzh0vDatpHptuTL1LIanMnr96PAkHLi1077vGkytHxX8DVVAwR7
         zUHCTphZb+6aGw9HyzNgwJa/MW+SPguWG1ppFr6Maw9VuKhq7ekLOXj79l89C/gubS2B
         rjpY/EXN6XXqDJ5VlfhZsx6Lsg22ZGziN20rtqiAfYADgBEbFSNmWsgk6ki3MPYllD8V
         gM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbB7K9JXzIFfC64wZwOJxadkHM5d93Lu7bP4PEogtJtHzk5I9Vl2mG6v04pVEjYZe+CgYv5xubqjyIGW4IPASdroloBTN1bS78NjN2
X-Gm-Message-State: AOJu0YzV8oEcdxddE4wD5Pa16HziKCNCwBu0Dm5qFEv9yMYmlLYCeMK2
	+YNFGkFbELxBOB67LKKazeLTnnwMnrc3S8pksVwgjNv2JXvZypdXKhjz3CYC3GR/i0M7bGCr4Bc
	IukUcvfjaHh6fc7PabyVNcI6cAMxGJRlCEMy9
X-Google-Smtp-Source: AGHT+IEgt+vrJuKet5+vLsOk9Xw317JIzuz1PvdoIHLkuVVDTlGkLl8XBDiu/7CjHj4ix2J6j72kQLMRIUDHkY8/wac=
X-Received: by 2002:a67:ea94:0:b0:479:bfd7:21a with SMTP id
 f20-20020a67ea94000000b00479bfd7021amr2861352vso.33.1712263736899; Thu, 04
 Apr 2024 13:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <93eccef7-a559-4ad8-be0f-8cc99c00bd09@redhat.com>
In-Reply-To: <93eccef7-a559-4ad8-be0f-8cc99c00bd09@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 13:48:45 -0700
Message-ID: <CAPTztWaMq7ogS_vgBTzUSmoosb1XtNO7FoYSSsUz-QEJBZtCLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: drop incorrect alignment check in cma_init_reserved_mem
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:05=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.04.24 18:25, Frank van der Linden wrote:
> > cma_init_reserved_mem uses IS_ALIGNED to check if the size
> > represented by one bit in the cma allocation bitmask is
> > aligned with CMA_MIN_ALIGNMENT_BYTES (pageblock size).
>
> I recall the important part is that our area always covers full
> pageblocks (CMA_MIN_ALIGNMENT_BYTES), because we cannot have "partial
> CMA" pageblocks.
>
> Internally, allocating from multiple pageblock should just work.
>
> It's late in Germany, hopefully I am not missing something
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> >
> > However, this is too strict, as this will fail if
> > order_per_bit > pageblock_order, which is a valid configuration.
> >
> > We could check IS_ALIGNED both ways, but since both numbers are
> > powers of two, no check is needed at all.
> >
> > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Fixes: de9e14eebf33 ("drivers: dma-contiguous: add initialization from =
device tree")
>
> Is there are real setup/BUG we are fixing? Why did we not stumble over
> that earlier?
>
> If so, please describe that in the patch description.

Nobody stumbled over it because the only user of CMA that should have
passed in an order_per_bit large enough to trigger this was
hugetlb_cma. However, because of a bug, it didn't :) When I fixed
that, I noticed that this check fired.

- Frank

