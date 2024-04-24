Return-Path: <linux-kernel+bounces-157757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F307F8B1565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803441F231F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75061158852;
	Wed, 24 Apr 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="q8RNGU6H"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC513BC19
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995960; cv=none; b=I3Kn2in/gPqi/N51NN0ojuRLNDUgSquSx5PjfFAnxFiD+sI2ZUuaGDcil5uOyFS8TfBmUE2Gg32Gwqt+9REzmd4mD2/CT8mPExrA+sETnmAE2+qEkGFuaXU5G08o0KsYS9v+vm6Yw9FS0I9imAgHtBruAtEeONse+JrHiER+KSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995960; c=relaxed/simple;
	bh=EjIckuWTMrPNrNx1IyUlm5d4usSLHanQ3mlH8tSGrxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF6IwesoT/XjjpWyjws0HARIgFQiExQ6DhVsVMTUVtHxVLOefrO2PKYzz3QoAuDsfvF6K8+NpBS9LkqaEde9gA+0ML8EymjtQpHJr9cY1iM4BZn8g1YkbZR6KPK37VZNjTF1bqzd1MXl90jMOWJnsChrE6nqtYhPO1mt1J5qdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=q8RNGU6H; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc71031680so401375276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1713995957; x=1714600757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NFDw6oSILEOEYj58Y+M6WCpQWJ4w2IPcRKjucPyIsU=;
        b=q8RNGU6HcZcj4JYSxbmETO1WnAJl+TyQ+RcsL2ZO3/bDfsUIi8uYBmOVuApw3rPQvd
         2ED95c+0plOOw/LyzbrkBjdVEE/jdn/1ikGX19wfiUi1B8L7/kQEZJRrocUBSIvSeV4/
         zdKNM8UfWiDkSgiLcK9oGLOzqxN/3ghv493SL1B4yySypnHLGC8w/eRf0nJ658Kkh7vi
         5jv3rTMnJDqyLtPY87ckdMLHNitCstC29OeDwcXMdhW/RJu6oBzgpbXh56Q46Yx693XO
         +y9LLhRG4FZtfPr1iN4EVigyd276wWoOoPwJBHJC7NIwgizgF6wYRVnJK/4A2aP16Zwn
         QZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995957; x=1714600757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NFDw6oSILEOEYj58Y+M6WCpQWJ4w2IPcRKjucPyIsU=;
        b=Mu0adz+NoX3VJIoVV6HNUV6KUEun21spUnJYdLMrfH8N1DbnRWVpbUgioCbpfntVfG
         l/EDum/i1AuKsgcZngC7QYx05AZeSGy/PphqB3w7BaW3jjCmwIF3tzeIMhiF9oIcPThP
         ZGG8Z1i2yUJn7P4t68ndiYM7l5vkxcvfxWzSbzNU5KNOpA522eBj7x71H1y/eC0xefFK
         pNc94pgOXkWoMvq48a+33TAZzYQYtdNH6Rt1vyVs7CMlpQp/q7ldAyn4QDt2K+qzng/f
         /zgo5MOqPDdUKivrlIxCElSdX4fkqLKyWqE66Avm/UipPN7b40eNAf66FpLtqisTiITm
         7xmA==
X-Forwarded-Encrypted: i=1; AJvYcCXoWgXawxoY5ASx71wuVrPeJ0wQ0e7ZJkaWGw6P31tMi73WLIEh+0EtlTOk3mTo4djly4XmbibHKk94tQC9NjkRKEpI6/aykud5EMxW
X-Gm-Message-State: AOJu0Yw5I/AmY+xZZJUvgEyA4rvHqlBVLWiIEaBYDlzVAi0F53WVMhd6
	H+jDP8Nk3BYM3WJZ9QGKb0W6MTHaqBX2DKDWYKR9nXGnt82qr1lBuquwffbrnxCcEXZH9Z04XMI
	Kmek5/vCOqwGajUb2d6DU2+QDKepmypPVf16UaXknJoBvOtQ6
X-Google-Smtp-Source: AGHT+IHy2FuolCm3/82+8/Dgz4CuKBRlE0Vfw8dsKNqEKZY0vA8flJOrwHri9OQTxI+SX6h284xnVqSPBzjMKoWTn2k=
X-Received: by 2002:a25:ab67:0:b0:de5:5390:b144 with SMTP id
 u94-20020a25ab67000000b00de55390b144mr3878973ybi.27.1713995957403; Wed, 24
 Apr 2024 14:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412192304.3201847-1-vineeth@bitbyteword.org> <99c1761a-9c00-4167-86e5-8a69cb6d9e5d@redhat.com>
In-Reply-To: <99c1761a-9c00-4167-86e5-8a69cb6d9e5d@redhat.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 24 Apr 2024 17:59:06 -0400
Message-ID: <CAO7JXPhAHs63QhjCn6hr7ksKc+DP2Qv3vfaKsFtzsbGhe2tmHg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix dlserver duplicate start and stop
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>, 
	Youssef Esmat <youssefesmat@google.com>
Content-Type: text/plain; charset="UTF-8"

> > dlserver should be started on an idle root cfs rq, when
> >  - enqueue on a non-throttled cfs_rq causing the root cfs rq to
> >    go non-idle, or
> >  - untthrottle results in the root cfs rq to go non-idle.
> >
> > Similarly dlserver should be stopped on a non-idle root cfs rq, when
> >  - dequeue on a non-throttled cfs_rq causing the root cfs rq to
> >    go idle, or
> >  - throttle results in the root cfs rq to go idle.
>
>
> seem to make sense, I will add this check on v7.
>
Thanks!

> Btw, as this is an ongoing thread discussion, instead of sending a patch, next time,
> please reply to the patchset... it is easier for everybody to keep track.
>
Sorry about this. Will reply to the patchset in the future.

Thanks,
Vineeth

