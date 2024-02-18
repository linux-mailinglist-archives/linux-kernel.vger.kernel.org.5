Return-Path: <linux-kernel+bounces-70280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C20859587
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D6281EA7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7182EAFC;
	Sun, 18 Feb 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4BPMWpW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16F3229
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243749; cv=none; b=hpiRr2stDiPMDgAW83Bsre9XFe9bVUMo1LFcnGz2IlKgZi/BATrRQCrfHmGv94yRuLkrFqZIW38AjkZxx2NR882ROQjeSBUDI4Ub01sIsajhDpl8Db7gipQ0/mW0yDY2LxWcaS9ePvTWSNqUJt+IzkLIZXeajHmPihUJYUuPS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243749; c=relaxed/simple;
	bh=y3gpuJW5ASHEEMFJWDsVS1HsiHUK+89IvXhljtSmVYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF9zudk7qI4pcYGMrWKWNF0nfuA87aMSZl/7zfrI3ifA1FvTDSYWo3ABTOrG/JA+KbPDXg1ER3gywjibBUMKkqNy1DmdGHyTT7uZVnZXfl8vclLtqiQQJ5RA287GhsCK7Im3Ckg+nQQaLXs7Ozp/MK+oA+f2V6l4Ub0BiGdYsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4BPMWpW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410acf9e776so39735e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708243745; x=1708848545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfqijOxZRqV8G3+K8nq9Fq3ADRHflW4wUyZr5KDyQS4=;
        b=j4BPMWpW+bFHxjgLChddP7WtBN3bnNBaxpomiYipIyxYuSUTf5rQu/vgWjFvFUSTVc
         wSxBSW01wHHPegB5wAasc5hbPD4UgPFGrOylRr9SEBAaU9PuV2VvsqBbgh14mZZVorPl
         2uxj9TV6n/j+T2Xyxm0K0Z+YbcgH72ak4w4z5dxcj8OKlI0NmPXQX6Dr/o3FONuA0yMC
         c6rDbXfGx6+pppDSvAOiaGeRW90vZHMCwstmZCsjARSnTUvzpMl4LS2mFdkx4d+1pwCw
         /3Bw37b3mHabycZTKMFxGKtTQKpcs8ztFUYtQtpyvnYOQ1G2COsAeQRewS2i2M8PjZ4F
         XAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243745; x=1708848545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfqijOxZRqV8G3+K8nq9Fq3ADRHflW4wUyZr5KDyQS4=;
        b=kNNKHQ56DzVPgWxHEmGc8sZcZE+bVm+ePRmjUoywq7hmGTaWvXl6gQ4QFYquOA5AxC
         3ahj8VeSlpZg700qzQTF6bpHKjD+4Fpn8Xn1CHDa0DNi/+l0Gls/4PFe55Hgt284I8fU
         /7X3JP1Pg7OZ7z2j89lD8rkbwCLdnvEQW7i6XyATT7plGSML3Ex7evcduBh15YKF/mvN
         P9r9CdKmqX6/gofgDGnHFrCZfRTXNv0iqKC7IY7G74GEa5eAAvogUY7auOFBs6hGEib5
         5vusuE+VjOOPXt6yTrRJvIbF5YEq9etUY1miXHOfTekqulmwaJ+wPIlBQ97e7a0rMhMo
         nY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQksbWzdQgKBI2SZP9EioNx6rlx+VTxfT5SqB4dpwEEXfFbzmdzs+ATGIpJtp8Eh3LnWQAeI2Dqc7+9Nj6/bCl3fAyzkad1fUBAbJz
X-Gm-Message-State: AOJu0YwHoKl78B/+3bdbmtJlaVJQeysNrZLQayVPelk7j0jUhnoZkZFv
	an3gQwHlPkz0wQQVZbq++8DlC4ay0U+zmxukO15dy4CXhnjhYAcQuUfpzeRk7EuimAvZojwjf3Y
	ZZGXql4Xdx0HjPxFi/nOhMixCHZyuD+D39XJv
X-Google-Smtp-Source: AGHT+IEvcmX6w18+RZ4VvQtXTZFiX72nSc5+q6s3K5JVP0z008xlrObQ3vJyH+wszldvDNrIN7BDsh7Xu1LTB9IbjaI=
X-Received: by 2002:a05:600c:4e49:b0:412:6101:912e with SMTP id
 e9-20020a05600c4e4900b004126101912emr55157wmq.5.1708243745467; Sun, 18 Feb
 2024 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev> <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
 <8123c4be-d696-4e9e-884f-aa12f6099ddb@linux.dev> <CAOUHufbVNF_zDm93W2nj+V5G3FrAx7jdcaiO+gdabmG7L_6AOw@mail.gmail.com>
 <c6fbf221-06f1-43e6-9801-157b2548d31a@linux.dev>
