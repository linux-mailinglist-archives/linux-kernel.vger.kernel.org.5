Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D20751ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjGMK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGMK1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:27:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53601E77
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:27:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qJtXu-0000xP-O8; Thu, 13 Jul 2023 12:27:38 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qJtXs-0003q8-0S; Thu, 13 Jul 2023 12:27:36 +0200
Date:   Thu, 13 Jul 2023 12:27:35 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     linux-imx@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: i.MX8MP EQOS + 10/100MBit RMII Phy Issue
Message-ID: <20230713102735.qd3ispdabpdpxawt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I currently debug an issue regarding the i.MX8MP EQOS in combination
with an 10/100Mbit RMII phy. The phy supplies the 50MHz rmii-refclk and
is working in 100Mbit but stops working in 10Mbit mode.

While my debugging session I found a great IP core signal overview from
STM [1]. The ETH signals matches the ones also listed in the i.MX8MP
refernce manual, therefore I think that the NXP used IP core version
does match the STM one very well.

As seen in the overview [1] the SoC has to provide the correct rx/tx
clocks to the EQOS core which depends on the speed (10/100/1000) and the
interface (mii, rmii, rgmii). The clock selection can be done by the
mac_speed_o[1:0] signals or have to be done separatly via software _but_
it have to be done outside the EQOS IP core.

The NXP i.MX8MP RM has some integration registers layed within the
IOMUXC_GPR1 register to select the interface (MII/RGMII/MII) but no bits
to select correct speed.

Since the RMII 100Mbit case is working I now assume:
 1) NXP has a /2 predivider but no /20 predivder nor a mux to select
    between both. Is this correct?
 2) NXP has all dividers and muxes but did not document these. If so can
    you provide us the registers and bits?

I look forward to here from NXP :)

Regards,
  Marco

PS: - I also checked the Rockchip refernce manual and they do have
      proper clock dividers and muxes like STM.
    - I did test the 10Mbit case on the i.MX8MP-EVK as well which does
      work because they use a RGMII interface which does have a
      different clock handling.

[1] https://community.st.com/t5/stm32-mpus/faq-stm32mp1-how-to-configure-ethernet-phy-clocks/ta-p/49266; figure 83
