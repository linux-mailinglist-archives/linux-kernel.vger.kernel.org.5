Return-Path: <linux-kernel+bounces-51036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B8848552
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C01928695E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727085CDD0;
	Sat,  3 Feb 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k7SLT0z1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA92A8D7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706959563; cv=none; b=A1MEZslBCwisEzNMHbl3GGO/ZKar/+JSTAVsaFQwAMYr+3DeajWF7IgMZgzT6T1TiEXZCL+0ZoldFJgnUFyyYnxRuoV2Of7Vru7zwdBua7P1ECFkzmexKnxNBVqqlj7KJpSIAoy9dxme2CZEl+UptfWCs4Y8eeegLe3kdPpf/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706959563; c=relaxed/simple;
	bh=3AnlwDJY1PiOq3jo238nrekVn4FA6LanT3SjuGnUNFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB+AZ2Oan3+hxAWvWmu5ao369ogJOBiTwBJQMGRcBKMcZ93ZzTVb7FO8lBX4XS8qJ6CvOJeHl/VsYqxHNe519d7O0NDUUluaFuwX6U8VdkTjnOQ03/4XlKfAiEMOrEo4pb+TKqzQTGED42F52bAYkPiVfkVJPBHuRLM4QGrCFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k7SLT0z1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A7C0E40E016C;
	Sat,  3 Feb 2024 11:25:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZZdsozVbr2fC; Sat,  3 Feb 2024 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706959556; bh=GuG1PrL37XWGzIIK0mw2Gt1HAsW61W8Mi9u163lCSVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7SLT0z1a6VwwSd1j6S+NY5WVLAG6pKXTHAfSLkGHYdDXtvi4ZN68CwMjjJT7v41Y
	 QBl0nQasVgluTRQ9OC12wu8bpJl+fpBzQOS7upk59vFyqDBtBhy0JxGDjJZGqCed7t
	 Q1W21BKWILSodbmMtbFfgojNIr3nqGaUP7dq+Chr0Dh4lNfRgNonqj5bE8xl2WKkMN
	 xC9W0h1g4t7DpKlrtY1d6NCLwh4OPIfriSkZko03vHUtAKTOwB2FqxzcCMVoDSvHeL
	 FRd0NhWcqUxz5ikbinA0rEb3vgTrH1mXNa7SkDQA1VoeQQuzRmOo60F4TVm7U9jr5M
	 4OTbjFc4+XquvVGXrTwQZITf8rp0O/ykfu2o3KxoA19HLkeKuFD28MevrFK7ssd9H9
	 vH1tRO628mjwcnFV3owV1PLOJJw7xO238IY1EhdexfTAf0myJeDIECqlL+Iq/wF/Em
	 /LHXj0FDLZMhNqlf9cHUhoGqYYztpsIQ5vfCbd1pRq1vPO9gm+Fntebevp/LBVKgcg
	 xeH+8AN1IiJsTDccYdQH874BmcwgCG7Mvbmnt2P4iTYeYTlRV57x4ThyNMc/nBRr+6
	 ZvmNPwZERyrObnv3IxSQtSbayNUwTjfOnPzm0NGIwFEVPNge1Ihi5PKLByux7DGVlV
	 /tkluTSi9W/JstENo+WUjV3s=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6D4B40E00C5;
	Sat,  3 Feb 2024 11:25:31 +0000 (UTC)
Date: Sat, 3 Feb 2024 12:25:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>,
	Jacob Xu <jacobhxu@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
Message-ID: <20240203112526.GGZb4iphr6YR5f5QNf@fat_crate.local>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com>
 <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
 <CAJ5mJ6j-Vw2P=QLK-J_J79S35UggvZPtm5sia74=enR1qq9X9A@mail.gmail.com>
 <20240131182944.GJZbqRmBN_KDgK_nmB@fat_crate.local>
 <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>
 <20240203101927.GEZb4TL2H3XTqCSo5d@fat_crate.local>
 <CAMj1kXGh9pw0U=+-Pg8Uh4xzNhyDZBDvGC7jcnCYvmTQxaUZTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGh9pw0U=+-Pg8Uh4xzNhyDZBDvGC7jcnCYvmTQxaUZTQ@mail.gmail.com>

On Sat, Feb 03, 2024 at 11:27:19AM +0100, Ard Biesheuvel wrote:
> The minimal fix doesn't look that bad IMHO. Note that this version is
> based on your patch that removes
> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT, and we'd need to see whether
> or not to backport that as well.

Ok, please send it formally so that I can take a look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

