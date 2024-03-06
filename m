Return-Path: <linux-kernel+bounces-94502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9908740B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11D91C20E66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537814037C;
	Wed,  6 Mar 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PgjB9rNt"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF413E7ED
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754392; cv=none; b=j+s6+dn+0KS3WswVP9EP63gKywOZSF70xpAe1vv3dhbFJosj1r0o35M2nwJ+J21ioU5gyByf1j9B8c7pfmaUrJw8xEBVTT0o7CrZq/jEBfHdil7oW7XaaA/tADXUZNdHkXqS626KERMoGYAL/URckL5wEsAmrpDdLysRN8NXIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754392; c=relaxed/simple;
	bh=EsrOB7GWDfZEolkuh93kmRh+nny/GJZOQsiuqS+Npj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM9Z3WM5+6Wm1UHKoN/sjAEWnkmHZJMzwAQBCnJ1+k4CT+suWjtqDWb9DXTBXfMRYAeC9/YhB0MUA0RqomsUOqweXCpfnp/j/qKAgedOxbY8J2n++AUQ1dRM7ivQvoLDApf6D+8vveJS1cTqPt/ceEuPe92uEtB1CWdos5HQVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PgjB9rNt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4467d570cdso15886166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709754388; x=1710359188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5tv/bveZOleZ+h93PkvUkJXX+8+GRGSuEkqnAwfMmY=;
        b=PgjB9rNt1HtUTZYN6PKrZ2MhJxMeNrtVdpL9VUAri0iKSKVKr9XeQa8fuFTlUcXyFc
         KhewoRNGxFPuWFLzMgEuhNuqGySFWIWmw1KImJ5Lx7SxYG/kEEzEx/UswpYJkAK0pnfc
         Yfj01Sdc0sOTk7KQxNgExX6xrB2M7sec7LkCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754388; x=1710359188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5tv/bveZOleZ+h93PkvUkJXX+8+GRGSuEkqnAwfMmY=;
        b=Ea7SPIWRW/cDk1/zc+yKmJNyk0r5yv3XuzrXy/WRdLmzyfXy5q6Ht7Ee7Sa8GTP0HJ
         9F+nl5MurMwwahP9B9VLFvmuSP4u11BnEgrTC4DnBa+SdMvNuIS03U1W4CFvsSq1mTGM
         vhAzWSMYTQH5Qp5IPNR4piHuf/xkKId8zpvdJ7P4Xtr7ysC4RG0vfqdqRCC289OPwEkB
         WVm0PDKumwd8k6/1wqzbwajsjMezdY46lS/9ZVj9NY2C2+8jhb5gK21rA/0L46JZkFF1
         xnuUsGUuy3Wt7dA8gpynRqat/T9uwd/ep2HK827Mfb/2L5oAyHySnZhNrcP7D0SP/Bhx
         tGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5x6/CcmBmHx6dSmqnb1GPmPMS0RNNGOj7++rpbwga/A0fEXmwmenfrX3Ps4ot3zltE48J7nlJVnYx4tAo+1NXUBqlMYkyxrOM6wWp
X-Gm-Message-State: AOJu0YxUWX1XrM1T6Y/YjjULE9D0nrnEfB69oHJelMBeAxYVa11lfeIj
	Iqg7RHaLyH5oxrVMDlo42PfPK+WiHNCOhl9ijPG2Q2oLSKJlnafBpRE0qJeRB7CjW5vIDN3m1I6
	4O9vMIg==
X-Google-Smtp-Source: AGHT+IEADdtfUkpyQ/TE8Va1nP0CHdlMiiHmJw6RuaEzc1jAWR7/yHixZFkuaDBpQAQkzA2nIOKQSA==
X-Received: by 2002:a17:906:d20a:b0:a44:505f:bfa9 with SMTP id w10-20020a170906d20a00b00a44505fbfa9mr10011936ejz.58.1709754388115;
        Wed, 06 Mar 2024 11:46:28 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906381b00b00a449f43a7afsm6020563ejc.113.2024.03.06.11.46.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:46:27 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4467d570cdso15884666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:46:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3QK8h6NsgSo1uVuPLwQIzl2ky5RR0QiTPbr5ImYe9WsT3oCQWNcfQ52A9NuntXiGxprOanXVS5FSmQLxqX73Rmw8bh5ldag+pZ5N3
X-Received: by 2002:a17:906:fc16:b0:a44:3bec:20a8 with SMTP id
 ov22-20020a170906fc1600b00a443bec20a8mr10802569ejb.76.1709754387248; Wed, 06
 Mar 2024 11:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
In-Reply-To: <20240306142738.7b66a716@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:46:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
Message-ID: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note this has nothing to do with tracing. This thread is in RCU. I just
> happen to receive the same patch "fix" for my code.

Ok, googling for rtort_pipe_count, I can only state that that code is
complete garbage.

And no amount of READ_ONCE/WRITE_ONCE will fix it.

For one thing, we have this code:

        WRITE_ONCE(rp->rtort_pipe_count, i + 1);
        if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {

which is broken by design. The compiler is allowed to (and probably
does) turn that into just

        WRITE_ONCE(rp->rtort_pipe_count, i + 1);
        if (i + 1 >= RCU_TORTURE_PIPE_LEN) {

which only results in the question "Why didn't the source code do that
obvious simplification itself?"

So that code is actively *STUPID*. It's randomly mixing READ_ONCE and
regular reads in ways that just makes me go: "there's no saving this
shit".

This needs fixing. Having tests that have random code in them only
makes me doubt that the *TEST* itself is correct, rather than the code
it is trying to actually test.

And dammit, none of that makes sense anyway. This is not some
performance-crticial code. Why is it not using proper atomics if there
is an actual data race?

The reason to use READ_ONCE() and WRITE_ONCE() is that they can be a
lot faster than atomics, or - more commonly - because you have some
fundamental algorithm that doesn't do arithmetic, but cares about some
"state at time X" (the RCU _pointer_ being one such obvious case, but
doing an *increment* sure as hell isn't).

So using those READ_ONCE/WRITE_ONCE macros for that thing is
fundamntally wrong to begin with.

The question should not be "should we add another READ_ONCE()". The
question should be "what drugs were people on when writing this code"?

People - please just stop writing garbage.

That 'rtort_pipe_count' should be an atomic_t, and the "add one and
return the old value" should be an "atomic_inc_return()-1" (the "-1"
is because "inc_return" returns the *new* value).

And feel free to add "_relaxed()" to that atomic op because this code
doesn't care about ordering of that counter. It will help on some
architectures, but as mentioned, this is not performance-crticial code
to begin with.

                Linus

