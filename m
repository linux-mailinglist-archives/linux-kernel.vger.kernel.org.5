Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F977F781
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351343AbjHQNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351454AbjHQNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:16:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A7103;
        Thu, 17 Aug 2023 06:16:17 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:16:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692278175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XsU42DM/msA/Cd5i5m/J+bQMyWNBvE8v4MIojmkpuw=;
        b=d48XWJt3B4sHnmLZskkGirccMizqbqs99ML19Gt8vNuTpvwHHgK0qDv8LwO+x2Rk8WVvuA
        wpA3kTiVE19SLdbi9N2k0/fdYIYQrJpPRHan9iYlN9l309crHPX5uLKdhSWTkjSa7Z0/4j
        C6OeSmhZpqpOrHvctYP2vxrNiBLXo/HfRMQUDFqfO9T2xdcf8IiwByxdj9LqgBJpQes30a
        jlTzAnaExixQbMicm3uh9yD3IiTk2LKWlS1Ut1ZUh8s5DzjIqUTuXXYirRZ02chiaAtSqU
        cmKDPasN0v210JPCILgMsoexKi/6q3w32wNJi8TnHIiTBecvom31dQBIImlnWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692278175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XsU42DM/msA/Cd5i5m/J+bQMyWNBvE8v4MIojmkpuw=;
        b=H/3Lwjw4RY5zrazKziA3e4yQKbhpvO4c2rFkNu5MZFvj73HNeWUACNTBWGFl2wVOhjTjQ4
        6JCHm6ybYD8RhHCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Yan Zhai <yan@cloudflare.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230817131612.M_wwTr7m@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814112421.5a2fa4f6@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-14 11:24:21 [-0700], Jakub Kicinski wrote:
> On Mon, 14 Aug 2023 11:35:26 +0200 Sebastian Andrzej Siewior wrote:
> > The RPS code and "deferred skb free" both send IPI/ function call
> > to a remote CPU in which a softirq is raised. This leads to a warning on
> > PREEMPT_RT because raising softiqrs from function call led to undesired
> > behaviour in the past. I had duct tape in RT for the "deferred skb free"
> > and Wander Lairson Costa reported the RPS case.
> 
> Could you find a less invasive solution?
> backlog is used by veth == most containerized environments.
> This change has a very high risk of regression for a lot of people.

Looking at the cloudflare ppl here in the thread, I doubt they use
backlog but have proper NAPI so they might not need this.

There is no threaded NAPI for backlog and RPS. This was suggested as the
mitigation for the highload/ DoS case. Can this become a problem or
- backlog is used only by old drivers so they can move to proper NAPI if
  it becomes a problem.
- RPS spreads the load across multiple CPUs so it unlikely to become a
  problem.

Making this either optional in general or mandatory for threaded
interrupts or PREEMPT_RT will probably not make the maintenance of this
code any simpler.

I've been looking at veth. In the xdp case it has its own NAPI instance.
In the non-xdp it uses backlog. This should be called from
ndo_start_xmit and user's write() so BH is off and interrupts are
enabled at this point and it should be kind of rate-limited. Couldn't we
bypass backlog in this case and deliver the packet directly to the
stack?

Sebastian
