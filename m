Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890C97D894F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjJZUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:00:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30900B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RvOXwandeVYtdokqifAIU5QghzlMJsS3czqYn7Psq7E=; b=kRfJ/TcxIaEyeZwdVqfX4UvqrI
        aY2pRl9eiyXEJrUSsDRRXOn2/hlT7BCsqe/TLrJjdQPqdBafYpuuPJupOgHXFH341YSRFk7j072K1
        6zFUdJwNjVCMZiYM+gYrsqMq2K1ukBOiz9ddpwwpI8g+oQ7g9H2HC62bi1bobZctV8YqZfkLzx58R
        wdJbaeGZAcx2MRd4Hhy2ClAHNIyRoUM5+j7G1QuYmOX0u5DPDeKJ9DubQl+lYHEwsDjy40bt8JJvC
        5nPJ22TU/FNOR1xCxGoYKY0vzpahOetj5K68dWUe3qFpip3B3bRJX34JS2+B/KladbvQSwcLngDz6
        lK917kEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qw6WX-00GtAR-D5; Thu, 26 Oct 2023 20:00:09 +0000
Date:   Thu, 26 Oct 2023 21:00:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH] kpageflags: respect folio head-page flag placement
Message-ID: <ZTrFSeG16WCoak2C@casper.infradead.org>
References: <20231025201237.948993-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025201237.948993-1-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:12:37PM -0400, Gregory Price wrote:
> +++ b/fs/proc/page.c
> @@ -188,20 +188,31 @@ u64 stable_page_flags(struct page *page)
>  		u |= 1 << KPF_SLAB;
>  
>  	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
> -	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
> +
> +	if (PageDirty(page))
> +		u |= 1 << KPF_DIRTY;

This is not the way to do it.

At the beginning of the function, add:

	struct folio *folio = page_folio(page);

Then use folio_test_XXX istead of PageXXX().

