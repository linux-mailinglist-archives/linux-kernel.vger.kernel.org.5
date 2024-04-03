Return-Path: <linux-kernel+bounces-129066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61189643C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7366B21BAF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13524CB4E;
	Wed,  3 Apr 2024 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msAKyTwB"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F811870
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123465; cv=none; b=h5EY3kSLg4RX/FhW9TQocNYUHXXhIt++itVJacEqUKRnn1q+rrvLy6sfMaNjY1v1Noetlh1acM927yp7M0KA7W9EKfINq9Sh5nQvUMfVa1nrw9ozpuanpmzIGAbajhzy6Kmxj3kTj0SSH2Oh6XlQ5QEu97QM9T5J1qqmROPrNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123465; c=relaxed/simple;
	bh=E4FbwUVJWlX4xtcxltOFjRly3b0AT46saRVGRZAwbpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgdEWZd5XKUPRQdqK0qLqTr27H0Mlr9Cohctf37NFDAIpKWGr+a95K+siA4s1DMdDpE3cpUrVxbKHWsWAUswcQ9lVZtniJySIRLIii4lCZqvr7SyJ3IzQLmBq3wTUvMBnI2vG7oM6Vy35JOCMB1JjS/C0qIKMixrSa85CWLTnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msAKyTwB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d715638540so66448441fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712123462; x=1712728262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCe99m+lvX3Q9JdwOVipLcUF6ks8hURE2QgW54n2EHA=;
        b=msAKyTwBL1035beDcwbrXObMP3gITDHOzPZIo35jphL5VQTtApAAcdNNSM1SgAUz1K
         0wq67t9BURBlSVZYpOX0fx/0D20HyM/FHAMbK0tYdcryaFFIWVvCSLfYi/Ca7oOcsS8i
         Ljv3Ez7Tn/Vs2XsbvgFbwj40Ybrbwsrw72bge6uPwTkqqW3Q1c3F5b9M/xhwAsq90wzb
         tUbUtKmLMOtGCANVITMpADDNnJz9l4BE8Fc7FD7UxgNMKtvPKVjzF0lDt9j53tovVNDa
         qVkBx+li7Hnk6e0OxuNwU84KsmaQTW17jWbl2tKZNN2y9IgmjipUgXPebTAf1ljL30N6
         AMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712123462; x=1712728262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCe99m+lvX3Q9JdwOVipLcUF6ks8hURE2QgW54n2EHA=;
        b=jarSe+O88ii4G9LcwDL7RrHfhdnXK1Koru0WIsB2RQMHaHORtmesuHm+rlhsPboOex
         pmYYE5JbJ2EXs5MtSZqD3w+YvQwGSJSNgvywOSTHiyAZ44DsY0kRJ8szdpU3/ehauKbH
         9yQqrrg/48G9KW5BYFYsQgzlNeAsHiygTN0ZQMVhNE2ZdGxs8lgqCC3XK+Ea2zxRTL+P
         gqJa5rrHlj8AmbuW8RW/Rk6MTKM8BnsmpYtV5T7i/FtFvIcqzA0Wne4fb9R33bMR26k/
         eZ5sBx55SiB3n97h0CncMtXfpZyxH7DOo+ZWqeAD9Vw7PuGaWdsJl0g2gWzZSrWQqLs9
         IpBA==
X-Forwarded-Encrypted: i=1; AJvYcCWqwLPDZ3PpsT0tO1LKuBJDRiQfw2/tqbXU7JX2YTgOxhSm4hKCwnpUCeV8juZBBFk1cFt8zWmNQYqhVdOWlPGN6BAP/rlxcyr+e0jE
X-Gm-Message-State: AOJu0YxCHAPkh4LvllIBscZGF9Arl7OsyWNgWg980a8Fzut/AyVZYhuu
	h5yQvXaYaq2wd8cy5d41peKVjYqpEbVGod8dYp6OEy7enpSpR6obHINb58VIcUmX7frp9LfRgri
	a85GugiskdqSLca75NTQVk2ZQGr4=
