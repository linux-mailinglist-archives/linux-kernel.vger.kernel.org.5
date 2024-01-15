Return-Path: <linux-kernel+bounces-25595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8882D324
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5351C20BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647F17D5;
	Mon, 15 Jan 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZRgQXP5"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED84628
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705286326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp0cDtoYBXFSyeoKR1ttkzmASwj02Q4AD67oZUkHwXc=;
	b=XZRgQXP5sE2No4rkATbsAoJnuqqsqEbYQa0Zg4rPYii5zZrAPp4V8gKmgcgwHsWtdMy5zy
	dXUBdFoRzitSlO8gXIEgJYBWS+BnUsFt2g8xCszuVU+q3UQHCd3Sr0I7pi+i+z3cvTFKqO
	CCavEgfv5nOnxO31o6SUEKCxQU47X2Q=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable
 safely
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240113094436.2506396-3-sunnanyong@huawei.com>
Date: Mon, 15 Jan 2024 10:38:07 +0800
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 akpm@linux-foundation.org,
 anshuman.khandual@arm.com,
 willy@infradead.org,
 wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <C34E859F-52FD-43C8-A1AA-554FC560663F@linux.dev>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <20240113094436.2506396-3-sunnanyong@huawei.com>
To: Nanyong Sun <sunnanyong@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Jan 13, 2024, at 17:44, Nanyong Sun <sunnanyong@huawei.com> wrote:
> 
> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
> BBM(break-before-make) logic when change the page table of vmemmap
> address, they will under the init_mm.page_table_lock.
> If a translation fault of vmemmap address concurrently happened after
> pte/pmd cleared, vmemmap page fault handler will acquire the
> init_mm.page_table_lock to wait for vmemmap update to complete,
> by then the virtual address is valid again, so PF can return and
> access can continue.
> In other case, do the traditional kernel fault.
> 
> Implement vmemmap_flush_tlb_all/range on arm64 with nothing
> to do because tlb already flushed in every single BBM.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


