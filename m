Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091317CC82C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjJQPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbjJQPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:55:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EEF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VrFoNcC3S43mjlhiW+V1SrfZF7QU7fgttASsi6ItKq4=; b=hjRhzilXs9do3FEcDzvCW+Imvp
        Kj8KQc8jeg60DnBVQtHAcMXdFlsIxZytVDaZQup2T2gNqsyHXgJC4I6+st48eu0Lz97hk/HJ15kZy
        Z5gl0f1zMdBTsVZGi8kXKfsVLNMq/+qZ3I6IBrF0biOmtfJ73gB7B6mf0cRx3+VUlpRA6vkxGOsvP
        PzPm/9L5VXiH3TGQ5+fN7fRtirYvRdiwiK3XzhRzmnvmU/+W+mo6VD9zuRwFDSXMjUUp+HAvQs4vl
        J68RL5N1pfk/odu0M4vv+KRz70MCWXuXk0LgCh8Yl+4gWVuswPlusELy5riGd3NOPULlVkLmBKWOx
        mvtPKSSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsmP0-00DCyk-L8; Tue, 17 Oct 2023 15:54:38 +0000
Date:   Tue, 17 Oct 2023 16:54:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH 1/5] slub: Introduce on_partial()
Message-ID: <ZS6uPqJMWgQfoD+j@casper.infradead.org>
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
 <20231017154439.3036608-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017154439.3036608-2-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:44:35PM +0000, chengming.zhou@linux.dev wrote:
> We change slab->__unused to slab->flags to use it as SLUB_FLAGS, which
> now only include SF_NODE_PARTIAL flag. It indicates whether or not the
> slab is on node partial list.

This is an unnecessarily complex solution.  As with the pfmemalloc bit,
we can reuse the folio flags for a few flags.  I would recommend the
PG_workingset bit for this purpose.

