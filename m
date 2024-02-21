Return-Path: <linux-kernel+bounces-75078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F14A85E2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0751C230A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A81213;
	Wed, 21 Feb 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HztFuJxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B907CF0F;
	Wed, 21 Feb 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531735; cv=none; b=TkzBE3EqZCzHSTeUSoqq1Ejiax5s2vX8d03KnniS6csm7BoWu6SNCVrgXefLvIPiVm7+OZ8tChYoK1GmTGeLKT07TBvJAqIa+ffK0ln63untxf/0AZ+pViKJ2Uhn61eZP5TSiEjJqtw3ncFloghHKHYQkO164IfwUsNIqIIK9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531735; c=relaxed/simple;
	bh=65OECqX9KxYAQydC9rm3J5R8qN/iq04mlYabKZdFS5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0EwwPQpD6BD6oikbl9HCVMpMuf7bv3HTJmIiiWUfLpG1k674Eej+yKb+njhdUdo/rmO+6fi0l7bztEd3+4y49CvgM+y4ZuwFCIwV4jA94d7VuYCGiqAB94yr9KHsxOR69KWe2QOumMlyq3J+Lwp8HcjMDPFouPmrZ1zyD8+O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HztFuJxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91373C433F1;
	Wed, 21 Feb 2024 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708531735;
	bh=65OECqX9KxYAQydC9rm3J5R8qN/iq04mlYabKZdFS5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HztFuJxseaQk0aYkeyC7H7JT1tB8CxESXcerSlvmnFx+KJKuYku4PjG3rzuYuv5MS
	 MHXznbwvVe1NKXst5Wr63JMcZEBYmHTm32SM/eF3avlfczRZKJ4RG5RN9yv/mTH47d
	 /bsQS9JfHR5yiPndbtTYqvl5zKkCz6GRm5bn16K4JZU03tfOaoHoHC29i9kiSs/2F2
	 ndM8ukJ5RLlTdp78vxD+E6pQ6x0MdNLqvqNU6goGHySWyxwxDcIxcXnYoS3PZymCt7
	 DpMUJBMFkPUzNky8TA5IZ91yqyTG+t+5PofaFWh58ItJKV0yV/PePTQq6ii07Q/l4N
	 bl03CPNN8bziQ==
Date: Wed, 21 Feb 2024 16:08:50 +0000
From: Will Deacon <will@kernel.org>
To: "ni.liqiang" <niliqiang.io@gmail.com>
Cc: danielmentz@google.com, iommu@lists.linux.dev, jin.qi@zte.com.cn,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	ni.liqiang@zte.com.cn
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is
 successfully written during SMMU initialization.
Message-ID: <20240221160849.GB7362@willie-the-truck>
References: <20240219091709.GA4105@willie-the-truck>
 <20240221152629.3656-1-niliqiang.io@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221152629.3656-1-niliqiang.io@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 21, 2024 at 11:26:29PM +0800, ni.liqiang wrote:
> >>  The SMMU registers are accessed using Device-nGnRE attributes. It is
> >> my understanding that, for Device-nGnRE, the Arm architecture requires
> >> that writes to the same peripheral arrive at the endpoint in program
> >> order.
> >
> > Yup, that's correct. The "nR" part means "non-Reordering", so something
> > else is going on here.
> 
> Yes, the SMMU registers are accessed using Device-nGnRE attributes. 
> 
> One additional point to note is: in cases where there is a failure writing
> to the CMDQ base address register, the testing environment was a
> multi-die, multi-socket server. This issue has not been observed on a
> single-die server. I apologize for omitting this information in my initial
> patch submission. 

Uh-oh, smells like a hardware issue ;p
I wonder if Device-nGnRnE behaves any differently?

> Over the past few days, I have referenced the kernel source code and
> ported the SMMU register initialization process. Through multiple stress
> tests, I have attempted to reproduce the CMDQ base address register write
> failure issue. The summarized results of my experiments are as follows:
> 1. When testing with one CPU core bound using taskset, the initialization
> process was executed 300,000 times without encountering the CMDQ base
> address register write failure issue. However, when not binding CPU using
> taskset, the issue was reproduced around 1,000 iterations into the test.
> 2. Without CPU binding, I inserted a memory barrier between accesses to
> the CMDQ_BASE register and CMDQEN register, similar to the modification
> made in the patch. After executing the initialization process 300,000
> times, the CMDQ base address register write failure issue did not occur.
> 
> Based on these observations and joint analysis with CMN colleagues, we
> speculate that in the SMMU register initialization process, if the CPU
> core changes, and these CPUs are located on different dies, the underlying
> 4 CCG ports are utilized to perform die-to-die accesses. However, in our
> current strategy, these 4 CCG ports cannot guarantee ordering, resulting
> in the completion of CMDQEN writing before the completion of CMDQ base
> address writing.

(Disclaimer: I don't know what a CCG port is)

Hmmm. The part that doesn't make sense to me here is that migrating between
CPUs implies context-switching, and we have a DSB on that path in
__switch_to(). So why would adding barriers to the driver help? Maybe it
just changes the timing?

> From the analysis above, it seems that modifying the die-to-die access
> strategy to achieve ordering of Device-nGnRE memory might be a better
> solution compared to adding a memory barrier?

I'm not sure what you're proposing, but I don't think Linux should be
changed to accomodate this.

Will

