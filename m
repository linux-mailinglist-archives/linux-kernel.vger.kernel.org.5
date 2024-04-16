Return-Path: <linux-kernel+bounces-147491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4238A752B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F92845BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31213956B;
	Tue, 16 Apr 2024 19:59:09 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E684E19
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297548; cv=none; b=dN4gX9yZCO45FYKIIvJAotitQELKILdw2JWSQ7Q2v7O0vjDgVnu0+s1CUhO9ilQi/pAYbdYFy2cFiUa9HWt0F+xSAiAdbdeja7RXH3pmot4+3dNFLx//L7sTv9/3LcJqfwsBDHpz80INEZcyWsIeHR5AqxIethgkGzcTY8jGMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297548; c=relaxed/simple;
	bh=0EBCCL+vb1UuGx3n24FYfvKlrLsXR6b7pZrb/Cerjjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQEkQKB0ZGU4sKZQ0WwIaT0jvNXLTVCdXvWE35HGW8MjbM4s8OV9j74DNOB1JDAjF/B1NC6kXFec7PqGDqNFIwhhl33SURlvILudojR1onXvGqkGB0Ux4Fad+V5kIaqow4NgBRcY8V3scXOnFkouh+oM5swoMeo6s6zifbG799k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A9E4A40E0187;
	Tue, 16 Apr 2024 19:59:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D_3Q3eApkcCs; Tue, 16 Apr 2024 19:59:01 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B62D840E016C;
	Tue, 16 Apr 2024 19:58:56 +0000 (UTC)
Date: Tue, 16 Apr 2024 21:58:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local>
References: <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
 <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Apr 16, 2024 at 06:37:18PM +0000, Luck, Tony wrote:
> I thought to get the first three into TIP, and thus into linux-next. Then I'd
> start posting patches to the individual files to their respective maintainers.
> 
> Only about half are arch/x86. The rest are scattered around the tree.

If you do that, people would have to merge the tip branch which has them
before they apply them in their tree.

Alternatively, we can take the arch/x86 parts and once 6.10 releases,
the other maintainers will have them in tree and thus not need the
cross-tree merges.

> But if you'd like to see the whole series in one big mail thread, I can
> post it all.

Or you can post the whole series and we can take it all through tip once
the other maintainers ack the respective patch for their area. Which
sounds like the simplest solution to me...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

