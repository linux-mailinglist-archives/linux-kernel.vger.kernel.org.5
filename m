Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FC7F3969
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjKUWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUWq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:46:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA0B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:46:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C4C433C8;
        Tue, 21 Nov 2023 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700606814;
        bh=yX4V4UGoITqpk2E1osXCSh2pJPJMs14QJsfn88pDby8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9Dj90iNyNJiGjwxGEgEQI6//qEfXkeHJdrw7XtEFmYzzsqC2w5HYdPrLm92GRn9J
         rsAKUG0TD7aPK5og8lcHcuyVipvDL4Mg7hZOBEmlLd8cuw6BLqYTQikGAOUdSnUmlW
         DXBJLM5iqvUWd3qbjsZeXRzVBRmiMANdZM7ZiB0oXveNwcNGUrR4LDDjvr5cADxqiC
         +JwnF28pLxCJFKecIYA7v4azz+dgPrzNpdTBBjHg0oHmu55Hy8kji9h2WjrLAm8mxa
         J0/ac4apq60YIupBPTIZILdb02aP2rV3JvYbtDjxwCCg1W+wZ9n0dO1+liPesAbK1e
         pz/M6p3yI9P2w==
Date:   Tue, 21 Nov 2023 14:46:52 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <ZV0zXBmINtopBvLQ@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-6-saeed@kernel.org>
 <20231121124456.7a6388c6@kernel.org>
 <ZV0bRpnhu/zWieTT@x130>
 <7ae9adff-5a6a-4ca6-983b-1d866dae9199@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7ae9adff-5a6a-4ca6-983b-1d866dae9199@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 14:18, David Ahern wrote:
>On 11/21/23 1:04 PM, Saeed Mahameed wrote:
>> On 21 Nov 12:44, Jakub Kicinski wrote:
>>> On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
>>>> high frequency diagnostic counters
>>>
>>> So is it a debug driver or not a debug driver?
>>>
>>
>> High frequency _diagnostic_ counters are a very useful tool for
>> debugging a high performance chip. So yes this is for diagnostics/debug.
>>
>>> Because I'm pretty sure some people want to have access to high freq
>>> counters in production, across their fleet. What's worse David Ahern
>>> has been pitching a way of exposing device counters which would be
>>> common across netdev.
>.
>
>For context on the `what's worse ...` comment for those who have not
>seen the netconf slides:
>https://netdev.bots.linux.dev/netconf/2023/david.pdf
>
>and I am having a hard time parsing Kuba's intent with that comment here
>(knowing you did not like the pitch I made at netconf :-))
>
>
>>
>> This is not netdev, this driver is to support ConnectX chips and SoCs
>> with any stack, netdev/rdma/vdpa/virtio and internal chip units and
>> acceleration engines, add to that ARM core diagnostics in case of
>> Blue-Field DPUs.
>> I am not looking for counting netdev ethernet packets in this driver.
>>
>> I am also pretty sure David will also want an interface to access other
>> than netdev counters, to get more visibility on how a specific chip is
>> behaving.
>
>yes, and h/w counters were part of the proposal. One thought is to
>leverage userspace registered memory with the device vs mapping bar
>space, but we have not moved beyond a theoretical discussion at this point.
>
>>
>>> Definite nack on this patch.
>>
>> Based on what ?
>
>It's a generic interface argument?
>

For this driver the diagnostic counters is only a small part of the debug
utilities the driver provides, so it is not fair to nak this patch based
on one use-case, we need this driver to also dump other stuff like
core dumps, FW contexts, internal objects, register dumps, resource dumps,
etc ..

This patch original purpose was to allow core dumps, since core dump can go
up to 2MB of memory, without this patch we won't have core dump ability
which is more important for debugging than diagnostic counters.

You can find more here:
https://github.com/saeedtx/mlx5ctl#mlx5ctl-userspace-linux-debug-utilities-for-mlx5-connectx-devices

For diagnostic counters we can continue the discussion to have a generic
interface I am all for it, but it's irrelevant for this submission.

