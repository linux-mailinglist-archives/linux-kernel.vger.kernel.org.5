Return-Path: <linux-kernel+bounces-51254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B8848854
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20EA1C21A0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3115FB83;
	Sat,  3 Feb 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IwGJ5Tp4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B861CAAB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987281; cv=none; b=AEnFXZypNMTGpFX+b30JDn0RyI7q/+fVniwxofXhVXzKqYOUhDFL6WmJHrdYIxXoLC39I+gFX+mvIMVy96Rl3pO9qGN51BA2kG53gZErXOSly96FkyxO6nrPYLBdNywgtrKzvORY8zpszn/vKjmNsHJDSv2qJgYjHuzcKxlO/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987281; c=relaxed/simple;
	bh=WvftTD3UruN16UX3EdI8dyX1uJUVfdutBsChQnJrkQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyWJNggZB+wSBlHyfCpESBvWSsrJeCkvBi1jmzlJuBsOsbPqAYVHbyB1WX9IUwmkqlzJk191JkagBzI0RfM3/HOudvDdshMYu8/QsrABYnZPbHe2vMG3K1QIbo6S10eSFee6cCN0fWIxPdvKKCt3DS8X4/uqGkKhfHxm9//CObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IwGJ5Tp4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DCBD40E01A9;
	Sat,  3 Feb 2024 19:07:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9K7J7D8BM0dn; Sat,  3 Feb 2024 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706987268; bh=neqK9J0OIh+eRJ1A2dGOjmSVUdK+ZOx6SQ3ir+I2BHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwGJ5Tp47Zg5Ie2Y49UXGS8LLZeew8utJRRKMf/WCxLQNynknl3+hq7Y+mwydJ4Yp
	 07p1ubSLm+Qkwirzx6npqwFsGIDMhNb3s2IB69EHUV930SFVRx9ad5XqwhSFlC39qA
	 wBznWesNSo6wvjucuzmcPt+8ZHaBDvwZmjeQm002Ya8CxSs5rJ2As9iAudOlGkHV6r
	 0NZKmy5x0hyzWH8QlaGqnQnPXH7SGg49TL4YxWV8clLbD7eb8vmXRNniS+WM/nuSmY
	 ypQyw70JRiVsESL/iVvNLL5HsInsD6YKHcQ4eFXRLpLGfiiAw7ICSyFoofv9fuXML9
	 cElRkCOhlrvd+s6p7mjY9kq/gJU+9Anp/KetGoHv3c5X75h2z59ED5nZB29EExJDfI
	 llnFgWEMcnL3EixKL6JA5o2CTGxx3JXBJ82E3g/iT9V8/2vtLDziQeuXZPujLhZuFC
	 DtFNkP5lV56qpBXqYLPfkcrzMZ8EKI3ZqqoCBj2phP3KyHETTK87b8EKhxFI9wO7bQ
	 lzUYP60Acq5M7QmuX0NkFoYJ1fsqC4ci0GG54N1S18CW/EBXEmVDU3tlrt8GOaSlUJ
	 d67fns73R5CP5/1DHxudT9ZSh5YvOPXi2WE9/pAXz/Q3JfNhc8Pfr/LxlG3bNxNsab
	 tHw/D9qBknlM4yjgmzPX6/wg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0237640E016C;
	Sat,  3 Feb 2024 19:07:34 +0000 (UTC)
Date: Sat, 3 Feb 2024 20:07:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	kirill.shutemov@linux.intel.com, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] x86/coco: Define cc_vendor without
 CONFIG_ARCH_HAS_CC_PLATFORM
Message-ID: <20240203190729.GHZb6O8UborcetShlw@fat_crate.local>
References: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>
 <20240203102925.GFZb4VhT1IwX-XRxTV@fat_crate.local>
 <20240203160806.GA520926@dev-fedora.aadp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203160806.GA520926@dev-fedora.aadp>

On Sat, Feb 03, 2024 at 09:08:06AM -0700, Nathan Chancellor wrote:
> I have no issues with blaming a9ef277488cf but I think da86eb961184 is
> equally blamable for removing the option to use cc_vendor in generic x86
> code where CONFIG_ARCH_HAS_CC_PLATFORM may not be set. Hopefully that at
> least carifies the "which is it?" question, I'll do whatever you think
> is best.

I guess I wasn't clear enough, sorry about that. Of the two, that one
should be in Fixes which is the first one which causes the build issue
so that the fix can be backported to the respective kernels.

IOW, if you can't trigger with da86eb961184, then a9ef277488cf should be
in Fixes and your fix should go through the KVM tree, along with
a9ef277488cf.

How does that sound?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

