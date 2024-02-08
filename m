Return-Path: <linux-kernel+bounces-57565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD484DAC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B011F22C94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443AD69970;
	Thu,  8 Feb 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="HFF2JT2k"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBF6A024;
	Thu,  8 Feb 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378152; cv=none; b=MWuTqHIL9CV2kKYAJj90BUbO1DwKESYVQSj/YZrsYznoKlkZM6kofkuB+gOdYUA+/i83SPCiJ19s8SBWF8mVjZ5svy7/vc4ZDSgyOTaB1NCu9je7gmRhyWB+1jzoe+4yVsHygS9D5pLEnCkP50zDH1700RsFhCcdhN4+afl3jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378152; c=relaxed/simple;
	bh=4kwN6kbUMPfDh8Daeh4OSPI9rA8xZ0ThDzZtBhr0M38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stG44ETv7Uidvg55WC2a7InRh7EEeu4hhN44E1xpqa3271WqT/jUWXC//JahFJtMJ6J9Lx+04AAJY4ZhpVdr03kdHMgAplIwlpNB2b5iXPPDdRik8pXl+4z1Pe8MX0EAKS6enjtU/UU7vqgG0m2tGns1zm4YZqLAFI6MmAl7l6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=HFF2JT2k; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 42776B20;
	Wed,  7 Feb 2024 23:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707378149;
	bh=nc6/jWnwLX397A9Ey6yCLTE82wXsWB+Hnpcpb6UbAaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFF2JT2kZMnF214qt6j38Xz6hmZbZihcccEsXXLVpOZge0Y+/IFzMg908eI0wbIV7
	 YXtGEDNHiBGpRa8I/5d46CgHNKKNxsl9z5aeMrfLDPQ/eBeQ8KHqpzb4vVZKFcJl+7
	 t5j2ipv2LWbAGVn8TTcMYKOsCE+Hbi5BrgLIhoYo=
Date: Wed, 7 Feb 2024 23:42:27 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Florent Revest <revest@chromium.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Stefan Roesch <shr@devkernel.io>, Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Sam James <sam@gentoo.org>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
Message-ID: <aee52007-b805-40a0-976b-eee52c98099c@hatter.bewilderbeest.net>
References: <20240208012620.32604-4-zev@bewilderbeest.net>
 <385d72eb-2443-42e5-858d-0cc083a29a26@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <385d72eb-2443-42e5-858d-0cc083a29a26@gmx.de>

Hi Helge,

Thanks for taking a look!

On Wed, Feb 07, 2024 at 11:02:24PM PST, Helge Deller wrote:
>Hi Zev,
>
>On 2/8/24 02:26, Zev Weiss wrote:
>>Hello,
>>
>>I noticed after a recent kernel update that my ARM926 system started
>>segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After
>>some investigation it appears that ARMv5 is incapable of providing the
>>appropriate protections for MDWE, since any readable memory is also
>>implicitly executable.
>>
>>(Note that I'm not an expert in either ARM arch details or the mm
>>subsystem, so please bear with me if I've botched something in the
>>above analysis.)
>>
>>The prctl_set_mdwe() function already had some special-case logic
>>added disabling it on PARISC (commit 793838138c15, "prctl: Disable
>>prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
>>check to use an arch_*() function, and (2) adds a corresponding
>>override for ARM to disable MDWE on pre-ARMv6 CPUs.
>
>Instead of splitting it out to a new function in mman.h,
>I'd prefer having it as config option, e.g. ARCH_HAS_NO_MDWE_SUPPORT (?)
>which could be checked instead.
>For parisc we still want to allow mdwe in the future, we just have
>to wait until most user-space programs have updated to the latest
>binaries which don't need an executable stack any longer.
>

I considered that, but it seems that ARM kernels at least may not know 
the answer to that question at compile-time -- see patch 2, where the 
ARM implementation does a runtime check on cpu_architecture().

>>With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
>>subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
>>succeed instead of unconditionally failing; on ARMv6 the prctl works
>>as it did previously.
>>
>>Since this was effectively a userspace-breaking change in v6.3 (with
>>newer MDWE-aware userspace on older pre-MDWE kernels the prctl would
>>simply fail safely) I've CCed -stable for v6.3+, though since the
>>patches depend on the PARISC one above it will only apply cleanly on
>>the linux-6.6.y and linux-6.7.y branches, since at least at time of
>>writing the 6.3 through 6.5 branches don't have that patch backported
>>(due to further missing dependencies [0]).
>>[0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/
>
>I think you don't need to worry about that, since stable kernel series
>for 6.3 up to 6.5 were stopped...
>

Ah, hadn't realized that -- thanks for the tip.


Zev


