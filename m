Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85B97FEEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjK3MXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3MXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:23:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C6301A8;
        Thu, 30 Nov 2023 04:23:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A91081042;
        Thu, 30 Nov 2023 04:24:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DB13F5A1;
        Thu, 30 Nov 2023 04:23:20 -0800 (PST)
Date:   Thu, 30 Nov 2023 12:23:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Ashley, William" <wash@amazon.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        will@kernel.org
Subject: Re: armv8pmu: Pending overflow interrupt is discarded when perf
 event is disabled
Message-ID: <ZWh-sbrHJu2b-BU6@FVFF77S0Q05N>
References: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
 <EBAF38AB-2BE5-425F-8A52-DDCB0B390309@amazon.com>
 <ZWdoNWps4izj5WJy@FVFF77S0Q05N.cambridge.arm.com>
 <ZWh2pnR_Z5-CKuZb@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWh2pnR_Z5-CKuZb@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:48:54AM +0000, Mark Rutland wrote:
> On Wed, Nov 29, 2023 at 04:35:01PM +0000, Mark Rutland wrote:
> > Does RR set any of the perf_event_attr::exclude_* bits? If not, does RR
> > intentionally count events that occur within the kernel?
> 
> Looking at the test, I see it sets perf_event_attr::exclude_kernel to 1, but
> doesn't set perf_event_attr::exclude_host or perf_event_attr::exclude_hv. I
> think the poorly-defined exclude_* bits are part of the problem here.
> 
> Using your test as-is on my ThunderX2, I can reproduce the period being longer
> than expected by concurrently running the following in a shell:
> 
>   while true; do
>     for C in $(seq 0 63); do
>       taskset -c -p $C ${TEST_PID_HERE};
>     done; 
>   done > /dev/null
> 
> ... resulting in:
> 
> | [mark@gravadlaks:~]% ./counter-overflow                                     
> | Pid 20060 running with period 10000 tolerance 1000
> | Signal #1: last: 0, cur: 10292, max diff: 0
> | Signal #415330: delta of 19999 is outside 10000 +/- 1000
> | Signal #415330: last: 4153290187, cur: 4153310186, max diff: 10292
> | Signal #489879: delta of 19998 is outside 10000 +/- 1000
> | Signal #511842: delta of 20058 is outside 10000 +/- 1000
> | Signal #511842: last: 5118430130, cur: 5118450188, max diff: 19999
> 
> However, if I modify the test to also set perf_event_attr::exclude_host=1, I do
> not see any lost overflows after many minutes. On VHE hosts (like the
> ThunderX2), the host kernel gets counted when perf_event_attr::exclude_host=0,
> even if perf_event_attr::exclude_kernel=1 (which I agree is surprising), so I
> think what's happening is the counters are counting in the host kernel, which
> isn't what RR actually wants regardless.

> I'll continue to look at what we can do kernel-side, but I reckon it's worth
> having RR try the other exclude bits regardless, if that's possible? It would
> be interesting to know whether that helps you under a hypervisor.

Sorry, the above is wrong, and I do not recommend RR goes and changes its
exclude_* settings.

I had misread the logic in armv8pmu_set_event_filter(), but looking again
that's saner than I thought it was, and what was actually happening in my
testing is that exclude_host also filtered host EL0 (userspace), and so the
test received *no* overflow signals.

I'll get back to looking at how we can better capture the overflow when
removing an event.

Mark.
