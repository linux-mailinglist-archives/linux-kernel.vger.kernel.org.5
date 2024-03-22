Return-Path: <linux-kernel+bounces-111648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEE886F06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43F1B23CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D248781;
	Fri, 22 Mar 2024 14:49:43 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB747F59;
	Fri, 22 Mar 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118983; cv=none; b=aib259MBXKB8LCtvBvVH90CGQjzMx3OZsYH5swcqiHc2ddW9v6of7faiUGwiLmrHr5mM61E3aCoC+5CCzhD2vwrDqGPfVHxhOJJwmTzSEz/UdbN7ALyb9mtLm+LUxfnPkZRswdd/y7DdobVzi4QS53pX8UohnrIMlfPsM/otESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118983; c=relaxed/simple;
	bh=x1rELB/Uz9Fbcjbsx1Oq+znV+D9W3R2Wrq7JrFWjea0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyLUpyqRkEQySq3pTIsJOjvxzTqZqq4voeaudR6xINdmx2cA3ipW3YUcGh9uz2kTMFjpXTAh6p7aNB1rgY+J35W3ciUGwTdpmMb9CFlEEiVP8+wyf2f33n59Euq/idP2wQIUXE1Bjk3wJoLFssrEyvDWgDsOQaeHlujsGyLuss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3c005cfd0so215b6e.0;
        Fri, 22 Mar 2024 07:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118981; x=1711723781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1rELB/Uz9Fbcjbsx1Oq+znV+D9W3R2Wrq7JrFWjea0=;
        b=dqYMsbhEqTnY6FgmNt9r7b7hXPAzmVh7L0UCPf8BiSYR6AGKIgPv/GHDlToX3uKp+h
         lAZF6zSxZ/sIdRN2EylhKfIBb6oluTBOw/06EErE8zPPX5XQfHPawOptwmf/3OVMCZGq
         MtK2AciZ9u6FJjAERn56SCcevoCZbd2Bo3JgMbBj6730FoW712VoBbQBGpRPCJup/9ih
         sycPFFegFYp5Ai5WbyfHJwjI46RyeeM4v6RRhGOXY2NUDS6YM663TOnaHFVQEfTVixa4
         TTXh+bHzF3ASWPupBpe9BfRZ5oY+VI3yw4Hzp0sKWqKBCrXf8qsEqB8VmbeT+FzEeK5B
         srHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYHbk/3p07H0WRLIQo2n49IqKhQF71+7AjRMwx+f0O0FzQWvTy2n/0trhIsjsZtpx5Itilsy/sbeiKxQypnX+38Qy6P7xjWA6A+Map1dKxRmNgU8f0wavnoJqFSHZTnl+l2yX+CLjC0fvl4w8wDj6+Q0R6nXj6n0iecOqJEplNSQtwsw==
X-Gm-Message-State: AOJu0YxFJ4HbpZyEFy/ds+AqJT5jYhfOtNRkJrTCuvl3mfyUSh73LKD4
	WALhqf7ZnJFw1z3A4aa3gKPBA0Gx0JuIGlOHNdk71xmpWjT7QTz/6Z4Ky6piFe/8kMtDOy2kwmc
	5MJhiLte4yoNm9lxabSB7oceAcQA=
X-Google-Smtp-Source: AGHT+IEHtTjrXSbHZUmtNdvKKQrFMO8MXrSdLKSFqUHVsFyFEZLRCAxRwhWK8XOlsDTP7yCvdQzGK6AiX2i5rhkQC3M=
X-Received: by 2002:a05:6808:1887:b0:3c3:badd:b804 with SMTP id
 bi7-20020a056808188700b003c3baddb804mr1545581oib.2.1711118980722; Fri, 22 Mar
 2024 07:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com> <5767438.DvuYhMxLoT@kreacher>
 <5770245.DvuYhMxLoT@kreacher> <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
In-Reply-To: <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Mar 2024 15:49:29 +0100
Message-ID: <CAJZ5v0hgWGWneAgqCxZ2L85nrM_7J7H1g042sA5tzz234BNUGw@mail.gmail.com>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Francisco Ayala Le Brun <francisco@videowindow.eu>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:28=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Thu, Mar 21, 2024 at 5:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
>
> > We actually can get away without defining a new IRQ flag, as in
> > the patch below.
> >
> > It is not super-clean, but should do the work.
> >
> > Linus, what do you think?
>
> Uhhh I rather not, the other approach will cover the invariably recurring
> instances of this, it will not be the last time we see something like thi=
s.

I'm not actually sure how likely this is.

The ACPI SCI is generally heavy-wieght, so it is not shared very often
(and I believe that there is a particular reason for sharing it with a
GPIO chip) and this very well may be an exception.

> We need tglx input on this, I could merge the patch below with some
> big TODO to fix it properly if the discussion about the proper solution
> takes too much time.
>
> But I rather not hack around with IRQs without tglx (or marcz, but he
> got overloaded) input.

Fair enough.

I guess I'll post the first patch with a proper changelog next week
and we'll see.

Thanks!

