Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC747DCA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjJaKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjJaKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EE113;
        Tue, 31 Oct 2023 03:14:28 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:14:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698747266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iX/KH2uQ59JkXmBYik5taBnOlkDyh5K27ne0UO08DGU=;
        b=d4LB31sE1eHw2NCSlos+jWEyMRnRlJzazcmVO7Td+52CglmICB8no/Ax9If8y37tHYIagB
        jlPIXg8buAenKvW5FjLSkL9197SERdIMwvwye2I5rxz4p6ClJL4P50kTfobmpPqZ+Xy1zL
        OdnHdmpsmTYDRU9bD6vVutayqkKKdq9jWaAPrvI13CEzCWiHsEUQQFODPX3T/tnBbiOTqE
        oq4TWRpIOyyKxtoWAr3nrt2dacFvYVLGTy9zeiBNNRwttPJ35zQmYFUi0y7o8LeYizrBeX
        TEjFunK61uz4NcOG6J+4J4UHNTblde8USIObjPWnIl1NdDT02yiCRbCFPtoPPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698747266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iX/KH2uQ59JkXmBYik5taBnOlkDyh5K27ne0UO08DGU=;
        b=ziqUWti5quLNaYI35IOsIj84QXu9EEltRruBzXDw6AP4k7Efux/puGFxvYh2y/wOIdrun+
        ImCCo34RWCha9OCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Come On Now <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231031101424.I2hTisNY@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org>
 <20231007155957.aPo0ImuG@linutronix.de>
 <20231009180937.2afdc4c1@kernel.org>
 <20231016095321.4xzKQ5Cd@linutronix.de>
 <20231016071756.4ac5b865@kernel.org>
 <20231016145337.4ZIt_sqL@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016145337.4ZIt_sqL@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-16 16:53:39 [+0200], To Jakub Kicinski wrote:
> On 2023-10-16 07:17:56 [-0700], Jakub Kicinski wrote:
> > On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > > > Do we have reason to believe nobody uses RPS?  
> > > 
> > > Not sure what you relate to. I would assume that RPS is used in general
> > > on actual devices and not on loopback where backlog is used. But it is
> > > just an assumption.
> > > The performance drop, which I observed with RPS and stress-ng --udp, is
> > > within the same range with threads and IPIs (based on memory). I can
> > > re-run the test and provide actual numbers if you want.
> > 
> > I was asking about RPS because with your current series RPS processing
> > is forced into threads. IDK how well you can simulate the kind of
> > workload which requires RPS. I've seen it used mostly on proxyies 
> > and gateways. For proxies Meta's experiments with threaded NAPI show
> > regressions across the board. So "force-threading" RPS will most likely
> > also cause regressions.
> 
> Understood.
> 
> Wandere/ Juri: Do you have any benchmark/ workload where you would see
> whether RPS with IPI (now) vs RPS (this patch) shows any regression?

So I poked offlist other RH people and I've been told that they hardly
ever test RPS since the NICs these days have RSS in hardware.

Sebastian
