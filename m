Return-Path: <linux-kernel+bounces-17362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E5824C46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C08283C41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D61C3E;
	Fri,  5 Jan 2024 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJqR8yDP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B3185B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7803C433C7;
	Fri,  5 Jan 2024 00:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704416330;
	bh=LbWufgpY2x1b9pPxEw8zyOci1BCSYD9ImieN+zxIa/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZJqR8yDPn9AzVbQuyqNZlCBakm6CAC5NDXhDq160wUqttEUt7OXwRWhdZJnEz3ZQk
	 8TGt8ZEqVFjK1jiPYS6usSVop+XpLuDOjaqD8NdlSJkYVsT4LMVhSQB0w2HvLZhuTQ
	 B/qSSuDx270axwXqk7Kb7kzVKMZ7hkJB4XLuWcwmNzZutXmHambwqQeTV0beo7ffNk
	 7jpZwzDkIfpbsnMOIRl4M/MmmqaU/O6Q952Baay+cibrSbxqeCOPtKhDSXAHQkCwsf
	 t1S3lMxn57wz1UMqqLqZvQrr3B9DyreCWn9DUdzk5tMAQrbmu2AVPHaZAI856N+PvD
	 Zm6U3+d9Mh7dQ==
Date: Thu, 4 Jan 2024 16:58:47 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
    Daniel Vetter <daniel@ffwll.ch>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen/gntdev: Fix the abuse of underlying struct page in
 DMA-buf import
In-Reply-To: <20240104185327.177376-1-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2401041658200.1322202@ubuntu-linux-20-04-desktop>
References: <20240104185327.177376-1-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Jan 2024, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> DO NOT access the underlying struct page of an sg table exported
> by DMA-buf in dmabuf_imp_to_refs(), this is not allowed.
> Please see drivers/dma-buf/dma-buf.c:mangle_sg_table() for details.
> 
> Fortunately, here (for special Xen device) we can avoid using
> pages and calculate gfns directly from dma addresses provided by
> the sg table.
> 
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Please note, I didn't manage to test the patch against the latest master branch
> on real HW (patch was only build tested there). Patch was tested on Arm64
> guests using Linux v5.10.41 from vendor's BSP, this is the environment where
> running this use-case is possible and to which I have an access (Xen PV display
> with zero-copy and backend domain as a buffer provider - be-alloc=1, so dma-buf
> import part was involved). A little bit old, but the dma-buf import code
> in gntdev-dmabuf.c hasn't been changed much since that time, all context
> remains allmost the same according to my code inspection.
> ---
> ---
>  drivers/xen/gntdev-dmabuf.c | 42 +++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> index 4440e626b797..0dde49fca9a5 100644
> --- a/drivers/xen/gntdev-dmabuf.c
> +++ b/drivers/xen/gntdev-dmabuf.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/dma-buf.h>
> +#include <linux/dma-direct.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -50,7 +51,7 @@ struct gntdev_dmabuf {
>  
>  	/* Number of pages this buffer has. */
>  	int nr_pages;
> -	/* Pages of this buffer. */
> +	/* Pages of this buffer (only for dma-buf export). */
>  	struct page **pages;
>  };
>  
> @@ -484,7 +485,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
>  /* DMA buffer import support. */
>  
>  static int
> -dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
> +dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
>  				int count, int domid)
>  {
>  	grant_ref_t priv_gref_head;
> @@ -507,7 +508,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
>  		}
>  
>  		gnttab_grant_foreign_access_ref(cur_ref, domid,
> -						xen_page_to_gfn(pages[i]), 0);
> +						gfns[i], 0);
>  		refs[i] = cur_ref;
>  	}
>  
> @@ -529,7 +530,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
>  
>  static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
>  {
> -	kfree(gntdev_dmabuf->pages);
>  	kfree(gntdev_dmabuf->u.imp.refs);
>  	kfree(gntdev_dmabuf);
>  }
> @@ -549,12 +549,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
>  	if (!gntdev_dmabuf->u.imp.refs)
>  		goto fail;
>  
> -	gntdev_dmabuf->pages = kcalloc(count,
> -				       sizeof(gntdev_dmabuf->pages[0]),
> -				       GFP_KERNEL);
> -	if (!gntdev_dmabuf->pages)
> -		goto fail;
> -
>  	gntdev_dmabuf->nr_pages = count;
>  
>  	for (i = 0; i < count; i++)
> @@ -576,7 +570,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
>  	struct dma_buf *dma_buf;
>  	struct dma_buf_attachment *attach;
>  	struct sg_table *sgt;
> -	struct sg_page_iter sg_iter;
> +	struct sg_dma_page_iter sg_iter;
> +	unsigned long *gfns;
>  	int i;
>  
>  	dma_buf = dma_buf_get(fd);
> @@ -624,26 +619,23 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
>  
>  	gntdev_dmabuf->u.imp.sgt = sgt;
>  
> -	/* Now convert sgt to array of pages and check for page validity. */
> +	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
> +	if (!gfns)
> +		goto fail_unmap;
> +
> +	/* Now convert sgt to array of gfns without accessing underlying pages. */
>  	i = 0;
> -	for_each_sgtable_page(sgt, &sg_iter, 0) {
> -		struct page *page = sg_page_iter_page(&sg_iter);
> -		/*
> -		 * Check if page is valid: this can happen if we are given
> -		 * a page from VRAM or other resources which are not backed
> -		 * by a struct page.
> -		 */
> -		if (!pfn_valid(page_to_pfn(page))) {
> -			ret = ERR_PTR(-EINVAL);
> -			goto fail_unmap;
> -		}
> +	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
> +		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
> +		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
>  
> -		gntdev_dmabuf->pages[i++] = page;
> +		gfns[i++] = pfn_to_gfn(pfn);
>  	}
>  
> -	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
> +	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
>  						      gntdev_dmabuf->u.imp.refs,
>  						      count, domid));
> +	kfree(gfns);
>  	if (IS_ERR(ret))
>  		goto fail_end_access;
>  
> -- 
> 2.34.1
> 

