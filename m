Return-Path: <linux-kernel+bounces-135899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510C89CCD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685FF285340
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B3146A6B;
	Mon,  8 Apr 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TiKOrn7s"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50B1465AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607062; cv=none; b=EoTRXSSlHoa8nxxFkCgWjnnEJoz+dhdVEcG3U51rPA2UrpHNEaWCbOt/IY4bsHWrJcvZXocfKLTq63Vmt5Nu7oa6nzdj9Q6yG1Q4FWF5gvOpoiijAksEkCBRVD359BMB+jkb/KcJM3vhbiix36+i9EvBtExZzkgyOArsebpz8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607062; c=relaxed/simple;
	bh=T9Axq0K/iXwEnSWdW8NNAFCF+A5jnAQA1gx3vfuBArU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe/Q74VPJmLI92s3ZVvVBI65TCxJigxZXuG6V06KDqygJwMl2lgX8mm6wkHMzY/MBUN2++OS+n7NQLKDL9Jkw5XrRWf7R/GYS3Hrtz4ALOWoJr1mvDnaPnQUpaffOY5JOP8yT53gKtLrFpvQw68XBY1Q3LVqT/zzyOq5iZCXqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TiKOrn7s; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d476d7972aso63245711fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712607058; x=1713211858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ciB+yk+sxj3WjvAOZ3AtBhLNrg4E8Qyg/edsGuYwbwE=;
        b=TiKOrn7spH/ePHJLsR6mEUJhWSHoai+QwFjNvuktLz1c7GPwlJ8pmPWDdTaUBjAo3O
         jqRVONsyznLKotfqB7M+gLE87zPB8yu4NFy8r9QEo6d8EaLuVKlYXZZBhOlxjqn9+RI2
         qmcLAMMOUkUA9k/o7UMPuNyA0C9L09PxZBc0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712607058; x=1713211858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciB+yk+sxj3WjvAOZ3AtBhLNrg4E8Qyg/edsGuYwbwE=;
        b=BjDefSa4rD567oV7GWPzWQaEG7udWGtvAr63579Jwcr8IutGyDp5RvrpPcR1c84H8k
         Vej+iEz4yhUdwG6xG+xZb11gF/MI6Jj4PSyCjWZlnutwPhehaIIZhbQEAU/UWlzYp5G2
         Lnpx9RtAtWEdZNFE38iLMrK9R5KKeefaZexyibsAoNOaXU1RyUcBrk9SptVuJE5sgiKH
         k600Y6JfoqQW/nuzClUhkRY0d/eiSMk0qz2rwi9bjQ7W8xHaI5JYyhnOdU3t/nj/7Fu9
         IKswv7sFwRFZTB3IU07EgCwETL+n/YjQhrdHlIVMqwvX3fiRrLO8pvn/B5FaB4lkGMuJ
         W5vg==
X-Forwarded-Encrypted: i=1; AJvYcCW0zwxbHMq3Fyz3aG2tAnLu7rYvLAHqK7OxWdKByCzE1/dxBD6U3e3DZHAUhfUuSGVe+vLd8VW90K+z/uuCjfrWk2Ao1Eah9V4aJclf
X-Gm-Message-State: AOJu0Ywf8N9zfPWtAiZedQGuDCLI1m5fWeFPykN9eXYrtTPFbIiInYCU
	nCnVJIvlxdUedP/r1KJX7pD/+xNqMPaZRqT5YO1rQuzzp32RvwCMesObtV8Qc7Mz2nnw//demmP
	mozuQaw==
X-Google-Smtp-Source: AGHT+IGoAM4fueC4yAweZqD/BpmChuYHeqvu03FIRY9TaVrezEFKVsQlO8rfeNZ483JNQtiUCkkA/A==
X-Received: by 2002:a2e:9a9a:0:b0:2d4:744c:24ab with SMTP id p26-20020a2e9a9a000000b002d4744c24abmr7041254lji.27.1712607058193;
        Mon, 08 Apr 2024 13:10:58 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id bg39-20020a05651c0ba700b002d814bf6618sm1293755ljb.115.2024.04.08.13.10.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:10:57 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d0162fa1so5760750e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:10:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/HbNotOU3pUzPMoLjyBgESp96EVnqSC2qoD+hmpTTJ9w0jvEUJLvOfu9Nvx7EhtaZhB7mxGcmKp/mXUVP45SKG02qYtpbhOoNGMhW
X-Received: by 2002:ac2:54bc:0:b0:516:afb5:6a71 with SMTP id
 w28-20020ac254bc000000b00516afb56a71mr6509617lfk.67.1712607057038; Mon, 08
 Apr 2024 13:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop> <20240408174944.907695-8-paulmck@kernel.org>
In-Reply-To: <20240408174944.907695-8-paulmck@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 13:10:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>
Message-ID: <CAHk-=whwbdbNXeJ0m+YZqZcxKPD3v4dbcPVCd6gP7YkwCM=X7w@mail.gmail.com>
Subject: Re: [PATCH cmpxchg 08/14] parisc: add u16 support to cmpxchg()
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 10:50, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> And get rid of manual truncation down to u8, etc. in there - the
> only reason for those is to avoid bogus warnings about constant
> truncation from sparse, and those are easy to avoid by turning
> that switch into conditional expression.

I support the use of the conditional, but why add the 16-bit case when
it turns out we don't want it after all?

                 Linus

