Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB87C4C39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjJKHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJKHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:45:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED939D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697010342; x=1728546342;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=z6TQtKHbDxI4Cd9EvJz9KyHI0D2KSVDUyCYQKiuwwwE=;
  b=GzuQzTeKrj4roY/PrwvLcJwsJvmJSNeTmYvlEJLu1+IIrNggLpyKee5Q
   XO6DJTz80N5h2sF64HuM82mYesf8CdtxDj6PTwHqY38Cq7bUSOykTltql
   RX8dYPNx3Flp6Nq/zauKEBm5qWOoR3CyQKSlpzGqu9OYK1vTucxnUNNw6
   3fdEZnCy+KFYGg1/5lXXrBlU64PM+dMHgFhZS5r9jePIAAwKGeCM6Alc4
   t+ubeYE1+iIvz+/SI7fckMBEr7IQA9gJuTz+WAy4lfeTUxzKIB67F3x0k
   0wcSS5UNPd5oeZmSxeeEC/94I4VDX83bP3vH+tJ+cwYlkG72nz8diJ5YK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387445118"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387445118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897535986"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897535986"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 1/2] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
        <20231010142111.3997780-2-ryan.roberts@arm.com>
Date:   Wed, 11 Oct 2023 15:43:36 +0800
In-Reply-To: <20231010142111.3997780-2-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Tue, 10 Oct 2023 15:21:10 +0100")
Message-ID: <87v8bdfvtj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> As preparation for supporting small-sized THP in the swap-out path,
> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
> which, when present, always implies PMD-sized THP, which is the same as
> the cluster size.
>
> The only use of the flag was to determine whether a swap entry refers to
> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
> Instead of relying on the flag, we now pass in nr_pages, which
> originates from the folio's number of pages. This allows the logic to
> work for folios of any order.
>
> The one snag is that one of the swap_page_trans_huge_swapped() call
> sites does not have the folio. But it was only being called there to
> avoid bothering to call __try_to_reclaim_swap() in some cases.
> __try_to_reclaim_swap() gets the folio and (via some other functions)
> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> call site and believe the new logic should be equivalent.

I believe this should be OK.  Better to compare the performance too.

> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
> which used to be called during folio splitting, since
> split_swap_cluster()'s only job was to remove the flag.
>

--
Best Regards,
Huang, Ying
