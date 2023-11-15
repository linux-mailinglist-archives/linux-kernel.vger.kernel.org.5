Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82E7EC4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbjKOOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjKOOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:19:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F3C5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8wVh7DNUM7SnBmRuhtk1Q8XS+buoIAZhntJMpDAZN9s=; b=CkLWirzPtZyuIqJtO/yj4dR8ED
        VmPqsDv+N0TdxUVmsRFwrWQj428Pmah59NVEjJB74wg7JRFWMvDES4RAXI9s7RpUvvjsPrNIaaXVg
        N4T8JsQefBRczx7SkSy1sCw/4fIDjOfo6LYqXqTQDZtZppFsQ5g7OUqg31qMMKPCBM4LATNf2eueY
        0ZKJKBE/hNWqK1goS88kx5kDx3DD1zY6cawzbRihDONBejLL2aXY9GaNa8LZigajivqS5JyVvHK20
        qcUrWVVlFGUmCAfPwFZSQa/9cUWiN1fNuN1bmLu26zaIonEcKla7dquCqe2QTG+ymhPukrViod3+v
        YRk+8CXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3Gjm-00EekH-Dv; Wed, 15 Nov 2023 14:19:26 +0000
Date:   Wed, 15 Nov 2023 14:19:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     akpm@linux-foundation.org, skhan@linuxfoundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev,
        syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/pgtable: return null if no ptl in
 __pte_offset_map_lock
Message-ID: <ZVTTbuviH9/RWYyI@casper.infradead.org>
References: <20231115065506.19780-1-jose.pekkarinen@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115065506.19780-1-jose.pekkarinen@foxhound.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:55:05AM +0200, José Pekkarinen wrote:
> Documentation of __pte_offset_map_lock suggest there is situations where

You should have cc'd Hugh who changed all this code recently.

> a pmd may not have a corresponding page table, in which case it should
> return NULL without changing ptlp. Syzbot found its ways to produce a
> NULL dereference in the function showing this case. This patch will
> provide the exit path suggested if this unlikely situation turns up. The
> output of the kasan null-ptr-report follows:

There's no need to include all this nonsense in the changelog.

>  spin_lock include/linux/spinlock.h:351 [inline]
>  __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:373
>  pte_offset_map_lock include/linux/mm.h:2939 [inline]
>  filemap_map_pages+0x698/0x11f0 mm/filemap.c:3582

This was the only interesting part.

> +++ b/include/linux/mm.h
> @@ -2854,7 +2854,7 @@ void ptlock_free(struct ptdesc *ptdesc);
>  
>  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>  {
> -	return ptdesc->ptl;
> +	return (likely(ptdesc)) ? ptdesc->ptl : NULL;
>  }

I don't think we should be changing ptlock_ptr().

> +++ b/mm/pgtable-generic.c
> @@ -370,6 +370,8 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  	if (unlikely(!pte))
>  		return pte;
>  	ptl = pte_lockptr(mm, &pmdval);
> +	if (unlikely(!ptl))
> +		return NULL;
>  	spin_lock(ptl);

I don't understand how this could possibly solve the problem.  If there's
no PTE level, then __pte_offset_map() should return NULL and we'd already
return due to the check for !pte.
