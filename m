Return-Path: <linux-kernel+bounces-117149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA0488A7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357BC1FA049F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C2446D9;
	Mon, 25 Mar 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WY/AsTSe"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F54CB54
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373518; cv=none; b=PTxmHiiQjRQRzDs0WrmhwUtqzKutch9PCQv8FmqUtJQliSMLgKw6TwDl1DdJLPt1oZCqpGUfU9YZUG0V5Od3QCxxNl6C9oIpUqyBqmhSmbU2BVNUBgzxEEKRg/sKdioW0o3BGZHcMPrAf/2xP8ngPHqnta2hLpIV28lcrPAq9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373518; c=relaxed/simple;
	bh=Noq9HJ+sO7FD5O4+z0BIm08ek7Wa19Uq39LkX/oIuTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JngMddQ1FKlkZokDXehO4d3BdpoNzE+7dk0WyfFuhTfG7PFquY+OElzYGfW8/ns+Y5rVYgstIBVdvd5vDfL24hOYwxSpubsf1duc2LlXACRAEuPBBvf7ZrSGa6iNPa98OZhmtUDKIItEFLqQ16NCVg2GmOeStTBFGqUnUXGRmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WY/AsTSe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso4163515276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711373516; x=1711978316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjrucB3wBbhQAMSDiYU110V4Jry+ELeXdh9amzt/biA=;
        b=WY/AsTSeQv4Fmk7STSmBBvYrNa4tiyMrMwMaDjk6316K0lJgcITZWk0udGfkPaFy/Y
         bER5v541q6lDkrXFASVu8MmgqKKC8RUEmsLVvV7Eip5QgvJjOI7r9JGwliXH37UgGdM3
         u0pn+2MKXPTzwqfxo0MHTDcbLmMZ8esKqFk1HE/Kj07zkgZkb9jeWLGlV8HxcfO8JgA+
         QAWwNCgn0N07CVhS2qvBdMfixiuouFLI59sEVOZ60sh1ukYR1qlP6LeIhWwTv5GRT55p
         wE1PtKFrP73TLEwOj1HJhS/AOVWkhfr75NsGqmvCO+POb9kcwt7jDC0ITxHPPfSxDMMG
         2Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373516; x=1711978316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjrucB3wBbhQAMSDiYU110V4Jry+ELeXdh9amzt/biA=;
        b=NqoEcjU+q00R+SE/+9d44YekcIdOD8Rj38YqkL4b+/do007IzVNBgc9fGXQQGudNv6
         YMIix7UK/SCPYnVASN5I3xQqEXS04M+P7teYzTXdR/tyIay0Bmlnsr1NR5bG74ieIxPZ
         mdsrh/zraCBO0aN7sNN21TbYXtFoSDLykVEIizVOziNdhGzwuWpILAHpPShOYzW++Dov
         BIw+YE4w1ULnPDTthEJumUNXE4AZfh+qc8Zvu1E0jp8v2AjoY4BDZysnYncnKeOMZ6Zf
         9W7iGy7vA7a2Ifh7cCXvVvzxKXjULoqYtQgI2sglG0RpRqltoqW13dFZCtJ2EDtGLYeY
         LFVw==
X-Forwarded-Encrypted: i=1; AJvYcCXkSIXP7mk9DhGEh5QPAVRIq+q8kKkSgzYQXRBbtuLJ5MWMvydKD30okTMkGD3aykuIZzLZYic4lSrIQ0hxiT1vyUPnnd/+1PJkX2p7
X-Gm-Message-State: AOJu0YySC/JpBqXdUjxu7nUdF6Agt+pu5/sA/xGFd+AQ4/UP4APlN/5F
	R6oZ5itng4dKzTXfSkIB7LhycZYXCx9wKMkJwCgP7+ui2dvknhsEss+H07MuLdlGG/8ySt2UiBI
	SbL2qowGN+CcBJGUCGa7Ef9zjTGCwGQv+dLDgjw==
X-Google-Smtp-Source: AGHT+IGj6hFj+6hUHwZFUxLS2kHoykDs/3o9qNXuHqkCWNbjVZC4rBcQ0W0UfjSVWc+jUK5Dl4JqkVCqyHnunibXQV0=
X-Received: by 2002:a25:c582:0:b0:d80:68d1:b826 with SMTP id
 v124-20020a25c582000000b00d8068d1b826mr4994709ybe.6.1711373515809; Mon, 25
 Mar 2024 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12417336.O9o76ZdvQC@kreacher>
In-Reply-To: <12417336.O9o76ZdvQC@kreacher>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Mar 2024 14:31:45 +0100
Message-ID: <CACRpkdayWiVskunN-YeYzS7dd6ZGHmqiTbCyWQKvOG91S04Dzw@mail.gmail.com>
Subject: Re: [PATCH v1] irq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Francisco Ayala Le Brun <francisco@videowindow.eu>, Mario Limonciello <mario.limonciello@amd.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is a problem when a driver requests a shared IRQ line to run
> a threaded handler on it without IRQF_ONESHOT set if that flag has
> been set already for the IRQ in question by somebody else.  Namely,
> the request fails which usually leads to a probe failure even though
> the driver might have worked just fine with IRQF_ONESHOT, but it does
> not want to use it by default.  Currently, the only way to handle this
> is to try to request the IRQ without IRQF_ONESHOT, but with
> IRQF_PROBE_SHARED set and if this fails, try again with IRQF_ONESHOT
> set.  However, this is a bit cumbersome and not very clean.
>
> When commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler
> for SCI") switched over the ACPI subsystem to using a threaded interrupt
> handler for the SCI, it had to use IRQF_ONESHOT for it because that's
> required due to the way the SCI handler works (it needs to walk all of
> the enabled GPEs before IRQ line can be unmasked).  The SCI IRQ line is
> not shared with other users very often due to the SCI handling overhead,
> but on sone systems it is shared and when the other user of it attempts
> to install a threaded handler, a flags mismatch related to IRQF_ONESHOT
> may occur.  As it turned out, that happened to the pinctrl-amd driver
> and so commit 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the
> interrupt request") attempted to address the issue by adding
> IRQF_ONESHOT to the interrupt flags in that driver, but this is now
> causing an IRQF_ONESHOT-related mismatch to occur on another system
> which cannot boot as a result of it.
>
> Clearly, pinctrl-amd can work with IRQF_ONESHOT if need be, but it
> should not set that flag by default, so it needs a way to indicate that
> to the IRQ subsystem.
>
> To that end, introdcuce a new interrupt flag, IRQF_COND_ONESHOT, which
> will only have effect when the IRQ line is shared and IRQF_ONESHOT has
> been set for it already, in which case it will be promoted to the
> latter.
>
> This is sufficient for drivers sharing the IRQ line with the SCI as it
> is requested by the ACPI subsystem before any drivers are probed, so
> they will always see IRQF_ONESHOT set for the IRQ in question.
>
> Closes: https://lore.kernel.org/lkml/CAN-StX1HqWqi+YW=3Dt+V52-38Mfp5fAz7Y=
Hx4aH-CQjgyNiKx3g@mail.gmail.com/
> Fixes: 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt req=
uest")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Reported-by: Francisco Ayala Le Brun <francisco@videowindow.eu>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> -#if !defined(CONFIG_GENERIC_IRQ_PROBE)
> +#if !defined(CONFIG_GENERIC_IRQ_PROBE)

Is that some whitespace fix? Not that it matters to me, so:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect that Thomas want to apply this one.

Yours,
Linus Walleij

