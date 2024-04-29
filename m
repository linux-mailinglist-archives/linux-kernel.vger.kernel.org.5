Return-Path: <linux-kernel+bounces-162594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8128B5DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612C11C21D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1081AA2;
	Mon, 29 Apr 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DHUUMOVt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99A7BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404781; cv=none; b=mNyWKKCpjLOiSzTbjPzwFhHhDrSbhmNhQF4MteWX/easxAq5LdmxKUTK4d5HLxjERjvR+nY24D0GyliwVHFocumEvbYhgg2ooS2GaQo5cdG21OmSWTK17Xu93nAc+I6ORzeB7S4q3hsPZqWr9BfATH7/5NDAXajXnoB+t6BSj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404781; c=relaxed/simple;
	bh=wDxA9I9+VmVVSI9BroVzQWlSN5RXJEUSc5DnHUzQWGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRO/+LPQOrQGuBi/ksLB+o+hciKt/aihZlC+LQic9uhoI5vmBTtFeuGEp0Imh690+Vek+1X41u5CzyUS1Ov4FIB34Q7HYjgJAdAIhvgczOtO7oF3lO9ZUXmULwAxnhlkQAZvBBCG1xM/3WOA7JbJQ/KC4kNdeSqiUnJgg5cK2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DHUUMOVt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58c89bda70so388134666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714404777; x=1715009577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8YJLjrLtk5N3O9qDCOgLkM7hm+XAZ4QGYxxZrlDK20=;
        b=DHUUMOVtK5sWyfMohMF8oYVp2cRIN+8yptDQo9Tnv/wKjzOAqovy6ZLXlNt0wtfHm6
         kyt0k+t+IQs786MWtRjyKff4rHU2S3Qft3AokPoTkhQ7heYk5Tfrsxhsva6MwmvA4ATz
         HfXuPa5hfqoeeDOwcy0GO5sUEBD2XFfErd3hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404777; x=1715009577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8YJLjrLtk5N3O9qDCOgLkM7hm+XAZ4QGYxxZrlDK20=;
        b=L75hlpwCMZ/5PuqXYXZxL++UfUoA0J87heNa0bA7UVVyGzxGFNuxRWvMMe2RJIjbFd
         QhMxhzvrWOmA4Ni9modWatHvFUuqobKAtvKNZ9qHrcM9ThrlF/LbBTrGEgJ/Dj9DwU+e
         M6OYbG055Ygkx4smgnvEqQEtRPmluDd0m5wXdyTYWVdMjORn1SofRz6Hg6SjWf47OjzF
         38cIx3pkrCb811cLYDwv5JUHiVVvWdmOziiQ4EKiyY/Z7RSuCBzVoxjEQCGEL6w4OhSk
         VcA5wllVm1HAcrJMiWJcjpR1hpRUa+++MHmWzWvZCDCgO3QgpiO6aiCEUgQksiG4pCIn
         5SDA==
X-Gm-Message-State: AOJu0YxpA4mBv59SGJOTxHwAvWDhaFpkYpMUEUJlub9JAktj8OdxAG90
	NdNFFRs72apSvsC742m+zz3xXkDQIeOAAj+un26Nwue3AyyPy+AKE+JobMgBK/ptggXKhmdbbse
	Z62bogg==
X-Google-Smtp-Source: AGHT+IG7Zn172TezdjbML23ZVcjV6Ku8PkW1lem7ykhZnxa41DiF14Hyrj8h3jr2bsiOHz1Clu0dtQ==
X-Received: by 2002:a17:906:dfc5:b0:a58:bd1b:a05f with SMTP id jt5-20020a170906dfc500b00a58bd1ba05fmr7343465ejc.68.1714404777390;
        Mon, 29 Apr 2024 08:32:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id wt8-20020a170906ee8800b00a55ac292b66sm10271117ejb.219.2024.04.29.08.32.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:32:56 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55b3d57277so556715866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:32:56 -0700 (PDT)
X-Received: by 2002:a17:906:12c1:b0:a55:3707:781d with SMTP id
 l1-20020a17090612c100b00a553707781dmr6533136ejb.73.1714404776259; Mon, 29 Apr
 2024 08:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429144807.3012361-1-willy@infradead.org>
In-Reply-To: <20240429144807.3012361-1-willy@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 08:32:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEMvpPLrzsi6BoH=o+-ScRKuuqxrdWSnrTtGEi=JvcNA@mail.gmail.com>
Message-ID: <CAHk-=whEMvpPLrzsi6BoH=o+-ScRKuuqxrdWSnrTtGEi=JvcNA@mail.gmail.com>
Subject: Re: [PATCH] bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	=?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7QstC+0YHQtdC70L7Qsg==?= <m.novosyolov@rosalinux.ru>, 
	=?UTF-8?B?0JjQu9GM0YTQsNGCINCT0LDQv9GC0YDQsNGF0LzQsNC90L7Qsg==?= <i.gaptrakhmanov@rosalinux.ru>, 
	stable@vger.kernel.org, Rik van Riel <riel@surriel.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 07:48, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> bits_per() rounds up to the next power of two when passed a power of
> two.  This causes crashes on some machines and configurations.

Bah. Your patch is *still* wrong, because bits_per() thinks you need
one bit for a zero value, so when you do

        bits_per(CONFIG_NR_CPUS - 1)

and some insane person has enabled SMP and managed to set
CONFIG_NR_CPUS to 1, the math is *still* broken.

The right thing to do is

        order_base_2(CONFIG_NR_CPUS)

and 'bits_per()' should be avoided, having completely crazy semantics
(you can tell how almost all users actually do "x-1" as the argument).

We should probably get rid of that horrid bits_per(() entirely.

I applied your patch with that fixed (which admittedly make it all
*my* patch, but applying it as yours just to get the changelog).

               Linus

