Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A37FC2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjK1Qv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjK1Qv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:51:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DDD4B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:52:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A6C433C8;
        Tue, 28 Nov 2023 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701190322;
        bh=GW4XIkaMDJZ63oG/z6tnggU5ESaXaU0eLAirvy2qaoo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SU+aHa6paqlU5a2RUYypewI8ISrvrQ/kZ88NCv5CrHyLJKUOeXT3TdueR2Z+BJTov
         xi/o2uR6UaKDEa/4QzTa2Li2i47FjO+FqfARSXSok20HF8S1l58kOtUWZqzgfk279z
         rqFhPS0pVdrqskeczdCoGZAppWNyyIILsKpPlHYPXmvUe5E0+u5KuOCPrxUekUzM4f
         TwTysbdoLweQv3J0CX9TeQAkP5tGGx5BNeJDMk2PoJXsumitne5rsEMT6Am3H9A6Qy
         PefUbi2XP0TZP9Dm+bW0SRcexWBNCqTCxJxnXYgqQLVS9LEQUWO91qBJ39wPgkL62s
         YoIJ2vpU78ISA==
Message-ID: <a0b5bd9d-2675-498e-aed0-f97d18df334e@kernel.org>
Date:   Tue, 28 Nov 2023 09:52:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh> <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh> <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh> <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org> <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231128065321.53d4d5bb@kernel.org>
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

On 11/28/23 7:53 AM, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 21:46:28 -0700 David Ahern wrote:
>>> You keep saying "debug information" which is really underselling this
>>> driver. Are you not going to support mstreg?
>>>
>>> The common development flow as far as netdev is concerned is:
>>>  - some customer is interested in a new feature of a chip
>>>  - vendor hacks the support out of tree, using oot module and/or
>>>    user space tooling
>>>  - customer does a PoC with that hacked up, non-upstream solution
>>>    - if it works, vendor has to find out a proper upstream API,
>>>      hopefully agreed on with other vendors
>>>    - if it doesn't match customer needs the whole thing lands in the bin
>>>
>>> If the vendor specific PoC can be achieved with fully upstream software
>>> we lose leverage to force vendors to agree on common APIs.  
>>
>> Please elaborate on what "common" API there is to create here?
> 
> Damn, am I so bad at explaining basic things or y'all are spending
> 5 seconds reading this and are not really paying attention? :|
> 
>> Do you agree that each ASIC in the device is unique and hence will
>> have made different trade offs - both features and nerd knobs to tune
>> and affect the performance and runtime capabilities? If you do not
>> agree, then we need to have a different discussion ...
>> If you do, please elaborate on the outline of some common API that
>> could possibly be done here.
> 
> We have devlink params. If that doesn't scale we can look for other
> solutions but let's see them not scale _in practice_ first.
> 
>> You said no to the devlink parameters as a way to tune an ASIC.
> 
> What? When?

Jason responded with the same LPC reference, so I will only add a
reference to the slides for interested parties:

https://lpc.events/event/16/contributions/1359/attachments/1092/2094/FW-Centric-devices.pdf

> 
> Sounds like you'd like a similar open-ended interface for your device.

That's the danger of chiming in on threads like this - people drawing
conclusions they should not.

My interest on this thread is along the same lines for commenting during
both the LPC 2022 discussion and again at netconf this year - trying to
understand and keep track of the strongly held opinions of maintainers
and what options are deemed off limits for similar needs. No vendor
wants to go in circles redesigning and rewriting s/w.
