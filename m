Return-Path: <linux-kernel+bounces-112644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9C887C7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D771F214D3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8F175B6;
	Sun, 24 Mar 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWbl8Ws+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FE7F9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711278882; cv=none; b=MwDlHcj4aFj8ex7ypDAkhBZB+OBn1mRG2lNsMDEGvZvWJKua0jC89AoWCPCBn1eOjvlyRQHzAYE0QgXVgtnUXXB8GTYOPtLRJ99CrzXcHCg/u+umTatiNq0oA/CyDJDA6Mq2vvKkiFecoxuAkUSzWWiF+3E7uw3V1gBIJFPag0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711278882; c=relaxed/simple;
	bh=FtVAlhKnqcPOVb6SUJ9Qjf3qnkSw96dP4Zgadi1dGlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h67Z5MLEKgOP+XlKiznyqP2uTmnPogJyzkqMpyD65tPH4VwV/8KVlZ/ZXDiHyeD/d+v94pHqypNnwjnrTiMY5efziqQMxRDZjNpSyf/Tt1D5snOftyXS3Gw0MOUPsQAXZnGRD9+Nbk4qlYs2CE3Fu5EDozjMgrbsMSfw+D3yv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWbl8Ws+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so15029111fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711278879; x=1711883679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHEBVbXcD510eWO4+9ZUum0yzIK8V8C0nA4QLZ0g0zo=;
        b=PWbl8Ws+YmTTOMYw+w9Lt8epJ0YmE5DYXNjTXDfrWfUwwrroFTmBO6LsME98+WReNJ
         fbJ6rkNu1ww4j4gxbtbLgAzL0bsL1tS8a4uJ6d64iEfUsbvBL5MZrDpv0FZmQwEzWD5q
         Ur19htObNmsBvISi0+CSCpZqus2w2Z5XPbpaQSKaQslvEtgveBFStSiq8fgLgjJYBdRL
         tzgdu4hNkBy74c67HLCc6pddQJNuuc5vFpeKxoygIpkDPbPRFRpQpUc8EPPjDcjh7bnf
         KiLDqGcF0Vr3uOOx2sSpODX+1jUcunJoRcU+KsSq4Ew4fWVofAoNzCfOA86ix7USkRNb
         1Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711278879; x=1711883679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHEBVbXcD510eWO4+9ZUum0yzIK8V8C0nA4QLZ0g0zo=;
        b=vjj0DXMgoj7t97zt5wio85JLnlTfxu5C3IfHWBgxkxz/gKlxRAsSpHLIm9owdYhZO/
         BZDk9qDIgsmh+Bzi3poCRHzb8HTL77RZNpZi0XyJnm8ZbMVHIUSA6/TTLNWbRy8CsR7t
         wylmPwyqWMIaiGDD/mX6qocLdeolKwX8jsvv2E939RfZ601TjdpTSIYVGucEZfp6m8sO
         5avhk5sC5skLZUuVua52uWHpyaNjy+df/pjc5N8vSza4Eg+6HRf8EAc6FOn5kFvWIeBT
         26xtGKMGdSMRzXaFkycjfmPZXHmFHoa673zeOPIuEJpa9IotczY8tWKaItt9IV3CCWIl
         1QUw==
X-Forwarded-Encrypted: i=1; AJvYcCWoZ51oBPWDEu0SGHb0kPjSPxG7ONB2lTwNsDtuhW9tSyrVX4G38FR8yT+TXa3aVbGLjKpcVy80dfnJoY9S9JsB40yEHa4s6HNAdvZ5
X-Gm-Message-State: AOJu0YzzXukdZc5Z0pHFlCCOile5F5jBauognJ2k2LuBbYNhHdE+rPxI
	VMTaAiaGtsZ0/wFXYeyptM8E35zAIq3mp/GoG6+M2hP2w1W5aEIPLnsI+7N+C/SIZJcwhS0qFXu
	HMi6ya1Ym2ZiSd55pz/2qpxMx/lY+cgJfT8M=
X-Google-Smtp-Source: AGHT+IEpW2Ne+HF4z/Vydz3PVV2sMuJoJNCsvmK3NhISrtgFfOeAUbzsUkhLBQk71K823G15cbGCwz2yPYgL6/BxA+Y=
X-Received: by 2002:a2e:740b:0:b0:2d4:42da:40fe with SMTP id
 p11-20020a2e740b000000b002d442da40femr2271774ljc.17.1711278878589; Sun, 24
 Mar 2024 04:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org> <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org> <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org> <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org>
