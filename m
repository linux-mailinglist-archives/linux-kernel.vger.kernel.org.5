Return-Path: <linux-kernel+bounces-108919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F18811E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1585728390A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014A40BF9;
	Wed, 20 Mar 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f96N0vgZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18340BE2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939292; cv=none; b=Gf0Em9a6CJH4oDgllu87Qm8WQoohwAYjgRfon5c7zNuCLcZc+MiCFDvPtO+UEgi97l8S/Uc5yhiuuawCwhGS+v1g5bUv+nH90oOML6/0L69vhNGgaTIxPnawkxf5lrLfNXbWCgIDcKhF1+qJZYpZSZLKccM/C3UmRVdymTw620E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939292; c=relaxed/simple;
	bh=aMIE+s94DUqJh+O6nig1IO/d5/0GWgvYw2BVlR/gCCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH48+ya9gDxkWs18GErpcSCFTGF1nhEUD0YWf80dxyNRvVdeqZob78M+SwdbJM+qwRAX5CedjLc/wJLidrEjFRHNIpeEFLXchkkc2GyWzKy6TGQbjFuu/X8pIOHmEPAuwPREgabPrxNNGLJrvuukbm1dl1NmZO0zRCRcgIKfGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f96N0vgZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q5DZVbBlgdY/ijS/sr5XzHi7g8HUvHiHBkBIhAImlBA=; b=f96N0vgZi46mEsOaJTXd20XzPY
	n2vtse5NKfY9beFU2Y2cTK3Qop4yRyKH2DDQujn0l7ojf7TjxEz9/CEczwfFSlp3Y9VBJlb9s0xOE
	e+AUC65hkMDzFKyeCcA6eJ04yB9xIDn7unwX90ZKhfRV//xrv+MWg/TiXSycSlPCzGmompJz4V5hs
	1/sVg7D/PSO/Z/+H0LTTV8Z6QQnJdSxQnNLNLq9HOx1lKuhzV1TnpVNshrhiVfQZ0jpwVffub1zEV
	tlwvYUnGKcOB2vM6F+Hr+mx0c+hzB7C/D+ihI9iw+sM+Ztx4BWaN0Cz5q/99mMG5bkT+KGS1G5gB5
	6gDe3ttA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmvSk-00000004KmR-0XZi;
	Wed, 20 Mar 2024 12:54:34 +0000
Date: Wed, 20 Mar 2024 12:54:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] mm/ksm: Convert get_ksm_page to return a folio
Message-ID: <ZfrcihNz74lDDg1J@casper.infradead.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320074049.4130552-2-alexs@kernel.org>

On Wed, Mar 20, 2024 at 03:40:37PM +0800, alexs@kernel.org wrote:
> -static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
> +static void *get_ksm_page(struct ksm_stable_node *stable_node,
>  				 enum get_ksm_page_flags flags)

I am really not a fan of returning void * instead of a page or a
folio.  Particularly since you rename this function at the end anyway!

You should do it like this:

In this patch, convert get_ksm_page() to get_ksm_folio() and add:

static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
		enum get_ksm_page_flags flags)
{
	struct folio *folio = get_ksm_folio(node, flags);
	return &folio->page;
}

Then convert each call-site to get_ksm_folio(), and finally delete
get_ksm_page().  That way you're always converting each caller to
the exact code you want it to look like, and your reiewrs don't have to
keep three patches in their head at once as they review each place.

Also, I think this should be ksm_get_folio(), not get_ksm_folio().
Seems to fit better.

> @@ -949,32 +949,32 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>  		 * in the ref_freeze section of __remove_mapping(); but Anon
>  		 * page->mapping reset to NULL later, in free_pages_prepare().

Could you fix page->mapping to folio->mapping in the comment?


