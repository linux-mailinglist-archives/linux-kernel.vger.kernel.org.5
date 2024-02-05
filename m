Return-Path: <linux-kernel+bounces-53026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B229849F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20432283676
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA53D54A;
	Mon,  5 Feb 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rGiA+b+T"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749A3CF58
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151142; cv=none; b=gqgUAoTvWsEEJ88UhxXDQ3YluxzWmgurYr8ZHbT4CTGDTsjsbUxNqYKjBAgfU7V32nIh5SEN3yslET8PHkTe8UGRvrq9wYVciQYaKxiCYOo6uMIQTTIq7gKw45COb/9ZaBs454FYPmbH/e4Hq6sS3TqK96Lh6eMzUKrIE3ZF6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151142; c=relaxed/simple;
	bh=2PwzTeph8vt3rczITqgolgnSuYxWZnc2KI+Bl0TtM/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKIVC1ZtAyZfl48WG4nH0gvV0olYJJ9fyvCipkL2Dmi1PUBhNMMFD7r7oYxMS8F407/wpR2fOcSN6Mesuzrinqe6tRsiEBD4Akaed0TedzNiLGFLPwris/UQusGkgJoSCZmNGddi1NI6jvOuIDDQ9yhyS1qUB54Gd/VU5L6G/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rGiA+b+T; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 16:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707151137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Mg8+9Ggqj2m4roy5J7E7b21K6K3wPABC3du7wYYYe4=;
	b=rGiA+b+T0R8YEaWun8VLxYJXWs4sPF5mOf4Dbywr1gt7Qwn3PGIXXVEbRSkXLxDx7hhuK6
	zqDd9vRtRyz4u+u91Ma8W7iyNkEZuJGWYLPrATjpx+fms0mpQmTSORNsbwV7ECs2ggtN6O
	1gMJyNrgcqF5YDtJGRY5wp++4yUzkbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	broonie@kernel.org, suzuki.poulose@arm.com, acme@kernel.org,
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
Message-ID: <ZcEPHyfQ4n23YOTW@linux.dev>
References: <20240104162714.1062610-3-james.clark@arm.com>
 <Zb1mCCi13AJ_YjFZ@linux.dev>
 <8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
 <ZcDc8-FQo8wKavA4@linux.dev>
 <867cjj6ohz.wl-maz@kernel.org>
 <ZcDg1sP3EYZG-i_3@linux.dev>
 <a7cc7791-c476-fd81-b79d-a151293b8302@arm.com>
 <864jen6k0i.wl-maz@kernel.org>
 <c773393c-221e-edd1-00b7-0ce6a2481c15@arm.com>
 <861q9q7vwr.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861q9q7vwr.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 03:50:12PM +0000, Marc Zyngier wrote:
> On Mon, 05 Feb 2024 15:37:34 +0000,
> James Clark <james.clark@arm.com> wrote:
> > 
> > Hmmm in that case if there's currently no way to distinguish between
> > normal VMs and pVMs in protected-mode then what I was thinking of
> > probably won't work.
> 
> Have you looked? kvm_vm_is_protected() has been in for a while, even
> if that's not a lot. The upcoming code will flesh this helper out,

Blame me for the bad intel. What I was mentioning earlier is that (1) we
use the hyp's shadowed vCPUs when running in protected mode and (2) we
don't sync PMU state into the shadow vCPU. So really PMU support for
non-protected guests has been broken since commit be66e67f1750 ("KVM:
arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()").

Fixing PMU support for non-protected guests implies the hypervisor will
conditionally trust data coming from the host based on the type of VM
that it is running.

For protected guests the hypervisor will need a private location to
do save/restore of the enable regs since I'm certain we will not trust
whatever the host tells us in these circumstances.

Both of these reasons has me feeling like the PMU context still needs to
be associated with the vCPU, though the tracing stuff can be percpu.

-- 
Thanks,
Oliver

