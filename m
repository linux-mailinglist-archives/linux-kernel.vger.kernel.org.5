Return-Path: <linux-kernel+bounces-145719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346128A59FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7796B21462
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11829154BE0;
	Mon, 15 Apr 2024 18:36:49 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020996CDAD;
	Mon, 15 Apr 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206208; cv=none; b=CM7mx5hBO/qgTvhP0NZHWnyHKovyjX5Vpy65kBruLVvQqNHoE9jIeuwYR3jnkPnsGO+WXH2jQo+Fxf6QDPZe8oR1SY+hJYMPnzzq4iQZrtxQqDLnQco9rXkoLMyL2EIiYaRE+G7WWF4GepukgyUlnNGEoK41xj86r8l1GsXUMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206208; c=relaxed/simple;
	bh=8WjLDUR1gaaesp6TKmIIOcXosPbEmFeHiEa9BwAviYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdVTjsUj7a+Sn3LQinQ11Sng7iQPLbWCR6i6K7OSDqlOWLsg6hQXLIBkG6FSh7Z5u/5kPHOKiFeauSs01xCZp3pCbLJgCeMsU4F/EOqYoyG1CXfmvBT153iyXajDGJ4QJarNgD7Mv8eYjwNO7AZXUXNCi+5juUIygAS5teGjQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C51440E01FF;
	Mon, 15 Apr 2024 18:36:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TFrJuOhBSMmW; Mon, 15 Apr 2024 18:36:38 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44CDB40E0177;
	Mon, 15 Apr 2024 18:36:22 +0000 (UTC)
Date: Mon, 15 Apr 2024 20:36:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ
 disable race condition
Message-ID: <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222181324.28242-2-fancer.lancer@gmail.com>

On Thu, Feb 22, 2024 at 09:12:46PM +0300, Serge Semin wrote:
> The race condition around the ECCCLR register access happens in the IRQ
> disable method called in the device remove() procedure and in the ECC IRQ
> handler:
> 1. Enable IRQ:
>    a. ECCCLR = EN_CE | EN_UE
> 2. Disable IRQ:
>    a. ECCCLR = 0
> 3. IRQ handler:
>    a. ECCCLR = CLR_CE | CLR_CE_CNT | CLR_CE | CLR_CE_CNT
>    b. ECCCLR = 0
>    c. ECCCLR = EN_CE | EN_UE
> So if the IRQ disabling procedure is called concurrently with the IRQ
> handler method the IRQ might be actually left enabled due to the
> statement 3c.
> 
> The root cause of the problem is that ECCCLR register (which since v3.10a
> has been called as ECCCTL) has intermixed ECC status data clear flags and
> the IRQ enable/disable flags. Thus the IRQ disabling (clear EN flags) and
> handling (write 1 to clear ECC status data) procedures must be serialised
> around the ECCCTL register modification to prevent the race.
> 
> So fix the problem described above by adding the spin-lock around the
> ECCCLR modifications and preventing the IRQ-handler from modifying the
> IRQs enable flags (there is no point in disabling the IRQ and then
> re-enabling it again within a single IRQ handler call, see the statements
> 3a/3b and 3c above).

So I'm looking at the code and am looking at this and wondering how we
even ended up in this mess?!

An interrupt handler should not *enable* the interrupt again - that's
just crazy. And I should've seen that in

  4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw")

and stopped it right there. But well, it is what it is...

So I'd like to see the following flow:

* on init, the interrupt is enabled with enable_intr() *after*
registering the interrupt handler.

* on exit, the interrupt is disabled with disable_intr() and then no
interrupts are coming in anymore.

And then I don't think you'll need the spinlock and it'll be sane
design.

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

