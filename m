Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8A7FD012
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjK2HsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2HsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:48:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7410D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:48:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb55001124so471713b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701244089; x=1701848889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LsmkOiZmmVlmozGbrCeR5+nJa1SsA881rwPlAyz/nI=;
        b=OBidgWXgszpZmxXYv7Lf/wUybZ/rnq60PJq/DUhCuExaetDVG97O1OCmtMfbtBi6SC
         KQOyobyj1alpV2tSwtswGkZzxejjgdCxmt7k1EO+K+Y1pURwDQ9dA4v4D/xiwTz2DSNe
         kNa+l3d57Lv2PxtbOX6nG8yPqTre8wHc7/h0cUHXz8zRiUxoGL6QHjZgMzI1uCrnHy4U
         BdX14oNGxQMtyteWAVnpfNkzzVfD2YKWAp/fEz941PT1W0MSQtsee9b7990A1D9fklbv
         k9rDY+zk14GTgEKKvIha4ZEPvRA/crFLVuEfJGjl7D/6J/o/jAVE7L3YkHnEK5wMC52T
         hCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701244089; x=1701848889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LsmkOiZmmVlmozGbrCeR5+nJa1SsA881rwPlAyz/nI=;
        b=L030qcwYF1S+51tcHFlAAsvBr1pnJx+2eKbedhn+Ci2r26XkduZC7GQpKNh/rX6b6J
         8i/a3gw2/hJt7pXNlVXB+U0/BgdEh/qCDlHjtbxuDhhl17ewYbqmqY2jV4WBpaKj6jct
         lH1Vnk1D6+SQcpuH4tfVsOZXW4ncnYuA637cV+NRJlU7EQ4RxRsyFIgMJJJ0szmnz3TY
         Hn23svfwhB4849ZMmjM09OqQ+FVLLvYeCA1s4SOTiCydt3GRGgfl6T8C5dx6NJxsMdfo
         JM27Nh6/1YbHdtm1ibz7TFUNbCh3Z3mgAsbgl8G+5jgoQaW/G8j7KCKw37HhipQHHWR6
         LB6g==
X-Gm-Message-State: AOJu0Yy7AP5L04n6Nucll4vt2DGJZUV4D5QfzGKfNd9C3b/OdqhYMcUL
        69IgQ31vqbXW+B6dTF9o39M=
X-Google-Smtp-Source: AGHT+IHconXlwv2Oxf+iVJsoobTCdl7aYpt1BKlRVRLPOKFRFNjZgzt5EVeAUWKtoNYd5pBbwFNrwA==
X-Received: by 2002:a05:6a20:841e:b0:18b:4f8b:5a05 with SMTP id c30-20020a056a20841e00b0018b4f8b5a05mr25778553pzd.30.1701244089366;
        Tue, 28 Nov 2023 23:48:09 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:35f3:88a6:8194:6439])
        by smtp.gmail.com with ESMTPSA id l23-20020a63ba57000000b005c2900df62esm864473pgu.63.2023.11.28.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:48:09 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, hanchuanhua@oppo.com
Subject: Re: [PATCH v3 0/4] Swap-out small-sized THP without splitting
Date:   Wed, 29 Nov 2023 20:47:41 +1300
Message-Id: <20231129074741.15682-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025144546.577640-1-ryan.roberts@arm.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi All,
> 
> This is v3 of a series to add support for swapping out small-sized THP without
> needing to first split the large folio via __split_huge_page(). It closely
> follows the approach already used by PMD-sized THP.
> 
> "Small-sized THP" is an upcoming feature that enables performance improvements
> by allocating large folios for anonymous memory, where the large folio size is
> smaller than the traditional PMD-size. See [3].
> 
> In some circumstances I've observed a performance regression (see patch 2 for
> details), and this series is an attempt to fix the regression in advance of
> merging small-sized THP support.
> 
> I've done what I thought was the smallest change possible, and as a result, this
> approach is only employed when the swap is backed by a non-rotating block device
> (just as PMD-sized THP is supported today). Discussion against the RFC concluded
> that this is probably sufficient.
> 
> The series applies against mm-unstable (1a3c85fa684a)
> 
> 
> Changes since v2 [2]
> ====================
> 
>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
>    allocation. This required some refactoring to make everything work nicely
>    (new patches 2 and 3).
>  - Fix bug where nr_swap_pages would say there are pages available but the
>    scanner would not be able to allocate them because they were reserved for the
>    per-cpu allocator. We now allow stealing of order-0 entries from the high
>    order per-cpu clusters (in addition to exisiting stealing from order-0
>    per-cpu clusters).
> 
> Thanks to Huang, Ying for the review feedback and suggestions!
> 
> 
> Changes since v1 [1]
> ====================
> 
>  - patch 1:
>     - Use cluster_set_count() instead of cluster_set_count_flag() in
>       swap_alloc_cluster() since we no longer have any flag to set. I was unable
>       to kill cluster_set_count_flag() as proposed against v1 as other call
>       sites depend explicitly setting flags to 0.
>  - patch 2:
>     - Moved large_next[] array into percpu_cluster to make it per-cpu
>       (recommended by Huang, Ying).
>     - large_next[] array is dynamically allocated because PMD_ORDER is not
>       compile-time constant for powerpc (fixes build error).
> 
> 
> Thanks,
> Ryan

> P.S. I know we agreed this is not a prerequisite for merging small-sized THP,
> but given Huang Ying had provided some review feedback, I wanted to progress it.
> All the actual prerequisites are either complete or being worked on by others.
> 

Hi Ryan,

this is quite important to a phone and a must-have component, so is large-folio
swapin, as i explained to you in another email. 
Luckily, we are having Chuanhua Han(Cc-ed) to prepare a patchset of largefolio
swapin on top of your this patchset, probably a port and cleanup of our
do_swap_page[1] againest yours.

Another concern is that swapslots can be fragmented, if we place small/large folios
in a swap device, since large folios always require contiguous swapslot, we can
result in failure of getting slots even we still have many free slots which are not
contiguous. To avoid this, [2] dynamic hugepage solution have two swap devices,
one for basepage, the other one for CONTPTE. we have modified the priority-based
selection of swap devices to choose swap devices based on small/large folios.
i realize this approache is super ugly and might be very hard to find a way to
upstream though, it seems not universal especially if you are a linux server (-_-)

two devices are not a nice approach though it works well for a real product,
we might still need some decent way to address this problem while the problem
is for sure not a stopper of your patchset.

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L4648
[2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/swapfile.c#L1129

> 
> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753b04@arm.com/
> 
> 
> Ryan Roberts (4):
>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
>   mm: swap: Remove struct percpu_cluster
>   mm: swap: Simplify ssd behavior when scanner steals entry
>   mm: swap: Swap-out small-sized THP without splitting
> 
>  include/linux/swap.h |  31 +++---
>  mm/huge_memory.c     |   3 -
>  mm/swapfile.c        | 232 ++++++++++++++++++++++++-------------------
>  mm/vmscan.c          |  10 +-
>  4 files changed, 149 insertions(+), 127 deletions(-)

Thanks
Barry
