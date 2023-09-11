Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CED79BD36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjIKVSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbjIKMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:12:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF92CEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:12:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DE74211C3;
        Mon, 11 Sep 2023 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694434346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tf7tRdXV7UNidkw8jKJWLwlUfOkHdMG5nA5zEy+A7gU=;
        b=AFfYbBiBycdQ/2GmktSMV/Pjt55ov/8QmZZf97c1lCCggS/qdwO6Y7QmVSqA0cAWWBt5zg
        orVTV43YzbN/432DUSHe671rHSPe8G1zxlndiS1Dd9QhitBEujAnQpCEHk5RdvtIVWShKA
        RLuidco961+1lUqdwpq33w9qVPmQ6fk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 199B9139CC;
        Mon, 11 Sep 2023 12:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cjAoAyoE/2SCAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 11 Sep 2023 12:12:26 +0000
Date:   Mon, 11 Sep 2023 14:12:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: remove redundant clear page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON configured
Message-ID: <ZP8EKWev8H9kMka3@dhcp22.suse.cz>
References: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-09-23 18:49:06, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> There will be redundant clear page within vma_alloc_zeroed_movable_folio
> when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on. Remove it by judging related
> configs.

Thanks for spotting this. I suspect this is a fix based on a code review
rather than a real performance issue, right? It is always good to
mention that. From a very quick look it seems that many architectures
just definte vma_alloc_zeroed_movable_folio to use __GFP_ZERO so they
are not affected by this. This means that only a subset of architectures
are really affected. This is an important information as well.
Finally I think it would be more appropriate to mention that the double
initialization is done when init_on_alloc is enabled rather than
referring to the above config option which only controls whether the
functionality is enabled by default.

I would rephrase as follows:
Many architectures (alpha, arm64, ia64, m68k s390, x86) define their own
vma_alloc_zeroed_movable_folio implementations which use __GFP_ZERO for
the page allocation.

Those which rely on the default implementation, however, would currently
go through the initialization twice (oce in the page allocator and
second in vma_alloc_zeroed_movable_folio) if init_on_alloc is enabled
though. Fix this by checking want_init_on_alloc before calling
clear_user_highpage.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

With the changelog updates
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/highmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 99c474de800d..3926f8414729 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -227,7 +227,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>  	struct folio *folio;
>  
>  	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
> -	if (folio)
> +	if (folio && !want_init_on_alloc(GFP_HIGHUSER_MOVABLE))
>  		clear_user_highpage(&folio->page, vaddr);
>  
>  	return folio;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
