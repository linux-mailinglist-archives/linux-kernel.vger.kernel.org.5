Return-Path: <linux-kernel+bounces-47034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5F844847
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C30B1C228E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E643EA96;
	Wed, 31 Jan 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/dFGNq0"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C93EA76
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730688; cv=none; b=FT5saKFaRwXjxQoSfTaThBhrARp4xE5GGyjlVL/87qOC0NeZR6viG6qQ3/f4ZNZZZ07rUM56NDpsfJrMcJSJ/P1XC0bi79qSgBjtflQpJEuWeVJ164qIspNZOAjToVSs/EFpar4Az9vZ5SxyNTibQcTmpjFBjoeVkqB2oE5HiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730688; c=relaxed/simple;
	bh=8ZnEORlLbsizKlPFacpTEd7KUr01nxGRz1weMm3NKU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8I9F7keTSFL25oSCN6tBqr//1KI2bYrEpbcgtxvXs6GFdRXCdGjjg9nReGFJ/q9Pg+kYiVVPr3lOc8p3jyMIZ2eCSGhCevknsed/vb8KFEJDvmSsWqlsbPPgBXE+CymWnUIfWzMjW4Rh5PAaVQ/UpHyZ4Zj/hcjV8tdW5dVCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/dFGNq0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6040e7ebf33so1086017b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706730686; x=1707335486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZWFUz0qVhfYcOd6k65WaS5iTo9NPz5WXjPmrZMzV94=;
        b=T/dFGNq0WcdpJ8au0TejcD/HB7cCpK/wY7Hh9ihq3CYW/CeF/VEzqE0hnh82x/775/
         ve/FgS+ZFl5lqOSDbsJ9xHiAy8SjOF08IbmH4kML/Fi/9b972bjVhj3Ir9P78jlRlqwB
         LqFXt8gBcH24MLVofYOhHWQuM9GnkYJCXkiPEvlm7dfTz5PEunlEZxR+e9MKczcIgvzI
         pigD8UXOES3mkzgR69IuikmtiL14yAkMa814mPQgJX2PqP4mIRu3C8POd1oVBLTtA40M
         nDQSPMHczkEF/ZYP2X5dJBmHxLpyOZ1DmbutK5EImqdEPOXGH8lETAwqLeVQgqH05Ixm
         rR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730686; x=1707335486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZWFUz0qVhfYcOd6k65WaS5iTo9NPz5WXjPmrZMzV94=;
        b=b5fu/PJt+/X3/zhnj+wlOlGy21XQ0whyH3KcQHlUHRxK5j8POGNuFtuZUq11TllIbi
         EwiTKxEepPsw4xuQatAv0tsYn5h6ZCNR/eNnHgF8+V4YxcK7NpHr4QSdUwFz8sJhHGc/
         4jVa8JfiPhOfpfmUZmyQQ/+IQKyx8ypOmYD+ZFi82YhQuZH9ixmdJfHVInC5GToaAcCr
         eVcZ7+kgApGVYgUXlDAovVf4aU57lPpPE+qaDElGMliHE8o/UAivQC1RjrLUqPZT1kF7
         pkLnTBB/FKv1PIpuQOEiDOZYTs1BForGkXQd8gXthU7rcCoP64Q4zncSD/VFA85RM+cI
         07ng==
X-Gm-Message-State: AOJu0YyZKDWycedC4OMJEJSS9aqtr09bFO5O5VhC1hKXZbZumJzvHVFY
	9XBv1VRtmODO60CGU1RmhFdlSqoxwyNFDBoBi5Xe7gC13vW/ayZJ1HrmTgRO/i6h02JLTfdlWF+
	Q9+FsAtEEwKnjgtx4QqECMdU1/9i4IUkZ372erg==
X-Google-Smtp-Source: AGHT+IGs/NmCuCnWWnRTFZmUjiYjl0D9360SAO7l1FGiKCPViEqEv3tl91ectKTgOG2KW8co04hic15sCAz9DuoRn/A=
X-Received: by 2002:a81:a0c3:0:b0:604:fd3:e656 with SMTP id
 x186-20020a81a0c3000000b006040fd3e656mr1407309ywg.19.1706730685631; Wed, 31
 Jan 2024 11:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-10-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-10-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 20:51:14 +0100
Message-ID: <CACRpkdY8v2x6VzRnEV6baa4_XLGLm0BOe6Nj6wzjujHxqEDHVA@mail.gmail.com>
Subject: Re: [PATCH 09/22] gpio: remove gpio_lock
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
> The "multi-function" gpio_lock is pretty much useless with how it's used
> in GPIOLIB currently. Because many GPIO API calls can be called from all
> contexts but may also call into sleeping driver callbacks, there are
> many places with utterly broken workarounds like yielding the lock to
> call a possibly sleeping function and then re-acquiring it again without
> taking into account that the protected state may have changed.
>
> It was also used to protect several unrelated things: like individual
> descriptors AND the GPIO device list. We now serialize access to these
> two with SRCU and so can finally remove the spinlock.
>
> There is of course the question of consistency of lockless access to
> GPIO descriptors. Because we only support exclusive access to GPIOs
> (officially anyway, I'm looking at you broken
> GPIOD_FLAGS_BIT_NONEXCLUSIVE bit...) and the API contract with providers
> does not guarantee serialization, it's enough to ensure we cannot
> accidentally dereference an invalid pointer and that the state we present
> to both users and providers remains consistent. To achieve that: read the
> flags field atomically except for a few special cases. Read their current
> value before executing callback code and use this value for any subsequen=
t
> logic. Modifying the flags depends on the particular use-case and can
> differ. For instance: when requesting a GPIO, we need to set the
> REQUESTED bit immediately so that the next user trying to request the
> same line sees -EBUSY.
>
> While at it: the allocations that used GFP_ATOMIC until this point can
> now switch to GFP_KERNEL.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(I'm sorry about NONEXCLUSIVE, let's see what we can do about it...)

> @@ -578,6 +577,9 @@ int gpiod_export(struct gpio_desc *desc, bool directi=
on_may_change)
>                 return -EINVAL;
>         }
>
> +       if (!test_and_set_bit(FLAG_EXPORT, &desc->flags))
> +               return -EPERM;

This exit early split off from the big if() below (which is good) is
a new thing right? Maybe mention this in the commit message?

> -/* gpio_lock prevents conflicts during gpio_desc[] table updates.
> - * While any GPIO is requested, its gpio_chip is not removable;
> - * each GPIO's "requested" flag serves as a lock and refcount.
> - */
> -DEFINE_SPINLOCK(gpio_lock);

GOOD RIDDANCE.

> -               /* FIXME: make this GFP_KERNEL once the spinlock is out. =
*/
> -               new =3D kstrdup_const(label, GFP_ATOMIC);
> +               new =3D kstrdup_const(label, GFP_KERNEL);

And all of this is neat as well.

Someone might complain about splitting that in a separate patch,
but not me because I don't care so much about such processy
things. (The patchset is already split enough as it is.)

Yours,
Linus Walleij

