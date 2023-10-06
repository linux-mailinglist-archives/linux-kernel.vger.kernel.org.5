Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDECC7BBE21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJFR5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJFR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:56:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC178106;
        Fri,  6 Oct 2023 10:56:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AAFC433C8;
        Fri,  6 Oct 2023 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696615017;
        bh=M7cM0uzrZk4lKMKjA93C2oMjoATI9WLt5iEp4Pa0My4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExVRjuA7T/H0LaeJ0jyf3NZMtrc0lM6wOK+ekvS3Hq8ZCLXMYeoBcRONIckkYnR9e
         R9KWM6wDzcE5q6jwvZF8lMhKkQ1lgD5XgMAmF7JJPxu8HLrXCruZvJdtW+N4EFMC/7
         +MgEyPdqIsG0GVwqs1Zo00lHWuag9pWExwjTRXjr6/1rfLAWPo85X4OULjN1ooa7MU
         QE2wvKipHSHuTUa2DvBuP+DGUrlVwrPA7dr5beW5tSBoKlXJNaQzu4hKecZwWebxPT
         cSOeYmHLA64elgkUGOYkMirnChTWEZcTn5lG+t94KgeZRNsGwZCdyYGcGdRGZ4Z1JF
         KS5ex2P3lOVhA==
Received: (nullmailer pid 70487 invoked by uid 1000);
        Fri, 06 Oct 2023 17:56:54 -0000
Date:   Fri, 6 Oct 2023 12:56:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: pinctrl: st,stm32: fix phandle-array warning
Message-ID: <169661501435.70432.16755877986670034633.robh@kernel.org>
References: <20231006082247.3830719-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006082247.3830719-1-martin@kaiser.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 10:22:48 +0200, Martin Kaiser wrote:
> make CHECK_DTBS=y st/stm32f469-disco.dtb
> 
> brings up a warning about a missing argument:
> 
> stm32f469-disco.dtb: pinctrl@40020000: st,syscfg:0: [21, 8] is too short
> 
> The description of the third entry indicates that this entry is optional.
> The code in stm32_pctrl_dt_setup_irq parses st,syscfg and treats the third
> entry as optional. It defaults to 0xf if not present in the devicetree.
> 
> Update the schema to require at least two entries, use the same syntax as
> the description of renesas,ipmmu-main in
> Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> 
> I tested the following cases, all of them returned the expected result:
> 
>    st,syscfg = <&syscfg>;              (too short)
>    st,syscfg = <&syscfg 0x8>;          (ok)
>    st,syscfg = <&syscfg 0x8 0x0>;      (ok)
>    st,syscfg = <&syscfg 0x8 0x0 0x0>;  (too long)
> 
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

