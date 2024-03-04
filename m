Return-Path: <linux-kernel+bounces-91080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85EE870955
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C42B283FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9F62170;
	Mon,  4 Mar 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGgEW9KC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F062140;
	Mon,  4 Mar 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576271; cv=none; b=EfYwJE6nf643NgMGc7HeQTKTnNMtVrXzbzk7u1KtkN3rpCJL16tBIbx6AdzmQP/fOZtRgv+U6W/fLub4PBoO7IYnaOjZ7jxE+HugydDz4AbE906J49Ft15ptmjNes8Cz+Zqu8WGVaydIrZrtrZsnHSxQdPihKcEu4nnamBAaWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576271; c=relaxed/simple;
	bh=0VcXOVEj4uX5cN19M7/PiaO2mkyA5iUM7Ie+C/DjQ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCH/a0WPB4uaxRlWP6vp8S8gnBceBZK9pcEeCNZe5IMr+YsqFFlZrUs5XraOcoW8Dpr6zu6c2pUJmefYV8ZBe3K3A4aTf3w0+0O7w1oZwYEJSrAy+nhBU9uPonYTcrMP9lE8mlaW3tmMtQUfQQsGZosJcMcQWVAop0jzlLluliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGgEW9KC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4467d570cdso485481266b.3;
        Mon, 04 Mar 2024 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709576268; x=1710181068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VcXOVEj4uX5cN19M7/PiaO2mkyA5iUM7Ie+C/DjQ/g=;
        b=BGgEW9KC+n6L2KlIkGvl+tGG7Ymt5sHRXUhzNAYExEZwZwmvgWLX43RkYp3Gg7dx5I
         e78pEfVy0iDf0+b/5bbxWErYWqQWqqtLxEUGAw3CBqfeuF33mKcwKCw/fpw2MZdmMbli
         Nqln6S+drgx6hxG29Y/30ADlMolgnfkbxVGDWusMKXVzftfbchyTG9i4IACRhYEWcDjm
         LtJK0ap6lkmFfgwgonzm34Yad2kutDOn0Gg7WQFTVehoF7Z9l+KG4e5C2xt9teBiNURm
         OIFzSOxBrKxW3TzUlWJrmRvYFcfH2hRN6Vy3wZt0VEZfuvzpLRKYaUQSZQv4cUz5VmAO
         y0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709576268; x=1710181068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VcXOVEj4uX5cN19M7/PiaO2mkyA5iUM7Ie+C/DjQ/g=;
        b=gJyPqOmp9VZgVm+N5NsGDKUeW2VJTYMAVjFYk/ypP5C955wIrwLKcupmHjdIT04+qE
         G9sj5lAJeJO5o2vw2nX13cs5usjy6DrrSS0anARRQIw8K57JuDQPnsNDoOGhJRx1sCdl
         RvR048Di079gn+WEDRz6U5SDjA6BHyIJDkelwTwOHXLWEPRAGMBnHDrpzOrjC+ZWINS1
         GdtJ75oIilMw1ttmCj9eoBScFScT324mLNvjc0wAp5UA35+W3tRg6cGzBijnW7Xd6RNT
         8qq1AVQYjU/ODLZ+kz1NQ+mglz+hEvrOfAV9HQAxNqSthi1o3kCFIpqrK56KHGKygXlA
         grxg==
X-Forwarded-Encrypted: i=1; AJvYcCVlmsfITOq3QzrEh+VPUNPvi8jFkS0hNd3nGWNUhWHScvaXwP7vWFK3LDqx4gIMFLfCxAKTgKPoB/VXhuqiCutz7hXLtyjpyd+b9Qhe6aTFmgxZtfSefl/2J1IBR0Z4umTJPWt0IQ/9NqmIwSjLLa0Op58y6+d05KMvhEZoC5O3uAu27ik=
X-Gm-Message-State: AOJu0YyHyMckGkXOxmvR5VjjpqVnifhA2jJq6LAN/ofdgUG5JJdyxYlE
	BfXKXggpGMRz6ftZ057/fKhias8sc/mMBHi0ZDwuRlAzEkpwLa8O6bbrWvZsvZYq/X+1zsI2b25
	aCf6o6qBam6CylL6x4V2EXgbLde0=
X-Google-Smtp-Source: AGHT+IH8TVrqbKPkISojymMNbutJG+3MG9Q5hp7NXKQN7l42CwKtPGnXdOghrTrfrTcx7ph0QmrrkGy8NtpHc3/FEFY=
X-Received: by 2002:a17:906:b80b:b0:a45:1c4b:54eb with SMTP id
 dv11-20020a170906b80b00b00a451c4b54ebmr3224939ejb.3.1709576267706; Mon, 04
 Mar 2024 10:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com> <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
 <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com> <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Mar 2024 20:17:11 +0200
Message-ID: <CAHp75Vfh_pv50Pk84JGz6qT=K9m3w=0_HDGX2WvqEN4Nm8fFDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Sun, Mar 3, 2024 at 9:43=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

..

> So IMHO it would be a bad idea to make the DP mandatory.

But I'm not talking about making it mandatory, I'm talking about the
DP to be used as DP when it _is_ present and wired. If current
platform wants to use DP for something else, I'm pretty much worried
that this is the right thing to do.

--=20
With Best Regards,
Andy Shevchenko

