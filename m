Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF877C5C60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjJKSvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJKSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F996E3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:51:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7C9C433C8;
        Wed, 11 Oct 2023 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050269;
        bh=xHjSajgbqDVJreeYNE416phrC7tK0Bxr9AhJFMNBi/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BKRnslJfWwQOczGi9dpbqoq6vdXykaT3KUp4glNsg4s0nYq+bTLt2v6glFwFh43F6
         VoZQ87Kh+ZX/3tcrsfFbNkjELHvHQaQ1OCJgJ/HnIyOBssFsoKZt6zwmsTTssknWAi
         LzAiCu0WAYumg2e0C/wf5NIWkTAxVSSuZTKSYqAQkELls5kIAk0yC5pZB/aqN1E08H
         Med1kxnGRKdqC3H/3Iy/lxWS2rZYwIFcHyKJCtwewGs9WWrUzpGEapPoffYmJcxtyT
         FivMve12aqAotJrYir18L8yhtCbqVR4HZ4tZfRjDw3CV3m2Dqrie5hDByjpJFFa/eS
         FX0iMJIEm+Dqw==
Message-ID: <a237055b-d617-86da-2fed-8193b2a98a22@kernel.org>
Date:   Wed, 11 Oct 2023 12:51:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/7] ipv4: add new arguments to
 udp_tunnel_dst_lookup()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-4-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-4-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> We want to make the function more generic so that it can be used by
> other UDP tunnel implementations such as geneve and vxlan. To do that,
> add the following arguments:
> 
>  - source and destination UDP port;
>  - ifindex of the output interface, needed by vxlan;
>  - the tos, because in some cases it is not taken from struct
>    ip_tunnel_info (for example, when it's inherited from the inner
>    packet);
>  - the dst cache, because not all tunnel types (e.g. vxlan) want to
>    use the one from struct ip_tunnel_info.
> 
> With these parameters, the function no longer needs the full struct
> ip_tunnel_info as argument and we can pass only the relevant part of
> it (struct ip_tunnel_key).
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      | 11 +++++++----
>  include/net/udp_tunnel.h   |  8 +++++---
>  net/ipv4/udp_tunnel_core.c | 26 +++++++++++++-------------
>  3 files changed, 25 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


