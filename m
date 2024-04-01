Return-Path: <linux-kernel+bounces-126955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD138944EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1230B21AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839E446DB;
	Mon,  1 Apr 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YtDFfq8r"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD34EB24
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996204; cv=none; b=De3Mz2u0VqxmEILM7PuvAFCS6Bq1ZwEBvW4tuwXUIkGRYflljB2St9pRYJZXWVaERt7DsAIZJl3V4xLGAvv85GedyuTAl4fq+mqaUowmZq5ZD3VGECcwTMqG9LLlxo7yei2Pf7bNMwny2FzQiHPSEkFc8dt4nKQ3UT1fKvV0K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996204; c=relaxed/simple;
	bh=jHBhTcz9b/FCYV57pFSGHdXOtywY1ISdo8C3i2njQVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDCP7K9fDbHil8pIeJngDZ2w0cKa/KO7bKrkSMS/rLGinuDXkduxpeN8vlmzGF9vSoRPt+uYZjzQQphGzxSuyU+YMIbefXANqEM9aIEZLq+ZIqEm8defQrWDzgQvuKdDDl9BkaOzbMRtQ5ESnp6ZB0AEo5fgcdIGCJzvxQHOaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtDFfq8r; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e65dec03eso165563166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711996201; x=1712601001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHBhTcz9b/FCYV57pFSGHdXOtywY1ISdo8C3i2njQVE=;
        b=YtDFfq8rGezJgdK3D8ULIJgzG24V1sWOFd4igrDUljRFTJGEgYM2S+6RYChXszCl65
         2DmEql5uANFZXG1B4sYnnhohGWxoVyfLgW1EA/mhmp+ys44Mh/XxwcWe4R2B4fN1xORj
         4w/RxSLHRnJ4XH3bVyEs5s9p6qf/GCDJ9zUsYlbaDztaZKM6mkAQbGqrVvCRgAP5KXrZ
         bk0rDjeYG2qovmXRQdtzR7E17xKv6rcNTIaoxx5AfrirtF82qzSKWla5UC0+T7YfA+KF
         2ocuawzY07REqWn6LZ7t/8XGRbcgqx0gEZlp7shAmSsvsmcLBoxA36e2vZt2hEE4Lu2F
         5ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711996201; x=1712601001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHBhTcz9b/FCYV57pFSGHdXOtywY1ISdo8C3i2njQVE=;
        b=W2CbD3gC42XQqiTeKNcGZV5l9xCfhHcBmqJOx+3LQ5axVGXow8+b7Sa4KnE+li16dO
         yrEPalWhd4G58q0KA7+eANfnPb9Jonv5srJhC5BjLAvDKek/4GiXvXX1kI6rj/Vyl9XQ
         wL/dZPzfx5VA3ipQSKH6c7Jg8miHqA3W9GyJuhsKMrnRI2lMXnXJvnayLZ7QhEHlGul3
         /1yZ8Znw5v0CaBcEjs1p+/ukNXIq3kqBn1CMErg6KXdRepqwmuORvJGVXLxUVQdtFjuF
         7gWl+qkdExa3nGXWcFCxwwHMhZAWXCd8eUmzh+R3o6Fvwe/KJ4rOv2uVChR62LBW2Jd4
         u9rA==
X-Forwarded-Encrypted: i=1; AJvYcCVsIXxiSaEw6+9tmkXY2JQcLPqlPmMq/DvaDYuzmicR3gkuM5LPGlM3V9wpEQ/MOb9vGmIUKxVjZIcOLJCaBeOU4N+QDYPfBEYvomeq
X-Gm-Message-State: AOJu0Yzl8ZfQmR/8BiPy+uWg+qvL5U73pWC0tRBwJ8vnw3G3biu62MuF
	IefiQuv0DLZb4kdcRJle4ArUXcFzCj4rePT+Ntf0YtYo4Ftqnitjj4C3Y3NX6t0dDHa+yrd5x9U
	64IitZUf86csVcY6txy1lgBSJn/1IcqU+7CBB
