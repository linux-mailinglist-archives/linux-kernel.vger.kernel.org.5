Return-Path: <linux-kernel+bounces-132085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF61898F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16591C21907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0E134CF8;
	Thu,  4 Apr 2024 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iwYrN/Qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BC134434
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261751; cv=none; b=J4L+evt1Lhi6LJhbUqFnPlHU+pdgy+hfWH/8b7UErhJz2mUEVYisKV9GhkHuarIVJAByvmydD3jaV4cmUi+X9hsD5RRwm403Wy84gH8d8A69MY6cY2YKeNWBXZmkWAhRQssNQ+gQh/Az9EPgBVZ2iVxrFkx7hxi/I7wM8FXGSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261751; c=relaxed/simple;
	bh=VVWhZr0aCuH2Y5GFYDZW8wnlUR0OXsRJ98VfsKuyNYU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LuQ4dFiaWDJTGo0BaVPkuNZNzXH+BPug7DpxoQvbdSZhPdyIQPZmeDQip8Q2jdvHl5mwVvEk37FcEyMHpNJm2ZcU+MM9F7Ay0X94lUvhpDBq4qgE5cZMq7beSXe1xHAFk7FxPXm6AP3D8U8OYKxlYnL6xTke55pbyaC8d7ZEc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iwYrN/Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE58C433F1;
	Thu,  4 Apr 2024 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712261751;
	bh=VVWhZr0aCuH2Y5GFYDZW8wnlUR0OXsRJ98VfsKuyNYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iwYrN/Qa6hTknYBmnxoeiYRnZy9dpjnSXd21EX835N/H5e0y5K/5tBmuKYrP7CVVG
	 WRSRyAflKnhkB/7TrVh01xquXXc2wsymfnyILjqOS7OOMO0r2kJBjOdf8a4sub5mAj
	 rRNqtoP3/0dDcAw4OGvVjhr40/g9l2/SIeeSmO/s=
Date: Thu, 4 Apr 2024 13:15:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 1/2] mm/cma: drop incorrect alignment check in
 cma_init_reserved_mem
Message-Id: <20240404131549.27a454072f7e96530dce2d62@linux-foundation.org>
In-Reply-To: <20240404162515.527802-1-fvdl@google.com>
References: <20240404162515.527802-1-fvdl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 16:25:14 +0000 Frank van der Linden <fvdl@google.com> wrote:

> cma_init_reserved_mem uses IS_ALIGNED to check if the size
> represented by one bit in the cma allocation bitmask is
> aligned with CMA_MIN_ALIGNMENT_BYTES (pageblock size).
> 
> However, this is too strict, as this will fail if
> order_per_bit > pageblock_order, which is a valid configuration.
> 
> We could check IS_ALIGNED both ways, but since both numbers are
> powers of two, no check is needed at all.

What are the userspace visible effects of this bug?

