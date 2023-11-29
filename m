Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455417FCE70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbjK2Fo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjK2Fo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:44:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B11998;
        Tue, 28 Nov 2023 21:44:31 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT5i6D912551070, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT5i6D912551070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 13:44:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 29 Nov 2023 13:44:06 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 29 Nov 2023 13:44:06 +0800
From:   James Tai <james.tai@realtek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/6] Initial support for the Realtek DHC SoCs
Date:   Wed, 29 Nov 2023 13:43:33 +0800
Message-ID: <20231129054339.3054202-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.190.247]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an interrupt controller driver for the Realtek DHC 
(Digital Home Center) SoCs.

Change log:
v2 -> v3:
- Retested the bindings using the new version of the dtschema
- Fixed the order of property items
- Removed redundant files and replaced them with 'realtek,intc.yaml'
- Replaced 'interrupts-extended' with 'interrupts'
- Added a description for 'interrupts'
- Reduced the example code
- Resolved kernel test robot build warnings

v1 -> v2:
- Tested the bindings using 'make dt_binding_check'
- Fixed code style issues
- Resolved kernel test robot build warnings
- Replaced spin_lock_irqsave with raw_spin_lock
- Replaced magic number with macro
- Removed the realtek_intc_set_affinity function

James Tai (6):
  dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
  irqchip: Add interrupt controller support for Realtek DHC SoCs
  irqchip: Introduce RTD1319 support using the Realtek common interrupt
    controller driver
  irqchip: Introduce RTD1319D support using the Realtek common interrupt
    controller driver
  irqchip: Introduce RTD1325 support using the Realtek common interrupt
    controller driver
  irqchip: Introduce RTD1619B support using the Realtek common interrupt
    controller driver

 .../interrupt-controller/realtek,intc.yaml    |  76 ++++++
 drivers/irqchip/Kconfig                       |  28 +++
 drivers/irqchip/Makefile                      |   5 +
 drivers/irqchip/irq-realtek-intc-common.c     | 208 ++++++++++++++++
 drivers/irqchip/irq-realtek-intc-common.h     |  77 ++++++
 drivers/irqchip/irq-realtek-rtd1319.c         | 218 +++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1319d.c        | 227 ++++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1325.c         | 227 ++++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1619b.c        | 217 +++++++++++++++++
 9 files changed, 1283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.c
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.h
 create mode 100644 drivers/irqchip/irq-realtek-rtd1319.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1319d.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1325.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1619b.c

-- 
2.25.1

