Return-Path: <linux-kernel+bounces-142641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBC8A2E29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1731C213C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4E5645D;
	Fri, 12 Apr 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWkCeV4y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22C55E56
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924690; cv=none; b=Y+Oi7XPUmS42/UKdQKlkKfMOaTJTpAh1Owzpi76DHDoPPiqmjG3ZZx0J1l0x4tErgJiVpjKxpfHNgyMvAdRbXH7LsTzzkkMGGvKvfYJzlBNHJXZqidsbwkK08IA26tihemhTaHDDwClXu5+gMQF0/SeiYhTF9SQsstMb3qBxkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924690; c=relaxed/simple;
	bh=l84tKIYFJRbNO3lPZNfB9URMCjMjbQfpQxdw4xzI+ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sizKg3GkNUxOpeMhOV8Il0bOOR9/jU3X2Dl+Ue3HWXUWvf/aV3jM4n8aDqDKe98o+PsFxmCE+1Wmprj4XzRxLvpxI96ZIGWr3tg8YVCeFfbl/8ns+zYogKJ/vgEFMxLUcl3QwEJWc3OlcjrD9UiLp69ci083cgdTlHk3V6CutHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uWkCeV4y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V8tHIi8mtmD3siYN748Lkzi4LVwXGCeJa+lIehzP4co=; b=uWkCeV4ysT2+I4xSNxZgjS/hDW
	O0MYpnRf2G3nZscjAqThdwQD6jkYNEpjVypoLlkvW6o0CubwwU4bn3HQgwXxqE2bkpyvzE1YCRI6e
	xfKZwJDOlZ9qrqrqi1JS1OBvNoXQbDA/d0lpIBHq8igi5ZbiNF6tlvh3YHmbMMyfLTXduF7KjlDyy
	8pF7x+/i2qveYWxGRGWmo8R6NHtfURZDYaTFE38szNynHh3vD3NpOnHi2Zev5QAE0Pzii85oL1mr3
	cx/C/CLXXuGXJ+bfOSvRVP6gnMN4/mWHOVvjBs1c7fu0EvEXJUrDSO5eIhdAw/2qRfOzbbgfMmKeC
	DubM335Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvFxM-0000000986C-2SQq;
	Fri, 12 Apr 2024 12:24:36 +0000
Date: Fri, 12 Apr 2024 13:24:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
Message-ID: <ZhkoBNudREynp6GQ@casper.infradead.org>
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>

On Fri, Apr 12, 2024 at 02:43:53PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Livelock in [1] is reported multitimes since v515, where the zero-ref
> folio is repeatly found on the page cache by find_get_entry. A possible
> timing sequence is proposed in [2], which can be described briefly as

I have no patience for going through another one of your "analyses".

1. Can you reproduce this bug without this patch?
2. Does the reproducer stop working after this patch?

Otherwise I'm not interested.  Sorry.  You burnt all my good will.

> the lockless xarray operation could get harmed by an illegal folio
> remaining on the slot[offset]. This commit would like to protect
> the xa split stuff(folio_ref_freeze and __split_huge_page) under
> lruvec->lock to remove the race window.

