Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236777B5859
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjJBQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJBQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:32:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62949A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:32:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA28C433C7;
        Mon,  2 Oct 2023 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696264366;
        bh=PjHXjJrymy9E1ifabnA+7L10wdhWj8PEINNxVQa+mtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKBVbRBbLIgROEbdXK769s8qOn8qHBhmF9JHZtDXFvK33SQKUFixcq9fz+PbKTwBf
         4tHxVyKq+XK+TncmoflVtynqR93eEPC9AiIPutFyylvzyvjaMQxv5YSwLJ8Dth5sqn
         R5DEhs72ruuoQysq4ONAAZwN5/u1JON1Z70V2bJGfN4oqmFdBvVMfHBHc2fevrhvSK
         NvE7awwlCR+hm+t2FG4icbFsM0qv8I/NXodyU4IYQD5pSyS9r6PtY8SkFhi+J5WF+B
         1cZAwkP99SC6yTCj78gXQPge4HVpBWLYBo3k6EICLo9EFK02kEqCLWyeRAMgVwZzgw
         WBei2x9IUBUQQ==
Received: (nullmailer pid 1903151 invoked by uid 1000);
        Mon, 02 Oct 2023 16:32:44 -0000
Date:   Mon, 2 Oct 2023 11:32:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Message-ID: <20231002163244.GA1886905-robh@kernel.org>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928092804.22612-2-eliza.balas@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:28:03PM +0300, Eliza Balas wrote:
> Add device tree documentation for the AXI TDD Core.
> The generic TDD controller is in essence a waveform generator
> capable of addressing RF applications which require Time Division
> Duplexing, as well as controlling other modules of general
> applications through its dedicated 32 channel outputs.
> 
> The reason of creating the generic TDD controller was to reduce
> the naming confusion around the existing repurposed TDD core
> built for AD9361, as well as expanding its number of output
> channels for systems which require more than six controlling signals.
> 
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> ---
>  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> new file mode 100644
> index 000000000000..8938da801b95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/adi,axi-tdd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI TDD Core
> +
> +maintainers:
> +  - Eliza Balas <eliza.balas@analog.com>
> +
> +description: |
> +  The TDD controller is a waveform generator capable of addressing RF
> +  applications which require Time Division Duplexing, as well as controlling
> +  other modules of general applications through its dedicated 32 channel
> +  outputs. It solves the synchronization issue when transmitting and receiving
> +  multiple frames of data through multiple buffers.
> +  The TDD IP core is part of the Analog Devices hdl reference designs and has
> +  the following features:
> +    * Up to 32 independent output channels
> +    * Start/stop time values per channel
> +    * Enable and polarity bit values per channel
> +    * 32 bit-max internal reference counter
> +    * Initial startup delay before waveform generation
> +    * Configurable frame length and number of frames per burst
> +    * 3 sources of synchronization: external, internal and software generated
> +  For more information see the wiki:
> +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-tdd-2.00.a

Where does this version number come from? I looked at the above link and 
see versions such as '2021_R2', '2019_r2', etc. I didn't dig deeper 
whether there's some per IP version.

If you want to use version numbers, please document the versioning 
scheme. For example, see 
Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt.

Rob
