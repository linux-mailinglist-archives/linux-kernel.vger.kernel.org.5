Return-Path: <linux-kernel+bounces-106871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289D87F4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CC21C21515
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793080B;
	Tue, 19 Mar 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F65JJFX5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A02363
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809337; cv=none; b=HbumV/zHBEzuwfNRXN1CiV2Vvtw6cjueYTEsI26I9w1eTU/ZOnR0Ks2FO44zS+k/pSsuY4PY4axn0WlL2aX2lSX9hhHkf6PBCGXYQ5/N/pFtCjeXRPOYQQI19Y0NuL5ar4LHKBCTf0XCiHzyLI7OT4Pr6b0dSRmsTxUnzMgYm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809337; c=relaxed/simple;
	bh=L3zeRLjOx6fQjN1L1rS2McI2JZtJlzjl1PZV34Mr7FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERtNdbYSTQOC+g0Yx6zD6MQ5sFG3haX+Ie/s/Os1epNy080qbTskG5nGpFLyKr+G85TUUZoZxfxiSgELf66sZDtm8A4JQQ1Zh28gYUWXKoB7eaVUvOzQzFN/Aw2Y6PPxocDxVlyuPIN9srXvWV/obqn/Q8TjPOts59t5uF0nQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F65JJFX5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so66719021fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710809334; x=1711414134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IceMzKVVx51fiz3kMqalJnKe2BKwCySQNoy0TLjTfjM=;
        b=F65JJFX5rsCnbDuyG3AP+84kYZLm6mMynY8si2LD7B+kDa6RundF8R7sw1Kp/VWt7J
         Y330H0RcXLuKV2lNu6p/VjF/2iv1R9vcYPbHkFGkeYNqphi6yDcfRlgSC60AgHyJ0ZF9
         3DE5XRHc7+QKq5Op2IwopJ+VJpPpgqUABhzct+mNcB5xaTY0VOUHJuwMkSJlm8LzKHXp
         Z5OLSo/VZArw8MAOkNvK1ids3G1lKPn+t8Q3YaVrorLBQcx9sYgD9xTqafAXYezXJes2
         oKsQy0H1tf/VL2EP+mmbRl3rE+hQib55Q4HNTEF/5STm8JVF8nEDPrk0rCk0BMqn6qRP
         yfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710809334; x=1711414134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IceMzKVVx51fiz3kMqalJnKe2BKwCySQNoy0TLjTfjM=;
        b=EruxFf4G3o7WqWeuQYmNOjM/FcNIVUX0JpvH8Rx6Huv8xivvtncf/3wD86DnmIlrZY
         aXExMR5hiDYypFjIeVdHgComi9fYlbQ6Fi1swmKgmoaCR/TiAPjW20S5RNRMVQsuEiSw
         8BjXrwLG7pnamKn5SAtFv2jQqDRhlu8/aarxON7jfAq3eWKu2OfuT03+m0egpbT6lVtt
         qWqyxMsk3moZFl4/vC7tqPCOlJv/u16nCy3Il7Ypo6hy4rz0QAum0R3Y+AYNZjWpq2oD
         puykv6TqWXEk/BzeT5/YKTgDsWSHx5bCcs3093hzR/T89pukMc/2zLqvuuR+XaXU3GcB
         vsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUvb65fAnoeOs1ZDOvoo9hnxkFLAbCCWhilC29Ilc5/try0mHLD3PoaQKVFQLKuj6ea2gHBFS7Ai3GjFd1j+ZGN/ASzr5gHY18IJXo
X-Gm-Message-State: AOJu0YxcZtsim1/evr+2G6hht2c6x4NS5X4NsH/B/m0q+LEjO/zkGH3U
	t8O7aA7sKOFWRxd/mVkxOY8ywpaveA+1eiTkcZ9319MsXafWyHslSb7Ozy3vtz4dBingCDTAiMu
	yvCiNVQZ0QONXQmpUO6k/IDnM9a4=
