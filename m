Return-Path: <linux-kernel+bounces-76373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DA85F658
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87A1B23C44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969B3FB1F;
	Thu, 22 Feb 2024 11:00:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66538F88
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599602; cv=none; b=GO/NP02VZk5TGj6qQvd3rGiqL7WmTXAyEGT65Ob8TOflzdvVsO35723cBId/6rcaydIog7UM83tparpNVyN081X4A8joNIxnpbckECRfLgYIRpsa8d1r0JJAQrEF3ze99C+dh1bQkLVEV2eIu3fDKQMn7lBvuX3ctl2+TnB0FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599602; c=relaxed/simple;
	bh=ItDxMt1okGzqHpdyO0Hqc0WQvStSr/CV/9RJDXHmRds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boRiQDrvJuf+vr0s7X2KHAShIM8qfWs0TuMPkwdLg9W1WcmgVnRBZyOQKZZL/hHG6fB2yqeaiZI8Rr03f2xRw5M41cY0ZAvttWhu3MFPpBC1qEcMndDA77f9hTqBJrPxYZVZ2AFXe/1+McIwCAfu4Z2QlVEmJS4UCugzPs43CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AED8DA7;
	Thu, 22 Feb 2024 03:00:37 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.79.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F3B3F73F;
	Thu, 22 Feb 2024 02:59:57 -0800 (PST)
Date: Thu, 22 Feb 2024 10:59:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: skseofh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add early fixmap initialization flag
Message-ID: <ZdcpJ2zoyHJuNkSD@FVFF77S0Q05N>
References: <20240217140326.2367186-1-skseofh@gmail.com>
 <ZdMx-svsHgrfguxX@FVFF77S0Q05N>
 <ZdPyWkOlUan5AI9r@vm3>
 <ZdSTMgxcWYsT9ECs@FVFF77S0Q05N.cambridge.arm.com>
 <ZdUyOAQG0TK1UtTY@vm3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdUyOAQG0TK1UtTY@vm3>

On Wed, Feb 21, 2024 at 08:14:00AM +0900, Itaru Kitayama wrote:
> On Tue, Feb 20, 2024 at 11:55:30AM +0000, Mark Rutland wrote:
> > From 5f07f9c1d352f760fa7aba97f1b4f42d9cb99496 Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Tue, 20 Feb 2024 11:09:17 +0000
> > Subject: [PATCH] arm64: clean up fixmap initalization
> > 
> > Currently we have redundant initialization of the fixmap, first in
> > early_fdt_map(), and then again in setup_arch() before we call
> > early_ioremap_init(). This redundant initialization isn't harmful, as
> > early_fixmap_init() happens to be idempotent, but it's redundant and
> > potentially confusing.
> > 
> > We need to call early_fixmap_init() before we map the FDT and before we
> > call early_ioremap_init(). Ideally we'd place early_fixmap_init() and
> > early_ioremap_init() in the same caller as early_ioremap_init() is
> > somewhat coupled with the fixmap code.
> > 
> > Clean this up by moving the calls to early_fixmap_init() and
> > early_ioremap_init() into a new early_mappings_init() function, and
> > calling this once in __primary_switched() before we call
> > early_fdt_map(). This means we initialize the fixmap once, and keep
> > early_fixmap_init() and early_ioremap_init() together.

> Thanks for this. Makes sense to me; would you post a proper patch
> so I can build and do a boot test, just to make sure?

I took a look, and Ard's recent changes to the boot code have removed the
duplicate call to early_fixmap_init() by other means, so we don't need to do
anything, and can forget about this patch. :)

Mark.

