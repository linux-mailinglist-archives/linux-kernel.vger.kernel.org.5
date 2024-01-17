Return-Path: <linux-kernel+bounces-28670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF68301A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CCDB23E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636813AF0;
	Wed, 17 Jan 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QUAN1Gvb"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9813FFB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481727; cv=none; b=mkDWeqmQ1pT7XJhBu/paBvqJSbzEQrBE22dNT/2JpuwRg+0kGvWWafq5EnPHcT5Y6Jp2rQ+n3ZHGYS1WeSWZiymeZNPbTigr+tln0LCqpn590Yhld8uPjSKUltpRKhUmXCS3jIGj2MZDeQzTmZaoF+P0cQMFSCPaqgrVJUeO0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481727; c=relaxed/simple;
	bh=aQ+6JbM5yR6kQFalamoiBcTrOt23eDME+cRfrzz+7Wc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=pY4EJYAAHRqBwJ53A/ymQs6dKyQ3m4shEeqGGU6kJfTbsZj1ZZlFfgmDrsvloTk77QqQvPX4rG42oPMNN7K2UdVT8btVim1McsMf/0pQzUNZUqj+6w+/GR7wpEQEaHnSreeLTv4qB6sXSdYW3ym06DyNjYv4PFkWJqiRkGR793Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QUAN1Gvb; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d250629e25so748250241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705481725; x=1706086525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ+6JbM5yR6kQFalamoiBcTrOt23eDME+cRfrzz+7Wc=;
        b=QUAN1GvbgLoiyZ5l8jCF0s+Nbu2G3y4btXCUvkCaUZq8GJ8Bo3iQHzZRFflEpIBWHX
         Jysv/JvROzYFCFFUd5GLqdVO0filnCSeebF8ZvXpuNn5cZBUHPXmaJZHRi6u+q4uvia4
         hReb3qx716kv1X7hjxY/LjCD4rLSrSBZx117FrBRQCPNdET5k2LIck/sgylEQsHaYaB1
         CCuVXlDcgCC3qcH4Kzmr9nTKvI0F34kfMY0X2M0CLu0ATPEc4N6yyehapQKV6sqX3oQO
         nCGD6UMNP33hvyRkU9WDNyncFuLaxcqjmZgbRNy9BG99SJV85KML2x1RbPVkfUMuXnOl
         3EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705481725; x=1706086525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ+6JbM5yR6kQFalamoiBcTrOt23eDME+cRfrzz+7Wc=;
        b=oRdJzToKRHgZlDf6YKQK94jUI/Qw0FB25NVByxO03rzJSgNedS8VAwnQgQBuZJhZ0h
         o+iVc1cnm0MObg11VcgCE3st12rve/HGH8amJgFXs8fWycw624hIsMK/E8skHItrqOug
         rWE6wklcWyqCQx2lvy7Lcbc+Yx/BjLugLmBP4E1a7TPxX8il2n3JU3aLMjlDm9hV8y7h
         gQ8AbgikV0CU+1WRNcF81fUHoDAWw1SAXM/sbBgg+AbRyNUBwvv9UvVh5PDuLVg+BNsx
         qUJWBXrDPSPzdyYRCZ3O4Ne1q/J9fx1kVkgmOJfGt0uq38hG9jgRM5MuuSda6DDySi+y
         uDIg==
X-Gm-Message-State: AOJu0Yx9uLYr2FGz0a445tIaz7skf8nT4KrOWWLVzyetYca6fIVMLhva
	VdKB8h45PcmfbVN+6htFYWEEShpFpXntT6dgCrjV5YCTWs/WfQ==
X-Google-Smtp-Source: AGHT+IES0DFHdOM86Gfrad0yRE/gG0ns3q7IesySq/UuocXs+YchPO//dRnsduZYFjqmfBLE32KcLpvyd6w/5fK9k0I=
X-Received: by 2002:ac5:cb45:0:b0:4b7:b264:b62a with SMTP id
 s5-20020ac5cb45000000b004b7b264b62amr3800364vkl.29.1705481724981; Wed, 17 Jan
 2024 00:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115111743.28512-1-brgl@bgdev.pl>
In-Reply-To: <20240115111743.28512-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Jan 2024 09:55:12 +0100
Message-ID: <CAMRc=McJEbeL-Esc5=ycNnTfQc8diQ8esgNjKDiG6rKDnT1CJA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: revert the attempt to protect the GPIO device
 list with an rwsem
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 12:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This reverts commits 1979a2807547 ("gpiolib: replace the GPIO device
> mutex with a read-write semaphore") and 65a828bab158 ("gpiolib: use
> a mutex to protect the list of GPIO devices").
>
> Unfortunately the legacy GPIO API that's still used in older code has to
> translate numbers from the global GPIO numberspace to descriptors. This
> results in a GPIO device lookup in every call to legacy functions. Some
> of those functions - like gpio_set/get_value() - can be called from
> atomic context so taking a sleeping lock that is an RW semaphore results
> in an error.
>
> We'll probably have to protect this list with SRCU.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/f7b5ff1e-8f34-4d98-a7be-b8=
26cb897dc8@moroto.mountain/
> Fixes: 1979a2807547 ("gpiolib: replace the GPIO device mutex with a read-=
write semaphore")
> Fixes: 65a828bab158 ("gpiolib: use a mutex to protect the list of GPIO de=
vices")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch queued for fixes for this merge window.

Bart

