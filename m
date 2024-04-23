Return-Path: <linux-kernel+bounces-156024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9088AFCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66EB1F24CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5774D58E;
	Tue, 23 Apr 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TbOyZxd0"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9913D994
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915443; cv=none; b=fmnmTUdtt3r9XiK1IFIL+eCuFcbq8b2UZpUtnu5ISqRPY8zD6Ogw8M0BDq8ckfKP9cn1agzpxg6cnkgjblbNTY6K+Iot3GmoDD5XmAPwFfIOS5QSLQ577Rshks34bdn10yWTjIR9wQCRtocSIdypixZbMZVEptDj4oDbbtD9byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915443; c=relaxed/simple;
	bh=ikZqLASnUD5BrgYBEPLKj4B+w5S2wpgaP0n66J2xSLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNCQ3Z1Ga8c70vrmMaTalRpexDJm6o11p8V2XLoCSz3H/41UFAezidm4vuAvopdwNd8cO5gSHjKQVGfzv0VmSDPX1zlJwIzp1cey/CpFh9Wdej+db2sOuecFWW1pAOLxfkEHwLPmSLvldhiubKWWn5sd3Qkg75wxk/Jhg2zM1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TbOyZxd0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a559928f46so4125091a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713915440; x=1714520240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oQOmoluKhr1R+Ar7Ae5lF+M+nWQtjuLiRMks0qxRaQ=;
        b=TbOyZxd0DIOwoJYNva6LaAnVLo8TsbjNSYE7DqvtJH31OL9GRPJwjPMRrze7KQc3ji
         3B80BDYlX1/EvruWnFHOE/9W3K3HIOXYDGkbnCI+P6hMVBiDLvqCrYUYYUEdzsc4YT1i
         EFEteQCKRGz/85lendmGr7fv2qz+xprb83vSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713915440; x=1714520240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oQOmoluKhr1R+Ar7Ae5lF+M+nWQtjuLiRMks0qxRaQ=;
        b=ZcfjoHX3NCac3Vg1P67/5X6ZVrw2bgqHGlkMfvOSmR6q6cAYz8+w2pE5/YedZ3Vt+y
         k6HMFPz+7sPnhrMeT8IutzdiSXK5IXCD4EepiYtJzyjO6tzJn6dDVTKlt/HpM9m+h25O
         Em9Jf40XC3jQYl7Gue3PvwJ0ncJk+ax213QOciICppjjWj2NK7H+Fjo+nuPGkDUbefSM
         RuABUl7tPgw/td0SxsVR/e4C/QA7M87dyQhmffEfGKOldnQ/4GIlBkZ7QbzygtS5oDZW
         QO4miBwRZA8yJzEeN2jdfHgsqEVcmjZ+CQWMnAEN6Aqhz+aUUe6dOjElVfgfC7VhZ/L7
         IZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9JbcE5yQ7GuclTo7QKEUZwFQ1muN6F7mOknThmpjA0dsMibQ/6jszy812TqnmvOGawsJg7evhhgDsTh+k+iL0vhnohdMAgYWUwRvE
X-Gm-Message-State: AOJu0YzEIZJ8UgJCtKvmlW9no6F1fXPN3w7LLPwUO2acMOvN7HYj5GCC
	zGERsWnyZ0INrYO/5VCAFNCt5qfF/RXCL19yeNAfvqrMCvGfaSQVIR4Vx9XT8g==
X-Google-Smtp-Source: AGHT+IHDkobZHch1s5O+S0fUWwcd6UP6yxod9NgVQHFZPNzzaoj/pjZPW5c+t940wYewU3d9rnZJkQ==
X-Received: by 2002:a17:90a:100f:b0:2a2:97ce:24f5 with SMTP id b15-20020a17090a100f00b002a297ce24f5mr823646pja.35.1713915439966;
        Tue, 23 Apr 2024 16:37:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a718800b002a2e6152f55sm11740139pjk.25.2024.04.23.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 16:37:18 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:37:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <202404231630.20B2693D@keescook>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <Zigj-lY5lnBSKuib@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zigj-lY5lnBSKuib@boqun-archlinux>

On Tue, Apr 23, 2024 at 02:11:22PM -0700, Boqun Feng wrote:
> On Thu, Apr 11, 2024 at 04:08:01PM -0700, Boqun Feng wrote:
> > Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> > normal substraction may be compiled as an overflow checking and panic
> > if overflow happens:
> > 
> >         subq    %rsi, %rdi
> >         jo      .LBB0_2
> >         movq    %rdi, %rax
> >         retq
> > .LBB0_2:
> >         pushq   %rax
> >         leaq    str.0(%rip), %rdi
> >         leaq    .L__unnamed_1(%rip), %rdx
> >         movl    $33, %esi
> >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> > 
> > although overflow detection is nice to have, however this makes
> > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> > clear that the overflow checking is helpful, since for example, the
> > current binder usage[1] doesn't have the checking.
> > 
> 
> Ping. Thomas, John and Stepthen. Could you take a look at this, and the
> discussion between Miguel and me? The key question is the behavior when
> ktime_sub() hits a overflow, I think. Thanks!
> 
> (Cc Kees as well)

While working on the signed (and unsigned) integer overflow sanitizer
support on the C side for the kernel, I've also run into timekeeping
being a questionable area[1]. I *think* from what I can tell, it's always
expected to have wrapping behavior.

Can we define the type itself to be wrapping? (This has been my plan on
the C side, but we're still waiting on a finalized implementation of the
"wraps" attribute.[2])

-Kees

[1] This is strictly WIP, as I think fixing the _types_ is going to be
    the more sustainable solution, but you can see some of what I was
    poking at:
    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/overflow/enable-unsigned-sanitizer&id=284464817a59b14f00d397bfbf1bf05683ed2f58
[2] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

