Return-Path: <linux-kernel+bounces-112125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBFA8875F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ADDB228E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAA399;
	Sat, 23 Mar 2024 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO2+d++Z"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE20182
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152805; cv=none; b=Xq5GNehGLALV7EprR9q3DoIbdfvFwGv3WqZCBolOQFE+6ysRzA/VsjCekJ3itVM3mCUvi2UhfyhWYuLyMcjBLMNAvNiydwCdgo7BpLN6JbqNymdOsSlmDpMUMJj/pZg3qJVUaeTmoprqCDbpMQGvThVOoIwK1+P++6HVsswTmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152805; c=relaxed/simple;
	bh=0GTZluK8Tk9dqMlKthDAUMQmnwQVeEa/jYkGDPEP2g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYeLdHViy9ilmMBZRp6VdE1LuD9JNuY7VTie73IB3dBeQ+PrDrZC9i7dvCFtj0kIKY//a606LDMKgJtInOJfGQCnPUqB0E399aeI6KeuEvFkgVR6JbHfu50eoSDWneJIWIilQLQGwo5wJeH7w3MZbOYLfYOmSes9UGQ0qRBeHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sO2+d++Z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46dec5d00cso348359466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711152802; x=1711757602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTnm6OaJtn/bHPEoB83FQ0QIm/hcDEj2s2zfrDk8C0s=;
        b=sO2+d++ZP2HhjJYWioV1OzdXcCx2ZKxqv/eZiaeGQTe/VK4ZilJ6r65OfyuhEeDl/Z
         l4mxCBwYp/HYPruWSKIisLcVh9RQwjIHZJjRccaxYIKMbLYNhhiqj3hRPhs6p4XNWslV
         ywJYSjchxitTi6WV9S/SJ75dr0jlRyATaoGMVz+1Rvkwx325ZPbv8HNbf/c6MTM0pDMs
         qI+EXAxmw5XiVIFkK8e+Cn4nCEyIDPzaigo6wxL+a6v/KrYWewlu1HONSWtPVSAy9EDm
         0mY38i7HZKjOuGFjb7upL1aimME7reeaiGApotMQEDLi5H6UjJqzjkg+oH5f9XT98Vym
         d4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152802; x=1711757602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTnm6OaJtn/bHPEoB83FQ0QIm/hcDEj2s2zfrDk8C0s=;
        b=MWaqTXl+qBgeR+724UZhIwDJO7UGLTaNb2JrcVED+5svsFHNi6pwrYWQLkdsP6okfQ
         6ST5f35EULh+QRpt7qx0604vHFAIgXL07eguzJJ+0iSsfsxGiB/lzhamB8f9QYGV4muX
         3otb9a9ezlprnylAJdU5vS7dMYrbBUdNWXM90bW3at/T0JD/oi7KZ+gFNza40mjSHfU2
         PU1lwLwGnSNWhpkJkxeNBH/EyVDnX1xjfLsJH80MRDwSaqgGaXnv4K8DQVyzIkIldTkl
         1jUeWDgbVuO2mRj1RDgmDe+nfv42rH/sNIforT10aBi4iX/GUqkCY/Y5bT8NdYI+s3XA
         DeAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFIwSJHuvd/dLKUNaK4gmFcHA3/U2KjV35t6xJq9nHXMKOv42s84MgErQ9MDogp9XAPYv8gdOakf1YRdZ9yAlafwdCtvRjAluMOzHT
X-Gm-Message-State: AOJu0YxybrY21RxaYg8AMZd5NVOesXzoz1eJlCyDMMPuqFa4nfuhTQwU
	KRAu34eA0AH4/L08UgJqoc4WSWwAKxQA6NMFB6453SwW7W0gwZFCZQC42vTB6jfFC5XWqD/fLtA
	/W4ig0M7R7FFM9PgmPVGJLm89BjGmzGyjuXDJ
X-Google-Smtp-Source: AGHT+IGwFY4dieKA9vYo5+qSPgsWn9qbdg6n0ZLkIBmwY3AN/ydYAmA4fjRqgZYY7L3I5suOrOsex9mAXAqJC+k5k20=
X-Received: by 2002:a17:907:78cf:b0:a46:bbb3:f0d2 with SMTP id
 kv15-20020a17090778cf00b00a46bbb3f0d2mr799284ejc.47.1711152801925; Fri, 22
 Mar 2024 17:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
 <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
 <Zf4HKUpKpDWZygni@google.com> <20240322234826.GA448621@cmpxchg.org>
In-Reply-To: <20240322234826.GA448621@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Mar 2024 17:12:45 -0700
Message-ID: <CAJD7tkY2y_nGRq9ft80op6q0B3tfJvtyqYhS6t+x=TpyGy+AXg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:48=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Mar 22, 2024 at 10:33:13PM +0000, Yosry Ahmed wrote:
> > On Sat, Mar 23, 2024 at 10:41:32AM +1300, Barry Song wrote:
> > > On Sat, Mar 23, 2024 at 8:38=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Fri, Mar 22, 2024 at 9:40=E2=80=AFAM <chengming.zhou@linux.dev> =
wrote:
> > > > >
> > > > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > > > >
> > > > > There is a report of data corruption caused by double swapin, whi=
ch is
> > > > > only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO ba=
ckends.
> > > > >
> > > > > The root cause is that zswap is not like other "normal" swap back=
ends,
> > > > > it won't keep the copy of data after the first time of swapin. So=
 if
