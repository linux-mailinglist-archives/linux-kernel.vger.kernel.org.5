Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F67F12CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjKTMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKTMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:09:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254BA7;
        Mon, 20 Nov 2023 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482143; x=1732018143;
  h=from:to:cc:subject:date:message-id;
  bh=TRYNfwwPipXMDJ9kTAnqqTy+1cQytF2OInesEWup8i4=;
  b=dNgj9I6t7kP3YZS+r9bgyLvTqH9dRH7BwPDPdhIhMf4THCDcziEBdQQE
   nnXpesuZ7AuwQMA8XrIUT/AdyTobeF06W09MNvJikmUubs+snYUusHLw6
   mT5RXz0NBplRe/QKP5ZwdLOgBcr+YW/t+2nX/M+kcNbx4Ekz09rCAejX1
   vhDZBf0u8FHSoMv45lAqnEoNn+U7k4BqW8CBPtsDDfM2ArC7gJUnCGzk/
   00G5agSPMQzCKWS9Wj1JawLBCPYE1SnIq3ibCMuYSWCAc9fsF/GP/T5kL
   7FJo9YuWwfIAmZ7MFN0uI3ALzjlb7KpFJsTcYTaENS0EbasLK1kFaQbyT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455638"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455638"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878561"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878561"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:08:46 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/6] Support integer types for _UID matching
Date:   Mon, 20 Nov 2023 17:38:31 +0530
Message-Id: <20231120120837.3002-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Raag Jadav (6):
  compiler.h: Introduce helpers for identifying array and pointer types
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               |  8 +---
 drivers/acpi/utils.c                   | 48 ---------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +---
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 58 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++-----
 include/linux/compiler.h               |  5 +++
 7 files changed, 70 insertions(+), 75 deletions(-)


base-commit: 5bd262f4820f2d5645d8ff1f251ef8e96715ef84
-- 
2.17.1

