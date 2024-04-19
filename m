Return-Path: <linux-kernel+bounces-151763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E78AB394
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299591C211CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8990136E13;
	Fri, 19 Apr 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+YXP2Mx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A3136678
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545222; cv=none; b=lxuc79b+9qr1AGNWpHAXosqLgRejCiA8pIC/ZomR46pVGfmlvUwEH/x3T1O0vSBMf2hQH1UWdSbqZsxw9CG+LdCM0ve7XqckNhbXbStnhJ1Cv7Z0qhZsuL+NcPKtLnVFPm9nLlosK7rxczddsLbmkxNcaejaRwfEd310+R51mIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545222; c=relaxed/simple;
	bh=XlVHXmoOoZJBxQK11P4e0G5gKO3J4n/iNHjCxcHwO6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oa6FxQk5I//H4HkFkx0GKZUDGgroLbyw+pjqiTwz2wSGz7PJe6DjfHQBYovaMuLVz207+dXWb572frSMC5ASCqSgGMQNixH9g1Roxa2ZUYtfyOc/5U5E6kfX4L9aD3FfCCjatzkmVJXBxDwyFa77McTmjgHTFg24Jb86mmlePsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+YXP2Mx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso4155682276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713545220; x=1714150020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgTuoKjvUJwd1St1Ysaygwu9RtHx37o8FxEW9+VLH3g=;
        b=A+YXP2MxlMlVxYSeS2g4hUJF7OfTdb2OCi0vElncwMhiBYObPyX/jCE799XN0fj08m
         3QQatMxIKXR6o2a7Lv7AZDolFTm5ZSgzxRyXqsM8Cqzj9p9T34ttiJdtvOof4+CTlYlL
         WVzLGBrOB5eRlULiPVugaGXKSDcpHavZ9jgZPhmR7E5Rps9LjXFpNhGNRdcb2IfQbfc/
         6i5U/68tz407tr43dHvbRAXGwAxaaRGvZU8pSjF60vNu8sU5+8KAIgKHvJCCwiPNFDyb
         qvbC3x0tqZsb7NrGy3XNMFB6XOtfN0RvszIGaFU4BdpQXNgn1dm53pZfA4JDygZUwcah
         B41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545220; x=1714150020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgTuoKjvUJwd1St1Ysaygwu9RtHx37o8FxEW9+VLH3g=;
        b=YmvUKt8+XNwGRss9r3ih2Z9LN/hlT9RS7eH1UWe97Uzc7AgFr3SHBtBnN/g+IY7IXv
         jORVFYROpSnOp5NoiYs04ziXN/HDSN1alNuKJ3eQuCMLGjpm1225RgHWkotHam7aKSNg
         OCOGqYBCNy8NjAzRR10CYE6aMxO5oU3C+F4jFZu0WuF0EHf7ZKRmC5RBgdzQaaRVFtfS
         tQVxHehIVGkoGKd3mS/EYP/8D2A4cWtaa8c0rJHReEAd22E1IgrqmBQtCAGfkhg9N6Ce
         +SxcueaMVjMAzV0pERJvXVdKl1vwNuf43jDpa4dtAi30GfwnkbsDeTQ9cZ/+R3ksNTPE
         Ei/w==
X-Forwarded-Encrypted: i=1; AJvYcCXyYPvFXkoXVfgEtqxy6Mw6URDAL9gXcOFMTcwV9nFT4ttNf4TGxNBFOcHcAuOiakBxCbgLTc11hFqYeRMbBPAHD3jRxbWSzJPLOcfp
X-Gm-Message-State: AOJu0Yws0IZN77FqSCOMcO2d8zoM5jxT+nyYc7LMN8fNReU/OwfH7vkW
	DnEQsEbHp1du/G/r7nMUCo8pCFUUOGJZFiJbdT9zQA5aYAjUqLKYzqkJtP380owC6+ul8nxMXpR
	loA==
X-Google-Smtp-Source: AGHT+IEqtJfIduJTupbfqjBE9B2dlDnnPdooK4NRFkzB0/8yaymYtyvWQGRlDH5P7p5wxJRE79mU11H50oQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6908:0:b0:de1:21b4:76a5 with SMTP id
 e8-20020a256908000000b00de121b476a5mr160741ybc.13.1713545220035; Fri, 19 Apr
 2024 09:47:00 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:46:58 -0700
In-Reply-To: <20240419160537.namt5yaxhhvwwa3r@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417001507.2264512-1-seanjc@google.com> <20240417001507.2264512-2-seanjc@google.com>
 <20240419160537.namt5yaxhhvwwa3r@treble>
Message-ID: <ZiKgAh1aNBGHpOof@google.com>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86 architectures
From: Sean Christopherson <seanjc@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Josh Poimboeuf wrote:
> On Tue, Apr 16, 2024 at 05:15:06PM -0700, Sean Christopherson wrote:
> > Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
> > mitigations are enabled by default, and force it on for all architectures
> > except x86.  A recent commit to turn mitigations off by default if
> > SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
> > completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
> > 
> > Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
> > code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
> > ends up being defined twice, and the default behavior would likely depend
> > on the arbitrary include order (if the two definitions diverged).
> > 
> > Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
> > architectures, and manually turned off, but there is no way to unselect a
> > Kconfig.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> > Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> It seems confusing to have two config options which have very similar
> names and similar purposes (with subtle differences depending on the
> arch).
> 
> How about we instead just get rid of the x86-specific
> SPECULATION_MITIGATIONS and replace it with a menu which depends on
> CPU_MITIGATIONS:

Huh, didn't realize that was possible.

I agree that having two things for the same thing is confusing, though Boris'
idea to do s/SPECULATION_MITIGATIONS/X86_CPU_MITIGATIONS would help a fair bit
on that front.

My only hesitation is that x86's menu and the common config knob end up in
completely different locations.  And AFAICT, the parser doesn't allow sourcing
menu entires from a different file:

  init/Kconfig:1959: 'menu' in different file than 'menu'

e.g. we can't declare the menuconfig in common code and then include arch
definitions.

Regardless of whether or not we shuffle things around, CPU_MITIGATIONS really
should be in init/Kconfig, not drivers/base/Kconfig, e.g. so that if we make it
a user-selectable option, it shows up under "General setup" instead of being
buried two layers deep in drivers.

That makes it less hard to find CPU_MITIGATIONS, but I still find it cumbersome
to have to enable CPU_MITIGATIONS, and then go hunting for x86's menu.

