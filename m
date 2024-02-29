Return-Path: <linux-kernel+bounces-87298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4999486D264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9E21F21D49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE994AEDE;
	Thu, 29 Feb 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aPKsceU8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EE2A8D7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231689; cv=none; b=biDtuaQUBQVuVqNrGqKf5TaQjH0g/m2aYazmEYXry/ggoSAHjwXEB9jBJ0nHqM0fuf4kXXH8jWt+x2AfD8jB6cG5G9jJXiScLVdX0cq11DATzri6E/Ctx03TGEWUGWQkIDGbDxFmbB6LE/dJgyZPL9FnispVWBXWbby6wKzI8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231689; c=relaxed/simple;
	bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O34WSQBEBOSMRCF7wfBSV7cjArunywJtmaUufGn5ZMJDIt2kPke1tZwH/ZpqI/xhq1U5VnOd41GzcyBHuZoMdBuDooF3r7IbFFDTeLMOEh/CsV7PqB25pyj7uQDpnab3aKmfvsFY2NVz/YDODR+pNkjfCJ0okSGS3Y/GRrd78g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aPKsceU8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so1870704a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231684; x=1709836484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
        b=aPKsceU8Nj47rWD2R4llx8mU73kV2xuWTY8gzVCWZhKUSfD9OTiigmAZVKVE9SEU6n
         dKPjU+w2rtdaEPpYqb+ouqb2VlBPNg2BTxX+6G+turyVfjJMU3mVhqDLpzywOx35CxxY
         9J/7/QxNzR6Fq5VR1p9oIz4z1rhCzrrr4sMJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231684; x=1709836484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
        b=vpMDJhCKP5TW6s3sHRtBT+zARjQJOHO9Z4Pa2tOMkJ6GjKuCbUz81bXExaLZxZlRGT
         3zwj0zqKUIXi4fXSmEz3fRCOxQIZNCfqysaxynh833kz86s+EevO+42TT18RQqnwqq7q
         2Mx9+3DC6aR+s4AXiIBXCrNYyGS67qH56BhekY0qHUaiIonW6i0vujq5W7HPw/sI5OD0
         PdhEH529SejGNybW6kgk8nsK5EBuKYZfoEu5akjMp2P5aF0NUXZOVcQfNw+gfFdpuS40
         uT/T/aT6thgLxNrOdR0nZrDDFhQTBxKNTAU65gLutbmvM4sXdLmAbVrfgOE+Wg6CQP6m
         pUXA==
X-Forwarded-Encrypted: i=1; AJvYcCWdffxioo9ZMlm81zDQKqrC4bVqls90Ysq9LVDF3IDny3IjMcAuzBKXnwR8imLUtH12QzARCGCYDQQXfBGpYynHINgQwej/7zvxLSEx
X-Gm-Message-State: AOJu0YzL8YxFi2FWcvTqWeCcoKQ3Gb7NYbWY8RJpjSpH9YO454jleB7P
	JZ2sbidAyZvG6gDbRDu4+vEahrD5NjNolntizDiJBL0xGKvtPbXt3DGN1cmBKLYjjHwXUDp2c6U
	on4Av
X-Google-Smtp-Source: AGHT+IGu/GPlufo9ki33d4lTUOFVzDWD98AqqPpFwockWKNT4pXzb81A6TfS+XPP4tac0Bl1vqqB0A==
X-Received: by 2002:a05:6402:348a:b0:565:9fc8:8f35 with SMTP id v10-20020a056402348a00b005659fc88f35mr2282358edc.42.1709231683898;
        Thu, 29 Feb 2024 10:34:43 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id be27-20020a0564021a3b00b0056650031d94sm829521edb.90.2024.02.29.10.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:34:42 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so9485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:34:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxWoT0nngok2qMjJ4I7KqrVoGA6AB5mOqky+EmxdItLxrETTTouZ2f8QWGh6SsrIUzhFbBLXnrZ9FxTOLO2AD6OSTILs6zfYrVbWlE
X-Received: by 2002:a05:600c:5185:b0:412:a039:945b with SMTP id
 fa5-20020a05600c518500b00412a039945bmr217511wmb.0.1709231682297; Thu, 29 Feb
 2024 10:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com> <20240228131104.GB22898@aspen.lan>
In-Reply-To: <20240228131104.GB22898@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 10:34:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>
Message-ID: <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Chen-Yu Tsai <wens@csie.org>, 
	Stephen Boyd <swboyd@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 5:11=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> > I'm still hoping to get some sort of feedback here. If people think
> > this is a terrible idea then I'll shut up now and leave well enough
> > alone, but it would be nice to actively decide and get the patch out
> > of limbo.
>
> I've read patch through a couple of times and was generally convinced by
> the "do what x86 does" argument.
>
> However until now I've always held my council since I wasn't familiar
> with these code paths and I figured it was OK for me to have no opinion
> because the first line of the description says that kgdb/kdb is 100% not
> involved in causing the problem ;-) .
>
> However today I also took a look at the HAVE_NMI architectures and there
> is no consensus between them about how to implement this: PowerPC uses
> NMI and most of the others use IRQ only, s390 special cases for the
> panic code path and acts differently compared to a normal SMP shutdown.

Thanks for taking a look! I think I just included you since long ago
you were involved in the pseudo-NMI patches. ;-)


> FWIW the x86 route was irq-only and then switching to irq-plus-nmi
> (after a short trial with NMI-only that had problems with pstore
> reliability[1]) and that approach has been in place for over
> a decade now!

Ah, interesting. I guess this isn't a problem for me at the moment
since we're not using any alternate pstore backends (ChromeOS just
does pstore to RAM), but it's good to confirm that people were facing
real issues. This matches what my gut told me: that it's nice to give
CPUs a little chance to shut down more cleanly before jamming an NMI
down their throats.


> However, if we talking ourselves into copying x86 then perhaps we should
> more accurately copy x86! Assuming I read the x86 code correctly then
> crash_smp_send_stop() will (mostly) go staight to NMI rather
> than trialling an IRQ first! That is not what is currently implemented
> in the patch for arm64.

Sure, I'm happy to change the patch to work that way, though I might
wait to get some confirmation from a maintainer that they think this
idea is worth pursuing before spending more time on it. I don't think
it would be hard to have the "crash stop" code jump straight to NMI if
that's what people want. Matching x86 here seems reasonable, though
I'd also say that my gut still says that even for crash stop we should
try to stop things cleanly before jumping to NMI. I guess I could
imagine that the code we're kexec-ing to generate the core file might
be more likely to find the hardware in a funny state if we stopped
CPUs w/ NMI vs IRQ.


-Doug

