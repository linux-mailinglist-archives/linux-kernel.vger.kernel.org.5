Return-Path: <linux-kernel+bounces-162479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED18B5C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7C1C21F17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587A84FDB;
	Mon, 29 Apr 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FUNn8bg9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627682D66
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401944; cv=none; b=M3e2Mjz2Rg9z0uvv2q+W+YAtULlUarBI9LhRCfgGh2O28EOIZydTko0d5QbHe3Iy7CPABJ1cYpFZKiEmEwwsfZ2LxVLzhFU+3xg0RvAF4Ng2CsTiAIP3Gmbp0A61mEeKMTyZ24gPWsz2BwYlZBZlAaZrdrSrCAduvO/9qHEjgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401944; c=relaxed/simple;
	bh=F3uL5MsmUALtcFiI0QIew6cRHX+r6COGBnKC/XZwBKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lia8n6cWxzXpMPhnEJbG0lMq9EnF43Il7D4pPO/ItnEtDsqP0bHzl09JkRoBPHda9+BUFoDY0wdHTl7f3E62qrPRSOs1GoGr9cruEeV6UM8HFk+0RP0xIXUCedOHqhgKAqmMrtRGRwLjwHRVsKkS4olwxZ6YNQMAx6ypsfDCcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FUNn8bg9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 988B940E0187;
	Mon, 29 Apr 2024 14:45:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jEjCQhPIYrru; Mon, 29 Apr 2024 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714401934; bh=zZZ5uIl7gam0sGKCdhwGGAI2qvhYN93EKC+r3/GxU7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUNn8bg9UGoZX4EhU2jeGeFFFlf7QDHM+ueU/sCj+9gGAJJZ+ukCF7gmLndn3W/T7
	 4wo6lFaRBzYuoMZxNEOxZDHlaQQVIGpI+JuoAoHdE+y5mL8n+yRz3WhUr6h1PGygj7
	 ZxwFiqR+ReP4lmSemEYnF2ywcqgTZuZifGr2+Tl51SVgiD8cLnZUhst/8Aet9ARSx8
	 SyeE44n7EzN9aIHV6RM/VYemsLUZ/mpZiwpawD38w+G9iWJNd48S6WZfxq3S2BbR/e
	 mHQD1jEOyrd8V3zgfNjviPj3x7Imq5QQ13rDDBvYHsPf8nxZmO4gn53/MPB4/6P/qc
	 eJ948igKRf4i05fxNhN7XUc6DBmaWnkqk4jb8EqF8ckEJT+Qz/VwpjOAIr8+6FWVc6
	 a8aegJ1S3eXyZMQspheuU4KSquSlQHkg97gZKZ6fVYfnoIepRMzQzYUg0Thg0eAtP1
	 3TRwkRehYHz9+Av2qXTC4HhtVzgLw9CMdGeHPulRGTNh+ahz2ptH0WY0tinNdfZHdg
	 1j0VXg8ljcNktUTniiXGKiW36ISjlip+f/FJbpP19sDGVkpqolIEpHW3lwzqH64T06
	 YYRwBGaB2Agmht8+OaiU5fRNib5gJAM+FyFqoeVMlkixNUDjda8OwVkFAaFkZ1eqfZ
	 jXwe/f5Ydu72Ky5gacB+n9Cc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A689B40E00C7;
	Mon, 29 Apr 2024 14:45:14 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:45:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>

On Mon, Apr 29, 2024 at 04:17:38PM +0300, Kirill A. Shutemov wrote:
> As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
> platform.

You mean when identity_mapped() runs as part of a kexec-ed kernel, it
might clear CR4.MCE and that would trigger the #VE?

So, if that is correct, you basically want to *preserve* the CR4.MCE
setting across kexec?

But then __mcheck_cpu_init_generic() will go and set it
unconditionally.

So what exactly is the correct flow here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

