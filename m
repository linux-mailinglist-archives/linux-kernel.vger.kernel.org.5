Return-Path: <linux-kernel+bounces-50630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D495C847BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DC328A3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581D83A10;
	Fri,  2 Feb 2024 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJ7tWXl+"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF383A06
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911253; cv=none; b=X8awD8e/kfp+2nvpYCpBXCgmOQmfsO766xnma9l+kHBj0yUyFI+oBj2dcz8fvsxWI2psPrXxIr5XSCWp//f+idaJF1nY6OKtYgP3ZnMCLgDYgyVvOXF3p6Tyjt7g2TedjqTYQrA3QvhEsy0OKmLPGuuDKvxsTGpqkrwEerso5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911253; c=relaxed/simple;
	bh=N7TSsTyTTpBhvIoyIV72Wm9XXJoUcSnN+bUHy/4yQS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgn6ArNnjJx8/vGoqzJwVaPMHRW+YA8Sx0XwSFZFaaOy1/ojtgClEDQIo6RjNuyYBRXUZUuCczLI47wuyNymvGn1qwqf/ZKmZZnyrbNNjEy4T8JBD7L/JU3acYHBdcJ1N17bMPs2ZzykQonkoa/7aooif4NPIyRlguBwyEhTnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JJ7tWXl+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 22:00:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706911249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zpF3hh3I48blUHSumiD5JMU6whQC2+CI14iV5XbGAM=;
	b=JJ7tWXl+TCmh5A/3ptirM/eUN3eqQtT2AfiAKO5tZ1pUy6x3ZKvSR0taZR4bYN+3pcFneK
	pOIJcFwAh7whf8AOwC8P1Kh1b/7HVlktnIpRJU9HbzQoZkyavGQnze9jNn3hSkT/H2Drpf
	/H1OGLttkJYqaBRw+DDwl+sTpNaVhxs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, acme@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rob Herring <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
	Jintack Lim <jintack.lim@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event
 state to hypervisor
Message-ID: <Zb1mCCi13AJ_YjFZ@linux.dev>
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-3-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104162714.1062610-3-james.clark@arm.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 04, 2024 at 04:27:02PM +0000, James Clark wrote:

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index c50f8459e4fc..89147a9dc38c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -130,13 +130,18 @@ static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static struct kvm_pmu_events *kvm_nvhe_get_pmu_events(struct kvm_vcpu *vcpu)
> +{
> +	return &kvm_host_global_state[vcpu->cpu].pmu_events;
> +}
> +
>  /*
>   * Disable host events, enable guest events
>   */
>  #ifdef CONFIG_HW_PERF_EVENTS
>  static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>  
>  	if (pmu->events_host)
>  		write_sysreg(pmu->events_host, pmcntenclr_el0);
> @@ -152,7 +157,7 @@ static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>   */
>  static void __pmu_switch_to_host(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>  
>  	if (pmu->events_guest)
>  		write_sysreg(pmu->events_guest, pmcntenclr_el0);

This now allows the host to program event counters for a protected
guest. That _might_ be a useful feature behind some debug option, but is
most definitely *not* something we want to do for pVMs generally.

Do we even need to make this shared data work at all for pKVM? The rest
of the shared data between pKVM and the kernel is system information,
which (importantly) doesn't have any guest context in it.

I'm perfectly happy leaving these sorts of features broken for pKVM and
using the 'normal' way of getting percpu data to the nVHE hypervisor
otherwise.

-- 
Thanks,
Oliver

