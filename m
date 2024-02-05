Return-Path: <linux-kernel+bounces-52679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BD849B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AECB23B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E881BDD0;
	Mon,  5 Feb 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d5OTMkxI"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B21CA9F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138299; cv=none; b=Dbt6zapHSW5QgRCcjMVaWwX7HdglR41S/qS8F3W3oFUUkiS1ILLTrCxw6LMk/H8HOq4DkkRuDnIrklMrS/qnptwmunSPPmcsxkGGE5xSBhaxXVX7r1wL2DZK9N4vOiSxTyw2IwZez3vPLSN+Urzc6qhLZ7daGj937sAvkY7zuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138299; c=relaxed/simple;
	bh=6R73Y1eL+XW9/5GN5zqnbfIAD02pmTNPIsXX1PzbkQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZBGfVnoj4z5KDdh8wNTnCNLuIy6b33w6POyc0Ql5pGVpK2hdacNo4pDOl9/y9TAiWU4lo6x23feyGJsghBEU2IoR2GoEZp/C+QXd9rkPAqbKjmo6agxfvBxn8p4L5peBt5PAeWvjyYs4L9yyUJj2XY33A+7VJx+Nc5wW8I0LTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d5OTMkxI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 13:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707138294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjDbYJsA64v+kSKvUvgWTs/MwMgC5uCGKzp4l4kiFPQ=;
	b=d5OTMkxIJ0g6UM3z7bHVp+C0KObAXlBjbpjAGtUI0R/TQZptwEcQ3TPCtL7tWTrDSzMYAy
	OEIqo5T0Z0ZpuQ3X9or70pTazC4A7W2D8fH7WO3AfkMisgfErJgHNcefcgqSjmBGDZqsr1
	QsiPxQfd2K9662ohcknZ8OQ8jJl523k=
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
Message-ID: <ZcDc8-FQo8wKavA4@linux.dev>
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-3-james.clark@arm.com>
 <Zb1mCCi13AJ_YjFZ@linux.dev>
 <8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 12:16:53PM +0000, James Clark wrote:
> > This now allows the host to program event counters for a protected
> > guest. That _might_ be a useful feature behind some debug option, but is
> > most definitely *not* something we want to do for pVMs generally.
> 
> Unless I'm missing something, using PMUs on protected guests was added
> by 722625c6f4c5b ("KVM: arm64: Reenable pmu in Protected Mode"). This
> change is just a refactor that will allow us to add the same behavior
> for a similar feature (tracing) without adding yet another copy of some
> state before the guest switch.

Ha, I had forgotten about that patch (and I had reviewed it!)

My interpretation of the intent for that change was to enable the usage
of vPMU for non-protected VMs. The situation has changed since then, as
we use the shadow state for vCPUs unconditionally in protected mode as
of commit  be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure
in handle___kvm_vcpu_run()")

Protected mode is well understood at this point to be a WIP feature, and
that not all things are expected to work with it. Eventually we will
need a way to distinguish between 'normal' VMs and true pVMs (i.e. the
VMM selected full isolation) in nVHE, but right now what we have enables
testing of some isolation features.

> > I'm perfectly happy leaving these sorts of features broken for pKVM and
> > using the 'normal' way of getting percpu data to the nVHE hypervisor
> > otherwise.
> > 
> 
> I can do that. But do I also disable PMU at the same time in a new
> commit? Now that both PMU and tracing is working maybe it would be a
> waste to throw that away and hiding it behind an option is better. Or I
> can leave the PMU as it is and just keep tracing disabled in pKVM.
> 
> I don't mind either way, my main goal was to get exclude/include guest
> tracing working for normal VMs. For pKVM I don't have a strong opinion.

Unless someone has strong opinions about making this work in protected
mode, I am happy to see tracing support limited to the 'normal' nVHE
configuration. The protected feature as a whole is just baggage until
upstream support is completed.

-- 
Thanks,
Oliver

