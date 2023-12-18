Return-Path: <linux-kernel+bounces-4151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1D6817885
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCBB1F231E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05895D758;
	Mon, 18 Dec 2023 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sacaxvEL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D625A860
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 17:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702920009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ5piTv0+pYp16eP2qMvs+lTjxUIdakKgcBRhgaO2U4=;
	b=sacaxvELU65hlgNAtaUo0nZziNlrsTWqPWJQ6Nwc19vywZeLqjxoHYCmwWoYR3SHYtb+SG
	y6I3nMK/Q3uTtMEWthVNMVFbcb8xrTNjA9C3js0S5fzyxahj2GD6o7T7dJ4JFRD0xr0I3H
	q8CsUIXdXuxr9BdAM8LifTywD3fyK94=
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
Message-ID: <ZYB_RKR5CqlVS-lV@linux.dev>
References: <7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com>
 <87a5q983zc.wl-maz@kernel.org>
 <ZX8w1vfQzeXP5klL@linux.dev>
 <ZX8xLhFFqTXRFQtd@linux.dev>
 <878r5s8xvc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r5s8xvc.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Dec 17, 2023 at 06:52:55PM +0000, Marc Zyngier wrote:
> On Sun, 17 Dec 2023 17:34:38 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > 
> > On Sun, Dec 17, 2023 at 05:33:16PM +0000, Oliver Upton wrote:
> > > On Sun, Dec 17, 2023 at 11:26:15AM +0000, Marc Zyngier wrote:
> > > 
> > > [...]
> > > 
> > > > But this has *nothing* to do with the guest. This is the *host*
> > > > userspace performing a write to the redistributor view, which has
> > > > different semantics. Which is why your earlier description made no
> > > > sense to me.
> > > > 
> > > > I think the problem is slightly larger than what you describe. A write
> > > > to ISPENDR0 should be propagated to the ITS for any values of the
> > > > latch, just like this happens on enabling HW-backed SGIs.
> > > > 
> > > > Can you please give this a go?
> > > 
> > > What do you think about using this as an opportunity for a bit of
> > > cleanup? It'd be nice unify the various MMIO and uaccess handlers for
> > > SPENDING + CPENDING while being careful about the arch_timer interrupt.
> 
> What is special about the timer interrupt?

Isn't that the case where we have a physical IRQ mapped and wind up
forwarding state to the physical GIC?

> Could be. But I'd rather have separate fixes from more invasive
> reworks.  Specially given that we have had multiple ugly bugs around
> this code in the past, which is why we ended up splitting userspace
> from guest accessors.

Fine by me. I had felt like a common helper w/ the user v. guest
exclusions is a bit easier to understand than diffing two very similar
functions, but it isn't a big deal.

Anyway, I'm happy with your fix. I'd like Kunkun to give it a go but
either way I can pick it up for 6.7.

-- 
Thanks,
Oliver

