Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2B77D30E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjHOTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbjHOTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:11:39 -0400
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D41BF8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:11:32 -0700 (PDT)
Date:   Tue, 15 Aug 2023 12:03:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692126208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkRjwrMHjPs40FvzIa8pU0GNTtMYIYTzYPKaWxP8TNI=;
        b=Ta2jjtysX+1vuxpyDUL4lX0t4dNB9CUUZt1Qpq8S7DmFhD7Q8DvwNvtB+TFE6B48E42Pab
        4uqcpSkIIf3/cS53lR+lRYgO/ZWUkCJseanx6zyGEoUMpGyn9fN42NZATCchY+ZUoN5mVw
        M7G1F6TVvzFETdqbgAEU1Z0ohAAmHE0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNvL65bx/PARcyBu@P9FQF9L96D.corp.robot.car>
References: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
 <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
 <c390dc64-280e-6d9f-661a-9a5d77f16cf8@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c390dc64-280e-6d9f-661a-9a5d77f16cf8@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:41:01PM -0700, Martin KaFai Lau wrote:
> > > > > First, I'm a bit concerned about implicit restrictions we apply to bpf programs
> > > > > which will be executed potentially thousands times under a very heavy memory
> > > > > pressure. We will need to make sure that they don't allocate (much) memory, don't
> > > > > take any locks which might deadlock with other memory allocations etc.
> > > > > It will potentially require hard restrictions on what these programs can and can't
> > > > > do and this is something that the bpf community will have to maintain long-term.
> > > > 
> > > > Right, BPF callbacks operating under OOM situations will be really
> > > > constrained but this is more or less by definition. Isn't it?
> > > 
> > > What do you mean?
> > 
> > Callbacks cannot depend on any direct or indirect memory allocations.
> > Dependencies on any sleeping locks (again directly or indirectly) is not
> > allowed just to name the most important ones.
> > 
> > > In general, the bpf community is trying to make it as generic as possible and
> > > adding new and new features. Bpf programs are not as constrained as they were
> > > when it's all started.
> 
> bpf supports different running context. For example, only non-sleepable bpf
> prog is allowed to run at the NIC driver. A sleepable bpf prog is only
> allowed to run at some bpf_lsm hooks that is known to be safe to call
> blocking bpf-helper/kfunc. From the bpf side, it ensures a non-sleepable bpf
> prog cannot do things that may block.

Yeah, you're right: non-sleepable bpf should be ok here.

> 
> fwiw, Dave has recently proposed something for iterating the task vma
> (https://lore.kernel.org/bpf/20230810183513.684836-4-davemarchevsky@fb.com/).
> Potentially, a similar iterator can be created for a bpf program to iterate
> cgroups and tasks.

Yes, it looks like a much better approach rather than adding a hook into
the existing iteration over all tasks.

Thanks!
