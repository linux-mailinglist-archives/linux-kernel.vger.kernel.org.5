Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484B77DD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbjHPJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243332AbjHPJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0789D26A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4D8616AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80EC433CA;
        Wed, 16 Aug 2023 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692178592;
        bh=WMb5MgJHMYvODEXXoXrLavxbTDf4vczIeJF+HfPmOgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLMawRYL5RQTZArXYzwlDV3Yss/ONrSi9ilW1iZsIXBYcW+YT5+1X31sai00ZOx1F
         ElNRloamoN3j//ij3+UoC3TON9L9UErH80ZD3FUDzBA5n7Ay8hYujdSqLh/X0Rf3IF
         EcHu06QZqFVZaJN7DWz4QhobeDQXat9WKp0OR8lTQwDAMXUxKMn8EqCvuiLvksKk9a
         vsR5hGjpDsJuGXtz1I7Ra7ZXIVTFnMVqhf/3L97V4EX7p2GVTiufrZgI9mHSBw/33s
         WziV3X0vhoMYZsDiXXTwGtgG3NwvJejSPyLu9kQ+vW7jg0SDX8Hv1rNWqloRh30F2U
         FxJS57oqxeseA==
Date:   Wed, 16 Aug 2023 11:36:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Francois Michel <francois.michel@uclouvain.be>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] netem: use a seeded PRNG for loss and
 corruption events
Message-ID: <ZNyYnLrA7bLMpM4O@vergenet.net>
References: <20230815092348.1449179-1-francois.michel@uclouvain.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815092348.1449179-1-francois.michel@uclouvain.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:23:37AM +0200, Francois Michel wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> In order to reproduce bugs or performance evaluation of
> network protocols and applications, it is useful to have
> reproducible test suites and tools. This patch adds
> a way to specify a PRNG seed through the
> TCA_NETEM_PRNG_SEED attribute for generating netem
> loss and corruption events. Initializing the qdisc
> with the same seed leads to the exact same loss
> and corruption patterns. If no seed is explicitly
> specified, the qdisc generates a random seed using
> get_random_u64().
> 
> This patch can be and has been tested using tc from
> the following iproute2-next fork:
> https://github.com/francoismichel/iproute2-next
> 
> For instance, setting the seed 42424242 on the loopback
> with a loss rate of 10% will systematically drop the 5th,
> 12th and 24th packet when sending 25 packets.
> 
> v1 -> v2: Address comments and directly use
> prandom_u32_state() instead of get_random_u32() for
> generating loss and corruption events. Generates a random
> seed using get_random_u64() if none was provided explicitly.
> 
> François Michel (3):
>   netem: add prng attribute to netem_sched_data
>   netem: use a seeded PRNG for generating random losses
>   netem: use seeded PRNG for correlated loss events
> 
>  include/uapi/linux/pkt_sched.h |  1 +
>  net/sched/sch_netem.c          | 49 +++++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 15 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

