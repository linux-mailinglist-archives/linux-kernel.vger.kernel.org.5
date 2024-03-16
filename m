Return-Path: <linux-kernel+bounces-105292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386C87DB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA15281AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5E91C6B2;
	Sat, 16 Mar 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i4uvy6T5"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987C1C6A5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623063; cv=none; b=B+u4RH4h3Eac+sMFlfvlp3Pgxf3Zfj1toHvxXp0opKq7m3a99qDsHgjo0LfXaR06C6enKlM8xRJyD2fUc1EIyxl/UEcbVYEHWi+1/aERhRfYY6Dcea1pkecWuZvOgvFda5+ByB6WJC7pgM2LNUrZm9R90jHhUpxzZVcCoDDIaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623063; c=relaxed/simple;
	bh=6wwdtUF1IZ2XtlCHQx2ubpP9SCPuKDIXG7ZJS2cK1Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1R2qk/2PicZEZYLYfugLeOd7vt1L3e2P4IE7v1TmHvvZsQpPctnlb5u8j2tSdTbvBh8pgmySwo7YcmYG+CoFcpxOlxheGyit9yqaOws/x1ppQfompeLFbmqVdHAKk+OzSB2aybEhwhvM6DxrK5/5MjGv58/pBRpUDIvgxyNgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i4uvy6T5; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Mar 2024 14:04:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710623058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13ysREvRIfRyhIebo3XESHYKkRzY1Wqd/fThUQgveOA=;
	b=i4uvy6T5Rw32a4b1sjxEuMpV9lTE2Z3CJpjE+BdcfZUB1XYoOdMzfxqa7Wt5AKC+vP0m3k
	lnVBdSTi6zvDGJ3TndOL8xiTsYPmWwLkyPtjm28Bd54VV69WXVxAbzs/TUQ9X13h2Erjw9
	PgUwRbwh6qo1bvtKxH7KWtxNuHI8HhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: add NULL check to obj_cgroup_put()
Message-ID: <ZfYJTXNusw2IdEZu@P9FQF9L96D.lan>
References: <20240316015803.2777252-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316015803.2777252-1-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 16, 2024 at 01:58:03AM +0000, Yosry Ahmed wrote:
> 9 out of 16 callers perform a NULL check before calling
> obj_cgroup_put(). Move the NULL check in the function, similar to
> mem_cgroup_put(). The unlikely() NULL check in current_objcg_update()
> was left alone to avoid dropping the unlikey() annotation as this a fast
> path.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

