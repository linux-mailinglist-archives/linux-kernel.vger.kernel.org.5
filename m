Return-Path: <linux-kernel+bounces-94456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB2874013
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D119D1F23E43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB2313E7EE;
	Wed,  6 Mar 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VgiE0riU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADA13E7D3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751738; cv=none; b=hHEplcf17aBitOOcIV1hnCKOrN6+W9LqKL6Cza1dPsMZk+ZbJzrhw8PTqSXYKfGKFDn/2G31rjR1W7kYyYlktsH1Ctymp7oVwuQaPFphwpmZZMoj9TxRQdMkXv7c5mbAA/Fs/YmSCjuMdxn82cTYlcYxojWDxtTpbn6p7xfd8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751738; c=relaxed/simple;
	bh=uktpHUkNmhOKTFxoD3U5Oj5kyJgrlheIj53K3uB4Das=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jlzyb5q798NOy8/2ijqHZMSSYeQAD72gxdjlxzXEndvkaaRswI3W+4CNRnD0cWN0AxH7cn/r3zT8ShkJoiYyXFmE/gsBPr5Cq7GYqdrsY7d6TaQb4kTyILOIZd6gEmwPJ/TJj1A/tB7hT9WGBevdDWK90iSGzmSDLmvIji81uR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VgiE0riU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so11198e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709751734; x=1710356534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nI0SlJxOqKR6hoj2NvT7LNh4O1romH2k1b9PGrSXHg0=;
        b=VgiE0riUh7vM/IXjEx5X2y8szYGhWOlw4hrwQ9S1caoRM0Fp65tjrOnX/z+YoBlUGa
         rKC35hjDNIvaktYfa73wCssEBAViHbYuFMRIj1L9/Sx0vK6XpLGdNmdE0tCQQ8soCMFk
         3BQMZlLdvMZvBqjcb+fTvWlR0BaYY3eAYFSm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709751734; x=1710356534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI0SlJxOqKR6hoj2NvT7LNh4O1romH2k1b9PGrSXHg0=;
        b=kL3QG0QHbJE/8kQMbPoPQveBGxpjkeMS56bxfd7cgZhtThw1RlE+tWTfDJ5HqJclu9
         Ze9NqFdU+gwdpaqFm7vQw1CvAnH5+8wDuYTTOtyqPeRkaHR6SKxv2pXIY3yQd8GYEs8F
         fEwATkMDbhvs6285H3zJLwzLr5/GEwxUAOnhHzjgYBMaSU/hdHMalxJGF0E/dd5s1nFq
         paj22fUhT2KN5DGCsvjqsQQV1E8VU5gy1+aqrlZCh6wpDGLAv7Ybjjx2+4nmJ+woClaZ
         NPIQioE22vIgJwZdGckuRPI5+/e8w2u41Mdx1CTMmAHCgI94x94QozG/rERzFN+ttJ3a
         hkeA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMWjvysrTEcvS1CRiwZVmPCCbDsZIITLq7VEmGo1WfZShkIEkTyk4MNJHcAmAQw2WZK7zYkmx/VqTKoB6Xe4MLPF1ZOg9+Mu1cEM4
X-Gm-Message-State: AOJu0YxfSpM0d7ZsUVieXQIjd1C0+RJKz/mc8N6i1GAaSh4bJBP9lNso
	M7H3Vz5ACQd/JTXC73ipwDCgfU3EUDev1ohIJcLZFPkPKjfF828+NOeOMLfiebVihGAY/Z/Juuk
	KUVQ=
X-Google-Smtp-Source: AGHT+IFWDbBVDd7Qb2DWP+yMxBFgcxPcKWQvoKi5n4Tg/dy4pPzfd9brzWRVZ9iBJmIT5bQj8Wwj+A==
X-Received: by 2002:ac2:5e79:0:b0:513:5a9e:78af with SMTP id a25-20020ac25e79000000b005135a9e78afmr2082760lfr.58.1709751734390;
        Wed, 06 Mar 2024 11:02:14 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090607d300b00a45cabd9b5asm25095ejc.111.2024.03.06.11.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:02:13 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so76270a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:02:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc2CG24XdAQ2wahJ5t68lrIMlgqzBzkLwf3TLYTRB4F23tSnR7SKq6yj0/0RN7PMxzTxHNG0Ogr+Ryfmge+Td9zvs79AWIy5QBjnKu
X-Received: by 2002:a17:906:f355:b0:a3e:c738:afa2 with SMTP id
 hg21-20020a170906f35500b00a3ec738afa2mr11850437ejb.76.1709751731771; Wed, 06
 Mar 2024 11:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com> <20240306135504.2b3872ef@gandalf.local.home>
In-Reply-To: <20240306135504.2b3872ef@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:01:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
Message-ID: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 10:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Now, are you OK with an addition of ADD_ONCE() and/or INC_ONCE()? So that we
> don't have to look at:
>
>         WRITE_ONCE(a, READ_ONCE(a) + 1);
>
> ?

In a generic header file under include/linux/?

Absolutely not. The above is a completely broken operation. There is
no way in hell we should expose it as a general helper.

So there is no way we'd add that kind of sh*t-for-brains operation in
(for example) our <asm/rwonce.h> header file next to the normal
READ/WRITE_ONCE defines.

In some individual tracing C file where it has a comment above it how
it's braindamaged and unsafe and talking about why it's ok in that
particular context? Go wild.

But honestly, I do not see when a ADD_ONCE() would ever be a valid
thing to do, and *if* it's a valid thing to do, why you'd do it with
READ_ONCE and WRITE_ONCE.

If you don't care about races, just do a simple "++" and be done with
it. The end result is random.

Adding a "ADD_ONCE()" macro doesn't make it one whit less random. It
just makes a broken concept even uglier.

So honestly, I think the ADD_ONCE macro not only needs to be in some
tracing-specific C file, the comment needs to be pretty damn big too.
Because as a random number generator, it's not even a very good one.
So you need to explain *why* you want a particularly bad random number
generator in the first place.

                  Linus

