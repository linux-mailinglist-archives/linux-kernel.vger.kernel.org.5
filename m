Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163228065D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376550AbjLFDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjLFDnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:43:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7F188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:43:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C4BC433C8;
        Wed,  6 Dec 2023 03:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701834226;
        bh=Yt/7bAOKIimNBpZ0Q4GpZ/R6rZPYD6PxJiZ4tyrcpxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cEk+RaKyvuWTUrYHayrbeJd+hkwdeo/6xXsVj9MQpyDav2tUpHVJPo8phFf00hoxV
         dc2wrv7DXhihdJpBks5x4pDuOCoaGwaUSiAZ6jJi1x5gctVY2OZz3vdeHwjM7H0G9P
         2vIP4kBu79EfQo4/XOuFXREVjY91BvCkOna62RS1TLhD26qUSGm1jQ3kY99CHeaK1z
         JOt0YI6tPiwqQzKf7cEMiKXuCQYMZlli+23XDclgnxffCiJc6jaE0h6/vkv5jNg/61
         Lh08gLdtNnCiuxds2dIzP+KmmDUgxpA86x5V08dpKdB1WiUj8aEN9hZ6Xdl7b6EeLb
         43SXRNnz4tNnw==
Message-ID: <2fea2908-69a5-4c6d-ad27-94f48f2f2586@kernel.org>
Date:   Tue, 5 Dec 2023 20:43:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Simon Horman <horms@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 8:38 PM, Judy Hsiao wrote:
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=1000 which expects tasks to be able to schedule in
> with ~1ms latency.
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> 
> ---
> 
> Changes in v2:
> - Use ktime_get_ns() for timeout calculation instead of jiffies.
> 
>  net/core/neighbour.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

