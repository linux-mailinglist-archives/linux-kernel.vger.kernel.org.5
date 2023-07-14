Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960B753E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjGNPRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbjGNPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:17:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033B2117
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:17:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKKXO-0002E1-CI; Fri, 14 Jul 2023 17:16:54 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qKKXN-0007t7-F1; Fri, 14 Jul 2023 17:16:53 +0200
Date:   Fri, 14 Jul 2023 17:16:53 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
Message-ID: <20230714151653.7xqrerpmxzv7crel@pengutronix.de>
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
 <61e9e380-dcb0-4dd4-562d-bffea2da5097@pengutronix.de>
 <2d9b2341-84ca-d152-8a42-90b815c66125@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9b2341-84ca-d152-8a42-90b815c66125@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-05, Krzysztof Kozlowski wrote:
> On 05/07/2023 11:28, Ahmad Fatoum wrote:
> >>> +        items:
> >>> +          - enum:
> >>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> >>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> >>
> >> Same comments as for patch #2. I think this should be rather deprecated
> >> - not a good pattern.
> > 
> > The middle compatible was my suggestion, because there's also the Debix Model
> > B Standard and Model B SE, which is the same board, but different SoC variant:
> > 
> >  Model A:          Commercial Temperature Grade
> >  Model B Standard: Industrial Temperature Grade
> >  Model B SE:       Industrial Temperature Grate, but i.MX8MP Lite
> >                    (No Neural/Video/Image accelerators).
> > 
> > As everything outside the SoC is the same, I wanted a generic board
> > compatible that bootloaders can match against. The SoMs should probably
> > not reuse it, but I think it should be kept (perhaps renamed?) for the
> > SBCs that don't utilize the Debix SoM.

The SoM may come also in a 'Standard' and 'SE' edition.

> The order of compatibles in patch two does not really look correct,
> although it is accepted in some cases (e.g. Renesas). But anyway "Debix"
> sounds like a vendor - they even have website - so compatible for all
> boards seems too generic. This should be compatible for one specific
> board. I understand that one board can have different SoMs (it is
> common, just look at Toradex or Variscite), but it does not mean that
> board should be unspecific.

I reused the "polyhex,imx8mp-debix" compatible since we already have a
user [1] and there are no differences.

I can drop it for the SoM case but for the SBC case I can't since this
would break current users [1].

Regards,
  Marco

[1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/boards/polyhex-debix/board.c#L38
