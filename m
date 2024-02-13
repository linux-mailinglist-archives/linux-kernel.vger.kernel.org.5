Return-Path: <linux-kernel+bounces-63155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEA852BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E1D1C22E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC622334;
	Tue, 13 Feb 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFjFpPIN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F02231A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814205; cv=none; b=YCuOr9FNtXfPkial5VyFswztlpV9ql0bEE1VxKcTuNVSSOULTfG+NiXwBVH2nHyu/ouVR+dNt0FTKWySliZBcEVTfx9Q7saHLO9S703zAk1k81H+RYHcjrRqQI0fc+/oZNbmSBaRXPtsmHOrZ1OOTQ6U3ndgHMtVL6TgDRZom+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814205; c=relaxed/simple;
	bh=cv/6yNxD9P/N1UVc15lEgknGFCcdRwsHnuRhgeVobYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIIyEuUsV/aqXvHxUPYyNuJDEoOFXTMD1X3OWV7CyYb6M+yQN4/FZEeyFiYD9WU7GUPDQBsFts46nzuIBqpzLA+dSJ511hhy1+Oi+9zZtqqmJoGyLYL+zTxDApTXTTkF3E2qowB5GWaIWePkYXlluhtScJDVtP2O070Q08lf0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFjFpPIN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so549979366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707814202; x=1708419002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw3WRWteG7bO5ZRTaxT1u5RmbXXXiTe9cEj4SvWBzyM=;
        b=cFjFpPINLEwxMP19d3Cieooa4eDzlRvjLZ4YcWoqVrjfPlIpuQVKI8hsb1v1ShCctm
         qJoQfCxcWbl3ZOorAVR3aehnTdITxuL4lrHZkKiQiWdGZ5XYhmqZnUbI0O5NQK5M6+Ch
         Kb9HUtdYdr9a91TY4QNUuuqAb5nBzoUS9pAxk3bBLD/8RZGK0V+a36WnynSZTnoH9CUf
         5SbRh8fLJagGpUp98lDaAC8De7iTct0mBE3UGOngP1bzVKgRnP3rXc4RzwOntPvVrRba
         y0qrqK9JkfWrwPSR9ZnuK2f2TpyT6UOldw393u7TswjHOGq5m7QBwqYywKq48eVDPFFg
         9Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814202; x=1708419002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw3WRWteG7bO5ZRTaxT1u5RmbXXXiTe9cEj4SvWBzyM=;
        b=pKoJGWhdMB08yVDFGpeeVTD0d+oUQ+S5pXEwlLct8lfEZWcfRIaK+ndJLxYKg2mm/d
         /YGUelaHh7mZQu+WK3/fXuBRQcvJDP4cn5fXsT1dtDTUqAYyTUsrPJv9JgF//X9H7evo
         aJnBfK7dzP2s/wDUjfrD9JJ21L6e+vt1RIpn1+Fs+xQ5e+wUIj8ql0oCvdD6KfOC4NkE
         cVl+DH6x+l9+j04qt0OIPemsKGlR3BO5G++3Ifvs7zlZhaIq+AoP4R8aNXg5tXQ+DVW1
         UoEHeSq7W8KHEf5XZhymyHqr2/hdveh+9dy9KyaWAeejGb1JQFh4aTeIiHC/T0uim9W5
         1Oag==
X-Forwarded-Encrypted: i=1; AJvYcCXacxmcnMAgJbkmFi58SD0l7H6n9QyU4G/4ccqVqgxAVlp6CVLT4k+o8d914iEV2fRyxh6W/BxvXwGUQYJwG7tRBZq/GytLEhUaEB/m
X-Gm-Message-State: AOJu0Yw6ErkxsUe5yNA8WWjYI6qzujnvrPyDy6PJC5avEG5XtLGreSBN
	fhWajNa9IYMArMh5nDJ322lADa144GY0GZyzsMtNFNXZfQI009Y6CDCF7Qm9cvYoodOymSG1p3u
	ktdd+FadojguDA1OUcEz6jDCJXVeGWPIi64l6Pi+KvJwKPP4bPVbI3wI=
X-Google-Smtp-Source: AGHT+IEJd0Zo2Fp93vgoVzJ1ZLV7YlDlHTruHz2LWubzKfVYl8DnUuBxaDSyZhcRphlKdG8Afh15J15F5NkwIe4IYMo=
X-Received: by 2002:a17:906:c78d:b0:a31:7dc1:c7c1 with SMTP id
 cw13-20020a170906c78d00b00a317dc1c7c1mr5570387ejb.65.1707814202108; Tue, 13
 Feb 2024 00:50:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209115950.3885183-1-chengming.zhou@linux.dev> <20240209115950.3885183-2-chengming.zhou@linux.dev>
In-Reply-To: <20240209115950.3885183-2-chengming.zhou@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 13 Feb 2024 00:49:25 -0800
Message-ID: <CAJD7tkZcL6=dYCHv4XvQhRXgszcevGmsZfeg12jXpzLyy4YH1g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
To: chengming.zhou@linux.dev
Cc: willy@infradead.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:00=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
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

It seems to me that it is totally up to chance whether the lru_add
batch is handled first, especially that there may be problems if it
isn't.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index cd8f0150ba3a..d304731e47cf 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -236,7 +236,8 @@ static void folio_batch_add_and_move(struct folio_bat=
ch *fbatch,
>
>  static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>  {
> -       if (!folio_test_unevictable(folio)) {
> +       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> +           !folio_test_unevictable(folio) && !folio_test_active(folio)) =
{

What are these conditions based on? I assume we want to check if the
folio is locked because we no longer check that it is on the LRUs, so
we want to check that no one else is operating on it, but I am not
sure that's enough.

>                 lruvec_del_folio(lruvec, folio);
>                 folio_clear_active(folio);
>                 lruvec_add_folio_tail(lruvec, folio);
> @@ -254,7 +255,7 @@ static void lru_move_tail_fn(struct lruvec *lruvec, s=
truct folio *folio)
>  void folio_rotate_reclaimable(struct folio *folio)
>  {
>         if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +           !folio_test_unevictable(folio) && !folio_test_active(folio)) =
{

I am not sure it is safe to continue with a folio that is not on the
LRUs. It could be isolated for other purposes, and we end up adding it
to an LRU nonetheless. Also, folio_batch_move_lru() will do
folio_test_clear_lru() and skip such folios anyway. There may also be
messed up accounting, for example lru_move_tail_fn() calls
lruvec_del_folio(), which does some bookkeeping, at least for the
MGLRU case.

>                 struct folio_batch *fbatch;
>                 unsigned long flags;
>
> --
> 2.40.1
>

