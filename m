Return-Path: <linux-kernel+bounces-18683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37C8260F1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659B5B230A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0BCA7A;
	Sat,  6 Jan 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mO0vgzdJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E6C2D9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Jan 2024 17:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704563428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ9HOtbgql3gNCXw9K/urpYebkD4txIvPdMOuw8HG/0=;
	b=mO0vgzdJ4D7GWICW/2dqAj+wRcim04Bd6gHfMcNOfYagypsVB0ptVYq6YatG+sEJW/I4HO
	sr6dZC9xfviQNV8BfPbb0zbW1McK7A74o2cooXH0S1uGujt9zmByUU36Q1m2FqdtaM4tO3
	n4kyeOWnXn8lQ7PT+oK/P2MvAAjAbJg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: Workaround for Ampere AC03_CPU_36
 (exception taken to an incorrect EL)
Message-ID: <ZZmS32lXXlULIArw@linux.dev>
References: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
 <ZZiWZkNP8Owytecw@linux.dev>
 <87sf3au0bu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf3au0bu.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Jan 06, 2024 at 12:13:09PM +0000, Marc Zyngier wrote:

[...]

> > From 265cb193190c13c651d8e008d34d1d18505d4804 Mon Sep 17 00:00:00 2001
> > From: Oliver Upton <oliver.upton@linux.dev>
> > Date: Fri, 5 Jan 2024 23:18:14 +0000
> > Subject: [PATCH] KVM: arm64: Mitigate AmpereOne erratum AC03_CPU_36
> > 
> > The AmpereOne design suffers from an erratum where if an asynchronous
> > exception arrives while EL2 is modifying hypervisor exception controls
> > (i.e. HCR_EL2, SCTLR_EL2) the PE may take an invalid exception to
> > another EL.
> 
> Same questions about SCTLR_EL2 and the notion of "another EL".

I've got the same questions :) This is just a rewording of Ampere's
erratum description.

https://amperecomputing.com/customer-connect/products/AmpereOne-device-documentation

> Other than the passing comments, I'm OK with this patch. However, I am
> very worried that this is only the start of a very long game of
> whack-a-mole, because there is no actual documentation on what goes
> wrong.
> 
> For example, we have plenty of writes to SCTLR_EL2 (using the
> SCTLR_EL1 alias if running VHE) for MTE. Are any of those affected?
> 
> Short of having some solid handle on what is happening, I don't see
> how we can promise to support this system.

Completely agree. At least on the AmpereOne machines I have access to
this seems to do the trick, but that observation is no replacement for
full documentation.

-- 
Thanks,
Oliver

