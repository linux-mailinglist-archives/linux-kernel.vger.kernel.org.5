Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A907781967
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjHSLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjHSLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9C1A28D;
        Sat, 19 Aug 2023 04:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1E86239E;
        Sat, 19 Aug 2023 11:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D05F0C43391;
        Sat, 19 Aug 2023 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445903;
        bh=GyFU6T0F2OLpd6ALmXN+jAt+vbRAupCEOdTo8blHr2A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t3Hq3ZLeskmN+egFuL4uTPl3pS4N5Pan9mqN2RTBePrAs2EHkWtv/6OIanl57V49l
         KAe9YLvKHnO85BqGHZzv4+HpSrYDSdQ1Q57rn+MVi/p3H2OPmTX9TtN1eWN7iYHec2
         rt8DUEgAJk+uDqGvQHfhYk8b/PCiyd+qTlV/xzWQ+LJ6jKcRW24LuwQsCPDO/uwhml
         m4mNwWl1pgjiCoXiU7SubfJYR7ywJ2Cx4nEXGOCPjw0WtMoJn9qyrCP0eptVA3qs1o
         2B2Yik6e8jq/J6MYlFAHVhyTWyVNGRhHFRQSCgZdyjwc7hwAPTJVdxG56ip/9eKMsh
         UdrQj/O+h721Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB93FC395DC;
        Sat, 19 Aug 2023 11:51:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net/smc: several features's implementation
 for smc v2.1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169244590269.30754.2401576809256028711.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 11:51:42 +0000
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 17 Aug 2023 21:20:26 +0800 you wrote:
> This patch set implement several new features in SMC v2.1(https://
> www.ibm.com/support/pages/node/7009315), including vendor unique
> experimental options, max connections per lgr negotiation, max links
> per lgr negotiation.
> 
> v1 - v2:
>  - rename field fce_v20 to fce_v2_base in struct
>    smc_clc_first_contact_ext_v2x
>  - use smc_get_clc_first_contact_ext in smc_connect
>    _rdma_v2_prepare
>  - adding comment about field vendor_oui in struct
>    smc_clc_msg_smcd
>  - remove comment about SMC_CONN_PER_LGR_MAX in smc_
>    clc_srv_v2x_features_validate
>  - rename smc_clc_clnt_v2x_features_validate
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net/smc: support smc release version negotiation in clc handshake
    https://git.kernel.org/netdev/net-next/c/1e700948c9db
  - [net-next,v2,2/6] net/smc: add vendor unique experimental options area in clc handshake
    https://git.kernel.org/netdev/net-next/c/7290178a82fc
  - [net-next,v2,3/6] net/smc: support smc v2.x features validate
    https://git.kernel.org/netdev/net-next/c/6ac1e6563f59
  - [net-next,v2,4/6] net/smc: support max connections per lgr negotiation
    https://git.kernel.org/netdev/net-next/c/7f0620b9940b
  - [net-next,v2,5/6] net/smc: support max links per lgr negotiation in clc handshake
    https://git.kernel.org/netdev/net-next/c/69b888e3bb4b
  - [net-next,v2,6/6] net/smc: Extend SMCR v2 linkgroup netlink attribute
    https://git.kernel.org/netdev/net-next/c/bbed596c74a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


