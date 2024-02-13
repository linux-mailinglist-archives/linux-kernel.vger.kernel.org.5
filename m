Return-Path: <linux-kernel+bounces-64341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C6853D46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3407F1C26730
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0166214A;
	Tue, 13 Feb 2024 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QEIyaW03"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC260BA6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860243; cv=none; b=M0YWJ2nl53MIk+xJ7kP5orVs4zCyZTAswvYfT+pQRznWwixLwqIGnJy0tNBxLymvn9AWfU/zTiSJx79a8NmRg1k3ImRPadCdiT97TloMph5AQ4ckJ+w5JbQH4HPYSz4oqOwnN65hGjaV/lyM3xPoP2ikto2S7lr4CsiwL5oE1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860243; c=relaxed/simple;
	bh=+u+owyuKuJFkGHSGbKvz4UTc229rDQ9Sn38kEXmB04M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtfow/npcQ5F9Mr85eWl+UMMxqm14U6F2uWOvaEaHPiO1FNVuzkVqjL3zjqFyB1lkSOvYQi0ukzPvEBTYhrl77nQ8efy9SO2tS+45eovfp9ozx1Bx0UWCE+HlcQPomOsH6nMrds9OtkFaZ1OOcyPaQAnLXU7q9+dklHvsrdHH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QEIyaW03; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E805740E01F7;
	Tue, 13 Feb 2024 21:37:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rI83Hgbywzby; Tue, 13 Feb 2024 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707860235; bh=D3ecxWaMVByifJVjnfG1Ub3I2qDV2hVXXGWWQRAmNxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEIyaW03qmQqCOv7v/9h+CCMwtAfHmbKYaK2mU8d9SBu8+btRkVpuDZonh6URfSKn
	 Uviju+rT83R47ybInt0FYq4+K+thLxdWuB07OsQYzAoRbTySC1DdlLs3g730ezDIiS
	 faq6Ou+fIHaL72eY1QOllXmj7VeglRkxDu6jS3fgrdkx7zF0w/WvKty+RC2+dq2Rhh
	 wuZoDmQvhF2Wc6/COvGL76w/DlOn9pjgvGWlPEqtSrNh/uC3u303PiR6T+YIIUmYEy
	 080edipcK2tzZJdUwoAmfY+MKInu5Gi04xqCfRdfu+8VPmR0n9ie5uVm+sa2zTkZy6
	 TnJYLNCmC8V38d5GIuv7JiV6nS7vT0WUkYRwqG7VDL+IvDiCSyabHG1pbBlVs6qvBD
	 CaX3rDyzPFqMk9T1mE6p4dkIPEm+DorTu01dkaEmc7wymFCNVWDe2GxEtj+2Dt0bBx
	 5avd4WDmuUd/PlBZolK+VzZSpksmbIQL4DI7MSBFal5cJ5bzoeLFsK/mB1mRPPeD2o
	 QilTRXqY0tE7n6U6XJF1ACiwxg0gC9dPvzUygbPti3iCJA0AmKpWS7YNmNgca4wo5Q
	 UYgONNPohLjk2Wtb7FJA06Yk+Yuyr2YVVZj4B+TQ6uKjeoAcVtk2pvGu5Z3temJ/N0
	 4AtKxDQpn55wGP4Ji/Qv/Mw0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C60340E00B2;
	Tue, 13 Feb 2024 21:36:56 +0000 (UTC)
Date: Tue, 13 Feb 2024 22:36:50 +0100
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
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Wang Wendy <wendy.wang@intel.com>
Subject: Re: [patch V6 01/19] x86/cpu: Provide cpuid_read() et al.
Message-ID: <20240213213650.GEZcvg8uvjPXTVhmHv@fat_crate.local>
References: <20240212153109.330805450@linutronix.de>
 <20240212153624.516965279@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212153624.516965279@linutronix.de>

On Tue, Feb 13, 2024 at 10:04:00PM +0100, Thomas Gleixner wrote:
> +static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
> +{
> +	regs[CPUID_EAX] = leaf;
> +	regs[CPUID_ECX] = subleaf;
> +	__cpuid(regs, regs + 1, regs + 2, regs + 3);

Yeah, 

	__cpuid(regs, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);

explains what those numbers are.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