X-Google-Smtp-Source: AGHT+IHY3XOA5JsoqO/zlW0bn4OJnO4ehM+sShZ1IQv2CExU+6hlVGQX5rWxsKJNI40NN4+DlBUPLS0eJ1vWlVIfr8g=
X-Received: by 2002:a2e:865a:0:b0:2d2:3661:487a with SMTP id
 i26-20020a2e865a000000b002d23661487amr9587787ljj.9.1710809333440; Mon, 18 Mar
 2024 17:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com> <Zfg0WLrcOmCtdn_M@casper.infradead.org>
In-Reply-To: <Zfg0WLrcOmCtdn_M@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 19 Mar 2024 08:48:42 +0800
Message-ID: <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:32=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> Stop creating new threads.  You're really annoying.
>
> On Mon, Mar 18, 2024 at 09:32:32AM +0000, =E9=BB=84=E6=9C=9D=E9=98=B3 (Zh=
aoyang Huang) wrote:
> > Summarize all information below to make it more clear(remove thread2 wh=
ich is not mandatory and make the scenario complex)
>
> You've gone back to over-indenting.  STOP IT.
>
> > #thread 0(madivise_cold_and_pageout)        #thread1(truncate_inode_pag=
es_range)
>
> This is still an impossible race, and it's the third time I've told you
> this.  And madivise_cold_and_pageout does not exist, it's
> madvise_cold_or_pageout_pte_range().  I'm going to stop responding to
> your emails if you keep on uselessly repeating the same mistakes.
>
> So, once again,
>
> For madvise_cold_or_pageout_pte_range() to find a page, it must have
> a PTE pointing to the page.  That means there's a mapcount on the page.
> That means there's a refcount on the page.
>
> truncate_inode_pages_range() will indeed attempt to remove a page from
> the page cache.  BUT before it does that, it has to shoot down TLB
> entries that refer to the affected folios.  That happens like this:
>
>                 for (i =3D 0; i < folio_batch_count(&fbatch); i++)
>                         truncate_cleanup_folio(fbatch.folios[i]);
> truncate_cleanup_folio() -> unmap_mapping_folio ->
> unmap_mapping_range_tree() -> unmap_mapping_range_vma() ->
> zap_page_range_single() -> unmap_single_vma -> unmap_page_range ->
> zap_p4d_range -> zap_pud_range -> zap_pmd_range -> zap_pte_range ->
> pte_offset_map_lock()
Sorry and thanks for the remind. I wonder if it is possible that
madvise_cold_or_pageout_pte_range join these races until
truncate_inode_pages_range finish doing pte cleanup via
truncate_cleanup_folio which seems could still make the bellowing race
timing make sense. BTW, damon_pa_pageout is a potential risk over this
race

>
> > pte_offset_map_lock                                            takes NO=
 lock
> >                                                                        =
        truncate_inode_folio(refcnt =3D=3D 2)
> >                                                                        =
        <decrease the refcnt of page cache>
> > folio_isolate_lru(refcnt =3D=3D 1)
> >                                                                        =
        release_pages(refcnt =3D=3D 1)
> > folio_test_clear_lru
> > <remove folio's PG_lru>
> >                                                                        =
       folio_put_testzero =3D=3D true
> > folio_get(refer to isolation)
> >                                                                        =
       folio_test_lru =3D=3D false
> >                                                                        =
       <No lruvec_del_folio>
> >                                                                        =
       list_add(folio->lru, pages_to_free)
> >                                                                        =
       ****current folio will break LRU's integrity since it has not been d=
eleted****
> >
> > 0. Folio's refcnt decrease from 2 to 1 by filemap_remove_folio
> > 1. thread 0 calls folio_isolate_lru with refcnt =3D=3D 1. Folio comes f=
rom vm's pte
> > 2. thread 1 calls release_pages with refcnt =3D=3D 1. Folio comes from =
address_space
> > (refcnt =3D=3D 1 make sense for both of folio_isolate_lru and release_p=
ages)
> > 3. thread0 clear folio's PG_lru by folio_test_clear_lru
> > 4. thread1 decrease folio's refcnt from 1 to 0 and get permission to pr=
oceed
> > 5. thread1 failed in folio_test_lru and do no list_del(folio)
> > 6. thread1 add folio to pages_to_free wrongly which break the LRU's->li=
st
> > 7. next folio after current one within thread1 experiences list_del_inv=
alid when calling lruvec_del_folio

