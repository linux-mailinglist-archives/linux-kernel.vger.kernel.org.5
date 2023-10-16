Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9ED7CA3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJPJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A331E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:10:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F4FC433C7;
        Mon, 16 Oct 2023 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447453;
        bh=9Lx78ecl0MZuF5F5PNauQCDBeFdcUns/BLrcQKTwtW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKpgoN/b8/gx5spIIHKQLj/BYMaITLA0ShZI8w54Z6AZp3+yxr+251NrFO3tI9/HA
         dKuuuaYuLdJRYP4053aXJObFgODZ8XabcwBbEU7z1bl3ojOSeSyAr2+h/jSiOtNRvv
         x0+44lYRpiiNjJ/Pr/xd80TumRQQ0bWoaXWJE4Wz7a3QKh/SwR7NlIUN8qDhptlsWQ
         ItL7ryT709B5NYfrKHbsSdf79BPk+Ioj7jZrYg4C2GOamcEbXeK66myoQtT6o7Rtc4
         hV9OmkzeywmN8uujBf5iHby+/H6F6OgKHk62t8aRudGlfHwkRZ4dOOzkpMHKmq3oPU
         3kZxk5sEhKImw==
Date:   Mon, 16 Oct 2023 11:10:48 +0200
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
        dsahern@kernel.org, ncardwell@google.com, ycheng@google.com,
        kuniyu@amazon.com, morleyd@google.com, mfreemon@cloudflare.com,
        mubashirq@google.com, linux-doc@vger.kernel.org, weiwan@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
Message-ID: <20231016091048.GG1501712@kernel.org>
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:30:44PM -0700, Haiyang Zhang wrote:
> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> There is no single value that fits all applications.
> Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> optimal performance based on the application needs.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3: Updated doc as suggested by Neal Cardwell.
>     Updated variable location in struct netns_ipv4 as suggested by Kuniyuki
>     Iwashima.
> 
> v2: Make it per-namesapce setting, and other updates suggested by Neal Cardwell,
> and Kuniyuki Iwashima.

Thanks,

this looks clean to me. It seems to address the review of v2.
And keeps the knob as syctl as discussed in v2.

Reviewed-by: Simon Horman <horms@kernel.org>
