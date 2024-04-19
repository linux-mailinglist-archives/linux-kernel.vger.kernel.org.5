Return-Path: <linux-kernel+bounces-150893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084DE8AA65B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19171F22084
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592A138E;
	Fri, 19 Apr 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsKULCgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0910FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487728; cv=none; b=UVXNSknqnC7+X83KI0eBzHRZg8KvP9WrjYsFGHxjHmia7/ynQRV4QWx6TIK6FNKs6unhJz+AxteFwR4BupdLfb02ofFOC/SxJhV2VwbecS6luYWInzZLcoVFl4DcXvpMBctKu1+T3lMzPwaEli91fa1x4BrgdQLpwOGLvYgm+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487728; c=relaxed/simple;
	bh=z3dsRoIho2UFcOVtKxoPrRld9oI+JpMNMnSKgMc1MOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDujayytjPOHN1LdVXJgDk0i/vQmj/JUYiPuNRk6L1tSJSthccmISif/2xzXOlG12VqyzRyTi/GLQ3Z+YzKVCBv+VXHIoF8afiLpl3PdmpiMIqZgFEEkKtWxk3bxnybA7hctDWZAlFgH8DJG7atxrGH36EpApPUX3mOEsClF0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsKULCgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7434DC113CE;
	Fri, 19 Apr 2024 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713487728;
	bh=z3dsRoIho2UFcOVtKxoPrRld9oI+JpMNMnSKgMc1MOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsKULCgSG7XE5q//CHVu+++9qUAwi+aKSRHANZgB6F2Y8YgdfILnwStBM9Yxr7yBi
	 j+j3UmvOxYxg/vACBOvYGwbanu81YRwUM1ySGAFkI0qh2YjZd1W7A4U8uIvEm65nn+
	 xMupZEAr1JjwukeySn0tQ0YfF52zJutTYUoQFARclNVHCNfcklpB2cnIHzCH8l+7Oe
	 HkB4N6EXaXQkbzYMu44BEJ6h3ydPc1aGylS3nNjCk9KGh1pwjbEVlY9ooAK/yce4SI
	 9xr3I/l6uIVI4vMwH891loIShfs9VoM69Iz2KauF70eI+zRwpfuaLrxMmKL+OJBrTn
	 nASf+If5AfCxA==
Date: Thu, 18 Apr 2024 17:48:45 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
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
Message-ID: <20240419004845.ker26cp3hslttslk@treble>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>
 <20240417164514.66hgypzxgqxt3ssk@desk>
 <20240417175723.r4si62d6oqirqadb@treble>
 <2a490bb4-fd00-46e7-b7c3-bb8ef962d8b9@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a490bb4-fd00-46e7-b7c3-bb8ef962d8b9@citrix.com>

On Wed, Apr 17, 2024 at 07:01:54PM +0100, Andrew Cooper wrote:
> On 17/04/2024 6:57 pm, Josh Poimboeuf wrote:
> > On Wed, Apr 17, 2024 at 09:45:14AM -0700, Pawan Gupta wrote:
> >> On Wed, Apr 17, 2024 at 04:14:26PM +0100, Andrew Cooper wrote:
> >>> On 17/04/2024 12:02 am, Josh Poimboeuf wrote:
> >>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> >>>> index ca295b0c1eee..dcb97cc2758f 100644
> >>>> --- a/arch/x86/kernel/cpu/bugs.c
> >>>> +++ b/arch/x86/kernel/cpu/bugs.c
> >>>> @@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
> >>>>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> >>>>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> >>>>  
> >>>> +	/*
> >>>> +	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
> >>>> +	 * considered safe.  That means either:
> >>>> +	 *
> >>>> +	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
> >>>> +	 *
> >>>> +	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
> >>>> +	 *
> >>>> +	 *   - the user turned off mitigations altogether.
> >>>> +	 *
> >>>> +	 * Assume innocence until proven guilty: set the cap bit now, then
> >>>> +	 * clear it later if/when needed.
> >>>> +	 */
> >>>> +	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> >>> Following on from the (re)discovery that X86_FEATURE_RETPOLINE is a poor
> >>> name given what it *actually* does, can I recommend s/SAFE/OK/ here?
> >> Or simply X86_FEATURE_USE_INDIRECT_BRANCH.
> >>
> >>> This flag really is "do I want indirect branches or not", which - as
> >>> noted here - is more than just a judgement of whether indirect branches
> >>> are "safe".
> > X86_FEATURE_USE_INDIRECT_BRANCH sounds good.  It's a bit long but does
> > describe it better.
> 
> Works for me.  Definitely an improvement over SAFE.

USE_INDIRECT_BRANCH is now irking me: "use indirect branch for what?
when? why?"

At the moment I'm leaning towards Andrew's suggestion of
X86_FEATURE_INDIRECT_OK as it at least says it's "ok" (safe or don't
care) to use indirect branches when desired (typically performance
raisins).  I'll probably go with that (or maybe
X86_FEATURE_INDIRECT_BRANCH_OK) unless anybody yells.

-- 
Josh

