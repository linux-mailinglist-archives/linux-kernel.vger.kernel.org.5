Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986B79156F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjIDKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjIDKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:03:22 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123DE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693821794;
        bh=Y+KsTpukaYfTZQUCMqYRBhRermVhX5Ciwu/jVzj/M8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O1nG18fcDnelTIvSTLo5J3men1NdktKf+FUCGE7PxQ1GtM0aDdPe/WZyoFZ/+RyNW
         REYN5gXdTiexYUIezoDevEp7htaZUpd8H534Fp90IgPXMnnyLl/VffdR3j/+xglkxu
         dkLyzBd/fFmf79trBrE3oft4eR0VxIWFG33DZHrbAurTIxY3c9+m1SQwCT8kPGRycX
         FXrvX6jawoJZKKVT339+YJ9emyNigpHlZe/4MitsjDACfpSRlTm/RUpJlv/6m3TgFD
         nDUaHlTgGKamTQ7xbLgvoKoqOCSzwhHWAm/eOVxfNqXclxCUQGMH8iNbJoe42wZqkn
         w3qXWRRRd17EQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RfPN25dCyz1N9n;
        Mon,  4 Sep 2023 06:03:14 -0400 (EDT)
Message-ID: <c5983185-5bdc-b703-1600-6e44c49d6442@efficios.com>
Date:   Mon, 4 Sep 2023 06:04:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [linus:master] [mm] c1753fd02a: stress-ng.madvise.ops_per_sec
 -6.5% regression
Content-Language: en-US
To:     Yin Fengwei <fengwei.yin@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        ying.huang@intel.com
References: <202307181511.8643eac7-oliver.sang@intel.com>
 <3b4ab51b-e3e9-a504-ee07-82326e9ee1e9@intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <3b4ab51b-e3e9-a504-ee07-82326e9ee1e9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 01:32, Yin Fengwei wrote:
> 
> 
> On 7/19/23 14:34, kernel test robot wrote:
>>
>> hi, Mathieu Desnoyers,
>>
>> we noticed that this commit addressed issue:
>>    "[linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops -13.9% regression"
>> we reported before on:
>>    https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com/
>>
>> we really saw a will-it-scale.per_thread_ops 92.2% improvement by this commit
>> (details are as below).
>> however, we also noticed a stress-ng regression.
>>
>> below detail report FYI.
>>
>>
>> Hello,
>>
>> kernel test robot noticed a -6.5% regression of stress-ng.madvise.ops_per_sec on:
>>
>>
>> commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ("mm: move mm_count into its own cache line")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> I noticed that the struct mm_struct has following layout change after this patch.
> Without the patch:
>                  spinlock_t         page_table_lock;      /*   124     4 */
>                  /* --- cacheline 2 boundary (128 bytes) --- */
>                  struct rw_semaphore mmap_lock;           /*   128    40 */   ----> in one cache line
>                  struct list_head   mmlist;               /*   168    16 */
>                  int                mm_lock_seq;          /*   184     4 */
> 
> With the patch:
>                  spinlock_t         page_table_lock;      /*   180     4 */
>                  struct rw_semaphore mmap_lock;           /*   184    40 */   ----> cross to two cache lines
>                  /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
>                  struct list_head   mmlist;               /*   224    16 */

If your intent is just to make sure that mmap_lock is entirely contained
within a cache line by forcing it to begin on a cache line boundary, you
can do:

struct mm_struct {
[...]
     struct rw_semaphore mmap_lock ____cacheline_aligned_in_smp;
     struct list_head mmlist;
[...]
};

The code above keeps mmlist on the same cache line as mmap_lock if
there happens to be enough room in the cache line after mmap_lock.

Otherwise, if your intent is to also eliminate false sharing by making
sure that mmap_lock sits alone in its cache line, you can do the following:

struct mm_struct {
[...]
     struct {
         struct rw_semaphore mmap_lock;
     } ____cacheline_aligned_in_smp;
     struct list_head mmlist;
[...]
};

The code above keeps mmlist in a separate cache line from mmap_lock;

Depending on the usage, one or the other may be better. Comparative
benchmarks of both approaches would help choosing the best way forward
here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

