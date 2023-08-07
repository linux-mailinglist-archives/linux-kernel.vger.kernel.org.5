Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FAB7718AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHGDD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGDDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:03:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE9170B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mrJGK7xolmy7+30+SP6QcPep8mA36OiN+uaIxGFlkBw=; b=fHYhJwBW43fhUdx0xdp6D5QHf+
        55sr6rFVnJ5VLQBVaMNLGIlPAo8GcPHHZ/Fe395R0gAudV0f2vm5tDMhU1GkdMODztAnJDyOEAeEu
        g0gS90RXQcnLviWMEvBMZArEB/Pi4xYmjULReOe9h8f8jRIRRuJf4dIaV0GHP51g4UpFQCp+ceMB5
        2vqu12++RzjanEGjMHOi5LNM//pC8ctt+RIYIT6F0XYCNrlT2edy/EkHtIWH95MFDEXIiihg1FxIc
        co3YGxBQgODDfA67cUld6gx762nwT3m/PWib9uUD8DRVsovqslcXFnMHqCbO3DPmLp3RvBFoPm3M+
        pc/lT/GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSqX4-007zHX-Ut; Mon, 07 Aug 2023 03:03:46 +0000
Date:   Mon, 7 Aug 2023 04:03:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move dummy_vm_ops out of a header
Message-ID: <ZNBfEjZRWnPrCIGu@casper.infradead.org>
References: <20230806231611.1395735-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806231611.1395735-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:16:11AM +0200, Mateusz Guzik wrote:
> Otherwise the kernel ends up with multiple copies:
> $ nm vmlinux | grep dummy_vm_ops
> ffffffff81e4ea00 d dummy_vm_ops.2
> ffffffff81e11760 d dummy_vm_ops.254
> ffffffff81e406e0 d dummy_vm_ops.4
> ffffffff81e3c780 d dummy_vm_ops.7
> 
> While here prefix it with vma_.

It really shouldn't be prefixed with vma.  Other than that, I love this
patch.

> [if someone has better ideas where to put it, please move it]
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/mm.h | 6 +++---
>  mm/init-mm.c       | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 406ab9ea818f..14898e76bbf1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -756,17 +756,17 @@ static inline void vma_mark_detached(struct vm_area_struct *vma,
>  
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
> +extern const struct vm_operations_struct vma_dummy_vm_ops;
> +
>  /*
>   * WARNING: vma_init does not initialize vma->vm_lock.
>   * Use vm_area_alloc()/vm_area_free() if vma needs locking.
>   */
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
> -	static const struct vm_operations_struct dummy_vm_ops = {};
> -
>  	memset(vma, 0, sizeof(*vma));
>  	vma->vm_mm = mm;
> -	vma->vm_ops = &dummy_vm_ops;
> +	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  	vma_mark_detached(vma, false);
>  	vma_numab_state_init(vma);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index efa97b57acfd..cfd367822cdd 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -17,6 +17,8 @@
>  #define INIT_MM_CONTEXT(name)
>  #endif
>  
> +const struct vm_operations_struct vma_dummy_vm_ops;
> +
>  /*
>   * For dynamically allocated mm_structs, there is a dynamically sized cpumask
>   * at the end of the structure, the size of which depends on the maximum CPU
> -- 
> 2.39.2
> 
> 
