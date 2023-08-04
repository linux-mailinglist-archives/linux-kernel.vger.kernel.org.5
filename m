Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698D7702C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjHDORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHDORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7C122;
        Fri,  4 Aug 2023 07:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE4786203B;
        Fri,  4 Aug 2023 14:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C23C433C8;
        Fri,  4 Aug 2023 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691158628;
        bh=ApkfPRCB7TcjMWBCpeisWeMpBBs1DqAxZdkPRk8zHOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feDjZ8KkGFQ13Fj63EyCGelIBXB5ZtKGGRbSNHEPHEx3OXrCqWQc+OGredJ6Li3of
         U70LnjcieQAkcPQAt75wjPdFSJgtZ4tn12aaGaaOX0FJGsegTqp8H651vITB0SaA7v
         TcCf2+hw64XQDFD6QVl7mRcE3cJyH9ovhlV8Y31cnwHW1OLlGrWYL11qlNe3gvn8An
         WoDlTgLmMocIgV8qKEhVfcbqpFI77iqFs3IYPG7/hQc+0yUFqmq+G8DAL5ehup/sDN
         eSmAbUA7lcxkH/g0h00ffM9PHgJiEMfdChtPWP6bxwyo1zttJNcbQYN3rNQfn4PXDQ
         TctT3H+rFI4Zw==
Date:   Fri, 4 Aug 2023 16:17:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/smc: Fix effective buffer size
Message-ID: <ZM0IX/YnaawWT9sm@kernel.org>
References: <20230803144605.477903-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803144605.477903-1-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:46:03PM +0200, Gerd Bayer wrote:
> Hi all,
> 
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") started to derive the effective buffer size for
> SMC connections inconsistently in case a TCP fallback was used and
> memory consumption of SMC with the default settings was doubled when
> a connection negotiated SMC. That was not what we want.
> 
> This series consolidates the resulting effective buffer size that is
> used with SMC sockets, which is based on Jan Karcher's effort (see 
> [1]). For all TCP exchanges (in particular in case of a fall back when
> no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
> are used. If SMC succeeds in establishing a SMC connection, the newly
> introduced values from net.smc.[rw]mem are used.
> 
> net.smc.[rw]mem is initialized to 64kB, respectively. Internal test 
> have show this to be a good compromise between throughput/latency 
> and memory consumption. Also net.smc.[rw]mem is now decoupled completely
> from any tuning through net.ipv4.tcp_[rw]mem.
> 
> If a user chose to tune a socket's receive or send buffer size with
> setsockopt, this tuning is now consistently applied to either fall-back
> TCP or proper SMC connections over the socket.
> 
> Thanks,
> Gerd 
> 
> v1 - v2:
>  - In second patch, use sock_net() helper as suggested by Tony and demanded
>    by kernel test robot.
> 
> [1] https://lore.kernel.org/netdev/20221123104907.14624-1-jaka@linux.ibm.com

Hi Gerd,

unfortunately this patchset does not appear to apply to current 'net'.

Could you rebase and send a v3?

-- 
pw-bot: changes-requested

