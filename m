Return-Path: <linux-kernel+bounces-91014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DEB870878
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C09C1F20B68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD78612FF;
	Mon,  4 Mar 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWAlWxKh"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB26612D8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574104; cv=none; b=aG+NGcnXDUQvZH4euRUBsmRKsuShoGi0vrEWudyuNmWOJZcNMUlQwAwo6k/rXcd+HAIu4NTk/f1sXV0Svh5XpqfNpgN5J1h20e5cMippnQT36CFhORqAwB2Wdbz0/GmfON0C/LDAOgkjOyI6nZw4NDfxRzgW9kq8rUwff3ZMowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574104; c=relaxed/simple;
	bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZclY7NpaESZ29u47FYQTtcfZxGU1rghhewr18m4AKnt/yRwviATFQrPPWD66X1YrKnvyVscCdoznCUdEXumWRKG6IsDxnGOl70TL7Fr/3M2YXS9Rp8u0Kw65pwzDVEUHjJ8kWQkqXg8lBgItmLWIJyyiXKprsDk4w8WEmcauGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JWAlWxKh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7882d713f6fso37341485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574101; x=1710178901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
        b=JWAlWxKhQQqe6DVlZgMygQiOkn25ZUUpEnGBECt7yNdl0SSNMac2jbFKUlyX16uueu
         6FZmJZH8Y8Pm2cjEuiO1TooTt1de/jWjSoJbsBaCJ4ucKWgRNpv1WWjZAUnRvZ4f2oy0
         PNC7CwKJkQFG1fSbQhiEdroOPMwuKmsygoflo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574101; x=1710178901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
        b=YX01rBpcKtJw6OmUC5h5AiXOBgefYHMDSVtmIrIul3cP3TMFwi82fCZBkOH297kTrI
         Up/d3Euhli89zkNxB8SQYgWLKactVJghyPgtPozSPpbfQ2Or0u/19lOC75zt6AQAFUj3
         1qQczYk3XL5cBQ/OChaOtJGTBtAgqIjUzS727fiX9qMucVeQHgc1aImViFtMs4pGxydX
         TCLM8XLgwxgn5HrX/WLSd38Jf511yvXccbAIilVgufafbPPMCJY65ZnUSEDunSC2f+Yk
         dvGV4dxZZsyENb8VyMpCIq62ULpj0oE46frAkP+AkuJ/Kan1xJEF8r+50BCpU6fGTgTw
         iGYw==
X-Forwarded-Encrypted: i=1; AJvYcCW7k3R0qx7UKiGOhLZD5VWcrCD7y4urHPUfvAtuI8RrkpxFEgVKTcfDuiU+etJMd402Q2OP9o/fNsNfnPPTDMPV6qHGFJPKXg6cSbTo
X-Gm-Message-State: AOJu0YxbkjMLGgbbUNhjb/HQcvww7Q0qqY0vDe9Phd9rsAq2AKUiLScQ
	7oYu05KWducHZ2cjADlpcMXXeeNkZet/UvNpZMx5ySPvE4K7LLOvrCJgYl3XTuMbCdM1haAG7q1
	8SXBK
X-Google-Smtp-Source: AGHT+IHh8RdTdgbReobl1pk1/aqOI9U6Q7tpR1zU/kPD1OZnUGo0RNVmE776cMFxS8a7mzvuKh0qZQ==
X-Received: by 2002:a05:620a:810:b0:788:2a7d:c5a4 with SMTP id s16-20020a05620a081000b007882a7dc5a4mr2845269qks.78.1709574101376;
        Mon, 04 Mar 2024 09:41:41 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x16-20020a05620a0ed000b00787b95c91d3sm4589051qkm.62.2024.03.04.09.41.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:41:41 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso8774e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:41:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBHrTHLv/i4poJlp3hZ3K8oeBas/ju3wl7CtVO6BfTywGVfi58a+oiuNx2mBNdIjeXZN2Q0I/uE+GmvVsjO07nNsl6zBvaBtfsCNld
X-Received: by 2002:a05:600c:4f07:b0:412:d6be:a32b with SMTP id
 l7-20020a05600c4f0700b00412d6bea32bmr2093wmq.6.1709573676220; Mon, 04 Mar
 2024 09:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com> <ZeH81_k6TFk7W4tm@FVFF77S0Q05N>
In-Reply-To: <ZeH81_k6TFk7W4tm@FVFF77S0Q05N>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 09:34:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJhvVO7k0hhz_KPH4eSrJQdb+k2CJQeCAP40+PYAdDBg@mail.gmail.com>
Message-ID: <CAD=FV=XJhvVO7k0hhz_KPH4eSrJQdb+k2CJQeCAP40+PYAdDBg@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 1, 2024 at 8:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Doug,
>
> On Tue, Feb 27, 2024 at 04:57:31PM -0800, Doug Anderson wrote:
> > On Mon, Jan 8, 2024 at 4:54=E2=80=AFPM Doug Anderson <dianders@chromium=
org> wrote:
> > > On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chr=
omium.org> wrote:
>
> > > The sound of crickets is overwhelming. ;-) Does anyone have any
> > > comments here? Is this a terrible idea? Is this the best idea you've
> > > heard all year (it's only been 8 days, so maybe)? Is this great but
> > > the implementation is lacking (at best)? Do you hate that this waits
> > > for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
> > >
> > > Aside from the weirdness of a processor being killed while holding th=
e
> > > console lock, it does seem beneficial to give IRQs at least a little
> > > time to finish before killing a processor. I don't have any other
> > > explicit examples, but I could just imagine that things might be a
> > > little more orderly in such a case...
> >
> > I'm still hoping to get some sort of feedback here. If people think
> > this is a terrible idea then I'll shut up now and leave well enough
> > alone, but it would be nice to actively decide and get the patch out
> > of limbo.
> >
> > FWIW the serial console dumping issue that originally inspired me to
> > track this down has been worked around at least well enough to not
> > spew garbage in my console. See commit 9e957a155005 ("serial:
> > qcom-geni: Don't cancel/abort if we can't get the port lock"). It's
> > still a little awkward because we'll be running fully lockless during
> > panic time, but it seems to work...
>
> This is on my list of things to look into, but I haven't had the chance t=
o go
> through it in detail.
>
> From a high level, I think this sounds reasonable; I just want to make su=
re
> this doesn't lead to any new surprises...

Sounds good. For now I'll snooze this for another 2 months and if I
haven't heard from you then I'll pester you again. There's no crazy
hurry, I was just hoping for some sort of decision one way or the
other. For now I'll hold off on changing things to match x86 exactly
until I get your take on it too.

-Doug

