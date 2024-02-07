Return-Path: <linux-kernel+bounces-55978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDE84C474
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB618289AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC814F98;
	Wed,  7 Feb 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xV2t9THj"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4E1CF8D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284783; cv=none; b=Fueb5Dcwcs0dxdC9wqNuu7JVWiQGSsUUjTKDOVlFKg/LMxI6YjQ7qzn/WRcCFXRhLJEj1qizHdKpvxN7ORmGcb8GP8CDu0qPLwIJsez7G/iqZ/qJea5v87rLBZJ75ufo2flIqJHd217Z0iqpB1Y3CPNh+KVnv6witcIIjd0J65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284783; c=relaxed/simple;
	bh=binrH5Mir+QNhaTwp+L3ihjHixBG0oRt+1Oj4M7+3Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDJVk0xR6DajhFpokfbKmizIm28KqoYqRNLuuPQfp9ZPBNN/NUwHEn6d0WkK2ZPYU365I/jWb8YINDhLMftjXxNIrGm8IsEM/Wc+gFpnUDW2/CjrGt/xIwoOFSip5XJ9Wlf/f7U0O1SgKYRHn0Fqn4Cb72MfIJI1+RAWKva1FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xV2t9THj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30e445602cso281501966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 21:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707284780; x=1707889580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kalDtVLZWTvATUBZIpX4S68OWyGb0GfwWS+1uj6sqPM=;
        b=xV2t9THj5IlouhUdC4WXhH0+eNU03QmbA4eb4wSlQeIJKV4Lw5RDm45KM2Qfn++MOt
         kyLwRj3foXoQzjFWo/L5wVMzxOoaLFqqsLQsB7qCBXYUJM4DaPsCPMNej9Jp+h/h66Hn
         HPz+ZTGaDXbjWy6ca78AbIW+hqVUhWsd6hGZlxdluKMQ3hu3Np9rL24QceGol7eVWnKC
         PT8TBnpmOKGi5FkyYsUVNEk4AEeiebtJzx+CVN0IrSmkzU9/3R7vuIVUtoI7Np5TMO+U
         H75Sq6HFIZXreceDVCxZJARiJ8fhsIm0i8WSDeqsd5MyFD72wR02ReCE5f98ldxrzYRj
         dYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707284780; x=1707889580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kalDtVLZWTvATUBZIpX4S68OWyGb0GfwWS+1uj6sqPM=;
        b=hAjXYBKsLNwnroClVPfIqSdpmBkAfp0Jqx5XkDdt0vpvqj/rz0LJmpiPCAVk5q8rJZ
         DreGLa3T9/gGU8jyPkkyqE9TG33dLz783P62Q598RdgOqEGg7fw1wskS2klldIcQKPhE
         R7us0MJIjfAnDoyONlZd+ilrAgcsVMlh2FqDJo+kbMkYhNxiXnMU1oppkMJyD+gz29fp
         mkD1Is62waPsoKRx2A7CIhmEKYHTEfqA0kPmv1NuxSzbh5+BcgzPvaUNUJkqhpOIG9I0
         JGrndj7Q0ChNkoY0zi8mBXNZCAQ+eDCZgLyEIFgJVJFl4otBqRLAWRQ3fcUJtu3vihDX
         R1NQ==
X-Gm-Message-State: AOJu0YyghkefamUAps9xxIeWn0QWhjH5ymDXWJW+KCk4OmgbR2nBBrOq
	lbUnUDjtqMp+Gqg+jJKolHiIPVUzLV0mqkO8cXhjSaafyylarYyOa9DvEyceuuZLjBh4TIh24zM
	1V6TTTH0Xw+zEA1wI3T2Gp8eYl5gP5UPOv9nW
X-Google-Smtp-Source: AGHT+IFrLEabmaF36oojZfoiOrcXwVRBSuGaGdzZQae/d43gq43MN9/eZpjPs0LhyOJ5wi57hxk+MUec9DV2G9tNc+g=
X-Received: by 2002:a17:906:310b:b0:a38:63a0:5947 with SMTP id
 11-20020a170906310b00b00a3863a05947mr995896ejx.20.1707284779457; Tue, 06 Feb
 2024 21:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207033857.3820921-1-chengming.zhou@linux.dev> <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
In-Reply-To: <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 6 Feb 2024 21:45:41 -0800
Message-ID: <CAJD7tkbc7j8B3X8YfQ9r00D3ojJvJg+YwNuAF6P=jyCyrGy_=Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/zswap: invalidate old entry when store fail or !zswap_enabled
To: Chris Li <chrisl@kernel.org>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
> >         /* map */
> >         spin_lock(&tree->lock);
> >         /*
> > -        * A duplicate entry should have been removed at the beginning of this
> > -        * function. Since the swap entry should be pinned, if a duplicate is
> > -        * found again here it means that something went wrong in the swap
> > -        * cache.
> > +        * The folio may have been dirtied again, invalidate the
> > +        * possibly stale entry before inserting the new entry.
> >          */
> > -       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > -               WARN_ON(1);
> > +       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> >                 zswap_invalidate_entry(tree, dupentry);
> > +               VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
>
> It seems there is only one path called zswap_rb_insert() and there is
> no loop to repeat the insert any more. Can we have the
> zswap_rb_insert() install the entry and return the dupentry? We can
> still just call zswap_invalidate_entry() on the duplicate. The mapping
> of the dupentry has been removed when  zswap_rb_insert() returns. That
> will save a repeat lookup on the duplicate case.
> After this change, the zswap_rb_insert() will map to the xarray
> xa_store() pretty nicely.

I brought this up in v1 [1]. We agreed to leave it as-is for now since
we expect the xarray conversion soon-ish. No need to update
zswap_rb_insert() only to replace it with xa_store() later anyway.

[1] https://lore.kernel.org/lkml/ZcFne336KJdbrvvS@google.com/