X-Google-Smtp-Source: AGHT+IEAp2lI4cFiCSugZPFYkalbx4AOKPCqeanvn3cKtaJ9ibjrGM46h3Qn/tZBgiMmdqstGQ1NTlO7/3y5F5AaH7U=
X-Received: by 2002:a17:906:4686:b0:a4e:7ebd:7e6a with SMTP id
 a6-20020a170906468600b00a4e7ebd7e6amr662481ejr.26.1711996201029; Mon, 01 Apr
 2024 11:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com> <20240328191109.GE7597@cmpxchg.org>
 <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
 <CAJD7tkYo90ynKfBcWyMZLu7r-GJj3egnnJyGiJ5T2SN-Tn3d9A@mail.gmail.com>
 <19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name>
 <20240329174457.GJ7597@cmpxchg.org> <CAJD7tkaXtbM6_6+Oe08_xorMRrU94nvEeDj4_R78nKdZZWqAMw@mail.gmail.com>
 <d111a52c-8f42-4743-9b1a-691882ca58be@maciej.szmigiero.name>
In-Reply-To: <d111a52c-8f42-4743-9b1a-691882ca58be@maciej.szmigiero.name>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 1 Apr 2024 11:29:21 -0700
Message-ID: <CAJD7tkaMXJpCw5gC7ic1DvfK+h=WYa6h1gNBwxMfLay3gFovvw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 3:38=E2=80=AFAM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 29.03.2024 19:22, Yosry Ahmed wrote:
> > On Fri, Mar 29, 2024 at 10:45=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> >>
> >> On Fri, Mar 29, 2024 at 03:02:10PM +0100, Maciej S. Szmigiero wrote:
> >>> On 29.03.2024 03:14, Yosry Ahmed wrote:
> >>>> On Thu, Mar 28, 2024 at 1:06=E2=80=AFPM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> >>>>>
> >>>>> On Thu, Mar 28, 2024 at 12:11=E2=80=AFPM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> >>>>>>
> >>>>>> On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> >>>>>>> There is no logical reason to refuse storing same-filled pages mo=
re
> >>>>>>> efficiently and opt for compression. Remove the userspace knob.
> >>>>>>>
> >>>>>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>>>>>
> >>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>>>
> >>>>>> I also think the non_same_filled_pages_enabled option should go
> >>>>>> away. Both of these tunables are pretty bizarre.
> >>>>>
> >>>>> Happy to remove both in the next version :)
> >>>>
> >>>> I thought non_same_filled_pages_enabled was introduced with the
> >>>> initial support for same-filled pages, but it was introduced
> >>>> separately (and much more recently):
> >>>> https://lore.kernel.org/all/7dbafa963e8bab43608189abbe2067f4b9287831=
1641247624.git.maciej.szmigiero@oracle.com/
> >>>>
> >>>> I am CCing Maciej to hear more about the use case for this.
> >>>
> >>> Thanks for CCing me.
> >>>
> >>> I introduced "non_same_filled_pages_enabled" a few years ago to
> >>> enable using zswap in a lightweight mode where it is only used for
> >>> its ability to store same-filled pages effectively.
> >>
> >> But all the pages it rejects go to disk swap instead, which is much
> >> slower than compression...
> >>
> >>> As far as I remember, there were some interactions between full
> >>> zswap and the cgroup memory controller - like, it made it easier
> >>> for an aggressive workload to exceed its cgroup memory.high limits.
> >>
> >> Ok, that makes sense! A container fairness measure, rather than a
> >> performance optimization.
> >>
> >> Fair enough, but that's moot then with cgroup accounting of the
> >> backing memory, f4840ccfca25 ("zswap: memcg accounting").
> >
> > Right, this should no longer be needed with the zswap charging.
> >
> > Maciej, is this still being used on kernels with f4840ccfca25 (5.19+)?
> > Any objections to removing it now?
>
> I don't object to its removal as long as stable kernel trees aren't
> affected.

Yeah this isn't something that would be backported to stable kernels.
Thanks for confirming.

