Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69B7BF680
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjJJIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJJIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A9A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:52:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0F4C433C8;
        Tue, 10 Oct 2023 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696927933;
        bh=XJynC3FVhVB5RPnfUzpYV78TXawY3XcAs4e1JfEyljQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o9wwu4UrznOZpfdZX7oqvMRLJk0mD61f6BIJ1INfdsdsymjZ4gRjo9Kau+5y3AYwm
         qs2/Fa4+Gj31ZGOFprfnW5V3dOP5sgf2zwrH5YNSmKXVbK3rw3OP0Grgh5BBhLEjMQ
         FibLRVELC/hZ9uJwGh7FMqtQcGRqgUPOBFn1Dky0eHFf6BMlcaKQ1Zkb98qPYHnYk5
         7yUtWh6ThBgm+wL2J5pRpDspCijDnRd8AjRiJ0Xl87C2plDpV5hxwHDxAlb7nC2QQk
         ++zDF65ChxJxHfm1/6NxL0vEnYZ6LAEpyWSh7PyluUgp8Vo0400KOYDhlXpkHEAOjr
         KCCwrv6n09xVQ==
Message-ID: <74a4dc35-eed2-79c2-2b57-ed0857cbc96a@kernel.org>
Date:   Tue, 10 Oct 2023 10:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] spmi: mtk-pmif: Serialize PMIF status check and
 command submission
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@google.com>, kernel@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230724154739.493724-1-nfraprado@collabora.com>
 <a4684a81-eb04-492a-bff6-a5ff78fe6b0f@notapiano>
 <7b407eda-702a-444a-b644-5e8dc31f3991@notapiano>
From:   AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
In-Reply-To: <7b407eda-702a-444a-b644-5e8dc31f3991@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/23 22:12, Nícolas F. R. A. Prado ha scritto:
> On Thu, Aug 10, 2023 at 06:03:53PM -0400, Nícolas F. R. A. Prado wrote:
>> On Mon, Jul 24, 2023 at 11:47:33AM -0400, Nícolas F. R. A. Prado wrote:
>>> Before writing the read or write command to the SPMI arbiter through the
>>> PMIF interface, the current status of the channel is checked to ensure
>>> it is idle. However, since the status only changes from idle when the
>>> command is written, it is possible for two concurrent calls to determine
>>> that the channel is idle and simultaneously send their commands. At this
>>> point the PMIF interface hangs, with the status register no longer being
>>> updated, and thus causing all subsequent operations to time out.
>>>
>>> This was observed on the mt8195-cherry-tomato-r2 machine, particularly
>>> after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
>>> drivers between 5.10 and 5.15") was applied, since then the two MT6315
>>> devices present on the SPMI bus would probe assynchronously and
>>> sometimes (during probe or at a later point) read the bus
>>> simultaneously, breaking the PMIF interface and consequently slowing
>>> down the whole system.
>>>
>>> To fix the issue at its root cause, introduce locking around the channel
>>> status check and the command write, so that both become an atomic
>>> operation, preventing race conditions between two (or more) SPMI bus
>>> read/write operations. A spinlock is used since this is a fast bus, as
>>> indicated by the usage of the atomic variant of readl_poll, and
>>> '.fast_io = true' being used in the mt6315 driver, so spinlocks are
>>> already used for the regmap access.
>>>
>>> Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> Hi,
>>
>> gentle ping on this one. MT8195 Chromebooks sometimes boot to a broken state
>> without it.
> 
> Hi Stephen,
> 
> once again kindling reminding you of this important fix for MediaTek platforms,
> solving a real issue impacting basic functionality observed on the MT8195
> Chromebook.
> 

Hello Stephen,

can you please pick this one ASAP?
MT8195 is broken without.

Thanks,
Angelo
