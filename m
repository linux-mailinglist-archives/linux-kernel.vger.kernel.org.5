Return-Path: <linux-kernel+bounces-17904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70968254DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984B01F23768
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725272D7B6;
	Fri,  5 Jan 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BL5qT+WD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AB2D78C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1768137e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704463817; x=1705068617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dfmz42MdXvMCi7ectWieUKdzDvevksoN5fHYgqMM0k=;
        b=BL5qT+WDVTfMlv3mFZns9OFM6FOLJuF8kIcifbqnKpEk36D8BW/lqz8181mQbDllkc
         Q2/Bu1tYBKDWdaj78k/nK8VIGaopY41ZZZ6kfGndCJFLLsecc4Ev2WUuVHm9qwtlmlK/
         fD4aAWHt5yM/O7iDK8IBnhxyjNmlKaN6CYIpkAk59ambMkwzRVw56I7qVyAQggk8ehQx
         Q7HsxZJ+DgSU2SdHU9Niz41F5gJOCnNZKsxyErpucGwXfpYrLSVf9esMLEHpoYidS1v3
         HzFDMyo26JxpDOZdGGmDk3xIUacoPlrC0iZUU6ls3GsuTOumw4O77A7hxn0ZFsmo++jX
         ZqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704463817; x=1705068617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dfmz42MdXvMCi7ectWieUKdzDvevksoN5fHYgqMM0k=;
        b=PQIFMtCa7zOnG88EPr3D9HGgT4ENs5qvyyRxDaeshDoM0trq6dSPFYCMYb18rQE4IX
         cPAGu95Vu9iwyTxhIZwp9KtgyJ8noR3MEcNCnFdsiTw1qdj5Mv7hMCECB/t/9r1KVF/P
         iKnxZtmt96N40J0GUMWBCfAXon8F2MPzNBDwIAtB6GfVNzKVTAeVjvtm7cvwwwwoNJpr
         +m6gAV2YPI0MMwZf0g2Iib/0fRm86H7AhCBSD/trBCtMIRPNamalU/+i/OmdoBgo0QNh
         TCSnfTn7X+dkzZPs8g3xDSnBqrbSsnRjOTiYK+uOtNzM/8pTozc3xG571lVVkTCCxsg5
         NupQ==
X-Gm-Message-State: AOJu0YwX4ikd0izH5+uhLBvDundp2awMn61GuwoMjcHH47fyAVzfHUSV
	SrhLt1NFcD5H+N7eV4gz0hsBP1y7L0Xqt17FCnkwbER9AKtBbg==
X-Google-Smtp-Source: AGHT+IFnymXKLPL9NqlZMDlVvqkcLHoX1m1Jq3xz0o1WWGb7AE9j+EWaQNVEHYc4jqZ5eI9x4ye0XqJhmm97eSoGhw0=
X-Received: by 2002:a05:6512:48cd:b0:50e:3774:9db6 with SMTP id
 er13-20020a05651248cd00b0050e37749db6mr518256lfb.196.1704463817498; Fri, 05
 Jan 2024 06:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com> <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 5 Jan 2024 22:10:06 +0800
Message-ID: <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hmm originally I was thinking of doing an (unconditional)
> lru_add_drain() outside of zswap_writeback_entry() - once in
> shrink_worker() and/or zswap_shrinker_scan(), before we write back any
> of the entries. Not sure if it would work/help here tho - haven't
> tested that idea yet.
>

The pages are allocated by __read_swap_cache_async() in
 zswap_writeback_entry() and it must be newly allocated=EF=BC=8C
not cached in swap.
Please see the code below in zswap_writeback_entry()

page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
                NO_INTERLEAVE_INDEX, &page_was_allocated);
    if (!page) {
        goto fail;}
    /* Found an existing page, we raced with load/swapin */
    if (!page_was_allocated) {
        put_page(page);
        ret =3D -EEXIST;
        goto fail;
    }

So when it comes to SetPageReclaim(page),
The page has just been allocated and is still in the percpu batch,
which has not been added to the LRU.

Therefore=EF=BC=8Clru_add_drain() did not work outside the
zswap_writeback_entry(=EF=BC=89

> >
> > New test:
> > This patch will add the execution of folio_rotate_reclaimable(not execu=
ted
> > without this patch) and lru_add_drain,including percpu lock competition=
.
> > I bind a new task to allocate memory and use the same batch lock to com=
pete
> > with the target process, on the same CPU.
> > context:
> > 1:stress --vm 1 --vm-bytes 1g    (bind to cpu0)
> > 2:stress --vm 1 --vm-bytes 5g --vm-hang 0=EF=BC=88bind to cpu0=EF=BC=89
> > 3:reclaim pages, and writeback 5G zswap_entry in cpu0 and node 0.
> >
> > Average time of five tests
> >
> > Base      patch            patch + compete
> > 4.947      5.0676          5.1336
> >                 +2.4%          +3.7%
> > compete means: a new stress run in cpu0 to compete with the writeback p=
rocess.
> > PID USER        %CPU  %MEM     TIME+ COMMAND                         P
> >  1367 root         49.5      0.0       1:09.17 bash     =EF=BC=88writeb=
ack=EF=BC=89            0
> >  1737 root         49.5      2.2       0:27.46 stress      (use percpu
> > lock)    0
> >
> > around 2.4% increase in real time,including the execution of
> > folio_rotate_reclaimable(not executed without this patch) and lru_add_d=
rain,but
> > no lock contentions.
>
> Hmm looks like the regression is still there, no?

Yes, it cannot be eliminated.

>
> >
> > around 1.3% additional  increase in real time with lock contentions on =
the same
> > cpu.
> >
> > There is another option here, which is not to move the page to the
> > tail of the inactive
> > list after end_writeback and delete the following code in
> > zswap_writeback_entry(),
> > which did not work properly. But the pages will not be released first.
> >
> > /* move it to the tail of the inactive list after end_writeback */
> > SetPageReclaim(page);
>
> Or only SetPageReclaim on pages on LRU?

No, all the pages are newly allocted and not on LRU.

This patch should add lru_add_drain() directly, remove the
if statement.
The purpose of writing back data is to release the page,
so I think it is necessary to fix it.

Thanks for your time, Nhat.

