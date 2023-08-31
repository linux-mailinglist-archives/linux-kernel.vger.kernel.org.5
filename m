Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE778E737
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjHaHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHaHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A91A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC606349B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3109C433AB;
        Thu, 31 Aug 2023 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693467225;
        bh=uBbUIx+dWiP81snMHPZPsuyuXAf8/yb8NeMDAgIBQFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p78tUK9qmJHU66Mv1WXWjGIsu44jcI1CeWmOqcSZeneI72RA+W/nhHwI7K5fhBHQ/
         o1AwHUdH6uld+XBRisOf0GaMsPIcyXhms/j32rOVrwnkAR7ZcVB2IRYYZtHR1JBrmB
         Pzqgjf2RH29h/Ul2knGx33f3/X/3nssjfsc3VdzCh7Q3NKdyC9kQZfJhHMUYBqWMgR
         sa+P5BfvRAnKa2f7Z6Yq9kkqK3WG889sjV+WyZs9xZ/IkRNoz0uIRnLehV/+F0yxlu
         texuzH2ulLcki8UyV4PtfURDvbfmy43KYIp4nrwHWvH+57omGQEQeMX7vuLgQEJtlm
         ut6tkFnSywtyQ==
Date:   Thu, 31 Aug 2023 10:33:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     Muchun Song <muchun.song@linux.dev>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, mgorman@techsingularity.net,
        akpm@linux-foundation.org
Subject: Re: [External] Re: [v3 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Message-ID: <20230831073306.GE3223@kernel.org>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:27:42AM +0100, Usama Arif wrote:
> 
> On 28/08/2023 12:33, Muchun Song wrote:
> > 
> > 
> > > On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> > > 
> > > The new boot flow when it comes to initialization of gigantic pages
> > > is as follows:
> > > - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> > > the region after the first struct page is marked as noinit.
> > > - This results in only the first struct page to be
> > > initialized in reserve_bootmem_region. As the tail struct pages are
> > > not initialized at this point, there can be a significant saving
> > > in boot time if HVO succeeds later on.
> > > - Later on in the boot, HVO is attempted. If its successful, only the first
> > > HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> > > after the head struct page are initialized. If it is not successful,
> > > then all of the tail struct pages are initialized.
> > > 
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > 
> > This edition is simpler than before ever, thanks for your work.
> > 
> > There is premise that other subsystems do not access vmemmap pages
> > before the initialization of vmemmap pages associated withe HugeTLB
> > pages allocated from bootmem for your optimization. However, IIUC, the
> > compacting path could access arbitrary struct page when memory fails
> > to be allocated via buddy allocator. So we should make sure that
> > those struct pages are not referenced in this routine. And I know
> > if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
> > the same issue, but I don't find any code to prevent this from
> > happening. I need more time to confirm this, if someone already knows,
> > please let me know, thanks. So I think HugeTLB should adopt the similar
> > way to prevent this.
> > 
> > Thanks.
> > 
> 
> Thanks for the reviews.
> 
> So if I understand it correctly, the uninitialized pages due to the
> optimization in this patch and due to DEFERRED_STRUCT_PAGE_INIT should be
> treated in the same way during compaction. I see that in isolate_freepages
> during compaction there is a check to see if PageBuddy flag is set and also
> there are calls like __pageblock_pfn_to_page to check if the pageblock is
> valid.
> 
> But if the struct page is uninitialized then they would contain random data
> and these checks could pass if certain bits were set?
> 
> Compaction is done on free list. I think the uninitialized struct pages
> atleast from DEFERRED_STRUCT_PAGE_INIT would be part of freelist, so I think
> their pfn would be considered for compaction.
> 
> Could someone more familiar with DEFERRED_STRUCT_PAGE_INIT and compaction
> confirm how the uninitialized struct pages are handled when compaction
> happens? Thanks!

I'm not familiar with compaction enough to confirm it only touches pages on
the free lists, but DEFERRED_STRUCT_PAGE_INIT makes sure the struct page is
initialized before it's put on a free list.
 
> Usama

-- 
Sincerely yours,
Mike.
