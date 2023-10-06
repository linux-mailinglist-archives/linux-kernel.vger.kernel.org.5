Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D897BB087
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjJFD3d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 23:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJFD3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:29:31 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21873E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:29:29 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qobWM-0001qH-1a;
        Thu, 05 Oct 2023 23:28:58 -0400
Message-ID: <d31f976cd37567b88b359749ee31fbf42568dd6d.camel@surriel.com>
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Date:   Thu, 05 Oct 2023 23:28:58 -0400
In-Reply-To: <20231006001912.GB86415@monkey>
References: <20231004032814.3108383-1-riel@surriel.com>
         <20231004032814.3108383-4-riel@surriel.com> <20231006001912.GB86415@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 17:19 -0700, Mike Kravetz wrote:
> 
> I have not gone through the patch, but it does produce the following:
> 
> [   49.783584] =====================================
> [   49.784570] WARNING: bad unlock balance detected!
> [   49.785589] 6.6.0-rc3-next-20230925+ #35 Not tainted
> [   49.786644] -------------------------------------
> [   49.787768] hfill2/938 is trying to release lock
> (mapping.invalidate_lock) at:
> [   49.789387] [<ffffffff815212e5>]
> remove_inode_hugepages+0x405/0x4b0
> [   49.790723] but there are no more locks to release!
> [   49.791808] 
> [   49.791808] other info that might help us debug this:
> [   49.793274] 4 locks held by hfill2/938:
> [   49.794190]  #0: ffff8881ff3213e8 (sb_writers#11){.+.+}-{0:0}, at:
> do_syscall_64+0x37/0x90
> [   49.796165]  #1: ffff888181c99640 (&sb->s_type-
> >i_mutex_key#16){+.+.}-{3:3}, at: do_truncate+0x6f/0xd0
> [   49.798188]  #2: ffff888301592f98
> (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at:
> remove_inode_hugepages+0x144/0x4b0
> [   49.800494]  #3: ffff888181c998b0
> (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at:
> remove_inode_hugepages+0x239/0x4b0

Well that's a fun one. The remove_inode_hugepages function
does not take the mapping.invalidate_lock, but it calls
hugetlb_unmap_file_folio which does.

The vma_interval_tree_foreach loop has a stray
hugetlb_vma_unlock_write() left, which I should have
removed when lifting the lock outside of the loop.

Nice catch!

-- 
All Rights Reversed.
