Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96B7F473E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjKVM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbjKVM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:57:07 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFAD4F;
        Wed, 22 Nov 2023 04:56:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99D4153ED3;
        Wed, 22 Nov 2023 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700657813; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=NJqnHAtPlKbGsmXwWt6Mzhb01vRIrHrGSJJ9KKN9CCc=;
        b=fetTjSddAWPcFfjStVgAKIIqceJ4c6B6mXFlCugrJlyGmrjsGOelHSc2y2oEnfWrgWJKz3
        NLFhStEMpLN0We0NMEWCrw2XkTJuyLOrmS8/0tUUCuFcqrKBwcWwKv9POQb+TmpuVCWymO
        SWf4kPm41WaAKEoDHAdZk1ZV4xhIfhrSCru/2U0sUM7ya8y7GaGelOt6CeaM41USx/TqMa
        jv6fXyLf+ndyTD24zb6E1F84eJshhYiX1TdTE2ujLP+2ONiFTrsLx4gkzqF9SlO66JPc9D
        8PuRzxhSfBE2p/T+7++iiRHrV6u2FnK7wTJbhD6/y6F0BMn87uy0Ze5DmqQDDA==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/5] soc: amlogic: add new meson-gx-socinfo-sm driver
Date:   Wed, 22 Nov 2023 15:56:38 +0300
Message-Id: <20231122125643.1717160-1-adeep@lexina.in>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; h=from:subject; bh=DcgIzLHIf256LOHM599wpJilJoTBV1o/3eeRP7SNgIc=; b=owGbwMvMwCHmnhFhrJcZuJTxtFoSQ2rstyOOs3z8P159rJUk2rqkoqfX9FXs5NANbz6c3bD/8vfk R2/fdZSyMIhxMMiKKbKEdQRN3eex+uLEBUYHYOawMoEMYeDiFICJPM1n+KfjHLLE+OoKdqc4v9s8T4 zMIlxC8/07525l3F9pqiR4/CnD/zAjyWnzdLtDZbPTbiWKOO3Y1bQsvmmpcnZK0TN7uTnr2AE=
X-Developer-Key: i=adeep@lexina.in; a=openpgp; fpr=E2FA1A767ACB0716E02E3E7AEE36B110025A8DFA
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique SoC ID starting from the GX Family and all new families.
But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.

This is the second attempt to publish data from the Amlogic secure monitor
chipid call. After discussions with Neil Armstrong, it was decided to
publish the chipid call results through the soc driver. Since
soc_device_match cannot wait for the soc driver to load, and the secure
monitor calls in turn depend on the sm driver, it was necessary to create
a new driver rather than expand an existing one.

In the patches, in addition to writing the driver:
- convert commonly used structures and functions of the meson-gx-socinfo
driver to a header file.
- transfer the chipid sm call constants to a header file (perhaps they
need renaming?).
- add secure-monitor references for amlogic,meson-gx-ao-secure sections
in dts files of the a1, axg, g12, gx families.

Viacheslav Bocharov (5):
  soc: amlogic: meson-gx-socinfo: move common code to header file
  soc: amlogic: meson-gx-socinfo: move common code to exported function
  firmware: meson_sm: move common definitions to header file
  soc: amlogic: Add Amlogic secure-monitor SoC Information driver
  arm64: dts: meson: add dts links to secure-monitor for soc driver in
    a1, axg, gx, g12

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
 drivers/firmware/meson/meson_sm.c             |   4 -
 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 102 ++++++++++
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 178 ++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 106 ++---------
 include/linux/firmware/meson/meson_sm.h       |   4 +
 11 files changed, 317 insertions(+), 92 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c

-- 
2.34.1

