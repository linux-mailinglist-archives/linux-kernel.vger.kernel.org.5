Return-Path: <linux-kernel+bounces-57757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8184DD10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8557C286BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783486BFA0;
	Thu,  8 Feb 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AmjBv5z/"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736356BFBB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384934; cv=none; b=upx6ByQAXAz4o/IE2xXUp3+wznipt8IxuSBvtp/Js2aAQBnD6UYKZffYvweOieRhIlWNPff9tk8Z9WPkjBkgLmqcWN+fvzIWDY/PEpUxZSYbbsdAtIvo2H+vBTnE6THebSgQ69hcM/fvkI4o8QMdWyUlzSs9v7M+3++GBLfSlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384934; c=relaxed/simple;
	bh=2Ef4MXQbcx6AIgkMzRdLe/6b60bd/1WlTCA2XekqYpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpfLi6fjD1u4RwXZ7y0BgDAJJRX2WKIqZC/p9CGnumsWFWMekdR7WgIaxdfOUGrhJZpAu+jgsZChkVzm/vb6u7GM6eRe8jrkVf6C9iJycVOpfmodgY7a2XWX9CSurqvZvI/tSdmJmR4Bycp6XHBqckVLLnSniO27B+CqcZFF/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AmjBv5z/; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso878667241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707384931; x=1707989731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ef4MXQbcx6AIgkMzRdLe/6b60bd/1WlTCA2XekqYpw=;
        b=AmjBv5z/J2X+E3sIQrawqjN+1OY+sA0/+V1vtISKCGUa0zgnvTYcVAaqGxQatwL2cw
         JfdQJHMccNMv6Lgb8CSEkI7H7o8AIKrDhFK4fA+qPWpMpwNfYT+Miu/KHDjdlZgUTaNY
         7gYwaw/k4TltASFpW1h4DPqESZ7mqbuCp+POWaL9VcM4i+7FuT7y7NQs2nfr2iZEH2UT
         h28/+qBmcA/uHUufUazXdWsPLaiGjMHAFrzpICMRnumdI8+A2rqDHqqtU0gk7KcdyYOm
         dPKjMsidFnyRLpqCdS3F85CeTJ1NqrSBKSWesQ8Lmlf8GaMxDvrCaQ7oOsfygZR7epPI
         /UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384931; x=1707989731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ef4MXQbcx6AIgkMzRdLe/6b60bd/1WlTCA2XekqYpw=;
        b=fSPztxR6vByONr8aWxHcWuOF7ZHayFL4d1vb/wGgUhMaYo87vKx6M8DJJJXgtXg2QV
         ggpyGB7pcAP2NBQPjpBEX6OPnkWf07rUFrsKJMO5kAC+ds3HC3df/gWQlnGq+P8c1wAm
         9k/Beks6ZBca3jB9mznonPbHyoB/YugLoS514onzGMgO7k20A1GlxVrw7N22m7nMRc/Y
         zIEtxtkqjCxFtBQQ19GyR4I/DXdrxu/D3evJN/IZ9edlWohVY3eDGSmoHToYlxueHTnf
         nzTeAUBWWlPqcowNtTZSOSETIj0ZuvA4Yw65jOa42OVZsW6P1hJSLNCPKyqbBA9HGEyG
         GC4g==
X-Forwarded-Encrypted: i=1; AJvYcCXK1zzT94Umr5lAeAnLmczOIQa86rtOwO++XTMCwZuqUvcCFDTR44kPJ8LmSlMYR3LWEMUiy4ptoq2EFfCbYwFizZXE4N+Ej+MQNVM/
X-Gm-Message-State: AOJu0YybUUCqukETCb1Pc98/WT9FT07Yarm35N3ixLuwWDPH5qzcb/5j
	SUGsYekHzCeXLRlHq6Q5RlEgbpTWkSwTQs4PsDFEU7b8oHGpktGFqllvsRW+f4wmaTF65oft99O
	/ZutGbMGzv4ZZmn9nwffs8t0ml/SQ8obzaLrDGg==
X-Google-Smtp-Source: AGHT+IGHYkhsqhK7jdquWbdRQFNxSjng3mgHAtet6uTK6szct7lKLlpp/s4hG5ha+PgzbQ8FiACiKfNtBKdrQtsQi4s=
X-Received: by 2002:a05:6102:2f3:b0:46d:3a99:7f0 with SMTP id
 j19-20020a05610202f300b0046d3a9907f0mr6053745vsj.2.1707384931130; Thu, 08 Feb
 2024 01:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205102229.42460-1-brgl@bgdev.pl>
In-Reply-To: <20240205102229.42460-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2024 10:35:20 +0100
Message-ID: <CAMRc=MdzQ9hTo8fG09T4EZDNP9-idTYELoA2uHZYGf=OfxLtFg@mail.gmail.com>
Subject: Re: [PATCH] gpio: remove GPIO device from the list unconditionally in
 error path
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:22=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Since commit 48e1b4d369cf ("gpiolib: remove the GPIO device from the list
> when it's unregistered") we remove the GPIO device entry from the global
> list (used to order devices by their GPIO ranges) when unregistering the
> chip, not when releasing the device. It will not happen when the last
> reference is put anymore. This means, we need to remove it in error path
> in gpiochip_add_data_with_key() unconditionally, without checking if the
> device's .release() callback is set.
>
> Fixes: 48e1b4d369cf ("gpiolib: remove the GPIO device from the list when =
it's unregistered")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Queued for fixes.

Bart

