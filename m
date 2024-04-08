Return-Path: <linux-kernel+bounces-135041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204489BA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940CE1F21CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F5938FA7;
	Mon,  8 Apr 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2tm/66T"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8F4084D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565047; cv=none; b=c8fUEJxUUNWKiExBokiWHEYsaLc1zmjdKz4Eq9mlNfCZyN+PjgkjfSwctEEUBMdVIzqVfHbZIfbEbuKOHF4aEyD+fOib5ogqFbAMD07BbG+jCY7VXXgrWIqKbXZyBf0CJyTnbzRC8lREb5iHeVYQ+o413AuNqYQ0vfb57+gho6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565047; c=relaxed/simple;
	bh=DlCB0MLCDKFbZ6OQNy2rzkZOL85cCf+2vW/rg/QwDXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpkivlj8kBNCOM1chdSxSBlNpnIRzECVzvZaCCeiy5TVf6LnXfjP/+ucz+lMIbOA0VI/r2yGkT/MkDdPPkACR4PPdL/vr41Bm3WSHQ4Q7iWKoat6A3+FeZ+n8vu1Gfr/C/dmCTJvYXO0iUkrGpTn1meWCdbLA+exyZf66BZGa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2tm/66T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso3232a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712565044; x=1713169844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9xvn/M8xXcsYEzO1oyT+gGu7oWuytzcOqfktvcQPMI=;
        b=m2tm/66TXfi4TtA8dT0qginmmQIuMBsFvai40coLQHtwq3175DldiQX1JLNkaU3nO7
         vkGMAEpNSt/6sw8bF3tSJ96tNJxZ4B7vG4Hr9KtCU8Lu9ZQM+qqvEV+GUrZGy9N3Vf1/
         4IbWVstqqMSgU1k1ro6JYq0GHIXSaJzlMxFQ2n9pgDGZCqWlmw8YmQPeLfMKyOBR0FdG
         wXAemPBPS7sDTxlhpysDlCUzSE3/8L0sD+IEKKrFLD3fKw85gPtuc6e51qdtO3zlHylc
         90nSBdfOJi+yCJgR2zeXkLzNwutmXZ1eUkUxQhr/jgYiROahU8N4uxcaUn1gZ1jFP16B
         vLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565044; x=1713169844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9xvn/M8xXcsYEzO1oyT+gGu7oWuytzcOqfktvcQPMI=;
        b=L4jz0Em/sUiScR0ZlkqQUkNRdtUv5kEyNuUCN9yyM3N8vI/NLadIJRCQ+Nq4EPTUg1
         cFYGZ1gJkbx5UusTdwQsQMdhSvuoOXJtJk0CYvvXC8uxzp/cuIaaPt0H2RouucTqEj4q
         YmCXxEW42aF8LASlIB9afMaFaXzNSJIXozgZYjebIM6BNbYTbO7Ry77BE/BpZ3UCwfHC
         eixFNiV7ggZG1m9Urktug8J9s5vdZcO7//PnCZ8iR1P6mjGe5mici1WuSG7bvYvwbElH
         3C0zZHEejmJQw9CmBUB6n9QrRxVwQKuXtMQT7lvigk8iJSkjKp9FlpXC5pFheskSPV+6
         xxNg==
X-Forwarded-Encrypted: i=1; AJvYcCXJe3sGxUXY1qAJpIhXuFWrme0dnPcNIrREU7KrLEzg3ktzTpi06kD9n1o090Rrsb95xbDvnOv9Plz7NONhOLDV2klFrunt4urWg1tn
X-Gm-Message-State: AOJu0YzRjp+YN8oU+UuMOuQ2Ik84GJLRLqxgqf2Uh161wB/Sl8k4GH7x
	hggqiUzg23ivBaOaw4AdGInk6Q0d5H7A7zrBOe0XSewwLsA0LO1s+EqAAoE4GRmnanVuhhpLcN1
	T8oMUm92pUyJIbDn+bXGiwBimUyFboo8m/If4
X-Google-Smtp-Source: AGHT+IGo86f+JsIMmosO2vCw07SGAuz9k/s/hLLN/rH0J0gPgIV9YJdb3JCApyMU+QZ12S3yUx1niuFqmBiJ/5noLeE=
X-Received: by 2002:a05:6402:542:b0:56e:ac4:e1f3 with SMTP id
 i2-20020a056402054200b0056e0ac4e1f3mr203931edx.7.1712565044222; Mon, 08 Apr
 2024 01:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx> <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx> <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
In-Reply-To: <20240406151057.GB3060@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 8 Apr 2024 10:30:32 +0200
Message-ID: <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 17:12, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Dmitry, Thomas,
>
> To simplify the review I've attached the code with this patch applied below.
>
> Yes, this changes the "semantics" of check_timer_distribution(), perhaps it
> should be renamed.
>
> But I do not see a better approach, and in fact I think that
>
>         Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
>
> is the wrong goal.
>
> Do you agree?
>
> Oleg.
> -------------------------------------------------------------------------------
>
> static pthread_t ctd_thread;
> static volatile int ctd_count, ctd_failed;
>
> static void ctd_sighandler(int sig)
> {
>         if (pthread_self() != ctd_thread)
>                 ctd_failed = 1;
>         ctd_count--;
> }
>
> static void *ctd_thread_func(void *arg)
> {
>         struct itimerspec val = {
>                 .it_value.tv_sec = 0,
>                 .it_value.tv_nsec = 1000 * 1000,
>                 .it_interval.tv_sec = 0,
>                 .it_interval.tv_nsec = 1000 * 1000,
>         };
>         timer_t id;
>
>         /* 1/10 seconds to ensure the leader sleeps */
>         usleep(10000);
>
>         ctd_count = 100;
>         if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
>                 return "Can't create timer";
>         if (timer_settime(id, 0, &val, NULL))
>                 return "Can't set timer";
>
>         while (ctd_count > 0 && !ctd_failed)
>                 ;
>
>         if (timer_delete(id))
>                 return "Can't delete timer";
>
>         return NULL;
> }
>
> /*
>  * Test that only the running thread receives the timer signal.
>  */
> static int check_timer_distribution(void)
> {
>         const char *errmsg;
>
>         signal(SIGALRM, ctd_sighandler);
>
>         errmsg = "Can't create thread";
>         if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
>                 goto err;
>
>         errmsg = "Can't join thread";
>         if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
>                 goto err;
>
>         if (ctd_failed)
>                 ksft_test_result_skip("No signal distribution. Assuming old kernel\n");

Shouldn't the test fail here? The goal of a test is to fail when
things don't work.
I don't see any other ksft_test_result_fail() calls, and it does not
look that the test will hang on incorrect distribution.


>         else
>                 ksft_test_result_pass("check signal distribution\n");
>
>         return 0;
> err:
>         ksft_print_msg(errmsg);
>         return -1;
> }
>

