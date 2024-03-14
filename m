Return-Path: <linux-kernel+bounces-103332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53987BE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A271F21E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AE6FE1D;
	Thu, 14 Mar 2024 13:58:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3E59149;
	Thu, 14 Mar 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424682; cv=none; b=TbGwcL0q063y80KBTeH46II8wRNNWPFPyjyYivvpwT5ZrvTBx2sYZZsfhJXQtpmXXKxr9tNPCAxCefpx+l9TCa7g0zDmdOvTrz/H1NbSFYPfmHeyTJPsZnH2BAi9TSw1bEyYUbC6RmzVgsQvvUe0GIEmZ6lBMkzstSYsSD2jD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424682; c=relaxed/simple;
	bh=dN4BV68IDf8HGWh30bz2lvsC1qhK7iq0GQPEZC4iLFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7UBXf5jkDX1z3p6ZFRFOLSQC6iYgHNfJUqrYh5HS2Y8CQBWe69/K7IwOGdu8nEYwLnVQXSQ9G9uY41ZG9kQdGIE9I6UtLZ8ksD4iS4DYRmZrN4tkmly+fosgb6bY+a/gb3wikTY0Hvocgc1hnIGCwW9roJObUUZ+b23NM2lS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6083BC433F1;
	Thu, 14 Mar 2024 13:57:57 +0000 (UTC)
Date: Thu, 14 Mar 2024 13:57:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfMCYl7GffVcLEUN@arm.com>
References: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
 <ZfCXJRJSMK4tt_Cm@arm.com>
 <ZfG5oyrgGOkpHYD6@bogus>
 <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
 <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk>
 <ZfK30r8M6zx2aWU6@arm.com>
 <a210104f-a3af-4554-b734-097cfa77a470@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a210104f-a3af-4554-b734-097cfa77a470@samsung.com>

On Thu, Mar 14, 2024 at 01:28:40PM +0100, Marek Szyprowski wrote:
> On 14.03.2024 09:39, Catalin Marinas wrote:
> > On Wed, Mar 13, 2024 at 05:13:33PM +0000, Russell King wrote:
> >> So, I wonder whether what you're seeing is a latent bug which is
> >> being tickled by the presence of the CPU masks being off-stack
> >> changing the kernel timing.
> >>
> >> I would suggest the printk debug approach may help here to see when
> >> the OPPs are begun to be parsed, when they're created etc and their
> >> timing relationship to being used. Given the suspicion, it's possible
> >> that the mere addition of printk() may "fix" the problem, which again
> >> would be another semi-useful data point.
> > It might be an init order problem. Passing "initcall_debug" on the
> > cmdline might help a bit.
> >
> > It would also be useful in dev_pm_opp_set_config(), in the WARN_ON
> > block, to print opp_table->opp_list.next to get an idea whether it looks
> > like a valid pointer or memory corruption.
> 
> I've finally found some time to do the step-by-step printk-based 
> debugging of this issue and finally found what's broken!
> 
> Here is the fix:
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8bd6e5e8f121..2d83bbc65dd0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, 
> int cpu)
>          if (!priv)
>                  return -ENOMEM;
> 
> -       if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +       if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
>                  return -ENOMEM;
> 
>          cpumask_set_cpu(cpu, priv->cpus);
> 
> 
> It is really surprising that this didn't blow up for anyone else so 
> far... This means that the $subject patch is fine.
> 
> I will send a proper patch fixing this issue in a few minutes.

Nice. Many thanks for tracking this down. I'll revert the revert of the
CPUMASK_OFFSTACK in the second part of the merging window (I already
sent the pull request).

-- 
Catalin

