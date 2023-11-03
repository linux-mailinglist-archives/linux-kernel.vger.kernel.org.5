Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF67DFDA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjKCA5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 20:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjKCA5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:57:21 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC3196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:57:16 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qyiUR-0006V8-14;
        Thu, 02 Nov 2023 20:56:47 -0400
Message-ID: <32cb089b2afec5dc3bb96234753cca4b22cb9ccd.camel@surriel.com>
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
From:   Rik van Riel <riel@surriel.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Thu, 02 Nov 2023 20:56:47 -0400
In-Reply-To: <tencent_164A247533766D667C3D873798968236C409@qq.com>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
         <tencent_164A247533766D667C3D873798968236C409@qq.com>
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

On Thu, 2023-11-02 at 20:58 +0800, Edward Adam Davis wrote:
> 
> +++ b/include/linux/hugetlb.h
> 
> +#define HPAGE_RESV_OWNER    (1UL << 0)
>  static inline bool __vma_private_lock(struct vm_area_struct *vma)
>  {
> -       return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
> >vm_private_data;
> +       return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
> >vm_private_data && 
> +               is_vma_resv_set(vma, HPAGE_RESV_OWNER);
>  }
>  
>  /*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1301ba7b2c9a..97ea782dfba6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1033,7 +1033,6 @@ __weak unsigned long vma_mmu_pagesize(struct
> vm_area_struct *vma)
>   * bits of the reservation map pointer, which are always clear due
> to
>   * alignment.
>   */
> -#define HPAGE_RESV_OWNER    (1UL << 0)
>  #define HPAGE_RESV_UNMAPPED (1UL << 1)
>  #define HPAGE_RESV_MASK (HPAGE_RESV_OWNER | HPAGE_RESV_UNMAPPED)
>  

Moving just that one define is less than ideal, and the
kernel test robot seems unhappy, too.

It may be cleaner to just move __vma_private_lock into
hugetlb.c, where it has all the dependencies it needs.

It isn't being called from anywhere else, anyway.

Hopefully that will keep the kernel test robot happy, too :)

-- 
All Rights Reversed.
