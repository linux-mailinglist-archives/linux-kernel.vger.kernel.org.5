Return-Path: <linux-kernel+bounces-105029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0A87D7D3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6570C282E69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960481859;
	Sat, 16 Mar 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2IMWmyO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED217E9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710552678; cv=none; b=d89uez5NBWx/NH9TbCwltngc2lFuWXsRSXRXgSQ0y3PmudqDq4cX5qtO6CGfj6tROnX3bMQ02QBc2ssoFJoUrKhaSKknrjgpWL0q9VaG39oty2PZbkqr03oquY+DbX8otz2hrmQ7EEhuQxKWKB2QUkGEfRpjvX5gCC1yMjUX6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710552678; c=relaxed/simple;
	bh=Z6ITrZFtaxCC35iQjbIOi10/3OCZx6fJ7baWv7IANwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNKz1vZYC0L4A6+y5E4HtSPurHxDtN53P5+I4HcPVymqq2PXIasRn9Jz6dGKibTrwaEplimsEI3TCtmmawVr2Fby3gG+aa0HT2UqgfUEP7f1mIUfy6mkTNnKJ65IjeKOE3HYVZ4YSPsFL0X91F3om6BImK3ZL8x/PUzDxc6kK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2IMWmyO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso313748766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710552675; x=1711157475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWDwaTOsUlEtY3mShuSOTHZs7gMc1813DXmknXHM1kI=;
        b=V2IMWmyONG8oOJCY7OVAtcbiTQA/iEKILM1FbiTHKfEVo0qRxgIGvHvyKf1Hp30msS
         /Aq7/sp/qEXJ35UxPzqAEcD1pbv4iSnk1yjjWXJvcsGqpT9sBi5mdLY06uoNN5D1sYil
         LLkXnhDb9EI62+LADndHuIxwDc7TwXedY51fJSh/vLUvJfRkogBcBPvvvI8ZsxjtCTwD
         A+0ZtutyxX6JS4iw0KWUUpO2T8M34Ihoio011tAz2XkyBT//zoFzmdVcdswFM2EjBcDN
         muaNcD1vIrM/gHHIYL6XQnDQ439bOEnRBLm8ft9/9ALVJ9W8EwsuA0FhEjnGwp0iNjNJ
         p4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710552675; x=1711157475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWDwaTOsUlEtY3mShuSOTHZs7gMc1813DXmknXHM1kI=;
        b=YUCqWcbVWP1JnAp4PQDphu9Gkv0Mh81JpdP6M03cODUaF2X/0MoEUhO8ve0hxJF8Ff
         fJpdKbfGNZVguYJoKOO7pHP9XjwYo4BeQPDGid+Smi2YpwGrpLJujt4q2CH1TkBJMf0L
         acGwdpWwbsiK8H01Df/aWIPtg8KWrHigaMBMOmfXaLowM6tx2eJU9Yki8z+lAQfWfTNo
         I5jEE5ApdJrMXd352auRImHL6nzzcHl1+eH0iETWYJuE0qLLq2jvRqdEl+NCg5sO6Kig
         Bf7gsyWf6i+amXB0kBwOJLhp9fP7JSEzUajp6N/Dy+fWKilboYGwId8OIBM9y7TABOEv
         9WJg==
X-Forwarded-Encrypted: i=1; AJvYcCVcApfOG2Sbgse2AqKQiFw0QidUX+CfnCTuWfvcwAJexowmLPzEIsLAO5KiMdi2f4n/rwydsm8bGQohhbo/ErhGuC0rsLwwA3tMguMJ
X-Gm-Message-State: AOJu0YwPJG1ja3gNwshHo0F23l1Em/4NN8wDxoHBukVwo9Xm3pMAkqti
	7f2JJ7xE3i40/HnO3nnyUA6McR/bFt2XSyrL3rBPNdapChGP0ui977fhwo+h3zSn1bt6MuEk/rj
	cQlF5pZkMY5aJ/0ae+GkhQ9jV5SOcQ6I7SMA9
X-Google-Smtp-Source: AGHT+IH3vsmZkRLUAfTuW89cfVVfV7DhZvPKkzKBRBk3AaoQYT41tDzBjrcMdyG7wia+SoNFvj3BhdIzfflQGMl3xQo=
X-Received: by 2002:a17:907:d50c:b0:a45:f39e:aad with SMTP id
 wb12-20020a170907d50c00b00a45f39e0aadmr4394055ejc.1.1710552675418; Fri, 15
 Mar 2024 18:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
In-Reply-To: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 15 Mar 2024 18:30:37 -0700
Message-ID: <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"

[..]
>
> @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>         entry->swpentry = swp;
>         entry->objcg = objcg;
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, entry->length);
> -               /* Account before objcg ref is moved to tree */


I do not understand this comment, but it seems to care about the
charging happening before the entry is added to the tree. This patch
will move it after the tree insertion.

Johannes, do you mind elaborating what this comment is referring to?
It should be clarified, updated, or removed as part of this movement.

>
> -               count_objcg_event(objcg, ZSWPOUT);
> -       }
>
> -       /* map */
> -       spin_lock(&tree->lock);
>         /*
>          * The folio may have been dirtied again, invalidate the
>          * possibly stale entry before inserting the new entry.
>          */
> -       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -               zswap_invalidate_entry(tree, dupentry);
> -               WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> +       old = xa_store(tree, offset, entry, GFP_KERNEL);
> +       if (xa_is_err(old)) {
> +               int err = xa_err(old);
> +               if (err == -ENOMEM)
> +                       zswap_reject_alloc_fail++;
> +               else
> +                       WARN_ONCE(err, "%s: xa_store failed: %d\n",
> +                                 __func__, err);
> +               goto store_failed;
> +       }
> +       if (old)
> +               zswap_entry_free(old);
> +
> +       if (objcg) {
> +               obj_cgroup_charge_zswap(objcg, entry->length);
> +               /* Account before objcg ref is moved to tree */
> +               count_objcg_event(objcg, ZSWPOUT);
>         }
> +
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&zswap.list_lru, entry);
>                 atomic_inc(&zswap.nr_stored);
>         }
> -       spin_unlock(&tree->lock);
>
>         /* update stats */
>         atomic_inc(&zswap_stored_pages);

[..]

