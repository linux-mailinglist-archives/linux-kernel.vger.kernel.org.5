Return-Path: <linux-kernel+bounces-75882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45985F040
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0B2284E96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B317597;
	Thu, 22 Feb 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUkXK6xe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4117593
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574157; cv=none; b=ME0Nud2DEwr5gBGPC7kahNvznpw3PUTVj03h33/yvu/oPTri8ENgYrDULtexYp91epe1Hl+D6yTnyS88KrHNv5aES5rKst8LFUdv9EqvXN4QKSG8Gcviwzy4hU50P9wQA3aprAM1nWDSANWEIky76VPPTxxHSngDUveyufOfil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574157; c=relaxed/simple;
	bh=L8FIWRJ7QoNWLb3BxwPTEVOVxBBoBTFGTrLjVPkuXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHdLGMrwGJ5IyYe2nHj3nOUBjxl7kByRq55xEtyoO2Bxf54xzrWMNVUWus+VCzBRdcaDdQixBm7nwZ5JqQz59FKji0f5dYmdRmdclcHZc3FpazwLnzERwPBKZJSKK+/T72FqIJ77GYZQ7xuuuHUrLJMKMsmNEqtDnYzK6BGdWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FUkXK6xe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YjmVoGrH3NTj6e8OOlyRDduZNWEtTAuI/cfYREosE2I=; b=FUkXK6xenP/WwXGTFSY8g8oMOM
	kwt6CKjSWezMIKkj1AuIg/S4MApsDp3bLm/dah+8hAJRij+n677qBlbN8jxzHsNlx4Ae9uga7uqrp
	gZZ9AYaTTEzuLpIOpSIb8JPDbJip18pc0Pg6TZAfQXXDROk68N75nhEt+ifxVSF1ILQKJryXzWZzn
	RZ40oYCdzfU3BK5hJt9o3ALqnxVuYf/ZGbpduC5daG/DprpS2MqDSbP6XOTp5UAGVOtF4DWEiCCgM
	nsqKJmMdIWHY0GgxaB7uJ5E3lS0ivim4ai7Mj0MqqOWxzEhIfCaJZmQSmDrXaLV2qPkFiXRCUmpL/
	cgVt4H6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd0Bc-00000002Vak-2wMk;
	Thu, 22 Feb 2024 03:55:52 +0000
Date: Thu, 22 Feb 2024 03:55:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>,
	Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Subject: Re: [PATCH v2 5/5] hugetlb: Allow faults to be handled under the VMA
 lock
Message-ID: <ZdbFyC6HPr6oKrM-@casper.infradead.org>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-6-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221234732.187629-6-vishal.moola@gmail.com>

On Wed, Feb 21, 2024 at 03:47:32PM -0800, Vishal Moola (Oracle) wrote:
> Hugetlb can now safely handle faults under the VMA lock, so allow it to
> do so.
> 
> This patch may cause ltp hugemmap10 to "fail". Hugemmap10 tests hugetlb
> counters, and expects the counters to remain unchanged on failure to
> handle a fault.
> 
> In hugetlb_no_page(), vmf_anon_prepare() may bailout with no anon_vma
> under the VMA lock after allocating a folio for the hugepage. In
> free_huge_folio(), this folio is completely freed on bailout iff there
> is a surplus of hugetlb pages. This will remove a folio off the freelist
> and decrement the number of hugepages while ltp expects these counters
> to remain unchanged on failure.
> 
> Originally this could only happen due to OOM failures, but now it may
> also occur after we allocate a hugetlb folio without a suitable anon_vma
> under the VMA lock. This should only happen for the first freshly
> allocated hugepage in this vma.

Hmm, so it's a bug in LTP.  Have you talked to the LTP people about it
(cc's added)?

Also, did you try moving the anon_vma check befor the folio allocation
so that you can bail out without disturbing the counters?

> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

