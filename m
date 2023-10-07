Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEE7BC8FA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJGQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbjJGQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:00:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B51BA;
        Sat,  7 Oct 2023 09:00:00 -0700 (PDT)
Date:   Sat, 7 Oct 2023 17:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696694398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=35TTRveXU2Ka7eoxo3UirDZ5E25/uzkse4gLA2aaRG4=;
        b=SEMFqg5hGSJNguDX9id9Wo/3ADKEUNIAazqz0QWmfUT1VUAk426yEbYBuuu2Bsck34Rxvr
        JBi6/IuLmVvwtOb9YRX7mMc4aDb80Hju6TUdLWsdEoh6WFePS6Fqv1zMmxjXWOtOQ/yPLI
        ANFhdYIkd6HTERjGJhCPHkKLNAK9mrw5oy9w7VQEBOvZ7jOmJk5NVIBFoOTR8YIUKnThqq
        +2alK5zWoRgyvDZrV+oq3aKZKRKuPIRKUbABrm3PK1nhVfck/BGxxv0Z6eGvBH1DPOoRqD
        gwTCdeNtJktA0Z0MyZHITjpFnERhuXaL0xvRSOgoAhwvrHcdA33Tv2I0VOVWfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696694398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=35TTRveXU2Ka7eoxo3UirDZ5E25/uzkse4gLA2aaRG4=;
        b=v7Sxfo5oPzPYHqoTaT2fz2jGOvxx9dP2ovpzBpe0JfddaRFWxWMUYP3UKiMF2bZldMd4FH
        kibF+uyqJjeMANAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231007155957.aPo0ImuG@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004154609.6007f1a0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-04 15:46:09 [-0700], Jakub Kicinski wrote:
> On Fri, 29 Sep 2023 18:20:18 +0200 Sebastian Andrzej Siewior wrote:
> >    - Patch #2 has been removed. Removing the warning is still an option.
> > 
> >    - There are two patches in the series:
> >      - Patch #1 always creates backlog threads
> >      - Patch #2 creates the backlog threads if requested at boot time,
> >        mandatory on PREEMPT_RT.
> >      So it is either or and I wanted to show how both look like.
> > 
> >    - The kernel test robot reported a performance regression with
> >      loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
> >      The regression is now avoided by using local-NAPI if backlog
> >      processing is requested on the local CPU.
> 
> Not what we asked for, and it doesn't apply.

Apologies if I misunderstood. You said to make it optional which I did
with the static key in the second patch of this series. The first patch
is indeed not what we talked about I just to show what it would look
like now that there is no "delay" for backlog-NAPI on the local CPU.

If the optional part is okay then I can repost only that patch against
current net-next.

Sebastian