In-Reply-To: <c6fbf221-06f1-43e6-9801-157b2548d31a@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 18 Feb 2024 03:08:27 -0500
Message-ID: <CAOUHufYa8QWXoR8VLG0_Nwks0kU5BSHoQCGWBsT=SxHJScEoYg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 9:52=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/2/15 15:06, Yu Zhao wrote:
> > On Wed, Feb 14, 2024 at 4:18=E2=80=AFAM Chengming Zhou <chengming.zhou@=
linux.dev> wrote:
> >>
> >> On 2024/2/14 15:13, Yu Zhao wrote:
> >>> On Fri, Feb 9, 2024 at 6:00=E2=80=AFAM <chengming.zhou@linux.dev> wro=
te:
> >>>>
> >>>> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>>>
> >>>> All LRU move interfaces have a problem that it has no effect if the
> >>>> folio is isolated from LRU (in cpu batch or isolated by shrinker).
> >>>> Since it can't move/change folio LRU status when it's isolated, most=
ly
> >>>> just clear the folio flag and do nothing in this case.
> >>>>
> >>>> In our case, a written back and reclaimable folio won't be rotated t=
o
> >>>> the tail of inactive list, since it's still in cpu lru_add batch. It
> >>>> may cause the delayed reclaim of this folio and evict other folios.
> >>>>
> >>>> This patch changes to queue the reclaimable folio to cpu rotate batc=
h
> >>>> even when !folio_test_lru(), hoping it will likely be handled after
> >>>> the lru_add batch which will put folio on the LRU list first, so
> >>>> will be rotated to the tail successfully when handle rotate batch.
> >>>>
> >>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >>>
> >>> I don't think the analysis is correct. IIRC, writeback from non
> >>> reclaim paths doesn't require isolation and the reclaim path doesn't
> >>> use struct folio_batch lru_add.
> >>
> >> Ah, my bad, I forgot to mention the important context in the message:
> >>
> >> This is not from the normal reclaim context, it's from zswap writeback
> >> reclaim context, which will first set PG_reclaim flag, then submit the
> >> async writeback io.
> >>
> >> If the writeback io complete fast enough, folio_rotate_reclaimable()
> >> will be called before that folio put on LRU list (it still in the loca=
l
> >> lru_add batch, so it's somewhat like isolated too)
> >>
> >>>
> >>> Did you see any performance improvements with this patch? In general,
> >>> this kind of patches should have performance numbers to show it reall=
y
> >>> helps (not just in theory).
> >>
> >> Right, there are some improvements, the numbers are put in cover lette=
r.
> >> But this solution is not good enough, just RFC for discussion. :)
> >>
> >>                            mm-unstable-hot   zswap-lru-reclaim
> >> real                       63.34             62.72
> >> user                       1063.20           1060.30
> >> sys                        272.04            256.14
> >> workingset_refault_anon    2103297.00        1788155.80
> >> workingset_refault_file    28638.20          39249.40
> >> workingset_activate_anon   746134.00         695435.40
> >> workingset_activate_file   4344.60           4255.80
> >> workingset_restore_anon    653163.80         605315.60
> >> workingset_restore_file    1079.00           883.00
> >> workingset_nodereclaim     0.00              0.00
> >> pgscan                     12971305.60       12730331.20
> >> pgscan_kswapd              0.00              0.00
> >> pgscan_direct              12971305.60       12730331.20
> >> pgscan_khugepaged          0.00              0.00
> >>
> >>>
> >>> My guess is that you are hitting this problem [1].
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20221116013808.3995280-1-yuzhao@=
google.com/
> >>
> >> Right, I just see it, it's the same problem. The only difference is th=
at
> >> in your case the folio is isolated by shrinker, in my case, the folio =
is
> >> in cpu lru_add batch. Anyway, the result is the same, that folio can't=
 be
> >> rotated successfully when writeback complete.
> >
> > In that case, a better solution would be to make lru_add add
> > (_reclaim() && !_dirty() && !_writeback()) folios at the tail.
> > (_rotate() needs to leave _reclaim() set if it fails to rotate.)
>
> Right, this is a solution. But PG_readahead is alias of PG_reclaim,
> I'm afraid this would rotate readahead folio to the inactive tail.

Then drain before setting readahead, since readahead isn't set on every fol=
io.

