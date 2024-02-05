Return-Path: <linux-kernel+bounces-52412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3B8497C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177EB28250D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D763171B0;
	Mon,  5 Feb 2024 10:29:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9A17582;
	Mon,  5 Feb 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128950; cv=none; b=BnEXBeOqbG4En9atHUgr9rTRTGK8gJTnhRk2OxKD85me4PZ+2VirdF7KBeVZcNQ46jbnHusSVTOpZLf10gtsqjYDhgw/6LMDZkK1jp9DdbjieOPBYK/J/KCgOpuLKa/nZEpjthdwQtCGBrYj2tV/nGy/Z5rsYTlxip+ekHao4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128950; c=relaxed/simple;
	bh=s0mnT/cdLHBbbew5fqdPMxLP/4VYZ1bC8Ao2a37JfpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm/82kY1BEZ+qGvKmVrfTdrc5TiVITYWZ7xzKWkxkG2oK7UaGNZZG3tvSgpp1MfPSLqny0EOppXqKZCOjDMqe8XIaGay33lXqVLkmz+gVlDuiIbrbtO26FRhOsUGbsXgTFz9XdOpwYSnWog3oEjEfbKIOXgui2Kah/zdEfImNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4441FB;
	Mon,  5 Feb 2024 02:29:47 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23ED63F762;
	Mon,  5 Feb 2024 02:29:04 -0800 (PST)
Date: Mon, 5 Feb 2024 10:28:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: nico@fluxnic.net, Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
Message-ID: <ZcC4aWWKFU1NgrZM@FVFF77S0Q05N>
References: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>

On Mon, Feb 05, 2024 at 05:57:29PM +0800, richard clark wrote:
> Hi guys,
> 
> With the ipi_raise event enabled and filtered with:
> echo 'reason == "Function call interrupts"' > filter, then the 'cat
> trace' output below messages:
> ...
> insmod-3355    [010] ....1.. 24479.230381: ipi_raise:
> target_mask=00000000,00000bff (Function call interrupts)
> ...
> The above output is triggered by my kernel module where it will smp
> cross call a remote function from cpu#10 to cpu#11, for the
> 'target_mask' value, what does the '00000000,00000bff' mean?

That's a cpumask bitmap: 0xbff is 0b1011_1111_1111, which is:

     ,- CPU 10
     |
    1011_1111_1111
    | '__________'
    |      |
    |      `- CPUs 9 to 0
    |
    `- CPU 11

Note that bitmap has CPUs 0-9 and CPU 11 set, but CPU 10 is not set.

I suspect your kernel module has generated the bitmap incorrectly; it looks
like you have a mask for CPUs 0-11 minus a mask for CPU 10?

For CPUs 10 and 11, that should be 0xc00 / 0b1100_0000_0000.

>  ~~~~~~~~~~~~~~
> 
> Another question is for the filter, I'd like to catch the IPI only
> happening on cpu#11 *AND* a remote function call, so how to write the
> 'target_cpus' in the filter expression?
> 
> I try to write below:
> echo 'target_cpus == 11 && reason == "Function call interrupts"' >
> events/ipi/ipi_raise/filter

The '=' checks if the target_cpus bitmap *only* contains CPU 11. If the cpumask
contains other CPUs, the filter will skip the call.

I believe you can use '&' to check whether a cpumask contains a CPU, e.g.

	'target_cpus & 11'

Thanks,
Mark.

