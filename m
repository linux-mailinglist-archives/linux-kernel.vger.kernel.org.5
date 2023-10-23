Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375367D3C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjJWQWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjJWQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:22:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8783
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OAWjUgVOZUJBsRmzt0lQvrsTEHJrJSHEJguU/ywRNhk=; b=L5HCq7NNjOMdEusQ7GlzvOE8Xi
        H/lVrBbYxsVVBZuSXVt5DKHMAW/sj7ojqfB+OHF+TWsf/hQPbJMIdBwDkyk+LhG5KwOmoWGpeCjZ5
        ogRSsXnZUJkcAKy7tc4s2dKmB+/qHYBvadm0yTs7RCJKeN6wYNj/9zAetlDGscx+/R0T6s8Wa4iAu
        uUGsBrsrvXPEtffH4z11dgZhe5lZtsJlDhK4P0BKrS8oDHqXJOPgQdWRKa4dml6rzdOg84qyji2nq
        178rUeKR+uV9Pz6zXQKVOsiepDj+NKF6zEvXceGDqSINaPr3kKl7Rt5WA5KL2Kkqz3xL1tn9Mda3w
        q7+gaaaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1quxgr-00Enmq-PL; Mon, 23 Oct 2023 16:22:05 +0000
Date:   Mon, 23 Oct 2023 17:22:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v2 1/6] slub: Keep track of whether slub is on the
 per-node partial list
Message-ID: <ZTadrbMDcWPKMjde@casper.infradead.org>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <20231021144317.3400916-2-chengming.zhou@linux.dev>
 <ZTZn23OzQfAm6epp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTZn23OzQfAm6epp@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 01:32:27PM +0100, Matthew Wilcox wrote:
> _Assuming_ that it's safe to use the non-atomic flag setting, I'd
> rather see this done as ...
> 
> static inline void slab_set_node_partial(struct slab *slab)
> {
> 	__folio_set_workingset(slab_folio(slab));

Ugh, I meant to delete this line.  I meant to just write the next line.

> 	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> }
