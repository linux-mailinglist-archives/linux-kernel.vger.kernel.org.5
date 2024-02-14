Return-Path: <linux-kernel+bounces-64826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1B85434F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B57D28E111
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284611713;
	Wed, 14 Feb 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="imWFJPni"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9D11706
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894838; cv=none; b=CIG+iRe29TgxB1mzFl9KmXyBL3XelogX+q0lF9GSl0tiJwaiHPLdHj5M+ZuYP2im/4iYXKAfmRWR6B3E49t+8Ffte9BYgkoMfB87OPz7Mr9UgfiQ6Ju/q9xE/RSW/9SFxiZY8ID7AolE6YRePUzojeVeKHL2Hnvv+hvARKLzlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894838; c=relaxed/simple;
	bh=cG3ytfbapMF878eiJ7E0ok6bF7KZipG/SHOU0Ejqb2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVWxjONyaNHt1Cj4sIgUKlgZju7YAXeOYnjgtusHn0D15kyX3OwVcX5EgoTb7giyscZnAo8Q5Ws8t+IoL5EXw/ItbItvTC3HnVa2Qw5NxmhDAqb3ActEUGkwBB2wkrQ/E6sjRgK+60/f6Y249tSggxeAcvlnqNwu3eITPKeKzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imWFJPni; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410cf70a057so112615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707894835; x=1708499635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG3ytfbapMF878eiJ7E0ok6bF7KZipG/SHOU0Ejqb2I=;
        b=imWFJPni9j2NADRVsjZIVHlBo8/jwygsjMM/EVF6Oa5sfma8KaVbdOXEHi5XuSNGbq
         1idrCRRAxJVdwR/miLHYmFFWYBRTTMOmxmadi7isrd4KyLZn4UJ4pXlQtaVHqqz2sijM
         eiJqkyOU52Effoj+fmffMJgRkRz4Pf7GOwr9XhdfIla/EBcOwP766LvOm53DPGM4WVEa
         ab91d/VxJ486jnvPBG4t3nH0AyNw67/B5XttymRlQakt4ti9KD17mFZwNH8cDvht+0wI
         Xjwsp3P6Isad3xhI2uVP2wn9Yy0Jme35hs6DpMlv8RFUE/z4xHayTZ49KuHN/Jk5169A
         Bz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707894835; x=1708499635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG3ytfbapMF878eiJ7E0ok6bF7KZipG/SHOU0Ejqb2I=;
        b=VaqhSC2QnhyHONpxwEQtPxKMiWrTnmwkCVcduOaRbsLa6mUhGLv8fNpWvTY/bDYMgD
         k/p74uP6Ij7MvXBqjvjOTnvU9UfMDzDYgoSaDUG9ewyO2h086X5ZelM60xBkgwzussJF
         C9uvlXW39yAz0Gj3Sd2IwixKjSOQi9Yk0VyRkft7VjFibVjRnDjic/HJ3rDDytO5CRPo
         7RjXtBCJWPsmZ/w3JR+7AVGLc3r3AZFhIftfRA2WL8ZQCPUT6pMbK5n44WhHY/8P0mRb
         B6yIaHIxcvzkVmVu1ODtHZS4i2GMH/4Rrsk5Ih/9V48G9oKDhSxuoq2C4UopZqsypXvA
         ZFLw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rlrcwGinZf6W50u+dUXyWWUqq/4zC6o4PyEBNcLp+QvsSngWw7kCd4WduEZFzUTmm0VE1wswdHRi87sscW9iqo6VfFOsRCODNA8q
X-Gm-Message-State: AOJu0YyG25roN0QvV1wq11cURg5l2KhAz1L4JxavEHDxEHiMilhThIpc
	ZkwmxAZkzfwZzieLuDIZebfF5y06JFpE8Fq/Y5Jowpi9zSH2pc7gLzVpQDUNBEi4dnm54IAbyFs
	qV/eUlcFjBjjSPOYEWh6RqQu76KBtKUPfVARt
X-Google-Smtp-Source: AGHT+IHxJaLI9oI+8cMXdNNVvYXm3CLXITKxWceNDGyG2O0yz3xlROb2tedM7AtNEhiCKwfIWus9ESEj1Br/DhGXHLk=
X-Received: by 2002:a05:600c:a01a:b0:411:e72d:e5c9 with SMTP id
 jg26-20020a05600ca01a00b00411e72de5c9mr58714wmb.5.1707894834941; Tue, 13 Feb
 2024 23:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209115950.3885183-1-chengming.zhou@linux.dev> <20240209115950.3885183-2-chengming.zhou@linux.dev>
In-Reply-To: <20240209115950.3885183-2-chengming.zhou@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 14 Feb 2024 01:13:17 -0600
Message-ID: <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
To: chengming.zhou@linux.dev
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:00=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> All LRU move interfaces have a problem that it has no effect if the
> folio is isolated from LRU (in cpu batch or isolated by shrinker).
> Since it can't move/change folio LRU status when it's isolated, mostly
> just clear the folio flag and do nothing in this case.
>
> In our case, a written back and reclaimable folio won't be rotated to
> the tail of inactive list, since it's still in cpu lru_add batch. It
> may cause the delayed reclaim of this folio and evict other folios.
>
> This patch changes to queue the reclaimable folio to cpu rotate batch
> even when !folio_test_lru(), hoping it will likely be handled after
> the lru_add batch which will put folio on the LRU list first, so
> will be rotated to the tail successfully when handle rotate batch.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

I don't think the analysis is correct. IIRC, writeback from non
reclaim paths doesn't require isolation and the reclaim path doesn't
use struct folio_batch lru_add.

Did you see any performance improvements with this patch? In general,
this kind of patches should have performance numbers to show it really
helps (not just in theory).

My guess is that you are hitting this problem [1].

[1] https://lore.kernel.org/linux-mm/20221116013808.3995280-1-yuzhao@google=
com/

