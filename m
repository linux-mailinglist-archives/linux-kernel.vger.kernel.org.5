Return-Path: <linux-kernel+bounces-29557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B826283102E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC12815DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291A26AC2;
	Wed, 17 Jan 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxw1g9MW"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD761C11
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535305; cv=none; b=gwo7+FzEuSd+gSiLhtAcclbGbmPm0dWmHAa3tqCDb2k0hXkqKnVTfTv7pv84r+V8nSKKFO9hEOssgDOfcmMyMfo9axVP9cGGyyN/R6EihoQqlfJU6jfCcMVrhdGXRUYHA2g1ojdZspQwCUJTgeYddDi5/CXwE6TfDDJI+VDhyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535305; c=relaxed/simple;
	bh=o/7Dr1KrXaPTWwgbqvtbLp3agio8da0eexlUCdi+K7w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=K67wcOSuGLS9JeRGyoF4MlOiwkegUL2xUAFLIya2Lfpcq6rEkjt4eLkGFSUMesi/5BITtpTCye690671qWHqOBhMAXsh/uUSI+f1w0xaUc14L0+Rpg5VzqH1s4J9uAj0wAqcwpIlHgOJ/S/yB4JBV4r2svd8qw7os0IUCTbsAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxw1g9MW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28ab7ae504so1095296366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705535302; x=1706140102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCBKt8IzuP6x9scNJoSJcUgrz4a37akazxYAWOrz96o=;
        b=uxw1g9MWVUCcPP0CpYrws6CY7oOjlfiM6QFyWfqMSDv4QC6WiiJZaGtlPeDLCj2jVr
         +XByPsD35RogMr4H4//gs2uhKeNok2DjlFtjEyuNe2zB7IoLC/UzbSO1R3tsgW8dp0+9
         GAglm6oefXT7Eae0pqGc2juEb4YMxvPhjbZkzM4NQKyDa+whVmf2IQ+3Q0K/+sVFivFb
         Yqftu15VetQJuRZkmDzdlLmQc8mZCO5M1nJ2JcnjwHZNerLayvg6l+LWUiC1z3ZLpE0U
         /1xKaln4a8i9ln6Tr2gOBZIQT+MfefdT3OCUlIEMF2D+OIZuFnlvNWPIAg4y0v7rrUiE
         4xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705535302; x=1706140102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCBKt8IzuP6x9scNJoSJcUgrz4a37akazxYAWOrz96o=;
        b=mh6YHBtZTAHAUnop4GjuF4CwQh7PuTZ9pxunXsY0lgE5n0eviDs5H5Grpj+ceiTmr8
         ZRXDyGQTbw0Y4Gj06h7YmNu4oljMJ87/rUa3360Bri1jAm844nHsqeaRPpvvvg2cFiSI
         7MOoTBc/0Ek+eq1HsyfSt0q/vYEzrPdXAubEjFJOgZv4xDtP+BBIK7sfDoLRF/gATK0p
         RZbRRmjtzitNmk3B+f6MuypszzeQRLy3P+vu1281QAF2Zwbk8/qHL0ezHzKs/aiypRS6
         7/GsBgK3eKj93KqBFHyejGoKX/PDA1/pKzGGl8eyqXctTyU+a8Q6ukfNmyg4bFMktceJ
         tOdQ==
X-Gm-Message-State: AOJu0YxxDrXu8NH92fSypAAA5NlyDkmn0BoJQtM/SWlAOGt/wWJPtpFi
	USNM8F3cLAS5s1Ma850nd4S6VkaQKfnY+/NUgPdOMCFMpip+
X-Google-Smtp-Source: AGHT+IHa4FJiq0gIOz5Xu8OFGK5EDo+l00VS9u+UDHJc/7nb2ZqSAqIo5sEY/iucx2Cc8EJZlYP9InkzXT4x1GRvqCg=
X-Received: by 2002:a17:906:60cb:b0:a26:ee83:8841 with SMTP id
 f11-20020a17090660cb00b00a26ee838841mr4895563ejk.33.1705535301782; Wed, 17
 Jan 2024 15:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com> <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
In-Reply-To: <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 15:47:45 -0800
Message-ID: <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Currently the xarray patch should have everything it takes to use RCU
> read lock. However taking out the tree spinlock is more work than
> previously. If we are going to remove the tree spinlock, I think we
> should revert back to doing a zswap tree lookup and return the zswap
> entry with reference increased. The tree mapping can still decouple
> from the zswap entry reference count drop to zero.  Anyway, my V1 of
> the xarray patch will not include removing the tree spinlock.

Interesting. What do you mean by removing the tree spinlock? My
assumption was that the xarray reduces lock contention because we do
not need a lock to do lookups, but we still need the lock otherwise.
Did you have something in mind to completely remove the tree lock?

>
> > The reason why I think we should wait for the xarray patch(es) is
> > there is a chance we may see less improvements from splitting the tree
> > if it was an xarray. If we merge this series first, there is no way to
> > know.
> >
> > Chris, do you intend to send the xarray patch(es) anytime soon?
>
> Thanks for the heads up. Let me send it out now.

Awesome, thanks! I assume Chengming can test whether this series
provides the same benefits with the xarray.

