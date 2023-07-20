Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF575AB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGTJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjGTJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:58:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A80EE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:58:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A5D022B4E;
        Thu, 20 Jul 2023 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689847082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHzbbuCMHfXitdRlhu6CbOu8h6g1SgL0u67GCVg312E=;
        b=EH0tPb84wa+gVtdOZdXgNL5NQIPNb66mpUXoBRWwL6GOYaDmeJ73oNfl7Vnc1UGIKuDYCW
        87auuZNyKIItvtaFxRyTxVFb9V2A0cDPsjNUH+dPBwogyQ/fyByenD1Gkhd0VeKEdK1SLq
        b2m93e0Sc4zkgddM/cqJkfjnAZLNqGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689847082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHzbbuCMHfXitdRlhu6CbOu8h6g1SgL0u67GCVg312E=;
        b=jS4/SYMM25FVLJF4c4U12FGyRKwC3mQUVQ0Cl7iLBI28ToDyEnpBbAJQAtXLSUXA72pVfp
        CfMX2sjLjxRp2LDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AFCF2C143;
        Thu, 20 Jul 2023 09:58:00 +0000 (UTC)
Date:   Thu, 20 Jul 2023 10:57:57 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 1/2] sched/rt: Fix sysctl_sched_rr_timeslice intial value
Message-ID: <20230720095757.syyntxzoqgiucxng@suse.de>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:37:42PM +0200, Cyril Hrubis wrote:
> Thre is 10% rounding error in the intial value of the
> sysctl_sched_rr_timeslice with  CONFIG_HZ_300=y.
> 
> This was found with LTP test sched_rr_get_interval01:
> 
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> 
> What this test does is to compare the return value from the
> sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
> fails if they do not match.
> 
> The prolem it found is the intial sysctl file value which was computed as:
> 
> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> 
> which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
> introduces 10% rounding error for CONFIG_HZ_300:
> 
> (MSEC_PER_SEC / HZ) * (100 * HZ / 1000)
> 
> (1000 / 300) * (100 * 300 / 1000)
> 
> 3 * 30 = 90
> 
> This can be easily fixed by reversing the order of the multiplication
> and division. After this fix we get:
> 
> (MSEC_PER_SEC * (100 * HZ / 1000)) / HZ
> 
> (1000 * (100 * 300 / 1000)) / 300
> 
> (1000 * 30) / 300 = 100
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
