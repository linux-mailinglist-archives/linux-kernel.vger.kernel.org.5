Return-Path: <linux-kernel+bounces-142736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D338A2F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20894B237E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DD8289C;
	Fri, 12 Apr 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGxKlxLu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358182862
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928773; cv=none; b=atvhCpd89+oZbJe0SEuI2xUmuC8Ebc2zlZcRcKy8nvSrD4qxQrrs11n2uCxZPSA/J36ABZeC7NzZ9QoCRUd4GUP4ptS0kuJ+e2MymSLBBRvtCzluC8yV3kDvCtIyfMlTmlBH8EAwnZL13PCW0a7lYtvua9M4EDw/a+AOzQGbpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928773; c=relaxed/simple;
	bh=glp0KGdx7sugtqOMvWWc4+qDYxFdbU/VbA2xs1AxaSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVqd+MFeTS9IiTVNg+rrKnGcNWTDCZs8Epr3YEBN0HruOZXmaP3D18CmjkwAPpiGuBlx4MZtHM7cj6Xwakdg8gC3vAWcLkwJoVzsqDHLNBJ1q+um4lNeJ6BSL2C+YDQghPvLtYoVJqsPT5lTz/uceixtd1jBmp5EnT3f6zW8xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iGxKlxLu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tlo/jKZBmTDJIdo4PDZvhBV4+iTY9T2bWEJHZD3RkwU=; b=iGxKlxLuVrmepm/fByNdFT5cbz
	YelU4Pv2IIxF/mgrDh0J0I5OQPwyawd/FCdqZG3fD/jtr8+oe2tMeFw5WhjmLxtDLefeZgwBFZmJd
	wsNMyZnGlFqvL0Us7gDU9wlAP60bw2QpeZeMJoZWdynua3Pp3hpekog+GEeL7/OSdJ5jyP6M4ON4I
	YbG/EUpVUSCxTFQqo3ixdxfd8Ho51C0/yy3a6+21xD3Btk/O0RbJhcL7AAARl2GOz7qcYgqY9OBRs
	fuN+KWcr0CyAphESaAHtMu1kVPx8r9lMrGJSFSQuTduXPvyAhmIrdxtEsZGfp/MYrhQOgwroeGFVj
	+7wGHdgA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvH1M-00000009ET5-0XgE;
	Fri, 12 Apr 2024 13:32:48 +0000
Date: Fri, 12 Apr 2024 14:32:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zhk4AKtGd-5_yK_3@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <CAJuCfpHpewmiyMxyPd_A8KSyQ6tB-1wHLV-FJ7KBrpV=RY9F7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHpewmiyMxyPd_A8KSyQ6tB-1wHLV-FJ7KBrpV=RY9F7w@mail.gmail.com>

On Fri, Apr 12, 2024 at 05:46:52AM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 11, 2024 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> About the code, I'll take a closer look once I'm back from vacation
> this weekend but I think you will also have to modify
> do_anonymous_page() to use vmf_anon_prepare() instead of
> anon_vma_prepare().

Ah yes.  Also do_huge_pmd_anonymous_page().  And we should do this:

+++ b/mm/rmap.c
@@ -182,8 +182,6 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
  * for the new allocation. At the same time, we do not want
  * to do any locking for the common case of already having
  * an anon_vma.
- *
- * This must be called with the mmap_lock held for reading.
  */
 int __anon_vma_prepare(struct vm_area_struct *vma)
 {
@@ -191,6 +189,7 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
        struct anon_vma *anon_vma, *allocated;
        struct anon_vma_chain *avc;

+       mmap_assert_locked(mm);
        might_sleep();

        avc = anon_vma_chain_alloc(GFP_KERNEL);

> > We could even eagerly initialise vma->anon_vma for anon vmas.  I don't
> > know why we don't do that.
> 
> You found the answer to that question a long time ago and IIRC it was
> because in many cases we end up not needing to set vma->anon_vma at
> all. So, this is an optimization to try avoiding extra operations
> whenever we can. I'll try to find your comment on this.

I thought that was file VMAs that I found the answer to that question?

