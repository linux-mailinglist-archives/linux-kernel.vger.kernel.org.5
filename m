Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2338809BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjLHFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjLHFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:39:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9240C171C;
        Thu,  7 Dec 2023 21:39:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DEC611FB;
        Thu,  7 Dec 2023 21:40:37 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8C813F5A1;
        Thu,  7 Dec 2023 21:39:47 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V3 00/10] coresight: Move remaining AMBA ACPI devices into platform driver
Date:   Fri,  8 Dec 2023 11:09:29 +0530
Message-Id: <20231208053939.42901-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves remaining AMBA ACPI devices into respective platform drivers for
enabling ACPI based power management support. This series applies on latest
coresight/next branch. This series has been built, and boot tested on a DT
based coresight platform. Although this still requires some more testing on
ACPI based coresight platforms.

https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v3)

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-stm32@st-md-mailman.stormreply.com

Changes in V3:

- Split coresight_init_driver/remove_driver() helpers into a separate patch
- Added 'drvdata->pclk' comments in replicator, funnel, tpiu, tmc, and stm devices
- Updated funnel, and replicator drivers to use these new helpers
- Check for drvdata instead of drvdata->pclk in suspend and resume paths in catu,
  tmc and debug devices
- Added patch to extract device name from AMBA pid based table lookup for stm
- Added patch to extract device properties from AMBA pid based table look for tmc
- Dropped pm_runtime_put() from common __probe() functions
- Handled pm_runtime_put() in AMBA driver in success path
- Handled pm_runtime_put() in platform driver in both success and error paths

Changes in V2:

https://lore.kernel.org/all/20231201062053.1268492-1-anshuman.khandual@arm.com/

- Dropped redundant devm_ioremap_resource() hunk from tmc_platform_probe()
- Defined coresight_[init|remove]_driver() for both AMBA/platform drivers
- Changed catu, tmc, tpiu, stm and debug coresight drivers to use the new
  helpers avoiding build issues arising from module_amba_driver(), and
  module_platform_driver() being on the same file

Changes in V1:

https://lore.kernel.org/all/20231027072943.3418997-1-anshuman.khandual@arm.com/

- Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki

Changes in RFC:

https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/

Anshuman Khandual (10):
  coresight: stm: Extract device name from AMBA pid based table lookup
  coresight: tmc: Extract device properties from AMBA pid based table lookup
  coresight: Add helpers registering/removing both AMBA and platform drivers
  coresight: replicator: Move ACPI support from AMBA driver to platform driver
  coresight: funnel: Move ACPI support from AMBA driver to platform driver
  coresight: catu: Move ACPI support from AMBA driver to platform driver
  coresight: tpiu: Move ACPI support from AMBA driver to platform driver
  coresight: tmc: Move ACPI support from AMBA driver to platform driver
  coresight: stm: Move ACPI support from AMBA driver to platform driver
  coresight: debug: Move ACPI support from AMBA driver to platform driver

 drivers/acpi/arm64/amba.c                     |   8 -
 drivers/hwtracing/coresight/coresight-catu.c  | 140 +++++++++++++---
 drivers/hwtracing/coresight/coresight-catu.h  |   1 +
 drivers/hwtracing/coresight/coresight-core.c  |  29 ++++
 .../hwtracing/coresight/coresight-cpu-debug.c | 141 ++++++++++++++--
 .../hwtracing/coresight/coresight-funnel.c    |  87 +++++-----
 drivers/hwtracing/coresight/coresight-priv.h  |  10 ++
 .../coresight/coresight-replicator.c          |  81 ++++-----
 drivers/hwtracing/coresight/coresight-stm.c   | 115 +++++++++++--
 .../hwtracing/coresight/coresight-tmc-core.c  | 156 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  99 +++++++++--
 include/linux/coresight.h                     |   7 +
 13 files changed, 713 insertions(+), 163 deletions(-)

-- 
2.25.1

