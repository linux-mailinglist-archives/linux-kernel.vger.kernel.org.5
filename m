Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C17A9046
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIUA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUA4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:56:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE0C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XYGTgVIYSEjTmo7UUNoXwCNhcc4oFR5jFDgdsjYRdSc=; b=aQvHTE/CAouVoyLi7Y7viO15No
        /fc9Xmw/lA4lnnkN3fJIiRJqNbLgH0qoyhmEaOmPm4r+eXwzfN1oFrx+cExguCfbCUjoGSCVS8jc6
        2h/oD8fj2Evg47CJ0Hcqw3hLDZRwreNraeRT+/JlB3u+Gm222Ju/KBerliVpB0f3l+/Z1lN5V4fL6
        fja1tgtj/BGfM8bdOW/Qzk7Nf/qEos9C0x/OQrFmHfde8+6NB0TeciPvNTfnhVqcD5dlEKphnvTu7
        3zdazoKNtDbjBhK9sjYvnIB0Es0qRR7BHOto/ju0wIhr9qNgYG4LU/JDJaH65bGSpe/lHtalY7auA
        7i3cnUsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj7yx-004aIp-2u;
        Thu, 21 Sep 2023 00:55:51 +0000
Date:   Wed, 20 Sep 2023 17:55:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Message-ID: <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912162815.440749-1-zi.yan@sent.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:28:11PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Feel free to give comments and ask questions.

How about testing? I'm looking with an eye towards creating a
pathalogical situation which can be automated for fragmentation and see
how things go.

Mel Gorman's original artificial fragmentation taken from his first
patches ot help with fragmentation avoidance from 2018 suggested he
tried [0]:

------ From 2018
a) Create an XFS filesystem

b) Start 4 fio threads that write a number of 64K files inefficiently.
Inefficiently means that files are created on first access and not
created in advance (fio parameterr create_on_open=1) and fallocate is
not used (fallocate=none). With multiple IO issuers this creates a mix
of slab and page cache allocations over time. The total size of the
files is 150% physical memory so that the slabs and page cache pages get
mixed

c) Warm up a number of fio read-only threads accessing the same files
created in step 2. This part runs for the same length of time it took to
create the files. It'll fault back in old data and further interleave
slab and page cache allocations. As it's now low on memory due to step
2, fragmentation occurs as pageblocks get stolen. While step 3 is still
running, start a process that tries to allocate 75% of memory as huge
pages with a number of threads. The number of threads is based on a
(NR_CPUS_SOCKET - NR_FIO_THREADS)/4 to avoid THP threads contending with
fio, any other threads or forcing cross-NUMA scheduling. Note that the
test has not been used on a machine with less than 8 cores. The
benchmark records whether huge pages were allocated and what the fault
latency was in microseconds

d) Measure the number of events potentially causing external fragmentation,
the fault latency and the huge page allocation success rate.
------- end of extract

These days we can probably do a bit more damage. There has been concerns
that LBS support (block size > ps) could hinder fragmentation, one of
the reasons is that any file created despite it's size will require at
least the block size, and if using 64k block size that means 64k
allocation for each new file on that 64k block size filesystem, so
clearly you may run out of lower order allocations pretty quickly. You
can also create different larg eblock filesystems too, one for 64k
another for 32k. Although LBS is new and we're still ironing out the
kinks if you wanna give it a go we've rebased the patches onto Linus'
tree [1], and if you wanted to ramp up fast you could use kdevops [2] which
let's you pick that branch and also a series of NVMe drives (by enabling
CONFIG_LIBVIRT_EXTRA_STORAGE_DRIVE_NVME) for large IO experimentation (by
enabling CONFIG_VAGRANT_ENABLE_LARGEIO). Creating different filesystem
with large block size (64k, 32k, 16k) on a 4k sector size drive
(mkfs.xfs -f -b size=64k -s size=4k) should let you easily do tons of
crazy pathalogical things.

Are there other known recipes test help test this stuff?
How do we measure success in your patches for fragmentation exactly?

[0] https://lwn.net/Articles/770235/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus-nobdev
[2] https://github.com/linux-kdevops/kdevops

  Luis
