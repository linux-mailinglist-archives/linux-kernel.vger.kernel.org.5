Return-Path: <linux-kernel+bounces-59937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881EE84FD92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EC91C21EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE054BE8;
	Fri,  9 Feb 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgeBAByz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701554667
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510614; cv=none; b=uD3hAGZqyblRn65ik9Eb3qGXazRGmb0dW3G4D7WyyZLAE9NnY5yVWNEHH/JPCuqzoJtz7GdxfEAkkssrSW8/FNqB2UbK0j2RSZKeu795IAV6RgW2U+ZcuOykadIe5p3V7MDq1kGGAvWu7hyPJdLMm0MXs7MFrMeJLxGSB48EoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510614; c=relaxed/simple;
	bh=tCxHiKTv7x7u6fH/xB9kfHNFRgKI7cTm693HD2GW1rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSbmq1+tEKeGTQA546HdC65+okdcRtv26HgIVVADvZYYuXipgvMH0NxOQRpN4JoVHXC8aa1bLH/befHKzlyBx3rukQEGVDnlSZStmE1Uoflhqep8bxueW4rU2MPykBqxnN6lyo1SqRoIjv2cH/UIACihPJQAXy7PLyksp/ODq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgeBAByz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0e4ef33b2so1137121fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510611; x=1708115411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMjKIw54kDOKhRSgoZvijwtD0+nr1hVe+puyGI6149U=;
        b=HgeBAByzz6vgMBfNVEVWja7bLbQ1fUzR3mNNk0NfzIbkmr/5My5WNPi6z+x0UhMHNr
         ydI3W3ipkqjlBz17AwWL4gk7p36ajBR14XKqXYvkfE2yhxD0CfIJn7zQ5OLPfFTbyQZ6
         mHQf3bS3+9M0iijZtL2q9c++ugE9jqDVcnuOGt0nJzdjt5i3QJIXgS/pntt+vdJPUbt7
         opaFmazARv0jxo2NwdTTCl52PDg16udEaE2cfttVE9L7cp/4LPDXxN684ObkH17BNl3S
         wQdXa8beEOhSYBqsV70UfZ7DOSyvkCBOH9DN5jRYhaESy0oXlA312D4ulrPEva9ZX7fx
         /ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510611; x=1708115411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMjKIw54kDOKhRSgoZvijwtD0+nr1hVe+puyGI6149U=;
        b=cWWYsE6M/qDJF4HOKmTTKhzU4KQCWx0C1at4jeNAUshWyoBOx5OTpumVVeP6RuGn2F
         h6Kyb80TSIMHsKrC4+sEI0rJaNanLRMaFjPZwvUxmqK3qaECp0Sng4dRT1ldQEcBadgH
         6qqvAppl6eE6LgtUkmVhfw7epQXfB0Cf8UIXhWb6n1QHCuDpf64TOa3t/S0f81a8uxvn
         ncoBNtDryWNMmUyHB1Rkx1yA3bIINPInFaq1qIFcfMdMquXIJ7UEBt7G1a/dos1jIc2S
         Z82dMTKlqfyWphIgDZEE8qVhM5YF2Z78Gjo4VoKK2+XJ5X8Zs5nnyvktdlXhrcC9Oj8S
         AOWw==
X-Gm-Message-State: AOJu0YzbeTBJ6ne2D2yp+nBsTaufyeoEp4KhBVv3bnUrIP9dHEbtQJzz
	pUWXOanlHU8hfY83rHrmWaxCjUVrzCeNBUyJufYLYwKHAjw7UmYv/5H+VS1I1lO2zFMKcU92tUT
	QplCHdN2xbuzARbpsPxXj15enu9k=
X-Google-Smtp-Source: AGHT+IG4gptGGFiA3p/G+Fj+qG4bgNGBjD1NRZRpVscN+pmn/Ut6HqPv9jnp69HV+F28gohYiS0SQIooSbtlWerMKb8=
X-Received: by 2002:a2e:8519:0:b0:2cd:5cfd:b19 with SMTP id
 j25-20020a2e8519000000b002cd5cfd0b19mr62539lji.19.1707510610570; Fri, 09 Feb
 2024 12:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206084838.34560-1-usama.anjum@collabora.com>
In-Reply-To: <20240206084838.34560-1-usama.anjum@collabora.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 9 Feb 2024 12:29:58 -0800
Message-ID: <CANaxB-zB6Qs_AYCJCQNC3ekx+DMoXoHB4Yq-uMBm7qs-bMPv4A@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate: preserve exact soft-dirty state
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Gofman <pgofman@codeweavers.com>, 
	kernel@collabora.com, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:48=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> From: Paul Gofman <pgofman@codeweavers.com>
>
> pte_mkdirty() sets both _PAGE_DIRTY and _PAGE_SOFT_DIRTY bits. The
> _PAGE_SOFT_DIRTY can get set even if it wasn't set on original page
> before migration. This makes non-soft-dirty pages soft-dirty just
> because of migration/compaction. Clear the _PAGE_SOFT_DIRTY flag if
> it wasn't set on original page.
>
> By definition of soft-dirty feature, there can be spurious soft-dirty
> pages because of kernel's internal activity such as VMA merging or
> migration/compaction. This patch is eliminating the spurious soft-dirty
> pages because of migration/compaction.
>
> Cc: Micha=C5=82 Miros=C5=82aw <emmir@google.com>
> Cc: Andrei Vagin <avagin@gmail.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Signed-off-by: Paul Gofman <pgofman@codeweavers.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cc9f2bcd73b4..05d6ca437321 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -211,14 +211,17 @@ static bool remove_migration_pte(struct folio *foli=
o,
>                 folio_get(folio);
>                 pte =3D mk_pte(new, READ_ONCE(vma->vm_page_prot));
>                 old_pte =3D ptep_get(pvmw.pte);
> -               if (pte_swp_soft_dirty(old_pte))
> -                       pte =3D pte_mksoft_dirty(pte);
>
>                 entry =3D pte_to_swp_entry(old_pte);
>                 if (!is_migration_entry_young(entry))
>                         pte =3D pte_mkold(pte);
>                 if (folio_test_dirty(folio) && is_migration_entry_dirty(e=
ntry))
>                         pte =3D pte_mkdirty(pte);
> +               if (pte_swp_soft_dirty(old_pte))
> +                       pte =3D pte_mksoft_dirty(pte);
> +               else
> +                       pte =3D pte_clear_soft_dirty(pte);
> +
>                 if (is_writable_migration_entry(entry))
>                         pte =3D pte_mkwrite(pte, vma);
>                 else if (pte_swp_uffd_wp(old_pte))
> --
> 2.42.0
>

