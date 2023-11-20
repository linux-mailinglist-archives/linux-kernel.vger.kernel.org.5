Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD27F13B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjKTMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:42:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD097116
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:42:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso13676325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700484159; x=1701088959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D52itfLWLbNvwsKv7sQ1ra+dg5qVPn9G/VynRctmB8E=;
        b=GKfSlQEvcB3o/5SY8kBXUs30Cd65CtFo+yMpNgnR7x7e0PeXYudArrv/DfLnErc3Gm
         KrqqHYPX9nvD6FzYu04FKf+PQF/posHFBi7/v8biMx6kcrOqPiMpK6zWtkf7pkDmDayG
         Iw/qEWstNMnejkkMU+tndUJH1cXRUgE6eGbGQEH8jvqfOLioyWPxZHDKyZBKOi8ct0nx
         VUWCRnFe5kWFtdbbzjjIyLgHWrzZWEMFaZ9uVFPyIFNC34VbH5/fRv0+lLKp44eymcny
         4QrRm86TGKH5zqyCDhwadlfd4rvUdF/n0fnnt3T0QhtMngU5E9kdANv7kE2V2C8t9xBK
         VWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484159; x=1701088959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D52itfLWLbNvwsKv7sQ1ra+dg5qVPn9G/VynRctmB8E=;
        b=mD3PcplFnPFlvImNs11CLEY948vXxixanodmvSFYiqRqjgEwRmte/u6+tuy2LCstpN
         X4rQYHC6IcfizNXQgVKT6R9moN1HyKjym/TE0X2FbiWEWAG1RGClRibsMsht/mpPUtlr
         fw+wZ10/SW3f5fsIsyy5Cd7NrQrKBpKTa93j9U6FIufG7znW3OTq1FUiQ5GianD8dAwv
         RImu/aWD66jHTBugDMlWOQYUqW8R7WZoAKWFKrkf/DB1xKb53YJRUDd5nYGYNFt5eRVb
         ki4fh2YlRGc2hm+e/Sd5t9O115fZE8hJ6NCHlYW2MSKB80XqsKSw9RJjwEGuNM6pWYHg
         85Cw==
X-Gm-Message-State: AOJu0Yy+7Rqwm5I4qS/dzhAhUNCEvrfWful+UDOZXlxWGgZ0BnNwSrU+
        LNw4bMIJ3gzW3+ycXYR+8AmQVg==
X-Google-Smtp-Source: AGHT+IH7fve2DfC8Ys8y9sab7zNPlCaywswvTUnSwqhadnaOXUnx3dF7w5Mh+QAKVDfdcoT5sPF5uA==
X-Received: by 2002:a05:600c:4750:b0:405:3e5e:6698 with SMTP id w16-20020a05600c475000b004053e5e6698mr5583660wmo.27.1700484158840;
        Mon, 20 Nov 2023 04:42:38 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id g18-20020a05600c4ed200b004068e09a70bsm13523994wmq.31.2023.11.20.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:42:37 -0800 (PST)
Date:   Mon, 20 Nov 2023 13:42:35 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 5/6] reset: rockchip: secure reset must be used by SCMI
Message-ID: <ZVtUOwFbz9NzX1Ly@Red>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-6-clabbe@baylibre.com>
 <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org>
 <11278271.CDJkKcVGEf@diego>
 <d82865bc-29a7-4150-876e-489e0d797699@linaro.org>
 <20231111205115.6hkhjj37ypeq45ax@mercury.elektranox.org>
 <4f86c7da-5589-4451-89cb-739b97b67170@linaro.org>
 <20231112202639.obvmnjlt4mpa52qr@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231112202639.obvmnjlt4mpa52qr@mercury.elektranox.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Nov 12, 2023 at 09:26:39PM +0100, Sebastian Reichel a écrit :
