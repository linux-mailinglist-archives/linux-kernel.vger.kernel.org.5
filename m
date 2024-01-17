Return-Path: <linux-kernel+bounces-28769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EB8302D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7181C21028
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FAA14276;
	Wed, 17 Jan 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HR0gGpc2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CD1426B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485183; cv=none; b=iH9ocuACDv896NGMHVIENcbhvT/WEnh1DME+7U1h4BSifUB7gBJ6OPN7DuEugTMr4l6A1rdxSAgmNWefbq/FcgpYmvHVFJtr/RE3t/3URmN/EdbG6s4+N7QfE52xwq/0rBv/p7tymxDbfNP+mywwMAKocJNdYOjL7LUaJRbFZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485183; c=relaxed/simple;
	bh=p6bd6mq8KFsjzFJ6wNa5CZdWzu0wPSbOf1Nsjitat3Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=X+DInG3D2YsszTc/dyhnLAsu5/667JV1BLMfodot98kvyYRb4esBJN9BPqL+7kywCOkErV0gFCSkODdEOxI9VEroNlbQAtdNZWj8GT4iRS9sluiRgMJKmbnRHGKCI+hnQ64LRZXN0GUv+GZLd+NwbAkM649NKQZvILYU4cz4tHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HR0gGpc2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so12809945e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705485179; x=1706089979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N7eo+PKWQbtdhFE2Ma1k5gF85XRa6NcuJZbycWLyxQ=;
        b=HR0gGpc2pNpx6TPlvs0c+yQQuClzdsMtFQwJJmsxBBjvnYRYrSLPA85sA1hKtHxrqn
         xaXjzX7jkyaaI69gpxQVa7p3E3K2YrdRBJhhqpIvXGr7lYQ/qdDYQCzywxd2Lb5/ctXW
         OJSnkKp55Zmb4HNxwXpG1ocls1B2KVLTtD1aSqAcbtwgfXuA6bwaPt8BAOI+VedONtHg
         BZi4kcGHkWIHWIzPxS6dJkGB7sdXkiO+RRHS0dVOcBd1ewwcG2OjLgE6q23udvGjDvn9
         CU+nL8ADgebWbKzscx+V7m3H0+xwdcl3u6RIHMV2MAQECV9HFJaSJblc9ibRnb1ZTZQq
         bIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485179; x=1706089979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N7eo+PKWQbtdhFE2Ma1k5gF85XRa6NcuJZbycWLyxQ=;
        b=d5r4gfY6yeumX5vLOkukAresmhPB9IAAowpBQ7wzAY7Ndg5QcQxjsx3IwqQHKMMh+U
         wn11ARc1TrzF233SZe+eqikU18lgse7YYID5aJW9r9wMT/Wb0Ow7EbrW2RKTQiyXuYkh
         7+akMs4tWoqd4hfslI0pJNVWQAVhf3lZIRNBv7Y1oc2oYnnk43GuSgFeQ/sahMpK8cz2
         Q8XNoWIUBs7eebNXA9zxrtRJrUNB8+L+OS+2iBdY9vgCy9J6WTPrCzGLHYU+jdxztCBG
         z5tscVRPCK2HT2ochvB+/sxs80OzSEX3Kos9WQ6Smm+I0HFYBhWhuLk45HfmiylbK7LV
         xLEg==
X-Gm-Message-State: AOJu0YwZLGIseSU6BFIrWhV3+2NA1FxFUuuHZ+iCe3/u36814ZE24xsY
	iIdIhOk3sS5XykBMrCBgPz/bNM5x7FZKiXzcPBfpJeOTz9nu3A==
X-Google-Smtp-Source: AGHT+IGESudi8nDr/fKi6Timoneh+VJkUoh2CnGT6W9oVuH4EaQ5EuM6Bk113egIwSq/TB/qWmrYHI1LyLmQXz5HFVw=
X-Received: by 2002:a05:6512:2007:b0:50e:dc99:b9d4 with SMTP id
 a7-20020a056512200700b0050edc99b9d4mr3538603lfb.44.1705485178988; Wed, 17 Jan
 2024 01:52:58 -0800 (PST)
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
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
 <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com> <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com>
In-Reply-To: <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 17 Jan 2024 17:52:47 +0800
Message-ID: <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > Please forgive me for adding additional information about this patch.
> >
> > I have finished the opt for introducing a folio_add_lru_tail(), but
> > there are many
> > questions:
> > 1) A new page can be move to LRU only by lru_add_fn, so
> >     folio_add_lru_tail could not add pages to LRU for the following cod=
e
> >     in folio_batch_move_lru(),which is added by Alex Shi for
> >     serializing memcg changes in pagevec_lru_move_fn[1].
> >
> > /* block memcg migration while the folio moves between lru */
> >         if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio))
> >             continue;
> > To achieve the goal, we need to add a new function like  lru_add_fn
> > which does not have the lru flag and folio_add_lru_tail()
> > +               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_move_ta=
il_fn_new &&
> > +                       !folio_test_clear_lru(folio))
> >
> > 2)  __read_swap_cache_async has six parameters, so there is no space to
> > add a new one, add_to_lru_head.
> >
> > So it seems a bit hacky just for a special case for the reasons above.
>
> It's a lot of plumbing for sure. Adding a flag to current task_struct
> is a less-noisy yet-still-hacky solution. I am not saying we should do
> it, but it's an option. I am not sure how much task flags we have to
> spare.

Got it.
>
> >
> > Back to the beginning,  lru_add_drain() is the simplest option=EF=BC=8C=
which is common
> > below the __read_swap_cache_async(). Please see the function
> > swap_cluster_readahead()
> > and swap_vma_readahead(), of course it has been batched.
> >
> > Or we should  leave this problem alone=EF=BC=8Cbefore we can write back=
 zswap
> > in batches.
>
> Calling lru_add_drain() for every written back page is an overkill
> imo. If we have writeback batching at some point, it may make more
> sense then.

Agree.

>
> Adding Michal Hocko was recently complaining [1] about lru_add_drain()
> being called unnecessarily elsewhere.

Got it, thanks.
>
> [1]https://lore.kernel.org/linux-mm/ZaD9BNtXZfY2UtVI@tiehlicka/

