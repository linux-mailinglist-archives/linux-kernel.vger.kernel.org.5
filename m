Return-Path: <linux-kernel+bounces-66347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB45855B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAE61F283C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6DDD518;
	Thu, 15 Feb 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrMIUfg5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0BA947E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980846; cv=none; b=CVlqR9IxAYdLye80lkTm8k6Y+9EHOOSQtaB/Jbw4FMJ4dWvOJyjxhEAAQOZBNTklclHyJ9WHePyIg1JAOvHmbEEbhIra23exMsPIW+QCiNP+OTPCNshxjQ5Y5iNJtgw3pGUCQcQH1ZuqoVeMBWb9bN80LJg7OTyB1QwbBd5QVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980846; c=relaxed/simple;
	bh=l4PLZm6Ml4E90WhlhQFbI5aXHf5cXcCSh206fgqAU0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLA9jgs+Bd7vVWx2FiXfle7p07kpDyOZ7ihjXSX+4Tdj1BNZRtSC5B+0W2OZMvGXSm1gVHV+ZbaAZamrtlgug6XNkE9LR8V20IdxQM+Bu1oDByCbmIe3fgZ01pryb7vSBDIgqb0OrxrcopNgk4/YQxlZpXeSuAqbmPzlp0Rm61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrMIUfg5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4120933b710so36555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707980843; x=1708585643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nddqiVq/3r6Pac3WeXAXpKp40eZ00zZsFZh1wnDRavA=;
        b=QrMIUfg55py1divoB0RlsHH4fnDX/7GuVM3EJHUAX68DRPZGKfsHimoTNUEIuY7kkH
         qFLQXrowJkI1QOdK4CLJMNhEuu7vGo20SDJJNdysz/az14iBN0/ecrLcrSE+x2LlhSaK
         ndQjZ53Fl4NTSgNJ5Q8czn/0gcyy68KzeKoWVvlXG4BjF3T0GncLprsiSsGd4V0rPj9Y
         7nzExaZalfrzau/EkJ77LZCfYPn7wja4KVTrZMb/J3FqfNbwOf8QPFCOVXRXdvqKEJRf
         HOEs6vZ1VzAJNcAELd5bHmdiM0VCQqJ/BF4HV+fliKia7yxekXg8D1+Kh2lFWXppIvhH
         MoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707980843; x=1708585643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nddqiVq/3r6Pac3WeXAXpKp40eZ00zZsFZh1wnDRavA=;
        b=BNkjK5ds6tHCe62nMhqF7HJzr3z2cWuJz/QnLoBabTcI9juFmeDHsKLf65G1jGT3bV
         nKuSZCB0gAgnN0JIQAnBKYT6VTGpb/wcOCUjVpAfqeM907ItbUP/GG4MiydnuJ/0GGgq
         vO3ljeEwrt/3Bzcvy9PEbLmaY3gBZCb9TTpSR2t9deY7HaVFBEF9j7r+OaA/cwoBAABE
         LnYZOzX4VpQ3azTg+JcYjSn8DA/nHmzoE4/VJS1N+G7vSxUZyJdT2Tgfay/K9hAgZsNd
         7wMvesDsHPTSMvX+tPyBZ/7F50NE7DKKOj4YWIxn38mrH1wB3rg9ml7NwCrGVW6Evs65
         9USw==
X-Forwarded-Encrypted: i=1; AJvYcCW+8iLlqmcMJB8TznJpxB88qVyTLrua0azcglATdsoPIY+RMozQNzphXbFFk08ETPb3pIzZ0jqRNeaTw7Ge9+DLSxyucuQC5cjBvOmS
X-Gm-Message-State: AOJu0Yxwtv/Fd3G5f4sUfX8IJPSuJEFKSXBxELi6puRZltBJet11BrmG
	FQQ+sIgAAxu8pbKHbKYCHEEvaIzckdhkuNNZQSNwxwEIpP4qZFAx8xeZVNJHHqdU1j6yuJ0cizM
	L+pcHI6PJ55YDaEK4JEcYfDnwftG3zkn2zyhi
