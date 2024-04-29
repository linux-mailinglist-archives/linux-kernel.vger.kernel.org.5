Return-Path: <linux-kernel+bounces-161690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C191D8B4FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562C81F21A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B668F55;
	Mon, 29 Apr 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTi5YEZG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D879F5;
	Mon, 29 Apr 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359800; cv=none; b=mjn1FEcn2aLQCm8SJVeT3h/4wCMSeD57mN5nRgJ3ExXnahVItXfxZ2IqX+g98VvTBzHEwHcTqXaY9NSmfS2neujaHm4dYjkLukH/FSYvi4KAcDCVZkG/Lz4pmoEYzknqjsTw6xJSvKxTwu02oVv2hyTKbbswOMB85pbPm795XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359800; c=relaxed/simple;
	bh=zYsfpjLL7Iq24ipcYQdH28KK0eatHdfbYQPgq5+u49g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I53ayrou9b8Y6+R0HOdkwolJmClx20xhUkHBxiU9xwWWMYj3i8nxmmh3QIws7w0i6rTM0R/cLhWf0/soYS2ORNMDUUiDS36xZBaceQgecCgttYJyebIPh1rx4dDJzZxhOGVg9sOpIvP1rmOproR1FOxzfs5SorTiDh0Qx+cQCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dTi5YEZG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zpDK3h32oUuO0Nqma8/RcCc8s663ovkNupspZ1u//j4=; b=dTi5YEZGqMYuADyfECb1/56PXW
	ixKq38APbHI8rd/v0mpkDbx5sDJJwB7lEAovKllW/ChJ+Qafq7F2eHzVkXk4GFrSp4RotbMUXBvfL
	Rm2Toc/B32yrextev64NNajOcGZlpndjnuKvhDhexuJZparxEBM0hmEXwV1nBJa3LSHqcw6S0CCmZ
	lDreiuLDgoEFMkE0GMZsAcHV69+HL/LDv1HsiYY4WP0diD6wKgic+egh6iOwcjnB6MvtQDAStbGWI
	DFK3HIVFJf4frDF2GL1rE3cAuCf6ebASRrdG9S0aCybpAfqQUYwA6+vfHy7VVZ4oAVOdj+rHL2LcX
	t/2JwC7g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1HIJ-0000000BAgI-3G4G;
	Mon, 29 Apr 2024 03:03:07 +0000
Date: Mon, 29 Apr 2024 04:03:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] mm/slab: make __free(kfree) accept error pointers
Message-ID: <Zi8N66yehahl6D59@casper.infradead.org>
References: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>

On Sun, Apr 28, 2024 at 05:26:44PM +0300, Dan Carpenter wrote:
> Currently, if an automatically freed allocation is an error pointer that
> will lead to a crash.  An example of this is in wm831x_gpio_dbg_show().
> 
>    171	char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
>    172	if (IS_ERR(label)) {
>    173		dev_err(wm831x->dev, "Failed to duplicate label\n");
>    174		continue;
>    175  }
> 
> The auto clean up function should check for error pointers as well,
> otherwise we're going to keep hitting issues like this.
> 
> Fixes: 54da6a092431 ("locking: Introduce __cleanup() based infrastructure")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Obviously, the fixes tag isn't very fair but it will tell the -stable
> tools how far to backport this.
> 
>  include/linux/slab.h  | 4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4cc37ef22aae..5f5766219375 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -279,7 +279,7 @@ void kfree(const void *objp);
>  void kfree_sensitive(const void *objp);
>  size_t __ksize(const void *objp);
>  
> -DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
> +DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))

Wait, why do we check 'if (_T)' at all?  kfree() already handles NULL
pointers just fine.  I wouldn't be averse to making it handle error
pointers either.

> -DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
> +DEFINE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))

Ditto kvfree().  Fixing kfree() would fix both of these.

