Return-Path: <linux-kernel+bounces-149132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A28A8C47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2026AB22059
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589A2E62B;
	Wed, 17 Apr 2024 19:42:32 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A32134B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382952; cv=none; b=dLeJ4GG6ZC4Ti1gc2dmSMl6EUA6km0JFrfMNWNnjxFlR80bd+TROAwJAaL0OfF2bZdZjT3RkOUZzdk6LJlvGAtI4N9KSVg1oPKP6dMhspgxkMbpfrcMh3ntAM0TafBAhmbwACPz087H0dXSSeO2uLKRpLeRepiyjgWclhkpmoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382952; c=relaxed/simple;
	bh=R+4G20Sv23I8JOJoiJwJgYGxqizLojnBWKg9lpc+6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVxJau6OCmJTwD32oWHxT1sHQLDN0YoL5/yTO33QcmFkDRgfg0MVJqMb1EvEycqcuDIzE5YRpqd3+LVkP6ayDb1mtT1jeDL8dkX/vvqT+PF33lmRfMfGy/zZASrJzFRzf2Jcx2kjrnkdYkQ4Qk0LDYdTytW1nu5EigrZhEOnZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 330F740E0177;
	Wed, 17 Apr 2024 19:42:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dEfQwNCD1xtJ; Wed, 17 Apr 2024 19:42:21 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A523E40E00B2;
	Wed, 17 Apr 2024 19:42:14 +0000 (UTC)
Date: Wed, 17 Apr 2024 21:42:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240417194207.GFZiAmD4I8sdqhV1RO@fat_crate.local>
References: <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
 <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local>
 <SJ1PR11MB6083F100B4D957EC472AFF19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZiAcvRWwl9m4x2n0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiAcvRWwl9m4x2n0@google.com>

On Wed, Apr 17, 2024 at 12:02:21PM -0700, Sean Christopherson wrote:
> There are two KVM changes hiding in there, but they're obviously quite trivial
> and can to through tip, I don't expect any conflicts.

Yeah, the plan is to queue it all through tip as that would be a lot
less conflicts and cross-tree issues so you acking them is what I was
hoping to get.

So thanks. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

