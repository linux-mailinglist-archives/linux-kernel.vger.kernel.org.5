Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E037FFA50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbjK3Syq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3Syp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:54:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DB10DE;
        Thu, 30 Nov 2023 10:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s/rDmWF02NwdqFljTBq3ivE1VLtPxbvFoYCxoKr5tkk=; b=ukYJ7ZXLRLKnuiGqLgilzy+W6R
        J6os9aQXTRF0Vkv+edCTTWm5PJiCesLMbij3enDPOgowYgu3oPrBD6U+/BLR+yL7cQNSBjcie3CYp
        t1nohxPqBpGF56aJHV0k+1PIS4cPo3zwgHt/a8yr0cw7ZuewHhRsktSubwqdvEn/stnQ0caSzyz8J
        q1YGmTctbZKEQckicOZJcgdcQRei25Nw2pP9HIzhvC9HKR5WQ7tF1r/j00lbYg1EahALVx7MI4gDv
        BcHtZ4b4flc+pDgCn66Ct+AvMbBIBxuKg1453al9BhaG8b68IfQJe66H7c+WrwbL+dl8rNBEOe62N
        /gmlHOVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8mBJ-00Ekuv-Db; Thu, 30 Nov 2023 18:54:37 +0000
Date:   Thu, 30 Nov 2023 18:54:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWjabcWQm/GUoGTf@casper.infradead.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130184424.7sbez2ukaylerhy6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> > * Swapout should be limited to manage SSD write endurance. In near-OOM
> 
> Is this about swapout to SSD only?

If you're using spinning rust with its limit of, what, 200 seeks per
second, I'd suggest that swapout should also be limited but for
different reasons.  We can set you up with a laptop with insufficient
RAM and a 5400rpm drive if you'd like to be convinced ...

