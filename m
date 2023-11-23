Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7C7F64FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbjKWROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:14:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08AD46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:14:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B13C433CC;
        Thu, 23 Nov 2023 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759669;
        bh=trQue5vt4vNug0lKdIifZG1U/sc0mMPLn521Cnxbi8A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NOdAwhwfhaybbj5HEJr6Qhi+fejV93baYjH8jDhcjY3Nh2+cG5MNdp+wOq8pG0A5k
         ZwOATpEZ3Wy4bBea/ZwdMcxFWdtfm3LRS923s+zCT8yQtAJyYDBc+hBuUhwv3H2P8e
         H9UBVlNTtcfEWppuxCz1hHHrZbY350a2m94KnF/QzWsNnQdvtcoueMnqd5a3nOebPc
         91RDbDBj47fJdqzt1CXk3pha1EJmoujk/gcj8buNYkCmtGGiAPe+8u2NnqwHoyn+0A
         fsb0dLmm42ew0AnhAvgXCvL3Ir82fNE/RItduAYxSOLm3jwSTy2XC4/H2ZvnyRXlAT
         8RkgBnCtoX2mg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 00/18] mfd: Convert to platform remove callback
 returning void
Message-Id: <170075966425.1458093.5482638425880756985.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:14:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 17:56:28 +0100, Uwe Kleine-König wrote:
> this series converts all platform drivers below drivers/mfd to use
> .remove_new(). Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver
> core doesn't (and cannot) cope for errors during remove. The only effect
> of a non-zero return value in .remove() is that the driver core emits a
> warning. The device is removed anyhow and an early return from .remove()
> usually yields resource leaks and/or use-after-free bugs.
> 
> [...]

Applied, thanks!

[01/18] mfd: ab8500-sysctrl: Convert to platform remove callback returning void
        commit: 05ce16c1303acaf2094f55ea248fd0d14119ed8f
[02/18] mfd: cros_ec_dev: Convert to platform remove callback returning void
        commit: c86e0818174f506e77dcb7ca0251f18269d79219
[03/18] mfd: exynos-lpass: Convert to platform remove callback returning void
        commit: e3468e03a63e8c24a8b2f9f84ed8443268dcccf4
[04/18] mfd: fsl-imx25-tsadc: Convert to platform remove callback returning void
        commit: 05d78da532ededbc11889ca5a22b302aaa8b9e1e
[05/18] mfd: hi655x-pmic: Convert to platform remove callback returning void
        commit: 30441c456171723d4d40ea86fdc7675a630cb5f8
[06/18] mfd: intel-lpss-acpi: Convert to platform remove callback returning void
        commit: 8b7ffe18eb0bf86b21d558c739279a9cb349b78d
[07/18] mfd: kempld-core: Convert to platform remove callback returning void
        commit: 5c9d52223920a70becbbdf67cce192917f997319
[08/18] mfd: mcp-sa11x0: Convert to platform remove callback returning void
        commit: 0082e145163801002a257c2cbaf2982192ab761e
[09/18] mfd: mxs-lradc: Convert to platform remove callback returning void
        commit: f9714ad21b8c01e6964e0638858d37f941dc19ba
[10/18] mfd: omap-usb-host: Convert to platform remove callback returning void
        commit: 7e5e828e1fef60673c20b47573054eaa036d1980
[11/18] mfd: omap-usb-tll: Convert to platform remove callback returning void
        commit: 6ee0e1844c917fb4e5f314aec2b780f1641375f0
[12/18] mfd: pcf50633-adc: Convert to platform remove callback returning void
        commit: 3e6eccaca6923e8d1ac4a0913b3367b5ab94f95c
[13/18] mfd: qcom-pm8xxx: Convert to platform remove callback returning void
        commit: 31b895f2528bda4db526dee1942f915f8f34091b
[14/18] mfd: sm501: Convert to platform remove callback returning void
        commit: 69fbad222c5caad34f777da33271ccdad3d9504c
[15/18] mfd: stm32-timers: Convert to platform remove callback returning void
        commit: 59569bc36fcec1cd62bd2f639784126c87c6fd1e
[16/18] mfd: ti_am335x_tscadc: Convert to platform remove callback returning void
        commit: 1dbe13baca338502bf741bbe3b199c07c7d1c5bc
[17/18] mfd: tps65911-comparator: Convert to platform remove callback returning void
        commit: 4aa72c8515734c2edf4c6c264aee4925efd97366
[18/18] mfd: twl4030-audio: Convert to platform remove callback returning void
        commit: db1e0b072da189db99f905b758676a81bb796a1a

--
Lee Jones [李琼斯]

