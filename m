Return-Path: <linux-kernel+bounces-96894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0698762A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0406AB2405C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011E55C0B;
	Fri,  8 Mar 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fZWgaYjZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76C2CCB3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895681; cv=none; b=lic3mddGDUeHJFaXxh8JLYa+VnWmN9utErYqiYdchrgg8PxqvINc8JholK2kQ43VSKyQNToezB/vNMlNU8sPS0S6R8Uco9qBrNy7CSFEN7Ae5VU7SiIH8uXsO6EN2UbCCxJV3OmQ7KE6lwa71Dg/trRg6aIYUJbGCQRVHfIdN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895681; c=relaxed/simple;
	bh=uHV1gGkgr6Tmt56AjXTymwnJiCemKOzJZhmAXfR2VYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufxhjavpR28mbqT+cn8+t0c7o1g+W+xj2ac+oQ+8diBbph4u7GaKRdV2a7O6u8KaGXBf2e18Rg3xm/afwbj/lbyGY/V2RoxwmwQOF181EywiaQAKgQL7sSx3D75+lT5ErPwIY/Ktd8Yt61dLcZ+BOTj5a1hYYcxoThzWZfBefdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fZWgaYjZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 144D940E0173;
	Fri,  8 Mar 2024 11:01:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zj6u7WGxYIDy; Fri,  8 Mar 2024 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709895674; bh=NVFJ/6oWHZdVHQAZ5JD2IT894wi7c6NAiBJiCcucup4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZWgaYjZPrf5m6zPSbVcy0iC/3EfnIGhQrPB2OBkoJLszCSlql6LX72MbByBHWneT
	 lJFMnLB/LfoIuIuiI6NTC52pFHxiUgEplXowi2GNt2VRN/fDuaUWNVsdNeqk8ibAPJ
	 e+YQ2/Vmj88WNNR2GxUc4SvCsslMqQAefhFjnKXqh75nmBSU1w6zrImk9ZsL67CSJT
	 ZEcDx5bICTwUbmgie/O604hZZNMFB8IQN9aCQJ37Q8iDqDc5LbGjVhRCmZpGKEtX6t
	 d2h9IytAbgB7rj0uV8pUFvlOCUyo4FilBVYWuVw+2b6AQB/xA4OXraLBn8wEzvGTRL
	 ++oYja268Tb9H9mvW8bVOV8+05SwDM1NsJQmY0msiGjIitPEdMlZUXK641qSuIokG/
	 2C8iIsFPhriqYxK4Tg1FGdujoUlfK2KtQuuI15ePOF6NYrBo/+MkSdgE7aQblMpi+Y
	 ZCPmVc0IjFXgPkcUjkKgXj5x2Fh9wDI2jOIbbxX/WWSJxWLz4bMlv3fQBzCY7XPNRX
	 7gItvuB5lok/fNcGC8s4O99RdKTJejZsaZUOmzVf2UhHf9OVv3jJAMJ1ojbdwSA89+
	 quguGO0xamnBK7yZeHo1pekKH1euOd4pPN4bIl9abnzof9W8FuIrqBJv8aGlo0wEUR
	 40leEO+ooWzpbwN8XrDjxrzY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5FBF40E01B5;
	Fri,  8 Mar 2024 11:00:48 +0000 (UTC)
Date: Fri, 8 Mar 2024 12:00:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>, acdunlap@google.com,
	alexander.shishkin@linux.intel.com, andrisaar@google.com,
	bhe@redhat.com, brijesh.singh@amd.com, dave.hansen@linux.intel.com,
	dionnaglaze@google.com, grobler@google.com, hpa@zytor.com,
	jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com,
	linux-kernel@vger.kernel.org, michael.roth@amd.com,
	mingo@redhat.com, peterz@infradead.org, pgonda@google.com,
	ross.lagerwall@citrix.com, sidtelang@google.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, x86@kernel.org, ytcoode@gmail.com
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
Message-ID: <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local>
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
 <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>

On Fri, Mar 08, 2024 at 11:30:50AM +0100, Ard Biesheuvel wrote:
> Agree with the analysis and the conclusion. However, this will need to
> be split into generic and x86 specific changes, given that the DMI
> code is shared between all architectures, and explicitly checking for
> SEV-SNP support in generic code is not appropriate.
> 
> So what we will need is:

I was actually thinking of:

	x86_init.resources.probe_roms = snp_probe_roms;

and snp_probe_roms() is an empty stub.

Problem solved without ugly sprinkling of checks everywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

