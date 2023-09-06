Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16F793C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbjIFMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbjIFMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:06:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5BE137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xxtZLesekG5b3wFQxKCMYE9RzV9DalJ9DCN36y6rges=; b=KAoOyUKic//cS3SljhfoqVfwOG
        t7OA3gIUOpNAA9sB6I2SEhf0rc1Hi3hISHknlsGytlQdui4DTImSv2xtPfyAUGu/OqdBf+BL63Z8z
        236J0uwDWZqgDLDQBf2wQ1dorXu2QGAuaqU7wG4/W4KLyVprOEfmIc4pMFngUYWylubzUC7tKhjfv
        S/U9w/yJABX6EhBgi+pc3XcrSmzgIJAR1wlOMdVwwsU4Mf3XKayxhIqwt8Q+bw5BhGkXViTp7PpHA
        qWPWSRsYsWWNoHMzxYVdEEthDJqsGpIHNfj2HHtEurbEqpHqcVVZ1kTWKyPQQHh+MAQYLQavtct46
        PAE+j/0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdrJ2-0029QD-Oq; Wed, 06 Sep 2023 12:06:48 +0000
Date:   Wed, 6 Sep 2023 13:06:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Edward AD <eadavis@sina.com>
Cc:     syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm: as the same logic with queue_pages_range
Message-ID: <ZPhrWDYL+JfI6upH@casper.infradead.org>
References: <000000000000f392a60604a65085@google.com>
 <20230906061902.591996-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906061902.591996-1-eadavis@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 02:19:02PM +0800, Edward AD wrote:
> Only dealwith queue_pages_range locked vmas.

What?

> Signed-off-by: Edward AD <eadavis@sina.com>
> ---
>  mm/mempolicy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..13050b968479 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1342,6 +1342,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	vma_iter_init(&vmi, mm, start);
>  	prev = vma_prev(&vmi);
>  	for_each_vma_range(vmi, vma, end) {
> +		if (!vma || start < vma->vm_start)
> +			continue;

#define for_each_vma_range(__vmi, __vma, __end)                         \
        while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)

How can this produce a vma that is either NULL or has a vm_start after start?

