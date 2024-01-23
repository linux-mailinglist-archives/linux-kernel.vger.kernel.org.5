Return-Path: <linux-kernel+bounces-35385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DDA83903E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FF8B276ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D15FBA1;
	Tue, 23 Jan 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irijOS1Q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DA5F55D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016388; cv=none; b=OZZc4sIvBC20DRirLgQEOUEGnVg4PUcst6qh5hKjuFcNZJbwh6eouzvXeNcmFeRlUqbVpJvpOERw0p4IfVlTQXzIZfnFXqvDbSdJRVlzvS9qGeK2jIu7K92bpyuEm7nvaLtP3ML2cJNdEa8TQfxKQIXfsnF4tCY7CTAoVtabDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016388; c=relaxed/simple;
	bh=aGUemJt7yibl0p8IQ6XiKE9p3IMHqYWuWEvWwsDbPe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYU08n2Y+YVX0gsw8/FdkWHkxX1cVbnUnOoj3clSRHqkhUJjPwU8UMONzL1t8b6S9cEIBTVdEVdNHRY5OY7VbrbE2vHwyp9Nvi+Z+rm8Q0HYQv+j0qiEJDug8XvKoDBOYdmMrAJRKeE4NToU6tEyV4p4+OCr4w1KIPasMN701YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=irijOS1Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ZCMocwMPamrl65ph5MZuGdO38zWJwVsJZU5ToyF4Tk=; b=irijOS1QnyXiGeqKvQYbe5ci7z
	gsNEQzafeZo/J2zav79FBsPs7Mjgc/MiHL8vblhCRLhSXWgYYL6Hlwhs/d7avUgLZatmUXufm0rrD
	Y6D9H8C6JJ0rGVFirMQtNbrooET5zfK2FDJzoZwRBMxCcoqSYRrB0b+wKpqyIX0PsjqIVX4k/sL8e
	wDr2CmRiIyoIfYsw2WKPqT0tOBhsJdxIl11zi02rW3tHLH3qa1EPWaF57dCL+R5I24XrnCuM2r4u3
	UCgbwNVLR3oaIxqcZJyQ7a89PdAZQQoNmOqILsAx2qqxkX6QG7qhDoTPgpsxaIp9CfHS6FBvP/wgm
	N1bYTJtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSGnH-00000003HYT-1hlQ;
	Tue, 23 Jan 2024 13:26:23 +0000
Date: Tue, 23 Jan 2024 13:26:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Liam.Howlett@oracle.com, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of maple_node objects to be its size aligned
Message-ID: <Za--f_sJ8cbgqn80@casper.infradead.org>
References: <56154bf4-c1e2-16d5-c6e2-c2dee42d3377@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56154bf4-c1e2-16d5-c6e2-c2dee42d3377@quicinc.com>

On Tue, Jan 23, 2024 at 04:33:51PM +0530, Charan Teja Kalla wrote:
> I am just curious about the purpose of maple node slab objects to be its
> size aligned, but I can understand why they need to be cache aligned.

Because we encode various information in the bottom few bits of the
maple node pointer.

/*
 * The Maple Tree squeezes various bits in at various points which aren't
 * necessarily obvious.  Usually, this is done by observing that pointers are
 * N-byte aligned and thus the bottom log_2(N) bits are available for use.  We
 * don't use the high bits of pointers to store additional information because
 * we don't know what bits are unused on any given architecture.
 *
 * Nodes are 256 bytes in size and are also aligned to 256 bytes, giving us 8
 * low bits for our own purposes.  Nodes are currently of 4 types:
 * 1. Single pointer (Range is 0-0)
 * 2. Non-leaf Allocation Range nodes
 * 3. Non-leaf Range nodes
 * 4. Leaf Range nodes All nodes consist of a number of node slots,
 *    pivots, and a parent pointer.
 */

> Reason for the ask is, when slub debug enabled with option Z, the change
> [1] makes the total object to be 256 * 3 (=768)bytes.  This turns out to
> be a problem in debug builds where the unreclaimable slab consumption
> itself is very high thus exerting the memory pressure on the system.

That seems like a very badly implemented patch.  Rather than make all
objects left & right redzone, we should simply insert a redzone at
the beginning of the slab.  ie

0	redzone
256	node
512	redzone
768	node
1024	redzone
1280	node
[...]
3072	redzone
3382	node
3584	redzone
3840	wasted space

Instead of getting only five nodes per 4kB page, we'd get seven; about
a 30% reduction in memory usage.

Slab redzoning is not a feature people turn on often, so I'm not
surprised nobody's noticed before now.

