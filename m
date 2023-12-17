Return-Path: <linux-kernel+bounces-2743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5B816138
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D678C1C220CD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D3646B8C;
	Sun, 17 Dec 2023 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LaqKKaN4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4746BA3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Dec 2023 17:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702834395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EC2ZiWMVE0bsblf0ibQ54FvtheWVnlzmW2NNfQKBpw8=;
	b=LaqKKaN4EeFoK3k+Hr2niESb0jzOaUpU6BVyUO+geV3UBeR5UxBKxSEgAEihoTJyr76kza
	nTodzcGM+A5rKHpVIzvjy1fWb/VuxAolzy3NqFAjsfXrHwf9l1QUnji2LNoANoT1fgQL3R
	uGt0WWHNLmHluVe4HJ1RdJ3OPxtfNkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	kvmarm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	"wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>
Subject: Re: [bug report] GICv4.1: vSGI remains pending across the guest reset
Message-ID: <ZX8w1vfQzeXP5klL@linux.dev>
References: <7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com>
 <87a5q983zc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5q983zc.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Dec 17, 2023 at 11:26:15AM +0000, Marc Zyngier wrote:

[...]

> But this has *nothing* to do with the guest. This is the *host*
> userspace performing a write to the redistributor view, which has
> different semantics. Which is why your earlier description made no
> sense to me.
> 
> I think the problem is slightly larger than what you describe. A write
> to ISPENDR0 should be propagated to the ITS for any values of the
> latch, just like this happens on enabling HW-backed SGIs.
> 
> Can you please give this a go?

What do you think about using this as an opportunity for a bit of
cleanup? It'd be nice unify the various MMIO and uaccess handlers for
SPENDING + CPENDING while being careful about the arch_timer interrupt.

	clear = ~val;
	vgic_uaccess_write_spending(val);
	vgic_uaccess_write_cpending(clear);

Happy to take your fix too, especially in case I missed something
obvious :)

[*] https://git.kernel.org/pub/scm/linux/kernel/git/oupton/linux.git/log/?h=kvm-arm64/vsgi-spending-fixes

-- 
Thanks,
Oliver

