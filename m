Return-Path: <linux-kernel+bounces-129641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F193896DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C180291081
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCDD1411ED;
	Wed,  3 Apr 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItrFbVAq"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F3135A5F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142506; cv=none; b=cb4nOOvVXMRIRWhMS2IKwgtbM4e6J2RKEyWKsmea0KtdwMCrgBg2plHqWs+igWA2cuav7eTILxlnG0nTVad5pyY27dTfWPtQfUxygA0t3jFdYo4A1StAa0aTZ3VrlfKeOHOuYntpZhpDfL/Ydxp7PsYgrv7h+Xf+wq+DhHkwDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142506; c=relaxed/simple;
	bh=A5TBEnJLJf3pZ31xGLJeUrjovRgvLKSKuzBlYTPH7Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLAE4kRlIxDeruXcYW2VnELTBdTAEi2k3FW4SkQHFtQ+gUV9w0DzlGaIwIabIAzfljxAHrVQ4ZT/1mleu7P+4+0pdidIrLv5kkVrHQmXp9t5ZG2pq2x1mtlp/+UmE1+aGSZgUzAmWDKKeGzrp/vQFb8hi6YQTQzEff+yFsAFdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItrFbVAq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d80baf621eso46403821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142503; x=1712747303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL5gIeJiry9Fye4cbZGujaQvZTKRVaB2Lu4bNfzx2YE=;
        b=ItrFbVAqv44Q4ug3TT4R1bmqhV4yXbtOxCr11rbXaFqKfCK75SA/s6Ze11PHsyZODC
         ICz1l8PPmUEgEf/m7le5kyprvAuwMUaIn0CbD9Xb+Hd18tOle0/4TAMs1eCm8/qWJ/At
         MQimmPMsUKqao1AVI/UfnLQRY0ttJBciTpqH1VK+Eep6CvkNXFUuQ33XdBOjVTvsQF8B
         0dSz64Q4U5oQ3wpqZFp39n34rCpHyIQvROFHkGWPq6wPHPemPH41ho7M+q3Tvwsi0/yd
         wYG/wQylbAJFbQOr0rj3wsjQsBKt4OhPfhn+ZP6WoquLL5WhIH/pitIKADV9NNmhj30j
         F5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142503; x=1712747303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL5gIeJiry9Fye4cbZGujaQvZTKRVaB2Lu4bNfzx2YE=;
        b=AXYVCvbHSyt+H2xXHLtGNdrfJDjZ0m2P4qXvKX+o7qcONVDPZB5Rhm+HNeVC8idEOf
         7jtZAc8YEq9zXZFxgUzO0L4y+UekH4ZKZkK7xtGTT7uimLkXFB0S0hUMsrG9MYAkSKmT
         0TY9pzrWRQXU9ozb+Z+FuQ94Lj3bTedID0S0aU2NNwnpXb9VtplEDi75zcYbYy+U01T0
         HugLsrLPoRaOO4WoZBVJG/oRqqSHgITc/UgPQfwwbXVMpYwxfaooDCVFICzJROIxLQ+k
         lDrHk+VWFo5u4N+jVgk75Bc83iw7M8jgUiUvEwbcuZDa/5fstFtye0umUlW0Uvp55Mxv
         W5lw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DQu3zRuaWLb3/We+sQIORka3a92mPUrfkMTTCLjs4WRal9CobtgCcW1zB2AFltBOoMGUi7qbG4oQ5+ttTR5Vcvipzypqzq/2Dt5O
X-Gm-Message-State: AOJu0Yz9UGgzFlW92rE/SGUA6LI0Ow8rAQCgjjbWjQK7GgHtz6Pl0H5W
	zxDTvsGMozt0RQAE//YCQZB9epxCz3aEHbqOBilYIHL763c+AxrRM6zuXPARF8pTAezCrtarFW0
	JR4UwVmhj/KoS3LiohgovEwYBaqU=
