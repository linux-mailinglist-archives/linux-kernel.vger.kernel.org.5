Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EC78BCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjH2Cpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjH2CpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD617CDD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0ACE619F7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE258C433C7;
        Tue, 29 Aug 2023 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693277066;
        bh=12Tjw7tG7dL1mz2s20vN7qBFSnVgo76Z5LvZt0hGtSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSMm8RofdIq9mhsJ4nBFA3VO46K+Kb/tLOL8vqVTu6ZCFb+V5o4/B4/pmN6Wwu4h1
         QcuriqL5B7mrKKIftPgk1dck+tRE3c2GwlPoIpvWeBpP0507TiIyGeC6DZZhfvaZ+K
         JOmLB5BUFh26YzOWt4w4Br0XmgAxEbCblUXkjHjbLcYZ7B6/nNKjRalOczoqGuNrOo
         Hf11xBqLN/pID9HvJICo5Dnes3FkTwum/HKLtzp31rSBTMwEb2iDzDESBdgw0LaotF
         jHRZeaBageTAfmIs0euZi+CdB0zv0iOnkTaN1lgXDrZz8zdPNSDK2v5mPemadn8zwe
         MuWlSYbRsuy1A==
Message-ID: <cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org>
Date:   Mon, 28 Aug 2023 20:44:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Content-Language: en-US
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 5:18 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 714cdc9e2b8e..9696343d0aa9 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -3013,8 +3013,6 @@ static struct ip6_sf_list *igmp6_mcf_get_next(struct seq_file *seq, struct ip6_s
>  				continue;
>  			state->im = rcu_dereference(state->idev->mc_list);
>  		}
> -		if (!state->im)
> -			break;
>  		psf = rcu_dereference(state->im->mca_sources);
>  	}
>  out:

agree the check is not needed, but I also believe it does not need to be
backported. Since net-next is closed, resubmit after 9/11.

--
pw-bot: defer
