Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B77573F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGRGRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGRGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C11993;
        Mon, 17 Jul 2023 23:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9D361467;
        Tue, 18 Jul 2023 06:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FA4C433C7;
        Tue, 18 Jul 2023 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689660954;
        bh=m6TNtiSSdr7NEHVUmCfp2rBAYfJpD9ldZcI2OBMUi7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LME1uDz5zz0EASXHY6yhdacg6B7fduJ2359XAmmYVudDrF8o86va+aukdcS+LZqMG
         ve0J0Z3ToB6YSNk+19J0umYoTqgzyJwLXTXzSvU8ZriIQltFa/fsAFdzplekMltTJ2
         HJCcyw7sz7SitoLoVyaFrTVtiCTC+y19R1POXm3Q5INOvB08yKlKvYIg07L9O+7lAp
         9WNfv4EobVXCQG7KoqebT9yCDlv+c+UtfS8Gg3bhNkhemz9h5Ag3/LQt0r3Ni9uIcQ
         atFneK6P+c/68cfsHEHhF4a5ErX72wvpkMFu/u2SU8kyB7DXmHUGQOAPO8ZMWkAqGR
         Lh2O+FVcQ7NEw==
Date:   Tue, 18 Jul 2023 14:15:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som: add missing pull-up for
 onboard PHY reset pinmux
Message-ID: <20230718061541.GJ9559@dragon>
References: <20230704134800.204542-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134800.204542-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:48:00AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> For SOMs with an onboard PHY, the RESET_N pull-up resistor is
> currently deactivated in the pinmux configuration. When the pinmux
> code selects the GPIO function for this pin, with a default direction
> of input, this prevents the RESET_N pin from being taken to the proper
> 3.3V level (deasserted), and this results in the PHY being not
> detected since it is held in reset.
> 
> Taken from RESET_N pin description in ADIN13000 datasheet:
>     This pin requires a 1K pull-up resistor to AVDD_3P3.
> 
> Activate the pull-up resistor to fix the issue.
> 
> Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite VAR-SOM-MX8MN System on Module")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
