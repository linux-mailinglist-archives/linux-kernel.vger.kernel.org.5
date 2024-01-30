Return-Path: <linux-kernel+bounces-43662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B684175A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196B61C233C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A489442;
	Tue, 30 Jan 2024 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcjkQZow"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537214A92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573587; cv=none; b=dnLCZA+lmgqc5rHfOu9ayZi6avcbsIuV4fhQDp8nLOshCBiyhwR5te4LVq8McPkOa5b/ZtIO/7jkUfQsW3LbGIlrE7xWJV/FWMXFQk5KC1sJX0bYwE+pzwi2krPAE5zIab25JjyeoHQkxAmBZtnQ1Zwf4qlSxypIgPRCTAJRqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573587; c=relaxed/simple;
	bh=OXTzc+kkuw+ShG+eg9t0/SuZakj6DjerRaMHogUdVuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WntgpCf77TSaRSQvHKolJHALkZC2B4tt7zFB1SBLD+X84MHbzzD1qzAso8EmqLUBpT7aXmtxWAri1Mnv0/5CZcgMDoZSbxwY7XOQ2rJMtM74Sb6S2csNHyKlF/w3mZrlDfWM1Xmz7WF03H3CSUZuWmC/fRBCcVnJ6PcjNu+zJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcjkQZow; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36379bc5d93so4483735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706573585; x=1707178385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXTzc+kkuw+ShG+eg9t0/SuZakj6DjerRaMHogUdVuM=;
        b=CcjkQZoweurF8L48wc4oDNl1xZlj7p1bAA2lhNeqwS9f5GYCKM7sffmYsNf8q6niRe
         9I5dT2iJLODdSz1FUJ3JftVlHjDqaD3PEtA/HHLggrjmuQ1LH+TDn7TgDFINnFr/CGet
         Do86Nw05FMPE9WCvb4qPF+0fgOPeP7x92JP1cMAzbSd9RC7UqdDs1fSUddonD9ekaOq2
         fC0dSVeoeKAP7Jgb/uV00905KdX1e7n33Tt0AAoe+FCogQiNb4yAAIzd5mhkHKF5HmZS
         mvnD3sEBE0kKVgE7vt3adYchQE0Gj8GvrU4k3dMhEx6d9LBK/E15BLCLDUanP2rM0jeO
         OOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573585; x=1707178385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXTzc+kkuw+ShG+eg9t0/SuZakj6DjerRaMHogUdVuM=;
        b=Rh9z9SW490Tfh4IyshrGjAenD/9ESmHq90W4zdbuWYS9+l6MqnwkH74NCgSSaaMCA8
         iP5D5Rje4lz8BDB7N41ZYpRLXbwyRAmMOOhYYHsML9+oayZQ/+L2L+sGEWgLNR/0qLF8
         44l56Off5uobLVQrQlAj6alYPwLVpTQhVz8LUV56NERYdE3Bmbi8QDLz2skx4CU0eyQ/
         8HsMo2NXT9XF7X2DCaJCWGcgRw7YmM+razkON7pMEtdn4u/50/uDTSSHrzhPxp+hatza
         SCKvZaDgTJZoob8QOvJqlwfMQHu7249EbmLrgvFwnpuaTh8jTr4HNvIfDu4wv8beC3Xx
         t0CQ==
X-Gm-Message-State: AOJu0YwwXDHlQdqXzMOBuYOS+kCuc0buluUHIs0flAybqTLN8RQsBkxA
	qj416TxwcnSFqZW3YXS/+2Uld5mc296spyB7HOUwYrOceUsZmB1JfNr5+HM8T5QyOXo+k6a5px1
	87RCupug6+G5YLiZqv0YEBdhxUSs=
X-Google-Smtp-Source: AGHT+IHZG5sIOtcpxW7IIs3sEwNN+GPZLM6q0s30XelhuyQ5UDhu6LphYwezreNI8SOxPwOUbGv8yBq2Tu6BRoVh30g=
X-Received: by 2002:a92:7312:0:b0:363:7f6e:e868 with SMTP id
 o18-20020a927312000000b003637f6ee868mr3261356ilc.19.1706573585364; Mon, 29
 Jan 2024 16:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-1-b10479847099@bytedance.com> <Zbg-INqi9oMUqJaW@google.com>
In-Reply-To: <Zbg-INqi9oMUqJaW@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jan 2024 16:12:54 -0800
Message-ID: <CAKEwX=MxRTupSoYbnr14wTurbBhJ7KipV3YuEofab2JJxsk3cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Sun, Jan 28, 2024 at 01:28:49PM +0000, Chengming Zhou wrote:
> > LRU_SKIP can only be returned if we don't ever dropped lru lock, or
> > we need to return LRU_RETRY to restart from the head of lru list.
> >
> > Otherwise, the iteration might continue from a cursor position that
> > was freed while the locks were dropped.
>
> Does this warrant a stable backport?

IUC, the zswap shrinker was merged in 6.8, and we're still in the RC's
for 6.8, right? If this patch goes into 6.8 then no need?
Otherwise, yeah it should go to 6.8 stable IMHO.

>
> >
> > Actually we may need to introduce another LRU_STOP to really terminate
> > the ongoing shrinking scan process, when we encounter a warm page
> > already in the swap cache. The current list_lru implementation
> > doesn't have this function to early break from __list_lru_walk_one.
> >
> > Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure=
")
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

