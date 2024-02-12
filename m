Return-Path: <linux-kernel+bounces-61867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9B851793
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9B3B24483
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A513D0A8;
	Mon, 12 Feb 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PhmgiCF9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F83CF49
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750346; cv=none; b=ouUTPNFq45HWC5DuJd/+0OI+TqYILDtFc1Ll46X30ZC2a2IaibKcxPQ7A2mJ6FTEhy9XnZzVOkUuWVlA/fAvfdXLZgS/L/jujI0ufxizMxaI2ecvlMA7uNXnrYaTFaO9XZcVKWt+i9ep24Iqs+rEh/5fV+2recpNgTbJZsNN8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750346; c=relaxed/simple;
	bh=cjR4H0b8R2B5xu2LjX2TMzEB9lNOfrxFvAlBi7z/6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajafG1xAaGSFSFxDLXYSDCsxkv3g7aA6J+MLxc5FBlJx+/wHg4UpLIpxq9zjOrcu/29VwxGyKt7fKea48/QYw92xr4Usm/HF5PXwnhzQo1S0jaeAw96U3r/9h9il/07ycA8XmaeLXUa59PlozZ6cnF8GYzntoI5uJ3DzoS5E2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PhmgiCF9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 62DB340E01BB;
	Mon, 12 Feb 2024 15:05:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kYVDyXgXMCrq; Mon, 12 Feb 2024 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707750340; bh=W3ZqrPOxPMdo3FuKIEovNlT7wxv/3e/hAQvWN9m9JHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhmgiCF9qnhAUzvCVgeeO4K6d5kSW6l8vZFClfwOIUu/bg+JFbUgoRsmtgmDzNExR
	 64R3CGzAltbMXprSHEeZN+XOL6gGr5mLfYz1gZyIBP+GInDfMNbh+AqN0up8ebGtmF
	 CQ50xLhSDUyxN60o3RrOSL4dmWufovtGCkAa3Fyt5cSMzogZ/3+6+nWDCSGF5xT9y/
	 PGTIk7LqvVz6HTR/4atfXA9NLsrVvq0lS94yOTqMVxGIqz/Ubl+7gcKZcwda+gAo5S
	 KKxFFaXjkQzppoCu7jDSORN+ayd8Rij4A0BdyKT9u+TpE3J1R0ZHZ+RHgYsVCZoz72
	 Or/halPOg88kaQt39oia4eta83y0ToF8M7NxxJlOkzFXbv34aduZVvkGjMQujQ/C4a
	 uSLxw1BIJgrpTwFTWw3Ts/XgdN4wXSvnH08INcUxvSP+YAaGKpLcDsMif67kbe/m4P
	 7wZFRl8NgyijEOZuO5kJcuUW7SpaFxtHrRrw+yMVuW7u8Qm3GCkgwmEwu70RWwnDzo
	 blENYtuhLYpKdnGxVw0hdnDBXdl+2QtDtqvhv6nldGr23P1nN7rKsmPd8Fcd5EgZTC
	 IbS6jJ0Yp+X8aHMWuhvhyBqc+EvsCoL3GJIg5tJ4rC2OIuz9Vtl2vJSas+Ftnuhdeg
	 gkJDtUM96argLTVe9MnXq4UA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30A2340E01A9;
	Mon, 12 Feb 2024 15:05:22 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:05:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Message-ID: <20240212150521.GFZcozsQpmGEvDC1h-@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
 <87il2tlqba.ffs@tglx>
 <87a5o5lo6q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5o5lo6q.ffs@tglx>

On Mon, Feb 12, 2024 at 04:03:41PM +0100, Thomas Gleixner wrote:
> Aside of that it would make the struct generator in the CPUID data base
> more complex.

Hmm, that's a valid point... that thing being XML is already complex.
:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

