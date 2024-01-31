Return-Path: <linux-kernel+bounces-46550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F0B84413A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291AC1F2C765
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E281AB6;
	Wed, 31 Jan 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cJ5/ZaFs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477F80BF5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709675; cv=none; b=ezX3/5TVOG0e8Y3ah54nQPlnlGefEg4xcvR9VRRLnpx2C01s3pmeMwNdig2fw5JuORGQh8y6y4e/IBlAshErEO+uv1N1JOzU68lB7Wj454oU4yRKMx3rVayBQyG+d44+3lo81ZHkzVm7ge3osMAGPz8S2rIi0GGYPQGJgb7G388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709675; c=relaxed/simple;
	bh=VKftZjYTPFttrAWy4mQSvI4tODip6EMij2iomGHSEiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQUq/BAwdreFd8e227XeHf3XU2ExijPXpcd053HNL5/EJKEqhvxRfb9U98r4svZWl2ocE49Rl1aNl4HQSp3E7dVvHJDJ7+ZVXM52Olh2n+0SjvHSd8wWuELs44dCQQ8ph/TENKBI0YiAhfwFgE1ZFw+/jH04mwOqAmpuz7d/ANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cJ5/ZaFs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78C7440E00C5;
	Wed, 31 Jan 2024 14:01:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7-49zGRkOdZG; Wed, 31 Jan 2024 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706709668; bh=s1sCZOaViMd/RO2i16hNLSl0mKH2iujGzYJ4LY2cvoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJ5/ZaFsbMWoYYcHishCz3dIIdEdYYVKBTfA8et8o/ldP2dtie5NWD0J4C0hr1viM
	 x6rZvYgUejuftFvp5w5jxwfl8ZydabTzVU8l2JsRrsi0cNS53JhXSoClIpDC+W0Rdk
	 RJWjDhxzSkOCm3melsW8S5SksY2CCOGVjC7A465xuiCYvU7k7Y/5KTSGaMtW7IL5n4
	 /dJQT7H2o2K2lm0pGgq64nmdu+o88PkeWb9QTGxhUdWEM3n/xlXfA2TiNAqL8vfnAE
	 yaQ2rsriZQDIia57V970O1VgJ8zrZ3rdJSYJYFnmgxvKY7xHZujVwmYpeLAknnZtNo
	 7v6pljTk9tEVsZtaTb3XKXVP2ygW2mzoykW6PDcbAbJFTH6lKuhOvq5+8n7hG1CC0p
	 DdyZgJwpIxpY/kEtKwZc0gTMd3d4LoJNsbLuY7If0paKzjNUlH5QEHA/Y0TJIBnCsR
	 2SXXHBKMHPg2peo48EFoE//y50vzT7mbxPz09k/YFsI4nSfKgRbGSu8TnfDPPlVQ9M
	 LVkBUcSJJKaRHM/mkYSm9w25gspQIEqLmo4JSI4psMgfLy15yriKtFBUT+PsdRU5MY
	 ZJDydytR0vFmpiA5Y6wQuIWZaMgW3RxMVzxVl7RDf+rCOXsJ60fWXygyZaODBrYlaB
	 QEfPNJnuAVQvKDT7pMD3aqd8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B373B40E00B2;
	Wed, 31 Jan 2024 14:00:43 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:00:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
Message-ID: <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130220845.1978329-1-kevinloughlin@google.com>

On Tue, Jan 30, 2024 at 10:08:43PM +0000, Kevin Loughlin wrote:
> Instead, this patchset continues the approach of fixing the immediate
> problem of SEV-SNP boots crashing when built by clang, providing a
> backport-friendly set of changes needed to successfully boot SEV-SNP
> hosts and guests.

What use cases are those exactly? How do I reproduce them here?

SNP is not upstream yet and the SEV* code has been out there for a while
now without a single such report so this must be something new happening
due to <raisins>...?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

