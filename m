Return-Path: <linux-kernel+bounces-130597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2929897A48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF0288E08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A215625A;
	Wed,  3 Apr 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WTSw+Vf0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7D1E493
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177853; cv=none; b=I5P/Rmsp+dsup/CkMCnnB3pK5op35/mwk94THqLR3vKDSVAp1LAPHzsmUEWB9OCJfUPHi2GSdSQNC2mOAovNwYDtRDyvB3ej3BZgBUNiSIj48RUiDmldyntxabOXlpANhYiFxM/PFaOULC34P3OmW+jHj88UxBcBieDbDR7KKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177853; c=relaxed/simple;
	bh=MtipjY1rhcZmd8ECzBFU2sU+RH7NZQPVwYxqI/OhKf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlfAwYktW1kCGyhaihtk+5I6qc/84+ujXqveDHPP9MWzA21+nznngEo+b8p7wKqGJgNIV3QsqKHlp2QkrbvG0e7XiP4lfoA/UMdpeFljK7OgnvsuXjbnXmdvoROvNGxrj4i/X4jXX1qCT4sZFC5a/G3dZmtN1lrfs41LolhFn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WTSw+Vf0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4644bde1d4so42305566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712177849; x=1712782649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhsxa7DGICZrrNGGAE/sbQuG+sYkkKkFMYbdqORjHlQ=;
        b=WTSw+Vf0CUyumHgE80ABzcAxCFE8R2EKw/7qTfcEZHsduefBewh/Ro+m9YjK8UfeOT
         Kd4kZc7Eny8T6HZuCwOuavrxrtlBDIknYfdyfEtY+s/14DzcY+OsINzRYJdQMYWot3JD
         /S5Y70JYVSQ6IDIc/DVVVRbmLqftk1/MPzyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712177849; x=1712782649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhsxa7DGICZrrNGGAE/sbQuG+sYkkKkFMYbdqORjHlQ=;
        b=MOryqJPA2nyEZChsiL3Q8rynee/ne668Httmian82DYH9Dtj/zT1QbPp45xMi0L99G
         IeBNYvP1hjCvgPowjNZ31yOefqMkaA5BYDRnypWr/jjc7vyI4HEgsBoeemPDLZbUDEGf
         RVdGWtv5+86ik3BYYshJpCctaSMzzBsN90l5RuOAvkBaR+16zA6v5zcJ0l8e/LJWZfW1
         3htLPTmv4b0BmxBJ8pzbAQ+pY3q/OH9cQIcKlCx7Nudh0eNQozLxbgfh9/oH7PReKFtO
         9QBYGvE2NAYl9qTt0yqkzbGiygLEVFMvy94YGNkjQ7Anr0+3/Ch3YpCYTpmBpsCWHh1N
         Rmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVlRxcfuibmvHbLXpgIiWGaXh9bszBm0j0/w9YAL56FylL1D0kP+ekE6+OKckeZhihHjtbwsiZKQdslYo5MurMKQo+y7fwMETit05n2
X-Gm-Message-State: AOJu0YwzawKprlE6OTf2DnihrVnJfi5+o7ektmrayx8Wfce35EFcGC+q
	ZNRwoavUumx+uSK65KE8IlXqOu1cbngYTXKSLVo3b3DaXQP3n0dgf43sGKD+0NlEBvVVaB70vEG
	wpYmc5w==
X-Google-Smtp-Source: AGHT+IE5HbSwhkBToqCqz9vEinVfEXjup+ekppXCr5pkcomNVUlkT4NeMnCZZyNvnycStxkWHREgxQ==
X-Received: by 2002:a17:906:4fca:b0:a46:cc87:12f3 with SMTP id i10-20020a1709064fca00b00a46cc8712f3mr302256ejw.75.1712177848933;
        Wed, 03 Apr 2024 13:57:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id wg1-20020a17090705c100b00a4e393b6349sm6627788ejb.5.2024.04.03.13.57.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 13:57:28 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so367191a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTfltx5n2LwsJXCY1yM/AprKHEPT14HR2J19AR6EONttcbal4WdZ75R3xM7PQj+tV0As2xP5AYPDawrwoqoYfeEFanJwDUeIGVaDTL
X-Received: by 2002:a17:907:2d8f:b0:a4e:2ad3:60ff with SMTP id
 gt15-20020a1709072d8f00b00a4e2ad360ffmr339680ejc.47.1712177847931; Wed, 03
 Apr 2024 13:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
 <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com> <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
In-Reply-To: <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 13:57:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOqTAX7nwQqHJ2Ti3dbxM-HrUJq3FD_Gjua5qW=QAoTg@mail.gmail.com>
Message-ID: <CAHk-=wiOqTAX7nwQqHJ2Ti3dbxM-HrUJq3FD_Gjua5qW=QAoTg@mail.gmail.com>
Subject: Re: user-space concurrent pipe buffer scheduler interactions
To: Michael Clark <michael@metaparadigm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 13:52, Michael Clark <michael@metaparadigm.com> wrote:
>
> On 4/4/24 05:56, Linus Torvalds wrote:
> > On Tue, 2 Apr 2024 at 13:54, Michael Clark <michael@metaparadigm.com> wrote:
> >>
> >> I am working on a low latency cross-platform concurrent pipe buffer
> >> using C11 threads and atomics.
> >
> > You will never get good performance doing spinlocks in user space
> > unless you actually tell the scheduler about the spinlocks, and have
> > some way to actually sleep on contention.
> >
> > Which I don't see you as having.
>
> We can work on this.

It's been tried.

Nobody ever found a use-case that is sufficiently convincing, but see
the write-up at

   https://lwn.net/Articles/944895/

for a pointer to at least attempts.

               Linus