X-Google-Smtp-Source: AGHT+IFQg+XpKcV43T6VCKP5wBoOaw4ThLeEIZZX8Pt5q6aFV7RsjjX9mVH5Mj8s03u2Txo8LW0jNtCOHFhzoBftHOI=
X-Received: by 2002:a2e:2ac6:0:b0:2d6:cd05:1895 with SMTP id
 q189-20020a2e2ac6000000b002d6cd051895mr1598010ljq.29.1712142502390; Wed, 03
 Apr 2024 04:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
 <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com> <CAGWkznF6NQrB-vwBZCfCF-1WQJv8iwPPrwND7yDsPJw1EbfxQA@mail.gmail.com>
 <2f8af9d1-8c8e-4e1c-a794-76f6bb287b08@redhat.com>
In-Reply-To: <2f8af9d1-8c8e-4e1c-a794-76f6bb287b08@redhat.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 3 Apr 2024 19:08:11 +0800
Message-ID: <CAGWkznEcS7rNWMudMBA7e-bjudX-sR4TGofyB5G1E=OmW_0Ckw@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in read_pages
To: David Hildenbrand <david@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:01=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.04.24 07:50, Zhaoyang Huang wrote:
> > On Tue, Apr 2, 2024 at 8:58=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 01.04.24 10:17, zhaoyang.huang wrote:
> >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>
> >>> An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> >>> unproperly during the procedure of read_pages()->readahead_folio->fol=
io_put.
> >>> This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
> >>> ->readpages doesn't process all pages")'.
> >>>
> >>> key steps of[1] in brief:
> >>> 2'. Thread_truncate get folio to its local fbatch by find_get_entry i=
n step 2
> >>> 7'. Last refcnt remained which is not as expect as from alloc_pages
> >>>       but from thread_truncate's local fbatch in step 7
> >>> 8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt(n=
ot
> >>>       the value but meaning) in step 8
> >>> 9'. Thread_truncate hit the VM_BUG_ON in step 9
> >>>
> >>> [1]
> >>> Thread_readahead:
> >>> 0. folio =3D filemap_alloc_folio(gfp_mask, 0);
> >>>          (refcount 1: alloc_pages)
> >>> 1. ret =3D filemap_add_folio(mapping, folio, index + i, gfp_mask);
> >>>          (refcount 2: alloc_pages, page_cache)
>
> [not going into all details, just a high-level remark]
>
> page_cache_ra_unbounded() does a filemap_invalidate_lock_shared(), which
> is a down_read_trylock(&mapping->invalidate_lock).
>
> That is, all read_pages() calls in mm/readahead.c happen under
> mapping->invalidate_lock in read mode.
>
> ... and ...
>
> >>>
> >>> Thread_truncate:
> >>> 2. folio =3D find_get_entries(&fbatch_truncate);
> >>>          (refcount 3: alloc_pages, page_cache, fbatch_truncate))
>
> truncation, such as truncate_inode_pages() must be called under
> mapping->invalidate_lock held in write mode. So naive me would have
> thought that readahead and truncate cannot race in that way.
>
> [...]
>
Thanks for the reminder. But I don't find the spot where holding
"mapping->invalidate_lock" by check the callstack of
'kill_bdev()->truncate_inode_pages()->truncate_inode_pages_range()',
or the lock is holded beyond this?
>
> >>
> >> Something that would help here is an actual reproducer that triggersth=
is
> >> issue.
> >>
> >> To me, it's unclear at this point if we are talking about an actual
> >> issue or a theoretical issue?
> > Thanks for feedback. Above callstack is a theoretical issue so far
> > which is arised from an ongoing analysis of a practical livelock issue
> > generated by folio_try_get_rcu which is related to abnormal folio
> > refcnt state. So do you think this callstack makes sense?
>
> I'm not an expert on that code, and only spent 5 min looking into the
> code. So my reasoning about invalidate_lock above might be completely wro=
ng.
>
> It would be a very rare race that was not reported so far in practice.
> And it certainly wouldn't be the easiest one to explain, because the
> call chain above is a bit elaborate and does not explain which locks are
> involved and how they fail to protect us from any such race.
>
> For this case in particular, I think we really need a real reproducer to
> convince people that the actual issue does exist and the fix actually
> resolves the issue.
Sorry, it is theoretically yet according to my understanding.
>
> --
> Cheers,
>
> David / dhildenb
>

