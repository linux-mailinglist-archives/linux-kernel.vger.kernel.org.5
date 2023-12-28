Return-Path: <linux-kernel+bounces-12438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802981F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D460283983
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27F290C;
	Thu, 28 Dec 2023 06:09:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C423A7;
	Thu, 28 Dec 2023 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BS68mXQ21766832, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BS68mXQ21766832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 14:08:49 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 28 Dec 2023 14:08:49 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 14:08:48 +0800
From: James Tai <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, James Tai <james.tai@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/6] Initial support for the Realtek interrupt controller
Date: Thu, 28 Dec 2023 14:08:19 +0800
Message-ID: <20231228060825.1380439-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Introduce an interrupt controller driver for Realtek DHC
(Digital Home Center) SoCs.

Change log:
v3 -> v4:
- Adjusted the allOf block to add constraints on the interrupts per variant
- Adjusted the error path and label
- Added the 'irq_domain_remove' to the error path
- Removed the 'devm_kfree' from the error path
- Replaced the 'irq_of_parse_and_map' with 'of_irq_get'
- Replaced the 'raw_spin_lock' with 'raw_spin_lock_irqsave'
- Adjusted the return value of the 'realtek_intc_subset'
- Replaced the '~1' with macro 'CLEAN_INTC_STATUS'
- Improved code comments and description
- Fixed coding style issues
- Fixed the incorrect control register in mask and unmask functions
- Changed the 'EXPORT_SYMBOL' to the 'EXPORT_SYMBOL_GPL'
- Renamed the 'realtek_intc_subset_cfg' to 'realtek_intc_mask'
- Removed unused and unnecessary code
- Removed 'irq_enable' and 'irq_disable' callback
- Replaced the 'core_initcall' with 'module_init'
- Removed redundant header files
- Moved the function of suspend and resume to common code
- Improved the description of config

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

 .../interrupt-controller/realtek,intc.yaml    | 131 +++++++++++
 drivers/irqchip/Kconfig                       |  44 ++++
 drivers/irqchip/Makefile                      |   5 +
 drivers/irqchip/irq-realtek-intc-common.c     | 211 ++++++++++++++++++
 drivers/irqchip/irq-realtek-intc-common.h     |  76 +++++++
 drivers/irqchip/irq-realtek-rtd1319.c         | 187 ++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1319d.c        | 196 ++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1325.c         | 196 ++++++++++++++++
 drivers/irqchip/irq-realtek-rtd1619b.c        | 186 +++++++++++++++
 9 files changed, 1232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.c
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.h
 create mode 100644 drivers/irqchip/irq-realtek-rtd1319.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1319d.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1325.c
 create mode 100644 drivers/irqchip/irq-realtek-rtd1619b.c

-- 
2.25.1


