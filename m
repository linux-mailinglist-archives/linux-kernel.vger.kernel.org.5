Return-Path: <linux-kernel+bounces-160306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6C8B3BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89B21F25066
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56F14901F;
	Fri, 26 Apr 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WaOCu6wW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D7148854
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145706; cv=none; b=ZcbBxr9HiaWszNgtCs62zqOjCGNoxGnkFcCUpg4vgZCxVTgYmAOXvm9qX9A4lQ8pesNBjn3TcYjx5cJevgUFibFWyZmjTtknFl3NtUqGoCJO5y7ZEs1AnoGLIUN/nkxRKYAECozBwqZdu83YaZnxtL6U7tf6MMEB1cLPN/QhNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145706; c=relaxed/simple;
	bh=hyxcIMkRQWAKyBamxAO3Hwum73Pll6GasPpR2BAxOUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXRXx9xh1xEk9Gup6IcTIBViI9LndwasUocMZrsBcTjOgjXsMP3JnaVZstXlnbc07YhxxrdBMZ6U7CEeHStOR49iK+zJZXyecgusvLaBvW61vrDmMlKdzNBsdZJ+IZ6xE7QUiZz34sjsTi3X6FIlKjM/BktHwSr3afdpcyNIj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WaOCu6wW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EA7340E0187;
	Fri, 26 Apr 2024 15:35:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y0I0XX85N4vT; Fri, 26 Apr 2024 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714145697; bh=075frEUodZiVoP0luxda7AkjREYnqrV4QquOdVqaK9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaOCu6wW5+hAYb3VNxSHy0uXO0ug44b8nFbNgfqBeVqUijxNlL60tiulCQhQ656EH
	 +umGjHofXzVh9uqFUZhD8PV5KIZLQEZdSIfk0ABlNgJV/I8aigPSmigofDXETJF7lR
	 gYJOAGfZvcVigL0+apZahn53U3qcsU4j3Q0dIlTmw6SWu5+qq7Dc2QO8XMK9GEwPkQ
	 6BuRFvp0ky49u3y8S+/hVZKpwt60VjVO4ItNVpigpgp6GXaB3yWIazHmBazSIiYojy
	 FEKirILHy8PfHuIMrPLaAFP4gCnkDWTg6qpoTp8JUFCHWPpHa0BdAizh38aCSDW4rF
	 RjOSv1IjkuTYwJPqRlfnRJZxAMwYIGyf3CIYQW2DoH+maegwnGFg0v8doQXMKNu2lp
	 Q/CqXV0jN4JhWy40bAbgTb57rBj2sX1Gr6PAGdWcXZZeqGdcXk59vMC3Ef1RpIOho0
	 bEgJMA51lZQ3ln3OZBPVDAfV2+uby+yZmg6BHa2Au918k47eN2Yab2M9tNAslboo4C
	 kyfv0NfZf3zAGIS3/FSRmx1RJDQnmHnu+xoifiFsEB1zmXZuRZX2U+C0Xve+j9Y82d
	 NxF171TyeoAevmpen5YUYcVil+u1PCg9LFR32ozcOZ6LmsOygjeYnkWjxgG28W7n1+
	 hGMVkDXmNpz3ysHRMTFacLj4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B01540E0177;
	Fri, 26 Apr 2024 15:34:31 +0000 (UTC)
Date: Fri, 26 Apr 2024 17:34:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426153425.GGZivJgbBxzo30ja8V@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
 <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
 <debd333e-6897-476a-97fc-02246e97a24c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <debd333e-6897-476a-97fc-02246e97a24c@amd.com>

On Fri, Apr 26, 2024 at 10:28:41AM -0500, Kalra, Ashish wrote:
> "Chained guest kexec" is when we are in a guest and kexec-ing into a new
> kernel and then this kernel kexecs into another and so on ...

Make sure to explain your terminology:

$ git grep -rE "chained.*kexec"
$

and there's nothing "chained" about it - you're simply kexec-ing in
a loop.

Please don't make it sound more complicated than it is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

