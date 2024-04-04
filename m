Return-Path: <linux-kernel+bounces-131159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F238983DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E841F221AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206427442A;
	Thu,  4 Apr 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbFgGQgh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7F5E07E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222153; cv=none; b=GQteFUSkft2acTsgiTyFxRRa9xlex0/FDA8gLrwd6n7UnowyYbGgqcHDFDjPpTtiAPqMeImn3Oqa1JfsVWWlw1ObzQhU14V6BfohSv8GLLRNEgKJqWRF07lchESbIgL4lYcGkZgoEetmxZ9JTA99PkSGxuSblnfA2uRTipo6y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222153; c=relaxed/simple;
	bh=iYeuE1M8+1AoJzcT/saQB4j4EUFDY6aBgr+HmHWXSBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXi+35xwEn7ZZ0rehe0PQG8ACjv0DXPDyVkxr9RhKPNZKs0z3iIBPx7Ofjxu13aBL7gIVT5Ttd+h5ueo64MUvM9Z7Hdf4F04Kr3eWlDvXLk2IB92RBwV/AvugBvsEkNY8rZ5Mt+8deL07t4eeomoIOnmH3z75LXsSY2fS7eERUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbFgGQgh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d04fc04bso254540e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712222149; x=1712826949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUdDZySjrF1wvq9oOqTRZ+b/TlHRXdjH4rV3Y1d7tV8=;
        b=HbFgGQghrAGSqGZAIpfVPiLOR0PSo7D0wkp0xptD+rK1x93h8ecRV1NH8jpwp1MxbB
         B3fL2rbR+lCFkOKakJFTSBODevE+s0Pky9FuAE3EpB1jGpzaTAuUC6U0A3ifnkjiZLNO
         rPJ9QnxaRFjbhdlz0hAUwfxc+RoNiWHJUUU56YDc6uPH8zi46XbLP0lGfJUlzaBRl2Ya
         vfC2+lvhtVwgmMTXlg3u7fMKGiXwwLqltd0Dgi0/+o9j+Ib7GK033Kds5RZUKUS4Gugz
         /gfUz4ycHreBbk6Y13AxP/UFZaPe5Xec8YsJjggJzFwbrmDTQO4bLyvgRnUNqDkONSy2
         4NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712222149; x=1712826949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUdDZySjrF1wvq9oOqTRZ+b/TlHRXdjH4rV3Y1d7tV8=;
        b=GPedFFBqY3MFhlJI3RfsgZa+Z6EMxpTtwShgaaoSWUCUUL7XSedKX0JEbxsZKpedST
         4QrLY/IQXrluk7FulnKuV/UE4HxKIfaTPf6HRlblh4M/nWwtKba6EqFbm1SqAMW8yoBZ
         9IPs3kf3UFDV+hc+1WVKGH8q5fyHsfQlkaU/BNSWGFgvJRmn+FDlHSzO9l6jy4BVoi0O
         0EzkzwdOh7YwNlOlN+/MNF1BdKRjGjCIg6ZaiKu/6ICfx1bpjDnCBvLk8lLcxeBCf+Q2
         Ldda9vSg/evXACYRkvJHwag609qTmgqPy0rch3+kWju9+dPyKbUxVMdwkKJoNYWPADSm
         +huQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCJ/8cjs8GrXsIyCEw6oRg3piXiHaz6/AytqshpgbnUSSoLsph/fUJHP/3nf220E4AH5NOZ395CEf9/r+Gsw7AQSl+sVa2r+XVZJrH
X-Gm-Message-State: AOJu0YwdDyVz/BJcQOSsEMfz9ecT+35C4qC5KTNtdrAaO3slj39lXN2g
	GP4VBoZ+U8FMDk62dulfNS4dvlrS+fh2tDpOAWqNmLaeqZIxJH5CIGW7gvjLVBdLH2Th/EZb4Kz
	84JamUoP9E9hHUB/aKgTb74XSHec=
X-Google-Smtp-Source: AGHT+IEElv649+FFP6kt5/YPlcCr8Xo7UyNH6A7fZ4VarBPQSVgWE20nIGmRs7d52Zocup2PPcz3hVe83Tm59A/z/Io=
X-Received: by 2002:ac2:58f7:0:b0:512:e02f:9fa7 with SMTP id
 v23-20020ac258f7000000b00512e02f9fa7mr1606524lfo.1.1712222148288; Thu, 04 Apr
 2024 02:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
 <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com> <CAGWkznF6NQrB-vwBZCfCF-1WQJv8iwPPrwND7yDsPJw1EbfxQA@mail.gmail.com>
 <2f8af9d1-8c8e-4e1c-a794-76f6bb287b08@redhat.com> <CAGWkznEcS7rNWMudMBA7e-bjudX-sR4TGofyB5G1E=OmW_0Ckw@mail.gmail.com>
 <134b6c6d-5bcf-4394-85ad-2da2e8dec1d3@redhat.com>
