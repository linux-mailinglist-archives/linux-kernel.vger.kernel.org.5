Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDE78442E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjHVO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjHVO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402D1BE;
        Tue, 22 Aug 2023 07:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A49AF65930;
        Tue, 22 Aug 2023 14:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0AFC433C7;
        Tue, 22 Aug 2023 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714563;
        bh=h5zyHpspl7dpKFk5tUBL2QsxCFhjvr9+cr25M5nKD9I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QxDU/uzDRlUYUbPhQBOBBNOe4RoQYo8maLbY92IV4a6WbbFzfjJM3cYl8Hat8g73g
         UmLCKlH0Kj/LyGcVQxXij4V3tz7tyT0FE+4/NiyJMLdMSKDCNee03y6trxBULGjTR+
         J1waOCWynNSHUvA8yfdXUyw1NhYHFZE9Gvf9rcMd7AB+ZG4lkHOhuvhIFKlSkTHH/L
         288bzbEype+o7jC7njo66bN46BOSpFsunj+ruMCsMkFCqp26n6bZkaefKfpb6+0Tjm
         SKXazm5R8YWyoXBqFSteLX2rh90hRe+hBPiORU39cnqt/Jo5njkzBWaXbT4F2ejRUN
         XqimrAsFVA1/w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20230819031731.22618-1-semen.protsenko@linaro.org>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH 0/8] arm64: exynos: Enable USB for E850-96
 board
Message-Id: <169271455700.280543.8632429647448619127.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 19:59:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2023 22:17:23 -0500, Sam Protsenko wrote:
> This patch series enables USB gadget, USB host and Ethernet support for
> E850-96 board. The most major change was done in USB PHY driver, as the
> register layout of PHY block in Exynos850 is very different from
> Exynos5 one.
> 
> Sam Protsenko (8):
>   dt-bindings: usb: samsung,exynos-dwc3: Add Exynos850 support
>   dt-bindings: phy: samsung,usb3-drd-phy: Add Exynos850 support
>   usb: dwc3: exynos: Add support for Exynos850 variant
>   phy: exynos5-usbdrd: Make it possible to pass custom phy ops
>   phy: exynos5-usbdrd: Add 26MHz ref clk support
>   phy: exynos5-usbdrd: Add Exynos850 support
>   arm64: dts: exynos: Enable USB in Exynos850
>   arm64: dts: exynos: Enable USB support on E850-96 board
> 
> [...]

Applied, thanks!

[2/8] dt-bindings: phy: samsung,usb3-drd-phy: Add Exynos850 support
      commit: 0b76bdce32300a626dc796f656c085a786c5dab1
[4/8] phy: exynos5-usbdrd: Make it possible to pass custom phy ops
      commit: 6b34ec66e7e7351b9a0a1eba8f57eb46ddeabf1e
[5/8] phy: exynos5-usbdrd: Add 26MHz ref clk support
      commit: 255ec3879dd4d585799fd8d8a94a335eaf84d2ec
[6/8] phy: exynos5-usbdrd: Add Exynos850 support
      commit: 691525074db97d9b684dd1457fd8dc9842a36615

Best regards,
-- 
~Vinod


