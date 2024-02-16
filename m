Return-Path: <linux-kernel+bounces-68239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D398577B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771791F215A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FB1804F;
	Fri, 16 Feb 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4LmP0dC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AC1798E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072215; cv=none; b=OTC1nSosQDKsQHf70qdBAQk40SBgt80S+sHM2HeoTtOFOyr/dLD+/Iy+eakV2UFnOjg+rnJtQxHPGWD2y0SfS3QkZLX5CNNjm+BBOZt1XShdVrADXqT7v2DiC4gz17T3Iv8aUfa5UAHZnw7ojanVrwhtnSO3jY+8lMPEY1ftGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072215; c=relaxed/simple;
	bh=GdhjGGCW1tp746L2kvnuzcO0JGGixFXgKt1BGfXddiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fC0ypB97hq8Gv0i/pAVbk1HbrHNJ4Z1+xGBsLnHkWcvmMJibnPWn7czg0XREOWeJNABABrv7wC4mnG+Y71uK9SJxR3YqPAk127ETJGV1dqScXS9rTq1O5w58AERi7+WRs1EQ/H0PTRQvcO9YOFQjCAp3LShTvr8qEEOVD9Ba/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4LmP0dC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso2967008276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708072212; x=1708677012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+T406awSm0PZWvamxb/O4glPc/yswynyie5XG4DmHE=;
        b=U4LmP0dCaq4iHak9mnXeylJInSYJBN1c9RyGjaGrqu3c6Q62tDgnXHeZNF5J2s/xdR
         K0y9/GD6Xy7avGjAki16V9natPYQErk6JaWgj4PP7q7KvkGkENFrAwEyoO+8tfbSw+fu
         5PSXqMO7xToNSnGozZFLLHaX2YbNRFY6sYhDKodTeV++1/VvuZKvMIuQRCCFS1/f22au
         nrXFTx7qfDe05HdZzNoYtzKINvQCvJtQUGyImdOf6VM5w8d/4W1y9+5pZ9rPQL2sXUe2
         nNI3S6rSBAPu5/24iYxBcXxd7yDj97T/sbJgYLV+ZXgJXYEmku0eLnJ3dWSwV3vjLUrx
         wOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708072212; x=1708677012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+T406awSm0PZWvamxb/O4glPc/yswynyie5XG4DmHE=;
        b=etzTHo6LBY5ao+thiWDAelKigi0BK4ZVxz2VjI1s0gSLRRxpddPDpZ3tjcnD5eVtmD
         p6u0jGzfBfE1TI6CRO+h9ZOKjQjzezktKIvKUyk8qWRowzm/EBu06kDJKKq+EOjLvoqs
         nB/IP9lmcovGejiVCzYVhXJrR01RJ/s99UDE8Ug//Ohel8MlJs5lJNBzqy/ZKit5unvD
         J3xQEhY+QeAl2dbCgFkKAwzqWI/cnbZ8W/zESqzGhwW0U4E6hqIJ80j5pW4DiddN0QW7
         KIvkSlMMxLRZT0pDhce1C/fMaQKviGeqzV3GALugjb7mTCKHeupCsNPj359iAXpySF8S
         dd2A==
X-Forwarded-Encrypted: i=1; AJvYcCWTlZAqsi2an7gKNKjFR981JOZoUuMsCd08VzjeKVbo57gtkDJDLQhAaVM1kKcVpUZnvMmtGpqBAwUqB/+9pE+m0RDvxG2Sb957MgC0
X-Gm-Message-State: AOJu0Yymy93CJ/m7axM2U+0itjb10EaQHiEbH1RdpIiVxzuyYcATueTB
	B7VTyTzxFPuyPwRHrVv34LG+u/N0N5rCuGVrPjZMDdORDCA0HvlIjJEDQjIuPD+X9m3TxszmWtS
	a6/xUQwwGeOKn2Qf5bA==
X-Google-Smtp-Source: AGHT+IF3trf13BJQXu17kJIafk/jn8S7KsSWkMDfarAi4KXYdoqAcTw5cjuzS+fWLBF6eBz3av4bvJ/YSiMvk+Xj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:728:b0:dcd:ac69:eb1a with SMTP
 id l8-20020a056902072800b00dcdac69eb1amr950084ybt.12.1708072212743; Fri, 16
 Feb 2024 00:30:12 -0800 (PST)
Date: Fri, 16 Feb 2024 08:30:10 +0000
In-Reply-To: <20240216040815.114202-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216040815.114202-1-21cnbao@gmail.com> <20240216040815.114202-3-21cnbao@gmail.com>
Message-ID: <Zc8dEn7eqFmC_Kcd@google.com>
Subject: Re: [PATCH v2 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 16, 2024 at 05:08:14PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Most compressors are actually CPU-based and won't sleep during
> compression and decompression. We should remove the redundant
> memcpy for them.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 350dd2fc8159..6319d2281020 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
>  	struct crypto_wait wait;
>  	u8 *buffer;
>  	struct mutex mutex;
> +	bool is_sleepable;
>  };
>  
>  /*
> @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  		goto acomp_fail;
>  	}
>  	acomp_ctx->acomp = acomp;
> +	acomp_ctx->is_sleepable = acomp_is_sleepable(acomp);

Just one question here. In patch 1, sleepable seems to mean "not async".
IIUC, even a synchronous algorithm may sleep (e.g. if there is a
cond_resched or waiting for a mutex). Does sleepable in acomp terms the
same as "atomic" in scheduling/preemption terms?

Also, was this tested with debug options to catch any possible sleeps in
atomic context?

If the answer to both questions is yes, the change otherwise LGTM. Feel
free to add:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

>  
>  	req = acomp_request_alloc(acomp_ctx->acomp);
>  	if (!req) {
> @@ -1368,7 +1370,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
>  	mutex_lock(&acomp_ctx->mutex);
>  
>  	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -	if (!zpool_can_sleep_mapped(zpool)) {
> +	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
>  		memcpy(acomp_ctx->buffer, src, entry->length);
>  		src = acomp_ctx->buffer;
>  		zpool_unmap_handle(zpool, entry->handle);
> @@ -1382,7 +1384,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
>  	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
>  	mutex_unlock(&acomp_ctx->mutex);
>  
> -	if (zpool_can_sleep_mapped(zpool))
> +	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
>  		zpool_unmap_handle(zpool, entry->handle);
>  }
>  
> -- 
> 2.34.1
> 

