Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E667E4728
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjKGRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjKGRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:36:02 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAFC0;
        Tue,  7 Nov 2023 09:35:59 -0800 (PST)
Received: from i53875a93.versanet.de ([83.135.90.147] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r0PzS-0006PH-Sg; Tue, 07 Nov 2023 18:35:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 5/6] reset: rockchip: secure reset must be used by SCMI
Date:   Tue, 07 Nov 2023 18:35:49 +0100
Message-ID: <11278271.CDJkKcVGEf@diego>
In-Reply-To: <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-6-clabbe@baylibre.com>
 <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. November 2023, 17:21:41 CET schrieb Krzysztof Kozlowski:
> On 07/11/2023 16:55, Corentin Labbe wrote:
> > While working on the rk3588 crypto driver, I loose lot of time
> > understanding why resetting the IP failed.
> > This is due to RK3588_SECURECRU_RESET_OFFSET being in the secure world,
> > so impossible to operate on it from the kernel.
> > All resets in this block must be handled via SCMI call.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/clk/rockchip/rst-rk3588.c             | 42 ------------
> >  .../dt-bindings/reset/rockchip,rk3588-cru.h   | 68 +++++++++----------
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> >  2 files changed, 34 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
> > index e855bb8d5413..6556d9d3c7ab 100644
> > --- a/drivers/clk/rockchip/rst-rk3588.c
> > +++ b/drivers/clk/rockchip/rst-rk3588.c
> > @@ -16,9 +16,6 @@
> >  /* 0xFD7C8000 + 0x0A00 */
> >  #define RK3588_PHPTOPCRU_RESET_OFFSET(id, reg, bit) [id] = (0x8000*4 + reg * 16 + bit)
> >  
> > -/* 0xFD7D0000 + 0x0A00 */
> > -#define RK3588_SECURECRU_RESET_OFFSET(id, reg, bit) [id] = (0x10000*4 + reg * 16 + bit)
> > -
> >  /* 0xFD7F0000 + 0x0A00 */
> >  #define RK3588_PMU1CRU_RESET_OFFSET(id, reg, bit) [id] = (0x30000*4 + reg * 16 + bit)
> >  
> > @@ -806,45 +803,6 @@ static const int rk3588_register_offset[] = {
> >  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_PMU0IOC, 5, 4),
> >  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_GPIO0, 5, 5),
> >  	RK3588_PMU1CRU_RESET_OFFSET(SRST_GPIO0, 5, 6),
> > -
> > -	/* SECURECRU_SOFTRST_CON00 */
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_NS_BIU, 0, 10),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_NS_BIU, 0, 11),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_S_BIU, 0, 12),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_S_BIU, 0, 13),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_SECURE_S_BIU, 0, 14),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_CORE, 0, 15),
> > -
> > -	/* SECURECRU_SOFTRST_CON01 */
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_PKA, 1, 0),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_RNG, 1, 1),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_CRYPTO, 1, 2),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_CRYPTO, 1, 3),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_CORE, 1, 9),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_RNG, 1, 10),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_KEYLADDER, 1, 11),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_KEYLADDER, 1, 12),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_OTPC_S, 1, 13),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_OTPC_S, 1, 14),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_WDT_S, 1, 15),
> > -
> > -	/* SECURECRU_SOFTRST_CON02 */
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_T_WDT_S, 2, 0),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM, 2, 1),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_DCF, 2, 2),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_DCF, 2, 3),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM_NS, 2, 5),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_KEYLADDER, 2, 14),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_S, 2, 15),
> > -
> > -	/* SECURECRU_SOFTRST_CON03 */
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_NS, 3, 0),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_D_SDMMC_BUFFER, 3, 1),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC, 3, 2),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC_BUFFER, 3, 3),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_SDMMC, 3, 4),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_TRNG_CHK, 3, 5),
> > -	RK3588_SECURECRU_RESET_OFFSET(SRST_TRNG_S, 3, 6),
> >  };
> >  
> >  void rk3588_rst_init(struct device_node *np, void __iomem *reg_base)
> > diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > index d4264db2a07f..c0d08ae78cd5 100644
> > --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > +++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > @@ -716,39 +716,39 @@
> >  #define SRST_P_GPIO0			627
> >  #define SRST_GPIO0			628
> >  
> > -#define SRST_A_SECURE_NS_BIU		629
> > -#define SRST_H_SECURE_NS_BIU		630
> > -#define SRST_A_SECURE_S_BIU		631
> > -#define SRST_H_SECURE_S_BIU		632
> > -#define SRST_P_SECURE_S_BIU		633
> > -#define SRST_CRYPTO_CORE		634
> > -
> > -#define SRST_CRYPTO_PKA			635
> > -#define SRST_CRYPTO_RNG			636
> > -#define SRST_A_CRYPTO			637
> > -#define SRST_H_CRYPTO			638
> > -#define SRST_KEYLADDER_CORE		639
> > -#define SRST_KEYLADDER_RNG		640
> > -#define SRST_A_KEYLADDER		641
> > -#define SRST_H_KEYLADDER		642
> > -#define SRST_P_OTPC_S			643
> > -#define SRST_OTPC_S			644
> > -#define SRST_WDT_S			645
> > -
> > -#define SRST_T_WDT_S			646
> > -#define SRST_H_BOOTROM			647
> > -#define SRST_A_DCF			648
> > -#define SRST_P_DCF			649
> > -#define SRST_H_BOOTROM_NS		650
> > -#define SRST_P_KEYLADDER		651
> > -#define SRST_H_TRNG_S			652
> > -
> > -#define SRST_H_TRNG_NS			653
> > -#define SRST_D_SDMMC_BUFFER		654
> > -#define SRST_H_SDMMC			655
> > -#define SRST_H_SDMMC_BUFFER		656
> > -#define SRST_SDMMC			657
> > -#define SRST_P_TRNG_CHK			658
> > -#define SRST_TRNG_S			659
> > +#define SRST_A_SECURE_NS_BIU		10
> 
> NAK. You just broke all users.

If I'm reading the commit message correctly, all resets in that area
couldn't have any users to begin with, as the registers controlling them
are in the secure space, and need a higher exception level

So if  anything is trying to handle these resets, would end up with some
security exception right now.

Though I guess we might want to use different names and not reuse the
existing ones. scmi clocks use a SCMI_CLK_* id scheme, so maybe SCMI_SRST_* ?