X-Google-Smtp-Source: AGHT+IEZGK7rs/84Y0QnbGxrQrX9DEMxASQW0pm5voFFt9sqVtOtLAZsKqN9qO601ExmYB592dcSsKBKGPOQoW+IK6I=
X-Received: by 2002:a05:600c:4e12:b0:411:f6b6:faf5 with SMTP id
 b18-20020a05600c4e1200b00411f6b6faf5mr249572wmq.3.1707980843006; Wed, 14 Feb
 2024 23:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev> <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
 <8123c4be-d696-4e9e-884f-aa12f6099ddb@linux.dev>
In-Reply-To: <8123c4be-d696-4e9e-884f-aa12f6099ddb@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 15 Feb 2024 02:06:46 -0500
Message-ID: <CAOUHufbVNF_zDm93W2nj+V5G3FrAx7jdcaiO+gdabmG7L_6AOw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 4:18=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/2/14 15:13, Yu Zhao wrote:
> > On Fri, Feb 9, 2024 at 6:00=E2=80=AFAM <chengming.zhou@linux.dev> wrote=
:
> >>
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> All LRU move interfaces have a problem that it has no effect if the
> >> folio is isolated from LRU (in cpu batch or isolated by shrinker).
> >> Since it can't move/change folio LRU status when it's isolated, mostly
> >> just clear the folio flag and do nothing in this case.
> >>
> >> In our case, a written back and reclaimable folio won't be rotated to
> >> the tail of inactive list, since it's still in cpu lru_add batch. It
> >> may cause the delayed reclaim of this folio and evict other folios.
> >>
> >> This patch changes to queue the reclaimable folio to cpu rotate batch
> >> even when !folio_test_lru(), hoping it will likely be handled after
> >> the lru_add batch which will put folio on the LRU list first, so
> >> will be rotated to the tail successfully when handle rotate batch.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > I don't think the analysis is correct. IIRC, writeback from non
> > reclaim paths doesn't require isolation and the reclaim path doesn't
> > use struct folio_batch lru_add.
>
> Ah, my bad, I forgot to mention the important context in the message:
>
> This is not from the normal reclaim context, it's from zswap writeback
> reclaim context, which will first set PG_reclaim flag, then submit the
> async writeback io.
>
> If the writeback io complete fast enough, folio_rotate_reclaimable()
> will be called before that folio put on LRU list (it still in the local
> lru_add batch, so it's somewhat like isolated too)
>
> >
> > Did you see any performance improvements with this patch? In general,
> > this kind of patches should have performance numbers to show it really
> > helps (not just in theory).
>
> Right, there are some improvements, the numbers are put in cover letter.
> But this solution is not good enough, just RFC for discussion. :)
>
>                            mm-unstable-hot   zswap-lru-reclaim
> real                       63.34             62.72
> user                       1063.20           1060.30
> sys                        272.04            256.14
> workingset_refault_anon    2103297.00        1788155.80
> workingset_refault_file    28638.20          39249.40
> workingset_activate_anon   746134.00         695435.40
> workingset_activate_file   4344.60           4255.80
> workingset_restore_anon    653163.80         605315.60
> workingset_restore_file    1079.00           883.00
> workingset_nodereclaim     0.00              0.00
> pgscan                     12971305.60       12730331.20
> pgscan_kswapd              0.00              0.00
> pgscan_direct              12971305.60       12730331.20
> pgscan_khugepaged          0.00              0.00
>
> >
> > My guess is that you are hitting this problem [1].
> >
> > [1] https://lore.kernel.org/linux-mm/20221116013808.3995280-1-yuzhao@go=
ogle.com/
>
> Right, I just see it, it's the same problem. The only difference is that
> in your case the folio is isolated by shrinker, in my case, the folio is
> in cpu lru_add batch. Anyway, the result is the same, that folio can't be
> rotated successfully when writeback complete.

In that case, a better solution would be to make lru_add add
(_reclaim() && !_dirty() && !_writeback()) folios at the tail.
(_rotate() needs to leave _reclaim() set if it fails to rotate.)

