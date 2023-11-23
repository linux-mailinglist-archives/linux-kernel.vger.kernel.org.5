Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364B7F57D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjKWFmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWFmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:42:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD98191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700718128; x=1732254128;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yFR3Tnxh8U1gSjLEybSTdB4n9wBqQ5KYMQumHDD8XgY=;
  b=kCzw9zqfqmHiEvWyUejkERrr73cwRAEvRFzrCpfPudSYdTCYFPKXeRTq
   bXZkpJh5k81G5RBLw4BTVSaZQSKJnkZLHJpmBqRkR8JPQDwil3UnEHrXv
   Diq8hYqMZkDzIpWZRKJmFyKhQaTv95AQQoT/YXbqRJ5meaTAH33TxXVM/
   p1eP68wuxbtXhcvl3UxJg1oIJG8r1bs+TSgzcTPZm4EC++ADbsQwC4gpP
   AHh5OR1GTFZw/5B01/uwPF5F9oITbhrQHhEWtlfSoB+a5dCQsTT+gUzuz
   /b1vSqAgnHf9xfQsinw7VobxiH+xYecRBNF/DLTeYa7UpjbhHR97V9t4k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382602379"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="382602379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="716953769"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="716953769"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:42:03 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [mm, pcp]  6ccdcb6d3a:
  stress-ng.judy.ops_per_sec -4.7% regression
In-Reply-To: <202311231029.3aa790-oliver.sang@intel.com> (kernel test robot's
        message of "Thu, 23 Nov 2023 13:03:34 +0800")
References: <202311231029.3aa790-oliver.sang@intel.com>
Date:   Thu, 23 Nov 2023 13:40:02 +0800
Message-ID: <87r0kh81u5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for test!

kernel test robot <oliver.sang@intel.com> writes:

> Hello,
>
> kernel test robot noticed a -4.7% regression of stress-ng.judy.ops_per_sec on:
>
>
> commit: 6ccdcb6d3a741c4e005ca6ffd4a62ddf8b5bead3 ("mm, pcp: reduce detecting time of consecutive high order page freeing")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> testcase: stress-ng
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
>
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: cpu-cache
> 	test: judy
> 	disk: 1SSD
> 	cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+-------------------------------------------------------------------------------------------------+
> | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.10MB.MB/sec 23.7% improvement                           |
> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
> | test parameters  | cpufreq_governor=performance                                                                    |
> |                  | mode=development                                                                                |
> |                  | nr_threads=100%                                                                                 |
> |                  | test=TCP                                                                                        |
> |                  | test_memory_size=50%                                                                            |
> +------------------+-------------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.file-ioctl.ops_per_sec -6.6% regression                                    |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
> | test parameters  | class=filesystem                                                                                |
> |                  | cpufreq_governor=performance                                                                    |
> |                  | disk=1SSD                                                                                       |
> |                  | fs=btrfs                                                                                        |
> |                  | nr_threads=10%                                                                                  |
> |                  | test=file-ioctl                                                                                 |
> |                  | testtime=60s                                                                                    |
> +------------------+-------------------------------------------------------------------------------------------------+

It's expected that this commit will benefit some workload (mainly
network, inter-process communication related) and hurt some workload.
But the  whole series should have no much regression.  Can you try the
whole series for the regression test cases?  The series start from
commit ca71fe1ad922 ("mm, pcp: avoid to drain PCP when process exit") to
commit 6ccdcb6d3a74 ("mm, pcp: reduce detecting time of consecutive high
order page freeing").

--
Best Regards,
Huang, Ying

