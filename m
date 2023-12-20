Return-Path: <linux-kernel+bounces-7404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EA81A76F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8CAB23C84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDF487A3;
	Wed, 20 Dec 2023 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nGclzkJI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744084878D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MOQBkuV64qGkpkL02M2q/zJVUfocblbpJ8/Q7Pg5Jnc=; b=nGclzkJI27pB0hdUSS5ouVV0ns
	O+02D269IBZ8f7WlDkCx6o7vRlP+AcWviiCSxE9Xn4rqSC7fubqVL0J6J8yG5tGrmbJ3/Entj/RgB
	xusZ7QrgCc32vwQkLV6HTKigjopb1NrrsKiTqUWMEj6Nf+C4zN67FkXhaIRiSK5jvbuAM8rgKUs3o
	+n1Ci83at1FkOal+kmoinH8t2A8APDD2M8TWwT6abZIKSIqNnwBdUseorZuM09PWH+CT/QsUsb5Zv
	7rFdrklOtINI2fyQJ4jHkCXqYs5hWiSrk8gGFKfOyIpg2nCa3rPwY+O2goOf39CGNWUvDcaVEGbSd
	pYNwbF1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rG2io-004Imu-0V; Wed, 20 Dec 2023 19:59:14 +0000
Date: Wed, 20 Dec 2023 19:59:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Message-ID: <ZYNHkQZhwvM81TZP@casper.infradead.org>
References: <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
 <657fbdb5db945_126a129483@iweiny-mobl.notmuch>
 <4255260.irdbgypaU6@fdefranc-mobl3>
 <6583463e8de5c_30a94294fb@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6583463e8de5c_30a94294fb@iweiny-mobl.notmuch>

On Wed, Dec 20, 2023 at 11:53:34AM -0800, Ira Weiny wrote:
> > My understanding of the current implementation is that unmap_and_put_page() 
> > calls folio_release_kmap(), taking as arguments the folio which the page 
> > belongs to and the kernel virtual address returned by kmap_local_page().
> > 
> > folio_release_kmap() calls kunmap_local() and then folio_put(). The last is 
> > called on the folio obtained by the unmap_and_put_page() wrapper and, if I'm 
> > not wrong, it releases refcounts on folios like put_page() does on pages.
> 
> This is where my consternation came from.  I saw the folio_put() and did
> not realize that get_page() now calls folio_get().

That's not new.  See 86d234cb0499 which changed get_page() to call
folio_get(), but notice that it's doing the _exact same thing_ that
get_page() used to do.  And it's behaved this way since ddc58f27f9ee
in 2016.

