Return-Path: <linux-kernel+bounces-52696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3850849B89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FA1283EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11018210F4;
	Mon,  5 Feb 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1BIwV8G"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D8210E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138874; cv=none; b=C7WKyzi0O6BTfMxyD+nwSR8Zf1iwm79EV3F0iGJohUJ5bPuMBtqrUVyotbqCvpmXkuUKL/s8Ng4ETk+qX7dVQaV8Q328Mh8PJLM5MMQhakCVPtzhOEftLX6wmtuF2GkDd9kXmuXMoyfz9EwHXof/TOM+xnyNQm7UJ65vBiE0XOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138874; c=relaxed/simple;
	bh=J1GmP1t4NYGlDzzJ87ekuY0mdt+8xwjuMbfgT9IruSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDfM3DYNpI4Wzc45EQ7cYCFMe4RS5dioaJY5ehhK7VaHjSBk1zWe6z9ui2xPQF5tO9r0cGEFYmwIklCtoFt3pBdOiG4ByqdNqGKbC3UUdTg4iFddOUEE8gXAu0l2uJueOQ1xAnZx9T4Mt7owRm7mKBw3siqjFxyRPuwjUbtTfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1BIwV8G; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 13:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707138870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXlHs13xGBsXqCF4G2IH5TZvDGaNtuoQs5bbO9vA6Os=;
	b=o1BIwV8GwpwSfWVn3WD6Xc9WB2EAZEDkvLoaYJLIPatKtCzQiom7hG4rkW+eT7NXHGYBOu
	STN7N1Mzto91nXIa2diKYNByLJatjk+xiZaFg+ekUTZMw4XM04FriGWBqdiBVSU6ky0m5p
	M4LaLDbztoq4HTL57+UK78BJZuccD9s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: will@kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 02/10] KVM: arm64: Add ptdump registration with
 debugfs for the stage-2 pagetables
Message-ID: <ZcDfM2VRiTETM04I@linux.dev>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-4-sebastianene@google.com>
 <ZYSAfORj2-cXo5t_@linux.dev>
 <Zbt-leieTD64ZefR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt-leieTD64ZefR@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 01, 2024 at 11:20:53AM +0000, Sebastian Ene wrote:
> On Thu, Dec 21, 2023 at 06:14:20PM +0000, Oliver Upton wrote:
> 
> Hi Oliver,
> 
> I am planning to split the series based on your suggestion and I
> wanted to make sure that I understand your feedback.
> 
> > On Mon, Dec 18, 2023 at 01:58:52PM +0000, Sebastian Ene wrote:
> > > +config PTDUMP_STAGE2_DEBUGFS
> > > +       bool "Present the stage-2 pagetables to debugfs"
> > > +       depends on PTDUMP_DEBUGFS && KVM
> > > +       default n
> > > +       help
> > > +         Say Y here if you want to show the stage-2 kernel pagetables
> > > +         layout in a debugfs file. This information is only useful for kernel developers
> > > +         who are working in architecture specific areas of the kernel.
> > > +         It is probably not a good idea to enable this feature in a production
> > > +         kernel.
> > 
> > It isn't really a good idea to mount debugfs at all in a production
> > system. There are already plenty worse interfaces lurking in that
> > filesystem. The pKVM portions already depend on CONFIG_NVHE_EL2_DEBUG,
> > so I don't see a need for this Kconfig option.
> > 
> 
> I created a separate option because I wanted to re-use the parsing
> functionality from the already existing ptdump code for EL1. This option
> is turned off in production and only enabled for debug.
> 
> I was thinking to make use of the `CONFIG_NVHE_EL2_DEBUG` but then I abandoned 
> this ideea as one can use ptdump for vHE as well.

Fair enough. I was going to say we could just have KVM follow
CONFIG_PTDUMP_DEBUGFS, but it doesn't matter either way.

> > > +void kvm_ptdump_register_host(void)
> > > +{
> > > +	if (!is_protected_kvm_enabled())
> > > +		return;
> > > +
> > > +	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
> > > +				    kvm_debugfs_dir);
> > > +}
> > > +
> > > +static int __init kvm_host_ptdump_init(void)
> > > +{
> > > +	host_reg.priv = (void *)host_s2_pgtable_pages();
> > > +	return 0;
> > > +}
> > > +
> > > +device_initcall(kvm_host_ptdump_init);
> > 
> > Why can't all of this be called from finalize_pkvm()?
> > 
> 
> I guess it can be called from finalize_pkvm before the is_protected_kvm_enabled
> check. This should work for nvhe & vhe as well.

What does nvhe and vhe modes have to do with it? I thought this was for
hooking up the host's S2, which does not exist outside protected mode.

-- 
Thanks,
Oliver

