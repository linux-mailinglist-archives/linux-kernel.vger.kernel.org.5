Return-Path: <linux-kernel+bounces-31066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9F832840
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ED1284309
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60C4C602;
	Fri, 19 Jan 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yHMRAb+"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA63C464
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662032; cv=none; b=cP8trowtNAFmB8QtG3jDttJARCq4KqYReWs/gze93wDUwkKHkFAYIcYmWxsT04W5epr1xRO48veRzqrXJ+nVwabtjs6w0v5sk6uAi1FkAWmd9bx9WPbzAXHZcJWJfpHsxJZvftWYvY4JCdhedWT2+lnt3qQkTX4cM0S9mTNcHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662032; c=relaxed/simple;
	bh=E8QfEkydkSnb7LnCdvu45N/wPlqfg3YPYucjEOTV77M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvz76nr5HU8Y/xClj9i9GdU0JBgsUVPhQFuKVZsLiCL+6oAKEjxiKCuiWhbLgvPcKERIV+k+mXTRdgzS11YnP5hOqXA7a4MGi2J9DBrKtsQBnBwcGRPDbN9d0CV0y5C6ZmUq+gyw+B2BMsOIx0aiOEV83oZsA91oYb9zsqlRK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yHMRAb+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc226bad48cso563470276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705662030; x=1706266830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kW4AZyeA4bljp7x9nTqzteku8F1VnnufDy0bi8JpooQ=;
        b=1yHMRAb+1SXiE6powORIeGNMTOF4ToxiH9amH3T7MYbW25EQS0AMbc6KZ2L776pNyH
         Q7OdaDBityMNZqY4bTH8/5Xr1VnSgShiWiQVZdt2BcJdOCaxQglQ21CuAUKVuTAg8Wpx
         5dG1za/Gsl3km/B2HsfbcqBp+/03RynS60Z7iEsIDVK6quRa9EImUFGTNSt6XsPwA8Ti
         JAaeYqV6jrWziUXZqpVuDuDtupl2Si6xLp7hTWYq5Q+Tm0Tr+Gy7Bu3zsAjPdFhi8GyO
         EBMN2SOZ0Z3+uSQUiMFem/CShgb7RBxec775vwwFPsnzHbSZcJ0WMu3AfE9J6R/5mYoa
         Nxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662030; x=1706266830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW4AZyeA4bljp7x9nTqzteku8F1VnnufDy0bi8JpooQ=;
        b=eJgRWHTh9p4B6d898MsNyBkTokiI4mNZcIgA/q/26WTQFxP6Epra6FjnMUrimOYYGp
         DtMrzf7iV1RAWHC/yB2oiyEt1EUh6GJ33B6LTIgZWXzaMRQdvMFa0Y4bJHoW6zTp8v/b
         QOqoAlA2d+828HkSAx8OJWgYxdTQ7vVu7wB39y6EXJ1KRWkRTj9UVJL+NlHwSnWrl0SX
         FnbVcZr3CkFTvmHRmpTrhJxjg9gDbvghlGScTtCszXeI7E3oy1kaIxd/J5A+9BqtBet0
         5ileUanZHcFLpJ5AqPUirxpvzxLjuy3nh/8z0TJdOac0J4YIWZJ/uUZ/qQuYxin/vpxz
         ycXQ==
X-Gm-Message-State: AOJu0YwuTi0ak06zHYQX/WtToU0zJhZ5xdo05c8G534vvZwHMEN+GcEB
	dPUbCO97Hmo+oz/jbtpXvI5n6IU5X7l4ufk7a9HRttTZ3Nx93P96Ea6xh8ipzoTpv4A3r+r0WZo
	8WTukbvGdflFn9aKR7kV+/yBLLLoFi8nZ9T46
X-Google-Smtp-Source: AGHT+IH43KcVJy94YdV7VaeLq8V0TGB/qMQbBhYYFRL9gVy1PzmmQ0UZASDTafAYC5KFNDONbReJLFfeSMjgeji5Mjk=
X-Received: by 2002:a25:8686:0:b0:dc2:5515:6f64 with SMTP id
 z6-20020a258686000000b00dc255156f64mr1546205ybk.93.1705662030096; Fri, 19 Jan
 2024 03:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
In-Reply-To: <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Jan 2024 11:59:54 +0100
Message-ID: <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: glider@google.com, dvyukov@google.com, eugenis@google.com, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 11:54, Marco Elver <elver@google.com> wrote:
>
> On Fri, 19 Jan 2024 at 11:46, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > I use a system with KASAN sanitizer everyday.
> > Because I want to catch difficult-to-repeat bugs.
> > And all worked fine until commit 773688a6cb24b0b3c2ba40354d883348a2befa38.
> > After commit 773688a6cb24b0b3c2ba40354d883348a2befa38 all working
> > jerky when I compile something.
> > The sound is interrupted, the cursor moves jerkily if I try to do
> > anything when all the cores are loaded.
> >
> > > git bisect bad
> > 773688a6cb24b0b3c2ba40354d883348a2befa38 is the first bad commit
> > commit 773688a6cb24b0b3c2ba40354d883348a2befa38
> > Author: Andrey Konovalov <andreyknvl@google.com>
> > Date:   Mon Nov 20 18:47:19 2023 +0100
> >
> >     kasan: use stack_depot_put for Generic mode
> [...]
> >  mm/kasan/common.c     |  3 ++-
> >  mm/kasan/generic.c    | 22 ++++++++++++++++++----
> >  mm/kasan/quarantine.c | 26 ++++++++++++++++++++------
> >  3 files changed, 40 insertions(+), 11 deletions(-)
> >
> > I attached here my build .config and kernel log.
> > Who could dig into it, please?
>
> I was afraid this would happen - could you try this patch series:
> https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/ [1]

In addition, could you give some additional details about the number
of CPUs in your system?
And if possible, do you have a way to measure performance besides the
obvious lagging of the system? It would be interesting to know if the
fix in [1] regains performance fully.

One major difference is still that an atomic RMW is in the fast paths.
This could be fixed by reverting
773688a6cb24b0b3c2ba40354d883348a2befa38 on top of everything else,
but we're not sure yet that's necessary because the cost of an atomic
RMW really depends on the system you're working with.

