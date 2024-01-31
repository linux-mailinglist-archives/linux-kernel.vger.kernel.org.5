Return-Path: <linux-kernel+bounces-47361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD67844CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6ACB37DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609073CF7F;
	Wed, 31 Jan 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZHql9ZHj"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65853A8E9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743164; cv=none; b=UleLBxZ3gQS/9GzYUy4VIN/Lc4++vUs3LgW5UMGXY+KT8ftrDPxcS9QicYHZGCiYSwyy2Qx5HLogoqbmXkyyTySbtMzrQFDVpmTiJzTTY3NaMFH4tADLv5tzlSV9mkAtmYabPn5VnlE3w90doomfUDzf5039dmioitrPbLIJRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743164; c=relaxed/simple;
	bh=xblL+yrpEo1gb8xzx/6pV+ZF6z63Q7arn5+fxeove9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz/YXpu/G6THrx366Vppz+sw9zZQeBH5mJt8D6Ak4wd5s6IySHYpXgLEq3+U3rQ5UWxlwSDQ0V8jFzJp1G3WiKoGaAf7UlSwMLMHBaCofF1DmBV09tRat3ebW5dArlDoBd03DjEO284Z48lGCcnoPrBMb0YHPwF0hIY4NjdV+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZHql9ZHj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d040a62a76so4324971fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706743160; x=1707347960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVGRon0CDQR02O+c0btFX180m2QPPnDAgbj2eP6Q1I=;
        b=ZHql9ZHjxDfoqbnok1QQK0K4BUaXQGCzWJ5AhhUZTTU3UX600/WlxgApbBeGoAu/S0
         V9J+thBasYy53HScXr+OZCkhz0ZCP0z7NahvAmeTRIrJ9/HTaUqc02lxfoayVIJV2oAK
         6ayLy95orZuzqFxC7r5JoP7y/PQJtMAjUUM4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743160; x=1707347960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFVGRon0CDQR02O+c0btFX180m2QPPnDAgbj2eP6Q1I=;
        b=g8Q+Nbzx0AzBuBfZBzgzWxM9MymgVlDKywxMsQUBjgXT89jYTW1/KGw+hVi/9Nwjye
         ucZSJ6nlFnMF7TQy24m1eJQY+dZ8lOX21vEPcuYX/0R8LPnEQ8/7vTwjOUWpyFjgVxna
         e1kIo9YmDBQr32QjPcq3W4SLEU7yqqRyOv8IYoZJSpUE2GJMp53IlmqzqktWNvqnxKOy
         mITijN3VVsXhuC3mdYAl1zv3LxJlKFChWCurPzpK7ZWAmNXWBcjQk8xNBbnTjEhHOtzZ
         Cd5WLriZnXmlJAYn0+9I6pC5Cfq+yh5XNmGC6FK1G+TeOw7IWFfWaKeTXJDilsZSG4f1
         IPLA==
X-Gm-Message-State: AOJu0YyIKNZNZbs8sT+y8Fth+tc3j/W2tzq02Dsql5sUm6WA+VGXJgmN
	RKmdItj/bM0r4ssfENqVzmMwWHGxwWELvenp7Rx0pyEoy7uIt04Kqh0nC03lIIduNx58sejocY6
	tS+i63Q==
X-Google-Smtp-Source: AGHT+IFY/m6bSLqLcIulF0+9nVnKdDbHosry8KQ45apUC0lum+W2ABmflZd+bZ2MNbrYcnv/44wpPA==
X-Received: by 2002:a2e:8016:0:b0:2cf:14ce:e101 with SMTP id j22-20020a2e8016000000b002cf14cee101mr2122008ljg.34.1706743160734;
        Wed, 31 Jan 2024 15:19:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbvo8nxq68xrsAXhtVe8xO91s70eqc6n9REtPZzzGBLV4tJtV+6CQDcKtsS5Oj/y6y9MNZT12nUspCi6pAKjJ9HcjIYnQixQEwiXlX
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0055f3edfc3desm2062373edo.20.2024.01.31.15.19.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 15:19:18 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso384884a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:19:18 -0800 (PST)
X-Received: by 2002:a05:6402:895:b0:55f:aa1e:2a2e with SMTP id
 e21-20020a056402089500b0055faa1e2a2emr474082edy.8.1706743158122; Wed, 31 Jan
 2024 15:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com> <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
In-Reply-To: <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2024 15:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Message-ID: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
>
> I don't know, so just did the dumb thing. If the caller always guarantees
> that the work items are never queued at the same time, reusing is fine.

So the reason I thought it would be a good cleanup to introduce that
"atomic" workqueue thing (now "bh") was that this case literally has a
switch between "use tasklets' or "use workqueues".

So it's not even about "reusing" the workqueue, it's literally a
matter of making it always just use workqueues, and the switch then
becomes just *which* workqueue to use - system or bh.

In fact, I suspect there is very little reason ever to *not* just use
the bh one, and even the switch could be removed.

Because I think the only reason the "workqueue of tasklet" choice
existed in the first place was that workqueues were the "proper" data
structure, and the tasklet case was added later as a latency hack, and
everybody knew that tasklets were deprecated.

             Linus

