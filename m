Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5B7DD6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjJaTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJaTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:53:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FCDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:53:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF144C433C7;
        Tue, 31 Oct 2023 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698782029;
        bh=2oK9cLvx1sCDZNWlQ8YmD9XkYwVk52IAfb2GSyqsfFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QwvqM/vxLUku3QjCdu5Eg5XrdhSYkBdWRjg6HQB1qwynnRUbLEWDc32mkIePftzyi
         lFVKmTxwmx5EyhzaY4tGlPHsV3Ge48WSUYThxF/cNjNz7cwLdnFn8UrqVq+o2rcV9b
         Ffeuq9d+6GOK7QS2GLyLIjtcGkc6H/Ljro0eQ5MQeKVwtpCnOCLqjaedYXcZ1yiL1q
         erE2ddwGXYHUaOmMfkC6wPqyPzNz8yasVZebpG67Rz5avikUKUAPeYJCGXo3N2By7k
         E3TOpljh28b3s/Y9344i7pf0JWj8kX5I7fmbVzAo3QKIN1ND1HEy3VtVKhu3ZhgqMc
         pGcw9rVhTxRiw==
Date:   Tue, 31 Oct 2023 12:53:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Youlun Zhang <zhangyoulun@bytedance.com>
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Message-ID: <20231031125348.70fc975e@kernel.org>
In-Reply-To: <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
        <20231027190254.GA88444@n191-129-154.byted.org>
        <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
        <20231028231135.GA2236124@n191-129-154.byted.org>
        <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 15:19:26 +0100 Daniel Borkmann wrote:
> > Since I didn't want to update host-veth's TX counters.  If we
> > bpf_redirect_peer()ed a packet from NIC TC ingress to Pod-veth TC ingress,
> > I think it means we've bypassed host-veth TX?  
> 
> Yes. So the idea is to transition to tstats replace the location where
> we used to bump lstats with tstat's tx counter, and only the peer redirect
> would bump the rx counter.. then upon stats traversal we fold the latter into
> the rx stats which was populated by the opposite's tx counters. Makes sense.
> 
> OT: does cadvisor run inside the Pod to collect the device stats? Just
> curious how it gathers them.

Somewhat related - where does netkit count stats?

> >> Definitely no new stats ndo resp indirect call in fast path.  
> > 
> > Yeah, I think I'll put a comment saying that all devices that support
> > BPF_F_PEER must use tstats (or must use lstats), then.  
> 
> sgtm.

Is comment good enough? Can we try to do something more robust?
Move the allocation of stats into the core at registration based 
on some u8 assigned in the driver? (I haven't looked at the code TBH)
