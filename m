Return-Path: <linux-kernel+bounces-134342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9189B07F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFA7281C8D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1231C288;
	Sun,  7 Apr 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zm0JSL2E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC122EE5
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487267; cv=none; b=ar6it+CF23ZXjA8TUorYPIepBi0EJuSGy5LGhVsnsDVed1yBHeBNG/HvPKLBV8EjFaKmOg2mefAAwf7Suy6tCCQN/kQdcHGB7V99XdTzdX61TgMUAr2r8bkYnTy/HCJV67ovMedfilo6TwkFv+jjvpcCcd1v7mci1C/1Y8ci/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487267; c=relaxed/simple;
	bh=8opWvl/2bXK4C2ZgBBY8nJn5GAzA8RqVkDlJPZfFSAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go9im9Px3hwSN+qNxqTNV0xxWuH1qPfBGO/dGqoUPqoMtja1yas1/UcARQu8B4ZpZClu6zzBK97Tb8UCl+Cz+hzF+GyBLCSGulSdQqMF3Ku1Aql2MEEUWvx99e/ioh9r/7O4BIwCuody3R3QLGLYcjW4JmpJsBzLPl6Jw80jf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zm0JSL2E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A9A540E023A;
	Sun,  7 Apr 2024 10:54:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sIFg-p3SwSWS; Sun,  7 Apr 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712487258; bh=EFKqApgapBFGYTWX4FDvown//LSH3cSIupGcbrCON5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zm0JSL2E6FnwWElpWWvywzbyOf5a3d6jyukK+jGiBXW2Djl/lQrao4SFQ2giXWWpk
	 snKQNqZRbfIOMP64hPzA7iwbkumgccPa7O8WqkFcx1MWP/qitnk/kj5khSzLbqQx/3
	 xbksTfNXwnYtqg8Ic3EP2mUuRfSm9/AoJwQrS6Ie3v6M9e6FTpO8KnPyDwNEOcFuEA
	 89dHm5nAXXyshaZvi/5y27gLYkVoT3y/AWC1r3KjakzF2xzswTIRsgv+FRsf7IR9Wn
	 EeFYeMd3m5m8n/OKCXQPWITfdjuZRVmxfDfS/d8AQdv03Ms+mV5oC8/3Q0WPkKx/PF
	 le3HDO/Rc3vvxO10JhkOTKaG07ogHmzSig/61lTbIoy2cTnBQwqtZV6SxW69ZsCZdR
	 k8r7kjjaK50I9WPdwKWvCLFf6mn2jQLnvkjfoGUxE1V3jSSUihh1jgG0qaWRnCE9Ww
	 mRCMKcvD1a31dd3rXTbzop6aIYeX8C20DEUYSgJdKCeGY9vDlI8h+niHSNtAcUtDsW
	 jpLnFXKowPWHk41a3muRAxLFlDL7XTuxUyIofOEXIhDb8ufqVRvo/E6fiNl/k/39Tc
	 Wt7SDwimfZyIaXlHeAG19y0Kv1kXv/KDfTKFE226XCBvAeYQ86EdaUEEaGqU1HRxE7
	 nqQdd8qUoD04LRMjSUeBDOFA=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05BA840E0192;
	Sun,  7 Apr 2024 10:54:14 +0000 (UTC)
Date: Sun, 7 Apr 2024 12:54:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zgr6kT8oULbnmEXx@agluck-desk3>

On Mon, Apr 01, 2024 at 11:18:57AM -0700, Tony Luck wrote:
> That's more visually more compact, but maybe not any more readable.

Yap, I see it the same way.

> But you would have the *option* to do this.

Thanks, yeah, in case we ever get to cross that bridge...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

