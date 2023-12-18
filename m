Return-Path: <linux-kernel+bounces-3119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC28167A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4EC1F22B39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF75101C8;
	Mon, 18 Dec 2023 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYzmR0RU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97628F9C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885397; x=1734421397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Gc3/ULM8ZNFEtImVaXY8oOyBtpfOhXWd6gLC4ljbAE=;
  b=aYzmR0RUhgWLdAEvDlwJ4cSSYunGnXBx/EtnnojCqxCMKtcqTz1F2LBp
   7gnpcf5urZO+BOpdxdWVrk3wQoKbGHCV2ZyB6KcJVk5vPPgQhB6jgtza/
   gX4bk1LL7v0sQYgnu0sYCrEsiMxgnRfIdqqEF+Fs//QKnLtSr9e2NNuVk
   eDw6fJX8WDblTDbM8fQIy8AKbOBQrPWSoDetjy/UdMEPPHnbl7hUnakNT
   ZbyNsMvv4xOWib6W+dOSVmeZOohbi0oewsgPiy/R8eLjAXJ0ixP4VeV3D
   WSWk7Qgsdg1hB0j7UHKfjjbXbfRRlRUrRcv7N+eSl6QXHj5nWUD/xK6M2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398252167"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398252167"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768744930"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="768744930"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:43:14 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Date: Mon, 18 Dec 2023 08:43:11 +0100
Message-ID: <4255260.irdbgypaU6@fdefranc-mobl3>
Organization: intel
In-Reply-To: <657fbdb5db945_126a129483@iweiny-mobl.notmuch>
References:
 <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
 <657fbdb5db945_126a129483@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 18 December 2023 04:34:13 CET Ira Weiny wrote:
> Fabio M. De Francesco wrote:
> 
> [snip]
> 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.maria.de.francesco@linux.intel.com> ---
> > 
> >  mm/memory.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7d9f6b685032..88377a107fbe 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5852,7 +5852,7 @@ static int __access_remote_vm(struct mm_struct *mm,
> > unsigned long addr,> 
> >  			if (bytes > PAGE_SIZE-offset)
> >  			
> >  				bytes = PAGE_SIZE-offset;
> > 
> > -			maddr = kmap(page);
> > +			maddr = kmap_local_page(page);
> > 
> >  			if (write) {
> >  			
> >  				copy_to_user_page(vma, page, addr,
> >  				
> >  						  maddr + offset, buf, 
bytes);
> > 
> > @@ -5861,8 +5861,7 @@ static int __access_remote_vm(struct mm_struct *mm,
> > unsigned long addr,> 
> >  				copy_from_user_page(vma, page, addr,
> >  				
> >  						    buf, maddr + offset, 
bytes);
> >  			
> >  			}
> > 
> > -			kunmap(page);
> > -			put_page(page);
> > +			unmap_and_put_page(page, maddr);
> 
> Does this really have the same functionality?
> 
> Ira

Do you have any specific reasons to say that? 

The unmap_and_put_page() helper was created by Al Viro (it initially was 
put_and_unmap_page() and I sent a patch to rename it to the current name). He 
noticed that we have lots of kunmap_local() followed by put_page(). 

The current implementation has then been changed (Matthew did it, if I 
remember correctly).

My understanding of the current implementation is that unmap_and_put_page() 
calls folio_release_kmap(), taking as arguments the folio which the page 
belongs to and the kernel virtual address returned by kmap_local_page().

folio_release_kmap() calls kunmap_local() and then folio_put(). The last is 
called on the folio obtained by the unmap_and_put_page() wrapper and, if I'm 
not wrong, it releases refcounts on folios like put_page() does on pages.

Am I missing something?

For further reference, please take a look at the following path from Al Viro 
that is modelled after my conversions in fs/sysv: https://lore.kernel.org/all/
20231213000849.2748576-4-viro@zeniv.linux.org.uk/

Thanks,

Fabio 