X-Google-Smtp-Source: AGHT+IHFqmXqlBSd2ZbMViKWG+Z1LzyEnCtR30sIJcynrZM9shhHsPMu9mH9re6Zh+Mf/CW35nLpVb9a2Oyge73CAY8=
X-Received: by 2002:a2e:b1c9:0:b0:2d4:42da:40fe with SMTP id
 e9-20020a2eb1c9000000b002d442da40femr9203882lja.17.1712123462056; Tue, 02 Apr
 2024 22:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com> <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com>
In-Reply-To: <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 3 Apr 2024 13:50:50 +0800
Message-ID: <CAGWkznF6NQrB-vwBZCfCF-1WQJv8iwPPrwND7yDsPJw1EbfxQA@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in read_pages
To: David Hildenbrand <david@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:58=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.04.24 10:17, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> > unproperly during the procedure of read_pages()->readahead_folio->folio=
_put.
> > This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
> > ->readpages doesn't process all pages")'.
> >
> > key steps of[1] in brief:
> > 2'. Thread_truncate get folio to its local fbatch by find_get_entry in =
step 2
> > 7'. Last refcnt remained which is not as expect as from alloc_pages
> >      but from thread_truncate's local fbatch in step 7
> > 8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
> >      the value but meaning) in step 8
> > 9'. Thread_truncate hit the VM_BUG_ON in step 9
> >
> > [1]
> > Thread_readahead:
> > 0. folio =3D filemap_alloc_folio(gfp_mask, 0);
> >         (refcount 1: alloc_pages)
> > 1. ret =3D filemap_add_folio(mapping, folio, index + i, gfp_mask);
> >         (refcount 2: alloc_pages, page_cache)
> >
> > Thread_truncate:
> > 2. folio =3D find_get_entries(&fbatch_truncate);
> >         (refcount 3: alloc_pages, page_cache, fbatch_truncate))
> >
> > Thread_readahead:
> > 3. Then we call read_pages()
> >         First we call ->readahead() which for some reason stops early.
> > 4. Then we call readahead_folio() which calls folio_put()
> >         (refcount 2: page_cache, fbatch_truncate)
> > 5. Then we call folio_get()
> >         (refcount 3: page_cache, fbatch_truncate, read_pages_temp)
> > 6. Then we call filemap_remove_folio()
> >         (refcount 2: fbatch_truncate, read_pages_temp)
> > 7. Then we call folio_unlock() and folio_put()
> >         (refcount 1: fbatch_truncate)
> >
> > Thread_reclaim:
> > 8. collect the page from LRU and call shrink_inactive_list->isolate_lru=
_folios
> >          shrink_inactive_list
> >          {
> >              isolate_lru_folios
> >              {
> >                 if (!folio_test_lru(folio)) //false
> >                     bail out;
> >                 if (!folio_try_get(folio)) //false
> >                     bail out;
> >              }
> >           }
> >           (refcount 2: fbatch_truncate, reclaim_isolate)
> >
> > 9. call shrink_folio_list->__remove_mapping
> >          shrink_folio_list()
> >          {
> >              folio_try_lock(folio);
> >              __remove_mapping()
> >              {
> >                  if (!folio_ref_freeze(2)) //false
> >                      bail out;
> >              }
> >              folio_unlock(folio)
> >              list_add(folio, free_folios);
> >          }
> >          (folio has refcount 0)
> >
> > Thread_truncate:
> > 10. Thread_truncate will hit the refcnt VM_BUG_ON(refcnt =3D=3D 0) in
> > release_pages->folio_put_testzero
> >          truncate_inode_pages_range
> >          {
> >              folio =3D find_get_entries(&fbatch_truncate);
> >              truncate_inode_pages(&fbatch_truncate);
> >              folio_fbatch_release(&fbatch_truncate);
> >              {
> >                  folio_put_testzero(folio); //VM_BUG_ON here
> >              }
> >          }
> >
> > fix: commit 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't=
 process all pages")'
>
> Something that would help here is an actual reproducer that triggersthis
> issue.
>
> To me, it's unclear at this point if we are talking about an actual
> issue or a theoretical issue?
Thanks for feedback. Above callstack is a theoretical issue so far
which is arised from an ongoing analysis of a practical livelock issue
generated by folio_try_get_rcu which is related to abnormal folio
refcnt state. So do you think this callstack makes sense?

>
> --
> Cheers,
>
> David / dhildenb
>

