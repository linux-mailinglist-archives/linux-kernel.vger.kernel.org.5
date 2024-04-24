Return-Path: <linux-kernel+bounces-157008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B220F8B0B80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B501C22C33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FE15B98B;
	Wed, 24 Apr 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cFuMhfON"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6B15B57E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966682; cv=none; b=t6bzUji4jfz+wctD6TZqtByfw0aHcEdw4rkQ2Zzrfnuo1jmz69o0TcVbdc9VvXEnwbOY+IOrfIOh5mAFNtrPZB8AKPQqdUhAo7aG9nTR+bGnWxg38dF3NHbm2Dxx72vIuYLn0hi1zznSSsPF5xQaGrFB7GyeVvfwlMIE8IsEKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966682; c=relaxed/simple;
	bh=Ru5nWKfEHKjsDt1vpqsF7Uu+ro/kn7zKfZdgh5xVHAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ2fYUvK52McCWdpxZNg5B6ZG/+QUWbfrZ3QZZNKNC9/07ksT/RKERtT1xCZxQ2WnELi6uX/wUgQW09WjhbzVsBL+RHqOnaaWrJ6UpAd1811RJn74UZLRD8ATLR+hfikDqL7sk5XJMVKW2NN3c1EGFW6PQxx00uP0KeaaoFLAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cFuMhfON; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EE2240E01C5;
	Wed, 24 Apr 2024 13:51:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JVrBxhuy33_y; Wed, 24 Apr 2024 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713966674; bh=EBY9JeX28ZOF1EBVDHZpilQ+UJ4BEt8eGoNz2J+9fsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFuMhfONd+yCpmn5H3a445TD59aoAoX05f1TAeGQIrB4wGQTfECpx/JK1k7YIkbRK
	 qy63iG7uHaFJumJCDLSbblC9RDeQBYmjg/uLL4CDGieFTYubdn1WmCtx0sZ0Gy0juZ
	 i31C/8Bt7oxGVPOf7uUng1GtjGbVJQTjrapfNosI8FsSwpdlRz73R3d/f5rjkffx9z
	 o5atlg87BSuqS4mvHRS21tEx8RRLFvk8COOVs5dhmmFa+4QGJtT2AerlH9G80DypJE
	 vFOZMJsijUu9ck0Rb5ZipCLmh8jxVDOZwoihsDoenjqmgYViideoERJh/Zq/nyHO1b
	 QPiarPweMFwrKIbo4qH+LXVodOS05jLZDYk0ZeKmONTze40fV3qo9U/KXBfY3tfc+z
	 4K0wc2hDSL2aTa7SvA3VjOQ0FEK70wgcsJB/S/g8Agt5l99B6SNUW3flSKIpEIGIPl
	 F3OfGv8pjypcu2gtuQJPJvTJtbkxneTGdqHFUKYvICFmegFcLdzbMn3jaANyKkTJEj
	 fKGiRW1yd8NM1I2rlaZUy7fSFZtwqffI5aiIguzJCdT/vmV7MA5aK/IL1maDGeq4cO
	 uCD2ncaKutVGK87r8E3J9d0fnfm9DrqqZJ7mlKr0MhRaA+h9Zd5L7ilqhrIraeqWMW
	 8J1zOivBIOjWzmyABaT+4+rM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 841CE40E0177;
	Wed, 24 Apr 2024 13:50:53 +0000 (UTC)
Date: Wed, 24 Apr 2024 15:50:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>

On Wed, Apr 24, 2024 at 11:38:42AM +0300, Kirill A. Shutemov wrote:
> It was wrong from beginning. If ACPI MADT wake up method is used on the
> platform, we cannot handle offline, regardless if it is TDX or not.

Sounds to me like this fact should be a prominent part of the commit
message and these 1-4 patches should be carved out as a separate set
fixing that ACPI MADT thing and I should take them separately now...?

Also, does this need to go to stable although it is kinda big for
stable. If stable, do we need a smaller fix first which is backportable?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

