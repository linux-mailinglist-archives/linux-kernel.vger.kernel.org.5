Return-Path: <linux-kernel+bounces-39072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC383CA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B321F25A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25725133994;
	Thu, 25 Jan 2024 18:06:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535213343E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205985; cv=none; b=fYW1wVeLaj7m04tAjCj0gFdVVb8uAeyDiQkTOJdUgW5vH5V/FDUbWK1dcK44ItAmd6GLVjIKSa0AXFNK0t9jcV6uFZDAqPAnYaKU9EVpCqCUCMQBg7EQgb707H69MyUoUjfNKiP+YY4dfiNfcBUAzB8o6w2FwbUmdSM6sRsheJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205985; c=relaxed/simple;
	bh=CjTqTGstT8B/7bRAtewmoOtK58XNsNvRn3gjW9lsl2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlxleWRt65fiyBVl84eIXPIltXH/5xhE4SjntgNQTmhyKQSD5FV/nbRYCudL8lomemzm78+RtQmPfC508hjltsTF6kxgk/dMHYdKSpG7Z7hAmI/2Qhx1HbGB0bFkx4GWpaHEST+hLT10BWAK+qIsgx1umxVDyBY5K/j/6Etv9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43125C433F1;
	Thu, 25 Jan 2024 18:06:23 +0000 (UTC)
Date: Thu, 25 Jan 2024 18:06:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: will@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZbKjHHeEdFYY1xR5@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113094436.2506396-1-sunnanyong@huawei.com>

On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> HVO was previously disabled on arm64 [1] due to the lack of necessary
> BBM(break-before-make) logic when changing page tables.
> This set of patches fix this by adding necessary BBM sequence when
> changing page table, and supporting vmemmap page fault handling to
> fixup kernel address translation fault if vmemmap is concurrently accessed.

I'm not keen on this approach. I'm not even sure it's safe. In the
second patch, you take the init_mm.page_table_lock on the fault path but
are we sure this is unlocked when the fault was taken? Basically you can
get a fault anywhere something accesses a struct page.

How often is this code path called? I wonder whether a stop_machine()
approach would be simpler.

Andrew, I'd suggest we drop these patches from the mm tree for the time
being. They haven't received much review from the arm64 folk. Thanks.

-- 
Catalin

