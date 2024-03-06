Return-Path: <linux-kernel+bounces-94443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F479873FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34A12877DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFD13E7FC;
	Wed,  6 Mar 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C308fTnM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE813E7F4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750627; cv=none; b=a5kkYGghWeQvAd1p3D7Ow2cnm5qAr5onw1eK/g7TZMdlbyNVH6OpOIUlvi16QkEFg/jngSQv+ANFZbLbl0DSUVn9nYS7r+J+/aTmizX6oM1JUflVw8CgaDz4U7D1yVAOh/0nu6GzDHwmvCu4qtOsAGpiK9Ib7QJaO5dFL4OfRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750627; c=relaxed/simple;
	bh=sMqhYwV20Y535DYN+vGw6lCYwpXjUAzsUCGQTdaeBto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm6pYPJ9cjmEFCBYqZk7B5/1Qop4NuT0tOvKXSBqGs9YCKOR90U5//KqHqMucYTOK+/nuO6lETQHhYAhEzPGj9hztxckopho1ycwlOdYXVrfFHgk7mLoGVcaTrJyKEwl1Rh1wTCK9TKSOwMY7m5dBaT3+sc3QpV0uJEr6TsiD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C308fTnM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso32251a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709750623; x=1710355423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQKl6UzO1h7CA/xfOVaLJcIbW5ASITdcUcyzKmlemHI=;
        b=C308fTnM6+goujFNMeoX3EJxOD/dDItY/FdygQz2XXjDVzesFCDZSFFYqDy0yqc+S3
         37Ua3rBxOHAsr+Cgu4YhIkiQvIOE9jHv6PMjzBTJIhodBqY+71n/fUnFqF2OO1TF8ilQ
         VQMPzwH1Caxx/tYibmk4M26P9nGTkCubruoTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750623; x=1710355423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQKl6UzO1h7CA/xfOVaLJcIbW5ASITdcUcyzKmlemHI=;
        b=r3ZEVwkd2ceCpEQSkAZEHp72taYAe2q6u1JUz+f7nvBi9MhgzI5Fj1EyOxPmBfsCBI
         JKXngLlwBq3ifaQb8hcmiplGl0Quc4SjFC1ltLHrLrY65HCnSy2N/ym1/2o5ACpxt94W
         D+IgmntznU/UzFWIn1+px/WYbHhe0kqaKgVn9RNwZSFjdXVArMPODqeYxV0+79CgQkZ0
         NXMnZFeF8pXWfLRb5gWhZcFcCgoJU5pqQZQHjJMuoph8IY9+aODqdT0uEpXw8zI5z92j
         Yul0sBYNDixmrw8WNeXxqWalJgj2ChA9KokrayJwlCC4m66KxL/Ia1eHG/sKf3UfPsE0
         3SJg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2Hl2kUuyFjehGICvturCmvl01lb6/aUXhon/Nxz7oPzKfa1np9KMpXW/Zh8s6fAAbtIp6edQZAH9z5wHNmjupzyK0l6ZR4n3G6MM
X-Gm-Message-State: AOJu0YwGzPTx4Ku4ygZhZHfbkv2N2Q99/vJGK0DiLLJfFt3D/zF6awrh
	g3pFlLN2iXUoOyoSYN83AVwz9ZIYN4IwjDhGgw0eTWgXQy+9Foip8Hzi751/H5E6Cj5XvHuLrdQ
	rmGI=
X-Google-Smtp-Source: AGHT+IHrVcCpMN/G1DWhjnEADR6VjslgV2btXbqS6wMznMx3nNqzHs+H4cJEwwJGvzD+QAg8DmyIEg==
X-Received: by 2002:a17:906:714f:b0:a44:5515:3b48 with SMTP id z15-20020a170906714f00b00a4455153b48mr10862603ejj.14.1709750623393;
        Wed, 06 Mar 2024 10:43:43 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7411930ejq.91.2024.03.06.10.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 10:43:42 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so11464666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:43:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCZRE8MnG/UtvJS42zoZqt4EZGkP0MgjcmUzOiHijLmKD6Us+mU2pDPeJxVhNXjiyRLR0mOuaa9waEXC2RFJCBBS3jAibss/HdexFC
X-Received: by 2002:a17:906:f898:b0:a44:17da:424 with SMTP id
 lg24-20020a170906f89800b00a4417da0424mr10700423ejb.56.1709750621742; Wed, 06
 Mar 2024 10:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
In-Reply-To: <20240306130103.6da71ddf@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 10:43:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
Message-ID: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 09:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> IIRC, the original purpose of READ_ONCE() and WRITE_ONCE() was to make sure
> that the compiler only reads or writes the variable "once". Hence the name.
> That way after a load, you don't need to worry that the content of the
> variable you read isn't going to be read again from the original location
> because the compiler decided to save stack space and registers.
>
> But that macro has now been extended for other purposes.

Not really.

Tearing of simple types (as opposed to structures or bitfields or
"more than one word" or whatever) has never really been a real
concern.

It keeps being brought up as a "compilers could do this", but it's
basically just BS fear-mongering. Compilers _don't_ do it, and the
reason why compilers don't do it isn't some "compilers are trying to
be nice" issue, but simply a "it is insane and generates worse code"
issue.

So what happens is that READ_ONCE() and WRITE_ONCE() have always been
about reading and writing *consistent* values. There is no locking,
but the idea is - and has always been - that you get one *single*
answer from READ_ONCE(), and that single answer will always be
consistent with something that has been written by WRITE_ONCE.

That's often useful - lots of code doesn't really care if you get the
old or the new value, but the code *does* care that it gets *one*
value, and not some random mix of "I tested one value for validity,
then it got reloaded due to register pressure, and I actually used
another value".

And not some "I read one value, and it was a mix of two other values".

But in order to get those semantics, the READ_ONCE() and WRITE_ONCE()
macros don't do just the 'volatile' (to get the "no reloads"
guarantee), but they also do that "simple types" check.

So READ_ONCE/WRITE_ONCE has never really been "extended for other
purposes". The purpose has always been the same: one single consistent
value.

What did happen that our *original* name for this was not "read vs
write", but just "access".

So instead of "READ_ONCE(x)" you'd do "ACCESS_ONCE(x)", and instead of
"WRITE_ONCE(x,y)" you'd do "ACCESS_ONCE(x) = y".

And, to make matters more interesting, we had code that did that on
things that were *not* simple values. IOW, we'd have things like
ACCESS_ONCE() on things that literally *couldn't* be accessed as one
single value.

The most notable was accessing page table entries, which on multiple
architectures (including plain old 32-bit x86) ended up being two
words.

So the extension that *did* happen is that READ_ONCE and WRITE_ONCE
actually verify that the type is simple, and that you can't do a
64-bit READ_ONCE on a 32-bit architecture. Because then while you
migth guarantee that the value isn't reloaded multiple times, you
cannot guarantee that you actually get a value that is consistent with
a WRITE_ONCE (because the reads and writes are both two operations).

Now, we've gotten rid of the whole ACCESS_ONCE() thing, and so some of
that history is no longer visible (although you can still see that
pattern in the rseq self-tests).

So yes, READ_ONCE/WRITE_ONCE do control "tearing", but realistically,
it was always only about the "complex values" kind of tearing that the
old ACCESS_ONCE() model silently and incorrectly allowed.

              Linus

