Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC37F9CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjK0J7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjK0J7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:59:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71332E1;
        Mon, 27 Nov 2023 01:59:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE6D42F4;
        Mon, 27 Nov 2023 02:00:03 -0800 (PST)
Received: from [10.57.4.90] (unknown [10.57.4.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4BE3F73F;
        Mon, 27 Nov 2023 01:59:14 -0800 (PST)
Message-ID: <8aa2592d-5fc7-4ae2-a355-fcf46bb076de@arm.com>
Date:   Mon, 27 Nov 2023 10:00:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to
 rk3399 GPU
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
 <14787054.VsHLxoZxqI@diego>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <14787054.VsHLxoZxqI@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 11/27/23 09:42, Heiko Stübner wrote:
> Hi Lukasz,
> 
> Am Montag, 27. November 2023, 09:15:11 CET schrieb Lukasz Luba:
>> Add dynamic-power-coefficient to the GPU node. That will create Energy
>> Model for the GPU based on the coefficient and OPP table information.
>> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
>> In similar way the Energy Model for CPUs in rk3399 is created, so both
>> are aligned in power scale. The maximum power used from this coefficient
>> is 1.5W at 600MHz.
> 
> 2640 is a pretty arbitary value, so it would be really helpful to describe
> in the commit message, how you arrived with that specific value.

It's in the above patch header. The power at 600MHz is ~1.5Watts, so for
max freq and max voltage you get the coefficient. The DT schema
describes quite well how the coefficient is calculated. IMO, there is no
need to duplicate that description here [1].

Have you checked that documentation? Is there still anything unclear?
I might elaborate a bit more why it's important for GPU to take the top
OPP for considerations (due to thermal operating mostly on top-half
OPPs, but the curve is a bit constraining). Unfortunately, this simple
model doesn't allow to reflect the leakage impact over time. It doesn't
also address the chip binning lottery. Although, it will be possible in
near future to address those [2].

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml#L94
[2] 
https://lore.kernel.org/lkml/20230925081139.1305766-1-lukasz.luba@arm.com/

