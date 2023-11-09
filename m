Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07957E6C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjKIOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjKIO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:29:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797B30DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UXn8QwRkK9Z79iLuBWzIkjy/+klmjPE5J0IBPDe+bz8=; b=RI7Fl2LY4Ip3Vu2GA42upkhuMc
        526bSmsudZos2vCzHP8BfqJd5Bv4yyyir2EHdW+HzSampM/oL+nDpbVbjPc8mDAJ+O7DBpXf75U8D
        MTx5YAPgTduilzEgjiN7es+fj/l/7jqCLY5FQj1Exx/NEOTwJheOiXJlw6uK0nwAql0RJxK/3MOue
        6suKWSQV44FnK7ccfErmD5RngwqoY2RQaIqHtd4GRvuvNM9mOPhaclKZOjDVcECAkQsy+E07oz8wI
        78mmJHcIfHgY1YhXAm2tJsgjOjDiz/iHl32o2vhtvlugtrMRnhoo7tMMdWEJYta8S5JsEuBjdL7d+
        64Zp4trQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r162T-007k9k-AL; Thu, 09 Nov 2023 14:29:45 +0000
Date:   Thu, 9 Nov 2023 14:29:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        fengwei.yin@intel.com, vbabka@suse.cz, mgorman@suse.de,
        mingo@redhat.com, riel@redhat.com, ying.huang@intel.com,
        hannes@cmpxchg.org, Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Message-ID: <ZUzs2YfXY3zBKIx9@casper.infradead.org>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <20231109141141.GC8683@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109141141.GC8683@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:11:41PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
> > Is there any way to avoid such a major fault?
> 
> man madvise

but from the mlockall manpage:

       mlockall() locks all pages mapped into the address space of the calling
       process.  This includes the pages of the code, data, and stack segment,
       as well as shared libraries, user space kernel data, shared memory, and
       memory-mapped files.  All mapped pages are guaranteed to be resident in
       RAM  when  the  call  returns successfully; the pages are guaranteed to
       stay in RAM until later unlocked.

https://pubs.opengroup.org/onlinepubs/9699919799/functions/mlockall.html
isn't quite so explicit, but I do think that page cache should be locked
into memory.
