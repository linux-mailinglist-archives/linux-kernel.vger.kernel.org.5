Return-Path: <linux-kernel+bounces-66094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BA8556CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD09B28B36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FF13DB9B;
	Wed, 14 Feb 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nEghvmqc"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333C18639
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951672; cv=none; b=tqVqG6K/wnn0AHgVRcgDUeyRX7b16x1AZneUXMEj7RxPIC7uSLtAP4LIJLVNkGpTIUXt1EJpna8tTGviJ2wrFxu6b6y8RAHsJr9Q806Zht0V+6eUh/QFq4LiJ1+57iqp3lXpNXM4OT70ZewcscVrFfdNSOACVmcZobyivI6GGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951672; c=relaxed/simple;
	bh=pn7Lm4F3Ijht1DutwlSIkqI3zdpaiThaEe+q4HgUxEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHURv4PKBiMFkf2XW7DszrnHQneQMj5c2CZGWvt4T3MG7v9kaR7A2SseqKY7TwgO7zsl6dn6rGTosv2HItAuD/PS2S5eW0wmT2fEYzilrJFPm2Qy/oT1a4G9KBLck6uiGPs6v1D4B1JgBjGYMtlXtxFrCN0u5obqUS8tZgu18Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nEghvmqc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 23:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707951668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQFwYXcKnv7TgRMN6YCVw8PApCD0oiTKGSM9n+rASIU=;
	b=nEghvmqc3Mv3wEyoaHml99FbgpeGfWsZRUacafVLReuEtAND8jkMniWMKkUDCersOFwErg
	5ZcMZF7ncZh0t4rzoMzTpM8sg79yRbTqa3qaxEJf+odUOoZtuF9RLUF0EcT/HJWxgC96UM
	KTrnUYlifyvZ5Qvs34H1BYNz5S2GjiE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/23] KVM: arm64: vgic: Use atomics to count LPIs
Message-ID: <Zc1GMFjvy_f1KsXr@linux.dev>
References: <20240213093250.3960069-1-oliver.upton@linux.dev>
 <20240213093250.3960069-8-oliver.upton@linux.dev>
 <861q9f56x6.wl-maz@kernel.org>
 <Zc0HIorNZG9KG5Mg@linux.dev>
 <86wmr64xyo.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wmr64xyo.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 08:01:19PM +0000, Marc Zyngier wrote:
> > > Of course, we only have 3 marks, so that's a bit restrictive from a
> > > concurrency perspective, but since most callers hold a lock, it should
> > > be OK.
> > 
> > They all hold *a* lock, but maybe not the same one! :)
> 
> Indeed. But as long as there isn't more than 3 locks (and that the
> xarray is OK being concurrently updated with marks), we're good!

Oh, you mean to give each existing caller their own mark?

> > Maybe we should serialize the use of markers on the LPI list on the
> > config_lock. A slight misuse, but we need a mutex since we're poking at
> > guest memory. Then we can go through the whole N-dimensional locking
> > puzzle and convince ourselves it is still correct.
> 
> Maybe. This thing is already seeing so many abuses that one more may
> not matter much. Need to see how it fits in the whole hierarchy of
> GIC-related locks...

It doesn't work. We have it that the config_lock needs to be taken
outside the its_lock.

Too many damn locks!

-- 
Thanks,
Oliver

