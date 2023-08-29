Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC51A78BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjH2Cpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjH2Cpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0F1A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D9A860EBB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF4BC433C8;
        Tue, 29 Aug 2023 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693277123;
        bh=hH2/zSFJebPe7D39TykbqHcZy5SmvHwnaWolx9gVkzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JJ0mb0KTN62N+r1ktmDaoC3MGU1ek0z87gqQBvNJ3jWHtgE4UINiEQOBxOORHeCJS
         3JrbfD3XFqafnMeGDDKbcs06+xBWDXmc13KCrGrgQTdXPiBN6EHo5xI0NZ137stBW7
         TNSRC9cGG4AykY8t1T7BlPvIR3RjyhkFrckBmAwa667ZKpiCA9BjPxLhTej4uRY/rh
         T+3Amn1N0pY0dan5MVAsqUq4wf+mgQ5EmTYcVnV0ZVGTm0IYYsMzPjFghL6G+JiHrj
         kCDpheWEY3Gyb7jdnaLa4x+2J00dynNVcLhxv9b5W5C5NpNKoiCanbMEWM9+VCZlMU
         7JynWHOKJiRVw==
Message-ID: <fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org>
Date:   Mon, 28 Aug 2023 20:45:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Content-Language: en-US
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
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

On 8/28/23 3:01 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/ipv4/igmp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 48ff5f13e797..6ebf06886527 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -2943,8 +2943,6 @@ static struct ip_sf_list *igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_l
>  				continue;
>  			state->im = rcu_dereference(state->idev->mc_list);
>  		}
> -		if (!state->im)
> -			break;
>  		spin_lock_bh(&state->im->lock);
>  		psf = state->im->sources;
>  	}

Same with this one: agree the check is not needed, but I also believe it
does not need to be backported. Since net-next is closed, resubmit after
9/11.

--
pw-bot: defer
