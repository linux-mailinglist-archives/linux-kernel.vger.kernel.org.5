Return-Path: <linux-kernel+bounces-50348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7028477D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AB1C20BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E84154422;
	Fri,  2 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHeB54CF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B7152DF3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899175; cv=none; b=JUu4Ex25vTDmNsA9wILQ63nDamvbpTjD9hSCK4olHEOvFGdrGdB2rVgw7c5SH72xXGxXq3OLcdnzt+PFnW53f4I8tUpWXCnI4ItL/QLY5mtC4Yg1DuLIkJbEqMkD6oS2V8Fu6NsU4dyzjaPmch67lpNHpkb5e9Dof4jR6clB898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899175; c=relaxed/simple;
	bh=6vtu3x2Y1jccAeEZW/cOuVCyNA6GUN7mxte5g1lUOrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLKrwcO7RXxdyQ6nl+Ao7jQIAb54EIaFtuDiNLirkAu1kK8j2DcnTK7uUloz2lPNMAfHh1E6c9zulODxke/yWaxv1lIHi/mchunFj4BZIONeK0g2fc8Vb5fBj1dfQNhS4zpTrg8CtIri0n4yJVxoiDt6i472FaZy+OSNu77HXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHeB54CF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eac018059so2971130e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706899171; x=1707503971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EK/oD0i1K4QS8LEPg1LGpWmJwJIYuOve/SpbccIVK8M=;
        b=IHeB54CFUk2Pu6lD2GAj8loMeIw5OHB3CUVpXRt/zRmhwMpktRKIlzjd0TGGAQWQCQ
         Lys1/NvYHNrxHr/aZc2m9O3yaQERM66FEpZEHbGHLGv08Q+OTc1a3JnBUak8NXPz8o2O
         EhC2n2Bt+Kf0bkekEtuOGGOMSb0/k+M0stkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899171; x=1707503971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK/oD0i1K4QS8LEPg1LGpWmJwJIYuOve/SpbccIVK8M=;
        b=PuZPu2H8nO/AcPaT0NErDrkgJczOKCbTc06ya+6J5JaLiVNaC6W5c3vp8MXeNrO+YT
         om15WGvZnZVR4M9WPCHCS5/J1V1oYPhXG5THhPxdkWXjTWZ+Bi3N+QPc6CH4Q0I4NDSg
         BSrF78YC+HJcSeN7Ushsc3qtHs8yOB7tw/lw27nQ3bdL2OMyITfVjKlQ3P/0zQIrvq//
         cKUP7y3CIeu4vzhinJ71t7XkJeEAM8qVfyIfn8AQem5wddfobrYuh3R1O3129ViAtsro
         bQ2O0BPUvWiUnZNwg7vFjfRI7Kht8QR5iUcd4xWeoR/hFN5yxya3u/29Lam8RFfCOd18
         IZlQ==
X-Gm-Message-State: AOJu0Yx7/lnFuB7uHLZ3I2vnxtZnoLaIDTPMoHOh23EZRvqO2wMJcx6O
	XJtnk6ufXw9kyCMLLiGDoGuD+w4gJxxCavvZjlwZXzHZSYiNBFHaGY2jFpJ8P8kyaY47d5h+DIo
	GHObDmg==
X-Google-Smtp-Source: AGHT+IGxajK4aCpy+yzgUd/THPbj+f2Y2QftwFKv+71/V+HmlJdJ1EK1DI2w7veGfawczdljy6aGxA==
X-Received: by 2002:ac2:562f:0:b0:511:1ed7:61b9 with SMTP id b15-20020ac2562f000000b005111ed761b9mr1861797lff.39.1706899170774;
        Fri, 02 Feb 2024 10:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPXntYQMr8umIjPTygZH1M4yVhzpd23xnwEJXrruV0ncs9ypiNg+4IxTwxvySETchukT+OUJJnwHrDwWRMXQkWwQ5go9706VHg4XXJ
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id dw12-20020a0565122c8c00b005113dfe177asm62646lfb.304.2024.02.02.10.39.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:39:30 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d07ffa0a9cso15353791fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:39:30 -0800 (PST)
X-Received: by 2002:a2e:8882:0:b0:2d0:8225:919d with SMTP id
 k2-20020a2e8882000000b002d08225919dmr1794857lji.21.1706899169784; Fri, 02 Feb
 2024 10:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 10:39:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Message-ID: <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 04:30, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>       ptrace: Introduce exception_ip arch hook
>       MIPS: Clear Cause.BD in instruction_pointer_set
>       mm/memory: Use exception ip to search exception tables

Just to clarify: does that second patch fix the problem that
__isa_exception_epc() does a __get_user()?

Because that mm/memory.c use of "exception_ip()" most definitely
cannot take a page fault.

So if MIPS cannot do that whole exception IP thing without potentially
touching user space, I do worry that we might just have to add a

   #ifndef __MIPS__

around this all.

Possibly somehow limited to just the microMIPS/MIPS16e case in Kconfig instead?

            Linus

