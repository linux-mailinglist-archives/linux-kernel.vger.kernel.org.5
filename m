Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB075AB92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGTKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjGTKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:00:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA8BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:00:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 528AB22B58;
        Thu, 20 Jul 2023 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689847207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r79tnlOtDHR7by6b49/n8KfLuYC93z1qpLSo+YCupbI=;
        b=LptwLFcWcnatSFJtxVy5x+3RHOlxDXXrM2dFPtbVWkJXaQlGXAKIBssq9IfwIvgEkWnc88
        VOOzzx2xTz/3VDMdsQoeiEruaeGohwfn0dna/khKC878vVedmQBCi63/LJyal6tkb2cjQH
        ACfTQywy+nD4o2s2x6chZ+xTYPN8uS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689847207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r79tnlOtDHR7by6b49/n8KfLuYC93z1qpLSo+YCupbI=;
        b=LP20h7HggkF6ko4HO0b91i+hdxc2azG90KqDBVdx3vLLNsdjEY2PPEZ5h32bZY55qbzSB7
        azmFIAHUsLj11LDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBEAC2C142;
        Thu, 20 Jul 2023 10:00:04 +0000 (UTC)
Date:   Thu, 20 Jul 2023 11:00:02 +0100
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
Subject: Re: [PATCH 2/2] sched/rt: sysctl_sched_rr_timeslice show default
 timeslice after reset
Message-ID: <20230720100002.yk7lef3fsvtohlhg@suse.de>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-3-chrubis@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:37:43PM +0200, Cyril Hrubis wrote:
> The sched_rr_timeslice can be reset to default by writing value that is
> <= 0. However after reading from this file we always got the last value
> written, which is not useful at all.
> 
> $ echo -1 > /proc/sys/kernel/sched_rr_timeslice_ms
> $ cat /proc/sys/kernel/sched_rr_timeslice_ms
> -1
> 
> Fix this by setting the variable that holds the sysctl file value to the
> jiffies_to_msecs(RR_TIMESLICE) in case that <= 0 value was written.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
