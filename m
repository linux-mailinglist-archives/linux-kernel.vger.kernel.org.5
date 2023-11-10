Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6957E84BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbjKJUrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjKJUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:46:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695E8A67
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ychU8/163qVFg3NRvLxy0W+AaKY9ruaWTI4UwS3bek=; b=QVVgrtUXxHkzv4Gs59wWtTbbds
        FEq1oSfCGTIpwiW8aCCyQfPKEavnv8eq8AxMGHrMc1D/SZtbYkQp9YjH68FscWdVduPugxg0FA+AJ
        ZkHWwShAtWhHXG2mJKHtqYrhiJoVU6XlF8iUHkEyjBtHwB3afbsu/Xzh+hjBAa9KWnmvz818+595w
        m0y1VRXAejQfm9zwSlOiSVVyoKazxeicWbKKRTAHmcMoMqYDsCkGzABSlUU+Za7yaxgR1moTkBkZR
        ZGlf6SWM05CtAc3bL/Rme6aRNor7G/iMWhFwD5OAInapRT7jPzOn5oT43QrCZtIO+4CaBM0i06Lm6
        PhhiRV8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1W2Y-00Et2C-6x; Fri, 10 Nov 2023 18:15:34 +0000
Date:   Fri, 10 Nov 2023 18:15:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2 2/7] fs/proc/page: use a folio in stable_page_flags()
Message-ID: <ZU5zRk+yi74pmAsq@casper.infradead.org>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:19AM +0800, Kefeng Wang wrote:
> Replace nine compound_head() calls with one page_folio().

But that's not all it does.  Honestly, when you write these kind of
things, I wonder if you understand what you're doing.

After this patch, if we report on a tail page, we set (some of) the
flags according to how its head page is set.  Before, we would have not
reported on it at all.

This was THE ENTIRE POINT of Greg's patch.  And why his patch made sense
and yours is nonsense.  Andrew, please drop this patch series.
