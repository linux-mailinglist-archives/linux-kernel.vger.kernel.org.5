Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8C76778C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjG1VVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG1VVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712944A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9350962204
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 21:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F58C433C8;
        Fri, 28 Jul 2023 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690579302;
        bh=edGCRJ0flhlER9HpXmivZeXp4EX2gRZndfukWqPCczg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=cPSF9/epTXmcZRnCHhaUMiLiJ8LOggxO+jLjjYswTQq6KeDJb87VocGU/nH1hA67r
         JDx2V8N1xlNjJC1S7hYuG7Kd4ya6cRZGwo86dUxnV3W9912B9U/7Yj7f+icgNdit4F
         vO4rvUos63tF2xiZP9wLZ7OQmkzMLGCLNMIqyzN6jAYk5VoKpzhRsVGG6pWDQOsc4i
         iN4xLC8v9863JNmwvTnD3a1jnSXQET91vlNVbdn/wydGSnvWTEA9O0a+Gj8Y686Wq2
         txrIWK+X/JZX29xv5utrtYOF6mtt+BeuHPJQhPxieN6Y0TkCOkG9GRybybr4UNJPDe
         gYIFYvArtw/3A==
Message-ID: <7adc43f3-725d-84df-065d-7d77d03327f6@kernel.org>
Date:   Fri, 28 Jul 2023 15:21:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/1] net: gro: fix misuse of CB in udp socket lookup
Content-Language: en-US
To:     Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, tom@herbertland.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gal@nvidia.com
References: <20230727152503.GA32010@debian> <20230727153353.GA32089@debian>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230727153353.GA32089@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 9:33 AM, Richard Gobert wrote:
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
> 
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      | 43 ++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/udp.c         |  8 ++++++--
>  net/ipv4/udp_offload.c |  7 +++++--
>  net/ipv6/udp.c         |  8 ++++++--
>  net/ipv6/udp_offload.c |  7 +++++--
>  5 files changed, 65 insertions(+), 8 deletions(-)
> 

I still think the text in the cover letter should be in this commit message.

Code wise, it looks ok to me:
Reviewed-by: David Ahern <dsahern@kernel.org>


