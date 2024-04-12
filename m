Return-Path: <linux-kernel+bounces-143317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17348A3720
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250F51F2144B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB281224FD;
	Fri, 12 Apr 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFr8EmDi"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88C4C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954171; cv=none; b=aHnI4208vjVmBNAMqU9KFz9pdbHLh151LJ63wcDvNL8RUwjxcnlKQN8LrTww8JAiAS0OuzBh4A33/wCuW7O+uudnF0jRdJfDoyR/jdLnV5aqnR8fYabIhIj7NWPVM0PgOtkw+e7su54DtAq54k3GE5/u5gPvaBA7V6djMQgxUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954171; c=relaxed/simple;
	bh=w6wx3JBuVV85eKjiqqgFBN8pDRB2iPlY9GJ9tCkAK90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q317g2pkSWmntgFqZcFNi9XO5EpcgxkHT78cJf+frodhazMMp7XhWxPWOBHP3XUuP+Mp/06dNFP89p4m2M3scwkPgO1EXcgzD+XPmepYJDjRenA/IYY0oHgjcah4CkZ+XSLasECGM5eJlQ7Q8nQy3Kulbl5QDb6T/1ykD1lzYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFr8EmDi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51beae2f13so152109566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954168; x=1713558968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwF5Q5R7Qkp4qYnTqzK2FqyRjSnKNNcNhwy8t7pOLVc=;
        b=LFr8EmDihLOhT5Ma1e2ateEk0A324MsdZ2YYjKjpWrY9XBeoLGJ4ymhUFlAlFkNRt9
         HlHB3lt0+CqBYPPM5GmXyYyztCwwtBoK9FTeUTEjrslGVbFOPpZSBZcTyhJhDs5kO3eH
         psTm3xGovelRF+ywmegcD/f1BtaqMV4Snfk3h9bVXLac47rYETm8eWOg+QDsvxX0L71o
         RO7ezhb598vCa+m3a88/Ad2qvdVDDphbwr5+QYTO8Qn27V8smRjDUoHBeDazxqIg4EJm
         CFWZ94zxDVSjx0fLnl7xfdMg9qAk8O1xXTI+3LEuh8XUtUPOANrol7w2BbvzxiMjp0Fw
         jqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954168; x=1713558968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwF5Q5R7Qkp4qYnTqzK2FqyRjSnKNNcNhwy8t7pOLVc=;
        b=e6FU+tbcwlnRksNLZIBsnSkYIt1xWlMQIiaCi18alhuRxtmL4PTYCa2jesyFZxMY9K
         qJP1YVecNqgD6gGEj1S0eg41cAQO+aDoVmSQSHxg29Ff4dBPX3qnFRS1G71OENpmzasB
         6gcGpg0FXUEVbmDLMn2IcPmSF4CmOHlEIuT32YdpRJERbLSpRUfO+sJ5pAU2KxxqrebX
         VwW49tvE4iB26DQqi5RGmcwfu9njz+K66v2Vua6blDhp/ezwZ8kniNFo8zO/K2RCwVqy
         EnHINfFyuiPpWXhuQqfCU0yp9+VRm+G0wljcy4OHIgY50KsBZqdykflIHkRx6JX1CDIo
         LT/g==
X-Forwarded-Encrypted: i=1; AJvYcCXJGzF8d6TGDVhXuldQ4PVh8MEmU+H/2WasQUJIP23P6FE00znkyFkxY2bY8/bM9eeVLC6eJtAj+Dhn+KLsnUlChy8PgHK2xqfbeGZC
X-Gm-Message-State: AOJu0YxpZhNBQMSPhYGjb/Nwa7L7ljxd97OmuOhcZGipbYCKR+bonSXT
	i6/blbBHC7t5rWhL2COUE+5UrQNZzltUUmxYPq75sghzm0KaVP1YMLL4tBfmv+RAS6y6M1lPif1
	Vj/wOCR8zw3qqi4JJPukLhBsTkmE=
