Return-Path: <linux-kernel+bounces-32395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC218835B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF89F1C2248E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43298D282;
	Mon, 22 Jan 2024 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgeDQ4pI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A07CA66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905851; cv=none; b=Im2wWVucyckzryuMmu+vbJLa2OmQFWDyWUM/OjJrH537OoV0MTgmS43Lxw1aMA1yFfBktQHNHrsuIb+CWtOc6LsHR28wq7s+HqyTp4uqsmpInwg0QmUa1mN5ZbW8mAd424haOCmn+XQP9B8mNhCn1S7HwAzRQDSTYyYAo2KiTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905851; c=relaxed/simple;
	bh=PXG7D7pO3cEeSofvUiEpo7EfpxglZFW9kTHuY80VPqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXFgdPLaXENpFVLZqpaXePXTTYdM1JcTvvXmoQKkP4+QutKsPe9WHjEu4zueYUQaMnYrF1EMUdW0q2qNWEI+RqfLV4qFuMoiETP4eYg9sha0j+8xbNwkzUhxOtIMHtm2fVHa/U33yWiC1Ls+6tlW6vaaZ+CzLzpykQPu2VUjSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgeDQ4pI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so30215231fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705905848; x=1706510648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plBekECwCrnkNSE3tEir64JnXRMMrK6QpZzhIq/r/bU=;
        b=mgeDQ4pIStB6bKJWPqXUJnwRc0Gg9k5U8woiIokdQuIFFxBMjbHA9w1zZ579LaLm4a
         s8kQ8YeOKEU24oH9OkpHFTqMEKg9PJIf+boOm9jNUwMysfiRRtsOi1/ZbnQtxSeEPYVf
         847B52daVSLbsSNkpUwyA+5OqGuzCxDK+aH0qrYtwxGrAEwijA9rANYfy/MmdeBAjLa+
         aH7hAKtcZTX0kqEc5uomIpn9rz4jlX5YGAqghRHtMr4jTN1dgMlTPd2x3qZ0whooxwS8
         WWcwhdZPNGhte/NRnFYxxtYoVZpqjLLJdL77FokaOh69gMUtlXFOUPYx1mUVNj1kNBPQ
         E2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705905848; x=1706510648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plBekECwCrnkNSE3tEir64JnXRMMrK6QpZzhIq/r/bU=;
        b=sViCygo9IVG+fsIEuE3CzlewbCWlqAj3CQUJp/Jk8XO419s1qUGdys9H9pCC+Pd7yo
         ZOyYQKR8eqV76ow3EKvSbucNPYJbu1rAXNK67fkM50MYl8ty24exkPnzJkXK09AUNhgp
         3zy2FaA0VIKOgSvjVabR6rLXNyfC4iFL/W7ewWsZ3xRAa4jf88nn8ti9Y4vgxuMaNtVa
         KwknKi8HvOeCdr6iofu30RF5Z3Ceqh1J04TZx7Fi2DWTYTcXjc29myiu6wN4q9sXJkrl
         wunht8Xz/ungQjLzFbJfIJlkpnSjm3mLp0duHOAfNdWbd2v79pVshKkbW6A/w26iPY1Y
         fuKA==
X-Gm-Message-State: AOJu0YzntA9qX7AaklrIwmqjsaV3SoN92ml4tpiv1UnblHkhbwNafIE5
	4af/7Vg04zMDpdohngM29kdYmR2bdERvFMqjR/dXknHEGlMYfdIp9TtIEEiP9ph0PQR6gxMC1FL
	Ln17wPujkymuPXddllE6uafWXtx+up2njGlJdCA==
X-Google-Smtp-Source: AGHT+IGOg1BfxsoNxvgonZ9HDzH+W3x/q6dSG2+7HqNFv843KuYAHZ+CabnoBUOd6oO7JXrShDpCzWW9ttGyYdv9Vck=
X-Received: by 2002:a05:651c:2004:b0:2cc:f163:fb6a with SMTP id
 s4-20020a05651c200400b002ccf163fb6amr1207905ljo.53.1705905848024; Sun, 21 Jan
 2024 22:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116234901.3238852-1-avagin@google.com> <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com> <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
 <87le8mfojz.ffs@tglx>
In-Reply-To: <87le8mfojz.ffs@tglx>
From: Andrei Vagin <avagin@gmail.com>
Date: Sun, 21 Jan 2024 22:43:56 -0800
Message-ID: <CANaxB-xYp6pWEPT68PJhiLog7jXx=UppSqbB6o_GeTt_SJorOQ@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrei Vagin <avagin@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:07=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Jan 17 2024 at 23:59, Andrei Vagin wrote:
> > On Wed, Jan 17, 2024 at 3:52=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >> I'm not really following the logic there.  What's the downside of taki=
ng
> >> the fault?
> >
> > Let's consider a scenario where someone messed up with an fpu state on =
a
> > signal frame.
>
> Then he can rightfully keep the pieces...
>
> > With my approach, a mistake can be promptly detected.
>
> How so? Everything which ends up at the 'setfx:' label will just
> silently fall back to FX only and init all other components.

and it will trigger the x86_fpu_xstate_check_failed tracing event.

Usually, when I want to check that our code generates sigframe fpu states
properly, I enable this event type, run tests and check that no event
has been triggered.

Plus, we have tests that check fpu register values, so they will fail if
registers are changed in unexpected values.


Thanks,
Andrei

