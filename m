Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44777D3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjHOTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbjHOTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:52:35 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217D19A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:52:33 -0700 (PDT)
Date:   Tue, 15 Aug 2023 12:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692129151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiWwkuxZLXlsMAakbQTpqYVqMa7+2V8VgSeqKNwbqnY=;
        b=vVlL8aU/i8mbZu9EunVXTFOHbz1Iac2XLnCqGKmQUETNw3eGScVfMkct1OY9dsZ35mputG
        bQrBsX3UyZtcOEbe+PMx8oGtfdUiBtDD1HH1gtqsncvHwjvFyYYk+xq83u6m8zUB5dlsLu
        r1JRj2XHpnG1tFzKDyBvHiknMzvvqe4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.lu@bytedance.com
Subject: Re: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNvXbX2HIFcl9OqQ@P9FQF9L96D.corp.robot.car>
References: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
 <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
 <fdec0f4c-a65f-df16-b4ee-7cfd977c8d7f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdec0f4c-a65f-df16-b4ee-7cfd977c8d7f@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:00:36PM +0800, Abel Wu wrote:
> On 8/9/23 3:53 PM, Michal Hocko wrote:
> > On Tue 08-08-23 14:41:17, Roman Gushchin wrote:
> > > It would be also nice to come up with some practical examples of bpf programs.
> > > What are meaningful scenarios which can be covered with the proposed approach
> > > and are not covered now with oom_score_adj.
> > 
> > Agreed here as well. This RFC serves purpose of brainstorming on all of
> > this.
> > 
> > There is a fundamental question whether we need BPF for this task in the
> > first place. Are there any huge advantages to export the callback and
> > allow a kernel module to hook into it?
> 
> The ancient oom-killer largely depends on memory usage when choosing
> victims, which might not fit the need of modern scenarios. It's common
> nowadays that multiple workloads (tenants) with different 'priorities'
> run together, and the decisions made by the oom-killer doesn't always
> obey the service level agreements.
> 
> While the oom_score_adj only adjusts the usage-based decisions, so it
> can hardly be translated into 'priority' semantic. How can we properly
> configure it given that we don't know how much memory the workloads
> will use? It's really hard for a static strategy to deal with dynamic
> provision. IMHO the oom_score_adj is just another demon.
> 
> Reworking the oom-killer's internal algorithm or patching some random
> metrics may satisfy the immediate needs, but for the next 10 years? I
> doubt it. So I think we do need the flexibility to bypass the legacy
> usage-based algorithm, through bpf or pre-select interfaces.

I agree in general, but I wouldn't call the existing implementation a legacy
or obsolete. It's all about trade-offs. The goal of the existing implementation
is to guarantee the forward progress without killing any processes prematurely.
And it does it relatively well.

Userspace oom killers (e.g. oomd) on top of PSI were initially created to
solve the problem of memory thrashing: having a system which is barely making
anything useful, but not stuck enough for the OOM killer to kick in.
But also they were able to provide a much better flexibility. The downside -
they can't be as reliable as the in-kernel OOM killer.

Bpf or a pre-select interface can in theory glue them together: make sure that
a user has a flexibility to choose the OOM victim without compromising on the
reliability. Pre-select interface could be preferable if all the logic is
already implemented in userspace, but might be slightly less accurate if some
statistics (e.g. memory usage) is used for the determination of the victim.
Bpf approach will require re-implementing the logic, but potentially is more
powerful due to a fast access to a lot of kernel data.

Thanks!
