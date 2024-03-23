Return-Path: <linux-kernel+bounces-112126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E78875F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D66D1F2203D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6155399;
	Sat, 23 Mar 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKsMt7DQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C56372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152917; cv=none; b=A00eqSPClBdqI/EyaBA+mWlY3G15sy3R8rJbiR0WY34HOq2B8X7jN8Xvt+V/mlPvOm+WNytCQrLr325O3kSfID+eprd5alhjDGxcL8Z9eYERgNHIMLcYYEfTI62fBfhk/wuaRve16+0HyMw33TEGR7CWy+VIqTK/AucH3tkz5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152917; c=relaxed/simple;
	bh=mqueisu5sCA3A19tLhxtWR0sNXQ6O5QqUP9Dth96xrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3Jvg09ctGB2mnDlRLxxw4tslb2JNTlmyIM2bBCxhKCodMD9d/SvJgQ844q2I38aqLhfUYiLIxDlfSB1l8OXXv2Hd2U+ciYVuWahYOFsCvMQcpoihQJY/2KftraKn8jggm1l6cUkuF4EJefYQ2IV6h7OVSSsIpmO7GbikoBha/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKsMt7DQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a471f77bf8eso244606366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711152913; x=1711757713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkUvhTBt1IYqiRZpIl+GFpvoPq0KklV0EtW5qagQ88k=;
        b=bKsMt7DQoOKLx1Mi5DrVMZYaQlXz5Z3SdHT1bM3MJHG4fwdA3TMBK4TBRGRRh7aG/4
         VUI7iTbjCzNL5jA7I+dIxp3AuOlXH+p/Fa5W9fkKt4Z3B4H2EpHsCvyuyfnVljrXkp49
         CI0Gqsb1ZKF/jhKBJKRLUHLAGjI8jzB1xr85iEUxrDdv27TXqsYIm9CbVvdDpNOfDLFu
         ZJFNej4rG0pCBFAqTN1Ma8xCoeU/MjumHBWkXxPpVlRUe/BpEFQnpAfo2s9YIP8Vr45Q
         lm6eedracFA95NXGRF0DEff886HKigGWrcbQ7GWoNq4xLE+TIE5A99OYqJh9a/hNEDq+
         WSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152913; x=1711757713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkUvhTBt1IYqiRZpIl+GFpvoPq0KklV0EtW5qagQ88k=;
        b=sADe0/mitlhTySPZkKONv0b+bqTEJL1m8FLD8yV9ODfUiGgVIu9NfTvlmP+GIK2dqv
         5TBbMXh40IHnxlpWeAV7avjJzhrs2tFHqXUpsi6vNRyPUfHahYotoDeFsNekBa5sQTOR
         O3syRyWgfHCJjy9evGsQ8ibK9N1c16bz2sb4qES48ADuBwUU8pDZxVFN6reZ8jB588Ro
         S7ZPNW1Lt3McSMyX45rpFae0q4BTs7xiy/xgpEzHY5plLZ5RvOvnjg+IR51KooiTryGU
         6FlKu9DA3oJgxRQiYfYc6jOrMgNXBDs4iuBq5mfoCwqz7Jnm0k8UIMTWPthR9sRxhDRx
         +V5g==
X-Forwarded-Encrypted: i=1; AJvYcCWy+JgqMi3jdcmJDxnDAvlCal6ST9IJbPUnFoOX78rcBgVjkU8MRL0AgtcHFGXHyLl2jJ9BTW3DUIquuf0UHclXbfFhMBdntxrkfiRd
X-Gm-Message-State: AOJu0YySeBz/SCOBjXLkFcms4tc/zqhiUciQ9d5vOI86pljRnRlCr7no
	6+iuZHCN0HqG/3Ce2h+5a4JUp5TTOJtYIO19b3DIrcrhj9bjLTVzAjATs2dUfr5q8AMAeWU5v95
	KvafTGZDqp2+pCJD0YR5td4ooDpevQXQIodS9I27u+3U2Q2UqUg==
