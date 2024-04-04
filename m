Return-Path: <linux-kernel+bounces-132200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDA89913A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BB92838E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89C13C667;
	Thu,  4 Apr 2024 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BG4fxvuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5713C3EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269257; cv=none; b=cYhH/cPZEDS3Tz3/aMg62gR0zy++te4EjOVmr9emFBWqd9fVwZnuxrDN89mF3nZfZLoiGX41p/5D0GhMYs/Q11Rb/gjoAjsXq7oHDqaBvFYziOzG2hdAUlAiQZvJvr+VFxdIwhCeMv8KZYKmYVYyHeCZ8dXsnbEfLqtQ3U0vv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269257; c=relaxed/simple;
	bh=x4zQufQrnwQJkcZWOFYuzKnnC758IPxss8keXX+/N3A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H8lXeNzbnWqgRKP/bHImcrFCkd/nbvRbJYm6jBXpL05GMr56hLsR7cW9WEACx+CLtszok9xMgxGwrS68Khg5yWPPNjY3SULY6d8ssjcmEHJpTHuxX2WkYtMiL/FIQYna9bNuvIr+E4y8Xr7QGD7ai/s7/cuEh0cObNKbiaiKNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BG4fxvuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BBFC433C7;
	Thu,  4 Apr 2024 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712269257;
	bh=x4zQufQrnwQJkcZWOFYuzKnnC758IPxss8keXX+/N3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BG4fxvuAzCSlXjqBIlIRkLL7s18/JCaVK6BzwaosCwcgIUVXRtEaqvbPc18u824Zr
	 KzDtEzJ7r+TXpIKP4GB92aQ3cxJGrnxzGQrlMKhB7mWhB1muvb1kLu68R1l0X2No5u
	 SQJis2uIY/kcEgknLU+0M9Lz1hoVV5sO2d9m15LU=
Date: Thu, 4 Apr 2024 15:20:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, David Hildenbrand
 <david@redhat.com>, linux-mm@kvack.org, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
Message-Id: <20240404152056.2bbf0313d934edb09d9a9f29@linux-foundation.org>
In-Reply-To: <CAPTztWbQ1kLw9H9FZW-qiELQpMjSwUx9Vwjg2j+bXdMt-P63Jg@mail.gmail.com>
References: <20240404162515.527802-1-fvdl@google.com>
	<20240404162515.527802-2-fvdl@google.com>
	<e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
	<Zg8TJ3CERBAdJRTd@P9FQF9L96D.corp.robot.car>
	<CAPTztWbQ1kLw9H9FZW-qiELQpMjSwUx9Vwjg2j+bXdMt-P63Jg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 15:02:34 -0700 Frank van der Linden <fvdl@google.com> wrote:

> Rushing is never good, of course, but see my reply to David - while
> smaller hugetlb page sizes than HUGETLB_PAGE_ORDER exist, that's not
> the issue in that particular code path.
> 
> The only restriction for backports is, I think, that the two patches
> need to go together.
> 
> I have backported them to 6.6 (which was just a clean apply), and
> 5.10, which doesn't have hugetlb page demotion, so it actually can
> pass the full 1G as order_per_bit. That works fine if you also apply
> the CMA align check fix, but would fail otherwise.

OK, thanks.  I added cc:stable to both patches and added this:

: It would create bitmaps that would be pretty big.  E.g.  for a 4k page
: size on x86, hugetlb_cma=64G would mean a bitmap size of (64G / 4k) / 8
: == 2M.  With HUGETLB_PAGE_ORDER as order_per_bit, as intended, this
: would be (64G / 2M) / 8 == 4k.  So, that's quite a difference.
: 
: Also, this restricted the hugetlb_cma area to ((PAGE_SIZE <<
: MAX_PAGE_ORDER) * 8) * PAGE_SIZE (e.g.  128G on x86) , since
: bitmap_alloc uses normal page allocation, and is thus restricted by
: MAX_PAGE_ORDER.  Specifying anything about that would fail the CMA
: initialization.

to the [2/2] changelog.


For extra test & review I'll leave them in mm-[un]stable so they go
into mainline for 6.10-rc1 which will then trigger the backporting
process.  This can of course all be altered...


