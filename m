Return-Path: <linux-kernel+bounces-164732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAD8B81D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AF71C21B89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA101A38F0;
	Tue, 30 Apr 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXTR2xva"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575512C819
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511756; cv=none; b=WWvDJgPSNWpMoFa8mlW9igfY5m7ER7zfF6ox07xniWeC6Wjwj0KU2Oo62cEYKtb3t8Z0Hmsgj9NGlEmDWkYAO9ZAS8np8qGbI5V5yVZ7RGfGZCUpsy0tR/px7univ0nyflO8hHjS7ErdsXMdype6TOgfNptLFGkiiwFuctyUrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511756; c=relaxed/simple;
	bh=XQKlbJsQcaAkcPsjQz8sjCihNDTs2E45cJWg1QLYlE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFioCtf+Y+eTY7YMeQkeJ+DBv7XysqKkEHfAUz7hQYcswAw+2267OcWSgkkCUoo1jdDl4iXjQxzWpLTDym53RsEjzZtgNYDHVecYj3t8oPOWMDzT9SBCiboHDGJNJf9BW4gisQ02B19X7DjvuKcGPsChVryZeV42i7XVG38UL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EXTR2xva; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eab16c8d83so50256295ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714511755; x=1715116555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybsFpX0X7CRfB780REANsMjNyYm7Y9wsUjgmwPZjU6k=;
        b=EXTR2xvaXynfQqWNm7DVyLsKMXpR8la8gDIIvWpMFBAVGnpc0XEkTAwVA1f9+LOSLp
         xqnNrx+qoWPh2j/Ts6L7obxPN7rg7HmABG0pcA+8rBN15R83VCCDp4/LvWBlYdtMlP+a
         hSYritZqmSUXd1RNDjj0dsXxgWKT2HULYzfro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714511755; x=1715116555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybsFpX0X7CRfB780REANsMjNyYm7Y9wsUjgmwPZjU6k=;
        b=w9sgpdne3DhYUoewD5ZXNMMvFbmdqwL8mJeGzy11BYuxkoeyUcQ/UgK+ZenDYkJzTQ
         l2te8ADe2Xi0DYRXKezpYUiockuEUIHeTxcEI59Qw86OCE9ZF6CrcPWoLqxGnzonf2pJ
         YEWGmFoJsBhcpOb56uDVMW7e0fv297o4cAxOnZy124agdJXiU9636gq0IkJ1LoO8IULr
         nnN90Jhif1KmoZoFuqA7tWAd1zQXwvESoiosWY7PlqCEqFqqdzzauRt4aBxsT0oNVcCB
         MHg3IwUX0dVdSlv0FaZ55V2In7pJw62n0j9ZnJFMDvv4E09T8khukW8/mbaZ+xJlOht7
         P3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXkByO7cUmhSUCd6VGiDfkjnx2mdS0019aZiWG7UCiDckeAX9iKaMzvBMEa3OorD1X2oyW+jo9Xxf/ewuS3irdQiebVtQwwNyUtnZTA
X-Gm-Message-State: AOJu0Yxjf7pGii4+oO2DMMu8Ucd2XB9iOBw/PMVO0fbAA1r8pcTB/qOb
	pTI+bOJz0Kgm+agdKjvLPt1Ireyu1uLThoBzgjAMd+3CprqyHo/KxyfVLoJfxQ==
X-Google-Smtp-Source: AGHT+IH65fhAB52q5SRM6fEv53OUPrvdI7HGuP4UMAsLKQOmSK4SnZFW69AZXJZQZh3NFJXh2vI83Q==
X-Received: by 2002:a17:902:82c9:b0:1ea:42d1:1421 with SMTP id u9-20020a17090282c900b001ea42d11421mr548705plz.68.1714511754804;
        Tue, 30 Apr 2024 14:15:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm22879566pll.249.2024.04.30.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:15:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:15:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404301409.D3BC98D5@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
 <202404301037.9E34D4811@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404301037.9E34D4811@keescook>

On Tue, Apr 30, 2024 at 10:48:36AM -0700, Kees Cook wrote:
> On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> > 
> > > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> > >   it isn't as secure as straight KCFI.)
> > 
> > Oi ?
> 
> Same objection I always had[1]: moving the check into the destination
> means attacks with control over executable memory contents can just omit
> the check.
> 
> But now that I went to go look I see 0c3e806ec0f9 ("x86/cfi: Add boot
> time hash randomization") is only enabled under FINEIBT... seems better
> if that were always enabled...

And FINEIBT actually can't be disabled... :|

And as it turns out CFI_CLANG doesn't work at all on v6.9...

[    0.587220] no CFI hash found at: __call_sites+0x339a8/0x34450 ffffffffac20cef8 00 00 00 00 00
[    0.588226] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:1182 __apply_fineibt+0x7a9/0x820
..
[    0.619220] SMP alternatives: Something went horribly wrong trying to rewrite the CFI implementation.
*hang*



-- 
Kees Cook

