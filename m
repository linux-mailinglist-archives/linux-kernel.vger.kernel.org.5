Return-Path: <linux-kernel+bounces-79579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4786246C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EDD1C21322
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159D250FE;
	Sat, 24 Feb 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZXKR2Pd"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F952260B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773109; cv=none; b=MYQAMrIjS2JKPvKV7M8B6owbyA6m3a8bTzXLjAdxNhsSRfLBVzDRjyOhIYi/k0DNgFxwdQ3NwAzdG7eF/Cy1Ue41idJGpOr0pwGJ0fnAD7degKPOFEW5VPO3dMBc4cj7p2kgB9/9cN2aPSmtIfqj/w+JntbIxpJh6v4mECTXZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773109; c=relaxed/simple;
	bh=Ri3QxNhCdWRUzxtt6K30VQ9dDXusNJ9qdsWwkYHGcH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un0CA/JCTY7QNjwbae6xLn2P8LzNBNZEGIyiTJJrKvD59SeYezT0im96lxxcMHHaVFkcdXyzpws3gf+MXibrSm1GMUITGVl+CKonHhes28fjJ/ogL7OrXxrp7gOK74vLYLHC9MGswDDxwZuqUiRv3OXbXMqZmuviBB9DBDiUuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZXKR2Pd; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Feb 2024 11:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708773105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQrVRzuuc7x4zdDY3sLDy+NO1SlXGxkB6DC5Uppljl8=;
	b=eZXKR2Pd1Av/I9U0Ezk8UX3ar7+YfQR9ykGcdg53Bk1TOg+ookw+EyPFAK2sLn7p4F/kj7
	7NV+FsLpg5Z2ZwWuN1/8xTQDQ5xVyfMiBbG2p7WdFYTMcYOA4LLLO+iub7pGskJ7UW7wRo
	Vk2iwcs7k6ApyTs5xY/hlNxxDLInrW0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH 3/3] irqchip/gic-v3-its: Print the vPE table installed in
 redistributor
Message-ID: <ZdnO7QIYkxgDdl0i@linux.dev>
References: <20240219185809.286724-1-oliver.upton@linux.dev>
 <20240219185809.286724-4-oliver.upton@linux.dev>
 <87bk869man.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk869man.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 24, 2024 at 10:41:36AM +0000, Marc Zyngier wrote:
> On Mon, 19 Feb 2024 18:58:08 +0000, Oliver Upton <oliver.upton@linux.dev> wrote:
> > -	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
> > -		 smp_processor_id(), val,
> > -		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
> > +	pr_info("CPU%d: Using %s vPE table @%llx (%s)\n",
> > +		smp_processor_id(),
> > +		(val & GICR_VPROPBASER_4_1_INDIRECT) ? "indirect" : "direct",
> > +		val & GICR_VPROPBASER_4_1_ADDR,
> > +		(page) ? "allocated" :
> > +			 ((from_its) ? "inherited from ITS" : "inherited from RD"));
> 
> From past experience, having the vpe_table_mask value displayed did
> help tracking VPE table affinity bugs.

My reasoning behind it was that the change expanded the table mask by
way of printing what's going on at every RD. But easy enough to throw
back in!

> This said, my problem with this patch is that we already have tons of
> these statement printed once per CPU/RD. This is really huge and
> accounts for a significant part of the boot time on large machines
> (64+ CPUs).
> 
> Before we add more of those, I'd really want to have a way to tone
> them down and only print them at runtime *if* required by the user.
> Kind of a dymanic debug, but driven from the command-line and present
> early enough.

Yeah, what'd be really nice is a way to enable pr_debug() on a per
file / driver / whatever basis, since turning on all of it becomes a bit
of a firehose... But I guess that's what grep is for.

WDYT about leaving it at pr_debug() for now, with the additional context
of what exactly VPROPBASE is getting programmend with?

-- 
Thanks,
Oliver