X-Google-Smtp-Source: AGHT+IGsh7L52vGNIGsYorqSd0cWDewuHZsE+togqNSWvkcBi7SwWCLDBnTQNNy6VtGVoKaPQ8tnyb6IAV45bVVJScY=
X-Received: by 2002:a17:907:9705:b0:a52:4403:9c2 with SMTP id
 jg5-20020a170907970500b00a52440309c2mr492944ejc.14.1712954167248; Fri, 12 Apr
 2024 13:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com> <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
In-Reply-To: <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Apr 2024 13:35:56 -0700
Message-ID: <CAHbLzkoQWXVUH-2HE9iwjZujAOMOup=KFLovZz71+7b6N_KxnA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:33=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.04.24 16:35, Zi Yan wrote:
> > On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
> >
> >> On 11.04.24 17:32, Zi Yan wrote:
> >>> From: Zi Yan <ziy@nvidia.com>
> >>>
> >>> In __folio_remove_rmap(), a large folio is added to deferred split li=
st
> >>> if any page in a folio loses its final mapping. It is possible that
> >>> the folio is unmapped fully, but it is unnecessary to add the folio
> >>> to deferred split list at all. Fix it by checking folio mapcount befo=
re
> >>> adding a folio to deferred split list.
> >>>
> >>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>> ---
> >>>    mm/rmap.c | 9 ++++++---
> >>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 2608c40dffad..d599a772e282 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>             enum rmap_level level)
> >>>    {
> >>>     atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>> -   int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>> +   int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>     enum node_stat_item idx;
> >>>             __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> >>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>                     break;
> >>>             }
> >>>   -         atomic_sub(nr_pages, &folio->_large_mapcount);
> >>> +           mapcount =3D atomic_sub_return(nr_pages,
> >>> +                                        &folio->_large_mapcount) + 1=
;
> >>
> >> That becomes a new memory barrier on some archs. Rather just re-read i=
t below. Re-reading should be fine here.
> >
> > Would atomic_sub_return_relaxed() work? Originally I was using atomic_r=
ead(mapped)
> > below, but to save an atomic op, I chose to read mapcount here.
>
> Some points:
>
> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
> RMW that return a value -- and how they interact with memory barriers.
> Further, how relaxed variants are only optimized on some architectures.
>
> atomic_read() is usually READ_ONCE(), which is just an "ordinary" memory
> access that should not be refetched. Usually cheaper than most other stuf=
f
> that involves atomics.
>
> (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read(map=
ped)
> to figure out if the folio is now completely unmapped.
>
> (3) There is one fundamental issue: if we are not batch-unmapping the who=
le
> thing, we will still add the folios to the deferred split queue. Migratio=
n
> would still do that, or if there are multiple VMAs covering a folio.

Maybe we can let rmap remove code not touch deferred split queue in
migration path at all because we know all the PTEs will be converted
to migration entries. And all the migration entries will be converted
back to PTEs regardless of whether try_to_migrate succeeded or not.

>
> (4) We should really avoid making common operations slower only to make
> some unreliable stats less unreliable.
>
>
> We should likely do something like the following, which might even be a b=
it
> faster in some cases because we avoid a function call in case we unmap
> individual PTEs by checking _deferred_list ahead of time
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..356598b3dc3c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                   * page of the folio is unmapped and at least one page
>                   * is still mapped.
>                   */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped) &&
> +                   atomic_read(mapped) &&
> +                   data_race(list_empty(&folio->_deferred_list)))
> +                       deferred_split_folio(folio);
>          }
>
>
> I also thought about handling the scenario where we unmap the whole
> think in smaller chunks. We could detect "!atomic_read(mapped)" and
> detect that it is on the deferred split list, and simply remove it
> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
>
> But it would be racy with concurrent remapping of the folio (might happen=
 with
> anon folios in corner cases I guess).
>
> What we can do is the following, though:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dc30139590e6..f05cba1807f2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *folio=
)
>          ds_queue =3D get_deferred_split_queue(folio);
>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>          if (!list_empty(&folio->_deferred_list)) {
> +               if (folio_test_pmd_mappable(folio))
> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
>                  ds_queue->split_queue_len--;
>                  list_del_init(&folio->_deferred_list);
>          }
>
> Adding the right event of course.
>
>
> Then it's easy to filter out these "temporarily added to the list, but ne=
ver split
> before the folio was freed" cases.
>
>
> --
> Cheers,
>
> David / dhildenb
>

