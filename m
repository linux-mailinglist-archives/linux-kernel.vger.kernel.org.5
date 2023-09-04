Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FBC791362
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjIDI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjIDI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:26:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ADB8D8;
        Mon,  4 Sep 2023 01:26:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00D9711FB;
        Mon,  4 Sep 2023 01:27:31 -0700 (PDT)
Received: from [10.57.91.85] (unknown [10.57.91.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0633F8A4;
        Mon,  4 Sep 2023 01:26:50 -0700 (PDT)
Message-ID: <59bf237d-1645-8c44-94f2-72a0cf229595@arm.com>
Date:   Mon, 4 Sep 2023 09:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
To:     Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sgoutham@marvell.com,
        gcherian@marvell.com
References: <20230904050548.28047-1-lcherian@marvell.com>
 <20230904050548.28047-2-lcherian@marvell.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230904050548.28047-2-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 06:05, Linu Cherian wrote:
> memory-region 0: Reserved trace buffer memory
> 
>    TMC ETR: When available, use this reserved memory region for
>    trace data capture. Same region is used for trace data
>    retention after a panic or watchdog reset.
> 
>    TMC ETF: When available, use this reserved memory region for
>    trace data retention synced from internal SRAM after a panic or
>    watchdog reset.
> 
> memory-region 1: Reserved meta data memory
> 
>    TMC ETR, ETF: When available, use this memory for register
>    snapshot retention synced from hardware registers after a panic
>    or watchdog reset.

Instead of having to use a number to map the memory regions, could
we use

memory-region-names property to describe the index ? That way it
is much easier to read and is less error prone.

Names could be something like:

tmc-reserved-trace
tmc-reserved-metadata

Suzuki

> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../devicetree/bindings/arm/arm,coresight-tmc.yaml  | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> index cb8dceaca70e..dce54978554a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> @@ -101,6 +101,17 @@ properties:
>             and ETF configurations.
>           $ref: /schemas/graph.yaml#/properties/port
>   
> +   memory-region:
> +    items:
> +      - description: Reserved trace buffer memory for ETR and ETF sinks.
> +        For ETR, this reserved memory region is used for trace data capture.
> +        Same region is used for trace data retention as well after a panic
> +        or watchdog reset.
> +        For ETF, this reserved memory region is used for retention of trace
> +        data synced from internal SRAM after a panic or watchdog reset.
> +
> +      - description: Reserved meta data memory. Used for ETR and ETF sinks.
> +
>   required:
>     - compatible
>     - reg
> @@ -115,6 +126,8 @@ examples:
>       etr@20070000 {
>           compatible = "arm,coresight-tmc", "arm,primecell";
>           reg = <0x20070000 0x1000>;
> +        memory-region = <&etr_trace_mem_reserved>,
> +                       <&etr_mdata_mem_reserved>;
>   
>           clocks = <&oscclk6a>;
>           clock-names = "apb_pclk";

