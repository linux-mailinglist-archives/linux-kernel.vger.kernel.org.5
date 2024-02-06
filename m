Return-Path: <linux-kernel+bounces-55689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5C84BFFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B466B24565
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF91C294;
	Tue,  6 Feb 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d4DsACTS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C61C283
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258352; cv=none; b=eRwDwHP5DR9O5TrcFXxOCQtlgw2uTb3Iybdbg7rjzhlTogilS6xGFvB1R5T7NX75Sa+cV0qO9L0LYp/Vua4SY1GaIJQn0TH3ir0LcXYcYwfQ4jZBsPTnx2Imcn4DRVsgVvHMiEVq0dDLU3Kx1i8jIk4ISeg8YUYZICGg79qMOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258352; c=relaxed/simple;
	bh=WU3x0zIeoP6xyUMyTVcnpXfLJrwhP5APoHffIvSjMFQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HqTbQd+tndilg6XpXYNz9QBnx3vhhem1i6ryv8FG4l+DCs3Zb8glVKpRhK5I/g09Zla5ANRU8szhRUWoPqARt83+OrUVEV/XqnzvBowmAT3m4ijMMk+9Ofl7isnBS1hNz7XX2eVbgruwlrCguR6ndD6fGdzFdrI3vPqR65HtunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d4DsACTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA06C433C7;
	Tue,  6 Feb 2024 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707258351;
	bh=WU3x0zIeoP6xyUMyTVcnpXfLJrwhP5APoHffIvSjMFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d4DsACTSy8TyyqJS3vN1FDuQFelfApE/DdBxnrCS9iPQH/Zy2u6zE1d/W0TvEFZgi
	 hoUTECZ7LJ2xfiTR0yzszUXCmhASl9nJ4P93wMC8/fqYcIpm5LEckg8nQ6/LDkUM+m
	 00qmGUqbRWbeJh/vyhvDo7YkU+xeniPBDG52Rxi4=
Date: Tue, 6 Feb 2024 14:25:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Sumit Semwal <sumit.semwal@linaro.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma: Drop cma_get_name()
Message-Id: <20240206142550.62bed7715692ddc0071da7d0@linux-foundation.org>
In-Reply-To: <20240206041518.438801-1-anshuman.khandual@arm.com>
References: <20240206041518.438801-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 09:45:18 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> cma_get_name() just returns cma->name without any additional transformation
> unlike other helpers such as cma_get_base() and cma_get_size(). This helper
> is not worth the additional indirection, and can be dropped after replacing
> directly with cma->name in the sole caller __add_cma_heap().

drivers/dma-buf/heaps/cma_heap.c: In function '__add_cma_heap':
drivers/dma-buf/heaps/cma_heap.c:379:28: error: invalid use of undefined type 'struct cma'
  379 |         exp_info.name = cma->name;
      |                            ^~

Fixing this would require moving the `struct cma' definition into
cma.h.  I don't think that's worthwhile.


