Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9E79D491
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjILPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjILPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:15:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A071BB;
        Tue, 12 Sep 2023 08:15:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA55C433C7;
        Tue, 12 Sep 2023 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531737;
        bh=OG76LHlfGJHYkxKaHllr4SLoZMBHB960bsox/kYXmQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo+6QA32tcA7Rmixlq1ZvNMqSHv0isoNpqQxy0GgmprY4fbhbLrRgt8ivlBvhAxAU
         8IxOb8YTUm3dF83yoL4BRsbMd6Oo5o7cgCzx/z1+X9yiQeW4VEmC0LGXLp8WEhQIrd
         xpEZrCq8cQ6AsyhmEHJreKu+jBAaTxCWPw+UNdr9bCjofTpyuD02HNgyCs941vrpHd
         Fotvc546EVqSP6hZHZnOsr82LMl1s2a01zSj7xUS2bO8VCRqjf7gzzBn1l8oqQf5WL
         LmfagrNExrgb5aBz4J5A19Xq1BewVm3hJ1+3woCMwkhmXyhBgJ2fR2fbio+bs44XHH
         uqk3mQX+JlxAw==
Received: (nullmailer pid 814342 invoked by uid 1000);
        Tue, 12 Sep 2023 15:15:35 -0000
Date:   Tue, 12 Sep 2023 10:15:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
Message-ID: <20230912151535.GA812148-robh@kernel.org>
References: <20230907160851.14241-1-joerg.hifiberry@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907160851.14241-1-joerg.hifiberry@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:08:51PM +0200, Joerg Schambacher wrote:
> The TAS5754/6 power amplifiers use the same pcm512x driver with
> only minor restictions described in the bindings document.
> 
> Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
> ---
>  .../devicetree/bindings/sound/pcm512x.txt     | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
> index 3aae3b41bd8e..b16cd0463695 100644
> --- a/Documentation/devicetree/bindings/sound/pcm512x.txt
> +++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
> @@ -1,12 +1,12 @@
> -PCM512x audio CODECs
> +PCM512x and TAS575x audio CODECs/amplifiers
>  
>  These devices support both I2C and SPI (configured with pin strapping
> -on the board).
> +on the board). The TAS575x devices only support I2C.
>  
>  Required properties:
>  
> -  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141" or
> -                 "ti,pcm5142"
> +  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
> +                 "ti,pcm5142", "ti,tas5754" or "ti,tas5756"
>  
>    - reg : the I2C address of the device for I2C, the chip select
>            number for SPI.
> @@ -25,6 +25,7 @@ Optional properties:
>      through <6>.  The device will be configured for clock input on the
>      given pll-in pin and PLL output on the given pll-out pin.  An
>      external connection from the pll-out pin to the SCLK pin is assumed.
> +    Caution: the TAS-desvices only support gpios 1,2 and 3
>  
>  Examples:
>  
> @@ -50,3 +51,16 @@ Examples:
>  		pll-in = <3>;
>  		pll-out = <6>;
>  	};
> +
> +	tas5756: tas5756@4f {
> +		compatible = "ti,tas5756";

Is there anything new here? Just a different compatible doesn't justify 
another example.

With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>
