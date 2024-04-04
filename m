Return-Path: <linux-kernel+bounces-131139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB8898396
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0067FB28DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642574405;
	Thu,  4 Apr 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXjoiXjF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B773530
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220930; cv=none; b=OyeQyVdxpxpHs/GGkHkAyUKWYRwjXQ5amaxLruZIkQBjY9vmcDpjNEcVbDTsDa0yedtIax3JyFiwF02TtdF2PCz59+vYf24QzU9ku6gXl8laE0WPYBil0+3SQawNRDc58XFDBgo32vXEo30cbJT05NF+O3YW6Ym/7qiXKXcKMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220930; c=relaxed/simple;
	bh=SjMW750EWieLC8GssjE4d0VybyGyABsFnQu1IQJUPVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm/aooHf2rHAHqKX+po3DvqM5uhkptcQcxd9KxHhy8vPK2sPIFRE7KPj/z0uQpFrf3m8ywhZwogqWEi4yv/514qWfNbu6hB9rESnZh+nC02lcVI42psflLKR+8iqsnyK94YVm75DEGbonNe2i8k9OoitiDviQzmHrj3AA3giP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXjoiXjF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516b07b4c07so1357e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712220927; x=1712825727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3+/tCR4hiyQCc/kSu8Ua48ZwM/P/iLQrVfSfzYNWog=;
        b=WXjoiXjF2YiauGR68sxn9HKCQXTVcDAafgWJUuCe44boHfEYw3YzUtTwCyZghzEfPQ
         2t5FWQcnUOs8EWAFBKs5ST7YgY4dwrLnRRqPuIFwyVgdStXVNf1p905/+yHpKT+Vfu1I
         bcZXA3xDi2ZiFURYzLX2Sgh/oh0i5QxASyzeVUVwfkrkd+vEI0stfppUMh5iJK1Ko26i
         n2as/pYnv29bEmiaAyKGP4vT448kwLnql/uGhq0AyeYjn/Yzc2WfkHeXE4AMLoxGEdpV
         H662na+m5IuzTxqvEAKWqZe4vtuZR1SudVMIwSoMIiV4Fw6mgQEA65wCm/CVozZGAvg5
         M2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220927; x=1712825727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3+/tCR4hiyQCc/kSu8Ua48ZwM/P/iLQrVfSfzYNWog=;
        b=LnDcrprRbdngPU6kxH9rdri73vGZsE4xJrKzlA31sRPtI6wIQFY37EzG/gGQhbgQAT
         FEqU4TkYW4T1fMQ0TYTLKdTgGVbyCBu/dwh4b2LKXaMKSSH/FuLL5+3oJGniv4A8qRUc
         gjDzIoQA/jyouANNxG7v9XQGrOX8Znnu2dYCUG/PWFnk3wkvw5WCBQlJVQWSEZjsT4Bc
         A3Or+6DR4Oui9h7S6rNYMrA1xfdnYDPCvDY1AuHxKl+N2ofkyocP+rV9kKe2WSC7o6T3
         nrar0JixstcxT/kqu/05N8yziR4/054QH4wQgbamwCDW1MjNZwoZvxXDgVJC7tpZuYrv
         94Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVzM4LESibhgC8we+8zZ2gmsjYJz+urboWUCf09YmT+sxq2Mjk9Nz63nVsBgRLz8x246octrSyJsc1v7UkZhMRGQnbHDXvHD6ASPUAN
X-Gm-Message-State: AOJu0Yy26HnsaycndpY+99umxuv2TBKBs/+AV9F2CBVTn+ukpt5cuBu7
	/+UGZHsmnk8BKJ2jg6Aug5i5nOqPsijpG5Ljk2w5UQ4JuNlcFobWCm7/3GzfWvZdsiElBdBTkFV
	CxgXIw401v5dfRXI4XIsvHFZIwc9RLn5lhQHS
X-Google-Smtp-Source: AGHT+IHJuCYcyRMZpQyAeKjDxXlQBfy8VLfzxYkxcBYpE2K0tzGDw3ORQEU59JjeJQMIq/kex/86/JdyqlrA8FkmdAE=
X-Received: by 2002:a19:4342:0:b0:515:b9de:e444 with SMTP id
 m2-20020a194342000000b00515b9dee444mr25478lfj.6.1712220927041; Thu, 04 Apr
 2024 01:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx> <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx> <20240403150343.GC31764@redhat.com> <87sf02bgez.ffs@tglx>
In-Reply-To: <87sf02bgez.ffs@tglx>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Apr 2024 10:55:13 +0200
Message-ID: <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 17:43, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Apr 03 2024 at 17:03, Oleg Nesterov wrote:
> > On 04/03, Thomas Gleixner wrote:
> >> The test if fragile as hell as there is absolutely no guarantee that the
> >> signal target distribution is as expected. The expectation is based on a
> >> statistical assumption which does not really hold.
> >
> > Agreed. I too never liked this test-case.
> >
> > I forgot everything about this patch and test-case, I can't really read
> > your patch right now (sorry), so I am sure I missed something, but
> >
> >>  static void *distribution_thread(void *arg)
> >>  {
> >> -    while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> >> -    return NULL;
> >> +    while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done) {
> >> +            if (got_signal)
> >> +                    usleep(10);
> >> +    }
> >> +
> >> +    return (void *)got_signal;
> >>  }
> >
> > Why distribution_thread() can't simply exit if got_signal != 0 ?
> >
> > See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/
>
> Indeed. It's too obvious :)

This test models the intended use-case that was the motivation for the change:
We want to sample execution of a running multi-threaded program, it
has multiple active threads (that don't exit), since all threads are
running and consuming CPU, they all should get a signal eventually.

If threads will exit once they get a signal, then the test will pass
even if signal delivery is biased towards a single running thread all
the time (the previous kernel impl).

