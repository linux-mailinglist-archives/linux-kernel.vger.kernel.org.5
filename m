Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC37AB696
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjIVQ5Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:57:23 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D88F1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:57:17 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qjjSa-00017W-09;
        Fri, 22 Sep 2023 12:56:56 -0400
Message-ID: <ad7546055971c69ff386ed666ca9338c0db1b01c.camel@surriel.com>
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Date:   Fri, 22 Sep 2023 12:56:55 -0400
In-Reply-To: <20230922164408.GA224968@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
         <20230920021811.3095089-2-riel@surriel.com> <20230921224201.GB21193@monkey>
         <c3309a3486df6ad2901d4d5c23e7bc6f4b8a9a24.camel@surriel.com>
         <20230922164408.GA224968@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 09:44 -0700, Mike Kravetz wrote:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f906c5fa4d09..8f3d5895fffc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -372,6 +372,11 @@ static void
> __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
>                 struct hugetlb_vma_lock *vma_lock = vma-
> >vm_private_data;
>  
>                 __hugetlb_vma_unlock_write_put(vma_lock);
> +       } else if (__vma_private_lock(vma)) {
> +               struct resv_map *resv_map = vma_resv_map(vma);
> +
> +               /* no free for anon vmas, but still need to unlock */
> +               up_write(&resv_map->rw_sema);
>         }
>  }
> 

Nice catch. I'll add that.

I was still trying to reproduce the bug here.

The libhugetlbfs code compiles with the offending bits
commented out, but the misaligned_offset test wasn't
causing trouble on my test VM here.

Given the potential negative impact of moving from a
per-VMA lock to a per-backing-address_space lock, I'll
keep the 3 patches separate, and in the order they are
in now.

Let me go spin and test v2.

-- 
All Rights Reversed.
