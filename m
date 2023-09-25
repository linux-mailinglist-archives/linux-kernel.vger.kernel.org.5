Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB557AE18E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjIYWLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:11:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB79F107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m41YmgAlvlgZpwnL0qQM2KGCyZY6OCsIZ8O/irEMgBQ=; b=Y2Qe941jWJAfvz+rqON69Ejd3S
        nLm4c1FZo4i8LCQsjNv2joK9WKgWwsq5Gg3U8NWj3v1LEfIuIMXx2NVn93U6x5AtV50vCV7g9is20
        5KjEQMpQ30BlC8eq1aCEivbzfAqNkI6YI/CEPvINIWcPylWmmUaqBo6pK0ACjVDxHGmx2o0ayiFl8
        h49RqPmSICN+0uaOmOWiBzHiYO6OdrLZbc7RdcIPOd/oovJexnkm/zzpQcZN+Ou1Vq3hyJ69gFjS/
        1o50v9U7S9XRu8t8lQVjctB4xmlfWsu3u7NSgt/WYxdhnyYUhSfrGtv4zoE2YQAvFfKhQvw5HZ+R2
        SVEtLn8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qktmy-003xxD-Dd; Mon, 25 Sep 2023 22:10:48 +0000
Date:   Mon, 25 Sep 2023 23:10:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/12] kernfs: drop shared NUMA mempolicy hooks
Message-ID: <ZRIFaPsEHTIxEY/d@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <dffc667-5dc9-a980-dab8-8554eafbda7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffc667-5dc9-a980-dab8-8554eafbda7@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:22:27AM -0700, Hugh Dickins wrote:
> It seems strange that kernfs should be an outlier with a set_policy and
> get_policy in its kernfs_vm_ops.  Ah, it dates back to v2.6.30's commit
> 095160aee954 ("sysfs: fix some bin_vm_ops errors"), when I had crashed
> on powerpc's pci_mmap_legacy_page_range() fallback to shmem_zero_setup().
> 
> Well, that was commendably thorough, to give sysfs-bin a set_policy and
> get_policy, just to avoid the way it was coded resulting in EINVAL from
> mmap when CONFIG_NUMA; but somehow feels a bit over-the-top to me now.
> 
> It's easier to say that nobody should expect to manage a shmem object's
> shared NUMA mempolicy via some kernfs backdoor to that object: delete
> that code (and there's no longer an EINVAL from mmap in the NUMA case).
> 
> This then leaves set_policy/get_policy as implemented only by shmem -
> though importantly also by SysV SHM, which has to interface with shmem
> which implements them, and with SHM_HUGETLB which does not.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
