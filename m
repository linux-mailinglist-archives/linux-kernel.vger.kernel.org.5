Return-Path: <linux-kernel+bounces-1037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65183814991
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971DB1C236B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BA30331;
	Fri, 15 Dec 2023 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPzsLg6d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACA2E842
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m3TpaISKdTfci96+P+Jf+SMvxKNA9yGZkAHX2szxtjI=; b=QPzsLg6deVq+SoZS+zr8iDREAY
	JwRlwRQoNRFLe8A/+GXPJ2CxYCiWnxBEerMdkyFZgXIPHUnodHHoQlgHbbmbtmny0KpoUhyHgZdRf
	vOeCu3P5V2xPZpABCU8M1D2bXX1s5m00oeJ+AePkTVt1I6AuA0UohcO+BBiqq/thpJmOhcQd++w5a
	wjERoWTKmZVuMP/6vQgK2LzAmKfYQBvX7wKzpIgw/aqLZzHHJFhxqDstyUhsm7I06mK3wktfJSgpq
	Ih99tYqsUixHO5RBZXfZuyQrfsA3+T4KT7b+4QrTcIIX0US0JtegEUCNXvy5Co5q8OsL/+IqzHIcC
	6CBa/xAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE8Vm-00HSci-A6; Fri, 15 Dec 2023 13:45:54 +0000
Date: Fri, 15 Dec 2023 13:45:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Message-ID: <ZXxYksG2efamYuOw@casper.infradead.org>
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
 <1610bab2-78fd-4010-9f50-486952f942e6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610bab2-78fd-4010-9f50-486952f942e6@oracle.com>

On Fri, Dec 15, 2023 at 12:48:10AM -0800, Jianfeng Wang wrote:
> On 12/14/23 3:00 PM, Matthew Wilcox wrote:
> > Shouldn't we put this in __tlb_gather_mmu() which already has the
> > CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
> > zap_page_range_single() too.
> 
> After looking at different use cases of tlb_gather_mmu(), I feel it is
> questionable to move lru_add_drain() into __tlb_gather_mmu(). There are
> two use cases of tlb_gather_mmu(): one for unmapping and releasing pages
> (e.g., the two cases in mmap.c); the other one is to update page table
> entries and flush TLB without releasing pages (e.g., together with
> mprotect_fixup()). For the latter use case, it is reasonable to not call
> lru_add_drain() prior to or within tlb_gather_mmu().
> 
> Of course, we may update tlb_gather_mmu()'s API to take this into account.
> For example, we can have tlb_gather_mmu_for_release() for the first case
> and tlb_gather_mmu() for the latter. I'd like to have your opinion on this.

Yes, I like this idea.  You're right that there's no need to drain the
lru lists for the other use case, so it makes sense to have two APIs.