X-Google-Smtp-Source: AGHT+IHkVoCll4b8OJSRskIDAfCmLxIBXHf5fO+Fei9Lq6oSjF56LnVWN3ybeliChP/rwQTDV0/JY0E1UG6DpAlQ9jM=
X-Received: by 2002:a17:906:a217:b0:a46:e8dc:5d51 with SMTP id
 r23-20020a170906a21700b00a46e8dc5d51mr731356ejy.25.1711152913434; Fri, 22 Mar
 2024 17:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
 <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
 <Zf4HKUpKpDWZygni@google.com> <20240322234826.GA448621@cmpxchg.org> <CAJD7tkY2y_nGRq9ft80op6q0B3tfJvtyqYhS6t+x=TpyGy+AXg@mail.gmail.com>
In-Reply-To: <CAJD7tkY2y_nGRq9ft80op6q0B3tfJvtyqYhS6t+x=TpyGy+AXg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Mar 2024 17:14:37 -0700
Message-ID: <CAJD7tkZqrrXuYTMYOAP+arMLeNayafFeLocWu7bJtDFHCYjwDA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > I don't think we want to stop doing exclusive loads in zswap due to this
> > > interaction with zram, which shouldn't be common.
> > >
> > > I think we can solve this by just writing the folio back to zswap upon
> > > failure as I mentioned.
> >
> > Instead of storing again, can we avoid invalidating the entry in the
> > first place if the load is not "exclusive"?
> >
> > The reason for exclusive loads is that the ownership is transferred to
> > the swapcache, so there is no point in keeping our copy. With an
> > optimistic read that doesn't transfer ownership, this doesn't
> > apply. And we can easily tell inside zswap_load() if we're dealing
> > with a swapcache read or not by testing the folio.
> >
> > The synchronous read already has to pin the swp_entry_t to be safe,
> > using swapcache_prepare(). That blocks __read_swap_cache_async() which
> > means no other (exclusive) loads and no invalidates can occur.
> >
> > The zswap entry is freed during the regular swap_free() path, which
> > the sync fault calls on success. Otherwise we keep it.
>
> I thought about this, but I was particularly worried about the need to
> bring back the refcount that was removed when we switched to only
> supporting exclusive loads:
> https://lore.kernel.org/lkml/20240201-b4-zswap-invalidate-entry-v2-6-99d4084260a0@bytedance.com/
>
> It seems to be that we don't need it, because swap_free() will free
> the entry as you mentioned before anyone else has the chance to load
> it or invalidate it. Writeback used to grab a reference as well, but
> it removes the entry from the tree anyway and takes full ownership of
> it then frees it, so that should be okay.
>
> It makes me nervous though to be honest. For example, not long ago
> swap_free() didn't call zswap_invalidate() directly (used to happen to
> swap slots cache draining). Without it, a subsequent load could race
> with writeback without refcount protection, right? We would need to
> make sure to backport 0827a1fb143f ("mm/zswap: invalidate zswap entry
> when swap entry free") with the fix to stable for instance.
>
> I can't find a problem with your diff, but it just makes me nervous to
> have non-exclusive loads without a refcount.
>
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 535c907345e0..686364a6dd86 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
> >         swp_entry_t swp = folio->swap;
> >         pgoff_t offset = swp_offset(swp);
> >         struct page *page = &folio->page;
> > +       bool swapcache = folio_test_swapcache(folio);
> >         struct zswap_tree *tree = swap_zswap_tree(swp);
> >         struct zswap_entry *entry;
> >         u8 *dst;
> > @@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
> >                 spin_unlock(&tree->lock);
> >                 return false;
> >         }
> > -       zswap_rb_erase(&tree->rbroot, entry);
> > +       if (swapcache)
> > +               zswap_rb_erase(&tree->rbroot, entry);

On second thought, if we don't remove the entry from the tree here,
writeback could free the entry from under us after we drop the lock
here, right?

> >         spin_unlock(&tree->lock);
> >
> >         if (entry->length)
> > @@ -1649,9 +1651,10 @@ bool zswap_load(struct folio *folio)
> >         if (entry->objcg)
> >                 count_objcg_event(entry->objcg, ZSWPIN);
> >
> > -       zswap_entry_free(entry);
> > -
> > -       folio_mark_dirty(folio);
> > +       if (swapcache) {
> > +               zswap_entry_free(entry);
> > +               folio_mark_dirty(folio);
> > +       }
> >
> >         return true;
> >  }