In-Reply-To: <134b6c6d-5bcf-4394-85ad-2da2e8dec1d3@redhat.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 4 Apr 2024 17:15:37 +0800
Message-ID: <CAGWkznEOopuVCkzdOj+HqH4ZGx0_8kHn+j8ZOhbhuoGV9pTQWg@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in read_pages
To: David Hildenbrand <david@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:47=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.04.24 13:08, Zhaoyang Huang wrote:
> > On Wed, Apr 3, 2024 at 4:01=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 03.04.24 07:50, Zhaoyang Huang wrote:
> >>> On Tue, Apr 2, 2024 at 8:58=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 01.04.24 10:17, zhaoyang.huang wrote:
> >>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>>>
> >>>>> An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> >>>>> unproperly during the procedure of read_pages()->readahead_folio->f=
olio_put.
> >>>>> This is introduced by commit 9fd472af84ab ("mm: improve cleanup whe=
n
> >>>>> ->readpages doesn't process all pages")'.
> >>>>>
> >>>>> key steps of[1] in brief:
> >>>>> 2'. Thread_truncate get folio to its local fbatch by find_get_entry=
 in step 2
> >>>>> 7'. Last refcnt remained which is not as expect as from alloc_pages
> >>>>>        but from thread_truncate's local fbatch in step 7
> >>>>> 8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt=
(not
> >>>>>        the value but meaning) in step 8
> >>>>> 9'. Thread_truncate hit the VM_BUG_ON in step 9
> >>>>>
> >>>>> [1]
> >>>>> Thread_readahead:
> >>>>> 0. folio =3D filemap_alloc_folio(gfp_mask, 0);
> >>>>>           (refcount 1: alloc_pages)
> >>>>> 1. ret =3D filemap_add_folio(mapping, folio, index + i, gfp_mask);
> >>>>>           (refcount 2: alloc_pages, page_cache)
> >>
> >> [not going into all details, just a high-level remark]
> >>
> >> page_cache_ra_unbounded() does a filemap_invalidate_lock_shared(), whi=
ch
> >> is a down_read_trylock(&mapping->invalidate_lock).
> >>
> >> That is, all read_pages() calls in mm/readahead.c happen under
> >> mapping->invalidate_lock in read mode.
> >>
> >> ... and ...
> >>
> >>>>>
> >>>>> Thread_truncate:
> >>>>> 2. folio =3D find_get_entries(&fbatch_truncate);
> >>>>>           (refcount 3: alloc_pages, page_cache, fbatch_truncate))
> >>
> >> truncation, such as truncate_inode_pages() must be called under
> >> mapping->invalidate_lock held in write mode. So naive me would have
> >> thought that readahead and truncate cannot race in that way.
> >>
> >> [...]
> >>
> > Thanks for the reminder. But I don't find the spot where holding
> > "mapping->invalidate_lock" by check the callstack of
> > 'kill_bdev()->truncate_inode_pages()->truncate_inode_pages_range()',
> > or the lock is holded beyond this?
>
> Well, truncate_inode_pages() documents:
>
> "Called under (and serialised by) inode->i_rwsem and
> mapping->invalidate_lock."
>
> If that's not the case than that's either (a) a BUG or (b) an
> undocumented exception to the rule, whereby other mechanisms are in
> place to prevent any further pagecache magic.
>
> I mean, kill_bdev() documents " Kill _all_ buffers and pagecache , dirty
> or not..", so *something* has to be in place to guarantee that there
> cannot be something concurrently filling the pagecache again, otherwise
> kill_bdev() could not possibly do something reasonable.
>
> For example, blkdev_flush_mapping() is called when bd_openers goes to 0,
> and my best guess is that nobody should be able to make use of that
> device at that point.
>
> Similarly, changing the blocksize sounds like something that wouldn't be
> done at arbitrary points in time ...
>
> So kill_bdev() already has a "special" smell to it and I suspect (b)
> applies, where concurrent pagecache action is not really any concern.
>
> But I'm not an expert and I looked at most of that code right now for
> the first time ...
Thanks for your help. I don't know if it is related to an out of date
documentation issue. Regardless of truncation path, there could be an
isolation path for entering this race where the refcnt of local folio
batch replaced the one of alloc_pages and then makes the page out of
the protection by folio_lock and could race between reclaiming and
following actions of isolation. It could be any kind of phenomenon
other than VM_BUG_ON.
>
> >>
> >>>>
> >>>> Something that would help here is an actual reproducer that triggers=
this
> >>>> issue.
> >>>>
> >>>> To me, it's unclear at this point if we are talking about an actual
> >>>> issue or a theoretical issue?
> >>> Thanks for feedback. Above callstack is a theoretical issue so far
> >>> which is arised from an ongoing analysis of a practical livelock issu=
e
> >>> generated by folio_try_get_rcu which is related to abnormal folio
> >>> refcnt state. So do you think this callstack makes sense?
> >>
> >> I'm not an expert on that code, and only spent 5 min looking into the
> >> code. So my reasoning about invalidate_lock above might be completely =
wrong.
> >>
> >> It would be a very rare race that was not reported so far in practice.
> >> And it certainly wouldn't be the easiest one to explain, because the
> >> call chain above is a bit elaborate and does not explain which locks a=
re
> >> involved and how they fail to protect us from any such race.
> >>
> >> For this case in particular, I think we really need a real reproducer =
to
> >> convince people that the actual issue does exist and the fix actually
> >> resolves the issue.
> > Sorry, it is theoretically yet according to my understanding.
>
> Okay, if you find a reproducer, please share it and we can investigate
> if it's a locking problem or something else. As of now, I'm not
> convinced that there is an actual issue that needs fixing.
I am hoping anybody could help to confirm if this is indeed a BUG
according to the procedures in the commit message.
>
> --
> Cheers,
>
> David / dhildenb
>

