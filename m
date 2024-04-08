Return-Path: <linux-kernel+bounces-135871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43689CC6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BC12864E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972C146005;
	Mon,  8 Apr 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bdozUmcc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DBF145B0B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604596; cv=none; b=ToEHLlY5Dj2cE0otF7jQdE2TPoAOXd7HH87QfHQ0W2fX+qd89N3zr0Cw2QwanDG9l+pH2A6MWujW32ii6binG3qBD9oC5n+RjMSzHNkYSjPk+OuLsvAC++GC1aq2Gc2C4PHLlKi6848S6hGWwvxZ5Hs7HNSu2gHJRaDBZA0Jn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604596; c=relaxed/simple;
	bh=kQkMMTWJKJG0SE0NuG2h3ck1w6oNzr+kJSFaydlkQZU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hesCpAVRfmuYoXknm5Mq1vXosJCqbHk6QrdbMFKEXOZqKSqZHN446z1hyLvCSAuPQweir+qI+ekHuIMgON2psEIZrcuk4D3dIHataQ9joqvyBH76fB5suVQu5IWTXPIe7KymJZOimvjoBhCpPUXfZDBdwTpGIEzNcMsTob+nbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bdozUmcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C5C43390;
	Mon,  8 Apr 2024 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712604595;
	bh=kQkMMTWJKJG0SE0NuG2h3ck1w6oNzr+kJSFaydlkQZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bdozUmccnNh6Z4oM2QWc49IVIOjNECLXM5mZF+uyV6IDh0yhJpFUXbuTWdABlj9QX
	 eFHsCWhTLCcJ1hpW9zOhnVsONVQ+7tclbZVHuPEHYnVlMSUUc7Alwq5eN+ZRor9no4
	 G01SiGu9MzsObRAG+M2FiyZsnTWniz4M1+cdvuDQ=
Date: Mon, 8 Apr 2024 12:29:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
Message-Id: <20240408122955.82183316d06cfe32fbacad0e@linux-foundation.org>
In-Reply-To: <20240407085456.2798193-1-linmiaohe@huawei.com>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Apr 2024 16:54:56 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When I did hard offline test with hugetlb pages, below deadlock occurs:
> 
> ...
>
> Fix this by calling drain_all_pages() instead.

Thanks.  I propose

Fixes: 510d25c92ec4a ("mm/hwpoison: disable pcp for page_handle_poison()")
Cc: <stable@vger.kernel.org>


