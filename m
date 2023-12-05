Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C92805FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjLEUqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjLEUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:46:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C9129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:46:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D39C433C7;
        Tue,  5 Dec 2023 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701809171;
        bh=QRoUE19qRtHescz0H5jxE4IfSkWb5vJkxf2yeRy6dfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXszuCb6OBuuMGlVtrbb7H9IgZB/NfwSd67Af3xwiN0RBK8jeiR8Bg+F58HSIP9Bw
         ugyXPDaobPyndakmDYXScizcLiAKJACf9l8cHCwKxgn5n2um578reCuFjeSIKsAigX
         1aiQp2EELa6yvoDKmIDD8W0o7qUk+sOTwh/vjpFc=
Date:   Tue, 5 Dec 2023 12:46:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/4] mm/ksm: Add ksm advisor
Message-Id: <20231205124610.ca70c47e880daa81a0f21f07@linux-foundation.org>
In-Reply-To: <20231204234906.1237478-1-shr@devkernel.io>
References: <20231204234906.1237478-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Dec 2023 15:49:02 -0800 Stefan Roesch <shr@devkernel.io> wrote:

> What is the KSM advisor?
> =========================
> The ksm advisor automatically manages the pages_to_scan setting to
> achieve a target scan time. The target scan time defines how many seconds
> it should take to scan all the candidate KSM pages. In other words the
> pages_to_scan rate is changed by the advisor to achieve the target scan
> time.

Dumb question time.  Can this be done in userspace?  Presumably this
will require exposing some additional kernel state to userspace.

> Why do we need a KSM advisor?
> ==============================
> The number of candidate pages for KSM is dynamic. It can often be observed
> that during the startup of an application more candidate pages need to be
> processed. Without an advisor the pages_to_scan parameter needs to be
> sized for the maximum number of candidate pages. With the scan time
> advisor the pages_to_scan parameter based can be changed based on demand.
> 
> Algorithm
> ==========
> The algorithm calculates the change value based on the target scan time
> and the previous scan time. To avoid pertubations an exponentially
> weighted moving average is applied.
> 
> The algorithm has a max and min
> value to:
> - guarantee responsiveness to changes
> - to limit CPU resource consumption
> 
> Parameters to influence the KSM scan advisor
> =============================================
> The respective parameters are:
> - ksm_advisor_mode
>   0: None (default), 1: scan time advisor
> - ksm_advisor_target_scan_time
>   how many seconds a scan should of all candidate pages take
> - ksm_advisor_max_cpu
>   upper limit for the cpu usage in percent of the ksmd background thread
> 
> The initial value and the max value for the pages_to_scan parameter can
> be limited with:
> - ksm_advisor_min_pages
>   minimum value for pages_to_scan per batch
> - ksm_advisor_max_pages
>   maximum value for pages_to_scan per batch

Should these be called ksm_advisor_min_pages_to_scan?

> The default settings for the above two parameters should be suitable for
> most workloads.
> 
> The parameters are exposed as knobs in /sys/kernel/mm/ksm. By default the
> scan time advisor is disabled.

Disabling it will reduce the effectiveness of testing.  What are the
risks of defaulting to "on"?

> Currently there are two advisors:
> - none and
> - scan-time.
> 
> Resource savings
> =================
> Tests with various workloads have shown considerable CPU savings. Most
> of the workloads I have investigated have more candidate pages during
> startup. Once the workload is stable in terms of memory, the number of
> candidate pages is reduced. Without the advisor, the pages_to_scan needs
> to be sized for the maximum number of candidate pages. So having this
> advisor definitely helps in reducing CPU consumption.
> 
> For the instagram workload, the advisor achieves a 25% CPU reduction.

25% of what?  What is the overall affect on machine resource
consumption?

> Once the memory is stable, the pages_to_scan parameter gets reduced to
> about 40% of its max value.
> 
> The new advisor works especially well if the smart scan feature is also
> enabled.
> 
> How is defining a target scan time better?
> ===========================================
> For an administrator it is more logical to set a target scan time.. The
> administrator can determine how many pages are scanned on each scan.
> Therefore setting a target scan time makes more sense.
> 
> In addition the administrator might have a good idea about the memory
> sizing of its respective workloads.
> 
> Setting cpu limits is easier than setting The pages_to_scan parameter. The
> pages_to_scan parameter is per batch. For the administrator it is difficult
> to set the pages_to_scan parameter.
> 
> Tracing
> =======
> A new tracing event has been added for the scan time advisor. The new
> trace event is called ksm_advisor. It reports the scan time, the new
> pages_to_scan setting and the cpu usage of the ksmd background thread.
> 
> Other approaches
> =================
> 
> Approach 1: Adapt pages_to_scan after processing each batch. If KSM
>   merges pages, increase the scan rate, if less KSM pages, reduce the
>   the pages_to_scan rate. This doesn't work too well. While it increases
>   the pages_to_scan for a short period, but generally it ends up with a
>   too low pages_to_scan rate.
> 
> Approach 2: Adapt pages_to_scan after each scan. The problem with that
>   approach is that the calculated scan rate tends to be high. The more
>   aggressive KSM scans, the more pages it can de-duplicate.
> 
> There have been earlier attempts at an advisor:
>   propose auto-run mode of ksm and its tests
>   (https://marc.info/?l=linux-mm&m=166029880214485&w=2)

