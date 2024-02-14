Return-Path: <linux-kernel+bounces-65814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C6855229
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1D91C28DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7612FB23;
	Wed, 14 Feb 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CP+h46Zp"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0013A25D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935534; cv=none; b=peTG5ugwEHkC7v9Cq8+pkHetbat4yXPS+xVNxPumPsuVBG/1vcrcRhZ80BHab1bXXf+vSpZH0pAYKrU267aIGblbNtsIKv5mYBOGsqRaGsmchTBTNW11/plFWVs427g1t4SVDeg6+geu5ifLe0Rd0gNfzB+z5L5kQdsHXC8tqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935534; c=relaxed/simple;
	bh=hQJBRQGs+RMDCzJU9MhP0ybkU+4yNcL1dqxEYsEzrCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onjTv36txctfI2u2zKFnMQh+GRQvHmYYPKukliOJ0gtPIWVH0nfHdlzSaLEQReTgDqZDrZxiSyBwFQh7dUCrJueBHizo0l7KNS0P9iJaeU+bk8Gs0cmeMJa1yinuN1eQvwhtBP42aCe2Y5iyH8H/JT5SPJqpBMFqRFGdYVa7HwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CP+h46Zp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 10:32:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707935531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GfEPhq0mY5MqLsPcWaUBe1RZW2jMzAXPTv3wIHSwKlQ=;
	b=CP+h46ZpoN7SQ22Jluz5ihfwrCgfTdgpoPkPirGUtf3QP+9gfQ7TEZm0pRPTbYuEMl+pm6
	Ww60ZIbeXtIkx2Xu/Bq+4IhqE7Uhwq33o4iA5pVBPTUjRu3nib+0GpnTUKxEf3sTAFbAJW
	3lyWZklfv39+UBTo+dfGIdiaYZGg6Ts=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/23] KVM: arm64: vgic: Use atomics to count LPIs
Message-ID: <Zc0HIorNZG9KG5Mg@linux.dev>
References: <20240213093250.3960069-1-oliver.upton@linux.dev>
 <20240213093250.3960069-8-oliver.upton@linux.dev>
 <861q9f56x6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861q9f56x6.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hey,

On Wed, Feb 14, 2024 at 04:47:49PM +0000, Marc Zyngier wrote:
> I'd like to propose an alternative approach here. I've always hated
> this "copy a bunch of INTIDs" thing,

Agree. 

> and the only purpose of this
> silly counter is to dimension the resulting array.

Well, we also use it to trivially print the number of LPIs for a
particular vgic in the debug interface.

> Could we instead rely on an xarray marking a bunch of entries (the
> ones we want to 'copy'), and get the reader to clear these marks once
> done?

I think that'd work. I'm trying to convince myself we don't have bugs
lurking in some of the existing usage of vgic_copy_lpi_list()...

> Of course, we only have 3 marks, so that's a bit restrictive from a
> concurrency perspective, but since most callers hold a lock, it should
> be OK.

They all hold *a* lock, but maybe not the same one! :)

Maybe we should serialize the use of markers on the LPI list on the
config_lock. A slight misuse, but we need a mutex since we're poking at
guest memory. Then we can go through the whole N-dimensional locking
puzzle and convince ourselves it is still correct.

-- 
Thanks,
Oliver

