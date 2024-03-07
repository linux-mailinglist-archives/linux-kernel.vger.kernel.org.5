Return-Path: <linux-kernel+bounces-96154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7098757C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CE0B25C82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F7137C30;
	Thu,  7 Mar 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MdfrHBLx"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FD1350D6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841667; cv=none; b=qAKW553Fd6GSucygyBcR2+aHE3wT/DPTwxqGiePfGbJ+tydJLosyzbJSKL7Rt1yASOqApbz5l7OXDfERcEB80b5jsOy8SqyxSoOEnudrZgx1I8tPBIIul/mj7pCBbo6G0JW2uThnRXualu1FT0ipC7qL34PThGHtwuqt7DgrR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841667; c=relaxed/simple;
	bh=20dZ8K6KYsjFLDRa9KVUU+GTtq9ea4tPvWyMafwWw8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb+68qPE5xUPMUvpF9TYIMk9MRd+FngpdkAOJ4xpbTWHOf4cS6wc94em9QqMj6WEGptOBabDNjwaQmLEC+t10etM74cf+t06WmuW5Lk8IVui19j4ib1Os+Kh+I23/EseHmzVHwK83+tfXePa1Dok6EdnaQE68VASQzPvV5slRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MdfrHBLx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so2435767a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709841663; x=1710446463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6kBgbL9HAhEpnz7T+Yyi2IbRse7Tjb+btEkUQHTFGM=;
        b=MdfrHBLxH/RIH6gZIR42cr6QJSYvLHAGU6G4aJVYagTvGdSoH/pSP2qTk+N5mJ0DJS
         awNXTOxWNkGO5NF3IFe5651lbkVrIlr4JE0Fdgd6pc0Nc+LRuDUuvwe0G+Caxvxqi4hg
         680DwLN+jicX8rnjex442RRtmdy2znzRZuVzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841663; x=1710446463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6kBgbL9HAhEpnz7T+Yyi2IbRse7Tjb+btEkUQHTFGM=;
        b=VevhhFDrquCxBIc5BPS08oUx7wjLA3Iyhx85YoOrpydoA7BBWxZAOuFUpHiC9jbyaS
         vIpxhTN3HY5pzrUnJVn3ztlHtYL1NKFf1rfIzXHgW5LqfAqfPD20wnbXQkQPgItcUPSS
         AiDFgLbOmR8k+4EbD++vmDgDY06R6juXXpZRHLIxSgXs0hqIwbLQ2gLP0HnOFdRTpIbS
         0aOA158qen9Um/kHV7ZYXFq5kjb+FFtnSj9hkhRfh/m408hHa2mUvUwVaGErqy3rIJYt
         cBzjqnSPtFCNP4uUA4bt2vzeGCwIYxRBMgbQKX7SNHQI4fs+bM+P038fhVwNHb8HeYHv
         RJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGB4vG0SpLFbt9Q9x6gj3IiUMr99l2WHRPtQ7aJrGTsAzlQk8qbIpymhR2m94X09X1uO75owBqgGNfaytTE0JCva4AyRqQxTbvDhC4
X-Gm-Message-State: AOJu0Yz9+NH4aXx+Bi6EMfGY/U9DwELpTMojI0XGjT0lnlfntMmOiXhv
	mv5Uc1H9XpQVtXBIsvIQfxNfdQXSIjoOKYauny6yZu/IU7ycXmGarwZalPsDhRReCxqlQKd5LY/
	XFce/YQ==
X-Google-Smtp-Source: AGHT+IFntQ5SA5sdyvP4sHcryYLDduLW1dqDtJBz2h2xKCIfn+DegUVK8lvfmWaS/MFNR3eth0d6Yg==
X-Received: by 2002:a50:bb44:0:b0:566:13f8:bcc with SMTP id y62-20020a50bb44000000b0056613f80bccmr736407ede.0.1709841663549;
        Thu, 07 Mar 2024 12:01:03 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id k22-20020aa7c056000000b0056706105abesm6420407edo.33.2024.03.07.12.01.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 12:01:02 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so443962966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:01:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPjHBcKF8XLAYD31IuRuiaFVJZKFJZQSXJu0JV6uyHMQ92xzYJ/bswR4s3YNiwf8/HAdoN2dG22BL+c5kO1rbD4od+trVlC0+8XmjR
X-Received: by 2002:a17:906:a18a:b0:a3e:4d7c:9ce1 with SMTP id
 s10-20020a170906a18a00b00a3e4d7c9ce1mr1133545ejy.21.1709841661652; Thu, 07
 Mar 2024 12:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop> <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com> <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com> <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
In-Reply-To: <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Mar 2024 12:00:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
Message-ID: <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linke li <lilinke99@qq.com>, joel@joelfernandes.org, boqun.feng@gmail.com, 
	dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com, 
	josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 11:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > - The per-thread counter (Thread-Local Storage) incremented by a single
> >   thread, read by various threads concurrently, is a good target
> >   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
> >   various liburcu implementations which track read-side critical sections
> >   per-thread.
>
> Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
> similar?

Absolutely not.

The READ_ONCE->WRITE_ONCE pattern is almost certainly a bug.

The valid reason to have a WRITE_ONCE() is that there's a _later_
READ_ONCE() on another CPU.

So WRITE_ONCE->READ_ONCE (across threads) is very valid. But
READ_ONCE->WRITE_ONCE (inside a thread) simply is not a valid
operation.

We do have things like "local_t", which allows for non-smp-safe local
thread atomic accesses, but they explicitly are *NOT* about some kind
of READ_ONCE -> WRITE_ONCE sequence that by definition cannot be
atomic unless you disable interrupts and disable preemption (at which
point they become pointless and only generate worse code).

But the point of "local_t" is that you can do things that aresafe if
there is no SMP issues. They are kind of an extension of the
percpu_add() kind of operations.

In fact, I think it might be interesting to catch those
READ_ONCE->WRITE_ONCE chains (perhaps with coccinelle?) because they
are a sign of bugs.

Now, there's certainly some possibility of "I really don't care about
some stats, I'm willing to do non-smp-safe and non-thread safe
operations if they are faster". So I'm not saying a
READ_ONCE->WRITE_ONCE data dependency is _always_ a bug, but I do
think it's a pattern that is very very close to being one.

             Linus

