Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202FE7AB220
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjIVM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIVM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:28:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA71A5;
        Fri, 22 Sep 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/hHJSVVNBq+Q25kH/Q3wHbSMiRa2RSWRIm+2U1rOzjk=; b=RGnfJOeunzJN6IjLYEZrXxcAL/
        fpuqpfDgH6Qj5AGs24gad1FLT/whsUz9i+WsoI2JuCWqvJREJGjVEjZGDNHJYKJ6ciBPPNTd/I/0+
        Zj7N6VWu/XuVFoJ4TnxeWgPsNcLEZE4uTMKvr56eStvdFil+9r9xQ7pQu1x1FCDurx1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjfGQ-007CHP-5B; Fri, 22 Sep 2023 14:28:06 +0200
Date:   Fri, 22 Sep 2023 14:28:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: stmmac: increase TX coalesce timer to
 5ms
Message-ID: <13bc074d-30c2-4bbf-8b4c-82f561c844b0@lunn.ch>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <20230922111247.497-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922111247.497-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 01:12:47PM +0200, Christian Marangi wrote:
> Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
> multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.
> 
> This caused some performance regression on some target (regression was
> reported at least on ipq806x) in the order of 600mbps dropping from
> gigabit handling to only 200mbps.
> 
> The problem was identified in the TX timer getting armed too much time.
> While this was fixed and improved in another commit, performance can be
> improved even further by increasing the timer delay a bit moving from
> 1ms to 5ms.
> 
> The value is a good balance between battery saving by prevending too
> much interrupt to be generated and permitting good performance for
> internet oriented devices.

ethtool has a settings you can use for this:

      ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
              [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
              [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
              [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
              [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
              [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
              [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
              [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-bytes N]
              [tx-aggr-max-frames N] [tx-aggr-time-usecs N]

If this is not implemented, i suggest you add support for it.

Changing the default might cause regressions. Say there is a VoIP
application which wants this low latency? It would be safer to allow
user space to configure it as wanted.

     Andrew
