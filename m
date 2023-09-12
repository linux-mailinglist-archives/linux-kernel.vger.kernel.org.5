Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2888079D2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjILNwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:52:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B70410D9;
        Tue, 12 Sep 2023 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/lGmwZAGVMbAJBhdY4pCtnB8dKwZ8xioPPey8tPDV/E=; b=Y8ILCw8+nxVE2RTsviiozG8ZeP
        X3EOwOyJ+cezyoO9pn8QnmZ/QDgXpW1S1vMcNYXRuBNHyiTg4XiNcK06lSg4OGl8FFvHCYtZcNA3Z
        G4t2VXuMxl0OwhuCyli6PHmmOzOKjF2BtsTrq87SxetEaH8rccl8UcM3x+TAgOSHR8QJBOWoNg5T1
        rld3iacnCZyiCpu7j1D6biV4LbWCRUpuTMjZPKubwzGTLPChg19ZFy6gSqm2AJfMr5ynfaBf+S7/G
        Q/EKMIb8PJByExiSM203u9+glibHuLM9d6JvpTH9uLlyehrHmlPCwkcnsqgwuR0MAJMJ7zpLR93WC
        sekkITFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg3oK-0069ce-0O;
        Tue, 12 Sep 2023 13:52:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EE7C300348; Tue, 12 Sep 2023 15:52:13 +0200 (CEST)
Date:   Tue, 12 Sep 2023 15:52:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230912135213.GA22127@noisy.programming.kicks-ass.net>
References: <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
 <ZQBZXSCyG+u2+i8E@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQBZXSCyG+u2+i8E@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:28:13PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 12, 2023 at 11:03:42AM +0200, Peter Zijlstra wrote:
> > If not, then sure we can do this; it's not like I managed to get rid of
> > muteX_is_locked() -- and I actually tried at some point :/
> > 
> > And just now I grepped for it, and look what I find:
> > 
> > drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
> > drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)
> > 
> > And there's more :-(
> 
> Are these actually abuse?  I looked at these two, and they both seem to
> be asking "Does somebody else currently have this mutex?" rather than
> "Do I have this mutex?".

It's effectively a random number generator in that capacity. Someone
might have it or might have had it when you looked and no longer have
it, or might have it now but not when you asked.

