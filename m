Return-Path: <linux-kernel+bounces-149023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6A8A8AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5621F251EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3C2172BD7;
	Wed, 17 Apr 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTDGtFsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132A172BC9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376646; cv=none; b=TiSsphPhu0jim7Ndr7fChUMOmorDj7Etd9kTHpzNAEry6fxSiJDgNL9sgA99QnJ4Nd6E7M6rz7Nr+f1V5hMJDIhA3KG4Mg0OE8D0iCKU88xKLkqpfWpHGVT7AeljgBQXKH9E8CEbnzO503/uGxKGMV6fhGk8JczMOoOKCGvrMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376646; c=relaxed/simple;
	bh=3d2ZLhWss3WpYFskVn7ql2myJj3BXlWA7VJpaBADf8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTApusvXQBMvw5o0gKhvU+BRsGA0u2G9ayF6HquvkpCXIUyDjojFJJawQRgBo6aRumzlFzyJZPLoYw9uzs61YY3TvWCAfz575Y6i3xbFwsZYLIBjsU+LdkuSrLE/RSLrSjeOLZv4gRqqgIumGf8ZRh1dle40CN+3rIfZVuTUQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTDGtFsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8293DC072AA;
	Wed, 17 Apr 2024 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713376646;
	bh=3d2ZLhWss3WpYFskVn7ql2myJj3BXlWA7VJpaBADf8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTDGtFsixswGNPPrmpqYl6s6CRY8pUO6WGUadHaGKJrRjlLd8Iz+KXWlowUQG99nX
	 LWB07IiKpAWm25E9qp+0DZGXHXDCiaNKn9DP2an2pz3bguUFK0BeXbo0x4tIQZU6ut
	 IgDJNPKPyuhP4/JbxCnnQhwQAkVYwwJrP/malXaDIC0Rbg0xsxEZEvNLPh+kGsgtno
	 dwVcy6+o7oL1K/pcBgzK8eOTcYphYJPjuqcjPOzUquPGq2J5UJY24n0+/OES9D944S
	 XpGwVMaLb123iTHENsZ5qzMFqht6/ToLU5xP3Y8elj8dY1TYG5ZQqCSManZYmyNuPo
	 xL2hUuJFPbvQA==
Date: Wed, 17 Apr 2024 10:57:23 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240417175723.r4si62d6oqirqadb@treble>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>
 <20240417164514.66hgypzxgqxt3ssk@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417164514.66hgypzxgqxt3ssk@desk>

On Wed, Apr 17, 2024 at 09:45:14AM -0700, Pawan Gupta wrote:
> On Wed, Apr 17, 2024 at 04:14:26PM +0100, Andrew Cooper wrote:
> > On 17/04/2024 12:02 am, Josh Poimboeuf wrote:
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index ca295b0c1eee..dcb97cc2758f 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
> > >  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> > >  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> > >  
> > > +	/*
> > > +	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
> > > +	 * considered safe.  That means either:
> > > +	 *
> > > +	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
> > > +	 *
> > > +	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
> > > +	 *
> > > +	 *   - the user turned off mitigations altogether.
> > > +	 *
> > > +	 * Assume innocence until proven guilty: set the cap bit now, then
> > > +	 * clear it later if/when needed.
> > > +	 */
> > > +	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> > 
> > Following on from the (re)discovery that X86_FEATURE_RETPOLINE is a poor
> > name given what it *actually* does, can I recommend s/SAFE/OK/ here?
> 
> Or simply X86_FEATURE_USE_INDIRECT_BRANCH.
> 
> > This flag really is "do I want indirect branches or not", which - as
> > noted here - is more than just a judgement of whether indirect branches
> > are "safe".

X86_FEATURE_USE_INDIRECT_BRANCH sounds good.  It's a bit long but does
describe it better.

-- 
Josh

