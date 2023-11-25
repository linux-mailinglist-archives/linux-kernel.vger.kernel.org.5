Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7307F8A36
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjKYLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:36:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38DD41
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:36:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4989AC433C7;
        Sat, 25 Nov 2023 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700912183;
        bh=aCwCQvlfp9RlSvy/8J0HTVolXv3WTuhEcuknlDUIbko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pZxw/pfQvVAlZYNi2K0gVG5mHhMKiATOenG9idjwmEqla54ee+Dajv1wLTV7OlNup
         /KkLSouuwAwxp2jQljbURTM2EDN5gqsZ1Ixi6ewNOF3nogJQZ7mb/IJ3J3aJORex6D
         /b4Rpg9P6n/FECD4vMXelSwFffToD1cFcqh17e5oMgGGk2uIDNobxnAgBIDWlr32EE
         EJcGDxM1LHdx6JKOrDJPNqatQaTiOAsspLKCwa6v/9g0SjglExjMgMEa2AMFviF3+F
         2O4f+3jeTMkRgdyACtsaCJWll3p7rKUXpmKWX2B+hhNittRpNuZdlaq5HKs9hbon6x
         C0eidqIl4PGow==
Date:   Sat, 25 Nov 2023 11:36:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add MCP4821
Message-ID: <20231125113617.4d626bb2@jic23-huawei>
In-Reply-To: <20231117073040.685860-1-anshulusr@gmail.com>
References: <20231117073040.685860-1-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 13:00:37 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Adds support for MCP48xx series of DACs.
> 
> Datasheet:
>   [MCP48x1] https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
>   [MCP48x2] https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
Hi Anshul,

Usually we mark vdd-supply as required given I guess device doesn't work
without a supply. Obviously we don't actually have to provide it in a binding
if the supply is always on and we are fine with a stub regulator being
provided by the regulator subsystem.

There was some discussion about this a while back and conclusion was
mark them required in bindings anyway.  We haven't yet updated this in all
the older IIO bindings and it's a minor thing, but given the build warning
on patch 2 you are going around again so might as well tidy that up!

Jonathan


> ---
>  .../bindings/iio/dac/microchip,mcp4821.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> new file mode 100644
> index 000000000000..904de15300bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4821 and similar DACs
> +
> +description: |
> +  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series of DACs.
> +  Device supports simplex communication over SPI in Mode 0,1 and Mode 1,1.
> +
> +  +---------+--------------+-------------+
> +  | Device  |  Resolution  |   Channels  |
> +  |---------|--------------|-------------|
> +  | MCP4801 |     8-bit    |      1      |
> +  | MCP4811 |    10-bit    |      1      |
> +  | MCP4821 |    12-bit    |      1      |
> +  | MCP4802 |     8-bit    |      2      |
> +  | MCP4812 |    10-bit    |      2      |
> +  | MCP4822 |    12-bit    |      2      |
> +  +---------+--------------+-------------+
> +
> +  Datasheet:
> +    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
> +    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4801
> +      - microchip,mcp4811
> +      - microchip,mcp4821
> +      - microchip,mcp4802
> +      - microchip,mcp4812
> +      - microchip,mcp4822

Whilst I understand the reasoning of keeping these grouped by number of channels,
I'd still rather see them in numeric order here and probably also in the table above.
Given that grouping by resolution rather than channels would also be a valid choice,
I don't see a strong reason to keep them out of order.

Also, manufacturers often get creative with numbering (when they run of out of digits
for example - maybe they'll do a 16 channel variant one day and then be stuck) so
trying to group things is often a loosing game long term!

Jonathan


>
