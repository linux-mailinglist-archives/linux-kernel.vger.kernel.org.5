Return-Path: <linux-kernel+bounces-56847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF784D02F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD51C26A74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21783CC3;
	Wed,  7 Feb 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdFmysLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDD8289E;
	Wed,  7 Feb 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328212; cv=none; b=Jv19meBGRiTpdAOCwW2X+6J+kQyIhKREPnXi09u2GToq+ymxegFG5QqtjqyKKuX/Je/1UV+L73k77FP3PDAQ9jk/tdnBVO41nU2Ld0BF8RaY4krfqJsyWXp9RBvP30uV9Fk9ZcOUulHwByCv5zw63wra0QowT3PYZXuZ+Qu2vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328212; c=relaxed/simple;
	bh=e4OieDXugUbycX0Ukl/FK2SvO3wPox5ygphY9IQdy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blNZlXRwM2/DiD7hydoab/BmbCrOiQCLDl+NFw7ckHvK2F5wKeafK/7cP7eeTIS6plDS98O6kQTuYLiidbwKW7AgTXzkoI2e6D7t70J/FoEuUgk4pgQyn5W6A+KVTssKc9vcSJLaGBfuUqfqIWVV/mi8BNfheWJa7JiTdMWDCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdFmysLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E368EC433C7;
	Wed,  7 Feb 2024 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328212;
	bh=e4OieDXugUbycX0Ukl/FK2SvO3wPox5ygphY9IQdy/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdFmysLtNzkVSD8/E229C6W3BqAH5WboXvD96/8v0jsedBQZr102argp5QPRMjahr
	 b17lBPt368dUPwiqTjoWl1rFoxOqx7dRoABFCifJmdrooCoIvmEXHII2wdo62JTKwo
	 wavUmgfp8nR6zMhSH3gswUsfLPZkwLk/gRwA0wuGpKRvfjRXSc0AlqpV97uLO5hLkT
	 ZSWWCOKVvStHIVBRl0IKv1XVOEE6Dt6EJH2me95p54P52vrmetKPIO8niywgIz2O/f
	 u+GlpwOyyzlYVISMI29/ihAhfaJM2elSfmn6DeUkg19OyQ/JpT11c/anp3KIEeyTzs
	 NQw/U52wn+bLQ==
Date: Wed, 7 Feb 2024 09:50:10 -0800
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
Message-ID: <20240207175010.nrr34b2pp3ewe3ga@treble>
References: <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>

On Thu, Jan 04, 2024 at 02:26:23PM +0100, Borislav Petkov wrote:
> On Thu, Jan 04, 2024 at 02:24:46PM +0100, Borislav Petkov wrote:
> > +void __warn_thunk(void)
> > +{
> > +	pr_warn_once("\n");
> > +	pr_warn_once("**********************************************************\n");
> > +	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > +	pr_warn_once("**                                                      **\n");
> > +	pr_warn_once("**   Unpatched return thunk in use. This should not     **\n");
> > +	pr_warn_once("**   happen on a production kernel. Please report this  **\n");
> > +	pr_warn_once("**   to x86@kernel.org.                                 **\n");
> 
> I'm not yet sure here whether this should say "upstream kernels" because
> otherwise we'll get a bunch of distro or whatnot downstream kernels
> reports where we can't really do anything about...
> 
> Hmmm.

At the very least, the dump_stack() should be a WARN_ON_ONCE().
Otherwise this is actually *more* likely to be ignored since automated
tools don't have a way to catch it: no taint, no "WARNING" string, no
panic_on_warn, etc.

But also, I'm not a fan of the banner.  A warning is enough IMO.

Many/most warnings can be "security" issues.  A production server which
ignores warnings/taints/etc would be a much bigger problem.

And as you say, there are many frankenkernels out there and upstream
doesn't want to be in the business of debugging them.

-- 
Josh

