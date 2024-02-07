Return-Path: <linux-kernel+bounces-56480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F084CAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E6B24957
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55459B74;
	Wed,  7 Feb 2024 12:25:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E6182A7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308729; cv=none; b=mzfXxMB/CONFnLiDI9w5kdS7z5ZD3/jJtRlZRepIxi9K5SNPgQMNwnGT0HoS95gn1CzJiEFifNMLVqClDe0xeRb15q0nBBeY926cUxGmzS10k65yLt1EJOqggUBi4N5OO2BT5f1reOCrQ0fMVm8vQHA0ZG6kYUnTOxHY4Z4bVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308729; c=relaxed/simple;
	bh=Bw085jWBVoB8uDXBI9aIXQekPKVTYwSsEUDtFsEatpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVpNYwsHumk1SqRkEKCPzBThZQRFHTj+xm9IgZ7nkT9IWBHeP3scPiG+J6RQOsV8wBDlnsnolJRcKE5OoQTKVO0z9nE6twz2sAU+QhS2ryoEnKRV+647xVwzmewEv35ejBlJOpkVX5ICDSF+2a9TZAB/usjJczCMaIvpZUWQJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB431FB;
	Wed,  7 Feb 2024 04:26:08 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821BE3F5A1;
	Wed,  7 Feb 2024 04:25:25 -0800 (PST)
Date: Wed, 7 Feb 2024 12:25:23 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] arm64/sve,sme: Refine scalable regset sizes at boot
Message-ID: <ZcN2syiQfgzdMiDF@e133380.arm.com>
References: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
 <ZcIS6ySfoGzwv31M@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcIS6ySfoGzwv31M@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 11:07:23AM +0000, Mark Brown wrote:
> On Mon, Feb 05, 2024 at 05:27:20PM +0000, Dave Martin wrote:
> 
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -9,6 +9,7 @@
> >   */
> >  
> >  #include <linux/audit.h>
> > +#include <linux/cache.h>
> >  #include <linux/compat.h>
> >  #include <linux/kernel.h>
> >  #include <linux/sched/signal.h>
> 
> Why?

include/linux/cache.h:#define __ro_after_init

(Yes, I was a bit surprised too, but that's where it is.)

Cheers
---Dave