In-Reply-To: <Zfz4_GJAHRInB8ul@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sun, 24 Mar 2024 19:14:27 +0800
Message-ID: <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:20=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 09:52:36AM +0800, Zhaoyang Huang wrote:
> > Thanks for the comments. fix the typo and update the timing sequence
> > by amending possible preempt points to have the refcnt make sense.
> >
> > 0. Thread_bad gets the folio by find_get_entry and preempted before
> > take refcnt(could be the second round scan of
> > truncate_inode_pages_range)
> >     refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true, PG_lock =3D=3D fal=
se
> >     find_get_entry
> >         folio =3D xas_find
> >         <preempted>
> >         folio_try_get_rcu
> >
> > 1. Thread_filemap get the folio via
> > filemap_map_pages->next_uptodate_folio->xas_next_entry and gets preempt=
ed
> >     refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true, PG_lock =3D=3D fal=
se
> >     filemap_map_pages
> >         next_uptodate_folio
> >            xas_next_entry
> >            <preempted>
> >            folio_try_get_rcu
> >
> > 2. Thread_truncate get the folio via
> > truncate_inode_pages_range->find_lock_entries
> >     refcnt =3D=3D 2(page_cache, fbatch_truncate), PG_lru =3D=3D true, P=
G_lock =3D=3D true
> >
> > 3. Thread_truncate proceed to truncate_cleanup_folio
> >     refcnt =3D=3D 2(page_cache, fbatch_truncate), PG_lru =3D=3D true, P=
G_lock =3D=3D true
> >
> > 4. Thread_truncate proceed to delete_from_page_cache_batch
> >     refcnt =3D=3D 1(fbatch_truncate), PG_lru =3D=3D true, PG_lock =3D=
=3D true
> >
> > 4.1 folio_unlock
> >     refcnt =3D=3D 1(fbatch_truncate), PG_lru =3D=3D true, PG_lock =3D=
=3D false
>
> OK, so by the time we get to folio_unlock(), the folio has been removed
> from the i_pages xarray.
>
> > 5. Thread_filemap schedule back from '1' and proceed to setup a pte
> > and have folio->_mapcnt =3D 0 & folio->refcnt +=3D 1
> >     refcnt =3D=3D 1->2(+fbatch_filemap)->3->2(pte, fbatch_truncate),
> > PG_lru =3D=3D true, PG_lock =3D=3D true->false
>
> This line succeeds (in next_uptodate_folio):
>                 if (!folio_try_get_rcu(folio))
>                         continue;
> but then this fails:
>
>                 if (unlikely(folio !=3D xas_reload(xas)))
>                         goto skip;
> skip:
>                 folio_put(folio);
>
> because xas_reload() will return NULL due to the folio being deleted
> in step 4.  So we never get to the point where we set up a PTE.
>
> There should be no way to create a new PTE for a folio which has been
> removed from the page cache.  Bugs happen, of course, but I don't see
> one yet.
>
> > 6. Thread_madv clear folio's PG_lru by
> > madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
> >     refcnt =3D=3D 2(pte,fbatch_truncate), PG_lru =3D=3D false, PG_lock =
=3D=3D false
> >
> > 7. Thread_truncate call folio_fbatch_release and failed in freeing
> > folio as refcnt not reach 0
> >     refcnt =3D=3D 1(pte), PG_lru =3D=3D false, PG_lock =3D=3D false
> > ********folio becomes an orphan here which is not on the page cache
> > but on the task's VM**********
> >
> > 8. Thread_bad scheduled back from '0' to be collected in fbatch_bad
> >     refcnt =3D=3D 2(pte, fbatch_bad), PG_lru =3D=3D false, PG_lock =3D=
=3D true
> >
> > 9. Thread_bad clear one refcnt wrongly when doing filemap_remove_folio
> > as it take this refcnt as the page cache one
> >     refcnt =3D=3D 1(fbatch_bad), PG_lru =3D=3D false, PG_lock =3D=3D tr=
ue->false
> >     truncate_inode_folio
> >         filemap_remove_folio
> >              filemap_free_folio
> > ******refcnt decreased wrongly here by being taken as the page cache on=
e ******
> >
> > 10. Thread_bad calls release_pages(fbatch_bad) and has the folio
> > introduce the bug.
> >     release_pages
> >         folio_put_testzero =3D=3D true
> >         folio_test_lru =3D=3D false
> >         list_add(folio->lru, pages_to_free)

ok. It seems like madvise is robust enough to leave no BUGs. I presume
another two scenarios which call folio_isloate_lru by any other ways
but PTE. Besides, scenario 2 reminds me of a previous bug reported by
me as find_get_entry entered in a livelock where the folio's refcnt =3D=3D
0 but remains at xarray which causes the reset->retry loops forever. I
would like to reply in that thread for more details.

