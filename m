Return-Path: <linux-kernel+bounces-61779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8241851672
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4441F20FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CA4122D;
	Mon, 12 Feb 2024 13:57:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148AB4120B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746223; cv=none; b=YNx3cqnOUkbmSSscJoQvxlG5OzZ5x7FlIEAy/I5FKkmJEfPp9Asl9j2q31cnlw2GggV2xf5KVkq9hqr86CTaI0Z78uqxdCi44Q6tpyMX5NRYI3Qri0dWNlmwKmfvjgqcGy9sRqa8TbyI6wqzMx+RmfTjAICjlT35/rRsh9/Va6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746223; c=relaxed/simple;
	bh=4z3gTIlI+F/UIrX0bqne0rW0G3XiIiM2IPbFzQacyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaTics4OmpRY95EhOa69ZyvxchYhrTz/E5dTbpHDmtO/t1oSbUxKAPSypyXSfnqPdQA/WGGGkbfDHGs4vLFRUqth7N9tJAlAL17o8horfS9++Nw1oHBPBw9XLS9tXWC3cMdvTTv4nhMYWkvdYgvX0q1OwKkFDuG/dA+ZUe5FoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80D9ADA7;
	Mon, 12 Feb 2024 05:57:41 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F9C3F7BD;
	Mon, 12 Feb 2024 05:56:59 -0800 (PST)
Date: Mon, 12 Feb 2024 13:56:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Fast kernel headers: reduce header dependencies
Message-ID: <ZcojpuqGNToctwNi@FVFF77S0Q05N.cambridge.arm.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>

Hi Max,

On Sun, Feb 11, 2024 at 01:29:25PM +0100, Max Kellermann wrote:
> This patch set aims to reduce the dependencies between headers, in
> order to have cleaner code and speed up the build.  It continues
> previous efforts by other developers.

While the intent of the series is admirable, as it currently stands it's very
painful to review:

* Patch 1 is *gigantic*. 3MiB+ of plain text cannot reasonable be reviewed by a
  human. This needs to be split into smaller patches, and that needs a more
  thorough commit message (e.g. *how* you determined specific headers were
  necessary).

  This could probably be a series on its own, or could be split up along more
  logical lines (e.g. have a series cleaning up a *particular* case of indirect
  includes).

* There have been three versions of the series in two days. We usually expect
  several says (e.g. a week) between versions, and posting multiple versions so
  quickly just spams reviewers' inboxes and doesn't give people sufficient time
  to provide any meaningful review.

> As a preparation, the first patch adds "#include" directives to source
> files that were missing previously, but due to indirect includes, this
> was never noticed.  After the cleanup, many missing directives would
> result in a compiler failure.
> 
> The second patch removes superfluous "#include" directives, some of
> which may be a leftover from refactoring patches.
> 
> The third patch replaces existing "#include" directives with narrower
> ones, e.g. use "spinlock_types.h" instead of "spinlock.h".  This
> continues the work others have done over the years.
> 
> The remaining patches add new "XXX_types.h" headers with lighter
> dependencies.  They have only basic struct/enum/const/macro
> definitions and maybe a few trivial inline functions, but no "extern"
> functions and no complex header dependencies.
> 
> Just like the other attempts to reduce header dependencies in the
> past, this is just the beginning.  There are still too many
> dependencies, and the speedup gained by this large patch set is not
> yet impressive.
> 
> Prior to this patch set:
> 
>  real	0m34.677s
>  user	23m13.045s
>  sys	2m26.007s
> 
> With this patch set:
> 
>  real	0m34.464s
>  user	22m19.073s
>  sys	2m15.246s
> 
> (Building the directories kernel,lib,mm on ARM64 "allyesconfig".)
> 
> I have tested this patch set with:
> 
> - ARCH=arm allyesconfig
> - ARCH=arm defconfig
> - ARCH=arm64 allyesconfig
> - ARCH=arm64 defconfig
> - ARCH=mips defconfig
> - ARCH=riscv defconfig
> - ARCH=x86_64 allyesconfig
> - ARCH=xtensa defconfig
> 
> Pretty sure, other architectures may fail to build, but before I test
> all of them, I'd like to get some feedback on whether my approach
> would be accepted.
> 
> For more gains, huge headers like "linux/mm.h", "linux/fs.h" and
> "linux/sched.h" would need to be optimized.  Nearly everybody includes
> them, and they include nearly everything.

IIUC the same is true of kernel.h.

How have you analyzed this? Are you using any specific tooling, or has this all
been manual analysis?

Mark.

