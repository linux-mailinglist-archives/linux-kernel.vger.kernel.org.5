Return-Path: <linux-kernel+bounces-40308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C255783DE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE9A2819F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AC1D54C;
	Fri, 26 Jan 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8QcMZyK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BB1D53F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284739; cv=none; b=DMMEqCSQlXXPH/OVxgghVHsH9g3+kzyBVpyEwXDX5RpeXT3D2BLlfxXzm+Y4UsSgj+WJXrpKwwPhTGAxesnFWY5kLr1yq4manOxIwqgfvS5NXGdrrLNCg3FcmSec/M5JAgJBaCtxOY9aDjRuN/6L6nNwWHp0AzuzOSjDuvGKdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284739; c=relaxed/simple;
	bh=YWkDD+P9zXOPy7HrIWKfAZv0AuLrjivBLh5euG8T+I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM4PH/6ZIRGErjgAsveugdqArejmuf6WuqqEY1yGZdO+H+0OGUQ2Z/xbU12qpevwUUsY1CMTk8vmtqqYgXQUOGVQ/bzkDADB3kO848gDD+Q41Bk2Cwr6OF5wlotNd+hWepviPmgHba9uHNJHaJ/Xw0bb6EC7FXVqzLDFI7Ytr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P8QcMZyK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a298accc440so83729566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706284735; x=1706889535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB/kmGUfsYpo5IS5Ji1QQ5HUPpqXNxhbTQeBAKirZjM=;
        b=P8QcMZyKyWZOYTjEw/5pvofCFdfC+TkY3O93UoMKqApDhLLUHCwKfAKYRrcEhDjB4N
         pqGzFKyzVDAeXreRfFDSHhFRn7tHgsYxCRvzydY9XzYCeeGqTzWKKiM+WAo/c5eGaOpI
         GhUfz0dEKfubGYe126+SCMUoPi+pvf0YG/sHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284735; x=1706889535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB/kmGUfsYpo5IS5Ji1QQ5HUPpqXNxhbTQeBAKirZjM=;
        b=vOUf/IGIhLAhwQUaN94StFaxgV3ME1DuMgZbXu/4p4wSWNrkfY2p13z3z/JSLpNkKx
         tLl7GBM4/RjkuO6c7HO5Gc90qFLFPZzTGd49OR8pGQoqW1B3PV4/eGItVF7ig4N0bZh/
         Mlc5cDENpbkT1+L5qGC6lV2cI47aa0Cl/r40Iyn61tJvVUnZ8zhak0t66Uky7R/p1Gvs
         XGJeHsPWx3LlCVO/50njp2K9B1YX/Zy9YsaXKYFeYXp+FIHn0phgRHCBISLWLIg1iR8P
         liAmE3SzUVJLqkB5eaOjk4f7EnF3p9u3Jd5a/eP0siqcuX06KemLeoHX69g8LL7vTpzl
         Vq1w==
X-Gm-Message-State: AOJu0Yzau7yOZfmN/ZmmtBX4ggg49K5HFx1YSOQ1WcsCA/sfbwJV1K83
	92sELgGsGUtvetLBft7nX+yUHHoJfXNUY9x+Y61Te5znBMK24k2Mr3jidm1zWtXdvWnRIt470XK
	RegoB
X-Google-Smtp-Source: AGHT+IFIY4XRKYzivDFm0OAMwyw4FifMdfHekc40a+eTmH0oQ4rNiQlPOKkVgQoSjg/RTRzYfHEbHA==
X-Received: by 2002:a17:906:5a87:b0:a31:7af3:f46f with SMTP id l7-20020a1709065a8700b00a317af3f46fmr1403335ejq.77.1706284735409;
        Fri, 26 Jan 2024 07:58:55 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm772797ejb.170.2024.01.26.07.58.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:58:54 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so4646a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:58:54 -0800 (PST)
X-Received: by 2002:a05:6402:b6f:b0:55c:e4da:760d with SMTP id
 cb15-20020a0564020b6f00b0055ce4da760dmr163470edb.1.1706284734205; Fri, 26 Jan
 2024 07:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
In-Reply-To: <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Jan 2024 07:58:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHiZ1VZ6bzV0P1Ns3Dapy-_q-c0ddEb3AzSLZX_AHC3A@mail.gmail.com>
Message-ID: <CAD=FV=VHiZ1VZ6bzV0P1Ns3Dapy-_q-c0ddEb3AzSLZX_AHC3A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 26, 2024 at 7:29=E2=80=AFAM Douglas Anderson <dianders@chromium=
org> wrote:
>
> In commit edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid
> tail call optimization") we marked lkdtm_HUNG_TASK() as
> __noreturn. The compiler gets unhappy if it thinks a __noreturn
> function might return, so there's a BUG_ON(1) at the end. Any human
> can see that the function won't return and the compiler can figure
> that out too. Except when it can't.
>
> The MIPS architecture defines HAVE_ARCH_BUG_ON and defines its own
> version of BUG_ON(). The MIPS version of BUG_ON() is not a macro but
> is instead an inline function. Apparently this prevents the compiler
> from realizing that the condition to BUG_ON() is constant and that the
> function will never return.
>
> Let's change the BUG_ON(1) to just BUG(), which it should have been to
> begin with. The only reason I used BUG_ON(1) to begin with was because
> I was used to using WARN_ON(1) when writing test code and WARN() and
> BUG() are oddly inconsistent in this manner. :-/
>
> Fixes: edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid tail =
call optimization")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ugh. I just realized I forgot these. Kees: hopefully you can add them...

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401262204.wUFKRYZF-lkp@int=
el.com/

-Doug

