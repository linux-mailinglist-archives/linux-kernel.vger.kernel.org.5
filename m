Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC938087E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjLGMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbjLGMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:35:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B94A10C9;
        Thu,  7 Dec 2023 04:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zk/qNVDXNPkzhq+BDiIPBpzhkIjj00RW4XeHZN0fz8s=; b=LzxLFDf1Ey6ie1bZazQ5sel0KV
        bgSBvaaz1ZqfoFMLihKPgNbhOsndwdBKVK0VdI7qD6BwzXPQ0b4s1GF6jLRCKwSnG8bTX68Q7nf0N
        Q7blMk18QpO0l3J5NH1QweC19J/dL6wHju4WJ9349VJybv+XZF00MDRdtwDu/EzOPNZYhFTa59Ckb
        lzyrfvECe46mwwZQuFwqv86BrInyJ+6kwzMRhOOeie3tMv6/dwdMcwoniZJ1Q/o6x4rD53ua0ADL0
        dFBNy3Rti+i4YVcZNliXIMSt/q6oUcVjD20aXa3/gXPd6LtIwazv520naVxE7HfTHT4H8bt46Cory
        JVcfAU/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBDbW-003t2L-LG; Thu, 07 Dec 2023 12:35:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B38DE300338; Thu,  7 Dec 2023 13:35:45 +0100 (CET)
Date:   Thu, 7 Dec 2023 13:35:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        mingo@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Move state information judgment outside
 task_call_func
Message-ID: <20231207123545.GB36716@noisy.programming.kicks-ass.net>
References: <20231207111634.667057-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207111634.667057-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 07:16:34PM +0800, Xiaolei Wang wrote:
> It is dangerous to output warnings in task_call_func,
> which may lead to the risk of deadlock. task_call_func
> uses p->pi_lock, and the serial port output may call
> try_to_wake_up to wake up the write buff, which also
> uses p->pi_lock.

No, we're not going to make the code ugly because printk is stupid. Fix
whatever that triggers the WARN and leave it at that.
