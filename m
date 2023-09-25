Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B140E7AE1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjIYWqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIYWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:46:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F111C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695681993; x=1727217993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YP7EHKPr2e+Pz1hp7bVbAs2UlnEMcHx46HJgSSpOj1Y=;
  b=b+4bfXErjjyW0Ahi0ZAATvF/MnAXFOrUmpSzdAAann/6KF3uMIP0Jqac
   CHuhWI+RYNc0Ufv58BrEhhTA+tmIZgOo0hYWAigEMw1TCei4FNX6lyV6h
   ZA9luFrGChaNiPYHHr6qCzdxO/0VquMZuY8VFKfyJmkXxFEdQQO1PiksL
   2FQHPm8absuwy9U/qX7u8Szs/GfCXAwwqGsh0mdq1QKfKpivQsv4zu+an
   uOPynuzXoTo9i/8SuygOPM2qk2CMnhex9OqpipVcf5GAe48CVPj4fDsz0
   kiU13S1txE8202JGGrJJmny+vY1FClqiqqNSJEVVzde7769rM5jRcV+TF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381333722"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="381333722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725211019"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="725211019"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:46:32 -0700
Date:   Mon, 25 Sep 2023 15:46:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 01/12] hugetlbfs: drop shared NUMA mempolicy pretence
Message-ID: <ZRINx/53KKUibbGb@tassilo>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <47a562a-6998-4dc6-5df-3834d2f2f411@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a562a-6998-4dc6-5df-3834d2f2f411@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:21:10AM -0700, Hugh Dickins wrote:
> hugetlbfs_fallocate() goes through the motions of pasting a shared NUMA
> mempolicy onto its pseudo-vma, but how could there ever be a shared NUMA
> mempolicy for this file?  hugetlb_vm_ops has never offered a set_policy
> method, and hugetlbfs_parse_param() has never supported any mpol options
> for a mount-wide default policy.
> 
> It's just an illusion: clean it away so as not to confuse others, giving
> us more freedom to adjust shmem's set_policy/get_policy implementation.
> But hugetlbfs_inode_info is still required, just to accommodate seals.
> 
> Yes, shared NUMA mempolicy support could be added to hugetlbfs, with a
> set_policy method and/or mpol mount option (Andi's first posting did
> include an admitted-unsatisfactory hugetlb_set_policy()); but it seems
> that nobody has bothered to add that in the nineteen years since v2.6.7
> made it possible, and there is at least one company that has invested
> enough into hugetlbfs, that I guess they have learnt well enough how to
> manage its NUMA, without needing shared mempolicy.

TBH i'm not sure people in general rely on shared mempolicy. The
original use case for it was to modify the numa policy of non anonymous
shared memory files without modifying the program (e.g. Oracle
database's shared memory segments)

But I don't think that particular usage model ever got any real
traction: at leas I haven't seen any real usage of it outside my tests.

I suspect people either are fine with just process policy or modify the
program, in which case it's not a big burden to modify every user,
so process policy or vma based mbind policy works fine.

Maybe it would be an interesting experiment to disable it everywhere
with some flag and see if anybody complains.

On the other hand it might be Hyrum'ed by now.

-Andi

