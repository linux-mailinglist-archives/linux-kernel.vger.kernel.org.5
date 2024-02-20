Return-Path: <linux-kernel+bounces-73740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40385CA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E64282D98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F8152DF6;
	Tue, 20 Feb 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZYnkq1wc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE31C1509BC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466560; cv=none; b=mcCHvEPDCMayjCR3UdK+9MI/JDuckPT/pbzzSt43z5soyxj9P7cBAnJmTtkP1TFUBBBTNQGmMbK8/BqP1mygX3B9hzEHKxatIEsB8rUu6kDGMmWG5qhl3pfgvGvaWkAnN4edrkbt+3j3UVEpjgQTAqhIBEaRmxnofHiPI55GIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466560; c=relaxed/simple;
	bh=7PluGDCDtKu4/hPc6/QUsqMWDX/isTVfpEnm7NW272o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKJcPzVvjC1VU2oofR03DBLDlqlliqXXkqfPrmDj6hE46iamrcXr6XiFMwiP7Imp5aXTe60S17Ojcx/WQeETsAaLS+E/xvGQHFlU1K1fn/sKntE5iwgfJQ+mHXqrakjyPtzDffbzXktUph8ykGbvcpRpD9bTCvXa2rFbqI3m6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZYnkq1wc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso334621266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708466557; x=1709071357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slEeVSXDAFhjTmrDFJ456REWzWzhVL5Yf7o/aFavGTM=;
        b=ZYnkq1wcWJ/t6r6rBi4f3taQDGswEXi6GVTvqhdK++RgsjSwCnUPowMQKL3TtstBXU
         1xp7JyYE7pbpZFrXl9LU1MGXUa9n657ZTjOianiQ50VbwxjA9t7NQf+naXkP9aKBcFle
         IaPT+42FSCcgUOw5MIvQSq4X9sa7s7UhBtv3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466557; x=1709071357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slEeVSXDAFhjTmrDFJ456REWzWzhVL5Yf7o/aFavGTM=;
        b=c8aVTAuPUzSH4ymt5nY0+t/JW8eefCDHFRknPV5Cfh2gwF+haqetAKI2dBnpeCUCTU
         GoEj7CS6lNiMndzBpNQvMY92mHGYDetXg/0forfDMCaW2/d8Japc4aRxi7O44YXmcefd
         JL910xqWyYIibHUHQX/6WEEboy6UGxMjxQTlG2Qd1JMbJnWEjuFD4Da197h9r+ZcqZ9d
         K6jydUVaafvB+sM0MHC55KfBs6S3iDRG2YxcRSCJSu7oO0xLj+Rfs+YqMQ/tlH/o9n79
         bga78V/6IQsKUlFggZe88ROHRwQBz2ImlLgnIOSNZg/+KcCZlSvVOuClzPjY3nSRfBze
         o1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkNjX3RocmQLHPS20PymDIboMUI18H0ssbBI+NHAM4K8ZxIOB5zpZAvT7S2q0y/HZu5KtIUQ8xrGl3/ciVWaIhtkK8Au8F1tIlili
X-Gm-Message-State: AOJu0Yz2FzYWNFqRQt0cSMDXLIs4q4+u95UVGk5//UqQkXiktybJjMTL
	9O0lJsjCoPH0Sn9ZktqCFVrZXV7cmEzZJ9+KT9dRLbReUdzy1Mw8qLyZR7gWaBP+4F6zs8iqbBV
	q3IzUdw==
X-Google-Smtp-Source: AGHT+IGm7BchUWt439ghNLZyUw/I7p1Wm3rTFIHYBpWOgpBU1xAx4Vlr3K6QU6sCLG1AVns6WNPxIw==
X-Received: by 2002:a17:907:7ea9:b0:a3e:b57f:2b8a with SMTP id qb41-20020a1709077ea900b00a3eb57f2b8amr6412888ejc.10.1708466556774;
        Tue, 20 Feb 2024 14:02:36 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id lc26-20020a170906dffa00b00a3e7cb91865sm2785428ejc.121.2024.02.20.14.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 14:02:36 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so4541252a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:02:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5ohOY91SKAfI5CcxWmSQJbkRs1iyEgAqRd6cZCf5uJd1Sr62/yiELqyR3dM3pukIF542on9AVJw0R0an/fIWY4b9cqgc5O9yZ2DQa
X-Received: by 2002:a05:6402:2cd:b0:564:e568:d1f7 with SMTP id
 b13-20020a05640202cd00b00564e568d1f7mr1009612edx.6.1708466555950; Tue, 20 Feb
 2024 14:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net> <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
 <2374eaeb-fa34-44b9-a945-2cd871aacf7b@roeck-us.net>
In-Reply-To: <2374eaeb-fa34-44b9-a945-2cd871aacf7b@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 14:02:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaaFFoc12yqoQVcQEHN4rYTxTzd7uKgFG6Y0XzJbxpAA@mail.gmail.com>
Message-ID: <CAHk-=wgaaFFoc12yqoQVcQEHN4rYTxTzd7uKgFG6Y0XzJbxpAA@mail.gmail.com>
Subject: Re: Linux 6.8-rc5
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 13:48, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Turns out it wasn't this code, but
>
> > Now, the __moddi3() is a *bit* more reasonable, because I assume it comes from
> >
> >                  int slot = i % 3;
>
> this code.

Yeah. It's still the kernel doing silly things for no good reason, but
a compiler can certainly do a small-constant 64-bit unsigned division
without actually going to the expense of actually doing a full divide.

For example, in this case, because 1**32 mod 3 is 1, you can literally
just add the high bits together with the low bits (with carry), and do
a 32-bit modulus.

And in fact, you can then turn that 32-bit modulus into a multiply
instead, avoiding doing any expensive divide at all.

And gcc knows to do all this. I *suspect* that the failing
architectures end up not having a 32x32->64 multiply, or maybe they
just don't have a very good machine description, and that's why gcc
failed on them and just ended up doing the stupid thing.

Regardless, our kernel code was just not good.  It should be fixed now.

           Linus

