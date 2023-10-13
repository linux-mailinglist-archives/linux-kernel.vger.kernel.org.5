Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52C87C8B51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjJMQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:21:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01AFE1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3960C433C8;
        Fri, 13 Oct 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697214000;
        bh=jB3xhsGiwedT1y0wsLmc3+3AK+4h8XgMTED+Ov12vqg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rSdJ+ZfS8hra/kHxpm4imBJSuOolm27MNMNZ7jyYCdnRGaeygnfM70LBwbbbY6STu
         ELaUi+KmT0gJGPp0k/4ekqUeFMjk4RTbXsgjnCRIIlMQJFu9LteNfhak5LfQssUGcC
         Tp3Vka37L6UIDskAq0wYaih8iStrWdDOzllpwGS9otXToYwuN1X4QbYgO64hZOf5CD
         7sSDOEyGx1YRlX48QCwwlRf2PljlPkd+dMrW7hVbunqdXNIJHoI435npJEEr1w8rHP
         9XIviSGO+1peoa+CkVn2iPLSc+rM6rLHJ7MbKr5IPW128AggXALCnpCJIBis2HJpl8
         ErDyxdrYzXX5A==
Message-ID: <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
Date:   Fri, 13 Oct 2023 11:19:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Content-Language: en-US
To:     "Nabil S. Alramli" <nalramli@fastly.com>, sbhogavilli@fastly.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     srao@fastly.com, dev@nalramli.com
References: <20231012005721.2742-2-nalramli@fastly.com>
 <20231012234025.4025-1-nalramli@fastly.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231012234025.4025-1-nalramli@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 5:40 PM, Nabil S. Alramli wrote:
> From: Suresh Bhogavilli <sbhogavilli@fastly.com>
> 
> On a node with multiple network interfaces, if we enable layer 4 hash
> policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
> broken and TCP connection does not make progress unless the incoming
> ICMP Fragmentation Needed (type 3, code 4) message is received on the
> egress interface of selected nexthop of the socket.

known problem.

> 
> This is because build_sk_flow_key() does not provide the sport and dport
> from the socket when calling flowi4_init_output(). This appears to be a
> copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
> flowi4_init_output() call used for packet forwarding where an skb is
> present, is passed later to fib_multipath_hash() call, and can scrape
> out both sport and dport from the skb if L4 hash policy is in use.

are you sure?

As I recall the problem is that the ICMP can be received on a different
path. When it is processed, the exception is added to the ingress device
of the ICMP and not the device the original packet egressed. I have
scripts that somewhat reliably reproduced the problem; I started working
on a fix and got distracted.
