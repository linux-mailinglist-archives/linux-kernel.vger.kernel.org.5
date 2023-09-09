Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7137779957E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjIIBRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjIIBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:17:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755B1FF0;
        Fri,  8 Sep 2023 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ZsYp9xBq3K/Mmd51vPcTXkWWi9Dav9b/gzTkFLb0g4=; b=HIx2xQuW1+qoR+282kB7any4BQ
        HHCetLGZTA33zrVKRzeqRMdqwLeSLkCEBXhgtIx0/ZOME7crgTH40F40uSimGk8IZDPVYKsvXe5nu
        TthRRLUSK1HpmQ1Dri8oiSDb4NHyLB9bsrrkK+aVu6jO5V9QOkJOKNv+PPOOuvXhe+tyKShoOMn7u
        81RbY8VvkDmjnOl8vvMRzBrjvpITP6luVPnHLZcG1YOz/EHvsNJGEZn7SFoeSeU/9n2Bgj9iBjzxy
        9YDhH63ZOdTrMGpdqbECkXQFFiz4bjwdlk/qKkPTliz5xed+R+qm80buzZ9AkiU5zmTYvkru1VTJs
        5DsGbXJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qemZs-003Qnj-5p; Sat, 09 Sep 2023 01:16:00 +0000
Date:   Sat, 9 Sep 2023 02:16:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Rafael Aquini <raquini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: fix slab_caches list corruption after
 kmem_cache_destroy()
Message-ID: <ZPvHUK95S6Dgl86v@casper.infradead.org>
References: <20230908230649.802560-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908230649.802560-1-aquini@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 07:06:49PM -0400, Rafael Aquini wrote:
> This patch fixes this issue by properly checking shutdown_cache()'s
> return value before taking the kmem_cache_release() branch.

Is this the right way to fix this problem?  If the module destroys the
slab cache, it's not going to be possible to free any of the objects
still allocated from the cache.  I feel that we should treat this as
implicitly freeing all the objects that were allocated from the cache
rather than saying the cache is still busy.

