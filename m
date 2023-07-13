Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A5752940
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjGMQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjGMQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E62708
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3808E61AED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911AC433C8;
        Thu, 13 Jul 2023 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689267468;
        bh=1U0ZApqiqBJyYb9F7YTTl2VWqVGIrbvAyt5SJ/N5UeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gNHYUQTLWWGxDhkxQy/gad2QxsFLJin7GlOhdFTKBWpWTLxYwc9mgVt3jrjY/62Ey
         ecezQTdRweCO0ohUX4Gb0RzeUHBNrfAlCXqYo/3nXOA9xvFk3IevAAXSv4Z6iN/Zmh
         vbTn3Qxla3CBL9pqLAjHb+Yct8AlA00mniRah1/41TUckc9NnLwzCGJ2ejUyJo9NzJ
         8lZ7eo01eroncxURfMzj7FLp2XD4I4ri9SL20Z5P18eAyc8x8i6UZb/L46P/4WoHKn
         aOa8E5LzzJgtghUzkU3wm3FvZ8PkeV/QPTIgt4G4XmFgYYsxHYTyjo1CizuHbpUEgW
         KwJcrDBg+dtkQ==
Date:   Thu, 13 Jul 2023 09:57:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230713095747.580c2b0a@kernel.org>
In-Reply-To: <CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
        <20230711193612.22c9bc04@kernel.org>
        <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
        <20230712104210.3b86b779@kernel.org>
        <CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 21:43:32 -0500 Yan Zhai wrote:
> Those are not unnecessary calls, e.g. a lot of those kfree_skb come
> from iptables drops, tcp validation, ttl expires, etc. On a moderately
> loaded server, it is called at a rate of ~10k/sec, which isn't
> terribly awful given that we absorb millions of attack packets at each
> data center. We used to have many consume skb noises at this trace
> point with older versions of kernels, but those have gone ever since
> the better separation between consume and drop.

I was hoping you can break them down by category.

Specifically what I'm wondering is whether we should also have 
a separation between policy / "firewall drops" and error / exception
drops. Within the skb drop reason codes, I mean.
