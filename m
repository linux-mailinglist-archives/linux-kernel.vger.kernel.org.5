Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9797D29A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjJWFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:36:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7AE9;
        Sun, 22 Oct 2023 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039383; x=1729575383;
  h=from:to:cc:subject:date:message-id;
  bh=A+HHnsIqeJDnLwMTstSYgBGn2R5+0SVjEsJpoHcWuWs=;
  b=TGO9k8G1c5+7JQ5W/JSs6rz3xPLUTQLZwJhSVqYyuUjXYT9rubqvwW1D
   TLY0opmXW/D46E3e0LsZcPLyzzv8QnL4CilngWbKoELxQ5wxrsUoKnwwn
   PAoIR1geXFZ1dONm/0Rn6Mr67kP09gLBFLO1z3Um/jDXjn6a/kEuhp2DP
   5OTPglWz/iSk3ULduiaXNdfFMzpkUamJo/csBuJy25seqb0O72FORMIFm
   3kDa9iNlXZOcKcTHg9SkUDnojS79oAfIlVOSmM/Ut1mfGBEjltHQgNYQn
   na+qpFS7tSrPtHlcAzbuFsLrFy6NPaRK354wWwTMsZQQ8npqi4HWV80cs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905358"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556671"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556671"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:35:53 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@Huawei.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/6] Refine _UID references across kernel
Date:   Mon, 23 Oct 2023 11:05:24 +0530
Message-Id: <20231023053530.5525-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use the standard ACPI helpers.

Changes since v1:
- Change acpi_dev_uid_match() to return false in case of NULL argument.
- Drop accepted patches.

Raag Jadav (6):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
 drivers/acpi/x86/utils.c              |  3 +--
 drivers/hwmon/nct6775-platform.c      |  4 +---
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 7 files changed, 40 insertions(+), 17 deletions(-)


base-commit: 64b6555f2fe6b43fb6782aa3e2cbb34bfe39047d
-- 
2.17.1

