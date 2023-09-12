Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54A79D59A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjILQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjILQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ADE10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/ufbF5AE1kJWZUkhHfxUWS38u59OErgU7vO9+D/zZc=; b=BkC0Kvx3yCVD5ZX3c+tL3s/w4j
        F0gMhWxTtbpUS8TtfyTsvUMqIpvBUekNvF10dTvQ6HT/Gwap/UWRoDqN0NlX9IQiZVrS13KuvCvQa
        CLRo1Gf1M5SYYEKkfYGgHtOfee0zp6nGabFsd8MeRk0KqqHZAqiWa93H8+PabHODYDFuhFTSvF3BI
        GVcr0FxKWQJjLx/yyofeMxP0aixTeqxcuT3m5wPjGmLJwDx7kUFm8nd4rewwTc+TY0lO9l4+T2lWB
        p2Z/TAiEwyIzUOt/eK3LqVgbgxUZD0vdFEGke8NWqFa2W++o0zHPkq0/zckdogDow2xMU0Kz06+wo
        V4ZMsk7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg5pv-008S9t-Vc; Tue, 12 Sep 2023 16:02:00 +0000
Date:   Tue, 12 Sep 2023 17:01:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <ZQCLdzmtVcjxZWXt@casper.infradead.org>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
 <ZQCAYpqu+5iD0rhh@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQCAYpqu+5iD0rhh@feng-clx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:14:42PM +0800, Feng Tang wrote:
> > Well that's the problem. Since I can't run the reproducer, there's
> > nothing I can do to troubleshoot the problem myself.
> 
> We dug more into the perf and other profiling data from 0Day server
> running this case, and it seems that the new simple_offset_add()
> called by shmem_mknod() brings extra cost related with slab,
> specifically the 'radix_tree_node', which cause the regression.
> 
> Here is some slabinfo diff for commit a2e459555c5f and its parent:
> 
> 	23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 
> 	---------------- --------------------------- 
>  
>      26363           +40.2%      36956        slabinfo.radix_tree_node.active_objs
>     941.00           +40.4%       1321        slabinfo.radix_tree_node.active_slabs
>      26363           +40.3%      37001        slabinfo.radix_tree_node.num_objs
>     941.00           +40.4%       1321        slabinfo.radix_tree_node.num_slabs

I can't find the benchmark source, but my suspicion is that this
creates and deletes a lot of files in a directory.  The 'stable
directory offsets' series uses xa_alloc_cyclic(), so we'll end up
with a very sparse radix tree.  ie it'll look something like this:

0 - "."
1 - ".."
6 - "d"
27 - "y"
4000 - "fzz"
65537 - "czzz"
643289767 - "bzzzzzz"

(i didn't work out the names precisely here, but this is approximately
what you'd get if you create files a-z, aa-zz, aaa-zzz, etc and delete
almost all of them)

The radix tree does not handle this well.  It'll allocate one node for:

entries 0-63 (covers the first 4 entries)
entries 0-4095
entries 3968-4031 (the first 5)
entries 0-262143
entries 65536-69631
entries 65536-65599 (the first 6)
entries 0-16777215
entries 0-1073741823
entries 637534208-654311423
entries 643039232-643301375
entries 643289088-643293183
entries 643289728-643289791 (all 7)

That ends up being 12 nodes (you get 7 nodes per page) to store 7
pointers.  Admittedly to get here, you have to do 643289765 creations
and nearly as many deletions, so are we going to see it in a
non-benchmark situation?

The maple tree is more resilient against this kind of shenanigan, but
we're not there in terms of supporting the kind of allocation you
want.  For this kind of allocation pattern, you'd get all 7 pointers
in a single 256-byte node.

