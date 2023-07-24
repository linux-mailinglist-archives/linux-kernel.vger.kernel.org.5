Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745DA760202
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGXWIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A510EC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DE161455
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70362C433C8;
        Mon, 24 Jul 2023 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690236496;
        bh=GAjZkvnU69tRmreUB7FnKwG6gWl6gwTbuqowaPIxOP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LD812y6GhvNf81+vQmORo0Hum550TLstldsLojxu4Rk9ECOhRNKSB/GekT8vL/r1B
         1yKVo9Z0eHkCG+CD92qbU6b9o5oH6Gaq1hKJY+O1clbsaoaMDPnBD0d+HlE3sqxszB
         mFPAX/ISexsUuBqWewpgFROAXjewgCWOpj95DfAVtWt9pklw1Sma6ocYZokyB+3RPR
         7wi9+xl+769ce5QVTYTq0qDN0EJb/XQjRTgIJRlHl8dI/lnBCsf++MIJH2IX2r/Pxf
         OQCPZ2OOjngjJkvjTWE9njRMWzRRnyaiLjzKcXgGVCNqq0lfuqYbx4mwQgW8yAUc88
         kloMUGezuMpSg==
Date:   Mon, 24 Jul 2023 15:08:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, bhutchings@solarflare.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230724150815.494ae294@kernel.org>
In-Reply-To: <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
        <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
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

On Mon, 24 Jul 2023 20:27:43 +0100 Edward Cree wrote:
> On 23/07/2023 16:06, Joe Damato wrote:
> > Greetings:
> > 
> > While attempting to get the RX flow hash key for a custom RSS context on
> > my mlx5 NIC, I got an error:
> > 
> > $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> > Cannot get RX network flow hashing options: Invalid argument
> > 
> > I dug into this a bit and noticed two things:
> > 
> > 1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
> > not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
> > that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
> > is patch 1/2.  
> 
> As I see it, this is a new feature, not a fix, so belongs on net-next.
> (No existing driver accepts FLOW_RSS in ETHTOOL_SRXFH's cmd->flow_type,
>  which is just as well as if they did this would be a uABI break.)
> 
> Going forward, ETHTOOL_SRXFH will hopefully be integrated into the new
>  RSS context kAPI I'm working on[1], so that we can have a new netlink
>  uAPI for RSS configuration that's all in one place instead of the
>  piecemeal-grown ethtool API with its backwards-compatible hacks.
> But that will take a while, so I think this should go in even though
>  it's technically an extension to legacy ethtool; it was part of the
>  documented uAPI and userland implements it, it just never got
>  implemented on the kernel side (because the initial driver with
>  context support, sfc, didn't support SRXFH).

What's the status on your work? Are you planning to split the RSS
config from ethtool or am I reading too much into what you said?

It'd be great to push the uAPI extensions back and make them
netlink-only, but we can't make Joe wait if it takes a long time
to finish up the basic conversion :(
