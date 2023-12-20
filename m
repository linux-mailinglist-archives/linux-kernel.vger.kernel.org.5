Return-Path: <linux-kernel+bounces-7042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC281A0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1B21F21486
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25C38DE9;
	Wed, 20 Dec 2023 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJ9Y1aBn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B038DD6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=upMoMYmYXslt+fyn4QzQsj8lri95H6D9tWlWB4yk1Ho=; b=mJ9Y1aBn9JmLEwVITeAsKLqvZ8
	LOj/Pu6+e6LgY7pOSiNh6skuRG1mnu6M57KfmQzUNbnSmiBm0nv+IjgXQZ6J1/pnZmzaAlcpZEBd7
	guriGYZT7ul2C/LcmDUYmeXMumGb0q3apjBlMuU3PDUJy4m4zXmDZu2IhWyVYIWHerAWjEG53Qrc8
	sZToRI0FvIeYyOUoahnpVQ86dRVyg4/8vPOZtNNSeCpVm+WpnXt8wcxV/nZNmDMC5pn6sDZYZqTqo
	Fu4xdDrPU29rlnLfpfnL456hHDEe19fKK3qcpgzrowbzkeh29uRUklcblF+mIYLCTqIRSRP+YvUDW
	eozqVYgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFxKn-00436p-2d; Wed, 20 Dec 2023 14:14:05 +0000
Date: Wed, 20 Dec 2023 14:14:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
Message-ID: <ZYL2rbD5UTz3s8gg@casper.infradead.org>
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>

On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Inactive mapped folio will be promoted to active only when it is
> scanned in shrink_inactive_list, while the vfs folio will do this
> immidiatly when it is accessed. These will introduce two affections:
> 
> 1. NR_ACTIVE_FILE is not accurate as expected.
> 2. Low reclaiming efficiency caused by dummy nactive folio which should
>    be kept as earlier as shrink_active_list.
> 
> I would like to suggest mark the folio be accessed in minor fault to
> solve this situation.

This isn't going to be as effective as you imagine.  Almost all file
faults are handled through filemap_map_pages().  So I must ask, what
testing have you done with this patch?

And while you're gathering data, what effect would this patch have on your
workloads?

diff --git a/mm/filemap.c b/mm/filemap.c
index 2e6b1daac6cd..8cecf82dcc5a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3418,6 +3418,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (xas->xa_index >= max_idx)
 			goto unlock;
+		folio_mark_accessed(folio);
 		return folio;
 unlock:
 		folio_unlock(folio);


