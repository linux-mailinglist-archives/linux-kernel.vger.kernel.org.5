Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5D7E5AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:14:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578E819A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:14:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7C6C433C7;
        Wed,  8 Nov 2023 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699460061;
        bh=qYaMUn5duRraHp6jr8ZuuZE1fl2gs0KU/LKQTez8o9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Whrwu6GIg7SpMw2mJOf96NBOwMy7GL3oSYCWku834BMQQcIPlQ10b2+HTcu9rEVyJ
         defOtH86G8m6qmQ3/CBDHcfF23pf8xJ0+euljpncO6exp+kIJxzHvn3tV7j+fy/E4k
         460UFKjuVzm+Wz3jaa1LWlb9kfB6vzZ9URKq41tI=
Date:   Wed, 8 Nov 2023 08:14:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huan Yang <link@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-Id: <20231108081419.1c31f74de8e7fce24f85c967@linux-foundation.org>
In-Reply-To: <20231108065818.19932-1-link@vivo.com>
References: <20231108065818.19932-1-link@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 14:58:11 +0800 Huan Yang <link@vivo.com> wrote:

> For example, when an application is pushed to the background and frozen,
> it may not be opened for a long time, and we can safely reclaim the
> application's anonymous pages, but we do not want to touch the file pages.

This paragraph is key to the entire patchset and it would benefit from
some expanding upon.

If the application is dormant, why on earth would we want to evict its
text but keep its data around?
