Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A67B1B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjI1L6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1L6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:58:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ECC11F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:58:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B66C433C7;
        Thu, 28 Sep 2023 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902309;
        bh=u/+AGQZZm+SiM9ktB+jXaWA0khtFcUnQM0ytfHWXFVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVJWBEPbmQ1AsrWdZbYoR0JX6ImPJMNyCHuGcXDB/8c6nnfANxbdTQxPQzz8Jfak/
         dzGN0SzHJ4gjBDujvjVOyJmU1ygHBHcAkS5BspN9ld2AFtH7qwA9sfLwJINdS4Csqi
         MuoNZEDFCWIVs8RDFNDnjyoiLhNs6WFFTv7d4lct10MV4LQJgh/253XvFse/7thAa7
         4GWDJhaD2yd8MBVNJqs6JUTiEzA+RIInsxHSnthb7hGW9Z+c9x+X8lAl36D9KWgf9V
         sOln0yEPivAuZDTbvwiiJITq2JTfNPmctiXerI914qVqX4/Lz9BDnGvKTfX/8ObkoI
         y7r1HHp+x5Psw==
Date:   Thu, 28 Sep 2023 13:57:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add sw tx/rx irq
 coalescing based on hrtimers
Message-ID: <20230928115713.GG24230@kernel.org>
References: <20230922121947.36403-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922121947.36403-1-rogerq@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:19:47PM +0300, Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Add SW IRQ coalescing based on hrtimers for TX and RX data path which
> can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0
>   ethtool -C eth1 tx-usecs 50
>   - configure TX0
>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>   - configure TX1
>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>   - configure TX0 and TX1
>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce tx-usecs 100
> 
>   show configuration for TX0 and TX1:
>   ethtool -Q eth0 queue_mask 3 --show-coalesce
> 
> Comparing to gro_flush_timeout and napi_defer_hard_irqs, this patch
> allows to enable IRQ coalesing for RX path separately.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

