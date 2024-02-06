Return-Path: <linux-kernel+bounces-55406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6084BC4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE94C28A49F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECEC16431;
	Tue,  6 Feb 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lciMhFVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BA1426B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241139; cv=none; b=NnkZRwTvFmzPotUdmq4A70Ei4kaojBNXXuwS6T9XF5P9iNOEpyzhFWtd2ab/L/VyTJJBYKzyJDomgrxUNbZ9eQUbkz3xSyA0baN22SQCPukf/n57sT1KiTXAtW+I03Lh4GIGJWi9ky3NV5Uqbf+dAejs8AA0WZ60t9zR5zf7h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241139; c=relaxed/simple;
	bh=rb8APAK/NFsWkjSw2CEJHSFqUkeP73aN71SPR67A7Ck=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GXGfetu46r7FTApI72lorztrUocnUVt1lCf3sKznolJLB49nI2yEC2TuhtG9Enegj5ppyenbYoEKKMARELsQBt4cjw4qT1HKp2zFTKfsvtSewkjFV1BEDgkE4ejGd8aKTNJbotPzoXqGvYAAE7M/vq8UTOnL9HscdsyKdxZQJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lciMhFVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244A1C433F1;
	Tue,  6 Feb 2024 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707241138;
	bh=rb8APAK/NFsWkjSw2CEJHSFqUkeP73aN71SPR67A7Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lciMhFVwD8spj2zXqwGFIForrObq2F8BJkxbrdxDdYKg1fqbP5VAtqDJQUwue4+18
	 DItyjrNq9uxFdW2im98TsjO377IO4W5VqyMC915WTZkqw+Bcft2n+PVPZvdbs5uY3o
	 Qv7TvTU/TNfcgzvgW8xsYVdhfUp+yQrigOvQyjRk=
Date: Tue, 6 Feb 2024 09:38:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, alexandru.elisei@arm.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma: Add sysfs file 'release_pages_success'
Message-Id: <20240206093857.d834af4f96d643c53e29e02d@linux-foundation.org>
In-Reply-To: <20240206045731.472759-1-anshuman.khandual@arm.com>
References: <20240206045731.472759-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 10:27:31 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This adds the following new sysfs file tracking the number of successfully
> released pages from a given CMA heap area. Also like before - this will be
> available via CONFIG_CMA_SYSFS, and help in determining active CMA pages
> available on the system.

"like before" is mysterious.  Is this referring to some other patch? 
To existing code?  Please be explicit and complete.

> /sys/kernel/mm/cma/<cma-heap-area>/release_pages_success
> 
> It adds an element 'nr_pages_released' (with CONFIG_CMA_SYSFS config) into
> 'struct cma' which gets updated during cma_release().

The changelog doesn't explain why Linux needs this feature.  The value
to our users.  Perhaps that info is buried in the link which is buried
below the ^---$, but as this is the most important part of a changelog,
it really should be spelled out here, completely and carefully please.

> ---
> This patch applies on v6.8-rc3
> 
> Some earlier relevant discussions regarding arm64 MTE dynamic tag storage
> in this regard can be found here.
> 
> https://lore.kernel.org/all/ZbpKyNVHfhf1-AAv@raptor/

