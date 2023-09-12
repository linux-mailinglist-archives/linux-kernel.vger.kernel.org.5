Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0536D79D111
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjILM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjILM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:28:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63F199B;
        Tue, 12 Sep 2023 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z8ryHLZvoZYaYVMPT2DZpm/JtTShBG1m5lfT41YyXTQ=; b=erCwDK5dpDueftgDg08gml1I+V
        arhJrULil/JMQj5sB6V10l8iCXZXlF9ROkiDC1IHUDqRQb9g6npPOA3odnUB63pKKOx8f/Nqg8l5B
        D8Q1uV4eaZZ6/ezbZli7/EAoFBJD3Ym4nEG6GeajOmsXjPq8Qy8voPKW8Xn5zGeX1iOH6JV2crvEW
        B5k5hZIYgGfbAn+N/U1rqxv3FZDaf5SmnRNet1nSakFLg6pO4OIS8xa+n/w3kd9TPYfxcfUkMVOCm
        E518FlHYGY2p91T32c1IK/eu51UlMjjKTA0j8QZZGCu8gr+eWNJR6VCSFtby7tyViqiF5nFGw8y0z
        qGweLZBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg2V3-007XrA-8B; Tue, 12 Sep 2023 12:28:13 +0000
Date:   Tue, 12 Sep 2023 13:28:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZQBZXSCyG+u2+i8E@casper.infradead.org>
References: <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912090342.GC35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:03:42AM +0200, Peter Zijlstra wrote:
> If not, then sure we can do this; it's not like I managed to get rid of
> muteX_is_locked() -- and I actually tried at some point :/
> 
> And just now I grepped for it, and look what I find:
> 
> drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
> drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)
> 
> And there's more :-(

Are these actually abuse?  I looked at these two, and they both seem to
be asking "Does somebody else currently have this mutex?" rather than
"Do I have this mutex?".
