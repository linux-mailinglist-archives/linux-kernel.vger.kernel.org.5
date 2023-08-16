Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458D977E4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjHPPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbjHPPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:22:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D01BF8;
        Wed, 16 Aug 2023 08:22:20 -0700 (PDT)
Date:   Wed, 16 Aug 2023 17:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692199338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7IUEQHzihCH8EQTTWoAYq9Za5pGutJky5EpXbKbfMU=;
        b=hRaGhTAqOqQipkzJSecPXLeVPOVhZMn4h3tA6BogOquSru5AXq2M/eBDB2TpZejeIPKoMR
        nvfPEZqJp6o/cQGoLCmJ+uYHWS+hMS4gMs2NoZ+pATGoxho+S9KRJHxfUJNNik6HEmzGwq
        3ZbUyYEbMdSaSoKTSOJQ+ALwR802pYXFu5mDdcxore7FSI+HsYz2EKZfvDzdoFbagItnwA
        vWi/FAWQFWE6EILqyY5mMK9WOM3ewcwWL3ax8Ol3L7DgYFrY7gZ5TDwYwuC2PicOjuKm4V
        h8hylgWKXpUImrDkeilSfuHyF7XyCyNPkW3mx6QQMGfCjuYYSN/SWXOyqo3r5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692199338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7IUEQHzihCH8EQTTWoAYq9Za5pGutJky5EpXbKbfMU=;
        b=5UAJOfScB/u8xi02CM776lXg6xRl/nTPYpsAF9Ppg/arFnKOqazgFXW8zEOuBtoF8AgPHI
        zwqiTQO83nBSgaBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from
 do_softirq_post_smp_call_flush().
Message-ID: <20230816152216.Gc_KwqZq@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de>
 <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
 <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 16:48:56 [+0200], Jesper Dangaard Brouer wrote:
> I'm no expert in sched / softirq area of the kernel, but I'm willing to help
> out testing different solution that can regain the "overload" protection
> e.g. avoid packet processing "falls-of-an-edge" (and thus opens the kernel
> to be DDoS'ed easily).
> Is this what Sebastian's patchset does?

I was going to respond but didn't know what so far.
Can you figure out if you are using backlog or not. If you do, could try
my patch. If not could you try to enable napi-thread and see?
Either way I will re-read it again.

Sebastian
