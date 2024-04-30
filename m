Return-Path: <linux-kernel+bounces-164774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7028B82B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776B81F240FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F031B806;
	Tue, 30 Apr 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zv3w7/W0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE61FB4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714516412; cv=none; b=PKzcrIyYOWZVMaPn1EwcN7vznoC0qt8SL2+gyhILBaR3h0lc59yFTLp5PFTkqNG+oTKNDA6DjBhsuvPAcb210biNj4bnjV8RrbPxecPVkSciz6U/9PZkTCF7glZiLl51In900YaIU9nOFZVIwu34Tr+e+b6HiahQqbfX9wsHW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714516412; c=relaxed/simple;
	bh=qVJzWg+P1aUqzTwhiutG7+knLlfh5JCpEUlUhqGtNbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Qei038FGmDwgnTRjxcDEJqkhzWXcMtpDL44Usa3fQscV8xTFiZzJnlVDze31NfhsK33s8PLYMGlTijldouQQAYtXvIX0aKn9D365gATTEgiJo4Yxtob8HONu2zGyL9HAKHJRnRcL9QB9p9ThogCyCMvkQuzWEgTpHDKhW0OoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zv3w7/W0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 202C540E01E8;
	Tue, 30 Apr 2024 22:33:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lfpg0u3yzQ3G; Tue, 30 Apr 2024 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714516399; bh=DlvATvaWxygVgSVb7uWjq/ccZzNWV0VAB/UNxxNHk3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zv3w7/W0pMY64ilgG37lz2oezELHaq86PPyeHWJw3n9wA7oad25UbVnPcfCPnU+ok
	 3dQRsUtD3gCdkkXBUUhHin8/EWbalP85DitVoG4GWMsphM7Y1eu42clmSyAjIyAM6W
	 Objc6wIV5OlCkjBKP/utzBWIpFd90xcJYmGHLLRvr8Z5XjLayCtL5tgM+1RTmpg0Co
	 MsRphpUPmv1b17K9uU4a7HXh27mJPWBsnbQUeHCB39/SWuOgLXXOA43IJ/VNHl0Fkk
	 2TT7kYaSIQjy3UoUe6K1aatPH2IieJNmYYwHq3W1xORY+IOpvlPpPZ/je5he8Jg+1u
	 otGd5aCs8QOD0S+rLjCpYtZZp8xvUd8NeBMP78UWFVcoy5seHImaeMCqLgU0+ZYtR9
	 XRLcdJVWQwCqzf5MfbdNTOFhtTusS3yTDZTpoQyyQOpowmqNTqV87I5HjT/Oaxg3vu
	 3CiTDJ3Wv5xd2JtE3gzPG+SEi4EE16nr5UEUG4uBHElvAiYyli7GozfeTclENXaR6g
	 bWc/kWwzKJCr/PUIiJJyw2RsM+Ig6eWeAFW/i+VkSPWbKyhxHPkqMTmSAa8Revx9+4
	 yNVqg3thgtrTix4K+Z9NAuSVskh5jt79/w1nZJERBlKZY66Z4CS6KaNI2hLv9PrURN
	 byQa7wlfDyxsrYPJK7w42hEY=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA8EB40E0187;
	Tue, 30 Apr 2024 22:33:10 +0000 (UTC)
Date: Wed, 1 May 2024 00:33:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjFLpkgI3Zl4dsXs@google.com>

On Tue, Apr 30, 2024 at 12:51:02PM -0700, Sean Christopherson wrote:
> But that would just mask the underlying problem, it wouldn't actually fix anything
> other than making the WARN go away.  Unless I'm misreading the splat+code, the
> issue isn't that init_ia32_feat_ctl() clears VMX late, it's that the BSP sees
> VMX as fully enabled, but at least one AP sees VMX as disabled.
> 
> I don't see how the kernel can expect to function correctly with divergent feature
> support across CPUs, i.e. the WARN is a _good_ thing in this case, because it
> alerts the user that their system is messed up, e.g. has a bad BIOS or something.

Yes, and yes.

There are two issues. Clearing feature flags after alternatives have
been applied should not happen, and this particular issue with that box.

Lemme cook up something in the coming days for the former.

As to the box having misconfigured VMX settings, dmesg says:

[    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS

which means this:

	(!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {

so... I have no clue what needs to happen here. BIOS update...

I hope we won't try to do some nasty fix for b0rked BIOSes again...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

