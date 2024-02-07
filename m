Return-Path: <linux-kernel+bounces-56989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E934284D261
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAEB21B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791985957;
	Wed,  7 Feb 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOxkl5O2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323878615A;
	Wed,  7 Feb 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335362; cv=none; b=aWUIREUi/xR8tX+WWt8Em7guQaP/dgX+84rchixxnfCwkIlKw3jmj6Hoxq8gy2283w9hChfmOLncqO+sQdC30x3DUme/jVf2ZQMo1B05A52XpM6JqdgCgTHeN2qNyVdmVRwfEcRSRpNG1zAWn+1wEAEEB33KT0SfagGrhNkdXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335362; c=relaxed/simple;
	bh=Qgto4wYZaGAjn9+btzk8CBsRBzPuQf1xeweWZoy1n5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhrNaxnjUcwVQniWjfrcAmDZwJCX0Mm1DZtIpt23w3/hLvHnxDXGgtF0LdZLqHYF4FEWldr04fcg5ZxPOPWDPVluLTJrwStyH06f9kphdj8VZf6mYA8Bn5XeyFlcEYE4yVWUZI4umf3Z99YHpiTHRYq9SfSYuiCz/eNxa6XR8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOxkl5O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1CC433C7;
	Wed,  7 Feb 2024 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707335361;
	bh=Qgto4wYZaGAjn9+btzk8CBsRBzPuQf1xeweWZoy1n5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOxkl5O29VIrTO+UZmB8d8ELCYblaTLg6nl8qrRxDdQ0/bmAgR1xrODVdtIIRMV4Y
	 baHLBj2QhOET5sbjIpQAdVGa2t0lW0WTP98mNUO5JuFlF95ypZ1Qu5gE+74IEAGph3
	 biRfPNE+ELgkiO4KDab+JZcZnsTIdiJ40PjAYR16vQGnBlhByxRtoJxGylIqxBJ6UH
	 eBvmm4cKpu9tXnRB13fgQs1dRxnzV1OClcqv0xkY7nGvpq4w3+jRWrArwSrtPs93jv
	 H2dj5ceOrff3GJtF/NTIU+VFqjuYqqw9WITrDSLkiqzzDLn6c3yBb1UZmcWQ9KWScH
	 qPw0b7RreZUBA==
Date: Wed, 7 Feb 2024 11:49:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240207194919.qw4jk2ykadjn5d4e@treble>
References: <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>

On Wed, Feb 07, 2024 at 07:53:28PM +0100, Borislav Petkov wrote:
> On Wed, Feb 07, 2024 at 09:50:10AM -0800, Josh Poimboeuf wrote:
> > And as you say, there are many frankenkernels out there and upstream
> > doesn't want to be in the business of debugging them.
> 
> Ok, all valid points. Diff ontop.
> 
> I'll queue it now so that it has ample time of cooking in linux-next.
> 
> Thx.
> 
> ---
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 612c9ec456ae..5a300a7bad04 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2853,16 +2853,5 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
>  
>  void __warn_thunk(void)
>  {
> -	pr_warn_once("\n");
> -	pr_warn_once("**********************************************************\n");
> -	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn_once("**                                                      **\n");
> -	pr_warn_once("**   Unpatched return thunk in use. This should not     **\n");
> -	pr_warn_once("**   happen on a production kernel. Please report this  **\n");
> -	pr_warn_once("**   to x86@kernel.org.                                 **\n");
> -	pr_warn_once("**                                                      **\n");
> -	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn_once("**********************************************************\n");
> -
> -	dump_stack();
> +	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
>  }

LGTM, thanks!

-- 
Josh

