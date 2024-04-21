Return-Path: <linux-kernel+bounces-152471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC48ABEE7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5401F210E9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8910A01;
	Sun, 21 Apr 2024 10:08:12 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332D33D5;
	Sun, 21 Apr 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713694092; cv=none; b=r6GyDNYTYKhJ0Jq3PFeheVdyF6ccAWS2rWrQ691gs8Gce5fApEEB36lclU/SyX0FG8mJxRnC0O5IcnBqEIqh7MhTNdhMH+wtqkbSCCtpEx1LjvtBJH9Z3+kG/XwKbfbPWyUk2ACdjyT+eF1CRLnVrJvVbIlM5H4fscjjG/EhjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713694092; c=relaxed/simple;
	bh=i1S6nqyTGUB5Pf4qllbaMsCVKY0B+Yn5GKrEWxkRPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAXFBkISq++s9vrV33CB3wbB7bBiIkeFQh4FWgDvJ7nMEYgcdKRG/a4U1L5lVl+NfPL/iUZ8ZjDBgJiluEFkDZhwW+fH+Y97OxeajimL3XPtv4+mY5b3bj5rzUrCplXtOhngd74MXLqcaMbIgfEtB9LXYX7715JxcppfnLqmtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F3A7240E0187;
	Sun, 21 Apr 2024 10:08:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hJeOWKH7xEdp; Sun, 21 Apr 2024 10:08:02 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 792AD40E0028;
	Sun, 21 Apr 2024 10:07:45 +0000 (UTC)
Date: Sun, 21 Apr 2024 12:07:30 +0200
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
Message-ID: <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
 <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>

On Tue, Apr 16, 2024 at 01:06:11PM +0300, Serge Semin wrote:
> It looks indeed crazy because the method is called enable_intr() and
> is called in the IRQ handler. Right, re-enabling the IRQ in the handler
> doesn't look good. But under the hood it was just a way to fix the
> problem described in the commit you cited. enable_intr() just gets
> back the IRQ Enable flags cleared a bit before in the
> zynqmp_get_error_info() method.
> 
> The root cause of the problem is that the IRQ status/clear flags:
> ECCCLR.ecc_corrected_err_clr	(R/W1C)
> ECCCLR.ecc_uncorrected_err_clr	(R/W1C)
> ECCCLR.ecc_corr_err_cnt_clr	(R/W1C)
> ECCCLR.ecc_uncorr_err_cnt_clr	(R/W1C)
> etc
> 
> and the IRQ enable/disable flags (since v3.10a):
> ECCCLR.ecc_corrected_err_intr_en	(R/W)
> ECCCLR.ecc_uncorrected_err_intr_en	(R/W)
> 
> reside in a single register - ECCCLR (Synopsys has renamed it to
> ECCCTL since v3.10a due to adding the IRQ En/Dis flags).
> 
> Thus any concurrent access to that CSR like "Clear IRQ
> status/counters" and "IRQ disable/enable" need to be protected from
> the race condition.

Ok, let's pick this apart one-by-one. I'll return to the rest you're
explaining as needed.

So, can writes to the status/counter bits while writing the *same* bit
to the IRQ enable/disable bit prevent any race conditions?

Meaning, you only change the status and counter bits and you preserve
the same value in the IRQ disable/enable bit?

IOW, I'm thinking of shadowing that ECCCTL in software so that we update
it from the shadowed value.

Because, AFAIU, the spinlock won't help if you grab it, clear the
status/counter bits and disable the interrupt in the process. You want
to only clear the status/counter bits and leave the interrupt enabled.

Right?

IOW, in one single write you do:

ECCCLR.ecc_corrected_err_clr=1
ECCCLR.ecc_uncorrected_err_clr=1
ECCCLR.ecc_corr_err_cnt_clr=1
ECCCLR.ecc_uncorr_err_cnt_clr=1
ECCCLR.ecc_corrected_err_intr_en=1
ECCCLR.ecc_uncorrected_err_intr_en=1

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

