Return-Path: <linux-kernel+bounces-133484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6389A45F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32E0B22383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42110172BBE;
	Fri,  5 Apr 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvJ53+0N"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA73172BAC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342639; cv=none; b=BdBKv0EayfhjQwItp4lGZ+ixJxopCupdhvcRJcMtjyqOeRPKKXZ4FJ9U6JQMW4iGJnfy5Ix9+J5PiJZEbMIs2XT/jAx/S8l/FJYGjhpID8D3P/jsAsdqTpFpoySNZqvg/k0J6h9+4gXUS8YyPiJ+969/3tPro+adiKBn5W1o9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342639; c=relaxed/simple;
	bh=Fce75o2l5YUPt0p0cIxGUqN80w6+7bIFBDLkdPYFUPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZzcS04RpomLpnmgXvxHKI7WKpAXcYbWSVoXevCqPOsxwhtK5FNyqo+tFXpUS8CEosB20RCxKrMT2hWZtjBLUfmhdVQBnLqQdujBLe/h7r4z8lj3dT5d2V5SfO1HmLDhkwMg99IotfcSmhpsDIWKgBvBsk3lgEcOnoxPCFBqpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvJ53+0N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso107881466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712342636; x=1712947436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnMV8AN6DREIABPi1BxfkQZ01lAd8EKxgi6dsBuz1eI=;
        b=yvJ53+0NovIi+woe6xXyJTHSURUKNuSFuhP3xidHkmNAjxg7X/c7SvxcrMgDcyL4DB
         V7gkEFsU5q2wll7f/nZfqc/tj9ocO4P/jJbqfEZL+t4JMtUP9hkhcUGt3nO4eHQijYS2
         +LULySrWy+wsELmG7osQnnyKoBKGgYcr6blekrs3O+IkDmlCK/qbv/bgsJbIDhXiXRuv
         ihwZc7xfs1ALoTJHmDRNHiyH7/fK0qlitj1ZJfnSQtPs2CC061jCOeMC0YOQvYHB+c+g
         p0UCaKpRP7zgxdrB1yyow3z/UxM/tOAa6YeNSB2fU4xR1rdkH4w5Qj4y/terD4yWQe4q
         fSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342636; x=1712947436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnMV8AN6DREIABPi1BxfkQZ01lAd8EKxgi6dsBuz1eI=;
        b=xMKMO1+imZ4gU1G0+QvWPCuk8kDdBhzG41yV1YMJXim+ExMD7t3HRKdgnmhW/GSXJZ
         IvSB855ZecdKXdrACTjc2crMdfIkHC6SmzyBOtJa5PQ9+L+PievhBYkla61LaokaaipY
         9ykCee2GuZlTBYiBRQdNaEOCzwNmUuChm6M/Y23bwy8HTxg5Dg6ys3RGMwhC/SnAA8+e
         uaNY90m3K+ohescyopocPQBOq5HYoxVz0Iglp+uX2JIz7LYqiBJA00Q2Czd9u7+OyTFQ
         xr8jcmA5Kir/CKLlIKaJQTRDG/7FyMz9hFw+3os/inLj5efJDduQSFplaLShHiY4s623
         xMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWVMER426we4qSqKBWgrD8uV3G21JQ8HE/iMQeBBJVqXtzIrPoC3ELOUex6kmNqtRVghyk93lGuN96RvX20f0L7YwbUsz0rv2fN+G9E
X-Gm-Message-State: AOJu0YzI/kNxheKsvMUH4Z8rZp5vniSyllCKNHFozkFfVehdHfmuOm03
	iqdn1/9Ek0rSBMg8+Jq2SqWEULp0DjL25ic9bvzd7v8yamW50kzzCraljMlJfkUBLKBh7fVZTyQ
	ULBAMpQRWQaFjERssWK8p1zDTMKpwzRkmj0Ir
X-Google-Smtp-Source: AGHT+IGbP37cCkoF7uwvIhjztIqOWb1qd4D53h5AorS37SmONsYnMkD6uHssi4l96XHUZw+tQA80X/rlVn4ygLCgIJg=
X-Received: by 2002:a17:906:717:b0:a51:a488:9213 with SMTP id
 y23-20020a170906071700b00a51a4889213mr1575930ejb.17.1712342635786; Fri, 05
 Apr 2024 11:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com> <20240405152619.GA866431@cmpxchg.org>
In-Reply-To: <20240405152619.GA866431@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 5 Apr 2024 11:43:17 -0700
Message-ID: <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:26=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Apr 05, 2024 at 05:35:07AM +0000, Yosry Ahmed wrote:
> > Currently, we calculate the zswap global limit, and potentially the
> > acceptance threshold in the zswap, in pages in the zswap store path.
> > This is unnecessary because the values rarely change.
> >
> > Instead, precalculate the them when the module parameters are updated,
> > which should be rare. Since we are adding custom handlers for setting
> > the percentages now, add proper validation that they are <=3D 100.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Nice! Getting that stuff out of the hotpath!
>
> Two comments below:
>
> > @@ -684,6 +703,43 @@ static int zswap_enabled_param_set(const char *val=
,
> >       return ret;
> >  }
> >
> > +static int __zswap_percent_param_set(const char *val,
> > +                                  const struct kernel_param *kp)
> > +{
> > +     unsigned int n;
> > +     int ret;
> > +
> > +     ret =3D kstrtouint(val, 10, &n);
> > +     if (ret || n > 100)
> > +             return -EINVAL;
> > +
> > +     return param_set_uint(val, kp);
> > +}
> > +
> > +static int zswap_max_pool_param_set(const char *val,
> > +                                 const struct kernel_param *kp)
> > +{
> > +     int err =3D __zswap_percent_param_set(val, kp);
> > +
> > +     if (!err) {
> > +             zswap_update_max_pages();
> > +             zswap_update_accept_thr_pages();
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static int zswap_accept_thr_param_set(const char *val,
> > +                                   const struct kernel_param *kp)
> > +{
> > +     int err =3D __zswap_percent_param_set(val, kp);
> > +
> > +     if (!err)
> > +             zswap_update_accept_thr_pages();
> > +
> > +     return err;
> > +}
>
> I think you can keep this simple and just always update both if
> anything changes for whatever reason. It's an extremely rare event
> after all. That should cut it from 3 functions to 1.

Yeah we can also combine both update functions in this case.

>
> Note that totalram_pages can also change during memory onlining and
> offlining. For that you need a memory notifier that also calls that
> refresh function. It's simple enough, though, check out the code
> around register_memory_notifier() in drivers/xen/balloon.c.

Good point, I completely missed this. It seems like totalram_pages can
actually change from contexts other than memory hotplug as well,
specifically through adjust_managed_page_count(), and mostly through
ballooning drivers. Do we trigger the notifiers in this case? I can't
find such logic.

It seems like in this case the actual amount of memory does not
change, but the drivers take it away from the system. It makes some
sense to me that the zswap limits do not change in this case,
especially that userspace just sets those limits as a percentage of
total memory. I wouldn't expect userspace to take ballooning into
account here.

However, it would be a behavioral change from today where we always
rely on totalram_pages(). Also, if userspace happens to change the
limit when a driver is holding a big chunk of memory away from
totalram_pages, then the limit would be constantly underestimated.

I do not have enough familiarity with memory ballooning to know for
sure if this is okay. How much memory can memory ballooning add/remove
from totalram_pages(), and is it usually transient or does it stick
around for a while?

Also CCing David here.

