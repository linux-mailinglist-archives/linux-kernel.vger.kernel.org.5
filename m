Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D528122AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjLMXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:13:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC59DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:13:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A87C433C8;
        Wed, 13 Dec 2023 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702509222;
        bh=Md24tJ3+Wb3bNcBuVcozhmG9U30jugNyNDfv6aSjv34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rhPMeHMMQOTm7QU7wJbze11+WOwek1FnlonvO6rQJqj8BuLk7e4EKqa/aOnd5YUjo
         J5BkV31id4OdPXqZcUxrGhqCcKrGdnAns7/so+JSp+61Ylc1YCX667pAyvnr5eKVsT
         TiF0xFpVFUGjQMAn+RuF4joWh1UgsMEoBbvr4shc=
Date:   Wed, 13 Dec 2023 15:13:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-Id: <20231213151341.9ae5fa2bdc266d794a7eed39@linux-foundation.org>
In-Reply-To: <ZWcPuYzWYAvOODsH@tiehlicka>
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
        <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWDPuR5Ssx07nBHb@tiehlicka>
        <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWRdG49vlGzSY_Uj@tiehlicka>
        <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZWW95JPQ1B0cVPY-@tiehlicka>
        <ZWZtdQKSSnLC8kZ6@google.com>
        <CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
        <ZWZ0fJP9wq65rXtM@google.com>
        <ZWcPuYzWYAvOODsH@tiehlicka>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


tl;dr, what's the viewpoint on this patch now?

I have a note here that we're hoping input from Johannes, Vlastimil and
Mel (please).


