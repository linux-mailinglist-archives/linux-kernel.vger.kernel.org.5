Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959317F3912
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKUWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKUWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:18:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31759191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:18:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BD7C433C7;
        Tue, 21 Nov 2023 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700605109;
        bh=0YC8SZz2FmloJHwU36nssTJ1zRm8xPDAafdB0h0p0j0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J7zbkuQ6LQ+LUO4qnHeIdW5uvb9tAeXXblsJnIjSdG/gi8y/92947Lz1YqIzfixt5
         uVVGJ31aOHi3sEBXvx0JhrRgiYdoNk0r9EXcfCD/bQOL4MZPaO5OHiGWlC/hIbwx2Q
         97V9cCj/VSKWU6fEsF2dnbvt6QbJPSixZN+CHkJ1IX3lgYB/d8kK33DX/KGweik4Mh
         cdxn+yKsIHdLlvSmSb2xj1hV7y9r5ENApxLGjwmSYh6qOO4G2durBhEgSdqWfHoiQu
         ewiuZjCE0MFhDE7kxvKhSTvVh4geYajIlNKanThHzyE9TxtGB8lvOqqwsZyXXiDzFM
         ggeuUxA5OO58Q==
Message-ID: <7ae9adff-5a6a-4ca6-983b-1d866dae9199@kernel.org>
Date:   Tue, 21 Nov 2023 14:18:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Content-Language: en-US
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, linux-kernel@vger.kernel.org
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-6-saeed@kernel.org> <20231121124456.7a6388c6@kernel.org>
 <ZV0bRpnhu/zWieTT@x130>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <ZV0bRpnhu/zWieTT@x130>
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

On 11/21/23 1:04 PM, Saeed Mahameed wrote:
> On 21 Nov 12:44, Jakub Kicinski wrote:
>> On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
>>> high frequency diagnostic counters
>>
>> So is it a debug driver or not a debug driver?
>>
> 
> High frequency _diagnostic_ counters are a very useful tool for
> debugging a high performance chip. So yes this is for diagnostics/debug.
> 
>> Because I'm pretty sure some people want to have access to high freq
>> counters in production, across their fleet. What's worse David Ahern
>> has been pitching a way of exposing device counters which would be
>> common across netdev.
.

For context on the `what's worse ...` comment for those who have not
seen the netconf slides:
https://netdev.bots.linux.dev/netconf/2023/david.pdf

and I am having a hard time parsing Kuba's intent with that comment here
(knowing you did not like the pitch I made at netconf :-))


> 
> This is not netdev, this driver is to support ConnectX chips and SoCs
> with any stack, netdev/rdma/vdpa/virtio and internal chip units and
> acceleration engines, add to that ARM core diagnostics in case of
> Blue-Field DPUs.
> I am not looking for counting netdev ethernet packets in this driver.
> 
> I am also pretty sure David will also want an interface to access other
> than netdev counters, to get more visibility on how a specific chip is
> behaving.

yes, and h/w counters were part of the proposal. One thought is to
leverage userspace registered memory with the device vs mapping bar
space, but we have not moved beyond a theoretical discussion at this point.

> 
>> Definite nack on this patch.
> 
> Based on what ?

It's a generic interface argument?


