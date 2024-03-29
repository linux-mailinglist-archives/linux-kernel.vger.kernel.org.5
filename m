Return-Path: <linux-kernel+bounces-124053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD70891192
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E4D2950D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8B39AF4;
	Fri, 29 Mar 2024 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NorheStb"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAF39AC1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678505; cv=none; b=qQri3A2RPcZjq+sAiFHHvYlaPJRIVT5B30vKBClywvmjBne5YSJ6FtbtTaH5nHhBIEIrhJZvvLFUn4HPem0OnIycv+lX4C9kAiVJn1FlGTAubrG4bDcDNZlbCQ6Gtyy6D5XjySmfWKq9mRIcFiWs7Da4cDSB09D1M7skLGzJzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678505; c=relaxed/simple;
	bh=2TJM3k1xxwLHj7rZQzcbRutzHAX/f/s1ZJB+wGTa34s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaMcgQpkW4mPEBB1ZTCdlggflOHfm/59OIfORhBkF0A4MuzzUeGsFj3S567GZ+wfsD6dPQVUxmnAk/gPuE7qd9c4ChDWKIeVShlzBsiDfAmhiwmeDNM/ocYiqpjFZzD7BtHHLcrziyOZ876X3xGgD61eE6FqvCzsbjh+Y2/B4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NorheStb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5101cd91017so1928287e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711678502; x=1712283302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TJM3k1xxwLHj7rZQzcbRutzHAX/f/s1ZJB+wGTa34s=;
        b=NorheStbNAyj9KCRvmGAJxf8gh0RENcdC3+iF+uXWCENBjgkcPlDCk7G4RJIxNXsl1
         ICTghRxcs4aPdUH1XsDrTqD9vpZjl5RZHLz1AyxtOMwTEi/71TCrGe+yYz3AH5tZxfkH
         azwSa7GLW1PG+j7FMDHa8hqKjdhqQ3KS5gRCUeWrBMG3bT5EnnW7axN1ji7fHbQMoyhx
         isdM3RN/rVOYZUFP7k3b5XtqmGQhvi/iUOpVb4T3oc8EuUedckBKGg36RzKRnzs8wrFw
         G40zavpHWEpOUXgx1fOleWwY37PiPxSAEbyXSxREWAx/qpO3UzObhT9xYSTpfTuWtEMT
         IzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711678502; x=1712283302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TJM3k1xxwLHj7rZQzcbRutzHAX/f/s1ZJB+wGTa34s=;
        b=Vc7y50ufRvyAgkUIxyjp5DfjyIbUOu2kkhnfYtrd89SldxxOns5FQp/MZoRcefe3yW
         45jbHjjB7WyGbgqPpc+TlCgn10BsGkwZJq3qSDNOtjrJ/0QYBnYyNn+cl5IV+KbDkL6j
         f6S+j6eGi7Yj5UGR736RZcXc8MVcfODplM0qtDe0L74F7ByTsbwjq0SKwe0vZwB1XeVI
         04GtaNeucGCJL4ZqakJXdcWKWNv4KKDge9V0Q/O9Nzht+cAQ+X2G00FgM2fwQSRH0iOv
         letfhd9uinyy4RumaVyTuiJK/D9v/2suFV5uNQOncz7S2d1keBPpJzMV+HK/oayoESZS
         25mg==
X-Forwarded-Encrypted: i=1; AJvYcCXhwOH05peBTlMnZTjnNGplzY01W2vDCmacMG2nKrsVNnBvlOW8ROyyqREYZ6pyHbTCGwLbN3gyrzUetW+F3U+fjbzqs88HFjI98r3B
X-Gm-Message-State: AOJu0Yzf31BqdtEgZJiLSGvH2WhRCC1QHBeZtnSbiG2Hb1hCbUbRytwR
	qqPmBJXUt4TygP/oGgoQCONRQ/oT7mGzL8GQRduE9p1cxE4hczCk0N7S6wtrsTbzlCCje/m0gw8
	F78iKXKCvgt3S1uWSP0hmusnK7Ojf6n9JUSQV
X-Google-Smtp-Source: AGHT+IFYfxEWp+QyYGIk6nirCzOHn5X1uxYWPnwfEZhRsfFbRfxGp0cuGuu1gkljjnat4Sd1Au0hxbaFMcNA7zKHm2w=
X-Received: by 2002:a05:6512:15a6:b0:515:d1bf:2473 with SMTP id
 bp38-20020a05651215a600b00515d1bf2473mr47876lfb.25.1711678501958; Thu, 28 Mar
 2024 19:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com> <20240328191109.GE7597@cmpxchg.org>
 <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
In-Reply-To: <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 19:14:25 -0700
Message-ID: <CAJD7tkYo90ynKfBcWyMZLu7r-GJj3egnnJyGiJ5T2SN-Tn3d9A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Mar 28, 2024 at 12:11=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> > > There is no logical reason to refuse storing same-filled pages more
> > > efficiently and opt for compression. Remove the userspace knob.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > I also think the non_same_filled_pages_enabled option should go
> > away. Both of these tunables are pretty bizarre.
>
> Happy to remove both in the next version :)

I thought non_same_filled_pages_enabled was introduced with the
initial support for same-filled pages, but it was introduced
separately (and much more recently):
https://lore.kernel.org/all/7dbafa963e8bab43608189abbe2067f4b9287831.164124=
7624.git.maciej.szmigiero@oracle.com/

I am CCing Maciej to hear more about the use case for this.

>
> Thanks!

