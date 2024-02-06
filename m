Return-Path: <linux-kernel+bounces-55560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07684BE22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818371F21D87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881A1B7F7;
	Tue,  6 Feb 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQxRxUAO"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D91B7E4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247908; cv=none; b=ATOoOHGi5OPpcEqb044uJe6kcsdXT4ZQ10nb9gRCrbJtr2+KzkWW4YpRBUbHVaOVVLv9IP8asGaWnw6aP3Se9q2psB3sJM+vLrP430DBKlgImoHgMhJYKpv1SIV3FnQO4wOx8Mte5NtofNywITxnWpXZZtrfCtY2F9P1UkUzWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247908; c=relaxed/simple;
	bh=NKR4aZ+1Z4Kd23EQJqsQ+eYPAT0hE3eFyHO5J2onJwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzeb5gvnDHZG1heXuL8vsdJmlAOsdY1zrgpFElHfKT52H6m8mq/IUO2YZcdJW7BR5kyx7ZhsEYxHJI3LdjbzKP8iM03aVCtXsTDw37Zimb7ch7gbcZzmugBzVChk3TzHmiozd1bKjHnUKeX94bvOvedyWvtK1Rcg2+zMVtqGlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gQxRxUAO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d07ffa0a9cso54564341fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707247902; x=1707852702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKR4aZ+1Z4Kd23EQJqsQ+eYPAT0hE3eFyHO5J2onJwI=;
        b=gQxRxUAOrVqo72vLPFR+xIkxp5kijn+Cc32TKlFdRYQ59XKXNImuswtYOx1VMT+y8Q
         HB9LwqaprwmtH50CVw+5ghqU001EsSSQDt0zm3TkRCyZ56mgR0AzibTRsh/KdCQQqnkp
         vHFctuGn4atBgav6Abw1lb7E2oTGkHwgJRF7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247902; x=1707852702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKR4aZ+1Z4Kd23EQJqsQ+eYPAT0hE3eFyHO5J2onJwI=;
        b=GY3dQhPcAIf8xSWoNa5OXSGwcJ1edI5wrvAkG7UpzHxbjjBkrIqVZbfvMSLv9h/XON
         ZcpaZykQAR0k+yYbhQLGaYkQSQyl3hkRggWZkl08YjL9mT4RblQio2E6O2KK2KEL/9kF
         znVm0EcMWhOyPlcpgiTPcOfd98Q4CpSWhRp2zDG+NoNTI5kDDT5w+S9MlXtZj9Y6n757
         VfrC1nfZTZE18JezFsBRAFXGH6VlmmmQ7PM+x3YenewUyMIsHjRLlF5KWeXByB4qrP5o
         P9GndrU4lTsIgjr4AYT3c9FNKPb7b1mkvsANtRjiQBMFYKBX3k+9HgCxAbRX6U6aHkig
         S90g==
X-Gm-Message-State: AOJu0YwyTR0XpHylQ22lnEiTjrYyJ5TvKQM/zMpMjb+tyMZ2pBN70VrE
	u9le6P4euwTWm1ixvs0fEG+bDxbVkJJ7i/VBTVsy8+//e/WZ3mW6RVn5BMQeLz5jtNI04W+oC2F
	jcg==
X-Google-Smtp-Source: AGHT+IEnolejXohNKl53cJP7NvaN/uMOLONTsaPUGy408dipbnNStwyvvRk+9eQ+vb326HQbPP4adw==
X-Received: by 2002:a05:651c:1a24:b0:2d0:a469:8a55 with SMTP id by36-20020a05651c1a2400b002d0a4698a55mr3279159ljb.0.1707247902651;
        Tue, 06 Feb 2024 11:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgrKZMnQ41ioQzsaPQf//s+IWBQjUCA3kQAZieyuQxg+NQ8jCEdk16ngCcVQnZzEOPfx0taISeTVR9YYcWU7LPESmGUsFSuvvJk++A
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id i38-20020a0564020f2600b00560c43b48f4sm246549eda.10.2024.02.06.11.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:31:42 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so11605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:31:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcdjQrRZDChOi+msO+0nXnaqnF/q0+8Ywzj5ltoGTou25+EB65oegpeRlGRg6PLaQYg4Gmuoxg2THnTYggb/qiqOVDVCuffga5nRSo
X-Received: by 2002:a05:600c:5188:b0:40f:e6f6:f9da with SMTP id
 fa8-20020a05600c518800b0040fe6f6f9damr23508wmb.3.1707247901136; Tue, 06 Feb
 2024 11:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220211640.2023645-1-dianders@chromium.org>
 <ZcIGKU8sxti38Kok@alley> <87ttmlan1d.fsf@jogness.linutronix.de>
In-Reply-To: <87ttmlan1d.fsf@jogness.linutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2024 11:31:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UBOiuJ=e0t0UTr0P7rCf6CnpD8RmEVz3wc8pfjvRqj8Q@mail.gmail.com>
Message-ID: <CAD=FV=UBOiuJ=e0t0UTr0P7rCf6CnpD8RmEVz3wc8pfjvRqj8Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] watchdog: Better handling of concurrent lockups
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Li Zhe <lizhe.67@bytedance.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Lecopzer Chen <lecopzer.chen@mediatek.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 2:46=E2=80=AFAM John Ogness <john.ogness@linutronix.=
de> wrote:
>
> On 2024-02-06, Petr Mladek <pmladek@suse.com> wrote:
> > I have just got an idea how to make printk_cpu_sync_get_irqsave()
> > less error prone for deadlock on the panic() CPU. The idea is
> > to ignore the lock or give up locking after a timeout on
> > the panic CPU.
>
> This idea is out of scope for this series. But it is something we should
> think about. The issue has always been a possible problem in panic().

One thing to be at least a little cognizant of is how this interacts
with the 10 second timeout in nmi_trigger_cpumask_backtrace(), which
we can hit twice in some of the lockup reports since we first trace
the locked CPU and then the rest. Ideally we don't hit that timeout
lots, except that on arm64 if you don't have pseudo-NMI turned on then
it's actually pretty easy to hit the timeout when you've got a
hard-locked CPU. Probably that 10 second timeout should be
shortened...

-Doug