> > >
> > > I don't quite understand this, so once we load a page from zswap, zsw=
ap
> > > will free it even though do_swap_page might not set it to PTE?
> > >
> > > shouldn't zswap free the memory after notify_free just like zram?
> >
> > It's an optimization that zswap has, exclusive loads. After a page is
> > swapped in it can stick around in the swapcache for a while. In this
> > case, there would be two copies in memory with zram (compressed and
> > uncompressed). Zswap implements exclusive loads to drop the compressed
> > copy. The folio is marked as dirty so that any attempts to reclaim it
> > cause a new write (compression) to zswap. It is also for a lot of
> > cleanups and straightforward entry lifetime tracking in zswap.
> >
> > It is mostly fine, the problem here happens because we skip the
> > swapcache during swapin, so there is a possibility that we load the
> > folio from zswap then just drop it without stashing it anywhere.
> >
> > >
> > > > > the folio in the first time of swapin can't be installed in the p=
agetable
> > > > > successfully and we just free it directly. Then in the second tim=
e of
> > > > > swapin, we can't find anything in zswap and read wrong data from =
swapfile,
> > > > > so this data corruption problem happened.
> > > > >
> > > > > We can fix it by always adding the folio into swapcache if we kno=
w the
> > > > > pinned swap entry can be found in zswap, so it won't get freed ev=
en though
> > > > > it can't be installed successfully in the first time of swapin.
> > > >
> > > > A concurrent faulting thread could have already checked the swapcac=
he
> > > > before we add the folio to it, right? In this case, that thread wil=
l
> > > > go ahead and call swap_read_folio() anyway.
> > > >
> > > > Also, I suspect the zswap lookup might hurt performance. Would it b=
e
> > > > better to add the folio back to zswap upon failure? This should be
> > > > detectable by checking if the folio is dirty as I mentioned in the =
bug
> > > > report thread.
> > >
> > > I don't like the idea either as sync-io is the fast path for zram etc=
.
> > > or, can we use
> > > the way of zram to free compressed data?
> >
> > I don't think we want to stop doing exclusive loads in zswap due to thi=
s
> > interaction with zram, which shouldn't be common.
> >
> > I think we can solve this by just writing the folio back to zswap upon
> > failure as I mentioned.
>
> Instead of storing again, can we avoid invalidating the entry in the
> first place if the load is not "exclusive"?
>
> The reason for exclusive loads is that the ownership is transferred to
> the swapcache, so there is no point in keeping our copy. With an
> optimistic read that doesn't transfer ownership, this doesn't
> apply. And we can easily tell inside zswap_load() if we're dealing
> with a swapcache read or not by testing the folio.
>
> The synchronous read already has to pin the swp_entry_t to be safe,
> using swapcache_prepare(). That blocks __read_swap_cache_async() which
> means no other (exclusive) loads and no invalidates can occur.
>
> The zswap entry is freed during the regular swap_free() path, which
> the sync fault calls on success. Otherwise we keep it.

I thought about this, but I was particularly worried about the need to
bring back the refcount that was removed when we switched to only
supporting exclusive loads:
https://lore.kernel.org/lkml/20240201-b4-zswap-invalidate-entry-v2-6-99d408=
4260a0@bytedance.com/

It seems to be that we don't need it, because swap_free() will free
the entry as you mentioned before anyone else has the chance to load
it or invalidate it. Writeback used to grab a reference as well, but
it removes the entry from the tree anyway and takes full ownership of
it then frees it, so that should be okay.

It makes me nervous though to be honest. For example, not long ago
swap_free() didn't call zswap_invalidate() directly (used to happen to
swap slots cache draining). Without it, a subsequent load could race
with writeback without refcount protection, right? We would need to
make sure to backport 0827a1fb143f ("mm/zswap: invalidate zswap entry
when swap entry free") with the fix to stable for instance.

I can't find a problem with your diff, but it just makes me nervous to
have non-exclusive loads without a refcount.

>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 535c907345e0..686364a6dd86 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> +       bool swapcache =3D folio_test_swapcache(folio);
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
> @@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> -       zswap_rb_erase(&tree->rbroot, entry);
> +       if (swapcache)
> +               zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> @@ -1649,9 +1651,10 @@ bool zswap_load(struct folio *folio)
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
> -       zswap_entry_free(entry);
> -
> -       folio_mark_dirty(folio);
> +       if (swapcache) {
> +               zswap_entry_free(entry);
> +               folio_mark_dirty(folio);
> +       }
>
>         return true;
>  }

