Return-Path: <linux-kernel+bounces-140744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0AB8A189E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352FD286596
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0DF9C3;
	Thu, 11 Apr 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDwA6l63"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A914A83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849102; cv=none; b=tV/ARM7hW4zur1vKTn3Jj7CjUG+94NB1UjQW4bhyLHZ5Oa9cDb7TFDRvN+1bp/OGVDDY2aApbnnYvnHixfj3WpmkIJYbkwmFQAkPLDnewdbBl0e5oSYDiDKBI3XPvHlGu+slVfe5w+63mIGbcUpB2gE7Os3fOwi8yzIDDy8NYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849102; c=relaxed/simple;
	bh=txhQwj0RH6HuEI7sGViKR/jkLhrL9FSe2rh8HBbOiow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKjThqRdxAeRoAnObdpsVE6z0Z9UtUXNd7obTXPnOnOhmBM/u40zmBP4AY+IKbmzIfEcpRsf/nnjjSdFtL/iAHnTAG01maGV0suDGMd9s6rScBDWLrOhK9tumFDIlqQ2NCD6wIHhGOKiffKOEN65gL8fCWs0HjrPojLuePSr8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDwA6l63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E07C113CD;
	Thu, 11 Apr 2024 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849101;
	bh=txhQwj0RH6HuEI7sGViKR/jkLhrL9FSe2rh8HBbOiow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDwA6l63qRBVtrk5OEmaEso5morlwUcROxXGcUmH9UsHlslvvITD9RSG6K5xT5Y7G
	 UVL/KBHNv8ve8hqbm5tEMZTV1nj9TKK67L3cUYpcAlZujmlYzQKuuXUs/pDzpaFfs9
	 Sbmk4v+offDN3CM7daL4zGS562rhWXK2/opwpB7Z6XWCEyZwStqn8KSJgnW53N0vsq
	 +WbwqpTmfPQwngXrbKrJWrPe+nIEylZo+wNgh/+mJwwCQU3EXIaVlThlD2b+JXb/dM
	 D0NELXXd1Kt11xeqk4IEPa0FkGT0i1nuU/kNoJhs6rg9EQJ/4sM3rCGCneZNXrYViY
	 8dD+PjOY+gsDA==
Date: Thu, 11 Apr 2024 08:24:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
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
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/7] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
 CONFIG_MITIGATION_SPECTRE_BHI
Message-ID: <20240411152459.53ofd6hmhfzgi6td@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
 <ZheV2ly/LZjpaVTE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZheV2ly/LZjpaVTE@gmail.com>

On Thu, Apr 11, 2024 at 09:48:42AM +0200, Ingo Molnar wrote:
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1628,7 +1628,7 @@ enum bhi_mitigations {
> >  };
> >  
> >  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> > -	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
> > +	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
> 
> Uhm, after this patch there's no CONFIG_MITIGATION_SPECTRE_BHI_ON anymore, 
> which is kindof nasty, as IS_ENABLED() doesn't generate a build failure for 
> non-existent Kconfig variables IIRC ...
> 
> So AFAICT this patch turns on BHI unconditionally.
> 
> I've fixed as per the patch below, but please double check the end result 
> in tip:x86/urgent once I've pushed it out..

Oof, thanks.  The result in tip looks good.

We should add a permanent build time check to catch cases like this.

-- 
Josh

