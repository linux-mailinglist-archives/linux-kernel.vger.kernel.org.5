Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2065E7BB4FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJFKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9049F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32291C433C8;
        Fri,  6 Oct 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696587628;
        bh=HROclaK6r3y0yFk9TokwoZ6XEm64wKXtyBPv2Q10kRk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TaJU+oGpsACxrifb0h7idG4NDC0Pc24/PbaP2YXLUWYcAgF92r48mzx8QM/MN4OER
         vqhszv9aw9nzdpk+XzM7NuVTXDu+4Oc0cVCUuI/LMkjvfQ/NYT6n/MEWnVre1BzX9c
         qPiIOCFjSK1YF9uj1z4Wr5RJCRxO3Ax5RxXXT15dmtAz1jUqOtw+3CQ/q0UEwStAHb
         sO4AfPro61clSUUO8czL4NjPfyVCQZo8EbgZHVrn82K4n7aU83esQpBcvajY+Y3sMp
         5Pem0OHvIXgDI9LhPThnWqyroSL7sO/UN6Wq5j3O2tRdkb2BnWTSakQzkaIBV0afjt
         A8sbigVEFEAHw==
Message-ID: <77701023-7bd1-4e04-aa44-0e46aa087c4f@kernel.org>
Date:   Fri, 6 Oct 2023 13:20:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v11 0/5] Enable Display for J784S4 and AM69-SK
 platform
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com
Cc:     afd@ti.com, s-vadapalli@ti.com, conor+dt@kernel.org,
        r-ravikumar@ti.com, sabiya.d@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231005132732.7462-1-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231005132732.7462-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/2023 16:27, Jayesh Choudhary wrote:
> This series adds support for:
> - DisplayPort for J784S4-EVM
> - Displayport and HDMI for AM69-SK platform
> 
> NOTE: Patch 4/5 introduces the following dtc warning which can be ignored
> since its behind W=1 check:
> Warning (graph_child_address): /bus@100000/dss@4a00000/ports: graph node
> has single child node 'port@0', #address-cells/#size-cells are not
> necessary
> 
> (This is more accurate description for port and the dtc check should not
> differentiate between port@0 and port@1.[0])
> 
> Changelog v10->v11:
> - Added comment for disabling serdes-refclk (according to comments of v5)
> - Update commit message to document why serdes, wiz nodes (2/5) and mhdp-
>   bridge, tidss nodes (3/5) are disabled.
> - Keep only ports in board files and move common properties to main file
>   and document why ports are kept empty.
> 
> v10: https://lore.kernel.org/all/20230927121157.278592-1-j-choudhary@ti.com/
> 
> Changelog v9->v10:
> - Remove duplicate properties from dp0_ports node in main file.
> - Add reg for the port even though there is only single port in dss_port
>   since its more accurate description for the port.
> - Carry the R-by tags from v9.
> 
> v9: https://lore.kernel.org/all/20230803080441.367341-1-j-choudhary@ti.com/
> 
> Changelog v8->v9:
> - Fix compatible of serdes_ln_ctrl node
> - Fix extra new lines across nodes
> - Fix node-names to keep them generic
> 
> v8: https://lore.kernel.org/all/20230801070019.219660-1-j-choudhary@ti.com/
> 
> Changelog v7->v8:
> - rebase on tag next-20230731
> - add AM69 display support
> - fix commit heading for patch [2/5]
> 
> v7: https://lore.kernel.org/all/20230728050859.7370-1-j-choudhary@ti.com/
> 
> Changelog v6->v7:
> - change compatible for scm_conf to 'simple-bus'
> - drop main_cpsw node due to driver dependency on [1]
> 
> v6: https://lore.kernel.org/all/20230721132029.123881-1-j-choudhary@ti.com/
> 
> Changelog v5->v6:
> - Change header file according to [2].
> - Add idle-state property in serdes_ln_ctrl node.
> - Fix dtbs_check warning due to clock-frequency property in serdes_refclk
>   node by disabling the node in main.dtsi and enabling it in board file
>   when the clock-frequency node is actually added.
> 
> v5: https://lore.kernel.org/all/20230710101705.154119-1-j-choudhary@ti.com/
> 
> Changelog v4->v5:
> - rebased the patches on linux-next tip.
> 
> v4: https://lore.kernel.org/all/20230425131607.290707-1-j-choudhary@ti.com/
> 
> Changelog v3->v4:
> - add reg property to serdes_ln_ctrl and fix the node name again to
>   get rid of dtbs_check error.
> - reorder reg, reg-names and ranges property for main_cpsw1.
> - correct the order for clocks in serdes_wiz nodes to fix dtbs_check
>   warnings.
> - fix indentation in reg, reg-names and clock property for dss node.
> - add comments for the reg type in dss registers.
> 
> v3: https://lore.kernel.org/all/20230419061710.290068-1-j-choudhary@ti.com/
> 
> Changelog v3->v2:
> - fix dtc warnings for 'scm_conf' and 'serdes_ln_ctrl' nodes
>   (Checked all the changes of the series with W=12 option during build)
> - added clock-frequency for serdes_refclk along with other EVM changes
>   This refclk is being used by all the instances of serdes_wiz which
>   are disabled by default. So configuring refclk when the serdes nodes
>   are used for the first time is okay.
> 
> v2: https://lore.kernel.org/all/20230414151553.339599-1-j-choudhary@ti.com/
> 
> Changelog v1->v2:
> - Moved J784S4 EVM changes together to the last patch
>   (Suggested by Andrew)
> 
> v1: https://lore.kernel.org/all/20230405111412.151192-1-j-choudhary@ti.com/
> 
> 
> [0]: <https://lore.kernel.org/all/570903b6-8239-d44a-5fac-71700804cb5d@ti.com/>
> [1]: <https://lore.kernel.org/all/20230605154153.24025-1-afd@ti.com/>
> [2]: <https://lore.kernel.org/all/20230721125732.122421-1-j-choudhary@ti.com/>
> 
> Dasnavis Sabiya (1):
>   arm64: dts: ti: k3-am69-sk: Add DP and HDMI support
> 
> Rahul T R (2):
>   arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>   arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0
> 
> Siddharth Vadapalli (2):
>   arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
>     mux
>   arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES PHY nodes
> 
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts      | 229 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 119 +++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 276 +++++++++++++++++++++
>  3 files changed, 624 insertions(+)
> 

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>
