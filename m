Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7D7D2CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJWIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJWImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:42:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23DD6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:42:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9F451FD79;
        Mon, 23 Oct 2023 08:42:18 +0000 (UTC)
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 896C02CF3D;
        Mon, 23 Oct 2023 08:42:15 +0000 (UTC)
Date:   Mon, 23 Oct 2023 09:42:13 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tim.c.chen@linux.intel.com,
        yu.c.chen@intel.com, gautham.shenoy@amd.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com
Subject: Re: [PATCH] sched/fair: Remove SIS_PROP
Message-ID: <20231023084213.i7isjqpysmfjp5hm@suse.de>
References: <20231019033323.54147-1-yangyicong@huawei.com>
 <20231020134337.GD33965@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231020134337.GD33965@noisy.programming.kicks-ass.net>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of mgorman@suse.de) smtp.mailfrom=mgorman@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.41 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[24];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.90)[86.05%];
         FREEMAIL_CC(0.00)[huawei.com,redhat.com,linaro.org,arm.com,linux.intel.com,intel.com,amd.com,vger.kernel.org,lists.infradead.org,goodmis.org,google.com,hisilicon.com,linux.vnet.ibm.com,gmail.com,bytedance.com]
X-Spam-Score: -0.41
X-Rspamd-Queue-Id: E9F451FD79
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:43:37PM +0200, Peter Zijlstra wrote:
> 
> 
> Since this had me looking at all that code, I did the below.
> 
> Holler if there's objections etc..
> 
> ---
> Subject: sched/fair: Remove SIS_PROP
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Oct 20 12:35:33 CEST 2023
> 
> SIS_UTIL seems to work well, lets remove the old thing.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
