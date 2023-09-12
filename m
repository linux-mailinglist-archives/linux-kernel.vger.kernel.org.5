Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2179D127
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjILMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjILMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:34:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9F9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TCd/VnMsUN2Xfg7sAjE+O/bMQ8NXxyvyk4g9OIV6gs=; b=jN91iTAqHkXMEwG5tjKOoJZgTs
        h7vfBm5tgEKymnY709XBHN6mXRzvLY/RlK/iuwQAGWcRCencHAXvRSky1n6i1Uv50iT5FLCvg0Fh+
        uXjVCE/AfhgtLUGLP3l0T093oMiiknWbssPvbdav0lBxkpRDzjTrfkNAkJUiVQxdScB0qcyFmbKWb
        FsFaOhd/SNYgy6D8xM4TJ9wLrhfw8ef0uLRzXQzBiO8XuQAsQa/nHzgvYC69c3o5S3c8+M/tFrltU
        kqD7tmmP9zddhY5e5QeeiMaKEr7AWnFJyzVuSAJ0xAgpMLFM3NRioZznpcsyjEQoE5uZU8eNk5QBn
        HJFfpCTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg2aa-007aMi-Jz; Tue, 12 Sep 2023 12:33:56 +0000
Date:   Tue, 12 Sep 2023 13:33:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQBatDtDrahkk+qO@casper.infradead.org>
References: <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:26:06AM +0200, Peter Zijlstra wrote:
> > How expensive would be always having PREEMPT_COUNT=y?
> 
> Effectively I think that is true today. At the very least Debian and
> SuSE (I can't find a RHEL .config in a hurry but I would think they too)
> ship with PREEMPT_DYNAMIC=y.

$ grep PREEMPT uek-rpm/ol9/config-x86_64
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

$ grep PREEMPT uek-rpm/ol9/config-aarch64
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

