Return-Path: <linux-kernel+bounces-136679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0389D705
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FB1F22550
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588881AA5;
	Tue,  9 Apr 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCMlo02B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1F55E55;
	Tue,  9 Apr 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658689; cv=none; b=t1N7UP5kUsJSQNsyVBsXty4XUX/BjZL8Q4y8du/bAigPZay9P8eBLEre7Dblo+PcTKfpcauKzCnKr2VwWsQz+aUCTNq2Lt0pjX2YaoDurIEeIDFjyJbwYeereKQLiqAb+E3quzl2CIr8S8Y5pUgesFLfEyEo2kW08Q1mO7d/IcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658689; c=relaxed/simple;
	bh=95/eNQEA2hT6GJXXuLkMPQn2OkasoWu1BXdBrwzlGl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNy4aGWQvDcfnFpcQ/4egtePglLG3uSJMnkGZKzdxyh+vgZPgGP0QfD6k6OQ3ECphQ97qmi/Z4xkVpSipOGZo9zys2w2tgSiQ7HC8Wjpv5DAgPTfe4eKzag3/plEsKtC/g8ndrqgsKwxe02baiBzsRePQY3OZmcBoss3Uc+4GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCMlo02B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC0C433C7;
	Tue,  9 Apr 2024 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658688;
	bh=95/eNQEA2hT6GJXXuLkMPQn2OkasoWu1BXdBrwzlGl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCMlo02BzURuyLxdIwDM+tm84sC14IiCKw/etLEfkWoG5XTGPfhAcNwtgmsdxDopb
	 dOBmNQaH7pVfZgic9BN2s/9AYAY1XJqHi/9OSqSKBZ6+h16bNg0Ja8hPL0nikETbWk
	 yQvnepDHRjxP3xU0dDip6S9ChKKhIrZq4wigumZObFRIS0QG3n9vfLNLghTpw+3Qt+
	 2lQLSERMJCEkHKRzffBCjnxHG+0omIYX0HOk01rwRZoFyPT8AuzOBJspi+VvrZg5Wk
	 MedIFW0D57TX18j8Nu6aHI+/wP4nhckgb3DwJ1ERW+hRNkcHoGEm6x4mauog3M83EE
	 ahXNuM7XR3/9g==
Date: Tue, 9 Apr 2024 11:31:20 +0100
From: Will Deacon <will@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
Message-ID: <20240409103120.GA22557@willie-the-truck>
References: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
 <CANiq72mCzRBW7_H5Q4VQF8PGRFwaKJzQwOe8LOP2NbStz4husg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mCzRBW7_H5Q4VQF8PGRFwaKJzQwOe8LOP2NbStz4husg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 05, 2024 at 01:14:19PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 5, 2024 at 12:58 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Add flags to support the shadow call stack sanitizer, both in the
> > dynamic and non-dynamic modes.
> >
> > Right now, the compiler will emit the warning "unknown feature specified
> > for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> > passes it to the codegen backend, so the flag will work just fine. Once
> > rustc starts recognizing the flag (or provides another way to enable the
> > feature), it will stop emitting this warning. See [1] for the relevant
> > issue.
> >
> > Currently, the compiler thinks that the aarch64-unknown-none target
> > doesn't support -Zsanitizer=shadow-call-stack, so the build will fail if
> > you enable shadow call stack in non-dynamic mode. However, I still think
> > it is reasonable to add the flag now, as it will at least fail the build
> > when using an invalid configuration, until the Rust compiler is fixed to
> > list -Zsanitizer=shadow-call-stack as supported for the target. See [2]
> > for the feature request to add this.
> >
> > I have tested this change with Rust Binder on an Android device using
> > CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=+reserve-x18 flag, the
> > phone crashes immediately on boot, and with the flag, the phone appears
> > to work normally.
> >
> > This contains a TODO to add the -Zuse-sync-unwind=n flag. The flag
> > defaults to n, so it isn't a problem today, but the flag is unstable, so
> > the default could change in a future compiler release.
> >
> > Link: https://github.com/rust-lang/rust/issues/121970 [1]
> > Link: https://github.com/rust-lang/rust/issues/121972 [2]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > This patch raises the question of whether we should change the Rust
> > aarch64 support to use a custom target.json specification. If we do
> > that, then we can fix both the warning for dynamic SCS and the
> > build-failure for non-dynamic SCS without waiting for a new version of
> > rustc with the mentioned issues fixed.
> 
> If the arm64 maintainers are OK with the warning being triggered in that case:

Sorry, I meant to reply on this at the time...

> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Otherwise partially reverting to the `target.json` approach sounds good too.
> 
> I added the `-Zuse-sync-unwind=n` to the list at
> https://github.com/Rust-for-Linux/linux/issues/2. Given the default is
> what we want, I have put it in the "Good to have" section.

I think we have time to do this properly, like we did for the clang
enablement a few years ago. In hindsight, avoiding hacks for the early
toolchains back then was a really good idea because it meant we could
rely on a solid baseline set of compiler features from the start.

So, please can we fix this in rustc and just have SCS dependent on that?

Cheers,

Will

