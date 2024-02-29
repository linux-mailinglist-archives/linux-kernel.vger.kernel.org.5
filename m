Return-Path: <linux-kernel+bounces-86561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CE86C716
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6969828635F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2979DC0;
	Thu, 29 Feb 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LR15xKGC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFB651A1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203086; cv=none; b=JRQbWYZmQZnKm+v9o/RJTbxiLyjoHnmVcfa1q+enL5m3Uu9dxWzip6QbO8Tc7kZHKO3vrouCAbwU9OAcYQWU3MfEtrgTh1TofIG64qnUwtYSeXUshvXHolvh0FVjjtUYTGHAt6fxX6kmq0WKHi7QMw44wcHuiPtMNntXpbOwJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203086; c=relaxed/simple;
	bh=C1LH26YhXc3fHATx6eQEtJ6WdmRuT1TXi+gudRwwMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDUMBEv90AgHcCl2Nn0bSLKObYAAR08oIjZuDiyBRbq1MxooiWEk1YAH2pFfq9o5RBa4XIwujIAk4tdK4Squ2+Za4gIpP/uWL+ySRuY2e3rinljAWAyX4TrhRTgNSB67I8+L5Zo4plB3BYHv0OzpZL6bwlrdYxZh+d+WnE6+eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LR15xKGC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6DF940E0028;
	Thu, 29 Feb 2024 10:38:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qNk3YuGXQug9; Thu, 29 Feb 2024 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709203077; bh=0StLIprXskarneurs0igA75jz9KvpMszEkdlQp9iLBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR15xKGCawRu9vpsUebpRU7e5dQg2S8FI3uGokogXeFWtgGznj1saZkC5Y16bRWuP
	 JoPa+2lz0+10vUEczmM8A8l4j3N7m+E30D3lpdk7zPg1xGgIja94qNAfAHjx0KI9qN
	 BmIi5JmMgwJIwsmaBwPBnD8N3FqOP5lStc9zSVRH5J1EmBOvcJFD4wO8g7V2oojPAf
	 q66PetU2SEg1hiqlR7aMOmPpgyT6GTdd3B6NQ/Q9il1T54YNhvWUM06gmyfRVqZxY3
	 QiDCQnhMCrlbq/M81Qw4uxX5As/ABDaYlnwB1DWIIZWefitKRGmInBexM/86V4kgR/
	 nFIYF0ca17++/msxsYNVfZ+fGaOpzQuGXHY3FBkLG71qybIVn7/zCoHuDG0zC+mfzi
	 YOw3wdKOPcvktVmMApPJuERFWZCqvgPMD8gFVI3aWGswSuVlIBTwWzNPwG6JEd1Qg/
	 DwmbVZDBlQS0LaYWd+E0F6U6viizq8/Qa879JEldZjVgBWlTOdUWQNL8G5k+ybSkea
	 QXCqGLlXmAU4rUGMHF30lmdUqJe550d09xZdoGY1QMFW6WdezvhBr/LNZ5fpK/Z7tJ
	 i51h3e32dMb7k+vb4cK0Zdt54oYLTy0+NIuitbqwmt77+Rx7DmvYzDoQ8l+kBBc94J
	 ssZTJjuJXq36ZsOU502t9HDM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC52040E0196;
	Thu, 29 Feb 2024 10:37:46 +0000 (UTC)
Date: Thu, 29 Feb 2024 11:37:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 4/9] x86/startup_64: Simplify virtual switch on
 primary boot
Message-ID: <20240229103740.GKZeBedEybE0IeOXUG@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-15-ardb+git@google.com>

First

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

for the patch.

On Tue, Feb 27, 2024 at 04:19:12PM +0100, Ard Biesheuvel wrote:
> +	/*
> +	 * Switch to early_top_pgt which still has the identity mappings
> +	 * present.

I was wondering why we've had this "discrepancy" forever - the boot CPU
would have early_top_pgt *with* the ident mappings while the APs would do
init_top_pgt.

But we end up loading init_top_pgt on the BSP too in init_mem_mapping()
so there's a short time during boot where we have this difference.
I haven't found a reason to have it yet except "why bother"...

And now some details just for future reference:

On the BSP:

=> 0x10000a0:   mov    %rax,%cr3

cr3            0x9922000
111850: ffffffff89922000  8192 OBJECT  GLOBAL DEFAULT   22 early_top_pgt

(gdb) p/x early_top_pgt
$3 = {{pgd = 0x9924063}, {pgd = 0x9924063}, {pgd = 0x0} <repeats 509 times>, {pgd = 0x2418067}}

first two PGDs and the last one are populated.

On the AP:

cr3            0x2416000
104747: ffffffff82416000  8192 OBJECT  GLOBAL DEFAULT   12 init_top_pgt

(gdb) p/x (long[512])*0xffffffff82416000
$8 = {0x0 <repeats 273 times>, 0xbe01067, 0x0 <repeats 128 times>, 0xc000067, 0xc001067, 0xc002067, 0xc003067, 0xc004067, 0xc005067,
  0xc006067, 0xc007067, 0xc008067, 0xc009067, 0xc00a067, 0xc00b067, 0xc00c067, 0xc00d067, 0xc00e067, 0xc00f067, 0xc010067, 0xc011067,
  0xc012067, 0xc013067, 0xc014067, 0xc015067, 0xc016067, 0xc017067, 0xc018067, 0xc019067, 0xc01a067, 0xc01b067, 0xc01c067, 0xc01d067,
  0xc01e067, 0xc01f067, 0xc020067, 0xc021067, 0xc022067, 0xc023067, 0xc024067, 0xc025067, 0xc026067, 0xc027067, 0xc028067, 0xc029067,
  0xc02a067, 0xc02b067, 0xc02c067, 0xc02d067, 0xc02e067, 0xc02f067, 0xc030067, 0xc031067, 0xc032067, 0xc033067, 0xc034067, 0xc035067,
  0xc036067, 0xc037067, 0xc038067, 0xc039067, 0xc03a067, 0xc03b067, 0xc03c067, 0xc03d067, 0xc03e067, 0xc03f067, 0x0, 0x0, 0x7ffd3067,
  0x0 <repeats 39 times>, 0x7ffd1067, 0x0, 0x9b11067, 0x2418067}

and that one becomes the swapper_pg_dir which is the kernel pagetable we
use.

PTI then does two separate ones, which is a whole different topic.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

