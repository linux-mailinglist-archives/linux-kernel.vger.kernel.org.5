Return-Path: <linux-kernel+bounces-139429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609A8A033B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C7A1C226DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F2184128;
	Wed, 10 Apr 2024 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvWNlXRC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767812FF7C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787691; cv=none; b=MYhLwMHMMUY+0MAJomIokYNyF4UolzvAnvh+Yqa7iYbPGt+bRO50Km+tjtcTX0VSi7zr75hcPXR9YO6iCFP9KiHcH69fFAbUlIKRbreGQPmQC4Sahg2okK319poydHuT34BMIP2oi4SvvuBu5g+KuQvHu19nBZ8D6sf2HqZ2DMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787691; c=relaxed/simple;
	bh=XeUMxL85wF4w3KZtxKRKZ2ShTc688UuYA1dTVwgdFWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWd7DlszS1Co+3HAX52F8pB1nX/C8qsxp9alyAL7SYtNAQOcmKAaQ/DSR7yfkCt7vJH+lq9H/vFhyDo0AsU3BWb9mhwiFAMAk313qEbkchvaxEL3Lhw3tLMGkjGoiBRU/qZ2OfdTbPl5UBGu+2Jdj6TQ6n3idxmA8AFs/1ts59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvWNlXRC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41687826509so13855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712787688; x=1713392488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH57B4VEUrPyB0pxiA08g9XOpVRgWubVTw/7AXbFYeE=;
        b=GvWNlXRCRdsrvaw0KAw9cI1lNLiAk1YRs/BFbkdJb2rAh9fY0q8eu94A3Wre/CSrZ/
         9jlxzAlJtmaPypIUvtuktdGaLVglzME3L26hDPqzuO+MoVisNXz8fUK/gb/o9ICncr9a
         B0diw5JB/p2wONdc4xqAXsQQDoxGAq/ATHsv6hSKJQowHVmeSZy20DngBOxrd7ZqtEkD
         qLdGL9pbnVp1fIVmppQIXMV9k33LRkJE+rwZNS+Tfy1A17ZEOm16Ywtd/5ue5PIMf9kI
         udDYDC6nDIm6dfhEvdgvNmD7C+2f1MPN6qpI7Rw7zgHnZqPPTuCwhsW4wIlcm7CxXMM4
         13+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787688; x=1713392488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH57B4VEUrPyB0pxiA08g9XOpVRgWubVTw/7AXbFYeE=;
        b=drNoaukeEH3hbzsu4AjXpLPE8CwUnRzKr6HspwG7oheKCUZOtlH07ZM4Duz+iXEcXm
         Mu1Z+1S8IMzqt1/Oj1mzJDHMbbGA2St3tMWOFvBYtBGe+aDaSFchg63FLba3TKsS6orD
         u/G0eniEl80eMVtjXudQtudTGlp5pSeo7ePkGA8L/jyELHgyUNqjOG+iHu7P9I9Qsldo
         NWtEjB9JSPXBMXNVzI+bQ28IrgD5tYIhMdz+EXfR80BhVg+PllOktecz0IDd8Bz5BwYL
         eBVp448g7oK0VDx5Qw4jvfsthILKplxIxEdwIM4vZ2Y40CrtZMoFa2tGo9v+YTEdOTjG
         7m9w==
X-Forwarded-Encrypted: i=1; AJvYcCUduh+e3dFQfQlPaTQLoSQi8lmnBIEP1Q3pmA2RGbExBJJVeGseZepEWrNRvDry7mFs4szRL3qmhSwlvb9HNbY6k+6taDhJa5aHAwb3
X-Gm-Message-State: AOJu0YzFt7FXS2/WtkI2Zz6s9cpkmOLHZuvQjosLmGG8Ivo4XESWPuN0
	BnfyLyNaEj+t/CCyeNIS3SS+KL+0Y0/5MwOb5ZnHkY80G9vPrgapNwnG7kJxJ3u+5q8rKifXsM/
	KiFPCe5u1h8iEpalN25C1X8AJHEzeBbBNp9o=
X-Google-Smtp-Source: AGHT+IHuLAGX1dDF/B+VXClW4hQV7LNv7+rD3OYpu22hgGR11bdXAMrPHvTf/kaZtOBnEomL/aOU990rNoz9PFvfoNo=
X-Received: by 2002:a05:600c:1d1a:b0:416:7385:b675 with SMTP id
 l26-20020a05600c1d1a00b004167385b675mr24064wms.7.1712787688267; Wed, 10 Apr
 2024 15:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com> <877ch67nhb.ffs@tglx>
 <20240409133802.GD29396@redhat.com>
In-Reply-To: <20240409133802.GD29396@redhat.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Apr 2024 15:21:15 -0700
Message-ID: <CANDhNCrverCP+nB53XnMKFH4sTvxmtchiLWyGbNW6du=8xOSNg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:39=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Thomas says:
>
>         The signal distribution test has a tendency to hang for a long
>         time as the signal delivery is not really evenly distributed. In
>         fact it might never be distributed across all threads ever in
>         the way it is written.
>
> To me even the
>
>         This primarily tests that the kernel does not favour any one.
>
> comment doesn't look right. The kernel does favour a thread which hits
> the timer interrupt when CLOCK_PROCESS_CPUTIME_ID expires.
>
> The new version simply checks that the group leader sleeping in join()
> never receives SIGALRM, cpu_timer_fire() should always send the signal
> to the thread which burns cpu.
>
> Without the commit bcb7ee79029d ("posix-timers: Prefer delivery of signal=
s
> to the current thread") the test-case fails immediately, the very 1st tic=
k
> wakes the leader up. Otherwise it quickly succeeds after 100 ticks.
>
> As Thomas suggested, the new version doesn't report the failure on the
> pre v6.3 kernels that do not have the commit bcb7ee79029d; this is a
> feature that obviously fails on the older kernels. So the patch adds the
> new simple ksft_ck_kernel_version() helper and uses ksft_test_result_skip=
()
> if check_timer_distribution() fails on the older kernel.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

This is working great here (on both 6.6 and the older 6.1)! Thanks so
much for fixing this!
One nit below, but otherwise:
  Tested-by: John Stultz <jstultz@google.com>

> +err:
> +       ksft_print_msg(errmsg);

This bit is causing the following warning:
posix_timers.c:250:2: warning: format not a string literal and no
format arguments [-Wformat-security]
  250 |  ksft_print_msg(errmsg);
      |  ^~~~~~~~~~~~~~

A simple fix is just to switch it to:
  ksft_print_msg("%s", errmsg);

thanks
-john