Scenario 1:
0. Thread_bad gets the folio by find_get_entry and preempted before
folio_lock (could be the second round scan of
truncate_inode_pages_range)
    refcnt =3D=3D 2(page_cache, fbatch_bad), PG_lru =3D=3D true, PG_lock =
=3D=3D false
        folio =3D find_get_entry
        folio_try_get_rcu
        <preempted>
        folio_try_lock

1. Thread_truncate get the folio via
truncate_inode_pages_range->find_lock_entries
    refcnt =3D=3D 3(page_cache, fbatch_bad, fbatch_truncate), PG_lru =3D=3D
true, PG_lock =3D=3D true

2. Thread_truncate proceed to truncate_cleanup_folio
    refcnt =3D=3D 3(page_cache, fbatch_bad, fbatch_truncate), PG_lru =3D=3D
true, PG_lock =3D=3D true

3. Thread_truncate proceed to delete_from_page_cache_batch
    refcnt =3D=3D 2(fbatch_bad, fbatch_truncate), PG_lru =3D=3D true, PG_lo=
ck =3D=3D true

4  folio_unlock
    refcnt =3D=3D 2(fbatch_bad, fbatch_truncate), PG_lru =3D=3D true, PG_lo=
ck =3D=3D false

5. Thread_bad schedule back from step 0 and clear one refcnt wrongly
when doing truncate_inode_folio->filemap_remove_folio as it take this
refcnt as the page cache one
    refcnt =3D=3D 1'(fbatch_truncate), PG_lru =3D=3D false, PG_lock =3D=3D =
true
        folio =3D find_get_entry
        folio_try_get_rcu
        folio_try_lock
        truncate_inode_folio
            filemap_remove_folio
            <preempted>

6. Thread_isolate get one refcnt and call folio_isolate_lru(could be
any process)
    refcnt =3D=3D 2'(fbatch_truncate, thread_isolate), PG_lru =3D=3D true,
PG_lock =3D=3D true

7. Thread_isolate proceed to clear PG_lru and get preempted before folio_ge=
t
    refcnt =3D=3D 2'(fbatch_truncate, thread_isolate), PG_lru =3D=3D false,
PG_lock =3D=3D true
        folio_test_clear_folio
        <preempted>
        folio_get

8. Thread_bad scheduling back from step 5 and proceed to drop one refcnt
    refcnt =3D=3D 1'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D t=
rue
        folio =3D find_get_entry
        folio_try_get_rcu
        folio_try_lock
        truncate_inode_folio
            filemap_remove_folio
        folio_unlock
            <preempted>

9. Thread_truncate schedule back from step 3 and proceed to drop one
refcnt by release_pages and hit the BUG
    refcnt =3D=3D 0'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D f=
alse

Scenario 2:
0. Thread_bad gets the folio by find_get_entry and preempted before
folio_lock (could be the second round scan of
truncate_inode_pages_range)
    refcnt =3D=3D 2(page_cache, fbatch_bad), PG_lru =3D=3D true, PG_lock =
=3D=3D false
        folio =3D find_get_entry
        folio_try_get_rcu
        <preempted>
        folio_try_lock

1. Thread_readahead remove the folio from page cache and drop one
refcnt by filemap_remove_folio(get rid of the folios which failed to
launch IO during readahead)
    refcnt =3D=3D 1(fbatch_bad), PG_lru =3D=3D true, PG_lock =3D=3D true

2.  folio_unlock
    refcnt =3D=3D 1(fbatch_bad), PG_lru =3D=3D true, PG_lock =3D=3D false

3. Thread_isolate get one refcnt and call folio_isolate_lru(could be
any process)
    refcnt =3D=3D 2(fbatch_bad, thread_isolate), PG_lru =3D=3D true, PG_loc=
k =3D=3D false

4. Thread_bad schedule back from step 0 and clear one refcnt wrongly
when doing truncate_inode_folio->filemap_remove_folio as it take this
refcnt as the page cache one
    refcnt =3D=3D 1'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D f=
alse
        find_get_entries
            folio =3D find_get_entry
            folio_try_get_rcu
        folio_lock
        <no check as folio->mapping !=3D mapping as folio_lock_entries does=
>
        truncate_inode_folio
            filemap_remove_folio
            <preempted>

5. Thread_isolate proceed to clear PG_lru and get preempted before folio_ge=
t
    refcnt =3D=3D 1'(fbatch_truncate, thread_isolate), PG_lru =3D=3D false,
PG_lock =3D=3D false
        folio_test_clear_folio
        <preempted>
        folio_get

6. Thread_bad schedule back from step 4 and proceed to drop one refcnt
by release_pages and hit the BUG
    refcnt =3D=3D 0'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D f=
alse

