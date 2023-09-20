Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5B7A73DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjITHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjITHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5F93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:20:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8814C433C8;
        Wed, 20 Sep 2023 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695194435;
        bh=H9wVKjvGVPXXyFE5kDB/IAFjYiewUvn32o8qyJzBTF0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fcvEFv9seiEaFxmdc9Dzr6HbMB0HFveSkjQztghfL8LG56IX4FfV7nIutdTAjFjpD
         Sy2TPMuvHBZf1hcqgndCq2RbRolD+tlnnFyPG/LWe2fPd5rV/6INK794pM6O7pjJG5
         RegCcH9Ytk7MHCoy0dPamWTmbfOvJOQshQkBMeSqSD1uMXSdvLnxf32E/0ZADpewD5
         /nepXRsalCOinA0DuJxO6mRK7wkqoFFENfyDxScmLfRFhr6Gs/u945MasSyNmz4fvV
         HsgPwjdUBZ/+Sp7N+tZHFuOzNjbWXfgCeldyxiRXPy2+yVZ4EsnHi9d4TqTrnotQBX
         fh5C1Qr16a38Q==
Message-ID: <5a4eb30b-6842-0512-56d5-23cb52c1f4ee@kernel.org>
Date:   Wed, 20 Sep 2023 10:20:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption
 MAC Merge support
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918095346.91592-1-rogerq@kernel.org>
 <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/2023 16:13, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 12:53 +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>>  5 files changed, 454 insertions(+), 47 deletions(-)
>>
>> Changelog:
>>
>> v3:
>> - Rebase on top of v6.6-rc1 and mqprio support [1]
> 
> I'm unsure if this will require a rebase for the next revision of the
> mqprio support. Anyhow the two patches are related, it's probably
> better bundle them in a series so that the dep is straight-forward.

Good idea.

> 
> When reposting, please insert the target tree in the subject profix
> (net-next in this case).

My bad. I will add. Thanks.

-- 
cheers,
-roger