> Hi,
> 
> On Sat, Nov 11, 2023 at 10:28:59PM +0100, Krzysztof Kozlowski wrote:
> > On 11/11/2023 21:51, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Tue, Nov 07, 2023 at 06:45:03PM +0100, Krzysztof Kozlowski wrote:
> > >> On 07/11/2023 18:35, Heiko Stübner wrote:
> > >>> Am Dienstag, 7. November 2023, 17:21:41 CET schrieb Krzysztof Kozlowski:
> > >>>> On 07/11/2023 16:55, Corentin Labbe wrote:
> > >>>>> While working on the rk3588 crypto driver, I loose lot of time
> > >>>>> understanding why resetting the IP failed.
> > >>>>> This is due to RK3588_SECURECRU_RESET_OFFSET being in the secure world,
> > >>>>> so impossible to operate on it from the kernel.
> > >>>>> All resets in this block must be handled via SCMI call.
> > >>>>>
> > >>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > >>>>> ---
> > >>>>>  drivers/clk/rockchip/rst-rk3588.c             | 42 ------------
> > >>>>>  .../dt-bindings/reset/rockchip,rk3588-cru.h   | 68 +++++++++----------
> > >>>>
> > >>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
> > >>>> warnings can be ignored, but the code here looks like it needs a fix.
> > >>>> Feel free to get in touch if the warning is not clear.
> > >>>>
> > >>>>>  2 files changed, 34 insertions(+), 76 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
> > >>>>> index e855bb8d5413..6556d9d3c7ab 100644
> > >>>>> --- a/drivers/clk/rockchip/rst-rk3588.c
> > >>>>> +++ b/drivers/clk/rockchip/rst-rk3588.c
> > >>>>> @@ -16,9 +16,6 @@
> > >>>>>  /* 0xFD7C8000 + 0x0A00 */
> > >>>>>  #define RK3588_PHPTOPCRU_RESET_OFFSET(id, reg, bit) [id] = (0x8000*4 + reg * 16 + bit)
> > >>>>>  
> > >>>>> -/* 0xFD7D0000 + 0x0A00 */
> > >>>>> -#define RK3588_SECURECRU_RESET_OFFSET(id, reg, bit) [id] = (0x10000*4 + reg * 16 + bit)
> > >>>>> -
> > >>>>>  /* 0xFD7F0000 + 0x0A00 */
> > >>>>>  #define RK3588_PMU1CRU_RESET_OFFSET(id, reg, bit) [id] = (0x30000*4 + reg * 16 + bit)
> > >>>>>  
> > >>>>> @@ -806,45 +803,6 @@ static const int rk3588_register_offset[] = {
> > >>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_PMU0IOC, 5, 4),
> > >>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_GPIO0, 5, 5),
> > >>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_GPIO0, 5, 6),
> > >>>>> -
> > >>>>> -	/* SECURECRU_SOFTRST_CON00 */
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_NS_BIU, 0, 10),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_NS_BIU, 0, 11),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_S_BIU, 0, 12),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_S_BIU, 0, 13),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_SECURE_S_BIU, 0, 14),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_CORE, 0, 15),
> > >>>>> -
> > >>>>> -	/* SECURECRU_SOFTRST_CON01 */
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_PKA, 1, 0),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_RNG, 1, 1),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_CRYPTO, 1, 2),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_CRYPTO, 1, 3),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_CORE, 1, 9),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_RNG, 1, 10),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_KEYLADDER, 1, 11),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_KEYLADDER, 1, 12),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_OTPC_S, 1, 13),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_OTPC_S, 1, 14),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_WDT_S, 1, 15),
> > >>>>> -
> > >>>>> -	/* SECURECRU_SOFTRST_CON02 */
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_T_WDT_S, 2, 0),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM, 2, 1),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_DCF, 2, 2),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_DCF, 2, 3),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM_NS, 2, 5),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_KEYLADDER, 2, 14),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_S, 2, 15),
> > >>>>> -
> > >>>>> -	/* SECURECRU_SOFTRST_CON03 */
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_NS, 3, 0),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_D_SDMMC_BUFFER, 3, 1),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC, 3, 2),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC_BUFFER, 3, 3),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_SDMMC, 3, 4),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_TRNG_CHK, 3, 5),
> > >>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_TRNG_S, 3, 6),
> > >>>>>  };
> > >>>>>  
> > >>>>>  void rk3588_rst_init(struct device_node *np, void __iomem *reg_base)
> > >>>>> diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > >>>>> index d4264db2a07f..c0d08ae78cd5 100644
> > >>>>> --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > >>>>> +++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> > >>>>> @@ -716,39 +716,39 @@
> > >>>>>  #define SRST_P_GPIO0			627
> > >>>>>  #define SRST_GPIO0			628
> > >>>>>  
> > >>>>> -#define SRST_A_SECURE_NS_BIU		629
> > >>>>> -#define SRST_H_SECURE_NS_BIU		630
> > >>>>> -#define SRST_A_SECURE_S_BIU		631
> > >>>>> -#define SRST_H_SECURE_S_BIU		632
> > >>>>> -#define SRST_P_SECURE_S_BIU		633
> > >>>>> -#define SRST_CRYPTO_CORE		634
> > >>>>> -
> > >>>>> -#define SRST_CRYPTO_PKA			635
> > >>>>> -#define SRST_CRYPTO_RNG			636
> > >>>>> -#define SRST_A_CRYPTO			637
> > >>>>> -#define SRST_H_CRYPTO			638
> > >>>>> -#define SRST_KEYLADDER_CORE		639
> > >>>>> -#define SRST_KEYLADDER_RNG		640
> > >>>>> -#define SRST_A_KEYLADDER		641
> > >>>>> -#define SRST_H_KEYLADDER		642
> > >>>>> -#define SRST_P_OTPC_S			643
> > >>>>> -#define SRST_OTPC_S			644
> > >>>>> -#define SRST_WDT_S			645
> > >>>>> -
> > >>>>> -#define SRST_T_WDT_S			646
> > >>>>> -#define SRST_H_BOOTROM			647
> > >>>>> -#define SRST_A_DCF			648
> > >>>>> -#define SRST_P_DCF			649
> > >>>>> -#define SRST_H_BOOTROM_NS		650
> > >>>>> -#define SRST_P_KEYLADDER		651
> > >>>>> -#define SRST_H_TRNG_S			652
> > >>>>> -
> > >>>>> -#define SRST_H_TRNG_NS			653
> > >>>>> -#define SRST_D_SDMMC_BUFFER		654
> > >>>>> -#define SRST_H_SDMMC			655
> > >>>>> -#define SRST_H_SDMMC_BUFFER		656
> > >>>>> -#define SRST_SDMMC			657
> > >>>>> -#define SRST_P_TRNG_CHK			658
> > >>>>> -#define SRST_TRNG_S			659
> > >>>>> +#define SRST_A_SECURE_NS_BIU		10
> > >>>>
> > >>>> NAK. You just broke all users.
> > >>>
> > >>> If I'm reading the commit message correctly, all resets in that area
> > >>> couldn't have any users to begin with, as the registers controlling them
> > >>> are in the secure space, and need a higher exception level
> > >>>
> > >>> So if  anything is trying to handle these resets, would end up with some
> > >>> security exception right now.
> > >>>
> > >>> Though I guess we might want to use different names and not reuse the
> > >>> existing ones. scmi clocks use a SCMI_CLK_* id scheme, so maybe SCMI_SRST_* ?
> > >>
> > >> I don't quite get what the patch wants to achieve. Why dropping driver
> > >> support for given reset ID is connected with changing the value of
> > >> binding for given reset?
> > >>
> > >> What is the point of this define SRST_A_SECURE_NS_BIU 10?
> > > 
> > > This is about two different reset controllers. The IDs defined here
> > > are used by the operating system to access the correct registers.
> > > The kernel has a LUT from the ID to a register addresses, which is
> > > something you asked for during upstreaming.
> > > 
> > > The ID defined by Corentin is for reset control via SCMI firmware,
> > > which has different number scheme than Linux. To me the suggestion
> > > from Heiko looks sensible (i.e. create a new ID scheme and keep the
> > > current one unchanged).
> > 
> > So the binding is not for Linux but for FW? This should be explained in
> > the commit msg.
> 
> No.
> 
> The current binding describes reset IDs, which are mapped by the
> Linux driver to register offsets in the CRU (clock-reset-unit).
> But accessing the crypto reset line directly from Linux (which
> usually does not run in secure state) will fail. Accessing it
> from correct security context with the current binding is fine
> though. Considering we are sharing the bindings with e.g.
> U-Boot, I suggest to keep the currently defined IDs.
> 
> But Corentin tries to get this running on Linux. For that he
> needs to ask the (SCMI) firmware running in secure state to
> please take care of the reset. The firmware is using different
> reset IDs (apparently the ones used by downstream Linux, which
> are derived from register offset).
> 
> In DT the difference looks like this (check the different phandles):
> 
> #define SRST_A_SECURE_NS_BIU 629
> crypto-old {
>     // existing binding from Linux perspective
>     // reset via direct CRU access
>     // NOTE: permission denied
>     resets = <&cru SRST_A_SECURE_NS_BIU>; 
> };
> 
> #define SCMI_RST_A_SECURE_NS_BIU 10
> crypto-new {
>     // new binding from Linux perspective
>     // reset via SCMI firmware request
>     resets = <&scmi SCMI_RST_A_SECURE_NS_BIU>;
> };
> 
> Instead of introducing SCMI_RST_A_SECURE_NS_BIU, Corentin
> currently just redefines SRST_A_SECURE_NS_BIU. This is quite
> misleading. If somebody does '<&cru SRST_A_SECURE_NS_BIU>'
> with the '10' value for SCMI, it instead resets
> SRST_A_TOP_M300_BIU.
> 
> So my suggestion is to go with the suggestion from Heiko and
> introduce SCMI_RST_A_SECURE_NS_BIU (or something similar).
> That also matches how the SCMI clks on RK3588 and some other
> platforms. See e.g.:
> 
> of include/dt-bindings/clock/rockchip,rk3588-cru.h.
> 
> Greetings,
> 
> -- Sebastian

Thanks for yours suggestions, I will do it that way.

Regards
