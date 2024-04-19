Return-Path: <linux-kernel+bounces-151568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512D8AB086
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254BB1F2741A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EE12D1FE;
	Fri, 19 Apr 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZDNtZ+IO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD62AE90;
	Fri, 19 Apr 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536179; cv=none; b=QeZW6l3X/1P8ICuO+rZ8DZAUJ6Ec5GPOJHNbfXeE6U6PTyA4XXJAzyyqnUlpJJuUM2IBxMbQXWLP+pxwAJG1PUT2rToTOPPYajuXKcsJxG66X3pjZTFirbEIZuuEjsJfbWYY39YPRczekKr/O6ndPSFlPJyAICnNVW++9YDP3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536179; c=relaxed/simple;
	bh=aDOq8AI51VY95QCIf94Ybjka3okbkHuv7Gd0QpQWoRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0mVxACJt2Z22oVjJuf3vM6Vc77f5c7xUeF4JFs3q9PEv9JjF03ObVMZNK3pgBxrkbYMekSG1Fk54SB7zyb4ILXUSpl3qMXawpintsWaORNuJjIPxQDGG7r6AI912R9aTGxy/DzG+CyrH9/MH6A7qYPHnT4Sr+m+RQD2KQFT7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZDNtZ+IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0617EC072AA;
	Fri, 19 Apr 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZDNtZ+IO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713536177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF1S05FrPd7JMzVACZsai4/uJrHwnNUjUOflVfvTORs=;
	b=ZDNtZ+IOXd2MPAVVwFLpyYebfWrW9sYI+HB5ti5kfYNDenU02ppxVoDlYqoYX1Xfpu0iO7
	1wFL87ywdic8OiXL0sL9AVX+6p0Q6UGRTgBr8GqLKY1MtNND7d0lLWS5ptd2f8ilF5MvSb
	+zqN3t3nAc/EWB4hzu+oNNDSccgNons=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3de85a4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 14:16:17 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46da8ced2so1892976276.0;
        Fri, 19 Apr 2024 07:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtRWvR25fXh/V70EWQ79NgAa51wcSu9AMJLCfV/POxHPgGP9+nQswfsYSVXV8kTDDnTeye0Jw084UeGLtLXsTMWZFORxe5YxXKwl8rHQ0unToogTcmEYQ47oTGZ3MYYa1D212aR1eHfw==
X-Gm-Message-State: AOJu0Yy/DrCL+eqs6cxhkvnC6aAxiLmRHedaJuNj3FrDTGAAoeIim47x
	Q6x820TXfqwmWcKcRiIMm6v6sq0W6UrVnUxv3EH3k+trFbZy00erL5Ebkyn7578OXe5s9ZgnYWw
	8VSVlNApHkr+KjFy+l0cYy8awSQY=
X-Google-Smtp-Source: AGHT+IH/RFWYSZUXAgYM5ig+fotiAkRbeoiD8cbK0NRBvFml7NnGT1SQsnkr1jNR4iTuHbwNW8c1U6EncYMAqfLeTrw=
X-Received: by 2002:a05:6902:248b:b0:dcb:be59:25e1 with SMTP id
 ds11-20020a056902248b00b00dcbbe5925e1mr2487799ybb.30.1713536176135; Fri, 19
 Apr 2024 07:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418121249.42380-1-Jason@zx2c4.com> <20240418121249.42380-4-Jason@zx2c4.com>
 <e4cbb6ab-975a-4d91-9bde-6976b4d84eba@amazon.co.uk> <CAHmME9r8+ULD74ehz-LOpuAXb57BDFCD9Gr3Aw-JPJfTLC5OCw@mail.gmail.com>
 <e2de24bf-d154-4b11-b322-8bad7de8a0a6@linaro.org>
In-Reply-To: <e2de24bf-d154-4b11-b322-8bad7de8a0a6@linaro.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 16:16:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9qEWHb_q+BS3MvCXbOZJNcrakdZBGCm3-eyu0B6ucPZ1w@mail.gmail.com>
Message-ID: <CAHmME9qEWHb_q+BS3MvCXbOZJNcrakdZBGCm3-eyu0B6ucPZ1w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] virt: vmgenid: add support for devicetree bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh@kernel.org, tytso@mit.edu, krzk@kernel.org, 
	"Landge, Sudan" <sudanl@amazon.co.uk>, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sudanl@amazon.com, graf@amazon.com, 
	dwmw@amazon.co.uk, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:14=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/04/2024 16:02, Jason A. Donenfeld wrote:
> > Hi Rob,
> >
> > On Fri, Apr 19, 2024 at 3:30=E2=80=AFPM Landge, Sudan <sudanl@amazon.co=
uk> wrote:
> >>>   config VMGENID
> >>>          tristate "Virtual Machine Generation ID driver"
> >>>          default y
> >>> -       depends on ACPI
> >>> +       depends on ACPI || OF
> >>
> >> Version 2 of the patches had these flag but were removed in version3
> >> following the below review comment from Rob:
> >> "One of those is pretty much always enabled, so it can probably be dro=
pped."
> >> reference :
> >> https://lore.kernel.org/lkml/CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcV=
ZAqs-mXC+Q@mail.gmail.com/
> >
> > Are you sure about that? I see other drivers that depend on `ACPI ||
> > OF`, and this driver is totally useless without either disabled
> > (right?), so the dependency makes sense. I think? Not an expert in
> > this area, so I'm happy to defer to what you know is best, but I did
> > want to lightly pushback a bit.
> >
>
> There are just 18 cases, so I would argue that it's not a real pattern
> but could be just growing organically, without really thinking.
>
> The driver could still be probed on some !ACPI and !OF system via driver
> name matching.
>
> Keeping it as is seems harmless, but OTOH, if this stays, you miss ||
> COMPILE_TEST

Fair enough, I'll ditch it.

Jason

