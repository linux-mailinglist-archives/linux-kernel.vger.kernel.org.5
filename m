Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8779920C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjIHWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjIHWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:08:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B31FCA;
        Fri,  8 Sep 2023 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=feIhy29eviQcz3w0j03WPUHi04Iv5MnRQxdFAPqyNns=; b=iGdC1B3qg4fADH5R3wqKQoYmDG
        ieN/d/cOMcuLZxa8xFAqYA43F7gzyHMFHAr/TtBRQy1zqrRV7y+tOxipUaS1Ma6Yb5A8HAIlrXfmZ
        yePoLRILXBzhIdDE3aWtRp4ns02dIS020WLLwEJ7aiohM6PyZ/krE/N1GOOU8hQDA4NW23kc+bXjd
        xw913cMBdeCNxf9E6ARB4+m94PAdRNrlcAskL7zas1Eqk6h5HK6faYQcSEMqYkQs0H427ECZMyY1n
        W7DHkhGlV3YuT9Lngbbv3uV9IiD8WDDNjrQPYJTGwy7saFAKw97D2fRHtH39kY0SebqOXHTq5Fsqc
        HIIkmNdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qejdz-002mtY-0x;
        Fri, 08 Sep 2023 22:08:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 621F73005FA; Sat,  9 Sep 2023 00:08:04 +0200 (CEST)
Date:   Sat, 9 Sep 2023 00:08:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Message-ID: <20230908220804.GA29218@noisy.programming.kicks-ass.net>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
 <20230904212324.GA2568@noisy.programming.kicks-ass.net>
 <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
 <20230907094651.GB16872@noisy.programming.kicks-ass.net>
 <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:08:07PM -0700, Elliot Berman wrote:

> > Perhaps we should start off by doing the below, instead of making it
> > more complicated instead. I suppose you're right about the overhead, but
> > run a hackbench just to make sure or something.
> > 
> 
> I ran perf bench sched message -g 40 -l 40 with the v3 patch [1]. After 60
> iterations each, I don't see a significant difference on my arm64 platform:
> both samples ~normal and ~eq variance w/t-test p-value: 0.79.
> 
> We also ran typical high level benchmarks for our SoCs (antutu,
> geekbench, et. al) and didn't see any regressions there.

So if you would've made this 2 patches, the first removing the ifdef,
then the changelog for that patch would be a good place to mention it
doesn't measurably regress things.

As a bonus, it then makes your other changes smaller too ;-)
