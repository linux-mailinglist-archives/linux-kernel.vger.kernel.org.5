Return-Path: <linux-kernel+bounces-96714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4C876071
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E841F25752
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD374535A1;
	Fri,  8 Mar 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BlZ0xaQi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311F5338C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888271; cv=none; b=Qz06lSzvlZ5b5B9jT+Dlx+BegQYdtK069rCYFx4RjrED8oC0kq8IL7cepzQfGXWcBDtQMemCAgZ1ay+kGvLuRFkQ7f/t3SKcj84FAQUVQMu1ZHZtcy9Kr8saxQUo08U4LU+iSkxJCkJziTeGcI7zkW+swB9NvzPqsd7PdG2d8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888271; c=relaxed/simple;
	bh=jajimP3j5lC4XyZuV2Qeuj7jzP25wkYstevIdyZy0es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYjwu19ranpIO1KVPa11DwJCggN5MDYkJ3aDsy/rEJLaPeFwl69XM9N4qIIcP+YKEc8ob39EA5HoNsnSsmwYSe7A4h6a2DpRINiECf0NQTqpkks3AFxL0QCHRd6GZlNUQGfA4h1MjRExHBDU5+2Ki9IdoMeNyq97R9VJnMm9GdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BlZ0xaQi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4DE6D40E01F7;
	Fri,  8 Mar 2024 08:57:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WC3h695uH_Jp; Fri,  8 Mar 2024 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709888263; bh=whg7S48qxi62u64g7hpTKEWyyjWtaN8l7RWfYvb+8FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlZ0xaQiyEun3ErVrAtwl9gVpdVjHxpsFrG/4uDRZxzR8omzuP2Pa3WonsQfaWQO+
	 dNDyP8/RfVERsPn8RKjzZBqnFD8i43Izf0qHJGGv/XEG5WL0psrbKLys2jJzewiRcw
	 uoSG/OxexnXSS742Ruwv23BLV2fttqaGqlIwiA7FpJEYXw1J6GgrotIYL4obNWz0lX
	 T7nqIFNkKlPj0typlf2hnP2T4F46aWk6GRBk+yQqKVBhxUZvjVaVxJPsBGqOvSS1zp
	 97cQ7ZaMtAGMleJo6aCIVkue4gi9Kr+G2xc8wtja6SF7BTRFIPlRjG22VQ00wn7bGr
	 Y/k+dCe9hCAUGYEDwTwGe7Nb22tFAyhxV7iET+I0j3vh6e5OoV2RN5Ry7AsQ0yw6A+
	 wrVGaZ+CscJEo7dk0BW1IkoLiI82tiyiSUlFNFSutbCFH9GpgrmjvEciV7a2ymIRBO
	 qW0F0UeQViiSf9b+AxIWJ/lnif3ian4pwzKl50iw4K1YWmnSnBij+pi26MFTvOPuwH
	 qpV7ni0l4rjPqPii4jzbq1CP8rvB7NxBzdcht0X6f6Ssfl2NUU//cjSTVXfwnMsdNn
	 FYIssrwoB2JrvK/TPa9k+eazxL364wAsEFbEPpygIQrib8t4MYCpwMI1s3lpTgUgT/
	 fBr5bytrnBMMPUEi8f5YZa1c=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4431F40E016B;
	Fri,  8 Mar 2024 08:57:37 +0000 (UTC)
Date: Fri, 8 Mar 2024 09:57:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 03/34] x86/pci: Assume that clflush size is always
 provided
Message-ID: <20240308085736.GCZerTAHhN5-PEmVfB@fat_crate.local>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183930.18D74E8B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222183930.18D74E8B@davehans-spike.ostc.intel.com>

On Thu, Feb 22, 2024 at 10:39:30AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The early boot code always sets _some_ clflush size.  Use that fact

s/clflush/CLFLUSH/g

as it is an insn mnemonic.

> to avoid handling the case where it is not set.
> 
> There may have been a time when the Xen PV call in here way too
> early.  But it calls get_cpu_address_sizes() before calling here
> now.  It should also be safe.
> 
> Note: This series will eventually return sane defaults even very
> early in boot.  I believe this is safe now, but it becomes *really*
> safe later on.

This should probably be ...

> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---

<--- ... here as when applied, "this series" means nothing.

With that:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

