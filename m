Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37D7DE34D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbjKAO23 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjKAO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:28:28 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF4110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:28:26 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qyCCL-00084w-04;
        Wed, 01 Nov 2023 10:27:57 -0400
Message-ID: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
From:   Rik van Riel <riel@surriel.com>
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Wed, 01 Nov 2023 10:27:56 -0400
In-Reply-To: <tencent_2A675773C6D47370E36A4966A3BA2444F705@qq.com>
References: <00000000000078d1e00608d7878b@google.com>
         <tencent_2A675773C6D47370E36A4966A3BA2444F705@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 14:36 +0800, Edward Adam Davis wrote:
> When obtaining resv_map from vma, it is necessary to simultaneously
> determine
> the flag HPAGE_RESV_OWNER of vm_private_data.
> Only when they are met simultaneously, resv_map is valid.
> 
> Reported-and-tested-by:
> syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private
> VMAs")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  include/linux/hugetlb.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 47d25a5e1933..1a3ec1aee1a3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1265,9 +1265,11 @@ static inline bool __vma_shareable_lock(struct
> vm_area_struct *vma)
>         return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
>  }
>  
> +#define HPAGE_RESV_OWNER    (1UL << 0)
>  static inline bool __vma_private_lock(struct vm_area_struct *vma)
>  {
> -       return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
> >vm_private_data;
> +       return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
> >vm_private_data && 
> +               ((unsigned long)vma->vm_private_data &
> HPAGE_RESV_OWNER);
>  }

This could be cleaned up a bit by moving the HPAGE_RESV_OWNER
definition (and its friends) into hugetlb.h, as well as the
is_vma_resv_set() helper function.

Then __vma_private_lock() can just call is_vma_resv_set(),
and open coding a duplicate of the same code.

Not having duplicates of the code will make it much harder
to "miss a spot" with future changes.

I am still struggling to find a place where we might leave
HPAGE_RESV_OWNER behind on a pointer that is otherwise NULL,
but if your tests show this fixes the issue, I'm all for it :)

-- 
All Rights Reversed.
