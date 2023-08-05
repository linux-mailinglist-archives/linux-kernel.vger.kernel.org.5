Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A573A7710C6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHERIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHERIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371DBE51;
        Sat,  5 Aug 2023 10:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB8260C5C;
        Sat,  5 Aug 2023 17:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11474C433C8;
        Sat,  5 Aug 2023 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691255330;
        bh=UDpdizPzwcEtTB868pvFDtGqqjiMNLIEy5YgD8LrlUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R9e2SNXn2PAQ1ttmi95R7I9gJ26yqrEtZSG00/s926uZ5WnVgTur5S5QSzbd5MP5N
         eOoOPWD/S1HhQ6I++Jwc9btvR04aqjPZ/VmDw9Hqgq6IV+qxN253lrueQbeFmKQVKV
         gv5ermbiwIh90d5zLNrwtj0t6v3gs0poNkk1+sTt57+8RrS3Nw2kc5ggdlLloh9j6t
         vxC4r8WVA2aklnmXNoPKLsY9lLcvRps4mdl8yz1jgMTK1vRUVN6ymHJgU8bJDcv71C
         W0ZpSmbNfYLcCBxK4k8Yr3hyD0KUovIiPaTRk9OyQ/RkEq1hby4pPwnq2qB2MXeasq
         A3VmKsgJFgE+g==
Date:   Sat, 5 Aug 2023 18:08:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Adding support for Microchip MCP3564 ADC family
Message-ID: <20230805180842.5d0a2005@jic23-huawei>
In-Reply-To: <20230804142820.89593-1-marius.cristea@microchip.com>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 17:28:18 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> Adding support for Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface. This driver covers the following part
> numbers:
>  - MCP3561, MCP3562, MCP3564, MCP3561R, MCP3562R, MCP3564R,
>  - MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R and MCP3464R.
> 
> Differences related to previous patch:
> v3:
> - fix review comments:
>   - fix and update the device tree bindings
>   - enable "auto_zeroing_ref_enable" attribute only
>     when internal reference is used
>   - remove unused headers
>   - fix comments (kernel-docs)
>   - remove scan_type
>   - replace "extend_name" with read_label
>   - print label for each channel (label could be added into the dt)
>   - add comment to explain the maximum channels numbers
>   - add protection around critical region
>   - fallback compatible in device tree to deal with some newer part number
>   
> - Open questions:
>   - whether or not to add a spi-mux type of thing to deal with the part number
>     address in case there are multiple devices connected to the same chip
>     select.

I'd failed to register (until noticing it in a review a few mins ago) that we have
have precedence for devices doing this device-address in the SPI transfer thing.
The mcp3911 does it as well.  Obviously that doesn't rule out us doing something
different with this one though.  

I think we should take the view this is relatively uncommon and go with this
simple vendor specific dt-binding approach.  Always nice to do something more
general, but sometimes it isn't worth the effort.


>   - discussion related to the "custom property". Last time around a consensus
>     wasn't reached. 
> 
> v2:
> - fix review comments:
>   - change the device tree bindings
>   - change the ADC channel creation (starting from DT)
>   - use defines, masks and FIELD_PREP() instead of hardcoded values
>   - mode the PGA from Hardware Gain to scale
>   - add a current output channel from burnout current
>   - fix coding style issues
>   - use self-explanatory naming to drop the comment 
> - renumbered the versioning (start with v1 instead of v0)
> 
> v1:
> - first version committed to review
> 
> Marius Cristea (2):
>   dt-bindings: iio: adc: adding MCP3564 ADC
>   iio: adc: adding support for MCP3564 ADC
> 
>  .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
>  .../bindings/iio/adc/microchip,mcp3564.yaml   |  200 +++
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/mcp3564.c                     | 1541 +++++++++++++++++
>  6 files changed, 1815 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
>  create mode 100644 drivers/iio/adc/mcp3564.c
> 
> 
> base-commit: 9e66fb52449538406cea43e9f3889c391350e76e

