Return-Path: <linux-kernel+bounces-27534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3273182F1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9915628536D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAE1C68C;
	Tue, 16 Jan 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N3KoqCc5"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93D1C680
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Jan 2024 16:38:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705419523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdUlkGvpg6AuVxEYLHDeazF0imgKqrZDbMjuhEMTD8o=;
	b=N3KoqCc5ehk6wxF6RAgNbMR7wj+PpGp16wLkvWqPN6tFdo0GnXEovVGkOVTdH2YmJ5gx/w
	h9KPhJ+kBh6w7gzt5tt6BcQVpiPwXphkiIFabnrFRe279DizAIRzQ4zEuaZo+6Mu2MSTV+
	3678SDcA5nA4JIsFvxrVHnX9dqr+3HE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64: Add missing ERX*_EL1 registers
Message-ID: <ZaajAQafAnOgB8ho@linux.dev>
References: <20240110075739.8291-1-tianruidong@linux.alibaba.com>
 <867ckh9y7l.wl-maz@kernel.org>
 <ZaVFmtKbtCJtaAAu@linux.dev>
 <67b15918-e9d3-97ea-65ca-985b5ddb3f88@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b15918-e9d3-97ea-65ca-985b5ddb3f88@arm.com>
X-Migadu-Flow: FLOW_OUT

Hi James,

On Mon, Jan 15, 2024 at 05:21:19PM +0000, James Morse wrote:
> Hi Oliver,
> 
> On 15/01/2024 14:47, Oliver Upton wrote:
> > On Wed, Jan 10, 2024 at 12:20:30PM +0000, Marc Zyngier wrote:
> >> If my reading of the ARM ARM is correct, these registers only exist if
> >> FEAT_RASv1p1 is implemented. Which means that we shouldn't handle
> >> those as RAZ/WI unconditionally, but instead check for what we
> >> advertise to the guest and handle it accordingly.
> > 
> > Can we go a step further and just stop advertising RAS to guests? I don't
> > expect VMs to gain much from our RAZ/WI implementation.
> 
> These CPU registers would describe the error in a kernel-first setup, but firmware-first
> has its own in-memory way of doing that.
> 
> The CPU features indicates the IESB feature and ESB-instruction exist to fence errors, and
> that the CPU uses the ESR_ELx.{S,A}ET bits to describe the CPU state after an error. These
> are all useful as part of the notification of an error, be that kernel-first or
> firmware-first.
> 
> When its supported by the hardware, the VMM can inject an asynchronous external abort
> using KVM_GET_VCPU_EVENTS - otherwise the ESR_ELx.ISS bits are all imp-def, meaning all
> errors are catastrophic.
> 
> Doing this would skip save/restore of VDISR_EL2, is there any other reason to do it?

Forgive me, had the blinders on and was thinking only of the error
record interface, not ESB/DISR. In that context it makes a lot less
sense to hide RAS from guests, especially if the guest depends on ESB
being a NOP if the hardware doesn't support it.

-- 
Thanks,
Oliver

