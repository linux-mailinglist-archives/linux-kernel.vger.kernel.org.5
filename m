Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1FA7BFFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJJOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjJJOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:51:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE81399;
        Tue, 10 Oct 2023 07:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B0C433C7;
        Tue, 10 Oct 2023 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696949482;
        bh=SmnMtoX0iHU4aj5Y/R+pD8vcwMWh9G5W6HyDrrmUaTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeGBwgxuRrY08gx0uXxKezhZHvPEPEw/4QLhYDwSKKTa0vpeOO6RTR0zMcg4eEOHP
         d3VtSsIyWMTSrjpMkqO2K2SPwnyWeDTETtB3Z4XTCJj7ctLw3qvlkR4UO04E5kO8ZC
         ikptBekNtPknPLqcNVgtNla3AQA4BT24Bq33oQK7Wm7s20Bz+lTN+rszpMxMpx5mhz
         cINn3zfdjFkdglmiM4N80t7YJy3W81aD6xkcqHkdfzWmuv5MB4QRGOu8IbqIczS6H5
         Y5/DqrALMDcbLRHRf9TIrRzA1ksYtAanuom2KZXb2W1j9agxg2wRogB0DlVupRFLBC
         csJJ0bWJusT5w==
Received: (nullmailer pid 864750 invoked by uid 1000);
        Tue, 10 Oct 2023 14:51:20 -0000
Date:   Tue, 10 Oct 2023 09:51:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] clk: si5351: add option to adjust PLL without
 glitches
Message-ID: <20231010145120.GA847407-robh@kernel.org>
References: <20231008111324.582595-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008111324.582595-1-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 01:09:36PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> This series intends to address a problem I had when using the Si5351A as
> a runtime adjustable audio bit clock. The basic issue is that the driver
> in its current form unconditionally resets the PLL whenever adjusting
> its rate. But this reset causes an unwanted ~1.4 ms LOW signal glitch in
> the clock output.
> 
> As a remedy, a new property is added to control the reset behaviour of
> the PLLs more precisely. In the process I also converted the bindings to
> YAML.
> 
> Changes:
> 
> v2 -> v3:
> 
> - address further comments from Rob:
>   - drop unnecessary refs and minItems
>   - simplify if conditions for chip variants
>   - ignore his comment about dropping '|', as line would be >80 columns

I've commented on v2 again.

>   - move additionalProperties: false close to type: object
>   - define clocks/clock-names at top-level
> - drop patch to dove-cubox dts per Krzysztof's comment - will send
>   separately
> - collect Sebastian's Acked-by
> 
> v1 -> v2:
> 
> - address Rob's comments on the two dt-bindings patches
> - new patch to correct the clock node names in the only upstream device
>   tree using si5351
> 
> Alvin Šipraga (3):
>   dt-bindings: clock: si5351: convert to yaml
>   dt-bindings: clock: si5351: add PLL reset mode property
>   clk: si5351: allow PLLs to be adjusted without reset
> 
>  .../bindings/clock/silabs,si5351.txt          | 126 --------
>  .../bindings/clock/silabs,si5351.yaml         | 268 ++++++++++++++++++
>  drivers/clk/clk-si5351.c                      |  47 ++-
>  include/linux/platform_data/si5351.h          |   2 +
>  4 files changed, 314 insertions(+), 129 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> 
> -- 
> 2.42.0
> 
