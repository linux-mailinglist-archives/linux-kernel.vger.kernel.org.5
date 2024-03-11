Return-Path: <linux-kernel+bounces-99609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6C878ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7431F212C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F6D57888;
	Mon, 11 Mar 2024 22:27:33 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29E57867
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196052; cv=none; b=D/MK1JeCkVaDpJ2jsGXLitMKDQ9OcGUw0PE4fXOjkwF/MVP13jFM9B0C9igMc1iHBtZbybhD8an9939oDYDBPLgVWkkLxUb/gZjCmnhsNZhM802DEtr0WhxIloldfiH1Wts22Xx3hEPOsI+fN3oRnEniLnlsgAHzmRt2qleg2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196052; c=relaxed/simple;
	bh=sLhrfnF8dSizg/c5wOEza7Fobu4qwgdo33vs55Xb8qY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edwdVPmhvE8/xsf9jJpE6R63w8DjVkF/XIsaIMtFOLbawEkEEnGU89FoVsEqNuWWCmvdDALg+HAwpnfdjnT5adZENm9drccg8xX0hZB/UXYOSj0W+q844Yd9bfqTZJgmwLI7yj7FB62Olff9w0He0hvlPUmy6TnGDaRwKuRYrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 618be5b6-dff6-11ee-a9de-005056bdf889;
	Tue, 12 Mar 2024 00:26:20 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Mar 2024 00:26:18 +0200
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>, linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mips: cm: Add __mips_cm_l2sync_phys_base prototype
 declaration
Message-ID: <Ze-FCrkZuRiHIItp@surfacebook.localdomain>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215171740.14550-2-fancer.lancer@gmail.com>

Thu, Feb 15, 2024 at 08:17:26PM +0300, Serge Semin kirjoitti:
> The __mips_cm_l2sync_phys_base() and mips_cm_l2sync_phys_base() couple was
> introduced in commit 9f98f3dd0c51 ("MIPS: Add generic CM probe & access
> code") where the former method was a weak implementation of the later
> function. Such design pattern permitted to re-define the original method
> and use the weak implementation in the new function. A similar approach
> was introduced in the framework of another arch-specific programmable
> interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
> difference is that the underscored method of the later couple was declared
> in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
> methods in the subject. Due to the missing the global function declaration
> the "missing prototype" warning was spotted in the framework of the commit
> 9a2036724cd6 ("mips: mark local function static if possible") and fixed
> just be re-qualifying the weak method as static. Doing that broke what was
> originally implied by having the weak implementation globally defined. Fix
> that by dropping the static qualifier and adding the
> __mips_cm_l2sync_phys_base() prototype declared in the "asm/mips-cm.h"
> header file.

..

> +/**
> + * __mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
> + *                              L2-sync region
> + *
> + * This function returns the physical base address of the Coherence Manager
> + * L2-cache only region. It provides a default implementation which reads the
> + * CMGCRL2OnlySyncBase register where available or returns a 4K region just
> + * behind the CM GCR base address. It may be overridden by platforms which
> + * determine this address in a different way by defining a function with the
> + * same prototype except for the name mips_cm_l2sync_phys_base (without
> + * underscores).
> + */
> +extern phys_addr_t __mips_cm_l2sync_phys_base(void);

I'm wondering if you run

	scripts/kernel-doc -v -none -Wall ...

against this file. I believe it will complain that you missed Return section.

-- 
With Best Regards,
Andy Shevchenko



