Return-Path: <linux-kernel+bounces-152273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2A8ABBB5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97441F21366
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9751D680;
	Sat, 20 Apr 2024 13:17:48 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F0625;
	Sat, 20 Apr 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713619068; cv=none; b=ShK2qfgEUDWknBIMRTutfXkjwpS53ay5OYqg3h6dsI/psPuzx58OBAegAF4ioid/SziBTxbAAFkfQGiG5xuGjfEQ5nghA0lOmlybf8XKKTkD6cYKe0ZDuZjpOsHSDiKnXtl7EagQIvtoWU9IMfRv7nqX4fdcO/38HSplt2LX2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713619068; c=relaxed/simple;
	bh=yL8ZhRG0Ar7ldeDWJNAdGEOh990mBiFNV9/rkXw7Hnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHiDdqMDBOqap6SfTcIKZNRZj7dx57TqClJ5lvuksrmMZ6i9NJ0y+soO0enLBIUaeLTAUfRsXf7KrS+88t7AYe/TzQf++Ct2GlZgjJJQo/B1cvj3f8bRDiKw/tOvui53on+4MkYRmCvUFi05Z4ni1/D6t8OkrSosbSTyWgYWfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DE3C40E02A5;
	Sat, 20 Apr 2024 13:17:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kJItCdUF5wmD; Sat, 20 Apr 2024 13:17:39 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2CC340E00B2;
	Sat, 20 Apr 2024 13:17:22 +0000 (UTC)
Date: Sat, 20 Apr 2024 15:17:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiri Slaby <jirislaby@kernel.org>, Michael Matz <matz@suse.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
Message-ID: <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local>
References: <20240418201705.3673200-2-ardb+git@google.com>
 <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org>

On Fri, Apr 19, 2024 at 01:35:44PM +0200, Jiri Slaby wrote:
> On 18. 04. 24, 22:17, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > On x86, the ordinary, position dependent 'small' and 'kernel' code models only
> > support placement of the executable in 32-bit addressable memory, due to
> > the use of 32-bit signed immediates to generate references to global
> > variables. For the kernel, this implies that all global variables must
> > reside in the top 2 GiB of the kernel virtual address space, where the
> > implicit address bits 63:32 are equal to sign bit 31.
> > 
> > This means the kernel code model is not suitable for other bare metal
> > executables such as the kexec purgatory, which can be placed arbitrarily
> > in the physical address space, where its address may no longer be
> > representable as a sign extended 32-bit quantity. For this reason,
> > commit
> > 
> >    e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
> > 
> > switched to the 'large' code model, which uses 64-bit immediates for all
> > symbol references, including function calls, in order to avoid relying
> > on any assumptions regarding proximity of symbols in the final
> > executable.
> > 
> > The large code model is rarely used, clunky and the least likely to
> > operate in a similar fashion when comparing GCC and Clang, so it is best
> > avoided. This is especially true now that Clang 18 has started to emit
> > executable code in two separate sections (.text and .ltext), which
> > triggers an issue in the kexec loading code at runtime.
> > 
> > Instead, use the position independent small code model, which makes no
> > assumptions about placement but only about proximity, where all
> > referenced symbols must be within -/+ 2 GiB, i.e., in range for a
> > RIP-relative reference. Use hidden visibility to suppress the use of a
> > GOT, which carries absolute addresses that are not covered by static ELF
> > relocations, and is therefore incompatible with the kexec loader's
> > relocation logic.
> 
> FWIW:
> 
> Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1211853

Interesting. I thought gcc doesn't have problems here yet and was
talking to Matz on Thu about it and it seems he's forgotten about his
statement too that "you should simply stop using -mcmodel=large.  Noone
should use it." :-)

Ok then, lemme queue Ard's fix.

I guess we want it in stable too but as it is pretty much the case with
toolchain fixes I'd prefer if we queued it the normal path for 6.10 and
then backport it after it sees some testing and nothing breaks. And not
rush it to Linus now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

