Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0947DD499
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjJaRYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbjJaRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:24:48 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 10:24:45 PDT
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1FA2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:24:45 -0700 (PDT)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2023103117234127230d291d8c8a83ab
        for <linux-kernel@vger.kernel.org>;
        Tue, 31 Oct 2023 18:23:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lFP+tbCCO5Al81BN5LxLj92CbDsS9TZpPfpARMeq65M=;
 b=P50E34PYGosi/ecNJHdTkYldQFW7FWtv2UoYbVfGe2P9oTlvGLldNnyb7IIgzRZxuCnvjr
 2SR9b8gPJeYgGaIwjLk++t/98j4iWVGq1s0idvlFI09pw8beYegkEv4QDQg2/Z0cAwqFoHmU
 JOGv70edFoDPs4YLxvyUMRnKFg1qo=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH v2 0/5] arm64: dts: iot2050: DT fixes, cleanups and enhancements
Date:   Tue, 31 Oct 2023 18:23:34 +0100
Message-Id: <cover.1698773019.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the lost aliases for the IOT2050 series, fixes mini PCIe card
hangs, drops an unused device node, brings runtime pinmuxing for the
Arduino connector via debugfs. Finally, it enables PRU-based Ethernet on
PG2/M.2 device variants (depends on [1]). PG1 devices still need changes
to the TI driver to enable them as well.

Changes in v2:
 - dropped spidev enabling - still looking for flexible and acceptable
   solution
 - added some missing signed-offs

Jan

[1] https://lore.kernel.org/lkml/35a3c4c9-5c1b-4891-9ea2-e3f648a9afe0@ti.com/

Benedikt Niedermayr (1):
  arm64: dts: ti: iot2050: Definitions for runtime pinmuxing

Jan Kiszka (3):
  arm64: dts: ti: iot2050: Re-add aliases
  arm64: dts: ti: iot2050: Drop unused ecap0 PWM
  arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices

Su Bao Cheng (1):
  arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin

 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  10 +-
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   4 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 828 +++++++++++++++++-
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  12 +-
 4 files changed, 794 insertions(+), 60 deletions(-)

-- 
2.35.3

