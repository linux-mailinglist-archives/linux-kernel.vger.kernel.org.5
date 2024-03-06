Return-Path: <linux-kernel+bounces-94477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B987405C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9426B28214B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541013F430;
	Wed,  6 Mar 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a4F5+Yed"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE913E7F8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753246; cv=none; b=O+sPr6r+mwItI988Jyep/rAVCw4pkMI5T1O7ZxKVPJfvv9pLo2LEK/S6EV9CqpMUTfcuIodfR+DzkkGWwjKrMVswsxxHuuDK1Er2DpMLJFDlqDugvw0ccizeT7LcCotAUubMs98KchOJHdJldbUiwLQ8asNO65ViCbcwnBBrYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753246; c=relaxed/simple;
	bh=biMnzxi6lyL4tJNfmpHNxn2LaDWRe4gzMKaFKNTV9dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNRnSeSXF8h7l5ECw8jSsmMhXSmAFiv2UPfqE5+bRtn4NmCLJsF6RD4nebWF9IO2z3wSNAoMqjRsoMKQbR9CluLrzKj638JUt+l0W1uD+rr95VeD4+P+sSf1gAojfZDRKeFRNOmAdATGJabm40aGOUwqlBJ8/fLeR+zei0UZsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a4F5+Yed; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131f3fc695so30908e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709753243; x=1710358043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2w7z8ybAhp0MNUwIXPYOARG82rdSVFWAVwXlDOSGiE=;
        b=a4F5+Yedmw2o1YViXTjGIFjp1dnhjAZoNpa/4DrV3c8X0RmNFy68Y4vxrGnt5HmM3P
         Hz0JT4jrnqUJE3wuISJZEpjJfDGl/PJlcajfGPEziwH1mr+81EqD0rcZWffWbISqcD98
         2a6otZkUEPuV7OVkuARvsGu2eo1kCKk2PZTiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753243; x=1710358043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2w7z8ybAhp0MNUwIXPYOARG82rdSVFWAVwXlDOSGiE=;
        b=Amkp/FjZ7EdqfhaRDDbweKD4LvZJ2mIYudkO7hY+yoZH5Q1LEJ/xi0qlHSzhyXtGj1
         wpejonLKikl1CKWcBaDScwMWWPvn2vPKZlxoedARxrumD6mUAHhKx3wqlHvPtjgJ06Mj
         mFwfNPOjnrkzY5fURbMdVI7MfR3PvEgo5JimqGBKr2rDWFZlnlsrYJVkOhR7Y+lpm2AJ
         idwu3n8np8ahzofFmaXTdwKOg0s/jiZ5757jXBdvnlgYT5ucRqkKKbsHbgN2Io9ttJzU
         T7J1/4TXodXurw/N3Pu5IEPvQDWFUCdFkV7rULSSQXexcVCOYqfnFq9zzcmIPC2BAOPc
         YjYg==
X-Forwarded-Encrypted: i=1; AJvYcCXxhyVsWWKsMeJn1v5DziHCIupbFR6t8ePXoIrpMdTuQY3+AWpUKMThzSc62EOi1TBLkKuYryrud6kDFPcE52J9Di4hLaAwaXFza20x
X-Gm-Message-State: AOJu0YwpBR4xZIqOPWa1kRUr6B7IDI7n57UeyTwSK/VIdgBxbdnfeecn
	JgihEuEzkIEimCh720zYo7ZwZXWk3zyN0fiMnt6I4VZafoqTbysTwhm58mj2QmYupviUdXrJzFs
	wUN8=
X-Google-Smtp-Source: AGHT+IHaIq1sH0gBvO46cFvQxIMbSLjnPGstZr3vV4rKeqhQs6+Z9yoxrzy4Hq4ETtYn5sUr7Zt+tA==
X-Received: by 2002:a05:6512:281a:b0:513:24b8:a7b1 with SMTP id cf26-20020a056512281a00b0051324b8a7b1mr41424lfb.47.1709753242885;
        Wed, 06 Mar 2024 11:27:22 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t26-20020ac24c1a000000b005131f4fca05sm2710186lfq.152.2024.03.06.11.27.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:27:22 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5135486cfccso49114e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8asXPpDAr1lZsfM4AWZrmhckcho2cGudn2xuyN0Ine3zw3p7miGQMQpx2mVsnQWhdDYnYT7+kzeEbeQND4NE2U5cvifaWr7020dD4
X-Received: by 2002:a05:6512:3b9f:b0:512:a4ce:abaa with SMTP id
 g31-20020a0565123b9f00b00512a4ceabaamr54463lfv.48.1709753241495; Wed, 06 Mar
 2024 11:27:21 -0800 (PST)
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
In-Reply-To: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:27:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
Message-ID: <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In some individual tracing C file where it has a comment above it how
> it's braindamaged and unsafe and talking about why it's ok in that
> particular context? Go wild.

Actually, I take that back.

Even in a random C file, the naming makes no sense. There's no "once" about it.

So if you want to do something like

   #define UNSAFE_INCREMENTISH(x) (WRITE_ONCE(a, READ_ONCE(a) + 1))

then that's fine, I guess. Because that's what the operation is.

It's not safe, and it's not an increment, but it _approximates_ an
increment most of the time. So UNSAFE_INCREMENTISH() pretty much
perfectly describes what it is doing.

Note that you'll also almost certainly end up with worse code
generation, ie don't expect to see a single "inc" instruction (or "add
$1") for the above.

Because at least for gcc, the volatiles involved with those "ONCE"
operations end up often generating much worse code, so rather than an
"inc" instruction, you'll almost certainly get "load+add+store" and
the inevitable code expansion and extra register use.

I really don't know what you want to do, but it smells bad. A big
comment about why you'd want that "incrementish" operation will be
needed.

To me, this smells like "Steven did something fundamentally wrong
again, some tool is now complaining about it, and Steven doesn't want
to fix the problem but instead paper over it again".

Not a good look.

But I don't have a link to the original report, and I'm not thrilled
enough about this to go looking for it.

                  Linus

