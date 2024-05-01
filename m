Return-Path: <linux-kernel+bounces-165548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2458B8DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854F428389D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88ED12FF91;
	Wed,  1 May 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK76njsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1A12FB36;
	Wed,  1 May 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580012; cv=none; b=vFyEYVw5tVUAwtjGbkO62+HOVLa9u6eWTfzZX1AhLDJpxfMARTVXjBImTLGty+wuccwdRCDIymEp8RMg8BIf9EWlEqzcae9S5CvrYQnmb1dLT1epQCngabyiDr0qN+yozt5iiqceu5phJGaSFSDTI8/oJGN9xiaSsIWtv820vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580012; c=relaxed/simple;
	bh=dFzfiSp+K+7eC8iqd8lGaatDkcEc0b44t6mRfekFWs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9twhZVkeCqNsk+Zo6dpz9YJSf0uuEPMPZ8BXqvlwg2G1v236yVmXHmy4vNSwoF/1RemRlHqCUgVhYOVIudzIGo3NXM6MrrhsTMT7BI686Epiu4m9UsVEMfwgtYIOD42M16oX4BQH5/aKrSgTPFFEkX7R3yzNWoVmrhy7wy8uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK76njsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA2DC072AA;
	Wed,  1 May 2024 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714580011;
	bh=dFzfiSp+K+7eC8iqd8lGaatDkcEc0b44t6mRfekFWs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SK76njsD/UbgyWhKEa5gdiXSDYZ7FmYrHbjk4phy4JQ/5y++dgaAoK7dFrTnpbgJm
	 wWqEsJ5UHazwnyXBq6qImP5pWtHrNCce6zW2vPHGcBPotG1/tWoiJPC2bQ6ETPpuLD
	 4EzW/uEvNHTm/x3mPEh/1agcO0v6woJRSKhugvfmwXAyGCT3/BtkrU9EYh/7s8n7Yc
	 WJ4yH29ddvKTUhqJTvKmHJYADF6hgHLpuh5KVdp95Du1ZUbMx2Ry/MJLU/peSJ02Gx
	 rJdVEZoG89TjPu1YbCz0ASGT8cme30P+XUQHFhwv9omUtihZ90EV6FDEgjt4eNqLjE
	 7Jutct3+m0Z2Q==
Date: Wed, 1 May 2024 19:11:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <ZjJpzqviUeFnV1A4@kernel.org>
References: <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
 <20240411154007.5bdf8d95@gandalf.local.home>
 <fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
 <20240412132243.053ad096@gandalf.local.home>
 <ZjJVnZUX3NZiGW6q@kernel.org>
 <20240501105455.42b78a0b@gandalf.local.home>
 <ZjJgIIOvvEdnisNA@kernel.org>
 <20240501120904.61c7617c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501120904.61c7617c@gandalf.local.home>

On Wed, May 01, 2024 at 12:09:04PM -0400, Steven Rostedt wrote:
> On Wed, 1 May 2024 18:30:40 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > > /*
> > > >  * Parse early_reserve_mem=nn:align:name
> > > >  */
> > > > static int __init early_reserve_mem(char *p)
> > > > {
> > > > 	phys_addr_t start, size, align;
> > > > 	char *oldp;
> > > > 	int err;
> > > > 
> > > > 	if (!p)
> > > > 		return -EINVAL;
> > > > 
> > > > 	oldp = p;
> > > > 	size = memparse(p, &p);
> > > > 	if (p == oldp)
> > > > 		return -EINVAL;
> > > > 
> > > > 	if (*p != ':')
> > > > 		return -EINVAL;
> > > > 
> > > > 	align = memparse(p+1, &p);
> > > > 	if (*p != ':')
> > > > 		return -EINVAL;
> > > > 
> > > > 	start = memblock_phys_alloc(size, align);  
> > > 
> > > So this will allocate the same physical location for every boot, if booting
> > > the same kernel and having the same physical memory layout?  
> > 
> > Up to kaslr that might use that location for the kernel image.
> > But it's the same as allocating from e820 after kaslr.
> > 
> > And, TBH, I don't have good ideas how to ensure the same physical location
> > with randomization of the physical address of the kernel image.
> 
> I'll try it out. Looking at arch/x86/boot/compressed/kaslr.c, if I read the
> code correctly, it creates up to a 100 slots to store the kernel.
> 
> The method I used was to make sure that the allocation was always done at
> the top address of memory, which I think would in most cases never be
> assigned by KASLR.
> 
> This looks to just grab the next available physical address, which KASLR
> can most definitely mess with.

On x86 memblock allocates from top of the memory. As this will run later
than e820, the allocation will be lower than from e820, but still close to
the top of the memory.
 
> I would still like to get the highest address possible.
> 
> -- Steve

-- 
Sincerely yours,
Mike.

