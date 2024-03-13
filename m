Return-Path: <linux-kernel+bounces-101613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D487A95C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A81628A0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF44652F;
	Wed, 13 Mar 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myNkllq/"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069746433
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339489; cv=none; b=sSUn5tZlFO0ATk+CrPbSGrCKIwUkeoQJGUH/iDQJLC9vBlEEwZZiSbpq8WetFj4bJ2RBrdr5zBUBc/G3wCeXhRIbf4XcvNPLq9SsSSP5Xm/rn6iOnZdkK0OCTewMBek+leTD1U5REcufpFV+O3K6zSRzflhO8aYbQwAI5VCH32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339489; c=relaxed/simple;
	bh=YdVzmhaBVHm20JsyPQZC+11KYcds7si9Z8hnWDsJlEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl5urunOAcCMGxaDmHxhs50Cb+YegQuwlDfuYiL7Oh9AqbyDGBl3RcjWSlYkK8801zlxd+NkwfWx/Mp9pStDHO+y8fv4YJkVeIhNXSNNlNp8YYQpXl7KzmpyJcagocWloaxCHFRwMtGC6hd2UdZXxxP7VDilshWs5nPRv2tIdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myNkllq/; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4e673d9abso2430154a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710339487; x=1710944287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD3YDr8tOSlxd6SayzAWcggM8xuhZzTheB38pd8zJuE=;
        b=myNkllq/dcfYsmnH29jh2ZIN+Mn1+Tyq9HMdK4V58XzRODKuczVMegwi9B3uGY73/T
         J6ABGIE2nTUggcnKddFqEc7Q1i9f/x7bwX6ehqeVieldguuRfYWbxXSMxcOdjpy1ASu1
         1EyS2flbhokEs7XR3iyY8tZ5pHoGyC+aJd5lEk4EG6qNhzVmzSZKFCKCuG9636NNrKVV
         LMhStHtoVipluS0jW7EJEm7Dpymbc/Vj2//0wV5tf9WnYMGqTBUDjwNzZgWteBbvvj3w
         v6bTKXwHhTgXB8b53QiFC1lmWul2ZhnoRGAlhxqjUlGVCtsN0mYVUy5toA6+eZg7rtyx
         Gu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710339487; x=1710944287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD3YDr8tOSlxd6SayzAWcggM8xuhZzTheB38pd8zJuE=;
        b=B1+u9yFZkIhXPabmemE56cedU1M9+lZJKwhaWMcUQp0r2z9z1P/shJ6gNpD9pWBjKn
         hhattfdMVwyZe7NYS+rMqn3FSe5pmwFYRjtqnWd6oZDfPWILZnt0p0h1yqte18uWVbaR
         2wkJKBMr8ICq6aWqpDsRbMCwh8UV2/28cXVsq2x9zO6dapltAFHJsyETso1PIo1IbJTj
         fHSNaVpji7eGQUzU7uR9KScDVrz/ndGNl5ULlPX8GiTVRtiEu9QHuLp0YG7b06CBl870
         i0RE2KRqoSCnIriVDf9WxmMofcDJW4CFKL0ZOfTe4LinP4eTdIA3lAJ1m9DJPzNajSWN
         0kRg==
X-Forwarded-Encrypted: i=1; AJvYcCVKg3K8WVPaGFhD58mTPSmbdEXQT50P1LRk/V4iZ4+S33nagT1ERTuGTdcGxRYavr/c7RDXKC4+81WnNkK2f4xe3u3kaOm5xOzYfE6J
X-Gm-Message-State: AOJu0YyMQPe1/NUNP96CNQ8wTu0FUq/9kWI68QhXExPpQSvdVBSImz8m
	0MSgqTWu08C5ktVFHnRXB9Ck/I1MwYk2sI5cpRSh4WIxpNtmdKhk4VExZ7PKAMtjddFJIN3yJvZ
	FIe3KMWf8d6m4TqqI+443W3PCu8YaVgiltGvs
X-Google-Smtp-Source: AGHT+IHr4+ut5/5+q0jlcqVCNExW9zh6aYQqmP6HkgA4swCQpZjfqoozX6xBkQQpJ7Z0sfcwNMs78xq0maqVC4Dq+UY=
X-Received: by 2002:a05:6830:1198:b0:6e5:3c63:7895 with SMTP id
 u24-20020a056830119800b006e53c637895mr14841otq.11.1710339487165; Wed, 13 Mar
 2024 07:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfGqCWzyVzyGQrAQ@x1> <ZfGudRl9-tB_TszO@x1>
In-Reply-To: <ZfGudRl9-tB_TszO@x1>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Mar 2024 15:17:28 +0100
Message-ID: <CANpmjNPrssMSw+jaP1ods1NZLxnk+bO_P9FUmRLs-ENEMPCcgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 14:47, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>
> On Wed, Mar 13, 2024 at 10:28:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 13, 2024 at 09:13:03AM +0100, Sebastian Andrzej Siewior wro=
te:
> > > One part I don't get: did you let it run or did you kill it?
>
> > If I let them run they will finish and exit, no exec_child remains.
>
> > If I instead try to stop the loop that goes on forking the 100 of them,
> > then the exec_child remain spinning.
>
> > > `exec_child' spins until a signal is received or the parent kills it.=
 So
>
> > > it shouldn't remain there for ever. And my guess, that it is in spinn=
ing
> > > in userland and not in kernel.
>
> > Checking that now:
>
> tldr; the tight loop, full details at the end.
>
> 100.00  b6:   mov    signal_count,%eax
>               test   %eax,%eax
>             =E2=86=91 je     b6
>
> remove_on_exec.c
>
> /* For exec'd child. */
> static void exec_child(void)
> {
>         struct sigaction action =3D {};
>         const int val =3D 42;
>
>         /* Set up sigtrap handler in case we erroneously receive a trap. =
*/
>         action.sa_flags =3D SA_SIGINFO | SA_NODEFER;
>         action.sa_sigaction =3D sigtrap_handler;
>         sigemptyset(&action.sa_mask);
>         if (sigaction(SIGTRAP, &action, NULL))
>                 _exit((perror("sigaction failed"), 1));
>
>         /* Signal parent that we're starting to spin. */
>         if (write(STDOUT_FILENO, &val, sizeof(int)) =3D=3D -1)
>                 _exit((perror("write failed"), 1));
>
>         /* Should hang here until killed. */
>         while (!signal_count);
> }
>
> So probably just a test needing to be a bit more polished?

Yes, possible.

> Seems like it, on a newer machine, faster, I managed to reproduce it on
> a non-RT kernel, with one exec_child remaining:
>
>   1.44  b6:   mov   signal_count,%eax
>               test  %eax,%eax
>  98.56      =E2=86=91 je    b6

It's unclear to me why that happens. But I do recall seeing it before,
and my explanation was that with too many concurrent copies of the
test the system either ran out of memory (maybe?) because the stress
test also spawns 30 parallel copies of the "exec_child" subprocess. So
with the 100 parallel copies we end up with 30 * 100 processes. Maybe
that's too much?

In any case, if the kernel didn't fall over during that kind of stress
testing, and the test itself passes when run as a single copy, then
I'd conclude all looks good.

This particular feature of perf along with testing it once before
melted Peter's and my brain [1]. I hope your experience didn't result
in complete brain-melt. ;-)

[1] https://lore.kernel.org/all/Y0VofNVMBXPOJJr7@elver.google.com/

Thanks,
-- Marco

