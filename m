Return-Path: <linux-kernel+bounces-28241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C350D82FC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E80628BB28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9CE219FC;
	Tue, 16 Jan 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovkexLaj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1792134E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436334; cv=none; b=aXkGVV4fyPDsAvsOW5bMIKlOZ10Z8RLvTRec30sNZnizhyfvkEFKXgJORvt6at1/wDjJkiqHeiQYgc1dq73QH7E9cbkw0MB7Zkcqf+nnvlMYmSXrlFljUnu4Wts+7OxFpl4PsiJliz/IrSskQGcJOlHdTbLSwgFBBFqVLLfPjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436334; c=relaxed/simple;
	bh=nDQnfqFQNCOBX7B8ttUApijBb3fHn6KBN9YuCbRLIuw=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=W6u5/HtP1z8hQvT0YJz/v1R2zMBwnZVHlcGWDNaDFy1TRlwhHFT1B1R3qN3MMfkUk7itDtwX+XWj22RGDX7umMrzJtCi3sipKBaPj9tdjH5JhTg23QvbvPbc37a/nIPv1ZZz5PnCKAYCcSkcg9PFt/gX/yXw7+ZmjKeQrHplxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovkexLaj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4PyfI5MUBxjuwt0E14mP7ZWzfjXP7I7pzSpm/PoDgq4=; b=ovkexLajKKyGsgIeUVpPLoLciP
	2j2hrpzQaan0nsiwLEBZliham/iItsGpco/CFv0xsUjamhuSDvTKZzukbtM3bQdF5iRyMtyJVEh/H
	cVthkdjjJIPuHmCbAC7p5zwhBZWTLK5PGGs2MGGprcobRlhfq2uoKkvHV0IxEfP6uZ8UOE7zwzyd4
	5gmC2ZM7qpsnVpQPkg90F5yzuTbK1D9Jz9piWrLZV9wh2mIvPqYWK3i1T28EflM9dDbqLoEEf5V8p
	owjzfFzhjuTahSevYQ96mxiXehRGHTqzeIVwpgOwtdTRsFYHkS4THYgm5Yjech86RoGaZY/Y7IJfq
	dEiqC08A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPptO-00E8lB-NW; Tue, 16 Jan 2024 20:18:38 +0000
Date: Tue, 16 Jan 2024 20:18:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <ZabknuNmymSP0XgG@casper.infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org>
 <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org>
 <20240116120944.01f25e65d13f0fc7e2a2df34@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116120944.01f25e65d13f0fc7e2a2df34@linux-foundation.org>

On Tue, Jan 16, 2024 at 12:09:44PM -0800, Andrew Morton wrote:
> On Mon, 17 Jul 2023 12:02:27 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > The only user of frontswap is zswap, and has been for a long
> > time. Have swap call into zswap directly and remove the indirection.
> 
> This falls afoul of "mm: zswap: multiple zpools support".  Could we
> please have a version against mm-unstable or linux-next?

Did this email get caught in a timewarp?  Or is it referring to
something that isn't commit 42c06a0e8ebe from six months ago?

