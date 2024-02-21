Return-Path: <linux-kernel+bounces-74413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12885D3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4421C22023
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDF53D992;
	Wed, 21 Feb 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SxfhwsgC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AB3D978
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507766; cv=none; b=tYwKlu/gVXclhIZpElCxrvREb6p5/gfh3XGl57xSwHVr53icKcJnmh/OhdfY9eUlu0JojAqJEsi3wmg7uXsKF4sclbLBQ6Y+yXsF5C+EgbsQO+SX1EvI7LEdBLVNu2IjeYYbAII6ugs4QGCqlNdO5QXjxGv2i0QMqVgy8kQlIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507766; c=relaxed/simple;
	bh=4Vc7HxGCJCBdEvcUXfjDHhrhvUWknscrkDNj+P5ZK/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNF3CgMO/4mp/5kWS6TfQHaz2Ardp+RqULx0P/RQ3DZlPd9gURKs3htYdBCBN+fQOhubkgjO6nh11buESoLNEPiPdq2MnvwKO40kGisserjY2qh7GRPL0ER3vC1YRhmj/nj6cKP5Fns7FUyrj3TX8MxNS5oWUP+PDEIXP1PWnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SxfhwsgC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B914140E0192;
	Wed, 21 Feb 2024 09:29:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NNpfjFquBV7B; Wed, 21 Feb 2024 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708507758; bh=5OWcUB2i28C/avGcDKPGphCf3YxNQOUCc80paTP1JY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxfhwsgCVHKYUSK9XiFJBx4z8JA1z3/zmt7s1Wp1VkUdWZB6HAd3bbRtMYVexP+SL
	 IGbPrci+6kyeGm+WO+9q0WNROVI5DqRp82y0seG8JLsphe3lMeptz/RSqA6ZR+HkJo
	 ZPhsm8PRA9ccNMQ4oWXAorRu2uo2XH5zFr7c/WToASvixp7jdMUA9R01muzgflKYud
	 npRSp8pKxygsET766//EOqkdEX2EWNo5Dnk1ZGCuQXCGe1Kdyka8vBMAs+3/A6ixYb
	 mkVMj0Oszjn5cLK1eV+z3dmea0faI0eifs+KBytKx9ST79XGzeBh61m3lBb3SU8vOD
	 X8fase3JMQgMkBgOa/ypS0tergLTWMXXUk3ROcVrhnWz0tud5FlbZhb+ZGy3/Oz6TL
	 UnDT+ka/aE03vKNsKMiHkXxgTgHby9kNIOoW5/sB95xyawMvmv/AVFdHqwHd9psZbx
	 Cc1p9VS1kB6eIZ8hosCeIHcFae+eZx3UeRD1a+6RsFyhlYvDQt9Enxi0Q9HN0yMYxT
	 +ESmFE8aZULUhM+rZlRM8xzB7zhhL6LjLDqpOzXP3yvbVSIK2utkROKo8ZErHV68T4
	 Y3+PslF7qyJpuF4DROwDGh0I38CrejKcUu10LRWlx7PMONiVyhUgAQjJeDXihUj6EP
	 a2xkNcK7SNKPJLHIbRhT2q8U=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B96A40E01B5;
	Wed, 21 Feb 2024 09:29:02 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:28:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dave Young <dyoung@redhat.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>

On Tue, Feb 20, 2024 at 04:30:13PM -0600, Tom Lendacky wrote:
> I believe the issues were that different Intel systems would hang or reset
> and it was bisected to that commit that added the WBINVD. It was a while
> ago, but I remember that they were similar to what the 1f5e7eb7868e commit
> ended up fixing, which was debugged because sometimes the WBINVD was still
> occasionally issued resulting in the following patch
> 
>   9b040453d444 ("x86/smp: Dont access non-existing CPUID leaf")
> 
> It just means that if we go to an unconditional WBINVD, then we need to be
> careful.

Let's try it.

Dave, do you remember what issues

  f23d74f6c66c ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

fixed?

If so, can you try the below diff ontop of latest tip/master to see if
those issues would reappear?

Thx.

---

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..ec4dcc9f70ca 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -824,8 +824,7 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
-		native_wbinvd();
+	native_wbinvd();
 
 	/*
 	 * This brings a cache line back and dirties it, but

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

