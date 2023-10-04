Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC27B84DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbjJDQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjJDQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8AF1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD17C433CA;
        Wed,  4 Oct 2023 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696436348;
        bh=5YCSUKis0P5pMUCSTy8MQPFGAhbMIzReSfUh9/11U3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mlU6hD5lL7ftnBxbxSbvDTrDTX7oWQsdqm4XXjIXKuLcfZ7O4e8TxUONMIg3T2pMg
         TDgwfWWHKHMMVuSOp2uvxJ2ypKkRs+anqw2pwCyd8I3oHZDqgT6d9nObBfjQprIStN
         L0Xhxj1gYSjldhBX2CAKV+lfF7MThHLQgJXLS2QE=
Date:   Wed, 4 Oct 2023 09:18:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-Id: <20231004091853.9be5aa562f65e0305e06b14c@linux-foundation.org>
In-Reply-To: <20230915083417.3190512-1-liushixin2@huawei.com>
References: <20230915083417.3190512-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 16:34:17 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> When spaces of swap devices are exhausted, only file pages can be
> reclaimed.  But there are still some swapcache pages in anon lru list.
> This can lead to a premature out-of-memory.
> 
> The problem is found with such step:
> 
>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>  memory limit, then runs an program to allocates about 15MB memory.
> 
> The problem occurs occasionally, which may need about 100 times [1].
> 
> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true and set swapcache_only to 1.
> When scan anon lru list in swapcache_only mode, non-swapcache pages will
> be skipped to isolate in order to accelerate reclaim efficiency.
> 
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> is skipped and do not count, the scan of pages in isolate_lru_folios() can
> eventually lead to hung task, just as Sachin reported [2].
> 
> By the way, since there are enough times of memory reclaim before OOM, it
> is not need to isolate too much swapcache pages in one times.
> 

mhocko earlier suspected this might impact global reclaim.  Have you
looked into that further?
