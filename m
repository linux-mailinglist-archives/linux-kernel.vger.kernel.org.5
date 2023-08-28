Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB678AEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjH1Ley (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjH1Lea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:34:30 -0400
Received: from out-250.mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93350C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:34:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693222465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRnBVmo3DqIJBhnJXFu4mrZmcPdTw6TB48chGflHSQo=;
        b=jLDHp/fW0ZFEyBVC1B8yr1RaUdS0s11uyb5GHbfG6vpiBhjWbkUSTGxXUNjkyxMLbQgAEs
        03I3jR5QDowd3vVakYqmXTWNcRvorVbJxTJHULOK5hpBSL4MaypJWxC9BU4H243VOocBOC
        g1tznq1EXlB2HAsMZ2msACd5tkSeenQ=
Mime-Version: 1.0
Subject: Re: [v3 4/4] mm: hugetlb: Skip initialization of gigantic tail struct
 pages if freed by HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825111836.1715308-5-usama.arif@bytedance.com>
Date:   Mon, 28 Aug 2023 19:33:46 +0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> 
> The new boot flow when it comes to initialization of gigantic pages
> is as follows:
> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> the region after the first struct page is marked as noinit.
> - This results in only the first struct page to be
> initialized in reserve_bootmem_region. As the tail struct pages are
> not initialized at this point, there can be a significant saving
> in boot time if HVO succeeds later on.
> - Later on in the boot, HVO is attempted. If its successful, only the first
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> after the head struct page are initialized. If it is not successful,
> then all of the tail struct pages are initialized.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

This edition is simpler than before ever, thanks for your work.

There is premise that other subsystems do not access vmemmap pages
before the initialization of vmemmap pages associated withe HugeTLB
pages allocated from bootmem for your optimization. However, IIUC, the
compacting path could access arbitrary struct page when memory fails
to be allocated via buddy allocator. So we should make sure that
those struct pages are not referenced in this routine. And I know
if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
the same issue, but I don't find any code to prevent this from
happening. I need more time to confirm this, if someone already knows,
please let me know, thanks. So I think HugeTLB should adopt the similar
way to prevent this.

Thanks.

