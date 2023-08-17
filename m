Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2F77FAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353225AbjHQPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353227AbjHQPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1A19A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A48FC61E13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F0EC433C7;
        Thu, 17 Aug 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692286227;
        bh=RzylO7MvvVlMSQpaAlr4pOqtI76t6JtBAKrRlm7mOm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DoARQyMEf9wimmENTwBMe0b+tGXmPNuD/rLpEKj/LmSRBg76hsUqiXtcyhlY5MMaI
         1VkO+92+CekUEAPG2pzYW8pw1D+DjE+RjeCDYSrvkX4L3VG3Ou9bUU2EB0ykltqiEX
         C2gqKeEPtz4pDcX6l/x25QJZjGhcWCKGgbdCLV5BZSFGNrMjWiQEcD7GFvIcvasT3u
         mylBTQVmNbXe4C8W1qUCdATr9aNpEu4QrfFokigKbiAcBgkggw7yohCXEvt5A7YWad
         F9uYI+DzdNDL6JP2VVEv/l3riB+a/tWHc3hWcXZAbJIqiU9XkXdXXSdIv8dfTMlDDV
         rOCahxRqfgyXw==
Date:   Thu, 17 Aug 2023 08:30:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Yan Zhai <yan@cloudflare.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230817083025.2e8047fa@kernel.org>
In-Reply-To: <20230817131612.M_wwTr7m@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
        <20230814112421.5a2fa4f6@kernel.org>
        <20230817131612.M_wwTr7m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 15:16:12 +0200 Sebastian Andrzej Siewior wrote:
> I've been looking at veth. In the xdp case it has its own NAPI instance.
> In the non-xdp it uses backlog. This should be called from
> ndo_start_xmit and user's write() so BH is off and interrupts are
> enabled at this point and it should be kind of rate-limited. Couldn't we
> bypass backlog in this case and deliver the packet directly to the
> stack?

The backlog in veth eats measurable percentage points of RPS of real
workloads, and I think number of people looked at getting rid of it.
So worthy goal for sure, but may not be a trivial fix.

To my knowledge the two main problems are:
 - we don't want to charge the sending application the processing for
   both "sides" of the connection and all the switching costs.
 - we may get an AA deadlock if the packet ends up looping in any way.

Or at least that's what I remember the problem being at 8am in the
morning :) Adding Daniel and Martin to CC, Paolo would also know this
better than me but I think he's AFK for the rest of the week.
