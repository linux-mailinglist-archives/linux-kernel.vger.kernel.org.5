Return-Path: <linux-kernel+bounces-44072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EE841CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CC7B24EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81B354667;
	Tue, 30 Jan 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EG3GYztW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD75381A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601119; cv=none; b=f//dAAbu+TKAacd6UXCwhin30RxxuzK19naJPaliL6PKkpeuuJeaV0glBHxsMpTDN2dNI0IZvryDgCExrKbMieT3MENehjaIGlxeUxUC1/Fqr4fR7TPpSIWUzbhrCW4i4r308xg46PfdiH0w/k0EjxSoxyrymG8e5H2OSpyjsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601119; c=relaxed/simple;
	bh=YLrgJ6yq1X+yEWK0QFuDAiVsv4iYPleIwkJ/IHuFqpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mswZMFdzU0J1MWd6RllsWWt+yi/6P42PP/+K+h8+bE6bSbDmTGawMjQEzUx2bN3kCjckTOQsjxzhUxlYfs22+t5fcInGHdQ7rjTa2FgopHD2D8zFAUD33V5JA11xn42E4fUtT7d0IeVqxo4tPuddRLz9ItFArGg4//OtcoR8cWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EG3GYztW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso5817912276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706601116; x=1707205916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aC2acMvCrsnsCSaOBPgEXr/tWbb4doa7fO8e2ncEHsI=;
        b=EG3GYztW2zsSFEsGGn8fiXtj4TlBMhBYx7qg3Jj3iLP+4tJg4Tygztq5Rtwqx8X/dL
         Qajy4EC2RGLmDp6dmvzz48qIguxKLsyC2Tc6GQEPsz0IX7BU2AKRI0nGgTYZ0+9WOpSY
         ZnoJtestf0uK44MYRyRgClJeVLWXRxgupN63SI13C1WQFWbMbQfwEQiXZM0oB7SFwwDy
         jMmrWld3JquoFT5BEHS46YsUYP3nfuIntJYACQI4XXYRvbL5rqhX/52wiM1ISPwnRaCl
         8reP2ccnsXPidNiFObHpXuFcsocKIzUVHIgT54AoN3oRK/JBzVAdiTTnzIPZomfbH35a
         SeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601116; x=1707205916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC2acMvCrsnsCSaOBPgEXr/tWbb4doa7fO8e2ncEHsI=;
        b=bL+WWBICL5vSus3+FWOQZuqykWTrpnxydmGsflTzHxH42UgSJyXynjdfcUHTOlmG/G
         j6n33eVHgJ8OKquEWehFOJm7T+in8CLtHs1J5UEgJjw1QLPpn1eYagkONCzmVlZOzX82
         33gHjSDvMDrpZK2KIFXI9DVoxMrvNSM/Q0P2yqYClyhK/+DjH3wLZVW9LorwyzZn0mFu
         LoZdPBGDgH9FHQvisygiR8VhnHamMFD3s3VdYrOhPnGl0Lz0GUtRUQ6Cantcp58Dje50
         WIYL4gGeQ/ZxGmy1WvO4ZY8TXoTJ0UjdB60CRCCZeft4A/1s0rrxoTDRtLzgGF7X6nzO
         nCxw==
X-Gm-Message-State: AOJu0Yx37Ill9nBL2vsYYXU03zTVhm2lMr+gniNTL/utJCWDvdMRMnt3
	rzioJM23tUvpSGEvrBhY0CIxNOLyN/J1EYXslZOP+J2yIVH6+pR4EJ88o7pNQm3DroggW1AbVJm
	sHFqKUdhT3YKyaE6YuA==
X-Google-Smtp-Source: AGHT+IFujAJSnIpBcmAbV97uHmHUldTU/Nx6o0IeMBQyrYJ/AkEZInSvGk6j70Unc0QUBg4KgRSkRB0BXb9FU1/9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:108f:b0:dc2:23d8:722d with
 SMTP id v15-20020a056902108f00b00dc223d8722dmr2809887ybu.13.1706601116113;
 Mon, 29 Jan 2024 23:51:56 -0800 (PST)
Date: Tue, 30 Jan 2024 07:51:54 +0000
In-Reply-To: <20240130014208.565554-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-6-hannes@cmpxchg.org>
Message-ID: <Zbiqmi0KMo0zTJ-p@google.com>
Subject: Re: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:41PM -0500, Johannes Weiner wrote:
> Remove stale comment and unnecessary local variable.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0c6adaf2fdb6..7a7e8da2b4f8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -546,15 +546,11 @@ static void zswap_entry_get(struct zswap_entry *entry)
>  	entry->refcount++;
>  }
>  
> -/* caller must hold the tree lock
> -* remove from the tree and free it, if nobody reference the entry
> -*/
> +/* caller must hold the tree lock */

We should replace all those "caller must hold the tree lock" comments
with lockdep_assert_held() or assert_spin_locked() or something.

I can send follow up patches on top if you don't want to resend this
series.

>  static void zswap_entry_put(struct zswap_entry *entry)
>  {
> -	int refcount = --entry->refcount;
> -
> -	WARN_ON_ONCE(refcount < 0);
> -	if (refcount == 0) {
> +	WARN_ON_ONCE(!entry->refcount);
> +	if (--entry->refcount == 0) {
>  		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
>  		zswap_entry_free(entry);
>  	}
> -- 
> 2.43.0
> 

