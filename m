Return-Path: <linux-kernel+bounces-1135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD23814AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513DA1F24AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F143589B;
	Fri, 15 Dec 2023 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBOjNwoh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786602C6BA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DwtaINkPA0tnROY4nC57G4Ih+1tbg5N0FGX0QoIWudg=; b=ZBOjNwoh9gzQ4Ds0ia1GEakVF0
	MXNdahJYz6dVGuc4a9OyI3PQWOYo8WzMHBnFwZpodj5vWkMWwIzBTTNxwSi00rVEDzaonl+IHwgqk
	AGoeDQ3wmR4o8jTPM7AOZRn6NlD1VPAdYG8IVp4JWLEfvu0RkcLr3OiPMNfJMHB68nn5W+Lai5ci/
	SystQkIn4ZxSIOL4vQ9mvIcirE1oI86kjDvyFAJ4qCqZ9X2PoNncookGuPtQ/q+o5nth1C99IUPx/
	2e4ZiSYrhIjjRZmYoS0ABHvY8jBNFT0a/YWNO2fb0AXbgIBeEm0m7l+Feib/ohBCHpjiMmhanSs2U
	uL3vEftg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE9XT-000SMS-Kc; Fri, 15 Dec 2023 14:51:43 +0000
Date: Fri, 15 Dec 2023 14:51:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
	ziy@nvidia.com, xuyu@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: fix getting incorrect page mapping during
 page migration
Message-ID: <ZXxn/0oixJxxAnpF@casper.infradead.org>
References: <e60b17a88afc38cb32f84c3e30837ec70b343d2b.1702641709.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60b17a88afc38cb32f84c3e30837ec70b343d2b.1702641709.git.baolin.wang@linux.alibaba.com>

On Fri, Dec 15, 2023 at 08:07:52PM +0800, Baolin Wang wrote:
> When running stress-ng testing, we found below kernel crash after a few hours:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> pc : dentry_name+0xd8/0x224
> lr : pointer+0x22c/0x370
> sp : ffff800025f134c0
> ......
> Call trace:
>   dentry_name+0xd8/0x224
>   pointer+0x22c/0x370
>   vsnprintf+0x1ec/0x730
>   vscnprintf+0x2c/0x60
>   vprintk_store+0x70/0x234
>   vprintk_emit+0xe0/0x24c
>   vprintk_default+0x3c/0x44
>   vprintk_func+0x84/0x2d0
>   printk+0x64/0x88
>   __dump_page+0x52c/0x530
>   dump_page+0x14/0x20

[...]

> There are seveval ways to fix this issue:
> (1) Setting the PAGE_MAPPING_ANON flag for target page's ->mapping when saving
> 'anon_vma', but this can confuse PageAnon() for PFN walkers, since the target
> page has not built mappings yet.
> (2) Getting the page lock to call page_mapping() in __dump_page() to avoid crashing
> the system, however, there are still some PFN walkers that call page_mapping()
> without holding the page lock, such as compaction.
> (3) Using target page->private field to save the 'anon_vma' pointer and 2 bits
> page state, just as page->mapping records an anonymous page, which can remove
> the page_mapping() impact for PFN walkers and also seems a simple way.
> 
> So I choose option 3 to fix this issue, and this can also fix other potential
> issues for PFN walkers, such as compaction.

I'm not saying no to this fix, but dump_mapping() is supposed to be
resilient against this.  Is the issue that 'dentry' is NULL, or is it
some field within dentry that is NULL?  eg, would this fix your
case?

+++ b/fs/inode.c
@@ -588,7 +588,7 @@ void dump_mapping(const struct address_space *mapping)
        }

        dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
-       if (get_kernel_nofault(dentry, dentry_ptr)) {
+       if (get_kernel_nofault(dentry, dentry_ptr) || !dentry) {
                pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
                                a_ops, ino, dentry_ptr);
                return;

Just to be clear, I think we should fix both the dumping and the migration
code.

