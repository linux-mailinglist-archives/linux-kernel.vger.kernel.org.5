Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C578DB97
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjH3SkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjH3SQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A01132;
        Wed, 30 Aug 2023 11:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F6B961CFD;
        Wed, 30 Aug 2023 18:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3576C433C7;
        Wed, 30 Aug 2023 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693419383;
        bh=TSAy/SHd+SvDS4iwv3tI4XLODuqMPzD59N5gfWt58t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+LTBiviG7Rn6pavN4JHbQs9/Wq/L66v8FN2xMUNqWSC73yFnpZE10w8TD4ovU5q4
         WUKOLAr0M3FDYs6DybUW72XCZXjHYCpLE/cBYKFREJFnbqdWsbqhNEAkYSLBGlBI2j
         ggfzDhh2aeUOrAzXrvfqkeRZet+PWYgzAWvtFJIc5bfFfOrQj9YXcAiSvQr5DfTVNm
         ZXVDLaFmmygQjp5TAZb6Sxyx44j8oUUlmimpj7ImU719wjbHvrLyBeTFKnipiKDX2i
         E+YnJHrOV6xJj2fqbQad1QvCoi5/UM8g9An/NZK27Zlcw6IKYjIHnxF9hHuTgXE74Z
         BVZNx4i52xVbg==
Received: (nullmailer pid 463580 invoked by uid 1000);
        Wed, 30 Aug 2023 18:16:21 -0000
Date:   Wed, 30 Aug 2023 13:16:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     Ben Levinsky <ben.levinsky@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Message-ID: <169341938045.463502.9445399366399743283.robh@kernel.org>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-2-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829181900.2561194-2-tanmay.shah@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Aug 2023 11:18:58 -0700, Tanmay Shah wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> UltraScale+ platform. It will help in defining TCM in device-tree
> and make it's access platform agnostic and data-driven.
> 
> Tightly-coupled memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> 
> The TCM resources(reg, reg-names and power-domain) are documented for
> each TCM in the R5 node. The reg and reg-names are made as required
> properties as we don't want to hardcode TCM addresses for future
> platforms and for zu+ legacy implementation will ensure that the
> old dts w/o reg/reg-names works and stable ABI is maintained.
> 
> It also extends the examples for TCM split and lockstep modes.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v4:
>   - Use address-cells and size-cells value 2
>   - Modify ranges property as per new value of address-cells
>     and size-cells
>   - Modify child node "reg" property accordingly
>   - Remove previous ack for further review
> 
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 +++++++++++++++---
>  1 file changed, 113 insertions(+), 18 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

