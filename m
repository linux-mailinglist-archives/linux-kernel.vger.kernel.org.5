Return-Path: <linux-kernel+bounces-107957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FB880414
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D7A1C22A31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87CB2745E;
	Tue, 19 Mar 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rd69+Yoc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43D23772
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871104; cv=none; b=RYv7eTWkUbk7W9BoE9jboSSEs8OiE8RlpsyVJ4HXgWfgNZuUJamtEWV+sbPa4DwJVfqbrKFsdN6EY/fAfCtoitMqsXHDpr2NwtSBWJFlJI9Xj5tww1JlndkXpw0uZ/nKXQngc0rHhLE4jr8KcIIo0i+8hSrDPKLuv/g8pbr2G1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871104; c=relaxed/simple;
	bh=8sTskcdOtVLcUoJrJXgCugdbs+vDeaj4D36P9Iiu1jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Os1vyijWMa2v2vLHcKFRSwczWFsuWbIvuU3SlEy/p9QEa+BOOvoZ5aEHcVFtwY3w2/e0mzND5vDXNugsYFev235CbG+6+c26BRo9/Kf3YltrLIg4zUwx6HtQYqcupa1kkbwKZ1LQVO/gbmmXMaSJRpkWtXw3Ph6sfYv+t1hw+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rd69+Yoc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so702688566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710871100; x=1711475900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twG2O+T6o6F/FN8MJ3T2+Oi98EiyVLX3AwSybqhHmqM=;
        b=Rd69+Yoch/DnuyBkvNiH3z52iBa/7EuZ4vQZZy4tbjaRJp3qefUf/7zWyHpuKcoFWW
         vP3lye6/9yMFwy4nnC8724UQFWu5u/OkbIf3xA4oxRpaRTrisdQaB7aFZVfK+OJjfl0Y
         fjW6wqsiCeALX8KTA1NbU3k3nxTthbT2+rmCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871100; x=1711475900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twG2O+T6o6F/FN8MJ3T2+Oi98EiyVLX3AwSybqhHmqM=;
        b=IRJxnod/dpj5PUlNkmLLz/Zn6jwDoBF1Qw/mg34uOhvhMUDiH6AjcDuUGpUWnFAGZA
         TuLsg7y8EJvGOLtAUaSYXELRpsLZVtYCN3PWQZo4n6GFE+ZteAEjqzfNf3nehcfcvBrv
         zwSPtwuH2zHq+SGEzC0uaOvqSkb8xpZZyVPnhLbVmEqwIKaGUZr8y928CuAiVv1fJlHm
         rbpwCmewuASjnvtqIz2KF+6VaE3QDRVlTR4ua+qkfeYPQcxaRaSJVIwYhsFcw6k/4S/D
         kZCvwA9nDmPmhy8O/LadPGOMgCDjxRodmebx3EA2oBEF5jYggGNzWENvkaxHYuMv6S+1
         1urA==
X-Forwarded-Encrypted: i=1; AJvYcCXUHL2KOXnnyRarkLAWxUDW9tOoxNy4ULJNl99HirSR9FKzyS+Kg0lp37RaJpY16ne4iOJy7t3hNwsdTgCJcLTkh9lo0owqXXfvtK9r
X-Gm-Message-State: AOJu0YwciiiHyAhM0GOIc1gGEwPtECg965qRTPkWovUFGEJkH2rlX56i
	DWE04UzM5ogs6GpVfgmG50s6RuqfhvyzrI1hRvDKRJffmk1udY5hIT7fjUOweU9liDb/WZtMbCp
	C61zVhQ==
X-Google-Smtp-Source: AGHT+IEFahzQin/2QwD6lta8+44sON3U82MtTORvFcuqyKM7nPbt5fRkzJPD48c4BU/RoLkMlRIfwQ==
X-Received: by 2002:a17:907:b9ce:b0:a46:be28:bb8d with SMTP id xa14-20020a170907b9ce00b00a46be28bb8dmr4834118ejc.64.1710871100319;
        Tue, 19 Mar 2024 10:58:20 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a46ce8f5e11sm1880177ejz.152.2024.03.19.10.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:58:19 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44ad785a44so702684166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:58:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDpU5+4w3lv97cdPUPYI9ngUHPtGb63VqEViDHfkyqPWhXUyyQbagW8SOte8/I1cxititrUieDfwouThxiX6pa3yM2xzS7QvbzQkCZ
X-Received: by 2002:a17:907:7e9f:b0:a45:ad00:eade with SMTP id
 qb31-20020a1709077e9f00b00a45ad00eademr12086295ejc.57.1710871099106; Tue, 19
 Mar 2024 10:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-3-glider@google.com>
In-Reply-To: <20240319163656.2100766-3-glider@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 10:58:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUf3Eqqz3PttTCBLyDKqwW2sdpeqjL+PuKtip15vDauA@mail.gmail.com>
Message-ID: <CAHk-=wiUf3Eqqz3PttTCBLyDKqwW2sdpeqjL+PuKtip15vDauA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 09:37, Alexander Potapenko <glider@google.com> wrote:
>
>         if (copy_mc_fragile_enabled) {
>                 __uaccess_begin();
> +               instrument_copy_to_user(dst, src, len);
>                 ret = copy_mc_fragile((__force void *)dst, src, len);
>                 __uaccess_end();

I'd actually prefer that instrument_copy_to_user() to be *outside* the
__uaccess_begin.

In fact, I'm a bit surprised that objtool didn't complain about it in that form.

__uaccess_begin() causes the CPU to accept kernel accesses to user
mode, and I don't think instrument_copy_to_user() has any business
actually touching user mode memory.

In fact it might be better to rename the function and change the prototype to

   instrument_src(src, len);

because you really can't sanely instrument the destination of a user
copy, but "instrument_src()" might be useful in other situations than
just user copies.

Hmm?

               Linus

