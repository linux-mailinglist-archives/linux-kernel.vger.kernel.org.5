Return-Path: <linux-kernel+bounces-6361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896138197AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4958B1F25FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2620DCD;
	Wed, 20 Dec 2023 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvBk1zO1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1D20B38
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RFQC95dSOgg5PvV853KUGsy4ImkW0LGUKynkOnk85XQ=; b=kvBk1zO1kRDMvoV1aHndE2MNaY
	8jTbvEiGqTOs8FmAnv7M34l4/dpVAsqradgRAwhP69AzVproqwORmJw7O+0zfO2EUVo2NgbByqLp7
	e5pLDfezQfOy8pAGcCSThqTGbIO+TM4uBv2KAIvRxDEFW2yJ+QruB8ax+ARP9Un68bRaYtVkPB1UM
	MFibTkWA36uAtIHtu3K95Jdmrjf8AVsBhTlfw+POThBKWNsVKEVbhtBx0g6rG9lErn7R4C01pTEW4
	i89PzAdSUsHw02i+oHe0plUk51srhpGUS6WKA7h6UhsHwJ4fMS1f99F/HYZFsG7Zof8u9HU3I+DFn
	0GTROXdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFo3S-003g82-FO; Wed, 20 Dec 2023 04:19:34 +0000
Date: Wed, 20 Dec 2023 04:19:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+9c40fd6eff0f3277cc9e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in add_to_swap
Message-ID: <ZYJrVtMcNnwpdhhr@casper.infradead.org>
References: <000000000000678f8b060cdc9313@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000678f8b060cdc9313@google.com>

On Tue, Dec 19, 2023 at 05:09:25AM -0800, syzbot wrote:
> raw: 05ffc00000480011 dead000000000100 dead000000000122 ffff0000d90d0aa1
> raw: 0000000000020ffd 0000000000000000 00000002ffffffff ffff00012a670000
> page dumped because: VM_BUG_ON_FOLIO(!folio_test_uptodate(folio))

The missing part of the dump:

 page:0000000058ec4ec0 refcount:2 mapcount:0 mapping:0000000000000000 index:0x20ffd pfn:0x16fc28
 memcg:ffff00012a670000
 anon flags: 0x5ffc00000480011(locked|dirty|swapbacked|hwpoison|node=0|zone=2|lastcpupid=0x7ff)
 page_type: 0xffffffff()
 raw: 05ffc00000480011 dead000000000100 dead000000000122 ffff0000d90d0aa1
 raw: 0000000000020ffd 0000000000000000 00000002ffffffff ffff00012a670000
 page dumped because: VM_BUG_ON_FOLIO(!folio_test_uptodate(folio))

I'm not sure how we get an anonymous dirty folio that's not uptodate.
It's order-0, so that doesn't implicate any of the recent positive-order
work.

