Return-Path: <linux-kernel+bounces-44955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4806842961
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527AB1F298FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2FC6A02A;
	Tue, 30 Jan 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GLS41lND"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F33C09F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632476; cv=none; b=R/qVT4qlz+DUEMw/Z1atq0Lbi8HlRFiUKd+7c/PaaIFOSvdMs88YXMG9lS7WXRvYhc9Mn8wWLEKhyFL0CZneqfnwfSm5NZhA2r2Ot/Ux6u4TUQ4wQcmHwnLgwU0uMlENuNg6aMohrKb9bP947cBLVUxkAIU3LXrEVcLUnYq3qHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632476; c=relaxed/simple;
	bh=cLW3TYnQ+UQStnoofBMZmHXvKOH1jxXp2MdItUiAV0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4aDuwcK1adPcJBEyeOmhy7MNBhZ0ebTIUmcs+f+kT+mY0pQboPF3odv9rLqjfFL7SJxpYfwUs/CTpKjwdknr/KiLk2wUPfHoqgMHM5/zcriIgHC1Lmf4pc2MWeRmm8PMB6oFlxEWz17jE1DlzH3ww5jg952kU4KhnSMl0xVDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GLS41lND; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4691940E01BB;
	Tue, 30 Jan 2024 16:34:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GIIfi_ELwrvH; Tue, 30 Jan 2024 16:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706632470; bh=671jtj68uxhyk+sXY3zn0M0IF1JJHiVY4EKi6W0gTLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLS41lNDXfP5LCvI9mo7vxz1UinLqfyVmg7q33O6KWK3VICw/KFdu/y4eQEU2mZ3l
	 Y+6A/1x9P05wfiX1a49hD45r3NLoKBMsm0YpB3EqqPvtgwxMQP7Xrb1lHDz1XsW+77
	 jRWRInMbR8xkS4wHdTHvWKPmWCmdzCpau60htHUPPRVItZXqvexKjHdND2t0PfaFlF
	 XKiWlxK6Euk9NbjcplklEcfkAjSjOcObqXnQ2ISpOhN568Tyu29KXcWC6uRN38/T0t
	 oRNd3u2PqtXjoWz24kU0swBRWxKm/uzlXjXxr/BRfsgjPtiFbF27neW4sK9Z4MsVTJ
	 9cMlInkSu+mOLUf0WR8h1chYcq8IgB9La0jpYxvIYVKH0m0KyrHeewGyCrcXSOSe7X
	 Ott1HuoNnl2oxKU9C+KOh8TBj3WwhhZ4J7ZVkfH5t27SMVaKDOTAMZUUvHXYkCwBcZ
	 UE1PGJU3kkgDyd75Xx4QIcwL44+rojFctUQAW6lbf8DJgyAhTCDMozYw4EDhycnNDl
	 2MNVIOdI+hHrACco5zdh0X/llrs/gZJBGzm5ksA+UPybOtKylK2SDGj7FkzC9lbCtA
	 3Fa4rgdo1uenYe7ptBq+uuiXpzNAeTcMcTfMZccFarF0kprWmznP7YU3b9NTolpVwI
	 0sx7BReln/ejn8xJY67tXztE=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE4FA40E00C5;
	Tue, 30 Jan 2024 16:34:18 +0000 (UTC)
Date: Tue, 30 Jan 2024 17:34:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Message-ID: <20240130163418.GGZbklCltPHmo2Z1NB@fat_crate.local>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-3-xin3.li@intel.com>
 <20240130124816.GCZbjwEFrZS55FLxb8@fat_crate.local>
 <SA1PR11MB6734A226858F6030C86AE2E5A87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
 <20240130153141.GEZbkWXQt2H3JHHGHx@fat_crate.local>
 <SA1PR11MB67344899D3BCCD4165249D8DA87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR11MB67344899D3BCCD4165249D8DA87D2@SA1PR11MB6734.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 04:30:34PM +0000, Li, Xin3 wrote:
> Even more interesting, gcc doesn't complain it with the attached config
> File in which CONFIG_X86_FRED=y and CONFIG_IA32_EMULATION not set.

Yes, CONFIG_IA32_EMULATION=n alone is not enough. That .config which
triggers it has something else which is causing this but I'm not sure
I want to go chase down what it is...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

