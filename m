Return-Path: <linux-kernel+bounces-112259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13F88778C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFABB21B61
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D47D267;
	Sat, 23 Mar 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PoL6haEJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7122C80
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183107; cv=none; b=OdQp6QTdXv0O69jEexN5FwtCeMjHUV9A8nM57NygcV5tlREhVntMk7znD9miL2wXlMCjw6w+LkcFRcrFsuxSKZCR8apetb12FWyLC/OkLEN4Ia4F/8gOdpUDxJC5tx9ThH2XdK5ys6ffGSZmoC8g/1p0idDPwCZ3G4zJica0jWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183107; c=relaxed/simple;
	bh=Ok5fXm8CszjuwHbJh5HS9+O1GUpBI5hEjbWwIhd5tv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1NDHRaGkTZrItg0hKiSrYuMWiWNTHD16bjPOZ7dL4yJKZ+A11CJmbkoQXwK1BB4IlV2b0Qs6PV3wbvl1y0RcX7CnmpR9QLzvSLBhanswhFF5usIlCPJm4rOxo8iZF+db66diQlkuDx1gre7TqIkf1NuiKYivFBSgKYh6NMg7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PoL6haEJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so41017241fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711183103; x=1711787903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3QPhhaDkr5PVLV70HuhVyiAoj596WZlUI+Mtwdvmno=;
        b=PoL6haEJRTLriri2kOtZYsLsH6HIdHyvIr0TkK4FC8jVib8+gdJx/ep0qQkLUSujTI
         Dv9Mmk2Mf5ymsGR4RFJsMXlwUd4Im1IDPnXl8PUCpTklEA6oS78Lx7jcVHnimguTnnl0
         iKfGn9GFdncx+tnqv9aHwX1Rxi+VNZYDr6O12HedRWQ7dyynf7BCJGSsFUjO6vrSROng
         1vNWWA7hiby64H10j6SbncLdcYR5UxNTcFer8KJ7I8sJmaAf9ZQbGiyB3HA+cJj+RYdP
         CQJwHGQbOPjKlVOuqNysMkcl4vTayQGZBd+W8hv2oAtp7fX8zq0riWEQJVl2O4zRXhi6
         KNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711183103; x=1711787903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3QPhhaDkr5PVLV70HuhVyiAoj596WZlUI+Mtwdvmno=;
        b=hYHCrnLyX1IKTA/GUDsu/Qybgw1MOHLgaw6xM+54SvzXSYg7iTbsjeySVWqYa/LbDg
         22KXnzukMn1/cgJayogBbf9KSwTioTjUjy3OtEWVT3j71YxuaYlRalMi7mJ4t3lxRoXk
         dyRQtBXMx6XxLGwOhvdtWqq2dEFWWhraYQYpKSTfV/WuFcuNRkhtt68F2/xLY+qbh2ze
         pv52goZFpyspX8NSerwtkvTOTq8FHRD3ksc/8ddTKGqkpf1agxeTXxAZic9nuB6fs6q2
         R+dKf7g4rM7SyNBZp7wsClChmgYH8IqPpd5TRDknm04B+G5DvSD9mpwzj54hhkMnklw7
         uL5A==
X-Forwarded-Encrypted: i=1; AJvYcCXhY/rToGBpdV9vFvmF2oidX4YKEEl2e/XCi2LwiWhfIbrUSok1OAVRW2fRXdruBcJE0vX+2y1kzHo9TScGuHmrnQomaTKj5KSOv3Pl
X-Gm-Message-State: AOJu0YxCUVM4A4/OAaqHivRh2gnAp2pw5zvo/HVAdU5x6c7w+x5jdr1h
	EB3qSq4xzE6ihPpK/Un4qU22yibpxqwv4OgGnLvcyFOdBwxYSkIi4laZp3jpEBBtR6SYwKmSW+l
	m8c7Ox+DmrrxOAmTKHWIttBug47XkxLx/Pl5KmQ==
X-Google-Smtp-Source: AGHT+IGf1ePLVQ3GtNmT+nk/C1U229ozPox6gLzk45w+ERLHgE8VyHto1lwFRrftaW6XEPZnRQmt2uTtTVMVaD9WgFw=
X-Received: by 2002:a2e:9613:0:b0:2d4:72be:e2c6 with SMTP id
 v19-20020a2e9613000000b002d472bee2c6mr1043129ljh.52.1711183103334; Sat, 23
 Mar 2024 01:38:23 -0700 (PDT)
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
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Sat, 23 Mar 2024 16:38:10 +0800
Message-ID: <CACSyD1MAkuK-n85gOHPxCNj5iDEHwP5vOEAZKn0woQ-Nv-ZHRA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] mm: add folio in swapcache if swapin
 from zswap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev, 
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 7:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
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

Hi Johannes,

After a few hours I haven't seen any problems.

If you don't mind=EF=BC=8Cplease add the following tag:
Tested-by:Zhongkun He <hezhongkun.hzk@bytedance.com>
Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Thanks.

