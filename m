Return-Path: <linux-kernel+bounces-108037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA11880519
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6471F23AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F356210FB;
	Tue, 19 Mar 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z9J0FnTr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86691EBB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874116; cv=none; b=P+LCA5MN64OFa/oj0MF3jP5XE34/CWiirpXObZMi5THTRdRfPo1B6IlM/5a2hiSB969IPWEBT+IxpwdkW4NTyDqsWUCNHToiXzdL+4LKnDEtosOMZ6y6gYaTqJRdrFmcDeF3p6++zFZrTXP4YNpITA6L8eOoPtDBuP/wTpu8hjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874116; c=relaxed/simple;
	bh=WGPvd5GwZ6PqsjHNqitGV0Y88GPZKt3oT2QOZMOdvXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH6HlLVBBjBnff3O/9C+rEvPJSOy8u6izLudK3SuQ7m9JP3G1Qye5SDz+L5gJa70+kVVNDgqNMXsKlk5bXpqTJb5qHsCLujYBk6MT9JeY8vR/njn/yRUMI8bFV9TiKwG0D4LdO7B/LyH59a4fA5BBzec9R63qaDuZF5kdj8cWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z9J0FnTr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OExp50z/CnQde4C4dQqyxK/JMlnOceYMC0oR3+8P3LY=; b=Z9J0FnTr60WoOmwI3hRQIpYOaK
	I9uX4ILY4VyWJSko3IrpQUp5GKVKUmkpScDpudtH2cDvnKEXbIiM6VyChCyiLuXe4tjRPU2cj8r7P
	MVSI4RNLZwV8WTt3FTQYgRHWV/YBGt75DhJaz0v5yoHK8MGGCbWUlY31+vbR9DYtU8321dfbL7P5f
	Jw5gUSB1QyaU7DvM22vUAqLnapFb0AsbzlMHox5GnSY+JBEwZbss3INBezQ6nqLDLrFql1+12W7EC
	34M8KrEjqEAtPHtiFcWX33Ir7EUZCrNcVSO4+qT8++v5sAA9pn+vmR+I3ycVZugGD30V3UwpC6KBe
	7lWJYLoA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmeVk-00000002X1Z-05zV;
	Tue, 19 Mar 2024 18:48:32 +0000
Date: Tue, 19 Mar 2024 18:48:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 2/2] mm,page_owner: Fix accounting of pages when
 migrating
Message-ID: <Zfnd_w0ZLOVhgACt@casper.infradead.org>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319183212.17156-3-osalvador@suse.de>

On Tue, Mar 19, 2024 at 07:32:12PM +0100, Oscar Salvador wrote:
> Upon migration, new allocated pages are being given the handle of the old
> pages. This is problematic because it means that for the stack which
> allocated the old page, we will be substracting the old page + the new one
> when that page is freed, creating an accounting imbalance.
> 
> Fix this by adding a new migrate_handle in the page_owner struct, and
> record the handle that allocated the new page in __folio_copy_owner().
> Upon freeing, we check whether we have a migrate_handle, and if we do,
> we use migrate_handle for dec_stack_record_count(), which will
> subtract those pages from its right handle.

Is this the right way to fix this problem?  I would have thought we'd
be better off accounting this as migration freeing the old page and
allocating the new page.  If I understand correctly, this is the code
which says "This page was last allocated by X and freed by Y", and I
would think that being last freed (or allocated) by the migration code
would be a very nice hint about where a problem might stem from.

