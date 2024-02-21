Return-Path: <linux-kernel+bounces-74566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7E85D60C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C8B21F44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0B3C067;
	Wed, 21 Feb 2024 10:51:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86C5394;
	Wed, 21 Feb 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512665; cv=none; b=jvRLfFWNF7Gt5wai8oNw+Lw59lqVjcHSXF6lgfgwq2NHrHCT8ro1BQleReG3PSBkB0yU/9vsqntfrXGl+aaKzzULtDTOqXs0ALE5B1H7JPTkbKlP7pRjHcHNBF0LAEwuAzVfdv8f3rpoI1nkjzfnzflHww4RDdGoRCsBTIp6naY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512665; c=relaxed/simple;
	bh=hxDqSBhDoWiFtrkpgug2oDEHEdiM9hC7r5lwdm3fopc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUWMNmzrYr6TcPbA9Tb3brQVbN8FwFszJPDMbi8Aue2+3vk4tWUqtHsDKE4eBDYNJ84HNHPHeHrI0cAv78fcAd0AnbsF2s+3zs4s30tl9LzfQLhnoi9vM4hVuSL7dN/vDNAlMM0wM0X9dphRvvaqCwpnLbVshEEpHSm518Os6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D0CFEC;
	Wed, 21 Feb 2024 02:51:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214533F73F;
	Wed, 21 Feb 2024 02:51:02 -0800 (PST)
Date: Wed, 21 Feb 2024 10:50:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Message-ID: <ZdXVk41lSMLx_Fmg@FVFF77S0Q05N>
References: <20240215151642.8970-1-petr.pavlu@suse.com>
 <ZdON5rbsYFsoulxm@FVFF77S0Q05N>
 <1c6bb7d4-59bf-4887-8a0a-03373d3d9c11@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6bb7d4-59bf-4887-8a0a-03373d3d9c11@suse.com>

On Tue, Feb 20, 2024 at 04:28:23PM +0100, Petr Pavlu wrote:
> On 2/19/24 18:20, Mark Rutland wrote:
> > On Thu, Feb 15, 2024 at 04:16:42PM +0100, Petr Pavlu wrote:
> >> GCC recently added option -fmin-function-alignment, which should appear
> >> in GCC 14. Unlike -falign-functions, this option causes all functions to
> >> be aligned at the specified value, including the cold ones.
> >>
> >> Detect availability of -fmin-function-alignment and use it instead of
> >> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> >> and make the workarounds for the broken function alignment conditional
> >> on this setting.
> >>
> >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > 
> > I don't have a GCC 14 build to play with, but this looks sound to me.
> > 
> > Petr, are you able to test an arm64 kernel with this and DYNAMIC_FTRACE
> > enabled? i.e. build that, and check that function symbols are all aligned to 8
> > bytes using objdump or similar? That way we could be pretty sure there's no
> > other latent issue in this area.
> 
> I tested an arm64 kernel with DYNAMIC_FTRACE, in particular with
> DYNAMIC_FTRACE_WITH_CALL_OPS=y. That is actually the primary motivation
> for this patch. We ran in our environment into some incorrectly aligned
> functions with this option despite the kernel workarounds. They were
> reported as "Misaligned patch-site" warnings from ftrace_call_adjust().
> I don't observe them anymore with -fmin-function-alignment in my tests.
> Sorry, I should have mentioned this motivation in the commit message.

No problem; thanks for confirming!

Mark.

