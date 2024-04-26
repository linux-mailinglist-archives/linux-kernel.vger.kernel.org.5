Return-Path: <linux-kernel+bounces-159421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299258B2E67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D22C1C21301
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130117C2;
	Fri, 26 Apr 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx0PmWmX"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C9EBE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714095941; cv=none; b=CURh8lBtolPShnUFAY2XNRRYpILPaExTrptZsgmzW89+iP+P1WruTBJpefsJbOzfinasSPrqWkvy3XLPZBriU2OeKFW1oB8ZdfMSWhLDd9d9jqL5fUYn0wFk0uXRJhhyezriGgM9pzbgFp2j01yTDbYjPg9LPb31yEa4cZ2eaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714095941; c=relaxed/simple;
	bh=DmEBYTxSoS0+TC1HxPKfke+iPafFTi7krbSlk96PkK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGKcCRRyFJVAi6fKE8coPEUIoQhySh6AyN/UM/f9ZIJsIr7wTbU5esEoNrD24BfBcdPH8kYjoMIfur4VIzd9lhm8Zc4kbetYDAiuCpJhhY4mldVIsu/GxenkItnITlJWfbPgFknV8Ij6XUqLVNuIDmb/Wq7AGkmwShYv0u9YXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx0PmWmX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4db24342894so547158e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714095939; x=1714700739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6b0ZXwqYFEJjvvbeKO3PjwCqkPqlL7SIVe+m+maAxc=;
        b=Yx0PmWmXJjiT3z3KVBRnH5tAAZerOqusCIrC/Alt1o/MiQVfLiISpoREzhWObaxC/Z
         qGoYmVTysW6whcoSs4YmWiOvHY61Fzb7ZjIKc+WuJ7owZuSkF8Rs3a8/6j2yR5nL19ys
         Pc+giXf7bw2sZac5ky8AUJdVs46elr9h9uGLEPqQ/TqqaHN+Pmjrc7WChn6njZM48SlH
         6QRJfhHCO8TXZfsOeQzZgWyNjjtyTw3AXR51zxUyzVuBBUuKPTlazei+4fQJ66UdLt7B
         0mq8YJkp3Mvc+Lisg2T/qpX3rnNvp1ifuOhOBaHvGrysfDLwgr+NsZy9w1cm2E7C0rJE
         fFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714095939; x=1714700739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6b0ZXwqYFEJjvvbeKO3PjwCqkPqlL7SIVe+m+maAxc=;
        b=vsQS+6Zi/6TeJ03tjk9/qQ7F9cg7zxls1jDxeimSsf05dMhh6020rs4zEueRaEwD9b
         PlrpsPFS5lAOLR/bxhzbggW4horFpqkQeyQRl7lMxWM9iRjzGuCCqwzeP5JR+Eu+y+0f
         KXE6SMjn1/wI7h5dhXmY0UNp68RA+5IlQySzni9G+0ihR3KcX7ICugb6XHU/tnZlfEMS
         7vKtehFPm9coHht3rnVhclkmMQQqy4Wh1/dW3rtnBuOFZjALffXuitlHTJZAXm/yqyS6
         p8VpF4DzdnNRdkYKahn9jZuNTzcN8vL8AtRmdSNKzw7TcLTXA9q3v7lvi5/ffybkbfmD
         5AYA==
X-Forwarded-Encrypted: i=1; AJvYcCUcmk2sVeEKK5UgNI+4en0XqfeQ/6dgT7KOtE5lU8Abf9scZWZlfZOGobP6HgEpHjhU7l58mjudWM4m6Yp/zVmUOJOmAdWQIWxb6z6M
X-Gm-Message-State: AOJu0Yx7AMgoQdua4dT3Lm/6wMWELsEHo08pGaBrjGjfO03MnE3pXHi5
	QoMeD6m4CPHLBMO9lxkQzsJavLmAMr3fvlI/1ou32AeLPNHSieSf8B/r47l8qG7Y6304loOCEtt
	eOD2jQWKng2fDunEE5veRrJ3B+XWr9XMWZyM=
X-Google-Smtp-Source: AGHT+IFsq6uOpr9y9eVY1eAlsBoEVM5Ah3t3NHkW7FSGnKhuHeopR4wlncx05WyB+oiFlKujFZPSUB0FJ9zowYhu9WU=
X-Received: by 2002:a05:6122:3c84:b0:4db:223b:1c0a with SMTP id
 fy4-20020a0561223c8400b004db223b1c0amr1310519vkb.11.1714095939129; Thu, 25
 Apr 2024 18:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com>
In-Reply-To: <20240425211136.486184-1-zi.yan@sent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 09:45:27 +0800
Message-ID: <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. But it is possible that
> the folio is fully unmapped and adding it to deferred split list is
> unnecessary.
>
> For PMD-mapped THPs, that was not really an issue, because removing the
> last PMD mapping in the absence of PTE mappings would not have added the
> folio to the deferred split queue.
>
> However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> they are always added to the deferred split queue. One side effect
> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> unintentionally increased, making it look like there are many partially
> mapped folios -- although the whole folio is fully unmapped stepwise.
>
> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
> folio is unmapped in one go and can avoid being added to deferred split
> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> -- or where this type of batching is not implemented yet, e.g., migration=
.
>
> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> to tell if the whole folio is unmapped. If the folio is already on
> deferred split list, it will be skipped, too.
>
> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/rmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a7913a454028..220ad8a83589 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) &&
> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
> +                       deferred_split_folio(folio);

Hi Zi Yan,
in case a mTHP is mapped by two processed (forked but not CoW yet), if we
unmap the whole folio by pte level in one process only, are we still adding=
 this
folio into deferred list?

>         }
>
>         /*
>
> base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
> --
> 2.43.0
>

Thanks
Barry

