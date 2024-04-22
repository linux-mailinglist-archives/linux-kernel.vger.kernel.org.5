Return-Path: <linux-kernel+bounces-153923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A9C8AD4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096521F2146E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2619155336;
	Mon, 22 Apr 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1DyT6SF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931A153831
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814471; cv=none; b=uDnBDfJldn3lC7rKWsvW50SO5TIJeIBnBqszh89lgvjzPT04xVvb5g+Evt32iUg6WG5rr8VrdfVNS7hBIW3XwmOOly8QD8aL0vXeTG/C5TmTN/EfvGT1XsX4A1gUo0WVWWnRdLUdkXYsHJ0EWWiOLrUaowtC1bO46DpVVo2X7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814471; c=relaxed/simple;
	bh=Vp/tkgdMoUx6EonBTngrC+tJWul5WETjfoj6TFvnm2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt2IgBhm9TjIrS+LDCqUqYCrkHbz2iRLqbKAGdFM0hm7cot0BMsRovYh08cjDVCDxwerUw+E+JHuVork5ZUdWM+mn/tEwtqb0FGO8aS29X4ppGSYYx3Q2vjb3yjv+att6jtn7Va9d3OPx0F/yBW1MaPJwg0wTY1NtKNxmnpBI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1DyT6SF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so7262096a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713814468; x=1714419268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sxtnPCIgVV9hGWPNgNGJvJcxoCruKD++MVW/iWLAiqM=;
        b=f1DyT6SFKK5cWCmllHsbDIOSrXJ+73f/wgQI6qfnk3YGs31S7fGHpVSXzA7xK7jJSE
         rocvuBPoKWKRKG5KyOQslsZxf93KiE28jC96t45VoH8WdGDy6NAe8FxvIPSnli5necHO
         YbNGy4uXxiVN4UHqAZA8P9yfuOZn9JvveEmzZqu3bxgu3PcWezQj+fXECg8lHBEUEZw5
         F+P094UPikG2jK6S0YObCKsOvrMHtSiCVvXJ/5/SHVR25r3Zj5GTmxL4w9hxz7qdl22o
         pSpaa4/oJV3EsfYJOq7Wic5MOJrODje3ryGWQqK3aiah+uMIOnIdGXmDSTweaiCc/0rN
         CMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814468; x=1714419268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxtnPCIgVV9hGWPNgNGJvJcxoCruKD++MVW/iWLAiqM=;
        b=cpmgeLSAKsU7wQgyhJOsVWPLOQlzK+6I47Ym1v6CR2JnZeta9mXFaGFxD1a0Ck51Lc
         Wgk5dnFeVieEdgg3pOu8QRMlZESri5i7ztnHD6zgofN2+9ZC0su4i+Zh3moxU72nhzyO
         vKaWWx9jOu3WVfRurvqyoQkLfNKwODoXB+JpjREDMpBUmIuIaCItTPhbrXamMvuZAWrK
         Tb17CpYeePQrWXoFG9okA3epz3KZvtoP7BgCd50/NGNc2IMtfW5u8QgCC6eZD2GoW1FX
         VP/ou6lPrD+dvinMp86LH2jqAjGd8UxaGLoVn7dFqVg7aUDnD2dvBfVrEhIlR7ENd9YS
         0dRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHn6DRC2xI2y87cOz87JFlugkiSeSc6vwWBwWqyRhZ2715LKul2GafKifIAhsn4v738Rez+Lt4q6P/BuciZW6GiC7o95N+TTJSo58j
X-Gm-Message-State: AOJu0YwcGudYqKfzuHHvh9GarmBnRvk/xmIrbNL1rQUFiwQgEI1hEQte
	Le/+7JBfHpsw2JheLJTmOTQrlV84KjnnqGNG67RFLLYOpmbpIrzPq2yXOFST5KeqA62nMSUDt9k
	yYycsk9SrStiXd0ZAREGtyUvUzGM=
X-Google-Smtp-Source: AGHT+IHq0FKEgI38KxHgzMapYhrWIisD2wIDMt2l4m9XrNS4sOyYhBk0IyWxxTtHNhJZt/hmUiA9C+ypY1A2PPdHQu8=
X-Received: by 2002:a50:d79e:0:b0:567:824:e36c with SMTP id
 w30-20020a50d79e000000b005670824e36cmr10820135edi.14.1713814467602; Mon, 22
 Apr 2024 12:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
 <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
 <7jhx44ynje54wfcq3bkaui5w6oox7ypd7cgg4u5zhue6rf5tok@nj6jaxppzq2b>
 <usubtr2bibcnwca3rk3ytbd2jbpvshgu44faujrrrcnidnrr25@ttdhvhrz34vs>
 <CAJg=8jyaV20PannVxVQrqasmo3RCTAjOWfmkdm3ehviMoc=V-w@mail.gmail.com> <4vyuejd7gikyjlbmcpmdcemplminhy27ltbodmq7nkjsozzod7@ttzgzxrjp63y>
In-Reply-To: <4vyuejd7gikyjlbmcpmdcemplminhy27ltbodmq7nkjsozzod7@ttzgzxrjp63y>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 12:34:16 -0700
Message-ID: <CAJg=8jx3jVc-Z-z7=WJFhv1TjH8MW6oTQo69xCDhxc5aX6H_=g@mail.gmail.com>
Subject: Re: general protection fault in mas_empty_area_rev
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Liam,

On Mon, 22 Apr 2024 at 11:53, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> * Marius Fleischer <fleischermarius@gmail.com> [240422 14:07]:
> > Hi Liam,
> >
> > On Mon, 22 Apr 2024 at 10:05, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > > * Liam R. Howlett <Liam.Howlett@oracle.com> [240422 11:25]:
> > > > * Marius Fleischer <fleischermarius@gmail.com> [240422 11:11]:
> > > > > Hi Liam,
> > > > >
> > > > > Thank you so much for the response!
> > > > >
> > > > > > >
> > > > > > > Crash log:
> > > > > > >
> > > > > > > general protection fault, probably for non-canonical address
> > > > > > > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > > > >
> > > > > > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > > > > >
> > > > > > > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
> > > > > >
> > > > > > This indicates that you built with your own patches.  Could you test an
> > > > > > unmodified 6.9.0-rc4 with your setup?
> > > > > >
> > > > >
> > > > > I'm very sorry for this oversight. I had applied the patches for another bug
> > > > > from this conversation
> > > > > (https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
> > > > > I will test the reproducer without these patches and get back to you!
> > > >
> > > > After testing with your config, I can see that those fixes are needed to
> > > > boot.
> > > >
> > > > I am going to try 6.9-rc5 with your configuration and see if I can
> > > > trigger the issue there.
> > > >
> > >
> > > The reproducer does not trigger for me with your configuration and
> > > reproducer.
> > >
> > > Does it still happen for you in 6.9-rc5?
> > >
> > You are right, indeed, I was not able to boot v6.9-rc4 without the fixes.
> >
> > I tested the reproducer on 6.9-rc5 (ed30a4a51bb196781c8058073ea720133a65596f)
> > and it still triggers the crash in my setup. How can I help you
> > further troubleshoot
> > this issue?
>
> Can you try the attached patch and see if that stops the crash?
>

I tested your patch against 6.9-rc5. It stops the crash.

Best,
Marius

