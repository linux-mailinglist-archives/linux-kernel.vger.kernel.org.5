Return-Path: <linux-kernel+bounces-23820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166082B237
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AFE1C26256
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769A50254;
	Thu, 11 Jan 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMYt55bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC550246
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA56C433F1;
	Thu, 11 Jan 2024 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704988513;
	bh=DnXBtrvk/IS9GuQJA1+8G+V0JxY/FRS95VNaOLPHcEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMYt55bfOJZKlbU2ajfSYoGf/KPFvSFtYDJlxru2THpRxBcS6JV0wbAu+z0pvoKnY
	 UPMgMyzr4sOGWbu+o/sz6hwTubjtToDFMiOKahOF+FFw3GxnYpCAeFVGkRJ/7hdR0F
	 ECbvG0PGpI+ABpSBD/ou8lOCzb+lepZ5xqoO2dSZkFzdBe25pVgs0rXQD8oSqwv24k
	 dYErq6ggotivkRG5qW8DdAcjDbc/uH6GeQ1v9OWk84u5HjCMVfaXq+2OsYxeEg9std
	 /M4qh5v8mtK2CTihhTYbX6YVtoFFzUW8rKezQVvNRNo5T+qzn9uhzOm4MqNKD4UWmi
	 fvfxCVqVhSJyw==
Date: Thu, 11 Jan 2024 08:55:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] Fix a wrong value passed to __find_vmap_area()
Message-ID: <20240111155511.GA3451701@dev-arch.thelio-3990X>
References: <20240111121104.180993-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111121104.180993-1-urezki@gmail.com>

On Thu, Jan 11, 2024 at 01:11:04PM +0100, Uladzislau Rezki (Sony) wrote:
> There was a type in the vmalloc_dump_obj() function. Instead
> of passing a real address which is "objp" an "addr" was used
> what is wrong and not initialized.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e88b85b81d5 ("mm: vmalloc: offload free_vmap_area_lock lock")

I am not sure that e88b85b81d5 introduced this. Based on the diff, I
think it was actually commit 86817057732a ("mm: vmalloc: remove global
vmap_area_root rb-tree"). Does not really matter for the patch text but
I think it does matter for what change this gets squashed into.

> Closes: https://lore.kernel.org/oe-kbuild-all/202401111810.TKPIXLCs-lkp@intel.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e30dabf68263..43a6608e1397 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4688,7 +4688,7 @@ bool vmalloc_dump_obj(void *object)
>  	vn = addr_to_node((unsigned long)objp);
>  
>  	if (spin_trylock(&vn->busy.lock)) {
> -		va = __find_vmap_area(addr, &vn->busy.root);
> +		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
>  
>  		if (va && va->vm) {
>  			addr = (unsigned long)va->vm->addr;
> -- 
> 2.39.2
> 

