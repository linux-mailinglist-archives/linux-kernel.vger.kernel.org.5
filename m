Return-Path: <linux-kernel+bounces-94890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891D87465B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95073B22F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68C7492;
	Thu,  7 Mar 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPqfQBFi"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922363D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779800; cv=none; b=lpu49us41/PxYBXZcISmbvQuJ4haOYcpEuog2QFbyjIQA2H6aKFQBPLgP3YaTVWywq7UXIm6+p6dHq7pWzUy/tZ6+/s3xTvJ6OxfRqC9Oba2tzFpoPtsmvxhVNKKtQUNo8yvLaA2ZusRdQtSHyWDNAs2K1aFbpU7H2ityAjqQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779800; c=relaxed/simple;
	bh=U/g3rd6umFaTxSMQeIcGcHvb8Y5daZVNnDFR/zjl5BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmBmjc9WcMnnB0agoSaFX+LNoEyt303FF9CQtdMClBM8nShesRljl3ysUZsAdCVnRF5SofslcQVmSSvb2WAUyjuR2brxCNair7Oi9gD66vTo5j6OrxgiWfLCMM93KQ+rH/eZHDXzBHfr3+0fjKiUK6qI4wWR9bzo0pHDSXaopxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cPqfQBFi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso375243e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 18:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709779796; x=1710384596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0NFNPBAo82DsOxwgtd1xvCB/a8TS3L7jSXLJGBJiaM=;
        b=cPqfQBFizGjfEJeHEaEs0zKs7fXbIQv7UDAirBosrG/vDpvMjkrQkMpzsbT1wrwfb7
         PYYDFszkQPlv/zRjuXSRsYAe4bWAKuTBl03UX7uF3xWguSwZUqXiiyIAKt2LtIYCnbkc
         6bTTWjBH1mLW8gqpI/paz/rp2X2XZA5yBLEBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709779796; x=1710384596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0NFNPBAo82DsOxwgtd1xvCB/a8TS3L7jSXLJGBJiaM=;
        b=GlKzvLRYD48C7pVaDZF3KtoM79/+H9mjan4LZcBCmpOwY/Db9Rat+L7j/DqGDoXnt6
         Yg5BNGxOOKtA7BlU8KVFGr90hjT/F4yQLBqu2SAt8aCE1eaJAmC2EOKzkqgrHTXp3JhR
         5SknxS5+8XO711llmqK71NTh8x5jZ34/YwlHrhB7xjA9jKQ6VEdBadHr+IWxK4e3HF9+
         XBx4co4BzhT/dJokcZpklTVWHsKTn4l3fsV4nHRJdWUgkB+F9ZBrBa7HY8tRBTW/jx2e
         KXKqNQR1A43ztP77V6KSRTiqCzlLdp1B0RCaRxfFqiBCn+rCzDPpB9WB3jPzqYNNedqx
         2J+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmsDgl2VKiAG0pq3sDDH4bh2Ufd1zd2VIZSiDVJsAlszwQO6YXjmC1HJxhhqMcf8nyJPzM25gS4tVhBYMnslaJ5PoK09F7R2WF2+mw
X-Gm-Message-State: AOJu0YzkGHjohmueDPiPRAe+OBPNd3B9aBFTKSFMPtzdhEjw+vjLl1i3
	sTzXuRV7PWusoMmtQPVahHKj70N79h78ymED0hFAT9qO21cIqKTiXwFxnhC1o2y6MPtD/kZh9Yd
	EszvYzQ==
X-Google-Smtp-Source: AGHT+IG7wBpuvjP6PgiGUNElSU+cXV+i15X7SOB7SeNFEZfU91R6p42jlpBvQcmEnCvIXIuohfRfKQ==
X-Received: by 2002:a19:e059:0:b0:513:4fb4:5388 with SMTP id g25-20020a19e059000000b005134fb45388mr456926lfj.41.1709779796137;
        Wed, 06 Mar 2024 18:49:56 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b005132359c699sm2842441lfn.70.2024.03.06.18.49.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:49:54 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e39226efso457215e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 18:49:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC2Br3V9n/1H5RhyiXJBIA1AIHfgpvLKTqkNtzLlMn1iaBWd8hVIX8OBmiGm8mVT74GGRE/D8xAr4OsD9anKp6VozSFz9YM4XBU5oa
X-Received: by 2002:a05:6512:510:b0:513:3b64:978b with SMTP id
 o16-20020a056512051000b005133b64978bmr456376lfb.23.1709779794360; Wed, 06 Mar
 2024 18:49:54 -0800 (PST)
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
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop> <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 18:49:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>
Message-ID: <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I dunno.

Oh, and just looking at that patch, I still think the code is confused.

On the reading side, we have:

    pipe_count = smp_load_acquire(&p->rtort_pipe_count);
    if (pipe_count > RCU_TORTURE_PIPE_LEN) {
        /* Should not happen, but... */

where that comment clearly says that the pipe_count we read (whether
with READ_ONCE() or with my smp_load_acquire() suggestion) should
never be larger than RCU_TORTURE_PIPE_LEN.

But the writing side very clearly did:

    i = rp->rtort_pipe_count;
    if (i > RCU_TORTURE_PIPE_LEN)
        i = RCU_TORTURE_PIPE_LEN;
    ...
    smp_store_release(&rp->rtort_pipe_count, ++i);

(again, syntactically it could have been "i + 1" instead of my "++i" -
same value), so clearly the writing side *can* write a value that is >
RCU_TORTURE_PIPE_LEN.

So while the whole READ/WRITE_ONCE vs smp_load_acquire/store_release
is one thing that might be worth looking at, I think there are other
very confusing aspects here.

           Linus

