Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C7770EF9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjHEJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHEJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F36469E;
        Sat,  5 Aug 2023 02:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C59060C1B;
        Sat,  5 Aug 2023 09:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CE8C433C7;
        Sat,  5 Aug 2023 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691226561;
        bh=xB1qV0PaGAB6f8kCo0AnFgu5p9Cp/WAx3pDQIkj8gvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSDTIZwLIkaJcXHl8Jm/Q5FAMwzyUKv/7XjD+IoTDfF5y8Hwiz2TmlbCSRzXn+e85
         fANhCb4VJC543oXGUNbTuqbUWyjje2r6d8V3Ep7DBaFxPZoCtzPZJ+6iL0r1Zn80l0
         of+rl87SEt/z8Ca+CDW01Qr1SpC8Y26T8bgMLNowAdaFat0slLBcHe4VVHCpeT3SkR
         D0l3YZV8k5YdaBKxxic+52OUJaNrZRCcQ+sJlw4yQYuEddjM+pO8JzhCMVc7zVCPfO
         gM+1af20AohCgXT0FvIuVi0tWADQk6guBPTigCOR8Xpi4U9MCwL4oxfGA33Cu2BpHS
         6O7jOBomHYGiQ==
From:   Conor Dooley <conor@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: (subset) [PATCH v6 0/3] Add initialization of clock for StarFive JH7110 SoC
Date:   Sat,  5 Aug 2023 10:09:04 +0100
Message-Id: <20230805-imaginary-paramedic-deb52367e36a@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804020254.291239-1-william.qiu@starfivetech.com>
References: <20230804020254.291239-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=636; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zMQM4BLLWfbMwoqkkncDlkVcxjGVicpsbkXv343HcXM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnnBNcJHhfYa9mb+u0f+58DGy48nlB7clXLsV9TM5Q2x XXMK9lwsqOUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATKcxm+Gf9Ku6Nb6z17/oO V+5riQxfD8+L5tx6KClSNPwVw42yidMYGfb0Wd1NZ783ue7Jwvdf6xPb88ojOZUfrq6bdXmd/Nw eFk4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 04 Aug 2023 10:02:51 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> Quad SPI controller driver. And this driver will be used in
> StarFive's VisionFive 2 board. In 6.4, the QSPI_AHB and QSPI_APB
> clocks changed from the default ON state to the default OFF state,
> so these clocks need to be enabled in the driver.At the same time,
> dts patch is added to this series.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC
      https://git.kernel.org/conor/c/fc3d49f970d2

Thanks,
Conor.
