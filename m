Return-Path: <linux-kernel+bounces-117750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4C88AF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58D71FA302C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31F4689;
	Mon, 25 Mar 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q9g5y6xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98528EB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392791; cv=none; b=gAKwa/AufRSBraWVmJqHS4g6fezys+BWwH9pmJWatQRsL/Nsaj5Jt7iAKznoqRaHbKnWxh4BSCVqmTHp6wxta6ricIrnA9IumquF7ICJ5EHdPt580neKWjY7wTAurWFJkbT53Jb5u3uJemYSiGBhzGzEeY+EJ4GMUZ7bzCbLbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392791; c=relaxed/simple;
	bh=hR9UJe32aZ/pMA7yh2LGZsAJ2lJT5ALVWGf+CC7hfDo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZqV7/hBGCgZ2WavZClDvs5vXZe+0RyX9nlCAOWJw5A3oBWfZ8Q3gk6w16YNZOKeiv8PKjrofkJxmbrsl5mxwEfAMwkvoMhE3GwE/GczC2SsASQLHXc0KNeGqTIHDIGp+BgsPN3xkFlBWMlo+OsiOjSoh+nNKqsGry1i/LJTMxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q9g5y6xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68596C43394;
	Mon, 25 Mar 2024 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711392789;
	bh=hR9UJe32aZ/pMA7yh2LGZsAJ2lJT5ALVWGf+CC7hfDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9g5y6xuMwEftgqfh1bq3/Ph3Ud+vrX5q4vxSmJDvBvTl7EZl5EKO4aQ67VzxtVl7
	 1B1mxve0S8vb3y68vHymsitx0gVaBrBWktwohEk+HPZ5yNLewQjTj0aVn1ZIQlaK1e
	 yH6Qw5PxoX7Ff8ubgyN7r3+1AptaDdqP66jWQu0Q=
Date: Mon, 25 Mar 2024 11:53:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v2 RESEND] mm/mmap: convert all mas except mas_detach to
 vma iterator
Message-Id: <20240325115308.f6344233a27f1633f642f888@linux-foundation.org>
In-Reply-To: <20240325063258.1437618-1-yajun.deng@linux.dev>
References: <20240325063258.1437618-1-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:32:58 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> There are two types of iterators mas and vmi in the current code. If the
> maple tree comes from the mm structure, we can use the vma iterator. Avoid
> using mas directly as possible.
> 
> Keep using mas for the mt_detach tree, since it doesn't come from the mm
> structure.
> 
> Remove as many uses of mas as possible, but we will still have a few that
> must be passed through in unmap_vmas() and free_pgtables().
> 
> Also introduce vma_iter_reset, vma_iter_{prev, next}_range_limit and
> vma_iter_area_{lowest, highest} helper functions for using the vma
> interator.
> 

I assume Liam's earlier request still applies?

: Helge,
: 
: Yajun has changed code that affects parisc with this patch, which hasn't
: been tested.
: 
: ...
: 
: Can you make sure that the expand_upwards() still functions on parisc?



