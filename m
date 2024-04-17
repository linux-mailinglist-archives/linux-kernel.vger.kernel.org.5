Return-Path: <linux-kernel+bounces-148741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1888A86D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36685283376
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70669146A70;
	Wed, 17 Apr 2024 14:58:12 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B178140E3D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365892; cv=none; b=aymR3+ItFnLYuhNmaBvJIzjheapJc+42qXfsKJC8e8HgqiFU6piftmw8QNVkNppCYXv4yGXIi4IFBr5uvO20uZGh/7OEcQM1Lt8oH+q6V5wEASeHZcMHZ7BxbJ6A8eTrps748bZ0nzsrqDBCCE5HqzDr4tHBtWr9jVgyfRQf9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365892; c=relaxed/simple;
	bh=2xyj0NTxTG4WCIsfGF2Dj9gu+EMZjKYzqcfchrNiejM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz5o/BN+OgTRBL1UI7KPTmr9Cvmjgd80gxKdDwKIX+TZHg2RldRe+IuqKK+FpiuKTfXrkyKLjekWtsODT1AvR1kvGCmlgOmeDKdFVyFIWlaJgvl2MkbRz2amJnvia3bcwflCEjEkPdf/bZR3Mb+mofLzlL93IuwOYrMNHx/HvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C152A40E0187;
	Wed, 17 Apr 2024 14:58:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4DOFZVzoP8VO; Wed, 17 Apr 2024 14:58:03 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3E9440E0028;
	Wed, 17 Apr 2024 14:57:43 +0000 (UTC)
Date: Wed, 17 Apr 2024 16:57:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240417145738.GDZh_jYguUrkT9QlXp@fat_crate.local>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>

On Tue, Apr 16, 2024 at 04:02:21PM -0700, Josh Poimboeuf wrote:
> Syscall hardening (i.e., converting the syscall indirect branch to a
> series of direct branches) may cause performance regressions in certain
> scenarios.  Only use the syscall hardening when indirect branches are
> considered unsafe.
> 
> Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
> v3:
> - fix X86_FEATURE_INDIRECT_SAFE value
> 
>  arch/x86/entry/common.c            | 15 ++++++++++++---
>  arch/x86/entry/syscall_32.c        | 11 +----------
>  arch/x86/entry/syscall_64.c        |  6 ------
>  arch/x86/entry/syscall_x32.c       |  7 ++++++-
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/include/asm/syscall.h     |  8 +++++++-
>  arch/x86/kernel/cpu/bugs.c         | 31 +++++++++++++++++++++++++++++-
>  7 files changed, 57 insertions(+), 22 deletions(-)

I poked at this a bit and can't find anything that I can complain about
so

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

I'll pick it up into urgent if no one complains soon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

