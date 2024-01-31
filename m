Return-Path: <linux-kernel+bounces-46678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6384428F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D799C1C24EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707212AAC0;
	Wed, 31 Jan 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrbaMlF/"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859712A14D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713315; cv=none; b=oV4btj4ZCLh0pHlNdWWSJh3FcjvFxBcbSp9840KjpoERosrUuwNepmDwBfcxzdvIs/Qwky6G7pnn+jCMoHtAtU3NuIRf6K9nJpZwpssnWkU3QwcOVrxPZXjWlljigFVj/bJuN1jlCPh/7IZBUCBhcL9KSga1vTHttQyuF6at0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713315; c=relaxed/simple;
	bh=xJgiomH/cxhNerklilkmo8Jkr30cyTGtYIstcEbnxwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paPQHjpsEK3HV7GCPCdpMJLopyO0tV9f+6JI6pIH4k88mOiUFELL6SVhXV/an8veUKNc5GdaCEsrJqU8FpC2C0rfXZKAKDQZgHhQo4kkWKkKxHb927m28YdR2In+UF7XkDfi3Tv0UCbPYvN5gp53geZq72ezTeiNXQO4L9zG0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrbaMlF/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so5183330276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706713313; x=1707318113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJgiomH/cxhNerklilkmo8Jkr30cyTGtYIstcEbnxwI=;
        b=KrbaMlF//G6hmQx4cZpWswyDatjoEljWjUg+WbI41nmM1NgeXskmHV01TBv6dceIoR
         BuH7BbxtebIhYOe7Q+qb29jseht6htGJMnUfgj0941kmQqrf/pdPRGvGC1YU/hK5Ka3h
         zdt+U0C4xvqjK3bFJL9/rT89FN32DiK/maQ8u+fFy9WE+9tmSGHV4O1mgKS3TcC5CSB9
         YYkrrjU78MHOpXUZ3l07Yi3a41aCiNhpbjm+53IOq7/NEVy1p/M/cwLkhioEq/Tb4P+e
         3pGfNMxIZlltnB66QCXalWjSiDh6GH7cjqczJx8mHMwWcHWXmcLcPppdEvf6DI8hsMFE
         TQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713313; x=1707318113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJgiomH/cxhNerklilkmo8Jkr30cyTGtYIstcEbnxwI=;
        b=KeUkvsCWBwX/MI1daWfLBKgIR1XPLz6vPdzgxlh6sZ5O6pTYaH0K2G5vVHD/YfwTBA
         F8m6Act5gaSaOR/tFmB1VHxgBzMA7Xm3+kzTtb0yMV7bjvQuLmc3daWi4KKq6vLbhxqB
         sA9zBIfSkPLQN4GF4AhC9X+Grkjl7wgLuL5kCSInwnkkUiQuOLG9N7B9AhS1h69XqaC8
         225epYQhaYfrFwC6GxnWKpxWl/nvAJvia4KSzZUw38xqilWCEAGGp6wz9UymAZcXf9DC
         umPRbZOYIS51y58q2wOf86fFqbPFstUloCZ3eDDDK27NC2uEavjWkTfp/w7BOp5wQ13O
         n31w==
X-Gm-Message-State: AOJu0YzsAv8nGdIDbT4lPEqR4BPgSGo5/qNjpjy22IACr8H8icNRwlf7
	vCLNIKGw2wlUjqCNHYJ8AOAlEQF2RGF1Ti1I9kG39lAe9yIg0BYpHcIFHQv20eawX40iUkPIHqR
	s5rClNPTmLvX9wNCk1DgNT4L7Yeysqa9QHv7QAw==
X-Google-Smtp-Source: AGHT+IGo/UNwy31dC2Km16vUlIHGiZR7sTpkb7DK4U/zHc/wAur+SRYdormF4CI++5+D4jBsjAgBxPkhsTfW9ODgY9Q=
X-Received: by 2002:a25:790d:0:b0:dbe:ac3a:9d07 with SMTP id
 u13-20020a25790d000000b00dbeac3a9d07mr2023767ybc.1.1706713312776; Wed, 31 Jan
 2024 07:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-2-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 16:01:40 +0100
Message-ID: <CACRpkdbJOqmPH8T2_MAbNHWVboudDNXpCPc8OpLzB8z20axxfQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] gpio: protect the list of GPIO devices with SRCU
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're working towards removing the "multi-function" GPIO spinlock that's
> implemented terribly wrong. We tried using an RW-semaphore to protect
> the list of GPIO devices but it turned out that we still have old code
> using legacy GPIO calls that need to translate the global GPIO number to
> the address of the associated descriptor and - to that end - traverse
> the list while holding the lock. If we change the spinlock to a sleeping
> lock then we'll end up with "scheduling while atomic" bugs.
>
> Let's allow lockless traversal of the list using SRCU and only use the
> mutex when modyfing the list.
>
> While at it: let's protect the period between when we start the lookup
> and when we finally request the descriptor (increasing the reference
> count of the GPIO device) with the SRCU read lock.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This looks to be doing the right thing to my RCU-untrained eye, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

