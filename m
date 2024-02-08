Return-Path: <linux-kernel+bounces-57831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163A84DDF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C3128BE3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2066D1A2;
	Thu,  8 Feb 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="bIF6OqoW"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533636BFC2;
	Thu,  8 Feb 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387452; cv=none; b=DP792yGVH3xOTKf4PuDZYxT1nFZ42z9MxAcuutPyREovg6TXHYBF0F8nSpNhX4iHeBf9P7bv3NUkHalU5vGMWyIG03W8YlqEABrqlAFv75uc25kK3dqlIZOfjCrvy5ssRvd6TGeunxsPPhCYlqb2Y7qi0XFtBBcmJhtlydPVSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387452; c=relaxed/simple;
	bh=Mx97f1IIrXA5jx8KWxAtL2kPGmFBm5rDhdqH8r3HIHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+Jfzys9MXcajh2rn5SRi24AcYfsJ6YiilqDv718IFyOwNc9KvdhVtzoTuSFxgcFyHJMRbx9Oy9yenvIbRaCPX3oz2JpeQIrRG3L0OgqF8Mn0HjCfVVVuak6t4Nvm6m2gPRmpgeK5s0hYqO5RS1p6ZSFfZwuzfFYOGxuIyBKPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=bIF6OqoW; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E90BC55F;
	Thu,  8 Feb 2024 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707387449;
	bh=z5fQJ45PdxccK1L56OVjul93Ta54zY+xbJ8VnsBJoxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIF6OqoW6AfsT35L0rMEayR+qDlGF+ec6WL21Y4yhwHGkxdCzxvZG+fEhr5dTj3pg
	 1pvLBexs36v9IPcDFVPiMPXUI2EGynxqw/J3nDIksQcBAHJf4GNNy6QRb/jfEGCrNa
	 60NIPtjNH6JFTBkkJfjQPGABrHnGg7Ntjgp1J30k=
Date: Thu, 8 Feb 2024 02:17:27 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>, Florent Revest <revest@chromium.org>,
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
	linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
Message-ID: <3c8dd43f-9ab0-4b98-bad2-71c5f3da0348@hatter.bewilderbeest.net>
References: <20240208012620.32604-4-zev@bewilderbeest.net>
 <ZcSc+ftxHY8RyinQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcSc+ftxHY8RyinQ@shell.armlinux.org.uk>

On Thu, Feb 08, 2024 at 01:20:57AM PST, Russell King (Oracle) wrote:
>Hi,
>
>Where is patch 1 of this series? It doesn't seem to have been Cc'd to
>linux-arm-kernel. Therefore, this can't be reviewed.
>

It went to (among others) the linux-parisc list, but not 
linux-arm-kernel as scripts/get_maintainers.pl didn't list it for that 
patch:
https://lore.kernel.org/lkml/20240208012620.32604-5-zev@bewilderbeest.net/

I think I've gotten differing opinions from different subsystem 
maintainers on this, but FWIW my usual default approach is to use 
scripts/get_maintainer.pl on each patch and then add the set-union of 
them all to the cover letter for context; I'll try to remember the 
preference for linux-arm-kernel though.

Is the link above sufficient for now, or shall I resend the series?


Thanks,
Zev


>Thanks.
>
>On Wed, Feb 07, 2024 at 05:26:18PM -0800, Zev Weiss wrote:
>> Hello,
>>
>> I noticed after a recent kernel update that my ARM926 system started
>> segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After
>> some investigation it appears that ARMv5 is incapable of providing the
>> appropriate protections for MDWE, since any readable memory is also
>> implicitly executable.
>>
>> (Note that I'm not an expert in either ARM arch details or the mm
>> subsystem, so please bear with me if I've botched something in the
>> above analysis.)
>>
>> The prctl_set_mdwe() function already had some special-case logic
>> added disabling it on PARISC (commit 793838138c15, "prctl: Disable
>> prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
>> check to use an arch_*() function, and (2) adds a corresponding
>> override for ARM to disable MDWE on pre-ARMv6 CPUs.
>>
>> With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
>> subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
>> succeed instead of unconditionally failing; on ARMv6 the prctl works
>> as it did previously.
>>
>> Since this was effectively a userspace-breaking change in v6.3 (with
>> newer MDWE-aware userspace on older pre-MDWE kernels the prctl would
>> simply fail safely) I've CCed -stable for v6.3+, though since the
>> patches depend on the PARISC one above it will only apply cleanly on
>> the linux-6.6.y and linux-6.7.y branches, since at least at time of
>> writing the 6.3 through 6.5 branches don't have that patch backported
>> (due to further missing dependencies [0]).
>>
>>
>> Thanks,
>> Zev
>>
>> [0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/
>>
>> Zev Weiss (2):
>>   prctl: Generalize PR_SET_MDWE support check to be per-arch
>>   ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6
>>
>>  arch/arm/include/asm/mman.h    | 14 ++++++++++++++
>>  arch/parisc/include/asm/mman.h | 14 ++++++++++++++
>>  include/linux/mman.h           |  8 ++++++++
>>  kernel/sys.c                   |  7 +++++--
>>  4 files changed, 41 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/include/asm/mman.h
>>  create mode 100644 arch/parisc/include/asm/mman.h
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>-- 
>RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

