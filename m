Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D397E72DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjKIUaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbjKIUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:30:12 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729C44BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeH-0002yL-0M; Thu, 09 Nov 2023 21:29:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-007rWU-Et; Thu, 09 Nov 2023 21:29:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-00GGtM-3f; Thu, 09 Nov 2023 21:29:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jay Fang <f.fangjian@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Ying <victor.liu@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yangtao Li <frank.li@vivo.com>, Yuan Can <yuancan@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 00/12] bus: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:30 +0100
Message-ID: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=J6a3im7lNbnTqrSTHauek+j417sdu4W8300ivumT3qU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUDuVSwm6Dry76QAgY1MQyxgniK5Ur0yUy/Cg DW8XtvPhlCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A7gAKCRCPgPtYfRL+ TonZB/4nfsBuFdJxCVjGRqREV3frv3i56Yi9aUTm3cZVViaDV6rrVzn83paMyvZOMcV+Qntq2tX 7WQ5SPanfT1NJ1AfbG/XwNxY6PS3hUii1I+bPm9FjxoxiyDrW0S2+D6+JEzITZZrJE7B8YHT0I2 Mf0d40VtdzK5EZ00R/it9N/7Pqn6lruK/C1HUU05s1WsFol+DMhIi62hlmt6UoLuPVZIoYHGZcu KtiwLuPKFLIuOikg/fK/+o/C+jl4BIv0TSXd6ezG6EL+9m0N1RQrTAAh6kI2ULO6AfQDkNbiMoF 1DoqM5OyvFMQd4GG4MjyGP6ulmlIBjWUtD4VZ5yBOlwjhO2c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series converts all drivers below drivers/bus to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

drivers/bus/fsl-mc was already addressed earlier with a separate
series[1].

All conversations are trivial, because all .remove() callbacks returned
zero unconditionally.

Some of the drivers touched here don't have a maintainer and there is no
maintainer for all of drivers/bus. It would be great if someone could pick up
the whole series, maybe Arnd might do that?

Best regards
Uwe

[1] https://lore.kernel.org/lkml/20231103230001.3652259-3-u.kleine-koenig@pengutronix.de

Uwe Kleine-König (12):
  bus: hisi_lpc: Convert to platform remove callback returning void
  bus: omap-ocp2scp: Convert to platform remove callback returning void
  bus: omap_l3_smx: Convert to platform remove callback returning void
  bus: qcom-ssc-block-bus: Convert to platform remove callback returning
    void
  bus: simple-pm-bus: Convert to platform remove callback returning void
  bus: sun50i-de2: Convert to platform remove callback returning void
  bus: sunxi-rsb: Convert to platform remove callback returning void
  bus: tegra-aconnect: Convert to platform remove callback returning
    void
  bus: tegra-gmi: Convert to platform remove callback returning void
  bus: ti-pwmss: Convert to platform remove callback returning void
  bus: ti-sysc: Convert to platform remove callback returning void
  bus: ts-nbus: Convert to platform remove callback returning void

 drivers/bus/hisi_lpc.c           | 6 ++----
 drivers/bus/omap-ocp2scp.c       | 6 ++----
 drivers/bus/omap_l3_smx.c        | 6 ++----
 drivers/bus/qcom-ssc-block-bus.c | 6 ++----
 drivers/bus/simple-pm-bus.c      | 7 +++----
 drivers/bus/sun50i-de2.c         | 5 ++---
 drivers/bus/sunxi-rsb.c          | 6 ++----
 drivers/bus/tegra-aconnect.c     | 6 ++----
 drivers/bus/tegra-gmi.c          | 6 ++----
 drivers/bus/ti-pwmss.c           | 5 ++---
 drivers/bus/ti-sysc.c            | 6 ++----
 drivers/bus/ts-nbus.c            | 6 ++----
 12 files changed, 25 insertions(+), 46 deletions(-)

base-commit: b622d91ca201bf97582e9b09ebbaab005ecee86f
-- 
2.42.0

